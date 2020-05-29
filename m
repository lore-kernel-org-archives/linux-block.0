Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A485C433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 14:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 138BF20814
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 14:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgE2Oei (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 10:34:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:36186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbgE2Oei (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 10:34:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 36293AC24;
        Fri, 29 May 2020 14:34:36 +0000 (UTC)
Subject: Re: [PATCH 8/8] blk-mq: drain I/O when all CPUs in a hctx are offline
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200529135315.199230-1-hch@lst.de>
 <20200529135315.199230-9-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <5dd32259-420c-d92b-e4bc-c7141f0ac466@suse.de>
Date:   Fri, 29 May 2020 16:34:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529135315.199230-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/29/20 3:53 PM, Christoph Hellwig wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> Most of blk-mq drivers depend on managed IRQ's auto-affinity to setup
> up queue mapping. Thomas mentioned the following point[1]:
> 
> "That was the constraint of managed interrupts from the very beginning:
> 
>   The driver/subsystem has to quiesce the interrupt line and the associated
>   queue _before_ it gets shutdown in CPU unplug and not fiddle with it
>   until it's restarted by the core when the CPU is plugged in again."
> 
> However, current blk-mq implementation doesn't quiesce hw queue before
> the last CPU in the hctx is shutdown.  Even worse, CPUHP_BLK_MQ_DEAD is a
> cpuhp state handled after the CPU is down, so there isn't any chance to
> quiesce the hctx before shutting down the CPU.
> 
> Add new CPUHP_AP_BLK_MQ_ONLINE state to stop allocating from blk-mq hctxs
> where the last CPU goes away, and wait for completion of in-flight
> requests.  This guarantees that there is no inflight I/O before shutting
> down the managed IRQ.
> 
> Add a BLK_MQ_F_STACKING and set it for dm-rq and loop, so we don't need
> to wait for completion of in-flight requests from these drivers to avoid
> a potential dead-lock. It is safe to do this for stacking drivers as those
> do not use interrupts at all and their I/O completions are triggered by
> underlying devices I/O completion.
> 
> [1] https://lore.kernel.org/linux-block/alpine.DEB.2.21.1904051331270.1802@nanos.tec.linutronix.de/
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> [hch: different retry mechanism, merged two patches, minor cleanups]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq-debugfs.c     |   2 +
>   block/blk-mq-tag.c         |   8 +++
>   block/blk-mq.c             | 112 ++++++++++++++++++++++++++++++++++++-
>   drivers/block/loop.c       |   2 +-
>   drivers/md/dm-rq.c         |   2 +-
>   include/linux/blk-mq.h     |  10 ++++
>   include/linux/cpuhotplug.h |   1 +
>   7 files changed, 133 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
