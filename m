Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38ABC282CE
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFC7206A3
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="m2ffGMy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbfDXQ5E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:57:04 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38252 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731043AbfDXQ5E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 12:57:04 -0400
Received: by mail-it1-f196.google.com with SMTP id q19so7392985itk.3
        for <linux-block@vger.kernel.org>; Wed, 24 Apr 2019 09:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ClnH07p4d6EFrZL2aH+LzlFFUWQr/bpKY87H1M5i1Mk=;
        b=m2ffGMy4YVjOow8DRNt5VF0lNchz9Wtz0nDp+B2CYERsayNqkh/K7WrE2J91HOiUf9
         m6FeMXX/lF0UI/x8ZJ3UVe+KcX8Ax/t091VHDxHL1UuvTkipzY1qB3NStAdzA+k0SgbI
         Qh0f2jTU9el4cS9jiwRcgGlkB8nIuykzR+OzopZEyGnkK3FqcQ/JbnDJUkxUr0j/aF3x
         jcyHc4jm4orXhuYvc0PYtexuDyRSQ+AehWZbtB01Q+V0llt2fPJef3S6vX3dHGH1utdY
         awiNcacfRMXzrfm1JwDCRKXtzBEKnok3krTozgwphdtqfHh4AIGFhWNjnbf9BYxsI7mA
         Z0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ClnH07p4d6EFrZL2aH+LzlFFUWQr/bpKY87H1M5i1Mk=;
        b=YCN3AZTaajmgnhjQWXRDBaCkmNM6tCGWdVanoyAV15qEJ6WycEdLLohFMJ6QTsGmDK
         ik0rLfUyLvelzbx15gYaCOwXjajkGUvSHJvfNrmJSq8REDrglpemi49s9q/pHO49i8qI
         vyiDMq4LBKY+/WW2cpoXbU1fBvrOfJhv62RICVDp0MM9WicyzpPmaeVZUVyUCQ086CfW
         IpChEAl+bky9Zkk0DetBRsSlqSjcEdaZ14Bh9CtDLucil9rjE/JxhmokUbvaHqsNeTRp
         W5TRWkKfvIYaVK2HjEMTxQhcpopJZAlGxFu3lci0Yn0HU+NDHYw1mszTXZXUvmmBESn6
         smmg==
X-Gm-Message-State: APjAAAXaz189SVtdjPGN7AJzmVm/UncHPTGbz64oz2QlYsX7/y6wqyiy
        rL0fGv84qcIHTd3ELiARy9jKsltO+6Ly6g==
X-Google-Smtp-Source: APXvYqzD21rm12ITRyElPnGwF/RWh4+t+Qlxd5YiQ/RbHC2meP+Ce6JSXDK4Sxfo3yY5WGWgrIn90w==
X-Received: by 2002:a24:791:: with SMTP id f139mr19953itf.73.1556125022951;
        Wed, 24 Apr 2019 09:57:02 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 136sm9371891itk.28.2019.04.24.09.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 09:57:01 -0700 (PDT)
Subject: Re: [PATCH 00/18] bcache patches for Linux v5.2
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20190424164843.29535-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c213551e-4c07-198c-1ccb-a404f07c2915@kernel.dk>
Date:   Wed, 24 Apr 2019 10:57:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424164843.29535-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/19 10:48 AM, Coly Li wrote:
> Hi Jens,
> 
> Here are the bcache patches for Linux v5.2.
> 
> Most of the patches are bug fixes. We don't introduce new feature in
> this run, people continue to focus on code quality improvement for now.
> 
> Juhui Tang and I make some fixes related to bcache journal, the changes
> include,
> - Fix KEY_PTRS set to 0 error under very heavy small I/O pressure, to
>   avoid potential missing for journal and uuid update to cache device.
> - Add code comments to make code more understandable.
> - Minor code cleanup.
> 
> Liang Chen, Guoju Fang and Shenghui Wang contribute useful and important
> fixes for,
> - Avoid a crash in cached_dev_read_done() by adding reference before
>   calling bio_complete()
> - Improve unused buckets statistic
> - Fix a race between cache register and unregister
> - Potential use-after-free and memory leak bugs
> 
> Arnd Bergmann and George Spelvin also contriubte useful code clean up
> to fix clang warning and make bch_get_congested() more clear.
> 
> Please pick them for the 5.2 merge window.

Applied, thanks Coly.

-- 
Jens Axboe

