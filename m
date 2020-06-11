Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C867BC433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 15:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C48207ED
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 15:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IxsUmGCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgFKPQF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbgFKPQF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 11:16:05 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F0AC08C5C1
        for <linux-block@vger.kernel.org>; Thu, 11 Jun 2020 08:16:05 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s135so1993222pgs.2
        for <linux-block@vger.kernel.org>; Thu, 11 Jun 2020 08:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TkYB8W4nXJPMmHfuB6tFy5NdErLfDGBuYJ9xHGiV3Nw=;
        b=IxsUmGCg9xCXJcVSJEYQFLPgY7kLMYX6eJTZ1z72m7zhsWvBgGBTX1x9lqgj6B5tOT
         0JV1l9UwolLKFpZ+dc0h9IG52uKi/3HwzBecVu2ISiciuwjDkNwQDqxJ8pSRleEOLs16
         VFbz2jwDyq0e1XWubhCpl43Z+a4oN/kGns7Rb0CMTTTxdcKH3VMMDqHtWsUZ/WwwRmsN
         lFfH5s/ClyskThKq1PGT/qcruHKyTDqkC9SRfwVzNQteR5/qd0Rg2SeXhNdTG5CzIq18
         SUi/kGzp0xGjNTBmuYLJg83r7DJqjaqz0MOtt4HqyIiLBHzjA3zqWE063MibbNxbdrbC
         OdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TkYB8W4nXJPMmHfuB6tFy5NdErLfDGBuYJ9xHGiV3Nw=;
        b=tdXbGrqXPpoSPrYvOeBPrwdSiIXngbPMsRWjhWmnvWRF9nj1i/9mWdu6IKdGevTYTt
         8iGQL9QjxRJ3dbYN5CmzbBiJg4oA2Xj03n4v7902tx3yD//NUX+mptYkgatt++MmUlSB
         tSdavD0V1C8RFPSEMDkK2OLHO/sxDm/kW4wartf2/gRNez/T7lHgf3iOM5uYzAh4GHya
         mZkUYKffmp08hktWkZe57Np6/ZuQQO0i8od47L5s8jQYNg4r1vLWI4Z3sE+A9YIiOD2A
         WyJHJ8DoE4WimDlDAfXxTz0Gu30t5wjUGibKeAll9JmwuT5RC0fbUaLiYH3Ktc/A9OB5
         p8qw==
X-Gm-Message-State: AOAM530TTqjBLZqSzVwn02RGO0e40L7YiQoclcS+vVv/0Llo65Yk7Jog
        2U02ME82192PnpbqikUvBFX3Uw==
X-Google-Smtp-Source: ABdhPJyBU4PaWFmugtp0SghM7ORFmRKLbhu67wIySCFY+UnIRRr2o7E5ktqM4TOai7STPK8vvP0Ytg==
X-Received: by 2002:a62:834c:: with SMTP id h73mr737262pfe.221.1591888565047;
        Thu, 11 Jun 2020 08:16:05 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id u5sm2975735pjv.54.2020.06.11.08.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 08:16:04 -0700 (PDT)
Subject: Re: [PATCH] pktcdvd: remove redundant initialization of variable ret
To:     Colin King <colin.king@canonical.com>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200611143014.925317-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <70a77fb7-ccfa-2843-c30b-beb5ba493856@kernel.dk>
Date:   Thu, 11 Jun 2020 09:16:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611143014.925317-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/11/20 8:30 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable ret is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.

Applied, thanks.

-- 
Jens Axboe

