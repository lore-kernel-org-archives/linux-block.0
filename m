Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3A0C636D6
	for <linux-block@archiver.kernel.org>; Wed, 22 Feb 2023 23:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjBVXSj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Feb 2023 18:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjBVXSh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2023 18:18:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001DC26B8
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 15:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677107869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mLHElaKQPSqskChP8KWT1+DuSNXELymsT3Gy1iZfps4=;
        b=ENBC/SayQCrMJM+smU2eeeFHClRrTLk1UlgwjugNE4wGcMLl2DbhKpVL+LSpShQ0ADe3sC
        tuQXugistWOIRn9nThMFCMPct92nSACot0AI/Y4LsZr5z4G59pZtbfyrpBYAX4W81y3ew2
        wgp3xtXRPBhiKLn8z7bUgFo1KGQLHuU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-rtu0xh5aNpCZaz_YZh-9HA-1; Wed, 22 Feb 2023 18:17:46 -0500
X-MC-Unique: rtu0xh5aNpCZaz_YZh-9HA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1E351C008A4;
        Wed, 22 Feb 2023 23:17:45 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD17E2166B29;
        Wed, 22 Feb 2023 23:17:38 +0000 (UTC)
Date:   Thu, 23 Feb 2023 07:17:33 +0800
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
Message-ID: <Y/aijeTJ2HuITMc1@T590>
References: <Y+my03K5MbSSRvQq@T590>
 <Y+qL9z7rtApszoBf@fedora>
 <Y+wsj2QqX+HMUJTI@T590>
 <87bkltrj9x.fsf@metaspace.dk>
 <Y+4JVgd338R0x1m4@T590>
 <877cwhrgul.fsf@metaspace.dk>
 <Y+7kfZnWsmnA0V84@T590>
 <Y++t3kYTSNo9Sbb5@fedora>
 <Y/C1CVFceZ+X0ECa@T590>
 <Y/EbEGV2Ege51RQZ@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/EbEGV2Ege51RQZ@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Feb 18, 2023 at 01:38:08PM -0500, Stefan Hajnoczi wrote:
