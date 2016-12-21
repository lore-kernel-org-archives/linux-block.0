Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60146 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752586AbcLUCWd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Dec 2016 21:22:33 -0500
Date: Tue, 20 Dec 2016 19:22:29 -0700
From: Jens Axboe <axboe@fb.com>
To: Paolo Valente <paolo.valente@linaro.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <osandov@fb.com>
Subject: Re: [PATCH 6/8] blk-mq-sched: add framework for MQ capable IO
 schedulers
Message-ID: <20161221022229.GA21762@kernel.dk>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
 <1481933536-12844-7-git-send-email-axboe@fb.com>
 <4A1753A0-121C-4A01-8821-6CDD99C98896@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4A1753A0-121C-4A01-8821-6CDD99C98896@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Dec 20 2016, Paolo Valente wrote:
> > +	else
> > +		rq = __blk_mq_alloc_request(data, op);
> > +
> > +	if (rq) {
> > +		rq->elv.icq = NULL;
> > +		if (e && e->type->icq_cache)
> > +			blk_mq_sched_assign_ioc(q, rq, bio);
> 
> bfq needs rq->elv.icq to be consistent in bfq_get_request, but the
> needed initialization seems to occur only after mq.get_request is
> invoked.

Can you do it from get/put_rq_priv? The icq is assigned there. If not,
we can redo this part, not a big deal.

-- 
Jens Axboe

