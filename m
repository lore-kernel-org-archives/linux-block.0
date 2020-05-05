Return-Path: <SRS0=vpK8=6T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88997C47254
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 15:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DEA6206B9
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 15:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbgEEPqY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 May 2020 11:46:24 -0400
Received: from verein.lst.de ([213.95.11.211]:35998 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729666AbgEEPqY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 May 2020 11:46:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 95D2268C4E; Tue,  5 May 2020 17:46:19 +0200 (CEST)
Date:   Tue, 5 May 2020 17:46:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200505154618.GA3644@lst.de>
References: <20200428155837.GA16910@hirez.programming.kicks-ass.net> <20200429021612.GD671522@T590> <20200429080728.GB29143@willie-the-truck> <20200429094616.GB700644@T590> <20200429122757.GA30247@willie-the-truck> <20200429134327.GC700644@T590> <20200429173400.GC30247@willie-the-truck> <20200430003945.GA719313@T590> <20200430110429.GI19932@willie-the-truck> <20200430140254.GA996887@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430140254.GA996887@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 30, 2020 at 10:02:54PM +0800, Ming Lei wrote:
> BLK_MQ_S_INACTIVE is only set when the last cpu of this hctx is becoming
> offline, and blk_mq_hctx_notify_offline() is called from cpu hotplug
> handler. So if there is any request of this hctx submitted from somewhere,
> it has to this last cpu. That is done by blk-mq's queue mapping.
> 
> In case of direct issue, basically blk_mq_get_driver_tag() is run after
> the request is allocated, that is why I mentioned the chance of
> migration is very small.

"very small" does not cut it, it has to be zero.  And it seems the
new version still has this hack.
