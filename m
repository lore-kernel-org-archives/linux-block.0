Return-Path: <loberman@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1509670091.2636.0.camel@wdc.com>
References: <7921fc66-16de-200b-cc0f-02cf52ef9002@kernel.dk>
 <20171101014611.GA8200@ming.t460p> <59F9FE28-F31A-47FD-A3FD-90CE1DB38FB2@kernel.dk>
 <20171101020312.GA9527@ming.t460p> <e6c4aa07-6427-bbee-ba14-fcba5e4f29ac@kernel.dk>
 <1509638224.2484.14.camel@wdc.com> <20171102233835.GA27370@ming.t460p>
 <1509666235.2484.23.camel@wdc.com> <20171102234801.GB27370@ming.t460p>
 <1509666897.2484.25.camel@wdc.com> <20171103001541.GF27370@ming.t460p> <1509670091.2636.0.camel@wdc.com>
From: Laurence Oberman <loberman@redhat.com>
Date: Thu, 2 Nov 2017 21:16:04 -0400
Message-ID: <CAFfF4qsbPCj3XLw0HkyJYELcqeqiPx_nR-G-1tSRew9z7ujw2Q@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>, "Hellwig, Christoph" <hch@infradead.org>,
	roman.penyaev@profitbricks.com, linux-block@vger.kernel.org, osandov@fb.com,
	"Reinecke, Hannes" <hare@suse.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: multipart/alternative; boundary="001a11475f384a715e055d09d9e6"
List-ID: <linux-block@vger.kernel.org>

--001a11475f384a715e055d09d9e6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ming
I have used Bart's tests on my test bed they should run fine.
Are you using my SRP setup.

Thanks
Laurence


On Nov 2, 2017 8:48 PM, "Bart Van Assche" <Bart.VanAssche@wdc.com> wrote:

> On Fri, 2017-11-03 at 08:15 +0800, Ming Lei wrote:
> > On Thu, Nov 02, 2017 at 11:54:57PM +0000, Bart Van Assche wrote:
> > > On Fri, 2017-11-03 at 07:48 +0800, Ming Lei wrote:
> > > > Could you please share your srp-tests script? I may find a IB/SRP
> system
> > > > to see if I can reproduce this issue and figure out one solution.
> > >
> > > Please have a look at https://github.com/bvanassche/srp-test.
> >
> > Could you provide me the exact command line for the reproduction?
> >
> > I simply run ./run_tests, and looks it doesn't work.
> >
> > [root@ srp-test]# ./run_tests
> > df: =E2=80=98/home/ming/git/srp-test/mnt2=E2=80=99: No such file or dir=
ectory
> > df: =E2=80=98/home/ming/git/srp-test/mnt2=E2=80=99: No such file or dir=
ectory
> > Unmounting /home/ming/git/srp-test/mnt2 from
> > umount: /home/ming/git/srp-test/mnt2: mountpoint not found
> > df: =E2=80=98/home/ming/git/srp-test/mnt2=E2=80=99: No such file or dir=
ectory
> > Error: unmounting /home/ming/git/srp-test/mnt2 failed
>
> This means that I have to add the following to the README document:
>
> Run "mkdir mnt1 mnt2 mnt3" before starting the tests.
>
> Bart.

--001a11475f384a715e055d09d9e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Ming=C2=A0<div dir=3D"auto">I have used Bart&#39;s tes=
ts on my test bed they should run fine.</div><div dir=3D"auto">Are you usin=
g my SRP setup.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks</=
div><div dir=3D"auto">Laurence</div><div dir=3D"auto"><br></div></div><div =
class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Nov 2, 2017 8:48 PM=
, &quot;Bart Van Assche&quot; &lt;<a href=3D"mailto:Bart.VanAssche@wdc.com"=
>Bart.VanAssche@wdc.com</a>&gt; wrote:<br type=3D"attribution"><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">On Fri, 2017-11-03 at 08:15 +0800, Ming Lei wrote:<br>
&gt; On Thu, Nov 02, 2017 at 11:54:57PM +0000, Bart Van Assche wrote:<br>
&gt; &gt; On Fri, 2017-11-03 at 07:48 +0800, Ming Lei wrote:<br>
&gt; &gt; &gt; Could you please share your srp-tests script? I may find a I=
B/SRP system<br>
&gt; &gt; &gt; to see if I can reproduce this issue and figure out one solu=
tion.<br>
&gt; &gt;<br>
&gt; &gt; Please have a look at <a href=3D"https://github.com/bvanassche/sr=
p-test" rel=3D"noreferrer" target=3D"_blank">https://github.com/bvanassche/=
<wbr>srp-test</a>.<br>
&gt;<br>
&gt; Could you provide me the exact command line for the reproduction?<br>
&gt;<br>
&gt; I simply run ./run_tests, and looks it doesn&#39;t work.<br>
&gt;<br>
&gt; [root@ srp-test]# ./run_tests<br>
&gt; df: =E2=80=98/home/ming/git/srp-test/mnt2=E2=80=99<wbr>: No such file =
or directory<br>
&gt; df: =E2=80=98/home/ming/git/srp-test/mnt2=E2=80=99<wbr>: No such file =
or directory<br>
&gt; Unmounting /home/ming/git/srp-test/mnt2 from<br>
&gt; umount: /home/ming/git/srp-test/mnt2: mountpoint not found<br>
&gt; df: =E2=80=98/home/ming/git/srp-test/mnt2=E2=80=99<wbr>: No such file =
or directory<br>
&gt; Error: unmounting /home/ming/git/srp-test/mnt2 failed<br>
<br>
This means that I have to add the following to the README document:<br>
<br>
Run &quot;mkdir mnt1 mnt2 mnt3&quot; before starting the tests.<br>
<br>
Bart.</blockquote></div></div>

--001a11475f384a715e055d09d9e6--
