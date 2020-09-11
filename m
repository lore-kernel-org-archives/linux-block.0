Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840BFC43461
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 11:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307F4221EB
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 11:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HmRkREyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgIKLZT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgIKLZA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 07:25:00 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EA1C061757
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 04:24:31 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v15so6433108pgh.6
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 04:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b/7SDEJP+uTll9ho7KntUu9F+eISrqRN9LoClujzSg0=;
        b=HmRkREyVvZ3A+vZGQajIEPKmyBNfGJGwTmS7z40PQxJKHmj/0TeKojxlSXCQHrcSDy
         vwRJdVAWA56ggexuYBakO8jBhYa4AWVdq1YuTw5MAUVMrDuLYny5Ft4g5lnDMV/Yj5N5
         LVZ/LFE6SGtEy+Zyckh1SI9rYs6zDhtadRENDU3hax8XhL601ndiMxZkgvsEiRyuie7z
         HNtGcrXntsxssCSPYZdqKBaddZ04rHCZj8ZrtFBi7CfCEYIE9tQ4jEpQ14wEOFRMGSPV
         izNMUbdlthSGtXtzcqtkxriwmfRmY53BkV4fK04wQYoRi0pyIGnfbHAyE8Oq2DFcByke
         mI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b/7SDEJP+uTll9ho7KntUu9F+eISrqRN9LoClujzSg0=;
        b=BAd/pLrDZ/JVKTihcgWJmiUN519xw8h11MAk59CThNtwGlQ+Fa0aDbS/5yaLT7Zgbp
         jTXX0tT2czmo8c2yWJBllrKyB/85P/cK/zmuS1yzQs8tFLyQ68bclUskhzCAIe9S9gjc
         DDE0fs5tga76E1RuqtbPn2dhVkNbCJu2D6r2EWQaFeCapywrn6aX11/7dAPkpgcp484G
         5llWNuVVe34mQqy2aziCF+SwrxRGz11IdKiH2QBmgOemyxYyeqVFFQMA6mu8lQZW0dfq
         RRZ6MozUzRRapSa77JrlU1dyOoNj7XCnR0MjgjcU9QIsuJnl+Tjd99h+aGOAW8QUnSjv
         6+8g==
X-Gm-Message-State: AOAM530Br+2ta5lKC1pWKanqsVz60qx8G6jmLMCxU+aqLqXiR/B93AY8
        itUPEZdQjPv/vKVj4etQHiRFRNEdEM1lrLU1
X-Google-Smtp-Source: ABdhPJxM7ld9x471TjUgNxEEN8T+FNm8l9ego5KssI3yCsO7CPcmQBlu688rIXQAbNNwRPu6S+y8XQ==
X-Received: by 2002:a63:2d0:: with SMTP id 199mr1323076pgc.408.1599823471466;
        Fri, 11 Sep 2020 04:24:31 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id h35sm1743394pgl.31.2020.09.11.04.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 04:24:30 -0700 (PDT)
Subject: Re: [PATCH] scsi: core: Remove the unused include statements
To:     Tian Tao <tiantao6@hisilicon.com>, linux-block@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1599821932-22682-1-git-send-email-tiantao6@hisilicon.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <abf75d33-66ce-b7fa-0cfe-f68a0f22f039@kernel.dk>
Date:   Fri, 11 Sep 2020 05:24:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1599821932-22682-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/11/20 4:58 AM, Tian Tao wrote:
> scsi/sg.h is included more than once, Remove the one that isn't
> necessary.

Thanks, applied with a title edit.

-- 
Jens Axboe

