import * as React from 'react';

interface Props {
  id: React.Component;
}

const Form: React.FunctionComponent<Props> = (props: Props) => (
  <form {...props}>
    <input type="text" />
  </form>
);

export default Form;
