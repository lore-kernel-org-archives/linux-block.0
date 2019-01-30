Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B782C282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 14:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F5020882
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 14:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="ZIJwnOEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbfA3OGi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:06:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43014 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3OGh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 09:06:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so11444301pfk.10
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 06:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SNEFHnDHEV2InRGScoBt6ATM/ddSE+5UswWzWFkZm0s=;
        b=ZIJwnOEaf74zNni6akN93jeK4w8ifnt7ICWhRVuRd/qT7zOJVkPrg/zTP0V35DP19m
         caffGrUjYMtNmxaSGH+sDW+477Xu9lE2B5IH3D9oLxIqvCkMuXvaTwutiXwbc2671Yur
         8iGY9Y7yyZAjvlzEUXWj9HT34Qv76wRvdc4fm5i6HcB4/rBuTOcXmu4QkKz/UgaM8BIL
         zO+2tdqk7bAu6QHuG6au17eGKUVoK0QnYgkg/rxizoqlknt+Rv/8ChzTYUDZG6J72Sm3
         uC2E8PsUq5SuJ1dBGabJCDE1RBNrQnz7lBpFbiCDkvPXiMjhNIxp/bTfdCPrvt8K5m+W
         VuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SNEFHnDHEV2InRGScoBt6ATM/ddSE+5UswWzWFkZm0s=;
        b=RoXVzAlMkzkcmt/Txuy3oP7bdJhupK4oepVDOhM9H/9w3g33tL/4HeSCQ3pmDLUlOY
         Ug+/zTOH3xs36XYKllPRrqAmGoxjEmPMMNT1Lbpzzb5IjAVR9B6j6Dkr26uSXr6dM2Ko
         C/KXHjSvwb6qNgSipH0trxrl+4RGi4RMLHLs/YtG/eEgnv4IBSBkDl6eU7q5sxY0WSSa
         JlAFppPeGG6ZCogBVLnsd0oRq8hB/47nt6QOguxiQgUrE94TuCBfwmhvThlHZwcYxIAX
         RPRB+NLw2h0ZT7z56qvzJgeZSQ+E5bx68Og9ky/HSQYGqPontmQFGUTeBVVsU3i+MOMF
         93uw==
X-Gm-Message-State: AJcUukemCIFsADFRdcOuct61DdPCdQ+28rPzZpWecdAp5wqZgu9sVe9f
        /RjVY23wL565q/MXu13FlbgaBQ==
X-Google-Smtp-Source: ALg8bN4n0YGuG32nnBaMV9dx8R6Ptx/d5Iw/PDQ9sCWJ6hJajV1LDBFtc09PAbE/m7L8MOSviStqIg==
X-Received: by 2002:a65:4904:: with SMTP id p4mr27994572pgs.384.1548857196924;
        Wed, 30 Jan 2019 06:06:36 -0800 (PST)
Received: from [192.168.15.224] (71-6-111-190.static-ip.telepacific.net. [71.6.111.190])
        by smtp.gmail.com with ESMTPSA id y1sm2544416pfe.9.2019.01.30.06.06.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 06:06:36 -0800 (PST)
Subject: Re: [PATCH] lightnvm: pblk: fix bio leak on large sized io
To:     chansol.kim@samsung.com,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     "matias.bjorling@wdc.com" <matias.bjorling@wdc.com>,
        "javier@javigon.com" <javier@javigon.com>
References: <CGME20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p1>
 <20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p1>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <5aa5596b-6394-0d09-533b-0365bc064152@lightnvm.io>
Date:   Wed, 30 Jan 2019 15:06:34 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/30/19 2:53 AM, 김찬솔 wrote:
> 
> Changes:
>   1. Function pblk_rw_io to get bio* as a reference
>   2. In pblk_rw_io bio_put call on read case removed
> 
> A fix to address issue where
>   1. pblk_make_rq calls pblk_rw_io passes bio* pointer as a value (0xA)
>   2. pblk_rw_io calls blk_queue_split passing bio* pointer as reference
>   3. In blk_queue_split, when there is a split, the original bio* (0xA)
>      is passed to generic_make_requests, and the newly allocated bio is
>      returned
>   4. If NVM_IO_DONE returned, pblk_make_rq calls bio_endio on the bio*,
>      that is not the one returned by blk_queue_split
>   5. As a result bio_endio is not called on the newly allocated bio.

The commit message needs a bit of massaging. The Changes: paragraph is 
not needed (that is what the patch is for). Also, please redo the second 
paragraph in without the bullets.

> 
> Signed-off-by: chansol.kim <chansol.kim@samsung.com>
> ---
>   drivers/lightnvm/pblk-init.c | 22 ++++++++--------------
>   1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index b57f764d..4efc929 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -31,30 +31,24 @@ static DECLARE_RWSEM(pblk_lock);
>   struct bio_set pblk_bio_set;
>   
>   static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
> -			  struct bio *bio)
> +			  struct bio **bio)

I am not sure why the **bio change is needed. Can you elaborate?

>   {
> -	int ret;
> -
>   	/* Read requests must be <= 256kb due to NVMe's 64 bit completion bitmap
>   	 * constraint. Writes can be of arbitrary size.
>   	 */
> -	if (bio_data_dir(bio) == READ) {
> -		blk_queue_split(q, &bio);
> -		ret = pblk_submit_read(pblk, bio);
> -		if (ret == NVM_IO_DONE && bio_flagged(bio, BIO_CLONED))
> -			bio_put(bio);
> -
> -		return ret;
> +	if (bio_data_dir(*bio) == READ) {
> +		blk_queue_split(q, bio);
> +		return pblk_submit_read(pblk, *bio);
>   	}
>   
>   	/* Prevent deadlock in the case of a modest LUN configuration and large
>   	 * user I/Os. Unless stalled, the rate limiter leaves at least 256KB
>   	 * available for user I/O.
>   	 */
> -	if (pblk_get_secs(bio) > pblk_rl_max_io(&pblk->rl))
> -		blk_queue_split(q, &bio);
> +	if (pblk_get_secs(*bio) > pblk_rl_max_io(&pblk->rl))
> +		blk_queue_split(q, bio);
>   
> -	return pblk_write_to_cache(pblk, bio, PBLK_IOTYPE_USER);
> +	return pblk_write_to_cache(pblk, *bio, PBLK_IOTYPE_USER);
>   }
>   
>   static blk_qc_t pblk_make_rq(struct request_queue *q, struct bio *bio)
> @@ -69,7 +63,7 @@ static blk_qc_t pblk_make_rq(struct request_queue *q, struct bio *bio)
>   		}
>   	}
>   
> -	switch (pblk_rw_io(q, pblk, bio)) {
> +	switch (pblk_rw_io(q, pblk, &bio)) {
>   	case NVM_IO_ERR:
>   		bio_io_error(bio);
>   		break;
> 

