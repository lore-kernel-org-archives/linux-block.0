Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775BDC47076
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 11:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B790206CC
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 11:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgEML7e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 07:59:34 -0400
Received: from verein.lst.de ([213.95.11.211]:46074 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728275AbgEML7e (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 07:59:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8AAA268BEB; Wed, 13 May 2020 13:59:32 +0200 (CEST)
Date:   Wed, 13 May 2020 13:59:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V11 07/12] blk-mq: stop to handle IO and drain IO
 before hctx becomes inactive
Message-ID: <20200513115932.GC6297@lst.de>
References: <20200513034803.1844579-1-ming.lei@redhat.com> <20200513034803.1844579-8-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513034803.1844579-8-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	if (unlikely(direct_issue && rq->mq_ctx->cpu != raw_smp_processor_id()))
> +		smp_mb();
> +	else
> +		barrier();

Independ of the fact that I still think this is horrible and hacky,
I also still don't see what the barrier() is trying to help with.
