Return-Path: <danil.kipnis@profitbricks.com>
MIME-Version: 1.0
References: <20180202140904.2017-1-roman.penyaev@profitbricks.com>
 <1517587623.2675.8.camel@sandisk.com> <1517589637.3936.16.camel@redhat.com>
In-Reply-To: <1517589637.3936.16.camel@redhat.com>
From: Danil Kipnis <danil.kipnis@profitbricks.com>
Date: Mon, 4 Jun 2018 14:14:08 +0200
Message-ID: <CAHg0HuwhyWXHPhr-91vNxLsyFS8Ka9OtxS-yud7jQmK0Bc48-w@mail.gmail.com>
Subject: Re: [PATCH 00/24] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To: dledford@redhat.com
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>, Roman Penyaev <roman.penyaev@profitbricks.com>,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, ogerlitz@mellanox.com,
	Jack Wang <jinpu.wang@profitbricks.com>, axboe@kernel.dk,
	Sagi Grimberg <sagi@grimberg.me>
Content-Type: multipart/alternative; boundary="0000000000008ddbbe056dcfdf32"
List-ID: <linux-block@vger.kernel.org>

--0000000000008ddbbe056dcfdf32
Content-Type: text/plain; charset="UTF-8"

Hi Doug,

thanks for the feedback. You read the cover letter correctly: our transport
library implements multipath (load balancing and failover) on top of RDMA
API. Its name "IBTRS" is slightly misleading in that regard: it can sit on
top of ROCE as well. The library allows for "bundling" multiple rdma
"paths" (source addr - destination addr pair) into one "session". So our
session consists of one or more paths and each path under the hood consists
of as many QPs (each connecting source with destination) as there are CPUs
on the client system. The user load (In our case IBNBD is a block device
and generates some block requests) is load-balanced on per cpu-basis.
I understand, this is something very different to what smc-r is doing. Am I
right? Do you know what stage MP-RDMA development currently is?

Best,

Danil Kipnis.

On Fri, Feb 2, 2018 at 5:40 PM Doug Ledford <dledford@redhat.com> wrote:

> On Fri, 2018-02-02 at 16:07 +0000, Bart Van Assche wrote:
> > On Fri, 2018-02-02 at 15:08 +0100, Roman Pen wrote:
> > > Since the first version the following was changed:
> > >
> > >    - Load-balancing and IO fail-over using multipath features were
> added.
> > >    - Major parts of the code were rewritten, simplified and overall
> code
> > >      size was reduced by a quarter.
> >
> > That is interesting to know, but what happened to the feedback that Sagi
> and
> > I provided on v1? Has that feedback been addressed? See also
> > https://www.spinics.net/lists/linux-rdma/msg47819.html and
> > https://www.spinics.net/lists/linux-rdma/msg47879.html.
> >
> > Regarding multipath support: there are already two multipath
> implementations
> > upstream (dm-mpath and the multipath implementation in the NVMe
> initiator).
> > I'm not sure we want a third multipath implementation in the Linux
> kernel.
>
> There's more than that.  There was also md-multipath, and smc-r includes
> another version of multipath, plus I assume we support mptcp as well.
>
> But, to be fair, the different multipaths in this list serve different
> purposes and I'm not sure they could all be generalized out and served
> by a single multipath code.  Although, fortunately, md-multipath is
> deprecated, so no need to worry about it, and it is only dm-multipath
> and nvme multipath that deal directly with block devices and assume
> block semantics.  If I read the cover letter right (and I haven't dug
> into the code to confirm this), the ibtrs multipath has much more in
> common with smc-r multipath, where it doesn't really assume a block
> layer device sits on top of it, it's more of a pure network multipath,
> which the implementation of smc-r is and mptcp would be too.  I would
> like to see a core RDMA multipath implementation soon that would
> abstract out some of these multipath tasks, at least across RDMA links,
> and that didn't have the current limitations (smc-r only supports RoCE
> links, and it sounds like ibtrs only supports IB like links, but maybe
> I'm wrong there, I haven't looked at the patches yet).
>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--0000000000008ddbbe056dcfdf32
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Doug,<div><br></div><div>thanks for the feedback. You r=
ead the cover letter correctly: our transport library implements multipath =
(load balancing and failover) on top of RDMA API. Its name &quot;IBTRS&quot=
; is slightly misleading in that regard: it can sit on top of ROCE as well.=
 The library allows for &quot;bundling&quot; multiple rdma &quot;paths&quot=
