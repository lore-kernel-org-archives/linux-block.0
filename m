Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB2FC10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 22:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D07820857
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 22:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfDHWvy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:51:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbfDHWvy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Apr 2019 18:51:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 948C7859FB;
        Mon,  8 Apr 2019 22:51:54 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C33E919C5A;
        Mon,  8 Apr 2019 22:51:49 +0000 (UTC)
Date:   Tue, 9 Apr 2019 06:51:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/5] block: rewrite blk_bvec_map_sg to avoid a nth_page
 call
Message-ID: <20190408225142.GA6540@ming.t460p>
References: <20190408104641.4905-1-hch@lst.de>
 <20190408104641.4905-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408104641.4905-2-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 08 Apr 2019 22:51:54 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 08, 2019 at 12:46:37PM +0200, Christoph Hellwig wrote:
> The offset in scatterlists is allowed to be larger than the page size,
> so don't go to great length to avoid that case and simplify the
> arithmetics.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-merge.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 8f96d683b577..52dbdd089fdf 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -467,26 +467,17 @@ static unsigned blk_bvec_map_sg(struct request_queue *q,
>  		struct scatterlist **sg)
>  {
>  	unsigned nbytes = bvec->bv_len;
> -	unsigned nsegs = 0, total = 0, offset = 0;
> +	unsigned nsegs = 0, total = 0;
>  
>  	while (nbytes > 0) {
> -		unsigned seg_size;
> -		struct page *pg;
> -		unsigned idx;
> +		unsigned offset = bvec->bv_offset + total;
> +		unsigned len = min(get_max_segment_size(q, offset), nbytes);
>  
>  		*sg = blk_next_sg(sg, sglist);
> +		sg_set_page(*sg, bvec->bv_page, len, offset);
>  
> -		seg_size = get_max_segment_size(q, bvec->bv_offset + total);
> -		seg_size = min(nbytes, seg_size);
> -
> -		offset = (total + bvec->bv_offset) % PAGE_SIZE;
> -		idx = (total + bvec->bv_offset) / PAGE_SIZE;
> -		pg = bvec_nth_page(bvec->bv_page, idx);
> -
> -		sg_set_page(*sg, pg, seg_size, offset);
> -
> -		total += seg_size;
> -		nbytes -= seg_size;
> +		total += len;
> +		nbytes -= len;
>  		nsegs++;
>  	}

Nice cleanup & simplification:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
