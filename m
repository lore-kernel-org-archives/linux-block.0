Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA51C4CECD
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 02:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159B421855
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 02:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IdTd2sn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfIRCcS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 22:32:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34207 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfIRCcS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 22:32:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id d3so2404900plr.1
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 19:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dbqlB3qRrBdKkDcgMmNFTF8DJMVlPpT3DzzG1y1NtZM=;
        b=IdTd2sn5nRirwiMAvQda1/KKoT0ugMKNz+9m28l3JOYeq5MZzI6ul+LqkAOHnu+UNt
         qgNai68qfusgc3UCCWClBUy0zpZzdUsQD/rAND3giClK5gOsi2rB5sU6G5/exzjiEeVl
         6Vw/2MG4LZZhZlTZW059ep/S6K2CJltrVdwoG3V17FTD44XaReGYrjIQrYy2my3b9Qy9
         gunJD74/n05O/qX2v/CumvMoExYiZFsyx/H+tvyoUhw5CK1NHfTNv+Dz5FLbu8BV4Pg+
         AfLL3jEN4hNsQPd2hj1A117bmGDXV5zVNArLqpChoMoieYiohEyA3tqDP5ApYm2CuUJQ
         9oOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dbqlB3qRrBdKkDcgMmNFTF8DJMVlPpT3DzzG1y1NtZM=;
        b=bHmB/vnZQryzP5bwFSrGasSqYp40hwdwVEuYisCwftFNkA0gYyBySeUTdvr41MCYnM
         Ulf261QwW0jk9XDfeF1FFOj1kGuCyXSfh878UScgCXA1UNkav07k5PxYzjb8ZknsMaMa
         /7JRkSaBKJP4N8YquOaecAE2tcJNeHoMmTZ+c5fHY9F0CIHjuObzyTlEqrVM2PNoTXb7
         YVD7PlgUWcWCCcpSsWz/T3DuS/xluPOBXKRu4DywEo8B+o5J5gBekMw9yogE+OmDtWUx
         fprs1m4HoParBfDNZzTFj0C5izoJFyolV7purn50hpVxMmIE5U+Weq5CZd0vsF1Fggbw
         4rZw==
X-Gm-Message-State: APjAAAUh2zqesNq4R0FHqYY2s/JTxkvNvuXZH9LuX9FHnYPLYr7YJn+q
        ZA7SL6n2DJ1LmjECMo1yCkjN3g==
X-Google-Smtp-Source: APXvYqz5g54cBRK0Q5eLyZd9W/XRv5gQwWw3OfLVEJwaUFU1MjaoiJV6ujcG9HNwiZkRPfrpEDEQbg==
X-Received: by 2002:a17:902:ff08:: with SMTP id f8mr1790128plj.309.1568773936216;
        Tue, 17 Sep 2019 19:32:16 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id s19sm4209846pfe.86.2019.09.17.19.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 19:32:15 -0700 (PDT)
Subject: Re: [PATCH V2 0/2] block: track per requests type merged count
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     osandov@fb.com, bvanassche@acm.org
References: <20190918005454.6872-1-chaitanya.kulkarni@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <369ecccb-06ca-68d0-1474-34abdc2e8851@kernel.dk>
Date:   Tue, 17 Sep 2019 20:32:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918005454.6872-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/17/19 6:54 PM, Chaitanya Kulkarni wrote:
> Hi,
> 
> With current debugfs block layer infrastructure, we only get the total
> merge count which includes all the requests types, but we don't get
> the per request type merge count.
> 
> This patch-series replaces the rq_merged variable into the
> rq_merged array so that we can track the per request type merged stats.
> 
> Instead of having one number for all the requests which are merged,
> with this now we can get the detailed number of the merged requests
> per request type which is mergeable.
> 
> This is helpful in the understanding merging of the requests under
> different workloads and for the special requests such as discard which
> implements request specific merging mechanism.

Regular io stats get merging stats for read/write/trim. Why do we need
something else for this?

-- 
Jens Axboe