; (source addr - destination addr pair) into one &quot;session&quot;. So ou=
r session consists of one or more paths and each path under the hood consis=
ts of as many QPs (each connecting source with destination) as there are CP=
Us on the client system. The user load (In our case IBNBD is a block device=
 and generates some block requests) is load-balanced on per cpu-basis.</div=
><div>I understand, this is something very different to what smc-r is doing=
. Am I right? Do you know what stage MP-RDMA development currently is?</div=
><div><br></div><div>Best,</div><div><br></div><div>Danil Kipnis.=C2=A0</di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, Feb 2, 2018 at 5:=
40 PM Doug Ledford &lt;<a href=3D"mailto:dledford@redhat.com">dledford@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, 2018-=
02-02 at 16:07 +0000, Bart Van Assche wrote:<br>
&gt; On Fri, 2018-02-02 at 15:08 +0100, Roman Pen wrote:<br>
&gt; &gt; Since the first version the following was changed:<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 - Load-balancing and IO fail-over using multipath fe=
atures were added.<br>
&gt; &gt;=C2=A0 =C2=A0 - Major parts of the code were rewritten, simplified=
 and overall code<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 size was reduced by a quarter.<br>
&gt; <br>
&gt; That is interesting to know, but what happened to the feedback that Sa=
gi and<br>
&gt; I provided on v1? Has that feedback been addressed? See also<br>
&gt; <a href=3D"https://www.spinics.net/lists/linux-rdma/msg47819.html" rel=
=3D"noreferrer" target=3D"_blank">https://www.spinics.net/lists/linux-rdma/=
msg47819.html</a> and<br>
&gt; <a href=3D"https://www.spinics.net/lists/linux-rdma/msg47879.html" rel=
=3D"noreferrer" target=3D"_blank">https://www.spinics.net/lists/linux-rdma/=
msg47879.html</a>.<br>
&gt; <br>
&gt; Regarding multipath support: there are already two multipath implement=
ations<br>
&gt; upstream (dm-mpath and the multipath implementation in the NVMe initia=
tor).<br>
&gt; I&#39;m not sure we want a third multipath implementation in the Linux=
 kernel.<br>
<br>
There&#39;s more than that.=C2=A0 There was also md-multipath, and smc-r in=
cludes<br>
another version of multipath, plus I assume we support mptcp as well.<br>
<br>
But, to be fair, the different multipaths in this list serve different<br>
purposes and I&#39;m not sure they could all be generalized out and served<=
br>
by a single multipath code.=C2=A0 Although, fortunately, md-multipath is<br=
>
deprecated, so no need to worry about it, and it is only dm-multipath<br>
and nvme multipath that deal directly with block devices and assume<br>
block semantics.=C2=A0 If I read the cover letter right (and I haven&#39;t =
dug<br>
into the code to confirm this), the ibtrs multipath has much more in<br>
common with smc-r multipath, where it doesn&#39;t really assume a block<br>
layer device sits on top of it, it&#39;s more of a pure network multipath,<=
br>
which the implementation of smc-r is and mptcp would be too.=C2=A0 I would<=
br>
like to see a core RDMA multipath implementation soon that would<br>
abstract out some of these multipath tasks, at least across RDMA links,<br>
and that didn&#39;t have the current limitations (smc-r only supports RoCE<=
br>
links, and it sounds like ibtrs only supports IB like links, but maybe<br>
I&#39;m wrong there, I haven&#39;t looked at the patches yet).<br>
<br>
-- <br>
Doug Ledford &lt;<a href=3D"mailto:dledford@redhat.com" target=3D"_blank">d=
ledford@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 GPG KeyID: B826A3330E572FDD<br>
=C2=A0 =C2=A0 Key fingerprint =3D AE6B 1BDA 122B 23B4 265B=C2=A0 1274 B826 =
A333 0E57 2FDD</blockquote></div><div dir=3D"ltr" class=3D"gmail_signature"=
 data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">=
<div dir=3D"ltr"><div dir=3D"ltr"><font face=3D"tahoma, sans-serif"><br></f=
ont></div></div></div></div></div></div></div>

--0000000000008ddbbe056dcfdf32--
