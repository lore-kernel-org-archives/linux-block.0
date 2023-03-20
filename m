Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E02FC7618A
	for <linux-block@archiver.kernel.org>; Mon, 20 Mar 2023 14:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjCTOwe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 10:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjCTOwJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 10:52:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00569DC
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 07:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679323751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pQNjwDdlPE9xK2FO+XtrSWKsztu6ijXT2bC2y91wqdU=;
        b=KifZ97E+qQ2U66UYYkV19TJWipbiwVjFOWpmx0vKWLwfbMGqrtFGo6BzznHvHsQtZoIVUd
        nqqCSjJejP/DeA7p/4yosfcsnD9TUUC/FpBBF3mnhghnMCzHjTv05lg5iAEKwNXY//SWm0
        0dqlPf4y3pLuLW3RQuilMsKldhpDHZI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-c-baOGKwN2uyU87Ga_kjXQ-1; Mon, 20 Mar 2023 10:49:06 -0400
X-MC-Unique: c-baOGKwN2uyU87Ga_kjXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95ADC96DC8C;
        Mon, 20 Mar 2023 14:49:04 +0000 (UTC)
Received: from localhost (unknown [10.39.194.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60BBA2166B29;
        Mon, 20 Mar 2023 14:49:03 +0000 (UTC)
Date:   Mon, 20 Mar 2023 08:34:17 -0400
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
Message-ID: <20230320123417.GC1011461@fedora>
References: <Y++t3kYTSNo9Sbb5@fedora>
 <Y/C1CVFceZ+X0ECa@T590>
 <Y/EbEGV2Ege51RQZ@fedora>
 <Y/aijeTJ2HuITMc1@T590>
 <Y/fKC7/cTM2mpz3H@fedora>
 <ZAAWj8Bs8JujXsbX@T590>
 <20230302150925.GD2485531@fedora>
 <ZBPaHBHrRPCPN4Ge@ovpn-8-18.pek2.redhat.com>
 <20230317144128.GB237262@fedora>
 <ZBUGJf67Yx9xMhmk@ovpn-8-18.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WV38a+vTkiNaDltd"
Content-Disposition: inline
In-Reply-To: <ZBUGJf67Yx9xMhmk@ovpn-8-18.pek2.redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--WV38a+vTkiNaDltd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 18, 2023 at 08:30:29AM +0800, Ming Lei wrote:
> On Fri, Mar 17, 2023 at 10:41:28AM -0400, Stefan Hajnoczi wrote:
> > On Fri, Mar 17, 2023 at 11:10:20AM +0800, Ming Lei wrote:
> > > On Thu, Mar 02, 2023 at 10:09:25AM -0500, Stefan Hajnoczi wrote:
> > > > On Thu, Mar 02, 2023 at 11:22:55AM +0800, Ming Lei wrote:
> > > > > On Thu, Feb 23, 2023 at 03:18:19PM -0500, Stefan Hajnoczi wrote:
> > > > > > On Thu, Feb 23, 2023 at 07:17:33AM +0800, Ming Lei wrote:
> > > > > > > On Sat, Feb 18, 2023 at 01:38:08PM -0500, Stefan Hajnoczi wro=
te:
> > > > > > > > On Sat, Feb 18, 2023 at 07:22:49PM +0800, Ming Lei wrote:
> > > > > > > > > On Fri, Feb 17, 2023 at 11:39:58AM -0500, Stefan Hajnoczi=
 wrote:
> > > > > > > > > > On Fri, Feb 17, 2023 at 10:20:45AM +0800, Ming Lei wrot=
e:
> > > > > > > > > > > On Thu, Feb 16, 2023 at 12:21:32PM +0100, Andreas Hin=
dborg wrote:
> > > > > > > > > > > >=20
> > > > > > > > > > > > Ming Lei <ming.lei@redhat.com> writes:
> > > > > > > > > > > >=20
> > > > > > > > > > > > > On Thu, Feb 16, 2023 at 10:44:02AM +0100, Andreas=
 Hindborg wrote:
> > > > > > > > > > > > >>=20
> > > > > > > > > > > > >> Hi Ming,
> > > > > > > > > > > > >>=20
> > > > > > > > > > > > >> Ming Lei <ming.lei@redhat.com> writes:
> > > > > > > > > > > > >>=20
> > > > > > > > > > > > >> > On Mon, Feb 13, 2023 at 02:13:59PM -0500, Stef=
an Hajnoczi wrote:
> > > > > > > > > > > > >> >> On Mon, Feb 13, 2023 at 11:47:31AM +0800, Min=
g Lei wrote:
> > > > > > > > > > > > >> >> > On Wed, Feb 08, 2023 at 07:17:10AM -0500, S=
tefan Hajnoczi wrote:
> > > > > > > > > > > > >> >> > > On Wed, Feb 08, 2023 at 10:12:19AM +0800,=
 Ming Lei wrote:
> > > > > > > > > > > > >> >> > > > On Mon, Feb 06, 2023 at 03:27:09PM -050=
0, Stefan Hajnoczi wrote:
> > > > > > > > > > > > >> >> > > > > On Mon, Feb 06, 2023 at 11:00:27PM +0=
800, Ming Lei wrote:
> > > > > > > > > > > > >> >> > > > > > Hello,
> > > > > > > > > > > > >> >> > > > > >=20
> > > > > > > > > > > > >> >> > > > > > So far UBLK is only used for implem=
enting virtual block device from
> > > > > > > > > > > > >> >> > > > > > userspace, such as loop, nbd, qcow2=
, ...[1].
> > > > > > > > > > > > >> >> > > > >=20
> > > > > > > > > > > > >> >> > > > > I won't be at LSF/MM so here are my t=
houghts:
> > > > > > > > > > > > >> >> > > >=20
> > > > > > > > > > > > >> >> > > > Thanks for the thoughts, :-)
> > > > > > > > > > > > >> >> > > >=20
> > > > > > > > > > > > >> >> > > > >=20
> > > > > > > > > > > > >> >> > > > > >=20
> > > > > > > > > > > > >> >> > > > > > It could be useful for UBLK to cove=
r real storage hardware too:
> > > > > > > > > > > > >> >> > > > > >=20
> > > > > > > > > > > > >> >> > > > > > - for fast prototype or performance=
 evaluation
> > > > > > > > > > > > >> >> > > > > >=20
> > > > > > > > > > > > >> >> > > > > > - some network storages are attache=
d to host, such as iscsi and nvme-tcp,
> > > > > > > > > > > > >> >> > > > > > the current UBLK interface doesn't =
support such devices, since it needs
> > > > > > > > > > > > >> >> > > > > > all LUNs/Namespaces to share host r=
esources(such as tag)
> > > > > > > > > > > > >> >> > > > >=20
> > > > > > > > > > > > >> >> > > > > Can you explain this in more detail? =
It seems like an iSCSI or
> > > > > > > > > > > > >> >> > > > > NVMe-over-TCP initiator could be impl=
emented as a ublk server today.
> > > > > > > > > > > > >> >> > > > > What am I missing?
> > > > > > > > > > > > >> >> > > >=20
> > > > > > > > > > > > >> >> > > > The current ublk can't do that yet, bec=
ause the interface doesn't
> > > > > > > > > > > > >> >> > > > support multiple ublk disks sharing sin=
gle host, which is exactly
> > > > > > > > > > > > >> >> > > > the case of scsi and nvme.
> > > > > > > > > > > > >> >> > >=20
> > > > > > > > > > > > >> >> > > Can you give an example that shows exactl=
y where a problem is hit?
> > > > > > > > > > > > >> >> > >=20
> > > > > > > > > > > > >> >> > > I took a quick look at the ublk source co=
de and didn't spot a place
> > > > > > > > > > > > >> >> > > where it prevents a single ublk server pr=
ocess from handling multiple
> > > > > > > > > > > > >> >> > > devices.
> > > > > > > > > > > > >> >> > >=20
> > > > > > > > > > > > >> >> > > Regarding "host resources(such as tag)", =
can the ublk server deal with
> > > > > > > > > > > > >> >> > > that in userspace? The Linux block layer =
doesn't have the concept of a
> > > > > > > > > > > > >> >> > > "host", that would come in at the SCSI/NV=
Me level that's implemented in
> > > > > > > > > > > > >> >> > > userspace.
> > > > > > > > > > > > >> >> > >=20
> > > > > > > > > > > > >> >> > > I don't understand yet...
> > > > > > > > > > > > >> >> >=20
> > > > > > > > > > > > >> >> > blk_mq_tag_set is embedded into driver host=
 structure, and referred by queue
> > > > > > > > > > > > >> >> > via q->tag_set, both scsi and nvme allocate=
s tag in host/queue wide,
> > > > > > > > > > > > >> >> > that said all LUNs/NSs share host/queue tag=
s, current every ublk
> > > > > > > > > > > > >> >> > device is independent, and can't shard tags.
> > > > > > > > > > > > >> >>=20
> > > > > > > > > > > > >> >> Does this actually prevent ublk servers with =
multiple ublk devices or is
> > > > > > > > > > > > >> >> it just sub-optimal?
> > > > > > > > > > > > >> >
> > > > > > > > > > > > >> > It is former, ublk can't support multiple devi=
ces which share single host
> > > > > > > > > > > > >> > because duplicated tag can be seen in host sid=
e, then io is failed.
> > > > > > > > > > > > >> >
> > > > > > > > > > > > >>=20
> > > > > > > > > > > > >> I have trouble following this discussion. Why ca=
n we not handle multiple
> > > > > > > > > > > > >> block devices in a single ublk user space proces=
s?
> > > > > > > > > > > > >>=20
> > > > > > > > > > > > >> From this conversation it seems that the limitin=
g factor is allocation
> > > > > > > > > > > > >> of the tag set of the virtual device in the kern=
el? But as far as I can
> > > > > > > > > > > > >> tell, the tag sets are allocated per virtual blo=
ck device in
> > > > > > > > > > > > >> `ublk_ctrl_add_dev()`?
> > > > > > > > > > > > >>=20
> > > > > > > > > > > > >> It seems to me that a single ublk user space pro=
cess shuld be able to
> > > > > > > > > > > > >> connect to multiple storage devices (for instanc=
e nvme-of) and then
> > > > > > > > > > > > >> create a ublk device for each namespace, all fro=
m a single ublk process.
> > > > > > > > > > > > >>=20
> > > > > > > > > > > > >> Could you elaborate on why this is not possible?
> > > > > > > > > > > > >
> > > > > > > > > > > > > If the multiple storages devices are independent,=
 the current ublk can
> > > > > > > > > > > > > handle them just fine.
> > > > > > > > > > > > >
> > > > > > > > > > > > > But if these storage devices(such as luns in iscs=
i, or NSs in nvme-tcp)
> > > > > > > > > > > > > share single host, and use host-wide tagset, the =
current interface can't
> > > > > > > > > > > > > work as expected, because tags is shared among al=
l these devices. The
> > > > > > > > > > > > > current ublk interface needs to be extended for c=
overing this case.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Thanks for clarifying, that is very helpful.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Follow up question: What would the implications be =
if one tried to
> > > > > > > > > > > > expose (through ublk) each nvme namespace of an nvm=
e-of controller with
> > > > > > > > > > > > an independent tag set?
> > > > > > > > > > >=20
> > > > > > > > > > > https://lore.kernel.org/linux-block/877cwhrgul.fsf@me=
taspace.dk/T/#m57158db9f0108e529d8d62d1d56652c52e9e3e67
> > > > > > > > > > >=20
> > > > > > > > > > > > What are the benefits of sharing a tagset across
> > > > > > > > > > > > all namespaces of a controller?
> > > > > > > > > > >=20
> > > > > > > > > > > The userspace implementation can be simplified a lot =
since generic
> > > > > > > > > > > shared tag allocation isn't needed, meantime with goo=
d performance
> > > > > > > > > > > (shared tags allocation in SMP is one hard problem)
> > > > > > > > > >=20
> > > > > > > > > > In NVMe, tags are per Submission Queue. AFAIK there's n=
o such thing as
> > > > > > > > > > shared tags across multiple SQs in NVMe. So userspace d=
oesn't need an
> > > > > > > > >=20
> > > > > > > > > In reality the max supported nr_queues of nvme is often m=
uch less than
> > > > > > > > > nr_cpu_ids, for example, lots of nvme-pci devices just su=
pport at most
> > > > > > > > > 32 queues, I remembered that Azure nvme supports less(jus=
t 8 queues).
> > > > > > > > > That is because queue isn't free in both software and har=
dware, which
> > > > > > > > > implementation is often tradeoff between performance and =
cost.
> > > > > > > >=20
> > > > > > > > I didn't say that the ublk server should have nr_cpu_ids th=
reads. I
> > > > > > > > thought the idea was the ublk server creates as many thread=
s as it needs
> > > > > > > > (e.g. max 8 if the Azure NVMe device only has 8 queues).
> > > > > > > >=20
> > > > > > > > Do you expect ublk servers to have nr_cpu_ids threads in al=
l/most cases?
> > > > > > >=20
> > > > > > > No.
> > > > > > >=20
> > > > > > > In ublksrv project, each pthread maps to one unique hardware =
queue, so total
> > > > > > > number of pthread is equal to nr_hw_queues.
> > > > > >=20
> > > > > > Good, I think we agree on that part.
> > > > > >=20
> > > > > > Here is a summary of the ublk server model I've been describing:
> > > > > > 1. Each pthread has a separate io_uring context.
> > > > > > 2. Each pthread has its own hardware submission queue (NVMe SQ,=
 SCSI
> > > > > >    command queue, etc).
> > > > > > 3. Each pthread has a distinct subrange of the tag space if the=
 tag
> > > > > >    space is shared across hardware submission queues.
> > > > > > 4. Each pthread allocates tags from its subrange without coordi=
nating
> > > > > >    with other threads. This is cheap and simple.
> > > > >=20
> > > > > That is also not doable.
> > > > >=20
> > > > > The tag space can be pretty small, such as, usb-storage queue dep=
th
> > > > > is just 1, and usb card reader can support multi lun too.
> > > >=20
> > > > If the tag space is very limited, just create one pthread.
> > >=20
> > > What I meant is that sub-range isn't doable.
> > >=20
> > > And pthread is aligned with queue, that is nothing to do with nr_tags.
> > >=20
> > > >=20
> > > > > That is just one extreme example, but there can be more low queue=
 depth
> > > > > scsi devices(sata : 32, ...), typical nvme/pci queue depth is 102=
3, but
> > > > > there could be some implementation with less.
> > > >=20
> > > > NVMe PCI has per-sq tags so subranges aren't needed. Each pthread h=
as
> > > > its own independent tag space. That means NVMe devices with low que=
ue
> > > > depths work fine in the model I described.
> > >=20
> > > NVMe PCI isn't special, and it is covered by current ublk abstract, s=
o one way
> > > or another, we should not support both sub-range or non-sub-range for
> > > avoiding unnecessary complexity.
> > >=20
> > > "Each pthread has its own independent tag space" may mean two things
> > >=20
> > > 1) each LUN/NS is implemented in standalone process space:
> > > - so every queue of each LUN has its own space, but all the queues wi=
th
> > > same ID share the whole queue tag space
> > > - that matches with current ublksrv
> > > - also easier to implement
> > >=20
> > > 2) all LUNs/NSs are implemented in single process space
> > > - so each pthread handles one queue for all NSs/LUNs
> > >=20
> > > Yeah, if you mean 2), the tag allocation is cheap, but the existed ub=
lk
> > > char device has to handle multiple LUNs/NSs(disks), which still need
> > > (big) ublk interface change. Also this way can't scale for single que=
ue
> > > devices.
> >=20
> > The model I described is neither 1) or 2). It's similar to 2) but I'm
> > not sure why you say the ublk interface needs to be changed. I'm afraid
> > I haven't explained it well, sorry. I'll try to describe it again with
> > an NVMe PCI adapter being handled by userspace.
> >=20
> > There is a single ublk server process with an NVMe PCI device opened
> > using VFIO.
> >=20
> > There are N pthreads and each pthread has 1 io_uring context and 1 NVMe
> > PCI SQ/CQ pair. The size of the SQ and CQ rings is QD.
> >=20
> > The NVMe PCI device has M Namespaces. The ublk server creates M
> > ublk_devices. Each ublk_device has N ublk_queues with queue_depth QD.
> >=20
> > The Linux block layer sees M block devices with N nr_hw_queues and QD
> > queue_depth. The actual NVMe PCI device resources are less than what the
> > Linux block layer sees because the each SQ/CQ pair is used for M
> > ublk_devices. In other words, Linux thinks there can be M * N * QD
> > requests in flight but in reality the NVMe PCI adapter only supports N *
> > QD requests.
>=20
> Yeah, but it is really bad.
>=20
> Now QD is the host hard queue depth, which can be very big, and could be
> more than thousands.
>=20
> ublk driver doesn't understand this kind of sharing(tag, io command buffe=
r, io
> buffers), M * M * QD requests are submitted to ublk server, and CPUs/memo=
ry
> are wasted a lot.
>=20
> Every device has to allocate command buffers for holding QD io commands, =
and
> command buffer is supposed to be per-host, instead of per-disk. Same with=
 io
