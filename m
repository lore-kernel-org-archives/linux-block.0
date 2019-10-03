Return-Path: <SRS0=GSyA=X4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7141BC4360C
	for <linux-block@archiver.kernel.org>; Thu,  3 Oct 2019 02:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44237222C2
	for <linux-block@archiver.kernel.org>; Thu,  3 Oct 2019 02:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RXesFoYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfJCCcw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Oct 2019 22:32:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44246 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfJCCcw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Oct 2019 22:32:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id i14so758387pgt.11
        for <linux-block@vger.kernel.org>; Wed, 02 Oct 2019 19:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K19dUfKMeY8BLXEsXBk6OU/EHlaRxwCl2aUwG6ZXU0o=;
        b=RXesFoYn7HN9To3yjNAdE8us7kMG9/9UJ7QKwCLlNr2HY6CVA2Y9UhrIA9zp3N7dAI
         RD5+HU6tgVFehQV5nDtR68jv0DJuqxXNQp6z6jX8TjRhsync8EJilwihK0X7aZgft4tf
         XI41J68VewsYeOtOzs/g1pNjCKcKZYQKMC+UFx7HS6X99jKuxm6DEOUHho0qoTjdQ43J
         4im4CMYhnYCFUhJe03JnH9IGY+HNv2o1bPB2NDPTKfW9WrxhF3awJcdc7I+sr4TFHM9L
         fGGuz+3kX+V5w7zZqRK7lRU4sKBoWEpeT40XjZ3HZIvORfj5pXwEKzPn0qi5qM1DfBT7
         l0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K19dUfKMeY8BLXEsXBk6OU/EHlaRxwCl2aUwG6ZXU0o=;
        b=hUnxT4oXd84SrnnzFjs0tZh+VolZC8RICPHllD+4NgnnxOmyW8leAKl4E6zJg0TswI
         UX1JoVaTOXfZUtvpzf6+2+XpI1jDy5VFDPGxWuh1WKTYzsV4xVjcCUfYoGQwR55Koobi
         MJgbs+G4Fyoca4Ne891vbHJMEpCfMqL8+FJPMpUsiGRt7nxKvpRjusax507VJFCnjcik
         yUzPjzzn09i8l0kI+8/OfI7c70cCp/Zz4kvQsGT1uE20+HoqI7G3QC+kNB8vtFNzvIY1
         liKroZHqVBia8k0M6CK5Y69tXhEaXW0CUzWXQdhlgEMhoE7vDNQdpMz8s+pA6aOwa3K1
         Rabg==
X-Gm-Message-State: APjAAAWEofeN0ArquiYk2VAkb/iqCKZEClTV9KEm8Y2sPgSDU2hrvJ2A
        FbZ9pvijm5te2gZ2uBTTdoxBtg==
X-Google-Smtp-Source: APXvYqzVsD7R/zMAePisZn0a9vUIXisxTGyyA+gIBLXagTz6/76dGMuqRiU6CxCmZi5V3UzC9JIBnA==
X-Received: by 2002:a63:e444:: with SMTP id i4mr7151634pgk.45.1570069970102;
        Wed, 02 Oct 2019 19:32:50 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 69sm755865pfb.145.2019.10.02.19.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 19:32:49 -0700 (PDT)
Subject: Re: [PATCH] block: pg: add header include guard
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20190720120526.7722-1-yamada.masahiro@socionext.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ef3a7522-4753-33c6-6611-e48a2f641bfa@kernel.dk>
Date:   Wed, 2 Oct 2019 20:32:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190720120526.7722-1-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/20/19 6:05 AM, Masahiro Yamada wrote:
> Add a header include guard just in case.

Applied, thanks.

-- 
Jens Axboe

