Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6420FC04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 16:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B1E2064D
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 16:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LaaBKonm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B1E2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeLEQZt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:25:49 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36120 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbeLEQZt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 11:25:49 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so21120713itj.1
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 08:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vKrjrO3N0vHL4Rqm8qJpRB8z3APMNK7apMQ+HoqTxqk=;
        b=LaaBKonmJVkBkx75VNJjeKjjK8x41uhlWygWxGuYlkw8D+1vo8Ln/E/5eKIoOFUhUh
         Gh7jLhSdRVZX3a0WbCyVdlL5MlbmzrHFkQ1qWIMUUiCt1FOPfCt6i45h9FTOx4ETVaCm
         P+a9KLye+gHvbge2CsNvhxaDhlaRFOVV+Guzi01Y5neoOJVCKv5bZO1UD7DcY+KAkYVM
         kbhBoxXlEd4OpxvwyIcUJjgBLVTWZIP1/AfpL9epPxmJyTZv7XSfrVG0Kb0j0k3pY3gW
         hmZw0T5z3BSzWS12sfN2QkkvGmED3ouxnljDeF6VpSSPNTTYKvCOr6WnJz58LMq1LE4C
         22dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vKrjrO3N0vHL4Rqm8qJpRB8z3APMNK7apMQ+HoqTxqk=;
        b=JNEils/BMPtwGFtLfYaoxXFzz8W9uqHROyWcfGHPyxPv0Ss2TGLqDL6lAmXrKwASnS
         kj43ZPyPTBZJeSHiOkRrjOEvbxMoZb3m2NpWRc6nUGHnLFfGUOmbifbK5oSfecbRDGSZ
         2SDB1tSe7OZao5cOO4N0IyAKOfoZ3IWyIr8wsKSB+bcd9zxJ72KQxLV6E056L4FNFjc8
         1uQ1ytAgIPL21q2Idk9HLxTypBEtHXdbp/mIuAnrrAK/mNp1NzCUomVPXdZd4iwJ+8SO
         K6G6cXpmE775E9Ug29w+G+UTzH858+pRgsJpbt/Dg0OBN+MZKOw/IsI2NLsfUpTtI/5R
         x+TA==
X-Gm-Message-State: AA+aEWYnze7HnNgEavOk3X5CK9e9nK7mHvgOPu37jKBoMGgO7BLQkMFs
        jJ/SWB3/Nvh9wnHbvi0/OViVsw==
X-Google-Smtp-Source: AFSGD/XN7205RtAh0F05+bskUug8QE12PABhVueg38NbJtoYVaOcdMvh5YO/9h8N9/7eOlnkn8DizQ==
X-Received: by 2002:a02:a791:: with SMTP id e17mr18411185jaj.104.1544027148026;
        Wed, 05 Dec 2018 08:25:48 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k18sm8329522ioa.39.2018.12.05.08.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 08:25:46 -0800 (PST)
Subject: Re: [PATCH V9 1/4] blk-mq: insert to hctx dispatch list when
 bypass_insert is true
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1543995842-20704-1-git-send-email-jianchao.w.wang@oracle.com>
 <1543995842-20704-2-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <54c7377f-e8e6-92cf-eced-6c76297afd52@kernel.dk>
Date:   Wed, 5 Dec 2018 09:25:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543995842-20704-2-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/18 12:43 AM, Jianchao Wang wrote:
> We don't allow direct dispatch of anything but regular reads/writes
> and insert all of non-read-write requests. However, this is not
> correct for 'bypass_insert == true' case where inserting is ignored
> and BLK_STS_RESOURCE is returned. The caller will fail forever.
> 
> Fix it with inserting the non-read-write request to hctx dispatch
> list to avoid to involve merge and io scheduler when bypass_insert
> is true.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 9005505..153af90 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1822,6 +1822,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  {
>  	struct request_queue *q = rq->q;
>  	bool run_queue = true;
> +	bool force = false;
>  
>  	/*
>  	 * RCU or SRCU read lock is needed before checking quiesced flag.
> @@ -1836,9 +1837,19 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  		goto insert;
>  	}
>  
> -	if (!blk_rq_can_direct_dispatch(rq) || (q->elevator && !bypass_insert))
> +	if (q->elevator && !bypass_insert)
>  		goto insert;
>  
> +	if (!blk_rq_can_direct_dispatch(rq)) {
> +		/*
> +		 * For 'bypass_insert == true' case, insert request into hctx
> +		 * dispatch list.
> +		 */
> +		if (bypass_insert)
> +			force = true;
> +		goto insert;
> +	}

Just do force = bypass_insert, no need for the if.

-- 
Jens Axboe

