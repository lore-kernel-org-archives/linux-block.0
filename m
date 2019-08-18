Return-Path: <SRS0=gctd=WO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5D2C3A589
	for <linux-block@archiver.kernel.org>; Sun, 18 Aug 2019 16:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751282064A
	for <linux-block@archiver.kernel.org>; Sun, 18 Aug 2019 16:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfHRQ0r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Aug 2019 12:26:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38079 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfHRQ0r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Aug 2019 12:26:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id e11so5482264pga.5;
        Sun, 18 Aug 2019 09:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qIaIZVb2KQ3q+RWZdfC+4X1CdKLZAbtGRiEqmBWlwsw=;
        b=ccsnOd99sa/GubGLxoTwkNCRq6B9RhyVg/I83diGayfDZHGnr6JhC7evaZIHF9WiV6
         Rggey5kr0xrgHkde3W0cOKC+AcSR3EkjEkqRz1WnTrjzSuyk56e1ehshRKnNwvlP1b3u
         gC7tVntHzctyqZUqC7jkhkb3LCxFD1hTDGU8AAhNRtRmup7fwxupwgrmXVbjKLuGUgQs
         /kRrvH372P8AK0whUlD7P1AJ7do3y73PdEZv2awstcLy1DnjWwXnU6e8ceD59uXLY2BE
         tTj0+2/TDn92dyTQ+PXRObE5wpmxsuSO0itKv6WSX2XeMFyNxEaB2Ead0aoLuIqnbX0b
         iXrA==
X-Gm-Message-State: APjAAAXNMGywGrvzsUuHgfN44CIMgu5a8LTTludr/K270UNvtowhVMel
        yhsuUz/2eUzgLEvAhwyHZVrVgd23
X-Google-Smtp-Source: APXvYqwlSwDiw94/I1cxF1rgyxIbPvcVrdkN4t0vdD/EOUFxna+BGjoLF6YyjHKkwy/U5sage0Y33A==
X-Received: by 2002:a17:90a:fa82:: with SMTP id cu2mr17229343pjb.85.1566145606042;
        Sun, 18 Aug 2019 09:26:46 -0700 (PDT)
Received: from asus.site ([2601:647:4001:9688:7239:73c8:e524:4c7f])
        by smtp.gmail.com with ESMTPSA id f27sm11714854pgm.60.2019.08.18.09.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2019 09:26:44 -0700 (PDT)
Subject: Re: [PATCH] block: fix a mismatched alloc free in bio_alloc_bioset
To:     Pan Bian <bianpan2016@163.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1566125837-17543-1-git-send-email-bianpan2016@163.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a7c09fbd-44a0-6541-ce1b-7fe03fcd43bf@acm.org>
Date:   Sun, 18 Aug 2019 09:26:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566125837-17543-1-git-send-email-bianpan2016@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/18/19 3:57 AM, Pan Bian wrote:
> The function kmalloc is called to allocate memory if bs is NULL.
> However, mempool_free is used to release the memory chunk even if bs is
> NULL in the error hanlding code. This patch checks bs and use the
> correct function to release memory.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>   block/bio.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 299a0e7..c5f5238 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -515,7 +515,10 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned int nr_iovecs,
>   	return bio;
>   
>   err_free:
> -	mempool_free(p, &bs->bio_pool);
> +	if (!bs)
> +		kfree(p);
> +	else
> +		mempool_free(p, &bs->bio_pool);
>   	return NULL;
>   }
>   EXPORT_SYMBOL(bio_alloc_bioset);
> 

Please add "Fixes:" and "Cc: stable" tags. See also 
Documentation/process/submitting-patches.rst.

Thanks,

Bart.
