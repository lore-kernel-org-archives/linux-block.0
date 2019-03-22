Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F3BC10F03
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 22:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D262B21925
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 22:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cRbEMKDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfCVWA2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:00:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42170 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfCVWA2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 18:00:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id r15so2393526pfn.9
        for <linux-block@vger.kernel.org>; Fri, 22 Mar 2019 15:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WQp0WNe+X6GkcnKSgJpReVIeC/xEsLmkihelFScJ3bo=;
        b=cRbEMKDHDicl9aX7YOQfMoJnuLo934wf3lg/0BamyVK5mwwoCKjj9XJIxLsWr4taLL
         1cGcuHEqw9/QP+klPJqhgZR0yVcZzd+0TY1BokY4sYcHdxfppeNa0Dzo6qtOmUcSOe/8
         MA120IjeUNM6JpmDj6a3Y+mqaa6nhik6y5A5HAop5EX1oehjHQ3WzLK8rvpMBkyy2c/+
         wDJVrchddpzM97CxojNZAFXaaUHJvcs18dL9u1ePP3B9XXX7znLj9jHtcZDKycpfxc6r
         GvP8YJ/23xznjMm1pErF2cEEEoVCnyRCMs4pGhjinKW3RnIL8wK4OS+m/VFH9zWQ8OWg
         WBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WQp0WNe+X6GkcnKSgJpReVIeC/xEsLmkihelFScJ3bo=;
        b=bbsFzID3jEIy2mYWDnIR0W2DOb9qzxUQgUo7LFdfggeB5//I55+XzDZu5buZVS3aob
         RFVqZeuFIdv0yWcD8Dt3n5/ZmX1LXOMyv0ujTG90CRmpIKLBsayCMrX71QOhb/uBgRGU
         w3DXX8YqjFIzz9yFWxZBrh5Xb/JO+pz380puoa5sgOCUp2vHfyYp5rn3CoG+ANkU9/up
         pPy3j+iRlOdSwD1GdT1Mrnw2p9q4pIFU0W8J9iBUxEkvOEyI5dEbJIPG5n070brGt6Eg
         F+7gE9+0r34tsb5Wtbj9Jy5eUIqnmKuRxVCDZsfpnwmlOV02e2dpz0h1e7tBCc/twm7t
         TyIA==
X-Gm-Message-State: APjAAAXjSYvLEUa2z+VCpYClLTvtaXFAVb4C+faB2f3uSO92gauXY8bg
        5EyQ3zK6LFIvVzKkRKSI7cL0qQ==
X-Google-Smtp-Source: APXvYqx/HM9iLwVpBsFaPt+difdECtJgd+tOtQ+8YICne46WK8BnRxYXCkB17ZQ7nNjZaI/qpxdRZQ==
X-Received: by 2002:a62:480d:: with SMTP id v13mr11692049pfa.125.1553292027508;
        Fri, 22 Mar 2019 15:00:27 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id k75sm19948572pfj.46.2019.03.22.15.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 15:00:26 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] block: bio: kill BIO_SEG_VALID flag
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
References: <20190322131346.20169-1-jthumshirn@suse.de>
 <20190322131346.20169-2-jthumshirn@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8273b995-01c2-fbf4-b8be-484508c65938@kernel.dk>
Date:   Fri, 22 Mar 2019 16:00:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322131346.20169-2-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/19 7:13 AM, Johannes Thumshirn wrote:
> @@ -712,7 +714,10 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
>  	bvec->bv_len = len;
>  	bvec->bv_offset = offset;
>  	bio->bi_vcnt++;
> -	bio->bi_phys_segments++;
> +	if (bio->bi_phys_segments == -1)
> +		bio->bi_phys_segments = 1;
> +	else
> +		bio->bi_phys_segments++;
>  	bio->bi_iter.bi_size += len;

Echo Christophs suggestion here.

> diff --git a/block/blk-core.c b/block/blk-core.c
> index 4673ebe42255..53372a16dd7c 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1514,6 +1514,7 @@ void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
>  	else if (bio_op(bio) == REQ_OP_DISCARD)
>  		rq->nr_phys_segments = 1;
>  
> +	WARN_ON(rq->nr_phys_segments == -1);
>  	rq->__data_len = bio->bi_iter.bi_size;
>  	rq->bio = rq->biotail = bio;

Just make that:

	else
		rq->nr_phys_segments = 0;

for the third case?

-- 
Jens Axboe

