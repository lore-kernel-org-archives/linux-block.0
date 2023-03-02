Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1CEC7EE23
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 03:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCBDYC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Mar 2023 22:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBDYB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Mar 2023 22:24:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CB714201
        for <linux-block@vger.kernel.org>; Wed,  1 Mar 2023 19:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677727393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f6HrLKOkMNYp+2QM4cY+LWRiYCrWfZRAhw1LdN3wQN8=;
        b=TIP4qQFX7NJakMaRMBr9iJOFS3I5sbWqszLDkIw/2w+z6BVtkxxbPtlNlTZdX/iybGxTBj
        5CGQFUbxE1vdr5u9iken6Xs0p7sUWC3y6c2qC4izjrmy9QdbIgjVCYQuBaFm1gGbiIP6VU
        4dsarJsHVnyd3cO9DvAwmDRWR5fTI5c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-B9hPIZ9POaWFXXnGWDWD5g-1; Wed, 01 Mar 2023 22:23:08 -0500
X-MC-Unique: B9hPIZ9POaWFXXnGWDWD5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 207183C02526;
        Thu,  2 Mar 2023 03:23:08 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79B592026D4B;
        Thu,  2 Mar 2023 03:23:01 +0000 (UTC)
Date:   Thu, 2 Mar 2023 11:22:55 +0800
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
Message-ID: <ZAAWj8Bs8JujXsbX@T590>
References: <Y+wsj2QqX+HMUJTI@T590>
 <87bkltrj9x.fsf@metaspace.dk>
 <Y+4JVgd338R0x1m4@T590>
 <877cwhrgul.fsf@metaspace.dk>
 <Y+7kfZnWsmnA0V84@T590>
 <Y++t3kYTSNo9Sbb5@fedora>
 <Y/C1CVFceZ+X0ECa@T590>
 <Y/EbEGV2Ege51RQZ@fedora>
 <Y/aijeTJ2HuITMc1@T590>
 <Y/fKC7/cTM2mpz3H@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/fKC7/cTM2mpz3H@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 23, 2023 at 03:18:19PM -0500, Stefan Hajnoczi wrote:
> On Thu, Feb 23, 2023 at 07:17:33AM +0800, Ming Lei wrote:
> > On Sat, Feb 18, 2023 at 01:38:08PM -0500, Stefan Hajnoczi wrote:
> > > On Sat, Feb 18, 2023 at 07:22:49PM +0800, Ming Lei wrote:
> > > > On Fri, Feb 17, 2023 at 11:39:58AM -0500, Stefan Hajnoczi wrote:
> > > > > On Fri, Feb 17, 2023 at 10:20:45AM +0800, Ming Lei wrote:
> > > > > > On Thu, Feb 16, 2023 at 12:21:32PM +0100, Andreas Hindborg wrote:
> > > > > > > 
> > > > > > > Ming Lei <ming.lei@redhat.com> writes:
> > > > > > > 
> > > > > > > > On Thu, Feb 16, 2023 at 10:44:02AM +0100, Andreas Hindborg wrote:
> > > > > > > >> 
> > > > > > > >> Hi Ming,
> > > > > > > >> 
> > > > > > > >> Ming Lei <ming.lei@redhat.com> writes:
> > > > > > > >> 
> > > > > > > >> > On Mon, Feb 13, 2023 at 02:13:59PM -0500, Stefan Hajnoczi wrote:
> > > > > > > >> >> On Mon, Feb 13, 2023 at 11:47:31AM +0800, Ming Lei wrote:
> > > > > > > >> >> > On Wed, Feb 08, 2023 at 07:17:10AM -0500, Stefan Hajnoczi wrote:
> > > > > > > >> >> > > On Wed, Feb 08, 2023 at 10:12:19AM +0800, Ming Lei wrote:
> > > > > > > >> >> > > > On Mon, Feb 06, 2023 at 03:27:09PM -0500, Stefan Hajnoczi wrote:
> > > > > > > >> >> > > > > On Mon, Feb 06, 2023 at 11:00:27PM +0800, Ming Lei wrote:
> > > > > > > >> >> > > > > > Hello,
> > > > > > > >> >> > > > > > 
> > > > > > > >> >> > > > > > So far UBLK is only used for implementing virtual block device from
> > > > > > > >> >> > > > > > userspace, such as loop, nbd, qcow2, ...[1].
> > > > > > > >> >> > > > > 
> > > > > > > >> >> > > > > I won't be at LSF/MM so here are my thoughts:
> > > > > > > >> >> > > > 
> > > > > > > >> >> > > > Thanks for the thoughts, :-)
> > > > > > > >> >> > > > 
> > > > > > > >> >> > > > > 
> > > > > > > >> >> > > > > > 
> > > > > > > >> >> > > > > > It could be useful for UBLK to cover real storage hardware too:
> > > > > > > >> >> > > > > > 
> > > > > > > >> >> > > > > > - for fast prototype or performance evaluation
> > > > > > > >> >> > > > > > 
> > > > > > > >> >> > > > > > - some network storages are attached to host, such as iscsi and nvme-tcp,
> > > > > > > >> >> > > > > > the current UBLK interface doesn't support such devices, since it needs
> > > > > > > >> >> > > > > > all LUNs/Namespaces to share host resources(such as tag)
> > > > > > > >> >> > > > > 
> > > > > > > >> >> > > > > Can you explain this in more detail? It seems like an iSCSI or
> > > > > > > >> >> > > > > NVMe-over-TCP initiator could be implemented as a ublk server today.
> > > > > > > >> >> > > > > What am I missing?
> > > > > > > >> >> > > > 
> > > > > > > >> >> > > > The current ublk can't do that yet, because the interface doesn't
> > > > > > > >> >> > > > support multiple ublk disks sharing single host, which is exactly
> > > > > > > >> >> > > > the case of scsi and nvme.
> > > > > > > >> >> > > 
> > > > > > > >> >> > > Can you give an example that shows exactly where a problem is hit?
> > > > > > > >> >> > > 
> > > > > > > >> >> > > I took a quick look at the ublk source code and didn't spot a place
> > > > > > > >> >> > > where it prevents a single ublk server process from handling multiple
> > > > > > > >> >> > > devices.
> > > > > > > >> >> > > 
> > > > > > > >> >> > > Regarding "host resources(such as tag)", can the ublk server deal with
> > > > > > > >> >> > > that in userspace? The Linux block layer doesn't have the concept of a
> > > > > > > >> >> > > "host", that would come in at the SCSI/NVMe level that's implemented in
> > > > > > > >> >> > > userspace.
> > > > > > > >> >> > > 
> > > > > > > >> >> > > I don't understand yet...
> > > > > > > >> >> > 
> > > > > > > >> >> > blk_mq_tag_set is embedded into driver host structure, and referred by queue
> > > > > > > >> >> > via q->tag_set, both scsi and nvme allocates tag in host/queue wide,
> > > > > > > >> >> > that said all LUNs/NSs share host/queue tags, current every ublk
> > > > > > > >> >> > device is independent, and can't shard tags.
> > > > > > > >> >> 
> > > > > > > >> >> Does this actually prevent ublk servers with multiple ublk devices or is
> > > > > > > >> >> it just sub-optimal?
> > > > > > > >> >
> > > > > > > >> > It is former, ublk can't support multiple devices which share single host
> > > > > > > >> > because duplicated tag can be seen in host side, then io is failed.
> > > > > > > >> >
> > > > > > > >> 
> > > > > > > >> I have trouble following this discussion. Why can we not handle multiple
> > > > > > > >> block devices in a single ublk user space process?
> > > > > > > >> 
> > > > > > > >> From this conversation it seems that the limiting factor is allocation
> > > > > > > >> of the tag set of the virtual device in the kernel? But as far as I can
> > > > > > > >> tell, the tag sets are allocated per virtual block device in
> > > > > > > >> `ublk_ctrl_add_dev()`?
> > > > > > > >> 
> > > > > > > >> It seems to me that a single ublk user space process shuld be able to
> > > > > > > >> connect to multiple storage devices (for instance nvme-of) and then
> > > > > > > >> create a ublk device for each namespace, all from a single ublk process.
> > > > > > > >> 
> > > > > > > >> Could you elaborate on why this is not possible?
> > > > > > > >
> > > > > > > > If the multiple storages devices are independent, the current ublk can
> > > > > > > > handle them just fine.
> > > > > > > >
> > > > > > > > But if these storage devices(such as luns in iscsi, or NSs in nvme-tcp)
> > > > > > > > share single host, and use host-wide tagset, the current interface can't
> > > > > > > > work as expected, because tags is shared among all these devices. The
> > > > > > > > current ublk interface needs to be extended for covering this case.
> > > > > > > 
> > > > > > > Thanks for clarifying, that is very helpful.
> > > > > > > 
> > > > > > > Follow up question: What would the implications be if one tried to
> > > > > > > expose (through ublk) each nvme namespace of an nvme-of controller with
> > > > > > > an independent tag set?
> > > > > > 
> > > > > > https://lore.kernel.org/linux-block/877cwhrgul.fsf@metaspace.dk/T/#m57158db9f0108e529d8d62d1d56652c52e9e3e67
> > > > > > 
> > > > > > > What are the benefits of sharing a tagset across
> > > > > > > all namespaces of a controller?
> > > > > > 
> > > > > > The userspace implementation can be simplified a lot since generic
> > > > > > shared tag allocation isn't needed, meantime with good performance
> > > > > > (shared tags allocation in SMP is one hard problem)
> > > > > 
> > > > > In NVMe, tags are per Submission Queue. AFAIK there's no such thing as
> > > > > shared tags across multiple SQs in NVMe. So userspace doesn't need an
> > > > 
> > > > In reality the max supported nr_queues of nvme is often much less than
> > > > nr_cpu_ids, for example, lots of nvme-pci devices just support at most
> > > > 32 queues, I remembered that Azure nvme supports less(just 8 queues).
> > > > That is because queue isn't free in both software and hardware, which
> > > > implementation is often tradeoff between performance and cost.
> > > 
> > > I didn't say that the ublk server should have nr_cpu_ids threads. I
> > > thought the idea was the ublk server creates as many threads as it needs
> > > (e.g. max 8 if the Azure NVMe device only has 8 queues).
> > > 
> > > Do you expect ublk servers to have nr_cpu_ids threads in all/most cases?
> > 
> > No.
> > 
> > In ublksrv project, each pthread maps to one unique hardware queue, so total
> > number of pthread is equal to nr_hw_queues.
> 
> Good, I think we agree on that part.
> 
> Here is a summary of the ublk server model I've been describing:
> 1. Each pthread has a separate io_uring context.
> 2. Each pthread has its own hardware submission queue (NVMe SQ, SCSI
>    command queue, etc).
> 3. Each pthread has a distinct subrange of the tag space if the tag
>    space is shared across hardware submission queues.
> 4. Each pthread allocates tags from its subrange without coordinating
>    with other threads. This is cheap and simple.

That is also not doable.

The tag space can be pretty small, such as, usb-storage queue depth
is just 1, and usb card reader can support multi lun too.

That is just one extreme example, but there can be more low queue depth
scsi devices(sata : 32, ...), typical nvme/pci queue depth is 1023, but
there could be some implementation with less.

More importantly subrange could waste lots of tags for idle LUNs/NSs, and
active LUNs/NSs will have to suffer from the small subrange tags. And available
tags depth represents the max allowed in-flight block IOs, so performance
is affected a lot by subrange.

If you look at block layer tag allocation change history, we never take
such way.


Thanks, 
Ming

