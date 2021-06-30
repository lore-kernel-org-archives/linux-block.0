Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9439C11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 09:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8552961D0F
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 09:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhF3J4G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 05:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233886AbhF3J4G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 05:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625046817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G1jcyIcuOwid1D4ZqnIUSCi/ESSvGmWyjdqcJ9jWniU=;
        b=D2W51glYAQG2AawQTVmHuWokMb7D5Zgbg1Mnq5ljE5XJxTF5PV6/LfpRz8ekUmh482oelT
        ZfpVT79iMTfW4h3k4Kbq+huhYOWCiNofiGrDU9+yqm4WKSqSJy9qgtJsgZlh0QpiYRdwVk
        iwGqcIADulvGrEII1XbE2KTFHoToPuk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-3HWoy5mqOs6L_mFKg33hfw-1; Wed, 30 Jun 2021 05:53:34 -0400
X-MC-Unique: 3HWoy5mqOs6L_mFKg33hfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 941C6804141;
        Wed, 30 Jun 2021 09:53:32 +0000 (UTC)
Received: from T590 (ovpn-12-133.pek2.redhat.com [10.72.12.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 34134179E6;
        Wed, 30 Jun 2021 09:53:20 +0000 (UTC)
Date:   Wed, 30 Jun 2021 17:53:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/2] blk-mq: fix blk_mq_alloc_request_hctx
Message-ID: <YNw/DcxIIMeg/2VK@T590>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <5f304121-38ce-034b-2d17-93d136c77fe6@suse.de>
 <YNwug8n7qGL5uXfo@T590>
 <c1de513a-5477-9d1d-0ddc-24e9166cc717@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1de513a-5477-9d1d-0ddc-24e9166cc717@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 30, 2021 at 11:43:41AM +0200, Hannes Reinecke wrote:
> On 6/30/21 10:42 AM, Ming Lei wrote:
> > On Wed, Jun 30, 2021 at 10:18:37AM +0200, Hannes Reinecke wrote:
> > > On 6/29/21 9:49 AM, Ming Lei wrote:
> > > > Hi,
> > > > 
> > > > blk_mq_alloc_request_hctx() is used by NVMe fc/rdma/tcp/loop to connect
> > > > io queue. Also the sw ctx is chosen as the 1st online cpu in hctx->cpumask.
> > > > However, all cpus in hctx->cpumask may be offline.
> > > > 
> > > > This usage model isn't well supported by blk-mq which supposes allocator is
> > > > always done on one online CPU in hctx->cpumask. This assumption is
> > > > related with managed irq, which also requires blk-mq to drain inflight
> > > > request in this hctx when the last cpu in hctx->cpumask is going to
> > > > offline.
> > > > 
> > > > However, NVMe fc/rdma/tcp/loop don't use managed irq, so we should allow
> > > > them to ask for request allocation when the specified hctx is inactive
> > > > (all cpus in hctx->cpumask are offline).
> > > > 
> > > > Fix blk_mq_alloc_request_hctx() by adding/passing flag of
> > > > BLK_MQ_F_NOT_USE_MANAGED_IRQ.
> > > > 
> > > > 
> > > > Ming Lei (2):
> > > >     blk-mq: not deactivate hctx if the device doesn't use managed irq
> > > >     nvme: pass BLK_MQ_F_NOT_USE_MANAGED_IRQ for fc/rdma/tcp/loop
> > > > 
> > > >    block/blk-mq.c             | 6 +++++-
> > > >    drivers/nvme/host/fc.c     | 3 ++-
> > > >    drivers/nvme/host/rdma.c   | 3 ++-
> > > >    drivers/nvme/host/tcp.c    | 3 ++-
> > > >    drivers/nvme/target/loop.c | 3 ++-
> > > >    include/linux/blk-mq.h     | 1 +
> > > >    6 files changed, 14 insertions(+), 5 deletions(-)
> > > > 
> > > > Cc: Sagi Grimberg <sagi@grimberg.me>
> > > > Cc: Daniel Wagner <dwagner@suse. thede>
> > > > Cc: Wen Xiong <wenxiong@us.ibm.com>
> > > > Cc: John Garry <john.garry@huawei.com>
> > > > 
> > > > 
> > > I have my misgivings about this patchset.
> > > To my understanding, only CPUs present in the hctx cpumask are eligible to
> > > submit I/O to that hctx.
> > 
> > It is just true for managed irq, and should be CPUs online.
> > 
> > However, no such constraint for non managed irq, since irq may migrate to
> > other online CPUs if all CPUs in irq's current affinity become offline.
> > 
> 
> But there shouldn't be any I/O pending during CPU offline (cf
> blk_mq_hctx_notify_offline()), so no interrupts should be triggered, either,
> no?
> 
> > > Consequently if all cpus in that mask are offline, where is the point of
> > > even transmitting a 'connect' request?
> > 
> > nvmef requires to submit the connect request via one specified hctx
> > which index has to be same with the io queue's index.
> > 
> > Almost all nvmef drivers fail to setup controller in case of
> > connect io queue error.
> > 
> 
> And I would prefer to fix that, namely allowing blk-mq to run on a sparse
> set of io queues.
> The remaining io queues can be connected once the first cpu in the hctx
> cpumask is onlined; we already have blk_mq_hctx_notify_online(), which could
> easily be expanded to connect to relevant I/O queue...

Then you need a big patches for doing that.

> 
> > Also CPU can become offline & online, especially it is done in
> > lots of sanity test.
> > 
> 
> True, but then again all I/O on the hctx should be quiesced during cpu
> offline.

Again that is only necessary for managed irq.

> 
> > So we should allow to allocate the connect request successful, and
> > submit it to drivers given it is allowed in this way for non-managed
> > irq.
> > 
> 
> I'd rather not do this, as the 'connect' command runs on the 'normal' I/O
> tagset, and hence runs into the risk of being issues against non-existing
> CPUs.

Can you explain what the risk is?

> 
> > > Shouldn't we rather modify the tagset to only refer to the current online
> > > CPUs _only_, thereby never submit a connect request for hctx with only
> > > offline CPUs?
> > 
> > Then you may setup very less io queues, and performance may suffer even
> > though lots of CPUs become online later.
> > ;
> Only if we stay with the reduced number of I/O queues. Which is not what I'm
> proposing; I'd rather prefer to connect and disconnect queues from the cpu
> hotplug handler. For starters we could even trigger a reset once the first
> cpu within a hctx is onlined.

Yeah, that need one big/complicated patchset, but not see any advantages
over this simple approach.


Thanks,
Ming