> buffer pre-allocation in userspace side.

I agree with you in cases with lots of LUNs (large M), block layer and
ublk driver per-request memory is allocated that cannot be used
simultaneously.

> Userspace has to re-tag the requests for avoiding duplicated tag, and
> requests have to be throttled in ublk server side. If you implement tag a=
llocation
> in userspace side, it is still one typical shared data issue in SMP, M pt=
hreads
> contends on single tags from multiple CPUs.

Here I still disagree. There is no SMP contention with NVMe because tags
are per SQ. For SCSI the tag namespace is shared but each pthread can
trivially work with a sub-range to avoid SMP contention. If the tag
namespace is too small for sub-ranges, then there should be fewer
pthreads.

> >=20
> > Now I'll describe how userspace can take care of the mismatch between
> > the Linux block layer and the NVMe PCI device without doing much work:
> >=20
> > Each pthread sets up QD UBLK_IO_COMMIT_AND_FETCH_REQ io_uring_cmds for
> > each of the M Namespaces.
> >=20
> > When userspace receives a request from ublk, it cannot simply copy the
> > struct ublksrv_io_cmd->tag field into the NVMe SQE Command Identifier
> > (CID) field. There would be collisions between the tags used across the
> > M ublk_queues that the pthread services.
> >=20
> > Userspace selects a free tag (e.g. from a bitmap with QD elements) and
> > uses that as the NVMe Command Identifier. This is trivial because each
> > pthread has its own bitmap and NVMe Command Identifiers are per-SQ.
>=20
> I believe I have explained, in reality, NVME SQ/CQ pair can be less(
> or much less) than nr_cpu_ids, so the per-queue-tags can be allocated & f=
reed
> among CPUs of (nr_cpu_ids / nr_hw_queues).
>=20
> Not mention userspace is capable of overriding the pthread cpu affinity,
> so it isn't trivial & cheap, M pthreads could be run from
> more than (nr_cpu_ids / nr_hw_queues) CPUs and contend on the single hw q=
ueue tags.

