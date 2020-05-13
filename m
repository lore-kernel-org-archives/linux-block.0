Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6EAC2D0F8
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 06:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 575C9206A5
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 06:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgEMGgA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 02:36:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:43396 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbgEMGgA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 02:36:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3C8E8AB5C;
        Wed, 13 May 2020 06:36:01 +0000 (UTC)
Subject: Re: [PATCH V11 06/12] blk-mq: prepare for draining IO when hctx's all
 CPUs are offline
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200513034803.1844579-1-ming.lei@redhat.com>
 <20200513034803.1844579-7-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <3994d91e-9f17-8c8f-eb6b-6ad22db44cf9@suse.de>
Date:   Wed, 13 May 2020 08:35:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513034803.1844579-7-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/13/20 5:47 AM, Ming Lei wrote:
> Most of blk-mq drivers depend on managed IRQ's auto-affinity to setup
> up queue mapping. Thomas mentioned the following point[1]:
> 
> "
>   That was the constraint of managed interrupts from the very beginning:
> 
>    The driver/subsystem has to quiesce the interrupt line and the associated
>    queue _before_ it gets shutdown in CPU unplug and not fiddle with it
>    until it's restarted by the core when the CPU is plugged in again.
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
> 
> [1] https://lore.kernel.org/linux-block/alpine.DEB.2.21.1904051331270.1802@nanos.tec.linutronix.de/
> 
> Cc: John Garry <john.garry@huawei.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-debugfs.c     |  1 +
>   block/blk-mq.c             | 19 +++++++++++++++++++
>   drivers/block/loop.c       |  2 +-
>   drivers/md/dm-rq.c         |  2 +-
>   include/linux/blk-mq.h     |  4 ++++
>   include/linux/cpuhotplug.h |  1 +
>   6 files changed, 27 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
