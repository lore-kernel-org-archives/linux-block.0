Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECEFC433DF
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 14:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 724F1207BC
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 14:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgE2OnV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 10:43:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:39792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgE2OnV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 10:43:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E1377B244;
        Fri, 29 May 2020 14:43:19 +0000 (UTC)
Date:   Fri, 29 May 2020 16:41:39 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 8/8] blk-mq: drain I/O when all CPUs in a hctx are offline
Message-ID: <20200529144139.wg7qe55kkicvi6vw@beryllium.lan>
References: <20200529135315.199230-1-hch@lst.de>
 <20200529135315.199230-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529135315.199230-9-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 29, 2020 at 03:53:15PM +0200, Christoph Hellwig wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> Most of blk-mq drivers depend on managed IRQ's auto-affinity to setup
> up queue mapping. Thomas mentioned the following point[1]:
> 
> "That was the constraint of managed interrupts from the very beginning:
> 
>  The driver/subsystem has to quiesce the interrupt line and the associated
>  queue _before_ it gets shutdown in CPU unplug and not fiddle with it
>  until it's restarted by the core when the CPU is plugged in again."
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

Reviewed-by: Daniel Wagner <dwagner@suse.de>
