Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B66AC43218
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 16:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF2A2077C
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 16:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfDYQWO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:22:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:53984 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726534AbfDYQWO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 12:22:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F1F71AE32;
        Thu, 25 Apr 2019 16:22:12 +0000 (UTC)
Subject: Re: [PATCH 1/2] bcache: clean up do_btree_node_write a bit
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org,
        linux-bcache@vger.kernel.org
References: <20190425070300.3388-1-hch@lst.de>
 <20190425070300.3388-2-hch@lst.de>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <ff18d818-7099-7e92-119b-e50f3e921ccc@suse.de>
Date:   Fri, 26 Apr 2019 00:22:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425070300.3388-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/4/25 3:02 下午, Christoph Hellwig wrote:
> Use a variable containing the buffer address instead of the to be
> removed integer iterator from bio_for_each_segment_all.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li

> ---
>  drivers/md/bcache/btree.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> index b139858b0802..3a9f8ed437de 100644
> --- a/drivers/md/bcache/btree.c
> +++ b/drivers/md/bcache/btree.c
> @@ -431,12 +431,13 @@ static void do_btree_node_write(struct btree *b)
>  	if (!bch_bio_alloc_pages(b->bio, __GFP_NOWARN|GFP_NOWAIT)) {
>  		int j;
>  		struct bio_vec *bv;
> -		void *base = (void *) ((unsigned long) i & ~(PAGE_SIZE - 1));
> +		void *addr = (void *) ((unsigned long) i & ~(PAGE_SIZE - 1));
>  		struct bvec_iter_all iter_all;
>  
> -		bio_for_each_segment_all(bv, b->bio, j, iter_all)
> -			memcpy(page_address(bv->bv_page),
> -			       base + j * PAGE_SIZE, PAGE_SIZE);
> +		bio_for_each_segment_all(bv, b->bio, j, iter_all) {
> +			memcpy(page_address(bv->bv_page), addr, PAGE_SIZE);
> +			addr += PAGE_SIZE;
> +		}
>  
>  		bch_submit_bbio(b->bio, b->c, &k.key, 0);
>  
> 


-- 

Coly Li
