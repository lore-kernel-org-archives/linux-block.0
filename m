Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E819C433DB
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 07:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B5622516
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 07:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbhAKHAw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 02:00:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:35312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbhAKHAw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 02:00:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 646AEAF48;
        Mon, 11 Jan 2021 07:00:11 +0000 (UTC)
Subject: Re: [PATCH V3 5/6] block: move three bvec helpers declaration into
 private helper
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210111030557.4154161-1-ming.lei@redhat.com>
 <20210111030557.4154161-6-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <a4c45038-fc01-af04-c9c5-f6505fbb3bd2@suse.de>
Date:   Mon, 11 Jan 2021 08:00:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210111030557.4154161-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/21 4:05 AM, Ming Lei wrote:
> bvec_alloc(), bvec_free() and bvec_nr_vecs() are only used inside block
> layer core functions, no need to declare them in public header.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk.h         | 4 ++++
>   include/linux/bio.h | 3 ---
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk.h b/block/blk.h
> index 7550364c326c..a21a35c4a3e4 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -55,6 +55,10 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
>   
>   void blk_freeze_queue(struct request_queue *q);
>   
> +struct bio_vec *bvec_alloc(gfp_t, int, unsigned long *, mempool_t *);
> +void bvec_free(mempool_t *, struct bio_vec *, unsigned int);
> +unsigned int bvec_nr_vecs(unsigned short idx);
> +
>   static inline bool biovec_phys_mergeable(struct request_queue *q,
>   		struct bio_vec *vec1, struct bio_vec *vec2)
>   {
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index f606eb1e556f..70914dd6a70d 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -478,9 +478,6 @@ static inline void zero_fill_bio(struct bio *bio)
>   	zero_fill_bio_iter(bio, bio->bi_iter);
>   }
>   
> -extern struct bio_vec *bvec_alloc(gfp_t, int, unsigned long *, mempool_t *);
> -extern void bvec_free(mempool_t *, struct bio_vec *, unsigned int);
> -extern unsigned int bvec_nr_vecs(unsigned short idx);
>   extern const char *bio_devname(struct bio *bio, char *buffer);
>   
>   #define bio_set_dev(bio, bdev) 			\
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
