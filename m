Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C9DC54FD0
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 15:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C38420661
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 15:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgD0PgF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:36:05 -0400
Received: from verein.lst.de ([213.95.11.211]:49160 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgD0PgF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 11:36:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B5DFA68C7B; Mon, 27 Apr 2020 17:36:01 +0200 (CEST)
Date:   Mon, 27 Apr 2020 17:36:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        peterz@infradead.org, paulmck@kernel.org
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200427153601.GA7802@lst.de>
References: <20200424102351.475641-1-ming.lei@redhat.com> <20200424102351.475641-8-ming.lei@redhat.com> <20200424103851.GD28156@lst.de> <20200425031723.GC477579@T590> <20200425083224.GA5634@lst.de> <20200425093437.GA495669@T590> <20200425095351.GC495669@T590> <20200425154832.GA16004@lst.de> <20200426020621.GA511475@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200426020621.GA511475@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 26, 2020 at 10:06:21AM +0800, Ming Lei wrote:
> On Sat, Apr 25, 2020 at 05:48:32PM +0200, Christoph Hellwig wrote:
> > FYI, here is what I think we should be doing (but the memory model
> > experts please correct me):
> > 
> >  - just drop the direct_issue flag and check for the CPU, which is
> >    cheap enough
> 
> That isn't correct because the CPU for running async queue may not be
> same with rq->mq_ctx->cpu since hctx->cpumask may include several CPUs
> and we run queue in RR style and it is really a normal case.

But in that case the memory barrier really doesn't matter anywaẏ.
