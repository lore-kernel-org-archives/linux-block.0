Return-Path: <SRS0=essW=AB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA7FC433E0
	for <linux-block@archiver.kernel.org>; Sat, 20 Jun 2020 21:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4258246BF
	for <linux-block@archiver.kernel.org>; Sat, 20 Jun 2020 21:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="w2xwOc2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgFTVW4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Jun 2020 17:22:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46309 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbgFTVWz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Jun 2020 17:22:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id b16so6271617pfi.13
        for <linux-block@vger.kernel.org>; Sat, 20 Jun 2020 14:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aNmYYThIQrwKb/CnYFR3qPzspsMeW9XF/8FmP59B/pA=;
        b=w2xwOc2AnM6BiXKYV8JoFnLRvFbrjOAYOTkIDHcfZAeGuhn7z8U1ubraIOTXuYYCQo
         STExqObm7UQKdamVnkf9bqs5IjG7eDSuPKYhFtH49/nFmVeKqQAIq4hW7+0eXS+/6L+m
         hiXyDzXfhgj2Th6+mZD81o1sqcpKbtbKkfg/FixGzeJAUcExUXphOe6ERIwkXtISfhJT
         tWL6RatMMMeWDspEjDzXJVGohrjuJRLexyu4ATa/LRwxsAmdYLuh1dJkHxzo6iyW5Jtj
         rFOAJKm5sx9K6R0sl5v+zFgKT1uG+g/tLkCTjkEf0xrP8yMJS3F0MFpZwE7meC+3xzZz
         tjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aNmYYThIQrwKb/CnYFR3qPzspsMeW9XF/8FmP59B/pA=;
        b=lboP3u+qQr1WQlLgq5vGBqy5VsAr/2QCs3HnMeU9zoDyiI5reHUfaVdBDGmGH8dl1o
         SvfNb41D1O/7odZAUU78CS397mXzDfWdw/2LVI+82NgN5AeRXPywJcfWGwqM+VFf5eea
         T83aqpHD8Fk/lcurbEWWcHrfqQM+3SjN+/sn5hxZUhkp2RaL4JA0+UTc+ImKqKO5rnV+
         hd0K2fxxl8WJ3nIEczZuA80btyaN8YB53Wl35pBFVn1anNaZ2KqJiAWUvFKwy1w95k7u
         y53gbn8JmJ0IWDPS7S8gxfwQa4eK04A05dqzPZg+t/rrkkVihaUGzSZCuaIeR2FNslSC
         EumA==
X-Gm-Message-State: AOAM5320MgJ7pwbmhT23Nk0iuYm9ian0GS5iDCRlr0Va6c0NYjkfHmND
        JxsXAo46N5pN3VgAxW4a1jGgVA==
X-Google-Smtp-Source: ABdhPJwIOpcEUxLA+Tx2u4Sym8EmChXJqY90sCTB5kAjBGyWszcpwUeEvhpKhj3+IN7vie2zB9rm8g==
X-Received: by 2002:a62:5e85:: with SMTP id s127mr253010pfb.236.1592688113516;
        Sat, 20 Jun 2020 14:21:53 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q6sm9305202pff.79.2020.06.20.14.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 14:21:52 -0700 (PDT)
Subject: Re: [PATCH][next] block: bio: Use struct_size() in kmalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20200620004949.GA30923@embeddedor>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ecbc8a9-42ec-c117-42f7-32572b750036@kernel.dk>
Date:   Sat, 20 Jun 2020 15:21:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200620004949.GA30923@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/20 6:49 PM, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.

Applied, thanks.

-- 
Jens Axboe

