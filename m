Return-Path: <SRS0=cKEj=BL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8BEC433E3
	for <linux-block@archiver.kernel.org>; Sat,  1 Aug 2020 03:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E60022CBE
	for <linux-block@archiver.kernel.org>; Sat,  1 Aug 2020 03:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgHADEx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jul 2020 23:04:53 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:26016 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727824AbgHADEw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jul 2020 23:04:52 -0400
X-IronPort-AV: E=Sophos;i="5.75,420,1589212800"; 
   d="scan'208";a="97319388"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 01 Aug 2020 11:04:50 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 229AF49B1116;
        Sat,  1 Aug 2020 11:04:48 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Sat, 1 Aug 2020 11:04:50 +0800
Subject: Re: [PATCH] loop: Remove redundant status flag operation
To:     <linux-block@vger.kernel.org>
CC:     Martijn Coenen <maco@android.com>
References: <1591929831-2397-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <d2a8b662-a99a-104c-b749-c10293f71211@cn.fujitsu.com>
Date:   Sat, 1 Aug 2020 11:04:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1591929831-2397-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 229AF49B1116.AB667
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi
Ping.

> Since ~LOOP_SET_STATUS_SETTABLE_FLAG is always a subset of ~LOOP_SET_STATUS_CLEARABLE_FLAGS
> ,remove this redundant flags operation.
> 
> Cc: Martijn Coenen <maco@android.com>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>   drivers/block/loop.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index c33bbbf..2a61079 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1391,8 +1391,6 @@ static int loop_clr_fd(struct loop_device *lo)
>   
>   	/* Mask out flags that can't be set using LOOP_SET_STATUS. */
>   	lo->lo_flags &= LOOP_SET_STATUS_SETTABLE_FLAGS;
> -	/* For those flags, use the previous values instead */
> -	lo->lo_flags |= prev_lo_flags & ~LOOP_SET_STATUS_SETTABLE_FLAGS;
>   	/* For flags that can't be cleared, use previous values too */
>   	lo->lo_flags |= prev_lo_flags & ~LOOP_SET_STATUS_CLEARABLE_FLAGS;
>   
> 


