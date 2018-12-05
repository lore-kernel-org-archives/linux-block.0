Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C895EC04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 16:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B67C2064D
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 16:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DQjAxKcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B67C2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeLEQ1J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:27:09 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38349 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeLEQ1J (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 11:27:09 -0500
Received: by mail-io1-f68.google.com with SMTP id l14so17161932ioj.5
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 08:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hcuc9dp/H5uwlbzrtVWkhbyE/HLJWQrwzdBHtDxRfr0=;
        b=DQjAxKcL8UfL6LYkPg6EPYXThPrggV6zCMPmyQbEWgL1Vnu1k2aRDO8oNapvQHTr2/
         JmmK3c7XAH7ga27pW70m88CR5uBiFq0kAjiTLeaY081LhZl69bykTqTt7icLSVi6IjgT
         zBs2jXJMa78eSJ5rBocUbdtqEUTnpdTEPMMw+ePjZqlsE0p6LhuhwyO6DycSBT4CMm8S
         +6rTqMxjAVwe3mNUuoBP3x02USLFFNoopsgMaKiI7hB8GIziaZqRpITFbcmf09witHpP
         KUIx90JEolmXP75vGoV2iy+3eHQHYg0MNi9tpfOmXR7ia0g12C+rUmRblL1uVxz8L1Ue
         k/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hcuc9dp/H5uwlbzrtVWkhbyE/HLJWQrwzdBHtDxRfr0=;
        b=L0Axhl46M0rcQd76uuhkOGjJBEQL/p0E7hDqjnnLt8+/KUy/lvXC8MWoxx0FUcvnYa
         GaVFJGCsO8JMyMs3jqV8MqyNC90IeFi1Zoao8iszuTvLlpYjWg8lg/xXsKTxPBTg+Qr6
         +llz86d7MD0+PqOFXqcjQ7rPCp4nwD7VfiqNbgWw+Tw5HbDiZlX5MQni/9LtAlmi5qdw
         PORkpfanmDMBjxiWBTw8hFLxwsVN4XXQWpug/upsFANCxt47XxDHs0NDrAJlI4DBYNs0
         ly5F2zAXisNPATLNds0U01MkXs71ZbnXWuNvvga5xZNfFOWsPOGJPN+dwLMtxinwS+OV
         OXVg==
X-Gm-Message-State: AA+aEWYz/PADOZY6S1iRsSFgaOSv9vnqQsvACfr0kL/GoIywvWiXJl3q
        vCmb0reeMj5cAwWPd+6y+UwgSA==
X-Google-Smtp-Source: AFSGD/WwVm2gCmbADAfYbV5YysnLgjKdLJKh4Uc8H7F61qdb5LOnskllqehlmDvn+u3Y/4PXdyPPSA==
X-Received: by 2002:a6b:4a09:: with SMTP id w9mr22445165iob.260.1544027228198;
        Wed, 05 Dec 2018 08:27:08 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id d199sm7237254itd.31.2018.12.05.08.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 08:27:07 -0800 (PST)
Subject: Re: [PATCH V9 2/4] blk-mq: refactor the code of issue request
 directly
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1543995842-20704-1-git-send-email-jianchao.w.wang@oracle.com>
 <1543995842-20704-3-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d46af0a7-62f3-4988-2b1c-857378282356@kernel.dk>
Date:   Wed, 5 Dec 2018 09:27:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543995842-20704-3-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/18 12:44 AM, Jianchao Wang wrote:
> Merge blk_mq_try_issue_directly and __blk_mq_try_issue_directly
> into one interface to unify the interfaces to issue requests
> directly. The merged interface takes over the requests totally,
> it could insert, end or do nothing based on the return value of
> .queue_rq and 'bypass' parameter. Then caller needn't any other
> handling any more and then code could be cleaned up.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq.c | 116 +++++++++++++++++++++++++++------------------------------
>  1 file changed, 54 insertions(+), 62 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 153af90..fe92e52 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1815,93 +1815,85 @@ static bool blk_rq_can_direct_dispatch(struct request *rq)
>  	return req_op(rq) == REQ_OP_READ || req_op(rq) == REQ_OP_WRITE;
>  }
>  
> -static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> +static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  						struct request *rq,
>  						blk_qc_t *cookie,
> -						bool bypass_insert, bool last)
> +						bool bypass, bool last)
>  {
>  	struct request_queue *q = rq->q;
>  	bool run_queue = true;
> +	blk_status_t ret = BLK_STS_RESOURCE;
> +	int srcu_idx;
>  	bool force = false;
>  
> +	if (!blk_rq_can_direct_dispatch(rq)) {
> +		/*
> +		 * Insert request to hctx dispatch list for 'bypass == true'
> +		 * case, otherwise, the caller will fail forever.
> +		 */
> +		if (bypass)
> +			force = true;
> +		goto out;
> +	}

Same here, of course.

Otherwise looks fine.

-- 
Jens Axboe

