Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3451FC169C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 02:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D942D20863
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 02:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="2NLQU00O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfBLCtn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:49:43 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:42649 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbfBLCtn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 21:49:43 -0500
Received: by mail-pg1-f171.google.com with SMTP id d72so511983pga.9
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 18:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z1CmkxZyM0zsGmXc11iu63ORuSJ7IEMKLLgTEqC8aW4=;
        b=2NLQU00OK4ic045v4sYeulxeLSkMPPSEJ6mAW/6l0BBuhl9pKzOoQiIiOx2R41wl9U
         C01RiYqW+IeU6hBNnCdTgLDLoGnX7L8VkoTDtphIxXzc4nVreS2GYcAKpgxDnTvUXI1B
         h1yMrxXhARY3e3CcUXzdB4L/+4+ZjQ3qeRUFL5NC0OwJIq712lLxq4qrSlPJNfrvNBYD
         h68LbLbDb+1xf+I18fraL3Rk8A84LUylczAUW04JyUJEuppUPbBqiHSUrRnVPx4qn2V8
         /g688avWor53KJ/lGoq6sckJsdXScIOJV3paJPguBMtoWpunRHUEJdxJJWoYo2zH43mG
         6Jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z1CmkxZyM0zsGmXc11iu63ORuSJ7IEMKLLgTEqC8aW4=;
        b=nthLAE9xBOcQ5IIqmpEl6PBtqejXtYOFhTbZsssG9cwEk0x1q3fzFGwFeITtyQBseM
         NAJXOlvLw51BPRKXBsVpndWTvBYCuHDd/52rJ47pY4SUqERIx70cbkCDJ8s9ZrrtfsxH
         HpG2eRKSEzaX82SqnXNT1kFhMx4HXdM2B2I6V7eeGjl+lq9iXrADuEVu2j9aLFwII50J
         iCmezgiquHGHRvjUxaF7Uvnx60jKKRTSvRlvK5qoN+hzRs40fkKUsXgzYHWjIJF+GdF5
         V2SfJ4icqueIEQf8Jg+CeZvGkRx++ZeI27xl+hvAp/gvlsiY8fchxI3zQSRBrKicTWIO
         KxuQ==
X-Gm-Message-State: AHQUAuaOogMAwhXK5xZPo6ajMmoO1fUfVhwvT7qvmFK+iSe9mycX7tqZ
        IGwB7KoCdf9dpeoEPhJ4e/leA6JYCNw=
X-Google-Smtp-Source: AHgI3IbZtyvlfrvs3Bdvk2vV84sRmY3cy4SgRaINpAuHLDj5dTzMmBC/p/PJ9oo4TvQ+kUwX9y1Tog==
X-Received: by 2002:a63:3fc8:: with SMTP id m191mr1526888pga.240.1549939782198;
        Mon, 11 Feb 2019 18:49:42 -0800 (PST)
Received: from ?IPv6:2600:380:4a5b:8858:a8b3:edff:f3de:ccc1? ([2600:380:4a5b:8858:a8b3:edff:f3de:ccc1])
        by smtp.gmail.com with ESMTPSA id b26sm20550063pfe.91.2019.02.11.18.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 18:49:41 -0800 (PST)
Subject: Re: [PATCH] blk-flush: fix inverted scheduler check
From:   Jens Axboe <axboe@kernel.dk>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Dragan Milenkovic <dragan.milenkovic@pantelija.rs>
References: <d52cf5d9-07a0-b643-e775-48139a4b19b0@kernel.dk>
Message-ID: <88832d01-8950-5958-74a4-a8c28b899637@kernel.dk>
Date:   Mon, 11 Feb 2019 19:49:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d52cf5d9-07a0-b643-e775-48139a4b19b0@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/11/19 4:11 PM, Jens Axboe wrote:
> 
> A previous commit inadvertently inverted a check for whether or not we
> have an IO scheduler attached. This is reported to cause a hang with
> particular LVM setups.
> 
> Fixup the condition.
> 
> Reported-by: Dragan Milenkovic <dragan.milenkovic@pantelija.rs>
> Fixes: 344e9ffcbd18 ("block: add queue_is_mq() helper")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Disregard this one.

-- 
Jens Axboe

