Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA24C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 20:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4751420851
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 20:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SZ4fAeFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732996AbfB1U6V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:58:21 -0500
Received: from mail-it1-f170.google.com ([209.85.166.170]:55907 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732327AbfB1U6V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 15:58:21 -0500
Received: by mail-it1-f170.google.com with SMTP id z131so16856839itf.5
        for <linux-block@vger.kernel.org>; Thu, 28 Feb 2019 12:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BLsspwXALJF06k47eK0KeHib+HMtqiL6byU7Xr8joP4=;
        b=SZ4fAeFENFuiAkBJqbgoAGcixgdYZjColriK1UTGWLdfOOtZacLp+gcGA3jebSszPF
         h4A+G3yqBcwm4qTJpTrqmpoZc1SWZeDOVWxJ87/lVijFGLYt4fQcX/Wl7aP5Ggcx/zAa
         rwRsSmXVtbZWFwZC4nZ6zKAaODvwZInqK/uzh79kuZOZqV3fmbr2/DaEnKn4mWVtrIzf
         W7y+dV7O/4DK85darUrbdp41DrTqMWdMb/ro/0/kqWAcyZp3CNZOFZ2Zh3sSXIuHl8N1
         T4ntb+dXT5DIuM2gLOcEBTc5ALVLISCeIvYzfT4sVJXV6PmW3jWx8YDmq6aLTFI+0a3z
         T5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BLsspwXALJF06k47eK0KeHib+HMtqiL6byU7Xr8joP4=;
        b=cYOwvTnNwrGOL/7APtovIAcfAejH8KYbGRS/p6UVtIFvC2SiNiYy+Gx8MgKNx0XTiP
         13jmlAX602Ld4ga+al+2I2FbYmymK7V+zJqzb7zMIfnK98aByT2lcJIOWF1hehlrLMj5
         2JzHNRM0BcCmwIGqldwb5qbpp+rKWWoyV5a+3BBAJz/rsSNrfCt15qxGmxwuDASfYrfq
         am3cv3kMJWO1Ji1cpf3pQgJe7ingJ7brOZzakbyXzZ30zi35OyIFvUhX4Ez5kkweS0mM
         97MhWXy6XU2bqYm6Fj9kJcisfAqocEwHRWDGCzJP3zLPTam1m/jf6j75+/jDx/TngcRl
         9Wuw==
X-Gm-Message-State: APjAAAXbWGSm/oSvpGn+hfYYQLGSihswz4E5+gGlxVjHCXUT82ljoFRN
        V1iSha2jxaAPDDlmojkTEz0qwA==
X-Google-Smtp-Source: AHgI3IZVnYD4sCialBMrZ6AvREjbcv3j1BQTi+WlyGM5GEGuWY2LYDrB9Jxz01WElTp+VGriUfK4Cw==
X-Received: by 2002:a24:fdc9:: with SMTP id m192mr1013528ith.133.1551387500737;
        Thu, 28 Feb 2019 12:58:20 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k26sm7746905iol.14.2019.02.28.12.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 12:58:19 -0800 (PST)
Subject: Re: [PATCH for-next 1/1] blk-mq: use HCTX_TYPE_DEFAULT but not 0 to
 index blk_mq_tag_set->map
To:     Dongli Zhang <dongli.zhang@oracle.com>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <1551274501-8297-1-git-send-email-dongli.zhang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ff9e764d-a40f-c3ef-b244-15e5abebb1fe@kernel.dk>
Date:   Thu, 28 Feb 2019 13:58:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551274501-8297-1-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/27/19 6:35 AM, Dongli Zhang wrote:
> Replace set->map[0] with set->map[HCTX_TYPE_DEFAULT] to avoid hardcoding.

Thanks, applied.

-- 
Jens Axboe

