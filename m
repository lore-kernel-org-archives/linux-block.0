Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40118C433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 01:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6B49235F9
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 01:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgLHBdm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Dec 2020 20:33:42 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:58658 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbgLHBdl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Dec 2020 20:33:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UHwMaed_1607391177;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UHwMaed_1607391177)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Dec 2020 09:32:58 +0800
Subject: Re: [PATCH v9] block: disable iopoll for split bio
From:   JeffleXu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com
References: <20201126091852.8588-1-jefflexu@linux.alibaba.com>
Message-ID: <a83f8e66-85fe-c4dd-d6c9-83ea489a8598@linux.alibaba.com>
Date:   Tue, 8 Dec 2020 09:32:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201126091852.8588-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

How about this patch? It has been reviewed by Christoph and Ming Lei.

-- 
Thanks,
Jeffle

On 11/26/20 5:18 PM, Jeffle Xu wrote:
> iopoll is initially for small size, latency sensitive IO. It doesn't
> work well for big IO, especially when it needs to be split to multiple
> bios. In this case, the returned cookie of __submit_bio_noacct_mq() is
> indeed the cookie of the last split bio. The completion of *this* last
> split bio done by iopoll doesn't mean the whole original bio has
> completed. Callers of iopoll still need to wait for completion of other
> split bios.
> 
> Besides bio splitting may cause more trouble for iopoll which isn't
> supposed to be used in case of big IO.
> 
> iopoll for split bio may cause potential race if CPU migration happens
> during bio submission. Since the returned cookie is that of the last
> split bio, polling on the corresponding hardware queue doesn't help
> complete other split bios, if these split bios are enqueued into
> different hardware queues. Since interrupts are disabled for polling
> queues, the completion of these other split bios depends on timeout
> mechanism, thus causing a potential hang.
> 
> iopoll for split bio may also cause hang for sync polling. Currently
> both the blkdev and iomap-based fs (ext4/xfs, etc) support sync polling
> in direct IO routine. These routines will submit bio without REQ_NOWAIT
> flag set, and then start sync polling in current process context. The
> process may hang in blk_mq_get_tag() if the submitted bio has to be
> split into multiple bios and can rapidly exhaust the queue depth. The
> process are waiting for the completion of the previously allocated
> requests, which should be reaped by the following polling, and thus
> causing a deadlock.
> 
> To avoid these subtle trouble described above, just disable iopoll for
> split bio and return BLK_QC_T_NONE in this case. The side effect is that
> non-HIPRI IO also returns BLK_QC_T_NONE now. It should be acceptable
> since the returned cookie is never used for non-HIPRI IO.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
> v9: tweak the logic of returning cookie a little considering Christoph Hellwig's suggestion
> ---
>  block/blk-merge.c | 8 ++++++++
>  block/blk-mq.c    | 5 +++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index bcf5e4580603..8a2f1fb7bb16 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -279,6 +279,14 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>  	return NULL;
>  split:
>  	*segs = nsegs;
> +
> +	/*
> +	 * Bio splitting may cause subtle trouble such as hang when doing sync
> +	 * iopoll in direct IO routine. Given performance gain of iopoll for
> +	 * big IO can be trival, disable iopoll when split needed.
> +	 */
> +	bio->bi_opf &= ~REQ_HIPRI;
> +
>  	return bio_split(bio, sectors, GFP_NOIO, bs);
>  }
>  
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 55bcee5dc032..06afd54b8949 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2157,6 +2157,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>  	unsigned int nr_segs;
>  	blk_qc_t cookie;
>  	blk_status_t ret;
> +	bool hipri;
>  
>  	blk_queue_bounce(q, &bio);
>  	__blk_queue_split(&bio, &nr_segs);
> @@ -2173,6 +2174,8 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>  
>  	rq_qos_throttle(q, bio);
>  
> +	hipri = bio->bi_opf & REQ_HIPRI;
> +
>  	data.cmd_flags = bio->bi_opf;
>  	rq = __blk_mq_alloc_request(&data);
>  	if (unlikely(!rq)) {
> @@ -2265,6 +2268,8 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>  		blk_mq_sched_insert_request(rq, false, true, true);
>  	}
>  
> +	if (!hipri)
> +		return BLK_QC_T_NONE;
>  	return cookie;
>  queue_exit:
>  	blk_queue_exit(q);
> 


