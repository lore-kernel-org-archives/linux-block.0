Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78355C7619A
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 02:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjDFCdx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 22:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjDFCdv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 22:33:51 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6215F7ED3
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 19:33:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id nh20-20020a17090b365400b0024496d637e1so201796pjb.5
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 19:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680748430; x=1683340430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NcT6eeBCcYCwHDLXpCoeHWJwPU7wQEvqRnmXVPYyQWQ=;
        b=HpLZr1EGSKaNqHdOfKzm9Q/DKSL0GCTwwljWneQz/hXRKdckLDnyMWQoFbaAnbMqPK
         6DzbSPWuWYBawV4nDxBb3P5Zh4JjD0fH0YAVrnFrzAl77SyKJ4USWztFIMo8tWf2fFuE
         umbYjcoHqvKcfxjyx/kv6HfiYIHm6GOoEBXgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680748430; x=1683340430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcT6eeBCcYCwHDLXpCoeHWJwPU7wQEvqRnmXVPYyQWQ=;
        b=BzXe1bw2F0KKJpvQO0BLgYR5YSPcH8P7ps7+KMz8L9W39s+9TzpA0tdgR+2judz4j3
         eDnpOGi1X999W3SrPc7G+YPpXNjRG5ZQxeiLUoV7tLzQVQfaQ1hKdNhDmWjNN2M2W6+E
         RBHzp+iV4hA804hRXzVyUUwouPuHdVz7mc3fPZEpR5HmaR4Fr6KEpMtk0WwuVoVq3Fuh
         IUeAh1JbKioFZfKOPCqYt8utCsOoxFqWZZjj/xSA8thtRFCpN0BJj25C+1yKXZKSyHRH
         ITpba21OORVFx40sRYBFroBncbP9XaI9Ftc9qpJ31yjhw2alyEb2mipoonSNDuX5xjL2
         HqJw==
X-Gm-Message-State: AAQBX9fGh7RYo7nmdQqykCJ1Cf07dAzmB0vYk+FOQpemOJecrAyTZzAP
        7jMmpyRUEh3yAr2EwywccCNSiw==
X-Google-Smtp-Source: AKy350anTpIoqYXpMzSjKKfR8C6S3ZCsdK5Pw1YjOH3CaB3DcAUO3Nxbq+erdYXFTm+U7gPId+iE2Q==
X-Received: by 2002:a17:902:e54f:b0:1a1:7da3:ef5b with SMTP id n15-20020a170902e54f00b001a17da3ef5bmr5088084plf.7.1680748429794;
        Wed, 05 Apr 2023 19:33:49 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id m8-20020a170902bb8800b001a19f2f81a3sm201974pls.175.2023.04.05.19.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 19:33:49 -0700 (PDT)
Date:   Thu, 6 Apr 2023 11:33:45 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 04/16] zram: move discard handling to zram_submit_bio
Message-ID: <20230406023345.GP12892@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230404150536.2142108-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404150536.2142108-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/04 17:05), Christoph Hellwig wrote:
> 
> Switch on the bio operation in zram_submit_bio and only call into
> __zram_make_request for read and write operations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

[..]
> @@ -1996,7 +1987,19 @@ static void zram_submit_bio(struct bio *bio)
>  {
>  	struct zram *zram = bio->bi_bdev->bd_disk->private_data;
>  
> -	__zram_make_request(zram, bio);
> +	switch (bio_op(bio)) {
> +	case REQ_OP_READ:
> +	case REQ_OP_WRITE:
> +		__zram_make_request(zram, bio);
> +		break;
> +	case REQ_OP_DISCARD:
> +	case REQ_OP_WRITE_ZEROES:
> +		zram_bio_discard(zram, bio);
> +		return;

Super nitpick,  break;

> +	default:
> +		WARN_ON_ONCE(1);
> +		bio_endio(bio);
> +	}
>  }
>  
>  static void zram_slot_free_notify(struct block_device *bdev,
> -- 
> 2.39.2
> 
