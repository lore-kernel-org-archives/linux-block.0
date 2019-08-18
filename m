Return-Path: <SRS0=gctd=WO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E39C3A589
	for <linux-block@archiver.kernel.org>; Sun, 18 Aug 2019 16:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC83206BB
	for <linux-block@archiver.kernel.org>; Sun, 18 Aug 2019 16:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfHRQ1e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Aug 2019 12:27:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37284 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfHRQ1e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Aug 2019 12:27:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id 129so5704230pfa.4;
        Sun, 18 Aug 2019 09:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EFk48uP0761tkL5eYL2TXTPQ7z/zsmg3gLwgJoDWpVQ=;
        b=R+IU/8ijDgdZBv253hDTPuzySHADymmtqI70StWigaVbUaNIsvq1mIw8T5+Q2t0bzV
         ddB4KnNZ8l8vIArhRRbaOFP4ykgcSVpmlo5nQfwwrExXjDlqvuruCbHhmPSwrcIi/rzd
         zt+UR3zFXCl0MWvPxP98ynT7Do9PLrmu7nwq7HRr6SODSkrHF0psvoVJdeigJ9Xob+VJ
         XK3/FHjsdMH4CSJqSZOO+vizyB1lFl0vAVZkPVDhLR9vOOJ7/1G+t1hCFbuRMAa3bsOE
         MqO1L67GONTuy1vZrSTIBsi/zCy5ANcH4HwKha5my/PHZ5+ocrffMayW0tHf1dV8wLzM
         vw6w==
X-Gm-Message-State: APjAAAVQmZZa7AB5s+xoOgnTsRj7A7HdKKDrdeX/YXLF30noEO9HvSaW
        6JSOTpxhgnFhn/YfTS1V68mbWv6D
X-Google-Smtp-Source: APXvYqwtjNnuLw3QPb//i0mvrIRcO11jmYRX3tm/nCe5PzECCN2ZtIcSYmpqvnENrrONam/0Skyisw==
X-Received: by 2002:a63:2a08:: with SMTP id q8mr16157575pgq.415.1566145652860;
        Sun, 18 Aug 2019 09:27:32 -0700 (PDT)
Received: from asus.site ([2601:647:4001:9688:7239:73c8:e524:4c7f])
        by smtp.gmail.com with ESMTPSA id y22sm14119905pfo.39.2019.08.18.09.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2019 09:27:31 -0700 (PDT)
Subject: Re: [PATCH] block/bio-integrity: fix mismatched alloc free
To:     Pan Bian <bianpan2016@163.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1566124514-3507-1-git-send-email-bianpan2016@163.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <843c93c2-4d83-c625-eec6-d0b7ca10a2c8@acm.org>
Date:   Sun, 18 Aug 2019 09:27:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566124514-3507-1-git-send-email-bianpan2016@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/18/19 3:35 AM, Pan Bian wrote:
> The function kmalloc rather than mempool_alloc is called to allocate
> memory when the memory pool is unavailable. However, mempool_alloc is
> used to release the memory chunck in both cases when error occurs. This
> patch fixes the bug.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>   block/bio-integrity.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index fb95dbb..011dfc8 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -75,7 +75,10 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
>   
>   	return bip;
>   err:
> -	mempool_free(bip, &bs->bio_integrity_pool);
> +	if (!bs || !mempool_initialized(&bs->bio_integrity_pool))
> +		kfree(bip);
> +	else
> +		mempool_free(bip, &bs->bio_integrity_pool);
>   	return ERR_PTR(-ENOMEM);
>   }
>   EXPORT_SYMBOL(bio_integrity_alloc);
> 

Also for this patch, please add "Fixes:" and "Cc: stable" tags.

Thanks,

Bart.
