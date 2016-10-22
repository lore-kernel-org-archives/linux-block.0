Return-Path: <kashyap.desai@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <20161021213121.GA10030@vader.DHCP.thefacebook.com>
References: <97184c74229af78b0d97e6b8016af972@mail.gmail.com> <20161021213121.GA10030@vader.DHCP.thefacebook.com>
From: Kashyap Desai <kashyap.desai@broadcom.com>
Date: Sat, 22 Oct 2016 20:34:38 +0530
Message-ID: <CAHsXFKFK1n9YgPz+XCA2sFhXFb3QrEqPOWgs-tULYVmHLuG_Pw@mail.gmail.com>
Subject: Re: Device or HBA level QD throttling creates randomness in sequetial workload
To: Omar Sandoval <osandov@osandov.com>
Cc: paolo.valente@linaro.org, Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a1144869c61932f053f757af3
List-ID: <linux-block@vger.kernel.org>

--001a1144869c61932f053f757af3
Content-Type: text/plain; charset=UTF-8

On 22-Oct-2016 3:01 AM, "Omar Sandoval" <osandov@osandov.com> wrote:
>
> On Fri, Oct 21, 2016 at 05:43:35PM +0530, Kashyap Desai wrote:
> > Hi -
> >
> > I found below conversation and it is on the same line as I wanted some
> > input from mailing list.
> >
> > http://marc.info/?l=linux-kernel&m=147569860526197&w=2
> >
> > I can do testing on any WIP item as Omar mentioned in above discussion.
> > https://github.com/osandov/linux/tree/blk-mq-iosched
>
> Are you using blk-mq for this disk? If not, then the work there won't
> affect you.
Yes I am using blk-mq.
>
> > Is there any workaround/alternative in latest upstream kernel, if user
> > wants to see limited penalty  for Sequential Work load on HDD ?
> >
> > ` Kashyap
> >
> > > -----Original Message-----
> > > From: Kashyap Desai [mailto:kashyap.desai@broadcom.com]
> > > Sent: Thursday, October 20, 2016 3:39 PM
> > > To: linux-scsi@vger.kernel.org
> > > Subject: Device or HBA level QD throttling creates randomness in
> > sequetial
> > > workload
> > >
> > > [ Apologize, if you find more than one instance of my email.
> > > Web based email client has some issue, so now trying git send mail.]
> > >
> > > Hi,
> > >
> > > I am doing some performance tuning in MR driver to understand how sdev
> > > queue depth and hba queue depth play role in IO submission from above
> > layer.
> > > I have 24 JBOD connected to MR 12GB controller and I can see
performance
> > for
> > > 4K Sequential work load as below.
> > >
> > > HBA QD for MR controller is 4065 and Per device QD is set to 32
> > >
> > > queue depth from <fio> 256 reports 300K IOPS queue depth from <fio>
128
> > > reports 330K IOPS queue depth from <fio> 64 reports 360K IOPS queue
> > depth
> > > from <fio> 32 reports 510K IOPS
> > >
> > > In MR driver I added debug print and confirm that more IO come to
driver
> > as
> > > random IO whenever I have <fio> queue depth more than 32.
> > >
> > > I have debug using scsi logging level and blktrace as well. Below is
> > snippet of
> > > logs using scsi logging level.  In summary, if SML do flow control of
IO
> > due to
> > > Device QD or HBA QD, IO coming to LLD is more random pattern.
> > >
> > > I see IO coming to driver is not sequential.
> > >
> > > [79546.912041] sd 18:2:21:0: [sdy] tag#854 CDB: Write(10) 2a 00 00 03
c0
> > 3b 00
> > > 00 01 00 [79546.912049] sd 18:2:21:0: [sdy] tag#855 CDB: Write(10) 2a
00
> > 00 03
> > > c0 3c 00 00 01 00 [79546.912053] sd 18:2:21:0: [sdy] tag#886 CDB:
> > Write(10) 2a
> > > 00 00 03 c0 5b 00 00 01 00
> > >
> > > <KD> After LBA "00 03 c0 3c" next command is with LBA "00 03 c0 5b".
> > > Two Sequence are overlapped due to sdev QD throttling.
> > >
> > > [79546.912056] sd 18:2:21:0: [sdy] tag#887 CDB: Write(10) 2a 00 00 03
c0
> > 5c 00
> > > 00 01 00 [79546.912250] sd 18:2:21:0: [sdy] tag#856 CDB: Write(10) 2a
00
> > 00 03
> > > c0 3d 00 00 01 00 [79546.912257] sd 18:2:21:0: [sdy] tag#888 CDB:
> > Write(10) 2a
> > > 00 00 03 c0 5d 00 00 01 00 [79546.912259] sd 18:2:21:0: [sdy] tag#857
> > CDB:
> > > Write(10) 2a 00 00 03 c0 3e 00 00 01 00 [79546.912268] sd 18:2:21:0:
> > [sdy]
> > > tag#858 CDB: Write(10) 2a 00 00 03 c0 3f 00 00 01 00
> > >
> > >  If scsi_request_fn() breaks due to unavailability of device queue
(due
> > to below
> > > check), will there be any side defect as I observe ?
> > >                 if (!scsi_dev_queue_ready(q, sdev))
> > >                              break;
> > >
> > > If I reduce HBA QD and make sure IO from above layer is throttled due
to
> > HBA
> > > QD, there is a same impact.
> > > MR driver use host wide shared tag map.
> > >
> > > Can someone help me if this can be tunable in LLD providing additional
> > settings
> > > or it is expected behavior ? Problem I am facing is, I am not able to
> > figure out
> > > optimal device queue depth for different configuration and work load.
> > >
> > > Thanks, Kashyap
>
> --
> Omar

--001a1144869c61932f053f757af3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On 22-Oct-2016 3:01 AM, &quot;Omar Sandoval&quot; &lt;<a hre=
f=3D"mailto:osandov@osandov.com">osandov@osandov.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Fri, Oct 21, 2016 at 05:43:35PM +0530, Kashyap Desai wrote:<br>
&gt; &gt; Hi -<br>
&gt; &gt;<br>
&gt; &gt; I found below conversation and it is on the same line as I wanted=
 some<br>
&gt; &gt; input from mailing list.<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"http://marc.info/?l=3Dlinux-kernel&amp;m=3D14756986052=
6197&amp;w=3D2">http://marc.info/?l=3Dlinux-kernel&amp;m=3D147569860526197&=
amp;w=3D2</a><br>
&gt; &gt;<br>
&gt; &gt; I can do testing on any WIP item as Omar mentioned in above discu=
ssion.<br>
&gt; &gt; <a href=3D"https://github.com/osandov/linux/tree/blk-mq-iosched">=
https://github.com/osandov/linux/tree/blk-mq-iosched</a><br>
&gt;<br>
&gt; Are you using blk-mq for this disk? If not, then the work there won&#3=
9;t<br>
&gt; affect you.<br>
Yes I am using blk-mq.<br>
&gt;<br>
&gt; &gt; Is there any workaround/alternative in latest upstream kernel, if=
 user<br>
&gt; &gt; wants to see limited penalty=C2=A0 for Sequential Work load on HD=
D ?<br>
&gt; &gt;<br>
&gt; &gt; ` Kashyap<br>
&gt; &gt;<br>
&gt; &gt; &gt; -----Original Message-----<br>
&gt; &gt; &gt; From: Kashyap Desai [mailto:<a href=3D"mailto:kashyap.desai@=
broadcom.com">kashyap.desai@broadcom.com</a>]<br>
&gt; &gt; &gt; Sent: Thursday, October 20, 2016 3:39 PM<br>
&gt; &gt; &gt; To: <a href=3D"mailto:linux-scsi@vger.kernel.org">linux-scsi=
@vger.kernel.org</a><br>
&gt; &gt; &gt; Subject: Device or HBA level QD throttling creates randomnes=
s in<br>
&gt; &gt; sequetial<br>
&gt; &gt; &gt; workload<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [ Apologize, if you find more than one instance of my email.=
<br>
&gt; &gt; &gt; Web based email client has some issue, so now trying git sen=
d mail.]<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I am doing some performance tuning in MR driver to understan=
d how sdev<br>
&gt; &gt; &gt; queue depth and hba queue depth play role in IO submission f=
rom above<br>
&gt; &gt; layer.<br>
&gt; &gt; &gt; I have 24 JBOD connected to MR 12GB controller and I can see=
 performance<br>
&gt; &gt; for<br>
&gt; &gt; &gt; 4K Sequential work load as below.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; HBA QD for MR controller is 4065 and Per device QD is set to=
 32<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; queue depth from &lt;fio&gt; 256 reports 300K IOPS queue dep=
th from &lt;fio&gt; 128<br>
&gt; &gt; &gt; reports 330K IOPS queue depth from &lt;fio&gt; 64 reports 36=
0K IOPS queue<br>
&gt; &gt; depth<br>
&gt; &gt; &gt; from &lt;fio&gt; 32 reports 510K IOPS<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; In MR driver I added debug print and confirm that more IO co=
me to driver<br>
&gt; &gt; as<br>
&gt; &gt; &gt; random IO whenever I have &lt;fio&gt; queue depth more than =
32.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I have debug using scsi logging level and blktrace as well. =
Below is<br>
&gt; &gt; snippet of<br>
&gt; &gt; &gt; logs using scsi logging level.=C2=A0 In summary, if SML do f=
low control of IO<br>
&gt; &gt; due to<br>
&gt; &gt; &gt; Device QD or HBA QD, IO coming to LLD is more random pattern=
.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I see IO coming to driver is not sequential.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [79546.912041] sd 18:2:21:0: [sdy] tag#854 CDB: Write(10) 2a=
 00 00 03 c0<br>
&gt; &gt; 3b 00<br>
&gt; &gt; &gt; 00 01 00 [79546.912049] sd 18:2:21:0: [sdy] tag#855 CDB: Wri=
te(10) 2a 00<br>
&gt; &gt; 00 03<br>
&gt; &gt; &gt; c0 3c 00 00 01 00 [79546.912053] sd 18:2:21:0: [sdy] tag#886=
 CDB:<br>
&gt; &gt; Write(10) 2a<br>
&gt; &gt; &gt; 00 00 03 c0 5b 00 00 01 00<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &lt;KD&gt; After LBA &quot;00 03 c0 3c&quot; next command is=
 with LBA &quot;00 03 c0 5b&quot;.<br>
&gt; &gt; &gt; Two Sequence are overlapped due to sdev QD throttling.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [79546.912056] sd 18:2:21:0: [sdy] tag#887 CDB: Write(10) 2a=
 00 00 03 c0<br>
&gt; &gt; 5c 00<br>
&gt; &gt; &gt; 00 01 00 [79546.912250] sd 18:2:21:0: [sdy] tag#856 CDB: Wri=
te(10) 2a 00<br>
&gt; &gt; 00 03<br>
&gt; &gt; &gt; c0 3d 00 00 01 00 [79546.912257] sd 18:2:21:0: [sdy] tag#888=
 CDB:<br>
&gt; &gt; Write(10) 2a<br>
&gt; &gt; &gt; 00 00 03 c0 5d 00 00 01 00 [79546.912259] sd 18:2:21:0: [sdy=
] tag#857<br>
&gt; &gt; CDB:<br>
&gt; &gt; &gt; Write(10) 2a 00 00 03 c0 3e 00 00 01 00 [79546.912268] sd 18=
:2:21:0:<br>
&gt; &gt; [sdy]<br>
&gt; &gt; &gt; tag#858 CDB: Write(10) 2a 00 00 03 c0 3f 00 00 01 00<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 If scsi_request_fn() breaks due to unavailability of d=
evice queue (due<br>
&gt; &gt; to below<br>
&gt; &gt; &gt; check), will there be any side defect as I observe ?<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (!scsi_dev_queue_ready(q, sdev))<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; If I reduce HBA QD and make sure IO from above layer is thro=
ttled due to<br>
&gt; &gt; HBA<br>
&gt; &gt; &gt; QD, there is a same impact.<br>
&gt; &gt; &gt; MR driver use host wide shared tag map.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Can someone help me if this can be tunable in LLD providing =
additional<br>
&gt; &gt; settings<br>
&gt; &gt; &gt; or it is expected behavior ? Problem I am facing is, I am no=
t able to<br>
&gt; &gt; figure out<br>
&gt; &gt; &gt; optimal device queue depth for different configuration and w=
ork load.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thanks, Kashyap<br>
&gt;<br>
&gt; --<br>
&gt; Omar<br></p>

--001a1144869c61932f053f757af3--
