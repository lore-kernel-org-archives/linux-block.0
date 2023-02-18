Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D9BC636CC
	for <linux-block@archiver.kernel.org>; Sat, 18 Feb 2023 11:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBRLX5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Feb 2023 06:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBRLX4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Feb 2023 06:23:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F7E7681
        for <linux-block@vger.kernel.org>; Sat, 18 Feb 2023 03:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676719385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8zqKIouz5CKS5Gx9wbbT695DxuH4rTrlTO0d667cCxk=;
        b=JIVFBvMwX7xFpvwU7RGclq3KpzHdwTtjRw9CnCg5kgSmGNd4FLWzIq15HcquWgj3G93brv
        nUY11Ds0Gng65J3htV01IcAEt+Kx3ew0fvDc9Ox/2iqs8iSQ07BSiqG6ify2cc5LzJEuty
        ZITG7Ri6z2JbUqY6RW0GY5v+GsxSIaU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-FgZAdYX5PuqoZZYISqRt-Q-1; Sat, 18 Feb 2023 06:23:02 -0500
X-MC-Unique: FgZAdYX5PuqoZZYISqRt-Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02D86811E6E;
        Sat, 18 Feb 2023 11:23:02 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B3492026D4B;
        Sat, 18 Feb 2023 11:22:54 +0000 (UTC)
Date:   Sat, 18 Feb 2023 19:22:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Andreas Hindborg <nmi@metaspace.dk>, linux-block@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Jim Harris <james.r.harris@intel.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        "hch@lst.de" <hch@lst.de>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>, ming.lei@redhat.com
Subject: Re: [LSF/MM/BPF BoF]: extend UBLK to cover real storage hardware
Message-ID: <Y/C1CVFceZ+X0ECa@T590>
References: <Y+MFAzt0Cx9aetf2@T590>
 <Y+OSxh2K0/Lf0SAk@fedora>
 <Y+my03K5MbSSRvQq@T590>
 <Y+qL9z7rtApszoBf@fedora>
 <Y+wsj2QqX+HMUJTI@T590>
 <87bkltrj9x.fsf@metaspace.dk>
 <Y+4JVgd338R0x1m4@T590>
 <877cwhrgul.fsf@metaspace.dk>
 <Y+7kfZnWsmnA0V84@T590>
 <Y++t3kYTSNo9Sbb5@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y++t3kYTSNo9Sbb5@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 17, 2023 at 11:39:58AM -0500, Stefan Hajnoczi wrote:
> On Fri, Feb 17, 2023 at 10:20:45AM +0800, Ming Lei wrote:
> > On Thu, Feb 16, 2023 at 12:21:32PM +0100, Andreas Hindborg wrote:
> > > 
> > > Ming Lei <ming.lei@redhat.com> writes:
> > > 
> > > > On Thu, Feb 16, 2023 at 10:44:02AM +0100, Andreas Hindborg wrote:
> > > >> 
> > > >> Hi Ming,
> > > >> 
> > > >> Ming Lei <ming.lei@redhat.com> writes:
> > > >> 
> > > >> > On Mon, Feb 13, 2023 at 02:13:59PM -0500, Stefan Hajnoczi wrote:
> > > >> >> On Mon, Feb 13, 2023 at 11:47:31AM +0800, Ming Lei wrote:
> > > >> >> > On Wed, Feb 08, 2023 at 07:17:10AM -0500, Stefan Hajnoczi wrote:
> > > >> >> > > On Wed, Feb 08, 2023 at 10:12:19AM +0800, Ming Lei wrote:
> > > >> >> > > > On Mon, Feb 06, 2023 at 03:27:09PM -0500, Stefan Hajnoczi wrote:
> > > >> >> > > > > On Mon, Feb 06, 2023 at 11:00:27PM +0800, Ming Lei wrote:
> > > >> >> > > > > > Hello,
> > > >> >> > > > > > 
> > > >> >> > > > > > So far UBLK is only used for implementing virtual block device from
> > > >> >> > > > > > userspace, such as loop, nbd, qcow2, ...[1].
> > > >> >> > > > > 
> > > >> >> > > > > I won't be at LSF/MM so here are my thoughts:
> > > >> >> > > > 
> > > >> >> > > > Thanks for the thoughts, :-)
> > > >> >> > > > 
> > > >> >> > > > > 
> > > >> >> > > > > > 
> > > >> >> > > > > > It could be useful for UBLK to cover real storage hardware too:
> > > >> >> > > > > > 
> > > >> >> > > > > > - for fast prototype or performance evaluation
> > > >> >> > > > > > 
> > > >> >> > > > > > - some network storages are attached to host, such as iscsi and nvme-tcp,
> > > >> >> > > > > > the current UBLK interface doesn't support such devices, since it needs
> > > >> >> > > > > > all LUNs/Namespaces to share host resources(such as tag)
> > > >> >> > > > > 
> > > >> >> > > > > Can you explain this in more detail? It seems like an iSCSI or
> > > >> >> > > > > NVMe-over-TCP initiator could be implemented as a ublk server today.
> > > >> >> > > > > What am I missing?
> > > >> >> > > > 
> > > >> >> > > > The current ublk can't do that yet, because the interface doesn't
> > > >> >> > > > support multiple ublk disks sharing single host, which is exactly
> > > >> >> > > > the case of scsi and nvme.
> > > >> >> > > 
> > > >> >> > > Can you give an example that shows exactly where a problem is hit?
> > > >> >> > > 
> > > >> >> > > I took a quick look at the ublk source code and didn't spot a place
> > > >> >> > > where it prevents a single ublk server process from handling multiple
> > > >> >> > > devices.
> > > >> >> > > 
> > > >> >> > > Regarding "host resources(such as tag)", can the ublk server deal with
> > > >> >> > > that in userspace? The Linux block layer doesn't have the concept of a
> > > >> >> > > "host", that would come in at the SCSI/NVMe level that's implemented in
> > > >> >> > > userspace.
> > > >> >> > > 
> > > >> >> > > I don't understand yet...
> > > >> >> > 
> > > >> >> > blk_mq_tag_set is embedded into driver host structure, and referred by queue
> > > >> >> > via q->tag_set, both scsi and nvme allocates tag in host/queue wide,
> > > >> >> > that said all LUNs/NSs share host/queue tags, current every ublk
> > > >> >> > device is independent, and can't shard tags.
> > > >> >> 
> > > >> >> Does this actually prevent ublk servers with multiple ublk devices or is
> > > >> >> it just sub-optimal?
> > > >> >
> > > >> > It is former, ublk can't support multiple devices which share single host
> > > >> > because duplicated tag can be seen in host side, then io is failed.
> > > >> >
> > > >> 
> > > >> I have trouble following this discussion. Why can we not handle multiple
> > > >> block devices in a single ublk user space process?
> > > >> 
> > > >> From this conversation it seems that the limiting factor is allocation
> > > >> of the tag set of the virtual device in the kernel? But as far as I can
> > > >> tell, the tag sets are allocated per virtual block device in
> > > >> `ublk_ctrl_add_dev()`?
> > > >> 
> > > >> It seems to me that a single ublk user space process shuld be able to
> > > >> connect to multiple storage devices (for instance nvme-of) and then
> > > >> create a ublk device for each namespace, all from a single ublk process.
> > > >> 
> > > >> Could you elaborate on why this is not possible?
> > > >
> > > > If the multiple storages devices are independent, the current ublk can
> > > > handle them just fine.
> > > >
> > > > But if these storage devices(such as luns in iscsi, or NSs in nvme-tcp)
> > > > share single host, and use host-wide tagset, the current interface can't
> > > > work as expected, because tags is shared among all these devices. The
> > > > current ublk interface needs to be extended for covering this case.
> > > 
> > > Thanks for clarifying, that is very helpful.
> > > 
> > > Follow up question: What would the implications be if one tried to
> > > expose (through ublk) each nvme namespace of an nvme-of controller with
> > > an independent tag set?
> > 
> > https://lore.kernel.org/linux-block/877cwhrgul.fsf@metaspace.dk/T/#m57158db9f0108e529d8d62d1d56652c52e9e3e67
> > 
> > > What are the benefits of sharing a tagset across
> > > all namespaces of a controller?
> > 
> > The userspace implementation can be simplified a lot since generic
> > shared tag allocation isn't needed, meantime with good performance
> > (shared tags allocation in SMP is one hard problem)
> 
> In NVMe, tags are per Submission Queue. AFAIK there's no such thing as
> shared tags across multiple SQs in NVMe. So userspace doesn't need an

In reality the max supported nr_queues of nvme is often much less than
nr_cpu_ids, for example, lots of nvme-pci devices just support at most
32 queues, I remembered that Azure nvme supports less(just 8 queues).
That is because queue isn't free in both software and hardware, which
implementation is often tradeoff between performance and cost.

Not mention, most of scsi devices are SQ in which tag allocations from
all CPUs are against single shared tagset.

So there is still per-queue tag allocations from different CPUs which aims
at same queue.

What we discussed are supposed to be generic solution, not something just
for ideal 1:1 mapping device, which isn't dominant in reality.

> SMP tag allocator in the first place:
> - Each ublk server thread has a separate io_uring context.
> - Each ublk server thread has its own NVMe Submission Queue.
> - Therefore it's trivial and cheap to allocate NVMe CIDs in userspace
>   because there are no SMP concerns.

It isn't even trivial for 1:1 mapping, when any ublk server crashes
global tag will be leaked, and other ublk servers can't use the
leaked tag any more.

Not mention there are lots of SQ device(1:M), or nr_queues
is much less than nr_cpu_ids(N:M N < M). It is pretty easier to
see 1:M or N:M mapping for both nvme and scsi.

> 
> The issue isn't tag allocation, it's the fact that the kernel block
> layer submits requests to userspace that don't fit into the NVMe
> Submission Queue because multiple devices that appear independent from
> the kernel perspective are sharing a single NVMe Submission Queue.
> Userspace needs a basic I/O scheduler to ensure fairness across devices.
> Round-robin for example.

We already have io scheduler for /dev/ublkbN. Also what I proposed is
just to align ublk device with the actual device definition, and so far
tags is the only shared resource in generic io code path.

> There are no SMP concerns here either.

No, see above.

> 
> So I don't buy the argument that userspace would have to duplicate the
> tag allocation code from Linux because that solves a different problem
> that the ublk server doesn't have.
> 
> If the kernel is aware of tag sharing, then userspace doesn't have to do
> (trivial) tag allocation or I/O scheduling. It can simply stuff ublk io

Again, it isn't trivial.

> commands into NVMe queues without thinking, which wastes fewer CPU
> cycles and is a little simpler.

tag allocation is pretty generic, which is supposed to be done in
kernel, then any userspace isn't supposed to duplicate the
not-trivial implementation.


Thanks, 
Ming

