Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAD9C636D4
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 00:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjBPAsE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 19:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBPAsB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 19:48:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC8B4392A
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 16:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676508433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JUvfgxsf4TeRb59XW8MDOggP0AHXEWYoDfxlWYYBVr8=;
        b=Dk2SpK53y8S11WECk5CajCN6PGjvsHF47nTGe/1YExu4Xk8kCM9zZbv8/di5lQr/czRlnJ
        nyovwQ3xJyueZv/Y2v7MRRAiLUptFvgbSWIyDrqXuOepqFWp6WfrBbJwMHvBYOUFnD8+Hs
        c5PK2ySjGRv1ardLJnYHS3XjNCyDx88=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-VEyrp28-NI-5HuEoXaRYFw-1; Wed, 15 Feb 2023 19:47:10 -0500
X-MC-Unique: VEyrp28-NI-5HuEoXaRYFw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED81A802C16;
        Thu, 16 Feb 2023 00:47:09 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A8CAE4010E83;
        Thu, 16 Feb 2023 00:47:02 +0000 (UTC)
Date:   Thu, 16 Feb 2023 08:46:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Jim Harris <james.r.harris@intel.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        "hch@lst.de" <hch@lst.de>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [LSF/MM/BPF BoF]: extend UBLK to cover real storage hardware
Message-ID: <Y+19AM8zuU9+abQS@T590>
References: <Y+EWCwqSisu3l0Sz@T590>
 <Y+Finej8521IDwzV@fedora>
 <Y+MFAzt0Cx9aetf2@T590>
 <Y+OSxh2K0/Lf0SAk@fedora>
 <Y+my03K5MbSSRvQq@T590>
 <Y+qL9z7rtApszoBf@fedora>
 <Y+wsj2QqX+HMUJTI@T590>
 <Y+z5yzrOhq2nbV/A@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+z5yzrOhq2nbV/A@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 15, 2023 at 10:27:07AM -0500, Stefan Hajnoczi wrote:
> On Wed, Feb 15, 2023 at 08:51:27AM +0800, Ming Lei wrote:
> > On Mon, Feb 13, 2023 at 02:13:59PM -0500, Stefan Hajnoczi wrote:
> > > On Mon, Feb 13, 2023 at 11:47:31AM +0800, Ming Lei wrote:
> > > > On Wed, Feb 08, 2023 at 07:17:10AM -0500, Stefan Hajnoczi wrote:
> > > > > On Wed, Feb 08, 2023 at 10:12:19AM +0800, Ming Lei wrote:
> > > > > > On Mon, Feb 06, 2023 at 03:27:09PM -0500, Stefan Hajnoczi wrote:
> > > > > > > On Mon, Feb 06, 2023 at 11:00:27PM +0800, Ming Lei wrote:
> > > > > > > > Hello,
> > > > > > > > 
> > > > > > > > So far UBLK is only used for implementing virtual block device from
> > > > > > > > userspace, such as loop, nbd, qcow2, ...[1].
> > > > > > > 
> > > > > > > I won't be at LSF/MM so here are my thoughts:
> > > > > > 
> > > > > > Thanks for the thoughts, :-)
> > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > It could be useful for UBLK to cover real storage hardware too:
> > > > > > > > 
> > > > > > > > - for fast prototype or performance evaluation
> > > > > > > > 
> > > > > > > > - some network storages are attached to host, such as iscsi and nvme-tcp,
> > > > > > > > the current UBLK interface doesn't support such devices, since it needs
> > > > > > > > all LUNs/Namespaces to share host resources(such as tag)
> > > > > > > 
> > > > > > > Can you explain this in more detail? It seems like an iSCSI or
> > > > > > > NVMe-over-TCP initiator could be implemented as a ublk server today.
> > > > > > > What am I missing?
> > > > > > 
> > > > > > The current ublk can't do that yet, because the interface doesn't
> > > > > > support multiple ublk disks sharing single host, which is exactly
> > > > > > the case of scsi and nvme.
> > > > > 
> > > > > Can you give an example that shows exactly where a problem is hit?
> > > > > 
> > > > > I took a quick look at the ublk source code and didn't spot a place
> > > > > where it prevents a single ublk server process from handling multiple
> > > > > devices.
> > > > > 
> > > > > Regarding "host resources(such as tag)", can the ublk server deal with
> > > > > that in userspace? The Linux block layer doesn't have the concept of a
> > > > > "host", that would come in at the SCSI/NVMe level that's implemented in
> > > > > userspace.
> > > > > 
> > > > > I don't understand yet...
> > > > 
> > > > blk_mq_tag_set is embedded into driver host structure, and referred by queue
> > > > via q->tag_set, both scsi and nvme allocates tag in host/queue wide,
> > > > that said all LUNs/NSs share host/queue tags, current every ublk
> > > > device is independent, and can't shard tags.
> > > 
> > > Does this actually prevent ublk servers with multiple ublk devices or is
> > > it just sub-optimal?
> > 
> > It is former, ublk can't support multiple devices which share single host
> > because duplicated tag can be seen in host side, then io is failed.
> 
> The kernel sees two independent block devices so there is no issue
> within the kernel.

This way either wastes memory, or performance is bad since we can't
make a perfect queue depth for each ublk device.

> 
> Userspace can do its own hw tag allocation if there are shared storage
> controller resources (e.g. NVMe CIDs) to avoid duplicating tags.
> 
> Have I missed something?

Please look at lib/sbitmap.c and block/blk-mq-tag.c and see how many
hard issues fixed/reported in the past, and how much optimization done
in this area.

In theory hw tag allocation can be done in userspace, but just hard to
do efficiently:

1) it has been proved as one hard task for sharing data efficiently in
SMP, so don't reinvent wheel in userspace, and this work could take
much more efforts than extending current ublk interface, and just
fruitless

2) two times tag allocation slows down io path much

2) even worse for userspace allocation, cause task can be killed and
no cleanup is done, so tag leak can be caused easily


Thanks, 
Ming

