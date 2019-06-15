Return-Path: <SRS0=HzVw=UO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36268C31E47
	for <linux-block@archiver.kernel.org>; Sat, 15 Jun 2019 07:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E035C2184B
	for <linux-block@archiver.kernel.org>; Sat, 15 Jun 2019 07:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oEP60rJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfFOHjN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Jun 2019 03:39:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37079 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfFOHjM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Jun 2019 03:39:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so1809734wme.2
        for <linux-block@vger.kernel.org>; Sat, 15 Jun 2019 00:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mYf89Tucxq7HMsKBTJXq+q8gU2cgY3RvsjL5U+IepF0=;
        b=oEP60rJ9B/zhXBGACmF2weW+++A5uTxCRXC9PvuvKXYyHsocmESHDzG6IATEVq6D+E
         zPAnFRZT9K2/0chp6SxCD10bV/x3/55Gzysd2uHXWSZtyev+zIb4f8tQh1UrZrvE3Hbq
         HqucAQxnEzTohLPdeDc76RsnzPulmi6WzeU0/xABirFIK6VTF8vi2o6+y9DkPjj8umfy
         W9Zwlf0OkqlLeqNazb21qVIs6mVI/ekkfo0vO5rIFaXKcBsOK/Q6LHb05UaA4ZpVFYsY
         zPx474fOkPJJsxroIvsyv+FEO8ut4JB4DUu8/pl0gJDegpO0+XwLVzh3O48vRUR7ezj9
         hV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mYf89Tucxq7HMsKBTJXq+q8gU2cgY3RvsjL5U+IepF0=;
        b=ZG89GOJ9pf4G/SNop9kt4BQKnbFFLKzoI3cWCI5M5SmWrelh4Z9Npm6gEbK5zcZUsp
         VMxU7EeRUImk8nfvl68k+C7KrSS5BJd+Fnt1Ixs+tBdrcjaSE24ftVehO8x7hox96kNh
         LCgCr2ILq5s9bb9MTw12QDUedVSb5Z//FHKmzx1zzjPALmizQ7Y2rfIqWJ4GBR3Zrr4B
         0D9Svcrg6OlbQSURRVzzs1OD7pnK25XUNbAn4UPFfpTCUVgfTa8OGALU65cYVZm1+eTy
         2a+cwb4wUA8SLTBumH/1dnn7s6jemEf2ze1Iv1Plk916jB6QASmVaRxWTGcyLy2hrM5E
         UfRQ==
X-Gm-Message-State: APjAAAVSk7ZySViD6H7BFlQT9R52DmHO2gC22GPBAZFYqcaAB0AOc28g
        YFASWLgt4IwkpMs9loMn5uMSCg==
X-Google-Smtp-Source: APXvYqxc2HGqJL/npLKUF24rYAEpTviEN0O3DkqsASPZMhFs7PHHS7epNkIiu3hVK8iggLzJLALy6Q==
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr10239401wma.107.1560584350690;
        Sat, 15 Jun 2019 00:39:10 -0700 (PDT)
Received: from [192.168.88.149] ([62.170.2.124])
        by smtp.gmail.com with ESMTPSA id f13sm8683183wrt.27.2019.06.15.00.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 00:39:10 -0700 (PDT)
Subject: Re: [PATCH 1/1] blk-mq/debugfs: Fix improper print qualifier
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7f9091f59d0331bf55286d5f78fa20fa4dde2e21.1560486257.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2a8c822c-94b6-1abb-4e52-46e71a749e82@kernel.dk>
Date:   Sat, 15 Jun 2019 01:39:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7f9091f59d0331bf55286d5f78fa20fa4dde2e21.1560486257.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/19 5:39 AM, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> struct blk_rq_stat::mean is a u64 value, so use %llu

Applied, thanks.

-- 
Jens Axboe

