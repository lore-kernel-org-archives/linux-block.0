Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED79C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 17:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074DC206B7
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 17:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Qpcw/EtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbfC2R6B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:58:01 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52053 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729849AbfC2R6B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 13:58:01 -0400
Received: by mail-it1-f195.google.com with SMTP id e24so5130234itl.1
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DciO0VF7ejRAWYxilaWeDQzoHCda1MoCGJWtS76abTE=;
        b=Qpcw/EtBEVjpuTe22RI7X/npgCgNxtlH1uf6g147C9LG9985GtX/APsqjwzj2Uoejh
         GWbHywM9oLpnE47QcPNGaCDoIHIgSKO7UJb35fLck5Q2jSS53T2tiUbho37sm2+prTYq
         jyGI7c2V97sDnf7E0tHMz2Yhcpv2mR7yMG+YHegb8kmL+Y2kSWeaQuH2FnCPh/R543+S
         iW1FU+in8AfnMDXov3YdL9alw4/g9watTRVjvPpM676pvSmcF7sl4hGDPieaKI55m9p5
         TfAlCmwTBIZwaGlKti7nO409mIYMDla0gQbJA8uxeDaqHJ1imI4zYF6z5Op34ozUoVyD
         xsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DciO0VF7ejRAWYxilaWeDQzoHCda1MoCGJWtS76abTE=;
        b=t+Wj1M8iiMMfU8S0IW67E0IiBGgHCewtx5mOi2Y06Pk+fVxW1Yp8/UWpgCXN/x27hs
         LQbtIajzZHi7DokEK6H5Gp86MdS1TSmDbsudc06XTyPGucYm8yCtUJmKT5crnWWXqhlP
         91RNSo/ep/LbH2ocZ2NkW4paDfDC4Uob2uG+dPD/GxYhsnDu63dF9sNl2D5I38iqVdqH
         hEPYhPEiErGdkwiFHCTdXGLdSHJ38p9V5PT50TPIcJV318d5OIqhcJcbCZsNdsE8A6EV
         hKSm5UHLmaL4TBeb/vrJdm8KtNWCJ2jyaVFkB3IblpQ/NAc2Wbqrq2aI8W0QjcKHUUfE
         q28g==
X-Gm-Message-State: APjAAAUShK2YPMWvRVbpSTuN+eAkrJqZK2Usb8wJnEWqg8TPXXAWXUHn
        aPk0W9uqd3l7FT5WTqvFmdMBmQ==
X-Google-Smtp-Source: APXvYqygtQr7BvvAO/nhmDgH9XvSFSVeKoHyLR1HbMdych9VCTKx7AYXmoqt6d//6iQaXAhhvmGF2Q==
X-Received: by 2002:a02:6553:: with SMTP id u80mr34940162jab.51.1553881888734;
        Fri, 29 Mar 2019 10:51:28 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b199sm1339143itb.29.2019.03.29.10.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 10:51:27 -0700 (PDT)
Subject: Re: [PATCH 0/3] md fixes and improvements
To:     Song Liu <songliubraving@fb.com>, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, neilb@suse.com, xni@redhat.com,
        ncroxon@redhat.com
References: <20190329174617.3670341-1-songliubraving@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e98ef1b2-1cca-f17b-e3e0-a3ee6888c713@kernel.dk>
Date:   Fri, 29 Mar 2019 11:51:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329174617.3670341-1-songliubraving@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/19 11:46 AM, Song Liu wrote:
> Hi Jens,
> 
> These patches are based on your 5.2-tmp branch. Please consider apply them
> to the non-tmp 5.2 branch. :)

Applied, with the whitespace fixed up in 1/3 as mentioned.

-- 
Jens Axboe

