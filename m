Return-Path: <SRS0=2dDp=UK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A103BC4321A
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 08:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750EF212F5
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 08:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404451AbfFKIKU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:10:20 -0400
Received: from verein.lst.de ([213.95.11.211]:49030 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404073AbfFKIKT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jun 2019 04:10:19 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6BC0968B02; Tue, 11 Jun 2019 10:09:51 +0200 (CEST)
Date:   Tue, 11 Jun 2019 10:09:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 1/2] blk-mq: Remove blk_mq_put_ctx()
Message-ID: <20190611080951.GC21815@lst.de>
References: <20190604181736.903-1-bvanassche@acm.org> <20190604181736.903-2-bvanassche@acm.org> <20190608081907.GB19573@lst.de> <8b179799-5381-1b47-1793-f1fd39726d49@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b179799-5381-1b47-1793-f1fd39726d49@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 10, 2019 at 03:00:39PM -0700, Bart Van Assche wrote:
> On 6/8/19 1:19 AM, Christoph Hellwig wrote:
>> On Tue, Jun 04, 2019 at 11:17:35AM -0700, Bart Van Assche wrote:
>>> No code that occurs between blk_mq_get_ctx() and blk_mq_put_ctx() depends
>>> on preemption being disabled for its correctness. Since removing the CPU
>>> preemption calls does not measurably affect performance, simplify the
>>> blk-mq code by removing the blk_mq_put_ctx() function and also by not
>>> disabling preemption in blk_mq_get_ctx().
>>
>> I like the idea behinds this, but I think it makes some small issues
>> we have in the current code even worse.  As far as I can tell the idea
>> behind this call was that we operate on the same blk_mq_ctx for the
>> duration of the I/O submission.  Now it should not matter which one,
>> that is we don't care if we get preempted, but it should stay the same.
>
> Hi Christoph,
>
> Can you clarify this? Isn't the goal of the rq->mq_ctx = data->ctx 
> assignment in blk_mq_rq_ctx_init() to ensure that the same blk_mq_ctx is 
> used during I/O submission?

Yes.  But we still have additional blk_mq_get_ctx calls that I was
concerned about.  But looking deeper it seems like the additional ones are
just used locally for I/O scheduler merge decisions, and we should be ok
even if the context changes due to a preemption between the failed merge
and the request allocation.  That being said it would still be nice
to pass the ctx from __blk_mq_sched_bio_merge to ->bio_merge instead
of having to find it again in kyber_bio_merge, but that isn't urgent.
