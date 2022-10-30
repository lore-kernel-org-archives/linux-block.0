Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D95C38A02
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 14:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJ3Oeh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 10:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJ3Oeh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 10:34:37 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9297BBF2;
        Sun, 30 Oct 2022 07:34:36 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id 128so8728288pga.1;
        Sun, 30 Oct 2022 07:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PwtAcHtc6yLnZbhGC85c6PLtOyAHelbRXALxsdVihxI=;
        b=b9YQhcyOKyBuCMOEKykgbREREJlMJgKn06EWbtoFfSKxdxSSi3D1R8yIQNdj19MQ1x
         TRd5+PM6oUG6D+9hb318Fik5Aiu7ElbEgSi7xqXauiVT3NVT5052E/TogzMWaD/zkb9T
         WVmch41mKHI7rK+nW7cujE0vuGdD8no3obN8bWXUbHLhflSvyVMq3aCxjtRgvTG/6H/B
         zdUVwXZY2gBRciUQ0vhYGxvHbo+ipnWZpUIP7JnzYSb5nXrDC+S1XK/dt7e49cYsHZf9
         6CAFSlfFl1j4w1MDHV71cudLQ8Xq9PjYZUM6BHsh0j/73O2PkKC+OuUUAPebgiU9cekv
         cXqw==
X-Gm-Message-State: ACrzQf3DPPzU8/5DMkKyUIWRHnnsryYS/yMXfzYiG8mAamyQw5X6kTTv
        vY9IYRMaxa7zAoBJ0CYHaRY=
X-Google-Smtp-Source: AMsMyM77LDjzcypLTJqH89+d0uebd97PRr/em96noLJ+aWRgw5bU6yxO36oFKhzHWpuTIBEMoQkOHg==
X-Received: by 2002:a05:6a00:15c8:b0:565:bc96:1c5b with SMTP id o8-20020a056a0015c800b00565bc961c5bmr9481293pfu.52.1667140475947;
        Sun, 30 Oct 2022 07:34:35 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090a6a8900b00205d85cfb30sm2472077pjj.20.2022.10.30.07.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 07:34:34 -0700 (PDT)
Message-ID: <8fdbe81c-8f43-40bb-91b8-d5c8c978fbad@acm.org>
Date:   Sun, 30 Oct 2022 07:34:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3] block: simplify blksize_bits() implementation
Content-Language: en-US
To:     Dawei Li <set_pte_at@outlook.com>, axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <TYCP286MB23238842958D7C083D6B67CECA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <TYCP286MB23238842958D7C083D6B67CECA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/29/22 22:20, Dawei Li wrote:
> @@ -1349,12 +1349,7 @@ static inline int blk_rq_aligned(struct request_queue *q, unsigned long addr,
>   /* assumes size > 256 */
>   static inline unsigned int blksize_bits(unsigned int size)
>   {
> -	unsigned int bits = 8;
> -	do {
> -		bits++;
> -		size >>= 1;
> -	} while (size > 256);
> -	return bits;
> +	return order_base_2(size >> SECTOR_SHIFT) + SECTOR_SHIFT;
>   }

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
