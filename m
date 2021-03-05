Return-Path: <SRS0=MGRw=ID=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD82C433DB
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 16:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 743006508C
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 16:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhCEQNx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Mar 2021 11:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhCEQNh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Mar 2021 11:13:37 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A06C061574
        for <linux-block@vger.kernel.org>; Fri,  5 Mar 2021 08:13:37 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id k2so2488547ili.4
        for <linux-block@vger.kernel.org>; Fri, 05 Mar 2021 08:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6DWum0PkSFOC7EqnCDn0YxayPunMKftKntuZCF5jSJc=;
        b=sHStvXrtBm6j4SWxFCJpnJ+pVtAmQg1uacMFUfPAQteAAbaiBcpbANbT7TRRRxDPHy
         JUdTBvSZFhigNZCUH89PlBHI1cLYC5fsV2R5d2z/T8Z0Z9yiVCYarIAE3AqHM8+bGIqB
         4z8CflWwuAFmyiRq16M4SO08/3yXfUv7I5YMvu80lhQ47ePg4psxwr2tcqbRsqjAyF1p
         jo4eMNnKc7rU6ZzBrrFe9E9NHCWvHx/GTrEKyqUR1uXFg8TynqdHQ6rvNLif8KSoK4gQ
         onVZN21d5Zlgr2uvxJLAdc7iLOG25r/0wYG6/oUfKEDZ4qs1fqnbFz7ZvbgEIniXGNj7
         OZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6DWum0PkSFOC7EqnCDn0YxayPunMKftKntuZCF5jSJc=;
        b=qjsLwAXYCWTB0Si60MTmut0IGfYyHxm3tWx+EUGMKZPl3CnA1NG3lH+qB94XFx4D7S
         yaA9OZxGL1tMWSHKJz8w520DwQROUoWtqn0WDDJbhcBxWgEhr+5rm9zE1kNtvUWc8iBB
         NVL50H8YDc/l72DAeDhBaCenHjTEzGra43hxSbQvXsIJVG6yR1l7zbjXkY1en5uiypCx
         yaLKhZs1KYhMkJQVh12xAuarbed+drEASCkiAMIA1iBzKaZabOem/f/4549SZaoDglf0
         090w4iqxZUyiaCCJ3hwuifAiHUPzgBRgV8guh2MLjCTj/fYq4hMmzLApERtTBzcbk+XN
         4EzA==
X-Gm-Message-State: AOAM530vyD4ygpNNvRXQhRiOkQ1a+rFfSxyn/Q6UQfawb18brLpgbn1U
        V9i+MhN9YvX4IsCt/Z94bMr3JQ==
X-Google-Smtp-Source: ABdhPJztVmGl6jVH9oIl+8Ya5KaL8hRp1949lAmDKpwctA2ro7Y8mZ5278NfNDNTc9d08kfFDygcaQ==
X-Received: by 2002:a05:6e02:1384:: with SMTP id d4mr9470392ilo.307.1614960816442;
        Fri, 05 Mar 2021 08:13:36 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o19sm1519955ioh.47.2021.03.05.08.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 08:13:36 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.12
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YEJYFTnbec9jteOc@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <353e221d-3d17-63ae-3956-507ea7d46846@kernel.dk>
Date:   Fri, 5 Mar 2021 09:13:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YEJYFTnbec9jteOc@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/5/21 9:11 AM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git tags/nvme-5.12-2021-03-05

Pulled, thanks.

-- 
Jens Axboe

