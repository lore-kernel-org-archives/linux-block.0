Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDAFC433EF
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 20:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25CB60E8B
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 20:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhJ1UrI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:47:08 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:43704 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhJ1UrI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 16:47:08 -0400
Received: by mail-pg1-f174.google.com with SMTP id b4so574736pgh.10;
        Thu, 28 Oct 2021 13:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8KCR3llTsNC/EmVOsfOprBNdpwIqMeBDoZEp27pTMi8=;
        b=JVx6EWJZXVrKsB2A3yuzYip67Qj7eYbMBZMah8PIQs0bmyIn4zswwBEDvDvUc/1/zt
         iaRUC5R6/0NwAOe/ybCWqiD2onDcnwhcuh2XT6VY6VcG/8zt1UXmMnMqSZZ4RmdVDYtI
         7NON1Ngcoitxj0Gchu7T3VVEP2nGdROSZYzixXu+CrNzZAMXMFH28rjAdREfuINyEesy
         1IXsUR5e0gmTe5RGFL7gTr79zeztJV5SYi1IT+ReN38RfMkXwkHq2Ea4IsYMa9eRWW0K
         f8iAsyxCYA67MVDXnZv0P1r/XIHWo31MgBEQZjQM4YCzzTh+oS6kC5AfJsIcMjyzih/e
         yA0w==
X-Gm-Message-State: AOAM533zpOWtk1jqiC9m/TNehhzvyNAgaZw8ghAcwoBynw0J0lobHCl+
        xzd9EEwCCDW3jgSHo38Pza6SBjorhcjpxg==
X-Google-Smtp-Source: ABdhPJzoENSGqL8QXsdXUGjZjVGz2Ebjj1mHxs++PsMoJrnpxpe82+qU+mdjEQU1bdtNqaGXnrjzSA==
X-Received: by 2002:a05:6a00:23c8:b0:47c:37d5:430 with SMTP id g8-20020a056a0023c800b0047c37d50430mr6624529pfc.72.1635453880334;
        Thu, 28 Oct 2021 13:44:40 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:e816:bd0d:426c:f959])
        by smtp.gmail.com with ESMTPSA id u12sm3637773pfi.18.2021.10.28.13.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 13:44:39 -0700 (PDT)
Subject: Re: [PATCH] zram: use ATTRIBUTE_GROUPS
To:     Luis Chamberlain <mcgrof@kernel.org>, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20211028203600.2157356-1-mcgrof@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <520834ee-edd2-282c-017a-b7ed075bd8a0@acm.org>
Date:   Thu, 28 Oct 2021 13:44:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211028203600.2157356-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/21 1:36 PM, Luis Chamberlain wrote:
> Embrace ATTRIBUTE_GROUPS to avoid boiler plate code.
> This should not introduce any functional changes.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   drivers/block/zram/zram_drv.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index fcaf2750f68f..268f727f7cba 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1874,14 +1874,7 @@ static struct attribute *zram_disk_attrs[] = {
>   	NULL,
>   };
>   
> -static const struct attribute_group zram_disk_attr_group = {
> -	.attrs = zram_disk_attrs,
> -};
> -
> -static const struct attribute_group *zram_disk_attr_groups[] = {
> -	&zram_disk_attr_group,
> -	NULL,
> -};
> +ATTRIBUTE_GROUPS(zram_disk);
>   
>   /*
>    * Allocate and initialize new zram device. the function returns
> @@ -1953,7 +1946,7 @@ static int zram_add(void)
>   		blk_queue_max_write_zeroes_sectors(zram->disk->queue, UINT_MAX);
>   
>   	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, zram->disk->queue);
> -	device_add_disk(NULL, zram->disk, zram_disk_attr_groups);
> +	device_add_disk(NULL, zram->disk, zram_disk_groups);
>   
>   	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
>   
> 

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