I don't understand your nr_cpu_ids concerns. In the model I have
described, the number of pthreads is min(nr_cpu_ids, max_sq_cq_pairs)
and the SQ/CQ pairs are per pthread. There is no sharing of SQ/CQ pairs
across pthreads.

On a limited NVMe controller nr_cpu_ids=3D128 and max_sq_cq_pairs=3D8, so
there are only 8 pthreads. Each pthread has its own io_uring context
through which it handles M ublk_queues. Even if a pthread runs from more
than 1 CPU, its SQ Command Identifiers (tags) are only used by that
pthread and there is no SMP contention.

Can you explain where you see SMP contention for NVMe SQ Command
Identifiers?

> >=20
> > If there are no free tags then the request is placed in the pthread's
> > per Namespace overflow list. Whenever an NVMe command completes, the
> > overflow lists are scanned. One pending request is submitted to the NVMe
> > PCI adapter in a round-robin fashion until the lists are empty or there
> > are no more free tags.
> >=20
> > That's it. No ublk API changes are necessary. The userspace code is not
> > slow or complex (just a bitmap and overflow list).
>=20
> Fine, but I am not sure we need to support such mess & pool implementatio=
n.
>=20
> >=20
> > The approach also works for SCSI or devices that only support 1 request
> > in flight at a time, with small tweaks.
> >=20
> > Going back to the beginning of the discussion: I think it's possible to
> > write a ublk server that handles multiple LUNs/NS today.
>=20
> It is possible, but it is poor in both performance and resource
> utilization, meantime with complicated ublk server implementation.

