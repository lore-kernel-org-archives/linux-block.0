Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F80BC6FD1D
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 14:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCQOmV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 10:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjCQOmU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 10:42:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B421B2CC4E
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 07:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679064095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sFPZs4mGLjgwsUCVHGZpn35+iOvevjb2WY0Ly5Bioeo=;
        b=DSI4V0IWYEVPq2Aj6+BlEleKGdQnuJbyIxCu82QdUof2qQvTJS26bgjO1lJDFi2RohFXL7
        C0D1qpSypUWrdByy3+QBttD6Ii0vawz7FBPT4/ctXeG0uUs1OM58t9UrHRsr7PtDaxGt+9
        bhc9jNmbLSL8WuqIGRgmArvrcPOnE5Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-Jk1_ObbEM5mlJEpSb2Nqbw-1; Fri, 17 Mar 2023 10:41:32 -0400
X-MC-Unique: Jk1_ObbEM5mlJEpSb2Nqbw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E947800B23;
        Fri, 17 Mar 2023 14:41:31 +0000 (UTC)
Received: from localhost (unknown [10.39.192.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 997D2483EC0;
        Fri, 17 Mar 2023 14:41:30 +0000 (UTC)
Date:   Fri, 17 Mar 2023 10:41:28 -0400
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Andreas Hindborg <nmi@metaspace.dk>, linux-block@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Jim Harris <james.r.harris@intel.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        "hch@lst.de" <hch@lst.de>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [LSF/MM/BPF BoF]: extend UBLK to cover real storage hardware
Message-ID: <20230317144128.GB237262@fedora>
References: <877cwhrgul.fsf@metaspace.dk>
 <Y+7kfZnWsmnA0V84@T590>
 <Y++t3kYTSNo9Sbb5@fedora>
 <Y/C1CVFceZ+X0ECa@T590>
 <Y/EbEGV2Ege51RQZ@fedora>
 <Y/aijeTJ2HuITMc1@T590>
 <Y/fKC7/cTM2mpz3H@fedora>
 <ZAAWj8Bs8JujXsbX@T590>
 <20230302150925.GD2485531@fedora>
 <ZBPaHBHrRPCPN4Ge@ovpn-8-18.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bNDkKOe6NFMRaBG8"
Content-Disposition: inline
In-Reply-To: <ZBPaHBHrRPCPN4Ge@ovpn-8-18.pek2.redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--bNDkKOe6NFMRaBG8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 17, 2023 at 11:10:20AM +0800, Ming Lei wrote:
> On Thu, Mar 02, 2023 at 10:09:25AM -0500, Stefan Hajnoczi wrote:
> > On Thu, Mar 02, 2023 at 11:22:55AM +0800, Ming Lei wrote:
> > > On Thu, Feb 23, 2023 at 03:18:19PM -0500, Stefan Hajnoczi wrote:
> > > > On Thu, Feb 23, 2023 at 07:17:33AM +0800, Ming Lei wrote:
> > > > > On Sat, Feb 18, 2023 at 01:38:08PM -0500, Stefan Hajnoczi wrote:
> > > > > > On Sat, Feb 18, 2023 at 07:22:49PM +0800, Ming Lei wrote:
> > > > > > > On Fri, Feb 17, 2023 at 11:39:58AM -0500, Stefan Hajnoczi wro=
te:
> > > > > > > > On Fri, Feb 17, 2023 at 10:20:45AM +0800, Ming Lei wrote:
> > > > > > > > > On Thu, Feb 16, 2023 at 12:21:32PM +0100, Andreas Hindbor=
g wrote:
> > > > > > > > > >=20
> > > > > > > > > > Ming Lei <ming.lei@redhat.com> writes:
> > > > > > > > > >=20
> > > > > > > > > > > On Thu, Feb 16, 2023 at 10:44:02AM +0100, Andreas Hin=
dborg wrote:
> > > > > > > > > > >>=20
> > > > > > > > > > >> Hi Ming,
> > > > > > > > > > >>=20
> > > > > > > > > > >> Ming Lei <ming.lei@redhat.com> writes:
> > > > > > > > > > >>=20
> > > > > > > > > > >> > On Mon, Feb 13, 2023 at 02:13:59PM -0500, Stefan H=
ajnoczi wrote:
> > > > > > > > > > >> >> On Mon, Feb 13, 2023 at 11:47:31AM +0800, Ming Le=
i wrote:
> > > > > > > > > > >> >> > On Wed, Feb 08, 2023 at 07:17:10AM -0500, Stefa=
n Hajnoczi wrote:
> > > > > > > > > > >> >> > > On Wed, Feb 08, 2023 at 10:12:19AM +0800, Min=
g Lei wrote:
> > > > > > > > > > >> >> > > > On Mon, Feb 06, 2023 at 03:27:09PM -0500, S=
tefan Hajnoczi wrote:
> > > > > > > > > > >> >> > > > > On Mon, Feb 06, 2023 at 11:00:27PM +0800,=
 Ming Lei wrote:
> > > > > > > > > > >> >> > > > > > Hello,
> > > > > > > > > > >> >> > > > > >=20
> > > > > > > > > > >> >> > > > > > So far UBLK is only used for implementi=
ng virtual block device from
> > > > > > > > > > >> >> > > > > > userspace, such as loop, nbd, qcow2, ..=
=2E[1].
> > > > > > > > > > >> >> > > > >=20
> > > > > > > > > > >> >> > > > > I won't be at LSF/MM so here are my thoug=
hts:
> > > > > > > > > > >> >> > > >=20
> > > > > > > > > > >> >> > > > Thanks for the thoughts, :-)
> > > > > > > > > > >> >> > > >=20
> > > > > > > > > > >> >> > > > >=20
> > > > > > > > > > >> >> > > > > >=20
> > > > > > > > > > >> >> > > > > > It could be useful for UBLK to cover re=
al storage hardware too:
> > > > > > > > > > >> >> > > > > >=20
> > > > > > > > > > >> >> > > > > > - for fast prototype or performance eva=
luation
> > > > > > > > > > >> >> > > > > >=20
> > > > > > > > > > >> >> > > > > > - some network storages are attached to=
 host, such as iscsi and nvme-tcp,
> > > > > > > > > > >> >> > > > > > the current UBLK interface doesn't supp=
ort such devices, since it needs
> > > > > > > > > > >> >> > > > > > all LUNs/Namespaces to share host resou=
rces(such as tag)
> > > > > > > > > > >> >> > > > >=20
> > > > > > > > > > >> >> > > > > Can you explain this in more detail? It s=
eems like an iSCSI or
> > > > > > > > > > >> >> > > > > NVMe-over-TCP initiator could be implemen=
ted as a ublk server today.
> > > > > > > > > > >> >> > > > > What am I missing?
> > > > > > > > > > >> >> > > >=20
> > > > > > > > > > >> >> > > > The current ublk can't do that yet, because=
 the interface doesn't
> > > > > > > > > > >> >> > > > support multiple ublk disks sharing single =
host, which is exactly
> > > > > > > > > > >> >> > > > the case of scsi and nvme.
> > > > > > > > > > >> >> > >=20
> > > > > > > > > > >> >> > > Can you give an example that shows exactly wh=
ere a problem is hit?
> > > > > > > > > > >> >> > >=20
> > > > > > > > > > >> >> > > I took a quick look at the ublk source code a=
nd didn't spot a place
> > > > > > > > > > >> >> > > where it prevents a single ublk server proces=
s from handling multiple
> > > > > > > > > > >> >> > > devices.
> > > > > > > > > > >> >> > >=20
> > > > > > > > > > >> >> > > Regarding "host resources(such as tag)", can =
the ublk server deal with
> > > > > > > > > > >> >> > > that in userspace? The Linux block layer does=
n't have the concept of a
> > > > > > > > > > >> >> > > "host", that would come in at the SCSI/NVMe l=
evel that's implemented in
> > > > > > > > > > >> >> > > userspace.
> > > > > > > > > > >> >> > >=20
> > > > > > > > > > >> >> > > I don't understand yet...
> > > > > > > > > > >> >> >=20
> > > > > > > > > > >> >> > blk_mq_tag_set is embedded into driver host str=
ucture, and referred by queue
> > > > > > > > > > >> >> > via q->tag_set, both scsi and nvme allocates ta=
g in host/queue wide,
> > > > > > > > > > >> >> > that said all LUNs/NSs share host/queue tags, c=
urrent every ublk
> > > > > > > > > > >> >> > device is independent, and can't shard tags.
> > > > > > > > > > >> >>=20
> > > > > > > > > > >> >> Does this actually prevent ublk servers with mult=
iple ublk devices or is
> > > > > > > > > > >> >> it just sub-optimal?
> > > > > > > > > > >> >
> > > > > > > > > > >> > It is former, ublk can't support multiple devices =
which share single host
> > > > > > > > > > >> > because duplicated tag can be seen in host side, t=
hen io is failed.
> > > > > > > > > > >> >
> > > > > > > > > > >>=20
> > > > > > > > > > >> I have trouble following this discussion. Why can we=
 not handle multiple
> > > > > > > > > > >> block devices in a single ublk user space process?
> > > > > > > > > > >>=20
> > > > > > > > > > >> From this conversation it seems that the limiting fa=
ctor is allocation
> > > > > > > > > > >> of the tag set of the virtual device in the kernel? =
But as far as I can
> > > > > > > > > > >> tell, the tag sets are allocated per virtual block d=
evice in
> > > > > > > > > > >> `ublk_ctrl_add_dev()`?
> > > > > > > > > > >>=20
> > > > > > > > > > >> It seems to me that a single ublk user space process=
 shuld be able to
> > > > > > > > > > >> connect to multiple storage devices (for instance nv=
me-of) and then
> > > > > > > > > > >> create a ublk device for each namespace, all from a =
single ublk process.
> > > > > > > > > > >>=20
> > > > > > > > > > >> Could you elaborate on why this is not possible?
> > > > > > > > > > >
> > > > > > > > > > > If the multiple storages devices are independent, the=
 current ublk can
> > > > > > > > > > > handle them just fine.
> > > > > > > > > > >
> > > > > > > > > > > But if these storage devices(such as luns in iscsi, o=
r NSs in nvme-tcp)
> > > > > > > > > > > share single host, and use host-wide tagset, the curr=
ent interface can't
> > > > > > > > > > > work as expected, because tags is shared among all th=
ese devices. The
> > > > > > > > > > > current ublk interface needs to be extended for cover=
ing this case.
> > > > > > > > > >=20
> > > > > > > > > > Thanks for clarifying, that is very helpful.
> > > > > > > > > >=20
> > > > > > > > > > Follow up question: What would the implications be if o=
ne tried to
> > > > > > > > > > expose (through ublk) each nvme namespace of an nvme-of=
 controller with
> > > > > > > > > > an independent tag set?
> > > > > > > > >=20
> > > > > > > > > https://lore.kernel.org/linux-block/877cwhrgul.fsf@metasp=
ace.dk/T/#m57158db9f0108e529d8d62d1d56652c52e9e3e67
> > > > > > > > >=20
> > > > > > > > > > What are the benefits of sharing a tagset across
> > > > > > > > > > all namespaces of a controller?
> > > > > > > > >=20
> > > > > > > > > The userspace implementation can be simplified a lot sinc=
e generic
> > > > > > > > > shared tag allocation isn't needed, meantime with good pe=
rformance
> > > > > > > > > (shared tags allocation in SMP is one hard problem)
> > > > > > > >=20
> > > > > > > > In NVMe, tags are per Submission Queue. AFAIK there's no su=
ch thing as
> > > > > > > > shared tags across multiple SQs in NVMe. So userspace doesn=
't need an
> > > > > > >=20
> > > > > > > In reality the max supported nr_queues of nvme is often much =
less than
> > > > > > > nr_cpu_ids, for example, lots of nvme-pci devices just suppor=
t at most
> > > > > > > 32 queues, I remembered that Azure nvme supports less(just 8 =
queues).
> > > > > > > That is because queue isn't free in both software and hardwar=
e, which
> > > > > > > implementation is often tradeoff between performance and cost.
> > > > > >=20
> > > > > > I didn't say that the ublk server should have nr_cpu_ids thread=
s. I
> > > > > > thought the idea was the ublk server creates as many threads as=
 it needs
> > > > > > (e.g. max 8 if the Azure NVMe device only has 8 queues).
> > > > > >=20
> > > > > > Do you expect ublk servers to have nr_cpu_ids threads in all/mo=
st cases?
> > > > >=20
> > > > > No.
> > > > >=20
> > > > > In ublksrv project, each pthread maps to one unique hardware queu=
e, so total
> > > > > number of pthread is equal to nr_hw_queues.
> > > >=20
> > > > Good, I think we agree on that part.
> > > >=20
> > > > Here is a summary of the ublk server model I've been describing:
> > > > 1. Each pthread has a separate io_uring context.
> > > > 2. Each pthread has its own hardware submission queue (NVMe SQ, SCSI
> > > >    command queue, etc).
> > > > 3. Each pthread has a distinct subrange of the tag space if the tag
> > > >    space is shared across hardware submission queues.
> > > > 4. Each pthread allocates tags from its subrange without coordinati=
ng
> > > >    with other threads. This is cheap and simple.
> > >=20
> > > That is also not doable.
> > >=20
> > > The tag space can be pretty small, such as, usb-storage queue depth
> > > is just 1, and usb card reader can support multi lun too.
> >=20
> > If the tag space is very limited, just create one pthread.
>=20
> What I meant is that sub-range isn't doable.
>=20
> And pthread is aligned with queue, that is nothing to do with nr_tags.
>=20
> >=20
> > > That is just one extreme example, but there can be more low queue dep=
th
> > > scsi devices(sata : 32, ...), typical nvme/pci queue depth is 1023, b=
ut
> > > there could be some implementation with less.
> >=20
> > NVMe PCI has per-sq tags so subranges aren't needed. Each pthread has
> > its own independent tag space. That means NVMe devices with low queue
> > depths work fine in the model I described.
>=20
> NVMe PCI isn't special, and it is covered by current ublk abstract, so on=
e way
> or another, we should not support both sub-range or non-sub-range for
> avoiding unnecessary complexity.
>=20
> "Each pthread has its own independent tag space" may mean two things
>=20
> 1) each LUN/NS is implemented in standalone process space:
> - so every queue of each LUN has its own space, but all the queues with
> same ID share the whole queue tag space
> - that matches with current ublksrv
> - also easier to implement
>=20
> 2) all LUNs/NSs are implemented in single process space
> - so each pthread handles one queue for all NSs/LUNs
>=20
> Yeah, if you mean 2), the tag allocation is cheap, but the existed ublk
> char device has to handle multiple LUNs/NSs(disks), which still need
> (big) ublk interface change. Also this way can't scale for single queue
> devices.

