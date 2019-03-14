Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD41C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 13:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EF52184C
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 13:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfCNNth (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:49:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:12332 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbfCNNth (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 09:49:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 06:49:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="126934188"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.142.164]) ([10.237.142.164])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2019 06:49:34 -0700
Subject: Re: [PATCH RFC] lightnvm: pblk: fix crash in pblk_end_partial_read
 due to multipage bvecs
To:     hans@owltronix.com, Matias Bjorling <mb@lightnvm.io>,
        javier@javigon.com
Cc:     Klaus Jensen <klaus.jensen@cnexlabs.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <20190314111637.20236-1-hans@owltronix.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <103c19f4-02a2-f54c-13f8-30bc5447426e@intel.com>
Date:   Thu, 14 Mar 2019 14:49:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190314111637.20236-1-hans@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While reading this patch, idea came to my mind - maybe it would be 
simply better to get rid of partial read handling from pblk in current 
form at all and use bio_split() & bio_chain() combination instead?

This would definitely reduce a number of this 'kind of complicated' code 
inside pblk and let block layer help us with that. Even that the 
performance of such a requests could be a little worse (few smaller IOs 
instead of single vector IO), I believe that partial read is more a 
corner case, then a typical use case, so maybe this would be a path to go.

Let me know what you think about such an approach - I can make a patch 
with that if you want.

Igor

On 14.03.2019 12:16, hans@owltronix.com wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> Ever since '07173c3ec276 ("block: enable multipage bvecs")' we
> need to handle bios with multipage bvecs in pblk.
> 
> Currently, a multipage bvec results in a crash[1].
> Fix this by using bvec iterators in stead of direct bvec indexing.
> 
> Also add a dcache flush, for the same reasons as in:
> '6e6e811d747b ("block: Add missing flush_dcache_page() call")'
> 
> [1] https://github.com/OpenChannelSSD/linux/issues/61
> 
> Reported-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> ---
> 
> RFC to get more eyes on this - note that we're doing something
> very similar to bio_copy_data_iter.
> 
> This works in my QEMU setup, and I'll start more regression testing now.
> 
>   drivers/lightnvm/pblk-read.c | 50 ++++++++++++++++++++----------------
>   1 file changed, 28 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> index 1f9b319c9737..b8eb6bdb983b 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -231,14 +231,14 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
>   	struct pblk_sec_meta *meta;
>   	struct bio *new_bio = rqd->bio;
>   	struct bio *bio = pr_ctx->orig_bio;
> -	struct bio_vec src_bv, dst_bv;
>   	void *meta_list = rqd->meta_list;
> -	int bio_init_idx = pr_ctx->bio_init_idx;
>   	unsigned long *read_bitmap = pr_ctx->bitmap;
> +	struct bvec_iter orig_iter = BVEC_ITER_ALL_INIT;
> +	struct bvec_iter new_iter = BVEC_ITER_ALL_INIT;
>   	int nr_secs = pr_ctx->orig_nr_secs;
>   	int nr_holes = nr_secs - bitmap_weight(read_bitmap, nr_secs);
>   	void *src_p, *dst_p;
> -	int hole, i;
> +	int bit, i;
>   
>   	if (unlikely(nr_holes == 1)) {
>   		struct ppa_addr ppa;
> @@ -257,33 +257,39 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
>   
>   	/* Fill the holes in the original bio */
>   	i = 0;
> -	hole = find_first_zero_bit(read_bitmap, nr_secs);
> -	do {
> -		struct pblk_line *line;
> +	for (bit = 0; bit < nr_secs; bit++) {
> +		if (!test_bit(bit, read_bitmap)) {
> +			struct bio_vec dst_bv, src_bv;
> +			struct pblk_line *line;
>   
> -		line = pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
> -		kref_put(&line->ref, pblk_line_put);
> +			line = pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
> +			kref_put(&line->ref, pblk_line_put);
>   
> -		meta = pblk_get_meta(pblk, meta_list, hole);
> -		meta->lba = cpu_to_le64(pr_ctx->lba_list_media[i]);
> +			meta = pblk_get_meta(pblk, meta_list, bit);
> +			meta->lba = cpu_to_le64(pr_ctx->lba_list_media[i]);
>   
> -		src_bv = new_bio->bi_io_vec[i++];
> -		dst_bv = bio->bi_io_vec[bio_init_idx + hole];
> +			dst_bv = bio_iter_iovec(bio, orig_iter);
> +			src_bv = bio_iter_iovec(new_bio, new_iter);
>   
> -		src_p = kmap_atomic(src_bv.bv_page);
> -		dst_p = kmap_atomic(dst_bv.bv_page);
> +			src_p = kmap_atomic(src_bv.bv_page);
> +			dst_p = kmap_atomic(dst_bv.bv_page);
>   
> -		memcpy(dst_p + dst_bv.bv_offset,
> -			src_p + src_bv.bv_offset,
> -			PBLK_EXPOSED_PAGE_SIZE);
> +			memcpy(dst_p + dst_bv.bv_offset,
> +				src_p + src_bv.bv_offset,
> +				PBLK_EXPOSED_PAGE_SIZE);
>   
> -		kunmap_atomic(src_p);
> -		kunmap_atomic(dst_p);
> +			kunmap_atomic(src_p);
> +			kunmap_atomic(dst_p);
>   
> -		mempool_free(src_bv.bv_page, &pblk->page_bio_pool);
> +			flush_dcache_page(dst_bv.bv_page);
> +			mempool_free(src_bv.bv_page, &pblk->page_bio_pool);
>   
> -		hole = find_next_zero_bit(read_bitmap, nr_secs, hole + 1);
> -	} while (hole < nr_secs);
> +			bio_advance_iter(new_bio, &new_iter,
> +					PBLK_EXPOSED_PAGE_SIZE);
> +			i++;
> +		}
> +		bio_advance_iter(bio, &orig_iter, PBLK_EXPOSED_PAGE_SIZE);
> +	}
>   
>   	bio_put(new_bio);
>   	kfree(pr_ctx);
> 