Okay. I wanted to make sure I wasn't missing a reason why it's
fundamentally impossible. Performance, resource utilization, or
complexity is debatable and I think I understand your position. I think
you're looking for a general solution that works well even with a high
number of LUNs, where the model I proposed wastes resources.

>=20
> >=20
> > > Another thing is that io command buffer has to be shared among all LU=
Ns/
> > > NSs. So interface change has to cover shared io command buffer.
> >=20
> > I think the main advantage of extending the ublk API to share io command
> > buffers between ublk_devices is to reduce userspace memory consumption?
> >=20
> > It eliminates the need to over-provision I/O buffers for write requests
> > (or use the slower UBLK_IO_NEED_GET_DATA approach).
>=20
> Not only avoiding memory and cpu waste, but also simplifying ublk
> server.
>=20
> >=20
> > > With zero copy support, io buffer sharing needn't to be considered, t=
hat
> > > can be a bit easier.
> > >=20
> > > In short, the sharing of (tag, io command buffer, io buffer) needs to=
 be
> > > considered for shared host ublk disks.
> > >=20
> > > Actually I prefer to 1), which matches with current design, and we can
> > > just add host concept into ublk, and implementation could be easier.
> > >=20
> > > BTW, ublk has been applied to implement iscsi alternative disk[1] for=
 Longhorn[2],
