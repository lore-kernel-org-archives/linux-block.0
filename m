Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56749C433ED
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 21:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11649613FB
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 21:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhDTVYa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 17:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbhDTVYa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 17:24:30 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EE8C06138A
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 14:23:58 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 31so12156791pgn.13
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 14:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=glVvR85xdfrE67R3CZjbgLnxmue59x0PtY9S4kH+sec=;
        b=r2gWKL7qzxRD5QAnD4hmvrIzR4IMnDbputgSsVU9mX7I2N/lzAT+uMHlGDBQzk1NFf
         yJ5vt5b8+5BY2SgydAZ86nwTu1dYMkMFGJ93a9STfiIMQHV5kPKIr6JDPzREHeTigwnw
         72Eu3fZO2SWgEo9lOxYUfE+5uK40kA//DRMiv3k3OIHEDn/dCdLetufNccjLPZn+7L3C
         Ft/HQavN299Tfa2ExWAijhQLwRwkk9S5iY9AkGq5QKb3zRwjSyOh9FZyaW6IEdUuGcDX
         5VzQ3L+pZCgtMkk9J0smXpAVh5eNjCJqk9n6lcrLy12qzygqhq3nxyQwLp8ex08s7QD7
         m9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=glVvR85xdfrE67R3CZjbgLnxmue59x0PtY9S4kH+sec=;
        b=M54cEgy9dxfAm8Jw1zRni+5a886T+rZfHbsEL9lg5CFGhtcbL2bFifJHWdbF/CwGL7
         ZrtnJjA4akm2FEVWS33bex9LpHfzfzl6g737qY+KdPhOCy7HvxUOVM35pafsgBGU3j2x
         qwjhXSDpSAGcMVNjvHjU94fZxFDqqAgpX68avZo3N3l43AnJao0EqMiZ3zmtHj1FIjgU
         KaXhkap/WvkttUcbLScoyuJq9TGauASzKymSSsDn77Qk4Ui2BAGQXIMi+oBh+5MB8iS1
         LdfgbmFoVbZcoAERCEFspZWoHzvbrgnm2Jb/74BejEVy3GAK0+5fCXnly30uvTQMpF5w
         hI4g==
X-Gm-Message-State: AOAM5309s42EEJvVXOtQszBqXGkrOMjj49inJUgavW45n69nS3QtVXxn
        AMaR6J4DXzcNtRt1rWc3vUgX5Q==
X-Google-Smtp-Source: ABdhPJz2TSHFrEWzD1FcGQP6T82U0X2bs7+O5FlMOXsznfPp/4/EuhhtJb07WaktlcO+jxEFzhgW3w==
X-Received: by 2002:a63:ed12:: with SMTP id d18mr18929494pgi.20.1618953838079;
        Tue, 20 Apr 2021 14:23:58 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d6sm45603pji.43.2021.04.20.14.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 14:23:57 -0700 (PDT)
Subject: Re: [PATCH 027/141] drbd: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <44663f18fb12e39c53b0e69039c98505b7c6d5da.1605896059.git.gustavoars@kernel.org>
 <ba77fcbe-8770-d234-509b-7dc5ac079319@embeddedor.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2c942833-ae0f-bda5-b023-e2a1860be50f@kernel.dk>
Date:   Tue, 20 Apr 2021 15:23:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ba77fcbe-8770-d234-509b-7dc5ac079319@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/20/21 2:25 PM, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: who can take this, please?

Applied, thanks.

-- 
Jens Axboe

