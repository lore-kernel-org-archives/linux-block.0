Return-Path: <loberman@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20171103164730.GB7021@ming.t460p>
References: <20171103001541.GF27370@ming.t460p> <1509670091.2636.0.camel@wdc.com>
 <CAFfF4qsbPCj3XLw0HkyJYELcqeqiPx_nR-G-1tSRew9z7ujw2Q@mail.gmail.com>
 <20171103021234.GH27370@ming.t460p> <1509676969.10883.0.camel@wdc.com>
 <20171103035050.GI27370@ming.t460p> <1509722593.2473.12.camel@wdc.com>
 <20171103154700.GA7021@ming.t460p> <1509724220.2473.21.camel@wdc.com>
 <CAFfF4qvBsTUE1jzYfd0b7GnNF3z_ojypfpWHbcwFUtZG422_MQ@mail.gmail.com> <20171103164730.GB7021@ming.t460p>
From: Laurence Oberman <loberman@redhat.com>
Date: Fri, 3 Nov 2017 13:13:42 -0400
Message-ID: <CAFfF4qsmewUZME8M6XJpNg9qe68DGr-Tnos8wekmsgVt70vA7w@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
To: Ming Lei <ming.lei@redhat.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>, Jens Axboe <axboe@kernel.dk>,
	"hch@infradead.org" <hch@infradead.org>,
	"roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "osandov@fb.com" <osandov@fb.com>,
	"hare@suse.com" <hare@suse.com>
Content-Type: multipart/alternative; boundary="94eb2c190f940be2e3055d173ad5"
List-ID: <linux-block@vger.kernel.org>

--94eb2c190f940be2e3055d173ad5
Content-Type: text/plain; charset="UTF-8"

Hi Ming
OK.
However that newer test kernel this morning (not rc4) has issues. Even with
device discovery.

Let me know if you want me to work on it after you are done this weekend.

Thanks
Laurence

On Nov 3, 2017 12:47 PM, "Ming Lei" <ming.lei@redhat.com> wrote:

> On Fri, Nov 03, 2017 at 12:13:09PM -0400, Laurence Oberman wrote:
> > Hi
> > I had it working some time back. I am off today to take my son to the
> > doctor.
> > I will get Bart's test working again this weekend.
>
> Hello Laurence and Bart,
>
> Just found srp-test starts to work now with v4.14-rc4 kernel, and
> the IO hang issue has been reproduced one time. BTW, the connection
> failure happened on for-next of block tree.
>
> Will investigate the issue this weekend.
>
> Thanks,
> Ming
>
> >
> > On Nov 3, 2017 11:51 AM, "Bart Van Assche" <Bart.VanAssche@wdc.com>
> wrote:
> >
> > > On Fri, 2017-11-03 at 23:47 +0800, Ming Lei wrote:
> > > > Forget to mention, there is failure when running 'make' under
> srp-test
> > > > because shellcheck package is missed in RHEL7. Can that be the issue
> > > > of test failure? If yes, could you provide a special version of
> srp-test
> > > > which doesn't depend on shellcheck?
> > >
> > > The srp-test software does not depend on shellcheck. The only purpose
> of
> > > the "shellcheck" target in the srp-test Makefile is to verify the
> syntax
> > > of the shell scripts. The tests run fine even if shellcheck is missing.
> > >
> > > Bart.
>
> --
> Ming
>

--94eb2c190f940be2e3055d173ad5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Ming<div dir=3D"auto">OK.</div><div dir=3D"auto">Howev=
er that newer test kernel this morning (not rc4) has issues. Even with devi=
ce discovery.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Let me kno=
w if you want me to work on it after you are done this weekend.</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">Thanks</div><div dir=3D"auto">Laure=
nce</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On=
 Nov 3, 2017 12:47 PM, &quot;Ming Lei&quot; &lt;<a href=3D"mailto:ming.lei@=
redhat.com">ming.lei@redhat.com</a>&gt; wrote:<br type=3D"attribution"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">On Fri, Nov 03, 2017 at 12:13:09PM -0400, Lauren=
ce Oberman wrote:<br>
&gt; Hi<br>
&gt; I had it working some time back. I am off today to take my son to the<=
br>
&gt; doctor.<br>
&gt; I will get Bart&#39;s test working again this weekend.<br>
<br>
Hello Laurence and Bart,<br>
<br>
Just found srp-test starts to work now with v4.14-rc4 kernel, and<br>
the IO hang issue has been reproduced one time. BTW, the connection<br>
failure happened on for-next of block tree.<br>
<br>
Will investigate the issue this weekend.<br>
<br>
Thanks,<br>
Ming<br>
<br>
&gt;<br>
&gt; On Nov 3, 2017 11:51 AM, &quot;Bart Van Assche&quot; &lt;<a href=3D"ma=
ilto:Bart.VanAssche@wdc.com">Bart.VanAssche@wdc.com</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; On Fri, 2017-11-03 at 23:47 +0800, Ming Lei wrote:<br>
&gt; &gt; &gt; Forget to mention, there is failure when running &#39;make&#=
39; under srp-test<br>
&gt; &gt; &gt; because shellcheck package is missed in RHEL7. Can that be t=
he issue<br>
&gt; &gt; &gt; of test failure? If yes, could you provide a special version=
 of srp-test<br>
&gt; &gt; &gt; which doesn&#39;t depend on shellcheck?<br>
&gt; &gt;<br>
&gt; &gt; The srp-test software does not depend on shellcheck. The only pur=
pose of<br>
&gt; &gt; the &quot;shellcheck&quot; target in the srp-test Makefile is to =
verify the syntax<br>
&gt; &gt; of the shell scripts. The tests run fine even if shellcheck is mi=
ssing.<br>
&gt; &gt;<br>
&gt; &gt; Bart.<br>
<br>
--<br>
Ming<br>
</blockquote></div></div>

--94eb2c190f940be2e3055d173ad5--