> > > and the performance improvement is pretty nice, so I think it is one =
reasonable
> > > requirement to support "shared host" ublk disks for covering multi-lu=
n or multi-ns.
> > >=20
> > > [1] https://github.com/ming1/ubdsrv/issues/49
> > > [2] https://github.com/longhorn/longhorn
> >=20
> > Nice performance improvement!
> >=20
> > I agree with you that the ublk API should have a way to declare the
> > resource contraints for multi-LUN/NS servers (i.e. share the tag_set). I
> > guess the simplest way to do that is by passing a reference to an
> > existing device to UBLK_CMD_ADD_DEV so it can share the tag_set? Nothing
> > else about the ublk API needs to change, at least for tags.
>=20
> Basically (tags, io command buffer, io buffers) need to move into
> host/hw_queue wide from disk wide, so not so simple, but won't
> be too complicated.
>=20
> >=20
> > Solving I/O buffer over-provisioning sounds similar to io_uring's
> > provided buffer mechanism :).
>=20
> blk-mq has built-in host/hw_queue wide tag allocation, which can provide
> unique tag for ublk server from ublk driver side, so everything can be
> simplified a lot if we move (tag, io command buffer, io buffers) into
> host/hw_queue wide by telling ublk_driver that we are
> BLK_MQ_F_TAG_QUEUE_SHARED.
>=20
> Not sure if io_uring's provided buffer is good here, cause we need to
> discard io buffers after queue become idle. But it won't be one big
> deal if zero copy can be supported.

If the per-request ublk resources are shared like tags as you described,
then that's a nice solution that also solves I/O buffer
over-provisioning.

Stefan

--WV38a+vTkiNaDltd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQYUskACgkQnKSrs4Gr
c8j67Af/eLYDuRpGB6y2NR3EFngIaY6HRZ59+b6jr+0NwVhkREhDIS0uSs54/EGL
L2S+wAKN6ZuCzBY/vHUfbBHkHY42wP8rEpT8GA78g6Mjo8O+gfRtlvacvdhoZo2L
C+MVKXM+3ahxhKyH3t4hetK6OkiU7rvHXL0TpYQ1r9YZarg5UJD4ERVHlMGoTbcj
x/AsYY3ODO5/HvJBnVfrdQ2M7oOdHYRFjGUEvdPyN9lh4R4h5Ixwag64tW1ssJ4i
q5cp3d824GCkAw+wxhGqJMdpUzQpWZZ82aFeqfe031IWiGULpMdi2x16D+IvjmQm
56jO1kFNXX/pSt8nCvj176ffqknnng==
=gq++
-----END PGP SIGNATURE-----

--WV38a+vTkiNaDltd--

