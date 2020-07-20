Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BCEC433E4
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 15:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A91722482
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 15:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EAv08AAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgGTPuB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730607AbgGTPuA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 11:50:00 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD9AC061794
        for <linux-block@vger.kernel.org>; Mon, 20 Jul 2020 08:50:00 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id r12so13702160ilh.4
        for <linux-block@vger.kernel.org>; Mon, 20 Jul 2020 08:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=000p9cJgkHytT1bjFsds7jdJx3x+bhAJTftHYJHfqk0=;
        b=EAv08AAtv6/hkJTPHZKeHF4AP03PqSo8hMQgTayUFFdgBbvpbPJXn8ZbaR4oxtkrfA
         icdooQDCsN38RQ+Voeu4DeQMOakltrDB9ZNdofwPHQSGlGAKUvdCPHLvTKWEnXGUS/hf
         U+OvOkU8q14jRnMS7GlbYxs8ajPw3I/ItJ8lrjRaqOXX+ufDBVzrpxlLY4+vBwQUpc8U
         6cnM/x6YtYDN56jfUkB/9McyLcvTWl6YlgVHqNnLTkeRYaOt1GPGzEYLV208ukSL49Te
         NvpjJqAzAD6du21I9aUJEztgbILxbYuCSad89DHC31UinlaxywL4i04MsMHa0ad9ugN4
         twuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=000p9cJgkHytT1bjFsds7jdJx3x+bhAJTftHYJHfqk0=;
        b=k/A4nnCbiWGJ0mQG2qSfeApitLKkqLaaR8n9MqcQ1y0Bxpr+SPZan+MODsqGofyvR0
         df15Na0MH72p5Q+Jj6I8cxQfAk+2nqz5u+Z4oNk2b3JPt0HG5DLW+BRuD/Sv//GCtP1X
         IB63XZMRivXPrOOft7lRKDA708BPE0Aq5BjVatq7TwEfpZ4EVAEUzZNCEXvnwuoVPfwn
         GOGi8o9nyZ0aynOnNO8lt+KATUVe27mNFbuyPnl6+DK/mO8oznLJk+XMNeAXMlNpzJ3f
         Cn8BIihX9Pvs2nPyDDIslW1fSVtarnGKFjXsso4yJSQH0sHhaseas96av7PKY4ZIWUsW
         F0ng==
X-Gm-Message-State: AOAM531X8om0Bs/5LZ2ngAPIhWfcbdZq6jHahQVKpaOFQLObDt5s4G/O
        pdZFUCBQsweWrdRfuwG44V2CPuIGM44fSQ==
X-Google-Smtp-Source: ABdhPJw9MPJLfLFKqHWIzg2iIkrzdrHtM2efhugCJJyDMPyoP+EOJTMyRu+KaJ9gMC0qbHjmyf6u4g==
X-Received: by 2002:a92:dc90:: with SMTP id c16mr23905340iln.202.1595260199528;
        Mon, 20 Jul 2020 08:49:59 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u15sm9147739iog.18.2020.07.20.08.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 08:49:58 -0700 (PDT)
Subject: Re: [PATCH v2] block: delete unused Kconfig
To:     Jiufei Xue <jiufei.xue@linux.alibaba.com>, tj@kernel.org
Cc:     linux-block@vger.kernel.org
References: <1595233988-28342-1-git-send-email-jiufei.xue@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c889122c-890e-405b-8f93-0affd2882c6b@kernel.dk>
Date:   Mon, 20 Jul 2020 09:49:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595233988-28342-1-git-send-email-jiufei.xue@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/20/20 2:33 AM, Jiufei Xue wrote:
> Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
> ---
>  block/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/block/Kconfig b/block/Kconfig
> index 9357d73..d52c9bc 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -146,7 +146,6 @@ config BLK_CGROUP_IOLATENCY
>  config BLK_CGROUP_IOCOST
>  	bool "Enable support for cost model based cgroup IO controller"
>  	depends on BLK_CGROUP=y
> -	select BLK_RQ_IO_DATA_LEN
>  	select BLK_RQ_ALLOC_TIME
>  	help
>  	Enabling this option enables the .weight interface for cost

What's the difference between v1 and v2? A commit message would
also be nice...

-- 
Jens Axboe