> On Sat, Feb 18, 2023 at 07:22:49PM +0800, Ming Lei wrote:
> > On Fri, Feb 17, 2023 at 11:39:58AM -0500, Stefan Hajnoczi wrote:
> > > On Fri, Feb 17, 2023 at 10:20:45AM +0800, Ming Lei wrote:
> > > > On Thu, Feb 16, 2023 at 12:21:32PM +0100, Andreas Hindborg wrote:
> > > > > 
> > > > > Ming Lei <ming.lei@redhat.com> writes:
> > > > > 
> > > > > > On Thu, Feb 16, 2023 at 10:44:02AM +0100, Andreas Hindborg wrote:
> > > > > >> 
> > > > > >> Hi Ming,
> > > > > >> 
> > > > > >> Ming Lei <ming.lei@redhat.com> writes:
> > > > > >> 
> > > > > >> > On Mon, Feb 13, 2023 at 02:13:59PM -0500, Stefan Hajnoczi wrote:
> > > > > >> >> On Mon, Feb 13, 2023 at 11:47:31AM +0800, Ming Lei wrote:
> > > > > >> >> > On Wed, Feb 08, 2023 at 07:17:10AM -0500, Stefan Hajnoczi wrote:
> > > > > >> >> > > On Wed, Feb 08, 2023 at 10:12:19AM +0800, Ming Lei wrote:
> > > > > >> >> > > > On Mon, Feb 06, 2023 at 03:27:09PM -0500, Stefan Hajnoczi wrote:
> > > > > >> >> > > > > On Mon, Feb 06, 2023 at 11:00:27PM +0800, Ming Lei wrote:
> > > > > >> >> > > > > > Hello,
> > > > > >> >> > > > > > 
> > > > > >> >> > > > > > So far UBLK is only used for implementing virtual block device from
> > > > > >> >> > > > > > userspace, such as loop, nbd, qcow2, ...[1].
> > > > > >> >> > > > > 
> > > > > >> >> > > > > I won't be at LSF/MM so here are my thoughts:
> > > > > >> >> > > > 
> > > > > >> >> > > > Thanks for the thoughts, :-)
> > > > > >> >> > > > 
> > > > > >> >> > > > > 
> > > > > >> >> > > > > > 
> > > > > >> >> > > > > > It could be useful for UBLK to cover real storage hardware too:
> > > > > >> >> > > > > > 
> > > > > >> >> > > > > > - for fast prototype or performance evaluation
> > > > > >> >> > > > > > 
> > > > > >> >> > > > > > - some network storages are attached to host, such as iscsi and nvme-tcp,
> > > > > >> >> > > > > > the current UBLK interface doesn't support such devices, since it needs
> > > > > >> >> > > > > > all LUNs/Namespaces to share host resources(such as tag)
> > > > > >> >> > > > > 
> > > > > >> >> > > > > Can you explain this in more detail? It seems like an iSCSI or
> > > > > >> >> > > > > NVMe-over-TCP initiator could be implemented as a ublk server today.
> > > > > >> >> > > > > What am I missing?
> > > > > >> >> > > > 
> > > > > >> >> > > > The current ublk can't do that yet, because the interface doesn't
> > > > > >> >> > > > support multiple ublk disks sharing single host, which is exactly
> > > > > >> >> > > > the case of scsi and nvme.
> > > > > >> >> > > 
> > > > > >> >> > > Can you give an example that shows exactly where a problem is hit?
> > > > > >> >> > > 
> > > > > >> >> > > I took a quick look at the ublk source code and didn't spot a place
> > > > > >> >> > > where it prevents a single ublk server process from handling multiple
> > > > > >> >> > > devices.
> > > > > >> >> > > 
> > > > > >> >> > > Regarding "host resources(such as tag)", can the ublk server deal with
> > > > > >> >> > > that in userspace? The Linux block layer doesn't have the concept of a
> > > > > >> >> > > "host", that would come in at the SCSI/NVMe level that's implemented in
> > > > > >> >> > > userspace.
> > > > > >> >> > > 
> > > > > >> >> > > I don't understand yet...
> > > > > >> >> > 
> > > > > >> >> > blk_mq_tag_set is embedded into driver host structure, and referred by queue
> > > > > >> >> > via q->tag_set, both scsi and nvme allocates tag in host/queue wide,
> > > > > >> >> > that said all LUNs/NSs share host/queue tags, current every ublk
> > > > > >> >> > device is independent, and can't shard tags.
> > > > > >> >> 
> > > > > >> >> Does this actually prevent ublk servers with multiple ublk devices or is
> > > > > >> >> it just sub-optimal?
> > > > > >> >
> > > > > >> > It is former, ublk can't support multiple devices which share single host
> > > > > >> > because duplicated tag can be seen in host side, then io is failed.
> > > > > >> >
> > > > > >> 
> > > > > >> I have trouble following this discussion. Why can we not handle multiple
> > > > > >> block devices in a single ublk user space process?
> > > > > >> 
> > > > > >> From this conversation it seems that the limiting factor is allocation
> > > > > >> of the tag set of the virtual device in the kernel? But as far as I can
> > > > > >> tell, the tag sets are allocated per virtual block device in
> > > > > >> `ublk_ctrl_add_dev()`?
> > > > > >> 
> > > > > >> It seems to me that a single ublk user space process shuld be able to
> > > > > >> connect to multiple storage devices (for instance nvme-of) and then
> > > > > >> create a ublk device for each namespace, all from a single ublk process.
> > > > > >> 
> > > > > >> Could you elaborate on why this is not possible?
> > > > > >
> > > > > > If the multiple storages devices are independent, the current ublk can
> > > > > > handle them just fine.
> > > > > >
> > > > > > But if these storage devices(such as luns in iscsi, or NSs in nvme-tcp)
> > > > > > share single host, and use host-wide tagset, the current interface can't
> > > > > > work as expected, because tags is shared among all these devices. The
> > > > > > current ublk interface needs to be extended for covering this case.
> > > > > 
> > > > > Thanks for clarifying, that is very helpful.
> > > > > 
> > > > > Follow up question: What would the implications be if one tried to
> > > > > expose (through ublk) each nvme namespace of an nvme-of controller with
> > > > > an independent tag set?
> > > > 
> > > > https://lore.kernel.org/linux-block/877cwhrgul.fsf@metaspace.dk/T/#m57158db9f0108e529d8d62d1d56652c52e9e3e67
> > > > 
> > > > > What are the benefits of sharing a tagset across
> > > > > all namespaces of a controller?
> > > > 
> > > > The userspace implementation can be simplified a lot since generic
> > > > shared tag allocation isn't needed, meantime with good performance
> > > > (shared tags allocation in SMP is one hard problem)
> > > 
> > > In NVMe, tags are per Submission Queue. AFAIK there's no such thing as
> > > shared tags across multiple SQs in NVMe. So userspace doesn't need an
> > 
> > In reality the max supported nr_queues of nvme is often much less than
> > nr_cpu_ids, for example, lots of nvme-pci devices just support at most
> > 32 queues, I remembered that Azure nvme supports less(just 8 queues).
> > That is because queue isn't free in both software and hardware, which
> > implementation is often tradeoff between performance and cost.
> 
> I didn't say that the ublk server should have nr_cpu_ids threads. I
> thought the idea was the ublk server creates as many threads as it needs
> (e.g. max 8 if the Azure NVMe device only has 8 queues).
> 
> Do you expect ublk servers to have nr_cpu_ids threads in all/most cases?

