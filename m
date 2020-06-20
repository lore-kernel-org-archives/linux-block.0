Return-Path: <SRS0=essW=AB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179FCC433E0
	for <linux-block@archiver.kernel.org>; Sat, 20 Jun 2020 21:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB232168B
	for <linux-block@archiver.kernel.org>; Sat, 20 Jun 2020 21:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tq9mJgf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgFTV0M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Jun 2020 17:26:12 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:47052 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbgFTV0L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Jun 2020 17:26:11 -0400
Received: by mail-pf1-f172.google.com with SMTP id b16so6274751pfi.13
        for <linux-block@vger.kernel.org>; Sat, 20 Jun 2020 14:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZHQxZ8TSsBGlpFQq4k9d8v+o7ASds0jY1nqeLeyAKZM=;
        b=tq9mJgf8znyh63cAW4/PCMUgKxAvFPXOee0lCGMh+PVnK7V85Udxk8h8SFuYlnD3HA
         kNQfv1l8ksPzM407nZlLinz8SF/qLgO/qsZS//FdSiDvrop/Ni6Vgr53A98UC8JSMAlQ
         fbDJzvXLQ+1Sg7NRs2kRUKhN+ZNQxVM04UZoAlqX5BN6krzBB+CCHdzprJyM3V0XR9BZ
         y/VscEiemKcwc8hS7iNjSiZXj3UfwOO0Cr70UAPvo9TV/CkX4gTYebwzvxyMrr0lewNK
         7mCKXSN1fXA13mVyPBQb2+DscRE0RjoA5TAEnyNwlhQ/8u47O6Xfu4+CXh0AgP/HxTcS
         4wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZHQxZ8TSsBGlpFQq4k9d8v+o7ASds0jY1nqeLeyAKZM=;
        b=mjAOz6QFMjvezEA0XEkLtqb/NVcOzIyUc1E3GZb5Eak3gbioBYvDQ9iuX8mgLNixpr
         2ZimuO2O/GYnHzmaUlTHKIemSNPh351N6tr249Uw/kGu98w5A8eRa3jE+yLIIoMoWyc+
         /YqI/V2aqZaL2AFN/W53PRq91D3nKJ2mL3YettFNOkn5/CCBJXdY8G+J5FVRgltN0YUb
         7cB+lOkAEFCVURsj/DvVsKpRrjZzrVm00BkVmkcKt6bfADdWwbPPe2XiKtXA9fqLVksb
         f5i9GjCoB0JCmFcQx3nOcWNKpGWqprQNFQc4Mjm5qlkioeDresbKkUMNeDBeIopy+x/N
         yibg==
X-Gm-Message-State: AOAM532e70sj68+ietRI5kJG9K1G3tBSzBv0kEX9Vc1yVX0Htp4MhaOu
        2LEOhnnblLpdR0GzLkqOQh+82Q==
X-Google-Smtp-Source: ABdhPJwmnMQuLonweUZsPZUPLIboe9pPgWn1MfhYScHl5K2gI2YxMJhjuxDUHi0QW5YZGAoAX/Utow==
X-Received: by 2002:a62:1c5:: with SMTP id 188mr13682576pfb.213.1592688310612;
        Sat, 20 Jun 2020 14:25:10 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id p14sm8668872pju.7.2020.06.20.14.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 14:25:10 -0700 (PDT)
Subject: Re: [PATCH][next] blk-iocost: Use struct_size() in kzalloc_node()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20200619230830.GA25608@embeddedor>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e0afded8-386a-7619-a221-869ae2e606f6@kernel.dk>
Date:   Sat, 20 Jun 2020 15:25:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619230830.GA25608@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/20 5:08 PM, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.

Applied, thanks.

-- 
Jens Axboe

