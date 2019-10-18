import * as React from 'react';

interface Props {
  id: string;
}

const Form: React.FunctionComponent<Props> = (props: Props) => (
  <form {...props}>
    <input type="text" />
  </form>
);

export default Form;
