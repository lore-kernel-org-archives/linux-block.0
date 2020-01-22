Return-Path: <SRS0=Jk+C=3L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7AEC2D0DB
	for <linux-block@archiver.kernel.org>; Wed, 22 Jan 2020 17:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C94524673
	for <linux-block@archiver.kernel.org>; Wed, 22 Jan 2020 17:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uzh00Ovu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgAVRba (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jan 2020 12:31:30 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39805 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVRba (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jan 2020 12:31:30 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so70015ioh.6
        for <linux-block@vger.kernel.org>; Wed, 22 Jan 2020 09:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QhmytsAHT+fQWKcDzmw1PiTvOkc+/ne5RpL730u18Rk=;
        b=uzh00OvunkHvzy7F38nibq3lJZLQdl+pKhWD9CrDrau675hae2smPZOXnvF6pL6DgZ
         CgW1L1nObjMBGzHlWckZGLL4YZVkU61jGrgndOEH98zcFyjIiWwppXijplKrUadWMHiF
         RMyYJ8rrsvmRhhU/qCPYK/hIIHt1R278L+0UJeuqXLb8Ju+a2tcFK1M1xjlRYSE6Ovvc
         3CYCjMYBNKRU9o86b/fWRabZk5x76sjJUca//+gI//1gLEDMoINXAwwT7J7sA15wQXHk
         6WvnI/7vJNm+HzeLlKH43OhQABCgOiZlEp+63/gtKjObP1kqjCuw+zYzYtJnQHjP/LZc
         k8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QhmytsAHT+fQWKcDzmw1PiTvOkc+/ne5RpL730u18Rk=;
        b=jWApUIwLP3J5E2zBkdTMWqyRNPbvLlyDs8gX+d8gEEhdlN1qyFtHNZ+eqIWkSsA7C5
         dCl0aRjgAriA9/cE7v/jV3KfcH2rkPhk7mu+eMxXekhTRRchQVX7d1zd8R2W7kDeEaRF
         WKxz6YmM2CRxhI/0rrHM9YOMOnl/AEbFhVnQhVfQYP/lrYj6d1NA9pEt2Rd/Itc2Ifv7
         X9LDrZCewIh9asDBGJp6ytK80vycaWY7dJDgKEIuSIqXhF6L6NIvqY5yQ3ZtsKxjZuNI
         ad9EZgX1gOOa6c7tci4WdXl1NkZ+5F2nQmrJyIxISJcaxYlYlZj7eQDZHz3fdjaEiioR
         ux0Q==
X-Gm-Message-State: APjAAAV7QEL0gO/TQXM+r/mLpEj4os/Tz+wAwUNp7lK2fpMQY8owndUK
        O9PB91i2zeb113OexOPlpiZU8Q==
X-Google-Smtp-Source: APXvYqyYc85e+ep55jcoAbCKz4ESlvKLEz4rjhsH70uEJF6eltTeHdBh2rGUEjG8VIiwrW03GzA5SA==
X-Received: by 2002:a05:6638:76f:: with SMTP id y15mr8152403jad.5.1579714289314;
        Wed, 22 Jan 2020 09:31:29 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f2sm10861732iok.20.2020.01.22.09.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 09:31:28 -0800 (PST)
Subject: Re: [PATCH] block/bfq: remove unused bfq_class_rt which never used
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1579596534-257642-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8e4f68d3-28a3-22f6-ae55-814903d990b9@kernel.dk>
Date:   Wed, 22 Jan 2020 10:31:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579596534-257642-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/21/20 1:48 AM, Alex Shi wrote:
> This macro is never used after introduced from commit aee69d78dec0
> ("block, bfq: introduce the BFQ-v0 I/O scheduler as an extra scheduler")
> 
> Better to remove it.

Applied, thanks.

-- 
Jens Axboe