The model I described is neither 1) or 2). It's similar to 2) but I'm
not sure why you say the ublk interface needs to be changed. I'm afraid
I haven't explained it well, sorry. I'll try to describe it again with
an NVMe PCI adapter being handled by userspace.

There is a single ublk server process with an NVMe PCI device opened
using VFIO.

There are N pthreads and each pthread has 1 io_uring context and 1 NVMe
PCI SQ/CQ pair. The size of the SQ and CQ rings is QD.

The NVMe PCI device has M Namespaces. The ublk server creates M
ublk_devices. Each ublk_device has N ublk_queues with queue_depth QD.

The Linux block layer sees M block devices with N nr_hw_queues and QD
queue_depth. The actual NVMe PCI device resources are less than what the
Linux block layer sees because the each SQ/CQ pair is used for M
ublk_devices. In other words, Linux thinks there can be M * N * QD
requests in flight but in reality the NVMe PCI adapter only supports N *
QD requests.

Now I'll describe how userspace can take care of the mismatch between
the Linux block layer and the NVMe PCI device without doing much work:

Each pthread sets up QD UBLK_IO_COMMIT_AND_FETCH_REQ io_uring_cmds for
each of the M Namespaces.

When userspace receives a request from ublk, it cannot simply copy the
struct ublksrv_io_cmd->tag field into the NVMe SQE Command Identifier
(CID) field. There would be collisions between the tags used across the
M ublk_queues that the pthread services.

