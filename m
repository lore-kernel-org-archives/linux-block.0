Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33745 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbdC2CEi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2017 22:04:38 -0400
Received: by mail-pg0-f66.google.com with SMTP id 79so686827pgf.0
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2017 19:04:37 -0700 (PDT)
Date: Wed, 29 Mar 2017 10:04:26 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] block-mq: don't re-queue if we get a queue error
Message-ID: <20170329020421.GA4341@ming.t460p>
References: <1490733472-3088-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490733472-3088-1-git-send-email-jbacik@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Mar 28, 2017 at 04:37:52PM -0400, Josef Bacik wrote:
> When try to issue a request directly and we fail we will requeue the
> request, but call blk_mq_end_request() as well.  This leads to the
> completed request being on a queuelist and getting ended twice, which
> causes list corruption in schedulers and other shenanigans.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>
> ---
>  block/blk-mq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 08a49c6..c5a6985 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1457,8 +1457,6 @@ static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie,
>  		return;
>  	}
>  
> -	__blk_mq_requeue_request(rq);
> -
>  	if (ret == BLK_MQ_RQ_QUEUE_ERROR) {
>  		*cookie = BLK_QC_T_NONE;
>  		rq->errors = -EIO;
> @@ -1466,6 +1464,7 @@ static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie,
>  		return;
>  	}
>  
> +	__blk_mq_requeue_request(rq);
>  insert:
>  	blk_mq_sched_insert_request(rq, false, true, false, may_sleep);
>  }

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

-- 
Ming
