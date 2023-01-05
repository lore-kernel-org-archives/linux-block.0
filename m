Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00C5C3DA7A
	for <linux-block@archiver.kernel.org>; Thu,  5 Jan 2023 21:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbjAEV2p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Jan 2023 16:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbjAEV2j (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Jan 2023 16:28:39 -0500
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078446319C
        for <linux-block@vger.kernel.org>; Thu,  5 Jan 2023 13:28:39 -0800 (PST)
Received: by mail-pg1-f170.google.com with SMTP id 141so7055344pgc.0
        for <linux-block@vger.kernel.org>; Thu, 05 Jan 2023 13:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4NfHQbVjBXzSTS5DZsdkkWWss5p6l1QMhBCl8oIS3Sk=;
        b=FoNi7/sz+D78WNlMX6HEyhSskqwuYlxOYCiPIl5yXbq/Ixb3La0UlRYwbt6hliM+2q
         /uqLkJvl2Zz/5yvXZW0YnXLIB/6CGv6zSYqR2U4GcuKACgv+VJLv721BGGB6gk0DxlCr
         DEF8IHQkGBcFE9BTFSS6Vhoda19F4rqcjFcfkOVfpQkVZQjbvz4b2UirL/l9LdUeoKj+
         5SOfFR2fDadBUQ3ZY9wfYe61m8LDSEALYmGdS2Gc2vOHk5WSRSGSniV/n8xhYiHNbMnm
         HuDI3z1u50kTinAo1XczAnyC5j7tw4xixWGFqtLuiOJxv2Ago0t7RM6aDPQ7qb/iQrA1
         g2DQ==
X-Gm-Message-State: AFqh2kr81e/0KiqB5Thr4+ib4X5ok+3au6bPAhiAcjqsBINPyIXHKwDy
        Z0u2cJgkYMZXcbpYGst+pFk=
X-Google-Smtp-Source: AMrXdXsaXd8EEdkVUSDtZAcZai0ijdOMvBKRzMxOLgcy6ngM2JH4zdsNyirF2sY90hp1AqbiVML+FQ==
X-Received: by 2002:aa7:96ba:0:b0:583:1dc6:2aef with SMTP id g26-20020aa796ba000000b005831dc62aefmr4611592pfk.34.1672954118255;
        Thu, 05 Jan 2023 13:28:38 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:f9eb:49b6:75b:111e? ([2620:15c:211:201:f9eb:49b6:75b:111e])
        by smtp.gmail.com with ESMTPSA id y17-20020a626411000000b00575b6d7c458sm24799602pfb.21.2023.01.05.13.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 13:28:37 -0800 (PST)
Message-ID: <fff1ca57-b0ee-9598-9ea8-e6c8b7571f0d@acm.org>
Date:   Thu, 5 Jan 2023 13:28:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCHv4 2/2] block: save user max_sectors limit
Content-Language: en-US
To:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     hch@lst.de, martin.petersen@oracle.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>
References: <20230105205146.3610282-1-kbusch@meta.com>
 <20230105205146.3610282-3-kbusch@meta.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230105205146.3610282-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/5/23 12:51, Keith Busch wrote:
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 93d9e9c9a6ea8..5486b6c57f6b8 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -239,19 +239,28 @@ static ssize_t queue_zone_append_max_show(struct request_queue *q, char *page)
>   static ssize_t
>   queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
>   {
> -	unsigned long max_sectors_kb,
> +	unsigned long var;
> +	unsigned int max_sectors_kb,
>   		max_hw_sectors_kb = queue_max_hw_sectors(q) >> 1,
>   			page_kb = 1 << (PAGE_SHIFT - 10);
> -	ssize_t ret = queue_var_store(&max_sectors_kb, page, count);
> +	ssize_t ret = queue_var_store(&var, page, count);
>   
>   	if (ret < 0)
>   		return ret;
>   
> -	max_hw_sectors_kb = min_not_zero(max_hw_sectors_kb, (unsigned long)
> +	max_sectors_kb = (unsigned int)var;

Shouldn't this function report an error if 'var' is too large to fit 
into an unsigned int?

Otherwise this patch looks good to me.

Thanks,

Bart.
