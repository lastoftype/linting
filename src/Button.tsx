import * as React from 'react';

interface Props {
  children: React.ReactNode;
}

export default class Button extends React.Component {
  constructor(props: Props) {
    super(props);
  }

  render() {
    return <Button {...this.props}>{this.props.children}</Button>;
  }
}
