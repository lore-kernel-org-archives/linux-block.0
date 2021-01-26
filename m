Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66A9C43219
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6AFA20679
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbhAZWAH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405459AbhAZUNy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 15:13:54 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4681C0613D6
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 12:13:12 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id j21so5780042pls.7
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 12:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t4rIGbMP+nugCJVqhcBEG6esf1Gvvdhv+s6G8fme28Y=;
        b=gjs4vxZOZ0TsibEO7cm9pJ5JakbmZfyDmmJJBGeRB8Zt4itspBlkuzC2YgOg6tc4RF
         GZGZpH4MSw6NfpPG1DxgFPbNP91pruWog2OekSw6DGF1P6rkqHbJbqFA45O+t8ffaiU3
         V3DPmxkflm2XoDb/jffDcJCNpG86tInDTM3y9DZFsxgeBZPVbvQWRAq5ZwXks0tBRJX1
         XEUY09izQpEVUBGSCHhkUSmASW44oRjkmq4et9Ef2qygYAXsujdQ123ZH0KGKE2UPg3E
         jx+OCq+yTjYYaVUoaISEt8RCl2fzp1+kJNDh6fKTIKaEQJEUeIy8Dn5BRETZuynG0X43
         qExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t4rIGbMP+nugCJVqhcBEG6esf1Gvvdhv+s6G8fme28Y=;
        b=Bvq/XoaEtRMPWDC603WH9YlR7YdFNNAtaTQQzElnaw4x/42rOa9+45oMMkTSxiUkwi
         xuOd8v5b+15Xct61vImsd5em47ZbDHK1sBIMGEIoqyH8s8lEpHI6k7CGEx8MBzORPmen
         H1lgTA+LUOVtmWx6DwnW+Ayv/bSna4dnLx50pgUaRA2uHlHF16IgWqsFKsDcmSsIyuq3
         RSS2mjCWMhs8e8u90ayMXAj2x4P23xRzSRbWna0s2skigQuQcMSFCG6DUpB+/X5jYJEj
         Eme3RdvmcnFKNE+av2WnjdpEjJv9bYX+DpXfT9oOz3hxVHmGeR4v288EbU2AEa7nixmH
         dw/g==
X-Gm-Message-State: AOAM531pR6W4ZtXrT8iWux2e2CKGaDDH4DLYLZbDlGVxd4euXOv4cKUo
        qY8bnG79q5u9Mp1PZbzHc+DA3Q==
X-Google-Smtp-Source: ABdhPJx3V2k3+5lERyKD2HLXO8yJrphtnh3SX9edaN3iprpAUZBZFD9KdvXev2rEerVxNHEO0fcjMg==
X-Received: by 2002:a17:90b:8cf:: with SMTP id ds15mr1535433pjb.182.1611691992462;
        Tue, 26 Jan 2021 12:13:12 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id q141sm9867997pfc.24.2021.01.26.12.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 12:13:11 -0800 (PST)
Subject: Re: [PATCH] blk: wbt: remove unused parameter from
 wbt_should_throttle
To:     chenlei0x@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lei Chen <lennychen@tencent.com>
References: <1611574024-23713-1-git-send-email-lennychen@tencent.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a08df994-4bc5-c465-a1d9-6d76c0b66b38@kernel.dk>
Date:   Tue, 26 Jan 2021 13:13:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1611574024-23713-1-git-send-email-lennychen@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/25/21 4:27 AM, chenlei0x@gmail.com wrote:
> From: Lei Chen <lennychen@tencent.com>
> 
> The first parameter rwb is not used for this function.
> So just remove it.

Applied, thanks.

-- 
Jens Axboe

