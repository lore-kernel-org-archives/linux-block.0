Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA44C2BA19
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 07:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B6B2076C
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 07:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgDWHbY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:31:24 -0400
Received: from verein.lst.de ([213.95.11.211]:56467 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgDWHbY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Apr 2020 03:31:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0636C68C4E; Thu, 23 Apr 2020 09:31:22 +0200 (CEST)
Date:   Thu, 23 Apr 2020 09:31:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V7 3/9] blk-mq: prepare for draining IO when hctx's all
 CPUs are offline
Message-ID: <20200423073121.GC10951@lst.de>
References: <20200418030925.31996-1-ming.lei@redhat.com> <20200418030925.31996-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418030925.31996-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 18, 2020 at 11:09:19AM +0800, Ming Lei wrote:
> Most of blk-mq drivers depend on managed IRQ's auto-affinity to setup
> up queue mapping. Thomas mentioned the following point[1]:
> 
> "
>  That was the constraint of managed interrupts from the very beginning:
> 
>   The driver/subsystem has to quiesce the interrupt line and the associated
>   queue _before_ it gets shutdown in CPU unplug and not fiddle with it
>   until it's restarted by the core when the CPU is plugged in again.
> "
> 
> However, current blk-mq implementation doesn't quiesce hw queue before
> the last CPU in the hctx is shutdown. Even worse, CPUHP_BLK_MQ_DEAD is
> one cpuhp state handled after the CPU is down, so there isn't any chance
> to quiesce hctx for blk-mq wrt. CPU hotplug.
> 
> Add new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE for blk-mq to stop queues
> and wait for completion of in-flight requests.
> 
> We will stop hw queue and wait for completion of in-flight requests
> when one hctx is becoming dead in the following patch. This way may
> cause dead-lock for some stacking blk-mq drivers, such as dm-rq and
> loop.
> 
> Add blk-mq flag of BLK_MQ_F_NO_MANAGED_IRQ and mark it for dm-rq and
> loop, so we needn't to wait for completion of in-flight requests from
> dm-rq & loop, then the potential dead-lock can be avoided.

The code here looks fine, but the split from the patches that actually
use it instead of just adding stubs first seems odd.
