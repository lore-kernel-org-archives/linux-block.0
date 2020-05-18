Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5210C433E0
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 03:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B45920758
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 03:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/1/HjmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgERDHY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 May 2020 23:07:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31132 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726966AbgERDHX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 May 2020 23:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589771242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3RTApUMT0TFyv0bY57HvR6hN+bO0xJ8doZzV5FXcLg0=;
        b=X/1/HjmN3Uvt0pnT+7MBCMFZnDltbpCbRQF8uVjf1eptRxk2NejX8AipOn9ftAbQbYnyr7
        OEj1pFNdNeFzz9MyhUT5IsYNqY8qpK5WdVioCVY8zBN3BOXLCwbxo8MyL5V1zxW6TS67dF
        13fmUMvdTHPEvznB/r+jQQkcaIlGvio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-LhPl8CaROcuT51fIJJ3-Xg-1; Sun, 17 May 2020 23:07:18 -0400
X-MC-Unique: LhPl8CaROcuT51fIJJ3-Xg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1CC0461;
        Mon, 18 May 2020 03:07:16 +0000 (UTC)
Received: from T590 (ovpn-13-68.pek2.redhat.com [10.72.13.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5583078B4F;
        Mon, 18 May 2020 03:07:09 +0000 (UTC)
Date:   Mon, 18 May 2020 11:07:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Alexander Potapenko <glider@google.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH v2 4/4] null_blk: Zero-initialize read buffers in
 non-memory-backed mode
Message-ID: <20200518030705.GB20647@T590>
References: <20200518014807.7749-1-bvanassche@acm.org>
 <20200518014807.7749-5-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518014807.7749-5-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 17, 2020 at 06:48:07PM -0700, Bart Van Assche wrote:
> This patch suppresses an uninteresting KMSAN complaint without affecting
> performance of the null_blk driver if CONFIG_KMSAN is disabled.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Cc: Alexander Potapenko <glider@google.com>
> Reported-by: Alexander Potapenko <glider@google.com>
> Tested-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/null_blk_main.c | 50 +++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
> index 06f5761fccb6..0c1df6ecb30b 100644
> --- a/drivers/block/null_blk_main.c
> +++ b/drivers/block/null_blk_main.c
> @@ -1250,8 +1250,58 @@ static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
>  	return errno_to_blk_status(err);
>  }
>  
> +static void zero_fill_bvec(const struct bio_vec *bvec)
> +{
> +	struct page *page = bvec->bv_page;
> +	u32 offset = bvec->bv_offset;
> +	u32 left = bvec->bv_len;
> +
> +	while (left) {
> +		u32 len = min_t(u32, left, PAGE_SIZE - offset);
> +		void *kaddr;
> +
> +		kaddr = kmap_atomic(page);
> +		memset(kaddr + offset, 0, len);
> +		flush_dcache_page(page);
> +		kunmap_atomic(kaddr);
> +		page++;
> +		left -= len;
> +		offset = 0;
> +	}
> +}
> +
> +static void nullb_zero_rq_data_buffer(const struct request *rq)
> +{
> +	struct req_iterator iter;
> +	struct bio_vec bvec;
> +
> +	rq_for_each_bvec(bvec, rq, iter)
> +		zero_fill_bvec(&bvec);
> +}

Not necessary to add zero_fill_bvec(), and it can be done in the
following two line code:

	__rq_for_each_bio(bio, rq)
		zero_fill_bio(bio);


Thanks,
Ming

