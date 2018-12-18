Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3043C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 08:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6040217D8
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 08:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeLRI1t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:27:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:43482 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbeLRI1s (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 03:27:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 54B2AAE15;
        Tue, 18 Dec 2018 08:27:46 +0000 (UTC)
Subject: Re: [PATCH V2] blk-mq: Set request mapping to NULL in
 blk_mq_put_driver_tag
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-scsi <linux-scsi@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <CAHsXFKHSjBHZy9tyhdEjYJcLJeE6SqdeBPcoeq=bCaRfzvMqgw@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <026c7a6d-7963-787f-80c1-a389dd6b4110@suse.de>
Date:   Tue, 18 Dec 2018 09:27:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAHsXFKHSjBHZy9tyhdEjYJcLJeE6SqdeBPcoeq=bCaRfzvMqgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/18/18 8:08 AM, Kashyap Desai wrote:
> V1 -> V2
> Added fix in __blk_mq_finish_request around blk_mq_put_tag() for
> non-internal tags
> 
> Problem statement :
> Whenever try to get outstanding request via scsi_host_find_tag,
> block layer will return stale entries instead of actual outstanding
> request. Kernel panic if stale entry is inaccessible or memory is reused.
> Fix :
> Undo request mapping in blk_mq_put_driver_tag  nce request is return.
> 
> More detail :
> Whenever each SDEV entry is created, block layer allocate separate tags
> and static requestis.Those requests are not valid after SDEV is deleted
> from the system. On the fly, block layer maps static rqs to rqs as below
> from blk_mq_get_driver_tag()
> 
> data.hctx->tags->rqs[rq->tag] = rq;
> 
> Above mapping is active in-used requests and it is the same mapping which
> is referred in function scsi_host_find_tag().
> After running some IOs, “data.hctx->tags->rqs[rq->tag]” will have some
> entries which will never be reset in block layer.
> 
> There would be a kernel panic, If request pointing to
> “data.hctx->tags->rqs[rq->tag]” is part of “sdev” which is removed
> and as part of that all the memory allocation of request associated with
> that sdev might be reused or inaccessible to the driver.
> Kernel panic snippet -
> 
> BUG: unable to handle kernel paging request at ffffff8000000010
> IP: [<ffffffffc048306c>] mpt3sas_scsih_scsi_lookup_get+0x6c/0xc0 [mpt3sas]
> PGD aa4414067 PUD 0
> Oops: 0000 [#1] SMP
> Call Trace:
>   [<ffffffffc046f72f>] mpt3sas_get_st_from_smid+0x1f/0x60 [mpt3sas]
>   [<ffffffffc047e125>] scsih_shutdown+0x55/0x100 [mpt3sas]
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> 
> ---
>   block/blk-mq.c | 4 +++-
>   block/blk-mq.h | 1 +
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 6a75662..88d1e92 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -477,8 +477,10 @@ static void __blk_mq_free_request(struct request *rq)
>       const int sched_tag = rq->internal_tag;
> 
>       blk_pm_mark_last_busy(rq);
> -    if (rq->tag != -1)
> +    if (rq->tag != -1) {
> +        hctx->tags->rqs[rq->tag] = NULL;
>           blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
> +    }
>       if (sched_tag != -1)
>           blk_mq_put_tag(hctx, hctx->sched_tags, ctx, sched_tag);
>       blk_mq_sched_restart(hctx);
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 9497b47..57432be 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -175,6 +175,7 @@ static inline bool
> blk_mq_get_dispatch_budget(struct blk_mq_hw_ctx *hctx)
>   static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
>                          struct request *rq)
>   {
> +    hctx->tags->rqs[rq->tag] = NULL;
>       blk_mq_put_tag(hctx, hctx->tags, rq->mq_ctx, rq->tag);
>       rq->tag = -1;
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
