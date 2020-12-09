Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F51C4361B
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 16:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3C7323B52
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 16:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgLIQJO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 11:09:14 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33947 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgLIQJN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Dec 2020 11:09:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id g18so1485472pgk.1
        for <linux-block@vger.kernel.org>; Wed, 09 Dec 2020 08:08:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QKHzCLi3S5y+pko5MCKpdheE3F20cx2X8q2g9d6p4Eg=;
        b=XCgdiSbMiTagBmLXRT6A/fJ3UzN+N1s4iRQ5Wdw6WlvuGBz4ixJfyNgEkt5eqnbNyg
         xfJ5bK6Gm59gQdepaEmgDiN+YE4g+kaSBTSOhf6EkIk0sRIFBwDdBctWMFWiy2PbRmZH
         FZWG6igeYHiEEW3u5SxAYYvJcRrByI0a1kl7OHATG/IsNXuff0yHLwhZkEVR+kSnjWLg
         YNpEgWbZ0zGe3mf9Nwy4zi6a1LbqLa1cPDxS7PY5oX6TQwpBN7jhZ+qXPg6xfZXzzehg
         uP1j/FnmRXqNtEdmT30gIbEtNTGWgM3T8fypE5oZUFk0ofkk08fN+tG4wuSaMH1sUvyo
         cXDw==
X-Gm-Message-State: AOAM530z/scNn7+pBJFN2PtA61ZihUO+snzdBVA1tCZakF7Npcacq1OV
        TZ2PSB6y96GTGg7Hj9TOKv4=
X-Google-Smtp-Source: ABdhPJx0I+U13+bvperNt3mB49p+l1GlPr9eTR3DNVa3XzH5dQ384BdAJkbkvW5r8zUtVWTDPLQgmQ==
X-Received: by 2002:a62:6844:0:b029:198:4f13:e9b2 with SMTP id d65-20020a6268440000b02901984f13e9b2mr2975882pfc.29.1607530112703;
        Wed, 09 Dec 2020 08:08:32 -0800 (PST)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id z126sm2912896pfz.120.2020.12.09.08.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 08:08:31 -0800 (PST)
Subject: Re: [PATCH for-next 1/7] block/rnbd-clt: Get rid of warning regarding
 size argument in strlcpy
To:     Jack Wang <jinpu.wang@cloud.ionos.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        danil.kipnis@cloud.ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        kernel test robot <lkp@intel.com>
References: <20201209082051.12306-1-jinpu.wang@cloud.ionos.com>
 <20201209082051.12306-2-jinpu.wang@cloud.ionos.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <0452fc87-3205-c3ad-9957-84e5e7adf32b@acm.org>
Date:   Wed, 9 Dec 2020 08:08:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201209082051.12306-2-jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/9/20 12:20 AM, Jack Wang wrote:
> From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> 
> The kernel test robot triggerred the following warning,
> 
>>> drivers/block/rnbd/rnbd-clt.c:1397:42: warning: size argument in
> 'strlcpy' call appears to be size of the source; expected the size of the
> destination [-Wstrlcpy-strlcat-size]
> 	strlcpy(dev->pathname, pathname, strlen(pathname) + 1);
> 					      ~~~~~~~^~~~~~~~~~~~~
> 
> To get rid of the above warning, use a len variable for doing kzalloc and
> then strlcpy.
> 
> Fixes: 64e8a6ece1a5 ("block/rnbd-clt: Dynamically alloc buffer for pathname & blk_symlink_name")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>   drivers/block/rnbd/rnbd-clt.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index a199b190c73d..62b77b5dc061 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1365,7 +1365,7 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
>   				      const char *pathname)
>   {
>   	struct rnbd_clt_dev *dev;
> -	int ret;
> +	int len, ret;
>   
>   	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, NUMA_NO_NODE);
>   	if (!dev)
> @@ -1388,12 +1388,13 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
>   		goto out_queues;
>   	}
>   
> -	dev->pathname = kzalloc(strlen(pathname) + 1, GFP_KERNEL);
> +	len = strlen(pathname) + 1;
> +	dev->pathname = kzalloc(len, GFP_KERNEL);
>   	if (!dev->pathname) {
>   		ret = -ENOMEM;
>   		goto out_queues;
>   	}
> -	strlcpy(dev->pathname, pathname, strlen(pathname) + 1);
> +	strlcpy(dev->pathname, pathname, len);
>   
>   	dev->clt_device_id	= ret;
>   	dev->sess		= sess;

Please use kstrdup() instead of open-coding it.

Thanks,

Bart.


