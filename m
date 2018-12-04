Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADABC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 14:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D2D2081C
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 14:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D2D2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbeLDOs6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:48:58 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40937 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeLDOs6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 09:48:58 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so8315853pfo.7
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 06:48:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j1A5GTKV0w9XCkA0YUkty+u5HjqDrdtu+egm3oO5Oqs=;
        b=L70YXPLI4mTp0IUrHVxn+v/+NUVAYKtlPW4u18oTdk+xh4I6PSeekJH5eZ35eLZLF+
         NI8W+TBPG4/YlRCHF0522CK9lSmy8w5/50qOYYv0rpj5NJAcxVjIWNVqFaWepx/9vZQm
         g/TiuLae57RWAxeIFuz4RlZxJqS4JbpwBHwk0DSp9LtPWUrxCVFUd+NkP5j54/KkxBkb
         vBU1w6Yx+/XO09S3evwVbMToblf9M0OZ8KZCr2TElmbGQ4j3regd9eYZgia992EnCfA/
         NBFN8WmZtoQX3JZO8YQkJaqixKa9INLIN3nRA4XErgSIwCJKQHlvrcNOxa017cjK7nlq
         Bj7w==
X-Gm-Message-State: AA+aEWZygK2KPw1FIpxIW9qpeQi/RaNA1Yrvfe3JgebeZQXR5Sdoj+qu
        460TpPr3f9+4TdpfAAL4VOTEGD7Op6s=
X-Google-Smtp-Source: AFSGD/Uuhb8JlpsW+iHg8K9r0kx32woSVyAHQmoKk/FZj2EV3cLWnFFnzfrYMGiPMnHofJfMYa50Qw==
X-Received: by 2002:a62:2c4d:: with SMTP id s74mr20109341pfs.6.1543934937300;
        Tue, 04 Dec 2018 06:48:57 -0800 (PST)
Received: from asus.site (c-24-7-51-64.hsd1.ca.comcast.net. [24.7.51.64])
        by smtp.gmail.com with ESMTPSA id f20sm9327953pfn.177.2018.12.04.06.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 06:48:56 -0800 (PST)
Subject: Re: [PATCH] blk-mq: Set request mapping to NULL in
 blk_mq_put_driver_tag
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>
References: <CAHsXFKFOBSmZeT9j7U2S6J4Af2k2ODe_pkFVGJg73v0Wp7O38A@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7e8e1fe2-9f91-a370-a98c-43cdad1f6e8e@acm.org>
Date:   Tue, 4 Dec 2018 06:48:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAHsXFKFOBSmZeT9j7U2S6J4Af2k2ODe_pkFVGJg73v0Wp7O38A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/4/18 2:00 AM, Kashyap Desai wrote:
> Problem statement :
> Whenever try to get outstanding request via scsi_host_find_tag,
> block layer will return stale entries instead of actual outstanding
> request. Kernel panic if stale entry is inaccessible or memory is reused.
> Fix :
> Undo request mapping in blk_mq_put_driver_tag  nce request is return.
> 
> More detail :
> Whenever each SDEV entry is created, block layer allocate separate tags
> and static requestis.Those requests are not valid after SDEV is deleted
> from the system. On the fly, block layer maps static rqs to rqs as below
> from blk_mq_get_driver_tag()
> 
> data.hctx->tags->rqs[rq->tag] = rq;
> 
> Above mapping is active in-used requests and it is the same mapping which
> is referred in function scsi_host_find_tag().
> After running some IOs, “data.hctx->tags->rqs[rq->tag]” will have some
> entries which will never be reset in block layer.
> 
> There would be a kernel panic, If request pointing to
> “data.hctx->tags->rqs[rq->tag]” is part of “sdev” which is removed
> and as part of that all the memory allocation of request associated with
> that sdev might be reused or inaccessible to the driver.
> Kernel panic snippet -
> 
> BUG: unable to handle kernel paging request at ffffff8000000010
> IP: [<ffffffffc048306c>] mpt3sas_scsih_scsi_lookup_get+0x6c/0xc0 [mpt3sas]
> PGD aa4414067 PUD 0
> Oops: 0000 [#1] SMP
> Call Trace:
>   [<ffffffffc046f72f>] mpt3sas_get_st_from_smid+0x1f/0x60 [mpt3sas]
>   [<ffffffffc047e125>] scsih_shutdown+0x55/0x100 [mpt3sas]
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> 
> 
> ---
>   block/blk-mq.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 9497b47..57432be 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -175,6 +175,7 @@ static inline bool
> blk_mq_get_dispatch_budget(struct blk_mq_hw_ctx *hctx)
>   static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
>                          struct request *rq)
>   {
> +    hctx->tags->rqs[rq->tag] = NULL;
>       blk_mq_put_tag(hctx, hctx->tags, rq->mq_ctx, rq->tag);
>       rq->tag = -1;

No SCSI driver should call scsi_host_find_tag() after a request has 
finished. The above patch introduces yet another race and hence can't be 
a proper fix.

Bart.

