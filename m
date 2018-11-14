Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCA8C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B785C22360
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QZNBrAwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B785C22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbeKOBhT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:37:19 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40761 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbeKOBhS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 20:37:18 -0500
Received: by mail-it1-f195.google.com with SMTP id e11so24437376itl.5
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 07:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OKUEeYY0/sxvI0EFaCuR5rTAR8Ly18hzLtp1icGV7Po=;
        b=QZNBrAwiaIIbQxxwxDEVOBWnuAxvPhNimWy9LYllQpWVNI44fyt0AEGpdirONa8RWY
         jOdsS6zXwIG0rgxPQ81YeffKkPRih6EiolkLC3nzQYNKeeDlrbQI8EvDJX+JqtZrYjtH
         pTTug9KQ8oYTIP+gjrjFgEBuo9fEBRBP+Gj1kt1+9AZpv7ROLr8QtoFqG+WujYUeMq6U
         pKinrSBHQfPs1ytJKFcQu47KPD+en23AijEf7RRKNvUyVxju+Gj3KuBfpJXF9pFSVtDM
         cUC0+qQzA5HrFggP6yb31bzPVJFvjTWYMt1xKB8G1kBaAH1QAGobteuLjK3pNDwK2n93
         NRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OKUEeYY0/sxvI0EFaCuR5rTAR8Ly18hzLtp1icGV7Po=;
        b=Q2/XpvC4KGAjyct406chLJL4bLLY5ajo8HoY1lPORdP0YYkElErlpYrLVTwATxFe1L
         LB1yiRH/K8hFRGxPkwXQbOfmCjC9XSmtRamDgkmRsQ9Wo+009xWOkTmmmhtDm8A/1jWq
         H7/nCc8G3gbLdsvM4UWBpiz2EOQ8dKlwkCgeIM/0rZy9rIWin4i1XVWfVHje29vafd/1
         D4JLXW9zMt1bPD1G6d7owFRkA7BkP9d2DsfWBUunYOll6PNnaw3pb/tLhpT69Y2kyMWZ
         IxiS2OyU+gV2hre76CjY4pb6L48aLIysWbX6uYNVKGYJ8kCRm16EriOpQgwDHrTBooA9
         lYDQ==
X-Gm-Message-State: AA+aEWbFW/6DzQaD+HILH+Q3YXCaj9fbdEGoKlRcS7rknbLcJyl3owGy
        h3dp/OMyUdBMBD9NiwuTgYyAe6eUSGc=
X-Google-Smtp-Source: AJdET5ca5xnldKzJac6hDqfYpHUletEjXsIhXnPkazVnyIJWZTwF0F2tOV/5ZWpIzUvSOxtw618GSg==
X-Received: by 2002:a24:97c3:: with SMTP id k186mr2019288ite.125.1542209615550;
        Wed, 14 Nov 2018 07:33:35 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id z5-v6sm6178971iob.68.2018.11.14.07.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 07:33:34 -0800 (PST)
Subject: Re: [PATCH 5/6] blk-rq-qos: inline check for q->rq_qos functions
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20181110151317.3813-1-axboe@kernel.dk>
 <20181110151317.3813-6-axboe@kernel.dk>
 <20181114152132.GB22186@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e81bc8be-cbb6-6f78-c358-32c7eae4e454@kernel.dk>
Date:   Wed, 14 Nov 2018 08:33:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114152132.GB22186@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/18 8:21 AM, Christoph Hellwig wrote:
> On Sat, Nov 10, 2018 at 08:13:16AM -0700, Jens Axboe wrote:
>> Put the short code in the fast path, where we don't have any
>> functions attached to the queue. This minimizes the impact on
>> the hot path in the core code.
>>
>> Cleanup duplicated code by having a macro setup both the inline
>> check and the actual functions.
> 
> The inlining sounds fine, but please do it without the obsfucating
> macros.

Why? It's a lot of code duplication.

-- 
Jens Axboe