Userspace selects a free tag (e.g. from a bitmap with QD elements) and
uses that as the NVMe Command Identifier. This is trivial because each
pthread has its own bitmap and NVMe Command Identifiers are per-SQ.

If there are no free tags then the request is placed in the pthread's
per Namespace overflow list. Whenever an NVMe command completes, the
overflow lists are scanned. One pending request is submitted to the NVMe
PCI adapter in a round-robin fashion until the lists are empty or there
are no more free tags.

That's it. No ublk API changes are necessary. The userspace code is not
slow or complex (just a bitmap and overflow list).

The approach also works for SCSI or devices that only support 1 request
in flight at a time, with small tweaks.

Going back to the beginning of the discussion: I think it's possible to
write a ublk server that handles multiple LUNs/NS today.

> Another thing is that io command buffer has to be shared among all LUNs/
> NSs. So interface change has to cover shared io command buffer.

I think the main advantage of extending the ublk API to share io command
buffers between ublk_devices is to reduce userspace memory consumption?

It eliminates the need to over-provision I/O buffers for write requests
(or use the slower UBLK_IO_NEED_GET_DATA approach).

> With zero copy support, io buffer sharing needn't to be considered, that
> can be a bit easier.
>=20
> In short, the sharing of (tag, io command buffer, io buffer) needs to be
> considered for shared host ublk disks.
>=20
> Actually I prefer to 1), which matches with current design, and we can
> just add host concept into ublk, and implementation could be easier.
>=20
> BTW, ublk has been applied to implement iscsi alternative disk[1] for Lon=
ghorn[2],
> and the performance improvement is pretty nice, so I think it is one reas=
onable
> requirement to support "shared host" ublk disks for covering multi-lun or=
 multi-ns.
