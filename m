Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9A3C2D0EA
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 12:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996A720747
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 12:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgDHMkU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:40:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:34688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgDHMkU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Apr 2020 08:40:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AD03DADD6;
        Wed,  8 Apr 2020 12:40:18 +0000 (UTC)
Date:   Wed, 8 Apr 2020 14:40:17 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V6 0/8] blk-mq: improvement CPU hotplug
Message-ID: <20200408124017.g6wizq5bljzwb2gq@beryllium.lan>
References: <20200407092901.314228-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407092901.314228-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On Tue, Apr 07, 2020 at 05:28:53PM +0800, Ming Lei wrote:
> Hi,
> 
> Thomas mentioned:
>     "
>      That was the constraint of managed interrupts from the very beginning:
>     
>       The driver/subsystem has to quiesce the interrupt line and the associated
>       queue _before_ it gets shutdown in CPU unplug and not fiddle with it
>       until it's restarted by the core when the CPU is plugged in again.
>     "
> 
> But no drivers or blk-mq do that before one hctx becomes inactive(all
> CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
> to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().
> 
> This patchset tries to address the issue by two stages:
> 
> 1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE
> 
> - mark the hctx as internal stopped, and drain all in-flight requests
> if the hctx is going to be dead.
> 
> 2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx becomes dead
> 
> - steal bios from the request, and resubmit them via generic_make_request(),
> then these IO will be mapped to other live hctx for dispatch
> 
> Please comment & review, thanks!

FWIW, I've stress test this series by running the stress-cpu-hotplug
with a fio workload in the background. Nothing exploded, all just
worked fine.

Thanks,
Daniel
