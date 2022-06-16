Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CB6C43334
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 23:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379285AbiFPXF6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 19:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379122AbiFPXFy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 19:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 677E46223B
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 16:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655420752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U0VJ3Cm/Y3rwtx3nV+0/84LUEhDyMiOPdSL1VuMXois=;
        b=gEVuYW2gkqMiP8pZ2pCkjfJidDy4wzq8/4yenzLstKeI/66FcqdSD2GBHIig5bPX1AoyWo
        832WRiECA7zg0hTdDyKGh/6aPGc1ZrplMQLn+O0wW4K2Z6cn78ei4m8W3Bt5d4t75qql3a
        3RNqOumcsQCrdW7d43fg1RYwyDwb5F0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-YxSp7ZQENQeBLXBOFCXDRg-1; Thu, 16 Jun 2022 19:05:51 -0400
X-MC-Unique: YxSp7ZQENQeBLXBOFCXDRg-1
Received: by mail-qv1-f72.google.com with SMTP id r14-20020ad4576e000000b0046bbacd783bso2998180qvx.14
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 16:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U0VJ3Cm/Y3rwtx3nV+0/84LUEhDyMiOPdSL1VuMXois=;
        b=aIiEp2UFVejIz6Q3E7A5jBqC3WQ6lOEnDIAXcpgkB0NYtXxGsPQRJdi5J0MkmUfqdr
         OXJpqX8+cwXJETO12HAErG/WhsRzWhFTOUmOO05s6B1M0nZ+13ymfNKcFNWxsNkNV6a2
         2i7rSW3uTaPa02JDkBFt/jHFDsbgRMzayoGh1VDcglINhVZC6zR2WEpbiWL9jy3YX1Tx
         I8g35ZjGUmSiNgCI0OgLGgboJFyYMYkAXcN1lhWUOLPzWsEYyWy6aNJrXnHbWIBcnaDA
         ci0Ifx1SKhmnZsKyyb2QOTULqCOEBLg1U1ZUbYGHmjuj4mewoYUAJvRRidDjNGWnkxOJ
         IlqQ==
X-Gm-Message-State: AJIora8jdpVPEMz/mFuazwfM2GJOoN5z8L0Ji9aXouFvJzG+PjHeUcQP
        mS3M6XFs66nGXq7p2R7gt1GyfklKEnbS9k7qhNoH+NKwui3RlrhdOI2t9qo4/lWzP0RlVWTKU/p
        w+YlQ50kQ2O3J9w89VTLhhw==
X-Received: by 2002:a37:9b09:0:b0:6a6:b23e:8534 with SMTP id d9-20020a379b09000000b006a6b23e8534mr5262838qke.214.1655420750848;
        Thu, 16 Jun 2022 16:05:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ukWikPEibv89UPW9YJ/Lk3dW7LBJk8ug+kPZTWxjEHoD1biXBjayw9IgNpzke1CCiJW2LwRw==
X-Received: by 2002:a37:9b09:0:b0:6a6:b23e:8534 with SMTP id d9-20020a379b09000000b006a6b23e8534mr5262793qke.214.1655420750250;
        Thu, 16 Jun 2022 16:05:50 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id x5-20020a05620a258500b006a75a0ffc97sm3428935qko.3.2022.06.16.16.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 16:05:49 -0700 (PDT)
Date:   Thu, 16 Jun 2022 19:05:48 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/6] block: factor out a chunk_size_left helper
Message-ID: <Yqu3TKf5MUwcnUty@redhat.com>
References: <20220614090934.570632-1-hch@lst.de>
 <20220614090934.570632-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614090934.570632-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 14 2022 at  5:09P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Factor out a helper from blk_max_size_offset so that it can be reused
> independently.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/blkdev.h | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 914c613d81da7..e66ad451274ec 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -933,6 +933,17 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
>  	return q->limits.max_sectors;
>  }
>  
> +/*
> + * Return how much of the chunk is left to be used for I/O at a given offset.
> + */
> +static inline unsigned int blk_chunk_sectors_left(sector_t offset,
> +		unsigned int chunk_sectors)
> +{
> +	if (unlikely(!is_power_of_2(chunk_sectors)))
> +		return chunk_sectors - sector_div(offset, chunk_sectors);
> +	return chunk_sectors - (offset & (chunk_sectors - 1));
> +}
> +
>  /*
>   * Return maximum size of a request at given offset. Only valid for
>   * file system requests.
> @@ -948,12 +959,8 @@ static inline unsigned int blk_max_size_offset(struct request_queue *q,
>  			return q->limits.max_sectors;
>  	}
>  
> -	if (likely(is_power_of_2(chunk_sectors)))
> -		chunk_sectors -= offset & (chunk_sectors - 1);
> -	else
> -		chunk_sectors -= sector_div(offset, chunk_sectors);
> -
> -	return min(q->limits.max_sectors, chunk_sectors);
> +	return min(q->limits.max_sectors,
> +			blk_chunk_sectors_left(offset, chunk_sectors));
>  }

While you're at it, any reason not to use queue_max_sectors() here?

