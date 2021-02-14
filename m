Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF0FC433DB
	for <linux-block@archiver.kernel.org>; Sun, 14 Feb 2021 10:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F26B64DCF
	for <linux-block@archiver.kernel.org>; Sun, 14 Feb 2021 10:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhBNKdF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Feb 2021 05:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhBNKdE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Feb 2021 05:33:04 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C99C061574
        for <linux-block@vger.kernel.org>; Sun, 14 Feb 2021 02:32:24 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id t5so4757567eds.12
        for <linux-block@vger.kernel.org>; Sun, 14 Feb 2021 02:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=ISzN9d7P2x4PijRdxMa0iYXCQ4Is1R13tpOV8I2wS7I=;
        b=dWoJEGWiR69vq1xXXEUCBXuPy+jQK0OFt8Vj9EMR+W193YHqJaTU3zWs2+bgrOwkA5
         bjQnxQXb6OrgLEt6/fob2VKe+JQuj25X8mO1arH8j8zK0GPCJX8LyGv6bUxf7hJsXuxp
         QuNirbnoQTwgUagXelst8n+D3pK+t7eV2C6HPPzjIRR9gpYBWgRYWurIClcFFxvO3CoR
         bhzfFvzyH2xwKul2lyqEz2NsWcbTcE5sfZmBdbwXpTidyyPHWtgwE4s6e2odcICB4oSZ
         acbv05GgHrRH7ILlpm6B+gs8gEUwCmmbIIWMw5Msa5rzg4M9P880vtW5Tmlf/SEyfuNE
         9tiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ISzN9d7P2x4PijRdxMa0iYXCQ4Is1R13tpOV8I2wS7I=;
        b=eebaeZX6znPA4RntbGUXD90sEHnhE3maLiI3WvB1/sApAqUR22sE50WDpZZj/7NVPc
         ryN3TaJ73kFLXviniRq2/Gy5iwWMyCIA3fJY+GbOFixSSMpJQLlpmgANTCq67LjQmTog
         Ns2xXcaBKlmXRL9N6dqw4bez3CTIcGGvqf14JWnjFznOtgoLZpOUvnTL+1tBby2K1hor
         PYZaZ5Qc3Boe+yzHi6COTRX/ZaFBfwYBWx70XOX2QlxupMrX0epZvNrWj3tMxWtPz20t
         ILXH43aCkbUtp/AQiKDRLxv9PKtlpw23PrOPNHG6ASjcFhjDJ4Ogk0xA3fv7TJv7UvSs
         dUow==
X-Gm-Message-State: AOAM5306QwNz8llmgMBEfWg9lnAkqMtQsSa5pIb+Z+Oto9evZf/YF+6y
        +kwfJHsJtsG0SHQEobBitzb6XQ==
X-Google-Smtp-Source: ABdhPJzy6MzqcvbL969Y7Od6Sj58zRVzxgcSCqKL4oerZ7KiXPhRiHDO+u4/sjeicno1p3Kogqw6xA==
X-Received: by 2002:a05:6402:216:: with SMTP id t22mr9226803edv.168.1613298742933;
        Sun, 14 Feb 2021 02:32:22 -0800 (PST)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id t9sm8602827ejc.51.2021.02.14.02.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Feb 2021 02:32:22 -0800 (PST)
Subject: Re: [PATCH v1] lightnvm: pblk: Replace guid_copy() with
 export_guid()/import_guid()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20210209164219.53849-1-andriy.shevchenko@linux.intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <beb04551-110d-3646-faf9-7fc4ae8d2bdf@lightnvm.io>
Date:   Sun, 14 Feb 2021 11:32:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210209164219.53849-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09/02/2021 17.42, Andy Shevchenko wrote:
> There is a specific API to treat raw data as GUID, i.e. export_guid()
> and import_guid(). Use them instead of guid_copy() with explicit casting.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/lightnvm/pblk-core.c     | 5 ++---
>   drivers/lightnvm/pblk-recovery.c | 3 +--
>   2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 1dddba11e721..33d39d3dd343 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -988,7 +988,7 @@ static int pblk_line_init_metadata(struct pblk *pblk, struct pblk_line *line,
>   	bitmap_set(line->lun_bitmap, 0, lm->lun_bitmap_len);
>   
>   	smeta_buf->header.identifier = cpu_to_le32(PBLK_MAGIC);
> -	guid_copy((guid_t *)&smeta_buf->header.uuid, &pblk->instance_uuid);
> +	export_guid(smeta_buf->header.uuid, &pblk->instance_uuid);
>   	smeta_buf->header.id = cpu_to_le32(line->id);
>   	smeta_buf->header.type = cpu_to_le16(line->type);
>   	smeta_buf->header.version_major = SMETA_VERSION_MAJOR;
> @@ -1803,8 +1803,7 @@ void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
>   
>   	if (le32_to_cpu(emeta_buf->header.identifier) != PBLK_MAGIC) {
>   		emeta_buf->header.identifier = cpu_to_le32(PBLK_MAGIC);
> -		guid_copy((guid_t *)&emeta_buf->header.uuid,
> -							&pblk->instance_uuid);
> +		export_guid(emeta_buf->header.uuid, &pblk->instance_uuid);
>   		emeta_buf->header.id = cpu_to_le32(line->id);
>   		emeta_buf->header.type = cpu_to_le16(line->type);
>   		emeta_buf->header.version_major = EMETA_VERSION_MAJOR;
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 299ef47a17b2..0e6f0c76e930 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -706,8 +706,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
>   
>   		/* The first valid instance uuid is used for initialization */
>   		if (!valid_uuid) {
> -			guid_copy(&pblk->instance_uuid,
> -				  (guid_t *)&smeta_buf->header.uuid);
> +			import_guid(&pblk->instance_uuid, smeta_buf->header.uuid);
>   			valid_uuid = 1;
>   		}
>   

Thanks, Andy. I've pulled it.

