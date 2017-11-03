Return-Path: <loberman@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1509724220.2473.21.camel@wdc.com>
References: <1509666235.2484.23.camel@wdc.com> <20171102234801.GB27370@ming.t460p>
 <1509666897.2484.25.camel@wdc.com> <20171103001541.GF27370@ming.t460p>
 <1509670091.2636.0.camel@wdc.com> <CAFfF4qsbPCj3XLw0HkyJYELcqeqiPx_nR-G-1tSRew9z7ujw2Q@mail.gmail.com>
 <20171103021234.GH27370@ming.t460p> <1509676969.10883.0.camel@wdc.com>
 <20171103035050.GI27370@ming.t460p> <1509722593.2473.12.camel@wdc.com>
 <20171103154700.GA7021@ming.t460p> <1509724220.2473.21.camel@wdc.com>
From: Laurence Oberman <loberman@redhat.com>
Date: Fri, 3 Nov 2017 12:13:09 -0400
Message-ID: <CAFfF4qvBsTUE1jzYfd0b7GnNF3z_ojypfpWHbcwFUtZG422_MQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	"hch@infradead.org" <hch@infradead.org>,
	"roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "osandov@fb.com" <osandov@fb.com>,
	"hare@suse.com" <hare@suse.com>
Content-Type: multipart/alternative; boundary="94eb2c043bb27c6008055d1661a0"
List-ID: <linux-block@vger.kernel.org>

--94eb2c043bb27c6008055d1661a0
Content-Type: text/plain; charset="UTF-8"

Hi
I had it working some time back. I am off today to take my son to the
doctor.
I will get Bart's test working again this weekend.
Thanks
Laurence

On Nov 3, 2017 11:51 AM, "Bart Van Assche" <Bart.VanAssche@wdc.com> wrote:

> On Fri, 2017-11-03 at 23:47 +0800, Ming Lei wrote:
> > Forget to mention, there is failure when running 'make' under srp-test
> > because shellcheck package is missed in RHEL7. Can that be the issue
> > of test failure? If yes, could you provide a special version of srp-test
> > which doesn't depend on shellcheck?
>
> The srp-test software does not depend on shellcheck. The only purpose of
> the "shellcheck" target in the srp-test Makefile is to verify the syntax
> of the shell scripts. The tests run fine even if shellcheck is missing.
>
> Bart.

--94eb2c043bb27c6008055d1661a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi<div dir=3D"auto">I had it working some time back. I am=
 off today to take my son to the doctor.</div><div dir=3D"auto">I will get =
Bart&#39;s test working again this weekend.</div><div dir=3D"auto">Thanks</=
div><div dir=3D"auto">Laurence</div></div><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">On Nov 3, 2017 11:51 AM, &quot;Bart Van Assche&quo=
t; &lt;<a href=3D"mailto:Bart.VanAssche@wdc.com">Bart.VanAssche@wdc.com</a>=
&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, =
2017-11-03 at 23:47 +0800, Ming Lei wrote:<br>
&gt; Forget to mention, there is failure when running &#39;make&#39; under =
srp-test<br>
&gt; because shellcheck package is missed in RHEL7. Can that be the issue<b=
r>
&gt; of test failure? If yes, could you provide a special version of srp-te=
st<br>
&gt; which doesn&#39;t depend on shellcheck?<br>
<br>
The srp-test software does not depend on shellcheck. The only purpose of<br=
>
the &quot;shellcheck&quot; target in the srp-test Makefile is to verify the=
 syntax<br>
of the shell scripts. The tests run fine even if shellcheck is missing.<br>
<br>
Bart.</blockquote></div></div>

--94eb2c043bb27c6008055d1661a0--
