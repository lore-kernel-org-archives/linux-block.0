Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EDAC61DA4
	for <linux-block@archiver.kernel.org>; Thu, 23 Feb 2023 20:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjBWUTO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Feb 2023 15:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBWUTO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Feb 2023 15:19:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F6E31E00
        for <linux-block@vger.kernel.org>; Thu, 23 Feb 2023 12:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677183505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2QqREG9WtpFt4J1LdG9LL5KCBAIEoCrPy8lenTnzVKE=;
        b=YNM8GGroWotNAwCTFxbo9ycjEbryLw4Gd9f8kdenrpuxAjEx+JMweFcIOviBzuyGjRxOvH
        97mjo/ohOoyjZtl+rUZ/SaioCl60Z4AQkRNap5OzpaFMeOM49+0BIpRyil9Xkl7obBhP9f
        uPt+xz+lNfQXPe8XjDDzmiaH3DPcCqg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-gE0T4M7QP5SWbEUV3BTjcQ-1; Thu, 23 Feb 2023 15:18:23 -0500
X-MC-Unique: gE0T4M7QP5SWbEUV3BTjcQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7A3D101A52E;
        Thu, 23 Feb 2023 20:18:22 +0000 (UTC)
Received: from localhost (unknown [10.39.192.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF33C2166B29;
        Thu, 23 Feb 2023 20:18:21 +0000 (UTC)
Date:   Thu, 23 Feb 2023 15:18:19 -0500
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
Message-ID: <Y/fKC7/cTM2mpz3H@fedora>
References: <Y+qL9z7rtApszoBf@fedora>
 <Y+wsj2QqX+HMUJTI@T590>
 <87bkltrj9x.fsf@metaspace.dk>
 <Y+4JVgd338R0x1m4@T590>
 <877cwhrgul.fsf@metaspace.dk>
 <Y+7kfZnWsmnA0V84@T590>
 <Y++t3kYTSNo9Sbb5@fedora>
 <Y/C1CVFceZ+X0ECa@T590>
 <Y/EbEGV2Ege51RQZ@fedora>
 <Y/aijeTJ2HuITMc1@T590>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ceQq/YE3odSVZ3bR"
Content-Disposition: inline
In-Reply-To: <Y/aijeTJ2HuITMc1@T590>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--ceQq/YE3odSVZ3bR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2023 at 07:17:33AM +0800, Ming Lei wrote:
> On Sat, Feb 18, 2023 at 01:38:08PM -0500, Stefan Hajnoczi wrote:
> > On Sat, Feb 18, 2023 at 07:22:49PM +0800, Ming Lei wrote:
> > > On Fri, Feb 17, 2023 at 11:39:58AM -0500, Stefan Hajnoczi wrote:
> > > > On Fri, Feb 17, 2023 at 10:20:45AM +0800, Ming Lei wrote:
> > > > > On Thu, Feb 16, 2023 at 12:21:32PM +0100, Andreas Hindborg wrote:
> > > > > >=20
> > > > > > Ming Lei <ming.lei@redhat.com> writes:
> > > > > >=20
> > > > > > > On Thu, Feb 16, 2023 at 10:44:02AM +0100, Andreas Hindborg wr=
ote:
> > > > > > >>=20
> > > > > > >> Hi Ming,
> > > > > > >>=20
> > > > > > >> Ming Lei <ming.lei@redhat.com> writes:
> > > > > > >>=20
> > > > > > >> > On Mon, Feb 13, 2023 at 02:13:59PM -0500, Stefan Hajnoczi =
wrote:
> > > > > > >> >> On Mon, Feb 13, 2023 at 11:47:31AM +0800, Ming Lei wrote:
> > > > > > >> >> > On Wed, Feb 08, 2023 at 07:17:10AM -0500, Stefan Hajnoc=
zi wrote:
> > > > > > >> >> > > On Wed, Feb 08, 2023 at 10:12:19AM +0800, Ming Lei wr=
ote:
> > > > > > >> >> > > > On Mon, Feb 06, 2023 at 03:27:09PM -0500, Stefan Ha=
jnoczi wrote:
> > > > > > >> >> > > > > On Mon, Feb 06, 2023 at 11:00:27PM +0800, Ming Le=
i wrote:
> > > > > > >> >> > > > > > Hello,
> > > > > > >> >> > > > > >=20
> > > > > > >> >> > > > > > So far UBLK is only used for implementing virtu=
al block device from
> > > > > > >> >> > > > > > userspace, such as loop, nbd, qcow2, ...[1].
> > > > > > >> >> > > > >=20
> > > > > > >> >> > > > > I won't be at LSF/MM so here are my thoughts:
> > > > > > >> >> > > >=20
> > > > > > >> >> > > > Thanks for the thoughts, :-)
> > > > > > >> >> > > >=20
> > > > > > >> >> > > > >=20
> > > > > > >> >> > > > > >=20
> > > > > > >> >> > > > > > It could be useful for UBLK to cover real stora=
ge hardware too:
> > > > > > >> >> > > > > >=20
> > > > > > >> >> > > > > > - for fast prototype or performance evaluation
> > > > > > >> >> > > > > >=20
> > > > > > >> >> > > > > > - some network storages are attached to host, s=
uch as iscsi and nvme-tcp,
> > > > > > >> >> > > > > > the current UBLK interface doesn't support such=
 devices, since it needs
> > > > > > >> >> > > > > > all LUNs/Namespaces to share host resources(suc=
h as tag)
> > > > > > >> >> > > > >=20
> > > > > > >> >> > > > > Can you explain this in more detail? It seems lik=
e an iSCSI or
> > > > > > >> >> > > > > NVMe-over-TCP initiator could be implemented as a=
 ublk server today.
> > > > > > >> >> > > > > What am I missing?
> > > > > > >> >> > > >=20
> > > > > > >> >> > > > The current ublk can't do that yet, because the int=
erface doesn't
> > > > > > >> >> > > > support multiple ublk disks sharing single host, wh=
ich is exactly
> > > > > > >> >> > > > the case of scsi and nvme.
> > > > > > >> >> > >=20
> > > > > > >> >> > > Can you give an example that shows exactly where a pr=
oblem is hit?
> > > > > > >> >> > >=20
> > > > > > >> >> > > I took a quick look at the ublk source code and didn'=
t spot a place
> > > > > > >> >> > > where it prevents a single ublk server process from h=
andling multiple
> > > > > > >> >> > > devices.
> > > > > > >> >> > >=20
> > > > > > >> >> > > Regarding "host resources(such as tag)", can the ublk=
 server deal with
> > > > > > >> >> > > that in userspace? The Linux block layer doesn't have=
 the concept of a
> > > > > > >> >> > > "host", that would come in at the SCSI/NVMe level tha=
t's implemented in
> > > > > > >> >> > > userspace.
> > > > > > >> >> > >=20
> > > > > > >> >> > > I don't understand yet...
> > > > > > >> >> >=20
> > > > > > >> >> > blk_mq_tag_set is embedded into driver host structure, =
and referred by queue
> > > > > > >> >> > via q->tag_set, both scsi and nvme allocates tag in hos=
t/queue wide,
> > > > > > >> >> > that said all LUNs/NSs share host/queue tags, current e=
very ublk
> > > > > > >> >> > device is independent, and can't shard tags.
> > > > > > >> >>=20
> > > > > > >> >> Does this actually prevent ublk servers with multiple ubl=
k devices or is
> > > > > > >> >> it just sub-optimal?
> > > > > > >> >
> > > > > > >> > It is former, ublk can't support multiple devices which sh=
are single host
> > > > > > >> > because duplicated tag can be seen in host side, then io i=
s failed.
> > > > > > >> >
> > > > > > >>=20
> > > > > > >> I have trouble following this discussion. Why can we not han=
dle multiple
> > > > > > >> block devices in a single ublk user space process?
> > > > > > >>=20
> > > > > > >> From this conversation it seems that the limiting factor is =
allocation
> > > > > > >> of the tag set of the virtual device in the kernel? But as f=
ar as I can
> > > > > > >> tell, the tag sets are allocated per virtual block device in
> > > > > > >> `ublk_ctrl_add_dev()`?
> > > > > > >>=20
> > > > > > >> It seems to me that a single ublk user space process shuld b=
e able to
> > > > > > >> connect to multiple storage devices (for instance nvme-of) a=
nd then
> > > > > > >> create a ublk device for each namespace, all from a single u=
blk process.
> > > > > > >>=20
> > > > > > >> Could you elaborate on why this is not possible?
> > > > > > >
> > > > > > > If the multiple storages devices are independent, the current=
 ublk can
> > > > > > > handle them just fine.
> > > > > > >
> > > > > > > But if these storage devices(such as luns in iscsi, or NSs in=
 nvme-tcp)
> > > > > > > share single host, and use host-wide tagset, the current inte=
rface can't
> > > > > > > work as expected, because tags is shared among all these devi=
ces. The
> > > > > > > current ublk interface needs to be extended for covering this=
 case.
> > > > > >=20
> > > > > > Thanks for clarifying, that is very helpful.
> > > > > >=20
> > > > > > Follow up question: What would the implications be if one tried=
 to
> > > > > > expose (through ublk) each nvme namespace of an nvme-of control=
ler with
> > > > > > an independent tag set?
> > > > >=20
> > > > > https://lore.kernel.org/linux-block/877cwhrgul.fsf@metaspace.dk/T=
/#m57158db9f0108e529d8d62d1d56652c52e9e3e67
> > > > >=20
> > > > > > What are the benefits of sharing a tagset across
> > > > > > all namespaces of a controller?
> > > > >=20
> > > > > The userspace implementation can be simplified a lot since generic
> > > > > shared tag allocation isn't needed, meantime with good performance
> > > > > (shared tags allocation in SMP is one hard problem)
> > > >=20
> > > > In NVMe, tags are per Submission Queue. AFAIK there's no such thing=
 as
> > > > shared tags across multiple SQs in NVMe. So userspace doesn't need =
an
> > >=20
> > > In reality the max supported nr_queues of nvme is often much less than
> > > nr_cpu_ids, for example, lots of nvme-pci devices just support at most
> > > 32 queues, I remembered that Azure nvme supports less(just 8 queues).
> > > That is because queue isn't free in both software and hardware, which
> > > implementation is often tradeoff between performance and cost.
> >=20
> > I didn't say that the ublk server should have nr_cpu_ids threads. I
> > thought the idea was the ublk server creates as many threads as it needs
> > (e.g. max 8 if the Azure NVMe device only has 8 queues).
> >=20
> > Do you expect ublk servers to have nr_cpu_ids threads in all/most cases?
>=20
> No.
>=20
> In ublksrv project, each pthread maps to one unique hardware queue, so to=
tal
> number of pthread is equal to nr_hw_queues.

Good, I think we agree on that part.

Here is a summary of the ublk server model I've been describing:
1. Each pthread has a separate io_uring context.
2. Each pthread has its own hardware submission queue (NVMe SQ, SCSI
   command queue, etc).
3. Each pthread has a distinct subrange of the tag space if the tag
   space is shared across hardware submission queues.
4. Each pthread allocates tags from its subrange without coordinating
   with other threads. This is cheap and simple.
5. When the pthread runs out of tags it either suspends processing new
   ublk requests or enqueues them internally. When hardware completes
   requests, the pthread resumes requests that were waiting for tags.

This way multiple ublk_devices can be handled by a single ublk server
without the Linux block layer knowing the exact tag space sharing
relationship between ublk_devices and hardware submission queues (NVMe
SQ, SCSI command queue, etc).

When ublk adds support for configuring tagsets, then 3, 4, and 5 can be
eliminated. However, this is purely an optimization. Not that much
userspace code will be eliminated and the performance gain is not huge.

I believe this model works for the major storage protocols like NVMe and
SCSI.

I put forward this model to explain why I don't agree that ublk doesn't
support ublk servers with multiple devices (e.g. I/O would be failed due
to duplicated tags).

I think we agree on 1 and 2. It's 3, 4, and 5 that I think you are
either saying won't work or are very complex/hard?

> >=20
> > > Not mention, most of scsi devices are SQ in which tag allocations from
> > > all CPUs are against single shared tagset.
> > >=20
> > > So there is still per-queue tag allocations from different CPUs which=
 aims
> > > at same queue.
> > >
> > > What we discussed are supposed to be generic solution, not something =
just
> > > for ideal 1:1 mapping device, which isn't dominant in reality.
> >=20
> > The same trivial tag allocation can be used for SCSI: instead of a
> > private tag namespace (e.g. 0x0-0xffff), give each queue a private
> > subset of the tag namespace (e.g. queue 0 has 0x0-0x7f, queue 1 has
> > 0x80-0xff, etc).
>=20
> Sorry, I may not get your point.
>=20
> Each hw queue has its own tag space, for example, one scsi adaptor has 2
> queues, queue depth is 128, then each hardware queue's tag space is
> 0 ~ 127.
>
> Also if there are two LUNs attached to this host, the two luns
> share the two queue's tag space, that means any IO issued to queue 0,
> no matter if it is from lun0 or lun1, the allocated tag has to unique in
> the set of 0~127.

I'm trying to explain why tag allocation in userspace is simple and
cheap thanks to the ublk server's ability to create only as many threads
as hardware queues (e.g. NVMe SQs).

Even in the case where all hardware (NVME/SCSI/etc) queues and LUNs
share the same tag space (the worst case), ublk server threads can
perform allocation from distinct subranges of the shared tag space.
There are no SMP concerns because there is no overlap in the tag space
between threads.

> >=20
> > The issue is not whether the tag namespace is shared across queues, but
> > the threading model of the ublk server. If the threading model requires
> > queues to be shared, then it becomes more complex and slow.
>=20
> ublksrv's threading model is simple, each thread handles IOs from one uni=
que
> hw queue, so total thread number is equal to nr_hw_queues.

Here "hw queue" is a Linux block layer hw queue, not a hardware queue
(i.e. NVMe SQ)?

>=20
> If nr_hw_queues(nr_pthreads) < nr_cpu_id, one queue(ublk pthread) has to
> handle IO requests from more than one CPUs, then contention on tag alloca=
tion
> from this queue(ublk pthread).

Userspace doesn't need to worry about the fact that I/O requests were
submitted by many CPUs. Each pthread processes one ublk_queue with a
known queue depth.

Each pthread has a range of userspace tags available and if there are no
more tags available then it waits to complete in-flight I/O before
accepting more requests or it can internally queue incoming requests.

> >=20
> > It's not clear to me why you think ublk servers should choose threading
> > models that require queues to be shared? They don't have to. Unlike the
> > kernel, they can choose the number of threads.
>=20
> queue sharing or not simply depends on if nr_hw_queues is less than
> nr_cpu_id. That is one easy math problem, isn't it?

We're talking about different things. I mean sharing a hardware queue
(i.e. NVMe SQ) across multiple ublk server threads. You seem to define
queue sharing as multiple CPUs submitting I/O via ublk?

Thinking about your scenario: why does it matter if multiple CPUs submit
I/O to a single ublk_queue? I don't see how it makes a difference
whether 1 CPU or multiple CPUs enqueue requests on a single ublk_queue.
Userspace will process that ublk_queue in the same way in either case.

> >=20
> > >=20
> > > > SMP tag allocator in the first place:
> > > > - Each ublk server thread has a separate io_uring context.
> > > > - Each ublk server thread has its own NVMe Submission Queue.
> > > > - Therefore it's trivial and cheap to allocate NVMe CIDs in userspa=
ce
> > > >   because there are no SMP concerns.
> > >=20
> > > It isn't even trivial for 1:1 mapping, when any ublk server crashes
> > > global tag will be leaked, and other ublk servers can't use the
> > > leaked tag any more.
> >=20
> > I'm not sure what you're describing here, a multi-process ublk server?
> > Are you saying userspace must not do tag allocation itself because it
> > won't be able to recover?
>=20
> No matter if the ublk server is multi process or threads. If tag
> allocation is implemented in userspace, you have to take thread/process
> panic into account. Because if one process/pthread panics without
> releasing one tag, the tag won't be visible to other ublk server any
> more.
>
> That is because each queue's tag space is shared for all LUNs/NSs which
> are supposed to implemented as ublk server.
>
> Tag utilization highly affects performance, and recover could take a
> bit long or even not recovered, during this period, the leaked tags
> aren't visible for other LUNs/NSs(ublk server), not mention for fixing
> tag leak in recover, you have to track each tag's user(ublk server info),
> which adds cost/complexity to fast/parallel io path, trivial to solve?

In the interest of time, let's defer the recovery discussion until
after the core discussion is finished. I would need to research how ublk
recovery works. I am happy to do that if you think recovery is the
reason why userspace cannot allocate tags, but reaching a conclusion on
the core discussion might be enough to make discussing recovery
unnecessary.

Thanks,
Stefan

--ceQq/YE3odSVZ3bR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmP3ygoACgkQnKSrs4Gr
c8hyoQgAwAgrChDz08P2buyc4hxNKr1i5ej+dTiCwpV4GTvri5NoaL05NhZ9uORp
WY/J8O7lfWOwQe4xblh6n2xCmWsUOUKwrpYveblm4atrLMYbG+E6z/cxVflbPhdo
D7DVESn67cNSJXvITw/d8y0jsyJCVOOGDB8GKmkg3lZkN/KKXZhwR1vjCe2JOnYI
5gcGcEmZGhU65e2EogwNCpbM1AeNtr/2+6uTmvgPuFYWPKfdkPaZmNJD0ekdM+Ht
zpBn4JC/rgXECjVzrC12vd7Aep8JYyXWtiu7HbMqikJQ91rjPx0oiW2jH477j9CG
E7h39Gmos0FwbXjr+bIQHdS0HIZg7Q==
=7/6c
-----END PGP SIGNATURE-----

--ceQq/YE3odSVZ3bR--

