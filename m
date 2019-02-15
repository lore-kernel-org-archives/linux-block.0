Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F99C4360F
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 02:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B6621B1A
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 02:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbfBOCBG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:01:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfBOCBF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 21:01:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A35AFC0AC371;
        Fri, 15 Feb 2019 02:01:03 +0000 (UTC)
Received: from ming.t460p (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EA8A5D6B6;
        Fri, 15 Feb 2019 02:00:55 +0000 (UTC)
Date:   Fri, 15 Feb 2019 10:00:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH V2] blk-mq: insert rq with DONTPREP to hctx dispatch list
 when requeue
Message-ID: <20190215020049.GA21045@ming.t460p>
References: <1549936585-1702-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549936585-1702-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 15 Feb 2019 02:01:04 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 12, 2019 at 09:56:25AM +0800, Jianchao Wang wrote:
> When requeue, if RQF_DONTPREP, rq has contained some driver
> specific data, so insert it to hctx dispatch list to avoid any
> merge. Take scsi as example, here is the trace event log (no
> io scheduler, because RQF_STARTED would prevent merging),
> 
>    kworker/0:1H-339   [000] ...1  2037.209289: block_rq_insert: 8,0 R 4096 () 32768 + 8 [kworker/0:1H]
> scsi_inert_test-1987  [000] ....  2037.220465: block_bio_queue: 8,0 R 32776 + 8 [scsi_inert_test]
> scsi_inert_test-1987  [000] ...2  2037.220466: block_bio_backmerge: 8,0 R 32776 + 8 [scsi_inert_test]
>    kworker/0:1H-339   [000] ....  2047.220913: block_rq_issue: 8,0 R 8192 () 32768 + 16 [kworker/0:1H]
> scsi_inert_test-1996  [000] ..s1  2047.221007: block_rq_complete: 8,0 R () 32768 + 8 [0]
> scsi_inert_test-1996  [000] .Ns1  2047.221045: block_rq_requeue: 8,0 R () 32776 + 8 [0]
>    kworker/0:1H-339   [000] ...1  2047.221054: block_rq_insert: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
>    kworker/0:1H-339   [000] ...1  2047.221056: block_rq_issue: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
> scsi_inert_test-1986  [000] ..s1  2047.221119: block_rq_complete: 8,0 R () 32776 + 8 [0]
> 
> (32768 + 8) was requeued by scsi_queue_insert and had RQF_DONTPREP.

scsi_mq_requeue_cmd() does uninit the request before requeuing, but
__scsi_queue_insert doesn't do that.


> Then it was merged with (32776 + 8) and issued. Due to RQF_DONTPREP,
> the sdb only contained the part of (32768 + 8), then only that part
> was completed. The lucky thing was that scsi_io_completion detected
> it and requeued the remaining part. So we didn't get corrupted data.
> However, the requeue of (32776 + 8) is not expected.
> 
> Suggested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
> V2:
>  - refactor the code based on Jens' suggestion
> 
>  block/blk-mq.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8f5b533..9437a5e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -737,12 +737,20 @@ static void blk_mq_requeue_work(struct work_struct *work)
>  	spin_unlock_irq(&q->requeue_lock);
>  
>  	list_for_each_entry_safe(rq, next, &rq_list, queuelist) {
> -		if (!(rq->rq_flags & RQF_SOFTBARRIER))
> +		if (!(rq->rq_flags & (RQF_SOFTBARRIER | RQF_DONTPREP)))
>  			continue;
>  
>  		rq->rq_flags &= ~RQF_SOFTBARRIER;
>  		list_del_init(&rq->queuelist);
> -		blk_mq_sched_insert_request(rq, true, false, false);
> +		/*
> +		 * If RQF_DONTPREP, rq has contained some driver specific
> +		 * data, so insert it to hctx dispatch list to avoid any
> +		 * merge.
> +		 */
> +		if (rq->rq_flags & RQF_DONTPREP)
> +			blk_mq_request_bypass_insert(rq, false);
> +		else
> +			blk_mq_sched_insert_request(rq, true, false, false);
>  	}

Suppose it is one WRITE request to zone device, this way might break
the order.


Thanks,
Ming
