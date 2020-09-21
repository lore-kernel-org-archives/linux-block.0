Return-Path: <SRS0=nPog=C6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1729C4363A
	for <linux-block@archiver.kernel.org>; Mon, 21 Sep 2020 18:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 603932071A
	for <linux-block@archiver.kernel.org>; Mon, 21 Sep 2020 18:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="ouPaSesD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgIUSDy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 14:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgIUSDy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 14:03:54 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F2DC061755
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 11:03:54 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z2so13170393qtv.12
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 11:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r//0o/XWd8URpctj3JPXfpTU1RAK9bKNJbZkVi4S2sQ=;
        b=ouPaSesD+PwTUVNfOZBG7gfFoebajvxMnFMJJGhbtP0SfZJMpzRl+LRhCJP5xKUgaa
         BiOuJNMdkdOfeE9D4ZpPm7UtiPfkhZnmN1Ei7CWMIH+b6wgGrRb8FV2+/mptEvzF/Ttv
         HzkisWYywvqjs9NGOeI8LwCypBjQlA0ehqfseNCk5rGKXhkbO8ARjQGMDd+4YQ3u4DVL
         QnY0Bu2iRWGEIiqxSTxIGhMjhDaWldB0Q4FQLqlETrmqd6qbhGDe1NU+4xgb8fIFBBhS
         AYo1O0wJfN/a4EPqgtd6xBHjscaJtxn2K6iBCK+Q5wlZa30KIfzTdkwcyU4BF2tblMMC
         kuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r//0o/XWd8URpctj3JPXfpTU1RAK9bKNJbZkVi4S2sQ=;
        b=j24mKNkLfyY+aG6u8Ey57krwyCga15E/RO3EVpnhMguGxnEX1HwGBZ1UwlO/h0ptO8
         SIqgkmV+FRewyUNLmKBNIaa/LFfvAR1vLU+7/JXDV5VT44mTDEFw1YQ3D1/PF2D1W8u4
         ZpWdMpJ/wV7wsHwB0aNzJ+6X9D4L9bnRlAyeZjA4hF2072C5E6wvf7nTcsjuqhSNoUPl
         UWz/iAPG0GYtqOdF6StoS+RvhwoqkSU+Y3cPQfP242+UMN1oj2qK3Vne3b6aj5ZIWBzp
         KdxKT0oxwZfO6zlwD4BL3M+kY5RPfuisuCTfUOsraMRhaHc8fuBqUiQKcShF7Ouf6Jnb
         8iEQ==
X-Gm-Message-State: AOAM5311gIS1DXyEftnmVGmXMZQAdCnoJu8M8+s2kw/VSKo+xJvJpPqH
        BAduGHebAsTINwTXpMUWSjSnsQ==
X-Google-Smtp-Source: ABdhPJyoPBgtJa+ce3Q+lGXEmKuOzIIwWIkgG/Gz+QQJRcvqCjdRf9fmMjwacFpgPFDufXj9dTbf0Q==
X-Received: by 2002:ac8:7388:: with SMTP id t8mr746977qtp.187.1600711433232;
        Mon, 21 Sep 2020 11:03:53 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v16sm9452685qkg.37.2020.09.21.11.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:03:52 -0700 (PDT)
Subject: Re: [PATCH 3/3] nbd: introduce a client flag to do zero timeout
 handling
To:     Hou Pu <houpu@bytedance.com>, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
References: <20200921105718.29006-1-houpu@bytedance.com>
 <20200921105718.29006-4-houpu@bytedance.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7f680bff-a19e-3aff-c91e-98b2933826a9@toxicpanda.com>
Date:   Mon, 21 Sep 2020 14:03:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921105718.29006-4-houpu@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/21/20 6:57 AM, Hou Pu wrote:
> Introduce a dedicated client flag NBD_RT_WAIT_ON_TIMEOUT to reset
> timer in nbd_xmit_timer instead of depending on tag_set.timeout == 0.
> So that the timeout value could be configured by the user to
> whatever they like instead of the default 30s. A smaller timeout
> value allow us to detect if a new socket is reconfigured in a
> shorter time. Thus the io could be requeued more quickly.
> 
> The tag_set.timeout == 0 setting still works like before.
> 
> Signed-off-by: Hou Pu <houpu@bytedance.com>

I like this idea in general, just a few comments below.

> ---
>   drivers/block/nbd.c      | 25 ++++++++++++++++++++++++-
>   include/uapi/linux/nbd.h |  4 ++++
>   2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 4c0bbb981cbc..1d7a9de7bdcc 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -80,6 +80,7 @@ struct link_dead_args {
>   #define NBD_RT_BOUND			5
>   #define NBD_RT_DESTROY_ON_DISCONNECT	6
>   #define NBD_RT_DISCONNECT_ON_CLOSE	7
> +#define NBD_RT_WAIT_ON_TIMEOUT		8
>   
>   #define NBD_DESTROY_ON_DISCONNECT	0
>   #define NBD_DISCONNECT_REQUESTED	1
> @@ -378,6 +379,16 @@ static u32 req_to_nbd_cmd_type(struct request *req)
>   	}
>   }
>   
> +static inline bool wait_on_timeout(struct nbd_device *nbd,
> +				   struct nbd_config *config)
> +{
> +	if (test_bit(NBD_RT_WAIT_ON_TIMEOUT, &config->runtime_flags) ||
> +	    nbd->tag_set.timeout == 0)
> +		return true;
> +	else
> +		return false;
> +}
> +

This obviously needs to be updated to match my comments from the previous patch.

>   static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
>   						 bool reserved)
>   {
> @@ -400,7 +411,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
>   	    nbd->tag_set.timeout)
>   		goto error_out;
>   
> -	if (nbd->tag_set.timeout) {
> +	if (!wait_on_timeout(nbd, config)) {
>   		dev_err_ratelimited(nbd_to_dev(nbd),
>   				    "Connection timed out, retrying (%d/%d alive)\n",
>   				    atomic_read(&config->live_connections),
> @@ -1953,6 +1964,10 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
>   			set_bit(NBD_RT_DISCONNECT_ON_CLOSE,
>   				&config->runtime_flags);
>   		}
> +		if (flags & NBD_CFLAG_WAIT_ON_TIMEOUT) {
> +			set_bit(NBD_RT_WAIT_ON_TIMEOUT,
> +				&config->runtime_flags);
> +		}

Documentation/process/coding-style.rst

"Do not unnecessarily use braces where a single statement will do."

same goes for below.  Thanks,

Josef