>=20
> [1] https://github.com/ming1/ubdsrv/issues/49
> [2] https://github.com/longhorn/longhorn

Nice performance improvement!

I agree with you that the ublk API should have a way to declare the
resource contraints for multi-LUN/NS servers (i.e. share the tag_set). I
guess the simplest way to do that is by passing a reference to an
existing device to UBLK_CMD_ADD_DEV so it can share the tag_set? Nothing
else about the ublk API needs to change, at least for tags.

Solving I/O buffer over-provisioning sounds similar to io_uring's
provided buffer mechanism :).

Stefan

--bNDkKOe6NFMRaBG8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQUfBcACgkQnKSrs4Gr
c8jmMwgAgrk31eTLKReNz2uaK292k7qOw6sK+2IK9J1UQkt7f7gIH9aiWcGK9Zlw
A5plzPh9iqVimn8e9HEgMJoX3a7d1m8koV6AtzYsCxKkBbeMEXVW6oAT6Nw0g0Fo
X9JJFWHsMIPo7HUjSw7HxySNJMiF3H7wXhq10MdoMEFF1PCn/r/J6I/575/6UMVw
Zm9VUWJnHbsRRLk0AIHXS79sfr+3i6Iq0az9hFYUUlJ9MI48TrXyLr8I35/oyXYv
KbG+d7UPBFuZZZyDJnKubSVBEYMHgvWZa8X4k972sVYYzMR3/jtGJHTyFsFL2hVo
C2Kymz99dnc8e856gBxZWeQB9WvOkQ==
=4etN
-----END PGP SIGNATURE-----

--bNDkKOe6NFMRaBG8--

