Return-Path: <SRS0=0HSq=CV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816ECC433E2
	for <linux-block@archiver.kernel.org>; Sat, 12 Sep 2020 13:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2208B20855
	for <linux-block@archiver.kernel.org>; Sat, 12 Sep 2020 13:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cD3F052V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgILNxO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Sep 2020 09:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25017 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbgILNxN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Sep 2020 09:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599918791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XR6u7TqERwThyNfZzYWgsg0Rr430L8zf9OdQe8Komps=;
        b=cD3F052V9OSPCEdZLey+NGmKMUrPllXZCHMP2ydt3zCUrtfepwPhcoHWxm6oYmn+AcXCaD
        VrkQJ+6qVYbm4KkB23kShoZh0msu+gyMPGcYAQWm5zLYVdc4y93qQI75MQUETq5j0ODj1u
        9u4rteTZc1/uooKw1FwCXX7Nk5lCcms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-tVGkUyi3Mm-ZZ6UZli9Okg-1; Sat, 12 Sep 2020 09:53:09 -0400
X-MC-Unique: tVGkUyi3Mm-ZZ6UZli9Okg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 224961074651;
        Sat, 12 Sep 2020 13:53:08 +0000 (UTC)
Received: from T590 (ovpn-12-84.pek2.redhat.com [10.72.12.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E60C360BF1;
        Sat, 12 Sep 2020 13:52:56 +0000 (UTC)
Date:   Sat, 12 Sep 2020 21:52:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] block: fix blk_rq_get_max_sectors() to flow more
 carefully
Message-ID: <20200912135252.GA210077@T590>
References: <20200911215338.44805-1-snitzer@redhat.com>
 <20200911215338.44805-2-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911215338.44805-2-snitzer@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 11, 2020 at 05:53:36PM -0400, Mike Snitzer wrote:
> blk_queue_get_max_sectors() has been trained for REQ_OP_WRITE_SAME and
> REQ_OP_WRITE_ZEROES yet blk_rq_get_max_sectors() didn't call it for
> those operations.

Actually WRITE_SAME & WRITE_ZEROS are handled by the following if
chunk_sectors is set:

        return min(blk_max_size_offset(q, offset),
                        blk_queue_get_max_sectors(q, req_op(rq)));
 
> Also, there is no need to avoid blk_max_size_offset() if
> 'chunk_sectors' isn't set because it falls back to 'max_sectors'.
> 
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> ---
>  include/linux/blkdev.h | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index bb5636cc17b9..453a3d735d66 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1070,17 +1070,24 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
>  						  sector_t offset)
>  {
>  	struct request_queue *q = rq->q;
> +	int op;
> +	unsigned int max_sectors;
>  
>  	if (blk_rq_is_passthrough(rq))
>  		return q->limits.max_hw_sectors;
>  
> -	if (!q->limits.chunk_sectors ||
> -	    req_op(rq) == REQ_OP_DISCARD ||
> -	    req_op(rq) == REQ_OP_SECURE_ERASE)
> -		return blk_queue_get_max_sectors(q, req_op(rq));
> +	op = req_op(rq);
> +	max_sectors = blk_queue_get_max_sectors(q, op);
>  
> -	return min(blk_max_size_offset(q, offset),
> -			blk_queue_get_max_sectors(q, req_op(rq)));
> +	switch (op) {
> +	case REQ_OP_DISCARD:
> +	case REQ_OP_SECURE_ERASE:
> +	case REQ_OP_WRITE_SAME:
> +	case REQ_OP_WRITE_ZEROES:
> +		return max_sectors;
> +	}
> +
> +	return min(blk_max_size_offset(q, offset), max_sectors);
>  }

It depends if offset & chunk_sectors limit for WRITE_SAME & WRITE_ZEROS
needs to be considered.


Thanks,
Ming

