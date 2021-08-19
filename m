Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C87CC4338F
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 22:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FFAC60462
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 22:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbhHSWjw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Aug 2021 18:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53484 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236811AbhHSWjq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Aug 2021 18:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629412749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WvW8FSkVp/VZ7wZBkabn/sUX6jEw55BCyhO8wvyuUhg=;
        b=LaAbbwyilh04Cog6OEPZ9tRhkNmzMj1/AMqfpQybA7aR9yrbyHIXtPpXSwSAoSGhzH6D0c
        fFuqstaHAfgC6iiVF+0vGnYEi1IDDNaztp2IOexTIbV9o1N/b2d5pC9n8e7aagAZfHCCW0
        fMyjaSpn4k55PPwYcmkIGfbdf3e7ZGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-bq2_hmHiNNCr_P7CtL99bg-1; Thu, 19 Aug 2021 18:39:05 -0400
X-MC-Unique: bq2_hmHiNNCr_P7CtL99bg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54AD2801B3D;
        Thu, 19 Aug 2021 22:39:04 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 13F4760938;
        Thu, 19 Aug 2021 22:38:55 +0000 (UTC)
Date:   Fri, 20 Aug 2021 06:38:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH V7 0/3] blk-mq: fix blk_mq_alloc_request_hctx
Message-ID: <YR7demOSG6MKFVAF@T590>
References: <20210818144428.896216-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818144428.896216-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 18, 2021 at 10:44:25PM +0800, Ming Lei wrote:
> Hi,
> 
> blk_mq_alloc_request_hctx() is used by NVMe fc/rdma/tcp/loop to connect
> io queue. Also the sw ctx is chosen as the 1st online cpu in hctx->cpumask.
> However, all cpus in hctx->cpumask may be offline.
> 
> This usage model isn't well supported by blk-mq which supposes allocator is
> always done on one online CPU in hctx->cpumask. This assumption is
> related with managed irq, which also requires blk-mq to drain inflight
> request in this hctx when the last cpu in hctx->cpumask is going to
> offline.
> 
> However, NVMe fc/rdma/tcp/loop don't use managed irq, so we should allow
> them to ask for request allocation when the specified hctx is inactive
> (all cpus in hctx->cpumask are offline). Fix blk_mq_alloc_request_hctx() by
> allowing to allocate request when all CPUs of this hctx are offline.
> 
> Wen Xiong has verified V4 in her nvmef test.
> 
> V7:
> 	- move blk_mq_hctx_use_managed_irq() into block/blk-mq.c, 3/3

Hello Jens,

NVMe TCP and others have been a bit popular recent days, and the kernel panic
of blk_mq_alloc_request_hctx() has annoyed people for a bit long.

Any chance to pull the three patches in so we can fix them in 5.15?


Thanks,
Ming

