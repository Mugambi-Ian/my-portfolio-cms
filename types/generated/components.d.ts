import type { Schema, Attribute } from '@strapi/strapi';

export interface AwardsAwards extends Schema.Component {
  collectionName: 'components_awards_awards';
  info: {
    displayName: 'Awards';
    description: '';
  };
  attributes: {
    title: Attribute.String;
    award: Attribute.String;
    date: Attribute.Date;
    description: Attribute.Text;
  };
}

export interface DutiesDuties extends Schema.Component {
  collectionName: 'components_duties_duties';
  info: {
    displayName: 'Duties';
  };
  attributes: {
    value: Attribute.Text;
  };
}

export interface EducationEducation extends Schema.Component {
  collectionName: 'components_education_educations';
  info: {
    displayName: 'education';
  };
  attributes: {
    school: Attribute.String;
    course: Attribute.String;
    start: Attribute.Date;
    end_date: Attribute.Date;
  };
}

export interface LinksLinks extends Schema.Component {
  collectionName: 'components_links_links';
  info: {
    displayName: 'links';
    description: '';
  };
  attributes: {
    link: Attribute.String;
    type: Attribute.Enumeration<['figma', 'repo', 'web']>;
    name: Attribute.String;
  };
}

export interface ProjectsProjects extends Schema.Component {
  collectionName: 'components_projects_projects';
  info: {
    displayName: 'Projects';
    description: '';
  };
  attributes: {
    title: Attribute.String;
    short_description: Attribute.String;
    project_url: Attribute.String;
    long_description: Attribute.Text;
    links: Attribute.Component<'links.links', true>;
    project_cover: Attribute.String;
  };
}

export interface ReferencesReferences extends Schema.Component {
  collectionName: 'components_references_references';
  info: {
    displayName: 'References';
    description: '';
  };
  attributes: {
    name: Attribute.String;
    email: Attribute.String;
    title: Attribute.String;
  };
}

export interface RolesRoles extends Schema.Component {
  collectionName: 'components_roles_roles';
  info: {
    displayName: 'Roles';
    description: '';
  };
  attributes: {
    department: Attribute.String;
    project_url: Attribute.String;
    tech_stack: Attribute.Relation<
      'roles.roles',
      'oneToMany',
      'api::tech-stack.tech-stack'
    >;
    deparment_roles: Attribute.Relation<
      'roles.roles',
      'oneToMany',
      'api::role-duty.role-duty'
    >;
  };
}

export interface TechStackTechStack extends Schema.Component {
  collectionName: 'components_tech_stack_tech_stacks';
  info: {
    displayName: 'TechStack';
    description: '';
  };
  attributes: {
    value: Attribute.String;
  };
}

export interface WorkExperienceWorkExperience extends Schema.Component {
  collectionName: 'components_work_experience_work_experiences';
  info: {
    displayName: 'WorkExperience';
    description: '';
  };
  attributes: {
    title: Attribute.String;
    company: Attribute.String;
    start_date: Attribute.Date;
    end_date: Attribute.Date;
    roles: Attribute.Component<'roles.roles', true>;
    description: Attribute.Text;
    location: Attribute.String;
  };
}

declare module '@strapi/types' {
  export module Shared {
    export interface Components {
      'awards.awards': AwardsAwards;
      'duties.duties': DutiesDuties;
      'education.education': EducationEducation;
      'links.links': LinksLinks;
      'projects.projects': ProjectsProjects;
      'references.references': ReferencesReferences;
      'roles.roles': RolesRoles;
      'tech-stack.tech-stack': TechStackTechStack;
      'work-experience.work-experience': WorkExperienceWorkExperience;
    }
  }
}