No.

In ublksrv project, each pthread maps to one unique hardware queue, so total
number of pthread is equal to nr_hw_queues.

> 
> > Not mention, most of scsi devices are SQ in which tag allocations from
> > all CPUs are against single shared tagset.
> > 
> > So there is still per-queue tag allocations from different CPUs which aims
> > at same queue.
> >
> > What we discussed are supposed to be generic solution, not something just
> > for ideal 1:1 mapping device, which isn't dominant in reality.
> 
> The same trivial tag allocation can be used for SCSI: instead of a
> private tag namespace (e.g. 0x0-0xffff), give each queue a private
> subset of the tag namespace (e.g. queue 0 has 0x0-0x7f, queue 1 has
> 0x80-0xff, etc).

Sorry, I may not get your point.

Each hw queue has its own tag space, for example, one scsi adaptor has 2
queues, queue depth is 128, then each hardware queue's tag space is
0 ~ 127. Also if there are two LUNs attached to this host, the two luns
share the two queue's tag space, that means any IO issued to queue 0,
no matter if it is from lun0 or lun1, the allocated tag has to unique in
the set of 0~127.

> 
> The issue is not whether the tag namespace is shared across queues, but
> the threading model of the ublk server. If the threading model requires
> queues to be shared, then it becomes more complex and slow.

ublksrv's threading model is simple, each thread handles IOs from one unique
hw queue, so total thread number is equal to nr_hw_queues.

If nr_hw_queues(nr_pthreads) < nr_cpu_id, one queue(ublk pthread) has to
handle IO requests from more than one CPUs, then contention on tag allocation
from this queue(ublk pthread).

> 
> It's not clear to me why you think ublk servers should choose threading
> models that require queues to be shared? They don't have to. Unlike the
> kernel, they can choose the number of threads.

queue sharing or not simply depends on if nr_hw_queues is less than
nr_cpu_id. That is one easy math problem, isn't it?

> 
> > 
> > > SMP tag allocator in the first place:
> > > - Each ublk server thread has a separate io_uring context.
> > > - Each ublk server thread has its own NVMe Submission Queue.
> > > - Therefore it's trivial and cheap to allocate NVMe CIDs in userspace
> > >   because there are no SMP concerns.
> > 
> > It isn't even trivial for 1:1 mapping, when any ublk server crashes
> > global tag will be leaked, and other ublk servers can't use the
> > leaked tag any more.
> 
> I'm not sure what you're describing here, a multi-process ublk server?
> Are you saying userspace must not do tag allocation itself because it
> won't be able to recover?

No matter if the ublk server is multi process or threads. If tag
allocation is implemented in userspace, you have to take thread/process
panic into account. Because if one process/pthread panics without
releasing one tag, the tag won't be visible to other ublk server any
more.

That is because each queue's tag space is shared for all LUNs/NSs which
are supposed to implemented as ublk server.

Tag utilization highly affects performance, and recover could take a
bit long or even not recovered, during this period, the leaked tags
aren't visible for other LUNs/NSs(ublk server), not mention for fixing
tag leak in recover, you have to track each tag's user(ublk server info),
which adds cost/complexity to fast/parallel io path, trivial to solve?


thanks, 
Ming

