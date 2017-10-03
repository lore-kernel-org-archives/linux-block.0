Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:45625 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbdJCJUL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 05:20:11 -0400
Date: Tue, 3 Oct 2017 02:20:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Tom Nguyen <tom81094@gmail.com>, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH V5 7/8] blk-mq-sched: refactor blk_mq_sched_try_merge()
Message-ID: <20171003092010.GE2771@infradead.org>
References: <20170930112655.31451-1-ming.lei@redhat.com>
 <20170930112655.31451-8-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170930112655.31451-8-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> +bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
> +		struct request **merged_request)
> +{
> +	struct request *rq;
> +	enum elv_merge type = elv_merge(q, &rq, bio);
> +
> +	return __blk_mq_try_merge(q, bio, merged_request, rq, type);
> +}
>  EXPORT_SYMBOL_GPL(blk_mq_sched_try_merge);

This only has two callers, just open code it and rename __blk_mq_try_merge
to blk_mq_try_merge.
