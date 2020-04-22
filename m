Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79B1C54FCB
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 15:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B98DF2073A
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 15:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgDVPLA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:11:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46664 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgDVPK7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 11:10:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id 145so1210961pfw.13;
        Wed, 22 Apr 2020 08:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BpWmzLO4boJS/3NuyjpxKLUJHU99G06c2WaRP9JRw3U=;
        b=pv1y3mvya9UT5qCckTHElRSTa/3ZxMp6OvEOz4YukVN8LvMBgBXvcqPjZt80R9hBCY
         KXopewmlKcgaz0/g59tHdTDQkbDfj8OfOcEQx4EFqEhwRjczzxc61FlQOjbnayBuV1cG
         vix3qtLpuZ+5GoPPA5lUewe8HqbredHNugBr9F1DmLEWdxHnVGiiSDsOAVMnOglmVnUF
         uXMqLAZRQqjfoW/F0Sp1/znTg8iOr2NMKUOLZ0SxGRRge/1SJFQ7gyjUruZikZ4O+AHq
         Lgrod/f/JCrk2nHfP8+nV7n0zZcouVPeM9sAyOXhTXcv+fTACimpOA5KcsiqgzOZnx1k
         iCGQ==
X-Gm-Message-State: AGi0PuYrCiFJ7VvyVE4R/Gq3jd7rSVDzCDE6bEBRtSbsQj6ZvXTAzFis
        BnT7QIEHmuAWgopa7vnWMjg=
X-Google-Smtp-Source: APiQypKxUUHnj/wIbVHs6Yr09dany3cagZOY3KdJIbbj3FYX6ZdtyChy0un+L44MwTvT/APFqhlYaw==
X-Received: by 2002:a65:4548:: with SMTP id x8mr26677950pgr.223.1587568258821;
        Wed, 22 Apr 2020 08:10:58 -0700 (PDT)
Received: from [100.124.11.187] ([104.129.198.222])
        by smtp.gmail.com with ESMTPSA id w9sm5990767pff.101.2020.04.22.08.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 08:10:58 -0700 (PDT)
Subject: Re: [PATCH 4/4] loop: Add LOOP_SET_FD_AND_STATUS ioctl.
To:     Martijn Coenen <maco@android.com>, axboe@kernel.dk, hch@lst.de,
        ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, Chaitanya.Kulkarni@wdc.com
References: <20200420080409.111693-1-maco@android.com>
 <20200420080409.111693-5-maco@android.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <9eaa4dc8-cd8f-a4e9-e83d-f49f8b00ec0e@acm.org>
Date:   Wed, 22 Apr 2020 08:10:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420080409.111693-5-maco@android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/20/20 1:04 AM, Martijn Coenen wrote:
> diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
> index 080a8df134ef..fcc9a693b588 100644
> --- a/include/uapi/linux/loop.h
> +++ b/include/uapi/linux/loop.h
> @@ -60,6 +60,11 @@ struct loop_info64 {
>   	__u64		   lo_init[2];
>   };
>   
> +struct loop_fd_and_status {
> +	struct loop_info64	info;
> +	__u32			fd;
> +};
> +
>   /*
>    * Loop filter types
>    */
> @@ -90,6 +95,7 @@ struct loop_info64 {
>   #define LOOP_SET_CAPACITY	0x4C07
>   #define LOOP_SET_DIRECT_IO	0x4C08
>   #define LOOP_SET_BLOCK_SIZE	0x4C09
> +#define LOOP_SET_FD_AND_STATUS	0x4C0A
>   
>   /* /dev/loop-control interface */
>   #define LOOP_CTL_ADD		0x4C80

Should linux-api be Cc'ed for this patch or the entire patch series? 
 From https://www.kernel.org/doc/man-pages/linux-api-ml.html: "Among 
other things, a primary goal of the list is to help answer the question: 
How do we even know when an interface has been added or changed?".

Thanks,

Bart.


