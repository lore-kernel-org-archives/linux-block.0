Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D799C433DF
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 03:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE3F207D3
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 03:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bPH7uHE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgFEDYe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 23:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgFEDYe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 23:24:34 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BCDC08C5C0
        for <linux-block@vger.kernel.org>; Thu,  4 Jun 2020 20:24:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ga6so2007583pjb.1
        for <linux-block@vger.kernel.org>; Thu, 04 Jun 2020 20:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EVmfztVzXoVu0QduA/l+tCorSJU4f9rapwi7f1MC1DE=;
        b=bPH7uHE55KjmKw8Ga2YC/pgn5FtH9iw/zcnLJWjmBSvWAdNxIKg+f3Ag229MSZSfw+
         iHb1Ba8j29qZExbXfSoTk+TcmXkA6pjrvMiMxRCD2mxh6dP0uhR1JdA/+kWX6jhv94M/
         bRwqlyo0VQ43nuF4hdkKUNWZP1PmLaRRljlwmPHRJWPUi5ffWZuPgzMpSX0Rg3eiaMvo
         90/tpWloKf4fO6nOlwE+Q1BZP8NfjZbFGsm2XtgEwzkx2Z5Shq6skApV7O545zAd/Ikr
         XlDupzGz1lLNtDp1aJ07jEKwJDtdDGTXW+r4uldKMAtCKCzwL57NN5xz+cPDG2jlRTTd
         MGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EVmfztVzXoVu0QduA/l+tCorSJU4f9rapwi7f1MC1DE=;
        b=ZhcQcTgY/xGqh9U2NXn89fNhljWaepQhAv1pMnnMmRbe7IXwKY1R2exJrsjKYX68hA
         3XwpXEdjTuhx4cft2nMb9s/dcLxPniEOxpUBys6x0FTX93wpqk07LM03LR0lpWSQTfY/
         7S6Rk6dfNaif4n1ckfmysHRJB2/RHUKm+AVDingoU1U3cM+c4qve90WDob65wSSpJijX
         HFNITLQNwJcn+QSIXrGblii6rHUlzIOIxQlcYxER5FvgkBHlZzCCCmUSIqdV+9z4jT2o
         0h70e0G3rAxdvVcn9xFAywOL7UaMFpviO+qZoJQVcJiMTKpiCCiIANFEp1xyUqnL/2XI
         ltUQ==
X-Gm-Message-State: AOAM5304xf+cAqan3x8lLjS5gycNB8dpUBrn83y4qT6j7i/xQ1vBS+AG
        1JBQtnebH80VP/nhOEAtD5qDeg==
X-Google-Smtp-Source: ABdhPJwPB0YeLS6h72HAGY40ENvyBUBjh+y3ewrGePyr7TuLyFkWR6v78LKP5O/tyKq1BmQr6zYjYg==
X-Received: by 2002:a17:90a:8c4:: with SMTP id 4mr666271pjn.64.1591327472043;
        Thu, 04 Jun 2020 20:24:32 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id u25sm5683740pfm.115.2020.06.04.20.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 20:24:31 -0700 (PDT)
Subject: Re: [PATCH V2 0/4] blktrace: fix sparse warnings
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>
References: <20200604071330.5086-1-chaitanya.kulkarni@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <46bee113-ee17-15a9-f383-ef0bc8b404b8@kernel.dk>
Date:   Thu, 4 Jun 2020 21:24:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604071330.5086-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/4/20 1:13 AM, Chaitanya Kulkarni wrote:
> Hi,
> 
> This is a small patch-series which fixes various sparse warnings.
> 
> Regards,
> Chaitanya
> 
> * Changes from V1:-
> 
> 1. Get rid of the first patch since Jan already posted similar
>    patch.

Applied 1-3 (there seems to be no number 4 anymore, regardless of subject
in this cover letter).

Jan, are you re-sending the final one?

-- 
Jens Axboe

