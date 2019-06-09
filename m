Return-Path: <SRS0=xEhu=UI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F35EC28EBD
	for <linux-block@archiver.kernel.org>; Sun,  9 Jun 2019 19:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24C7206BB
	for <linux-block@archiver.kernel.org>; Sun,  9 Jun 2019 19:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="fgzDvGCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfFITvv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jun 2019 15:51:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36734 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfFITvu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Jun 2019 15:51:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so6015141ljj.3
        for <linux-block@vger.kernel.org>; Sun, 09 Jun 2019 12:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7R/kDNArDXUfynqKd/gwyYV/gk6x647qrM7vLY8POoY=;
        b=fgzDvGCcvDVZve4f1Xx5N4zsXprEyZt5KYDClSFFh9pLNjITwKnLd95B/SBLO2JdZX
         fp4FUxFpLAIfxkH3x5Nj/XUUKl1tDydYml/KvQtzHn5LJE8VvKObkdYeYPw2hpf7GPBs
         e+Z14X7H2QQrrcbJD1SAfMTfEjc7jDV4CJlJWHSPBItocj2fZU5a9TNu4IXoQ3RCR9VY
         t9ZbTNDsykxa2Iamg/2rri0V+symMbbkxRtzWRPl8fdiGZIw6/OKPU8JtzqD95brZPIh
         oWQSjO+W0RGjNPgHrcVsdC7O+bo0DLc+yagHf0q+eFwJ/TwnwCprOVyhs4WTPr69T9bJ
         hidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7R/kDNArDXUfynqKd/gwyYV/gk6x647qrM7vLY8POoY=;
        b=fc9ASOKzoq6XUCD+Pz8rdn4BFV9FFAvZA+V0I9hDnby+ik3/ZuIjmyWanGypLVULiR
         smmEAlOykmHOLyXZowIon7XJpJOjfmWnqAz5LRBKhk/Wxh7fkkUQgGb/WifmZj88VMQJ
         VsljsYfq4OvtP1x7br6NnhmKgDyivI2ur/Jsv8Vb3bJzVHAaF6dh91n9wBn9oOUW52EE
         Q/BtgFAtJEG6hDExmr3q2Tby5QjHKRj0rDvrUiWYaqi65C4/CVwAsn1p7e69XSK1x7yL
         +vZf8VNuUVQdyZXvmyjwHMjYTB8oifax6OP6G+NpTWvZa/ydJeSu5PwhHtflV3n+lHQa
         wd2g==
X-Gm-Message-State: APjAAAV7E5mx805pqQY9tJ8uyJJu1V8XTbTiDlAtaK3U83w+M9/PqrSV
        b8G2KeG1XyxGD2jGzeA0LNhuRrUzOr4=
X-Google-Smtp-Source: APXvYqxeapMO4Me1oWbNrAYpoki9ivMX8bag3yCRCQCGNLe+TKBD45BI3JqaS0P38VMDMy9LNeXnNA==
X-Received: by 2002:a2e:5dc4:: with SMTP id v65mr24853422lje.138.1560109908392;
        Sun, 09 Jun 2019 12:51:48 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id q63sm1520163ljb.44.2019.06.09.12.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 12:51:47 -0700 (PDT)
Subject: Re: [PATCH 2/6] block: remove blk_init_request_from_bio
To:     Christoph Hellwig <hch@lst.de>, axboe@fb.com
Cc:     linux-block@vger.kernel.org
References: <20190606102904.4024-1-hch@lst.de>
 <20190606102904.4024-3-hch@lst.de>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <81eb6765-b8f2-fbfb-4ab9-812b613a53a9@lightnvm.io>
Date:   Sun, 9 Jun 2019 21:51:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190606102904.4024-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/6/19 12:29 PM, Christoph Hellwig wrote:
> lightnvm should have never used this function, as it is sending
> passthrough requests, so switch it to blk_rq_append_bio like all the
> other passthrough request users.  Inline blk_init_request_from_bio into
> the only remaining caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c             | 11 -----------
>   block/blk-mq.c               |  7 ++++++-
>   drivers/nvme/host/lightnvm.c |  2 +-
>   include/linux/blkdev.h       |  1 -
>   4 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 9b88b1a3eb43..a9cb465c7ef7 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -674,17 +674,6 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
>   	return false;
>   }
>   
> -void blk_init_request_from_bio(struct request *req, struct bio *bio)
> -{
> -	if (bio->bi_opf & REQ_RAHEAD)
> -		req->cmd_flags |= REQ_FAILFAST_MASK;
> -
> -	req->__sector = bio->bi_iter.bi_sector;
> -	req->write_hint = bio->bi_write_hint;
> -	blk_rq_bio_prep(req->q, req, bio);
> -}
> -EXPORT_SYMBOL_GPL(blk_init_request_from_bio);
> -
>   static void handle_bad_sector(struct bio *bio, sector_t maxsector)
>   {
>   	char b[BDEVNAME_SIZE];
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ce0f5f4ede70..61457bffa55f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1766,7 +1766,12 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>   
>   static void blk_mq_bio_to_request(struct request *rq, struct bio *bio)
>   {
> -	blk_init_request_from_bio(rq, bio);
> +	if (bio->bi_opf & REQ_RAHEAD)
> +		rq->cmd_flags |= REQ_FAILFAST_MASK;
> +
> +	rq->__sector = bio->bi_iter.bi_sector;
> +	rq->write_hint = bio->bi_write_hint;
> +	blk_rq_bio_prep(rq->q, rq, bio);
>   
>   	blk_account_io_start(rq, true);
>   }
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index 4f20a10b39d3..ba009d4c9dfa 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -660,7 +660,7 @@ static struct request *nvme_nvm_alloc_request(struct request_queue *q,
>   	rq->cmd_flags &= ~REQ_FAILFAST_DRIVER;
>   
>   	if (rqd->bio)
> -		blk_init_request_from_bio(rq, rqd->bio);
> +		blk_rq_append_bio(rq, &rqd->bio);
>   	else
>   		rq->ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_NORM);
>   
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 592669bcc536..c67a9510e532 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -828,7 +828,6 @@ extern void blk_unregister_queue(struct gendisk *disk);
>   extern blk_qc_t generic_make_request(struct bio *bio);
>   extern blk_qc_t direct_make_request(struct bio *bio);
>   extern void blk_rq_init(struct request_queue *q, struct request *rq);
> -extern void blk_init_request_from_bio(struct request *req, struct bio *bio);
>   extern void blk_put_request(struct request *);
>   extern struct request *blk_get_request(struct request_queue *, unsigned int op,
>   				       blk_mq_req_flags_t flags);
> 

Thanks Christoph.

Reviewed-by: Matias Bjørling <mb@lightnvm.io>
