Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDB5C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 17:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCAD20878
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 17:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DiR6SKFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCAD20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbeLFRA4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:00:56 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:52221 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLFRA4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 12:00:56 -0500
Received: by mail-it1-f181.google.com with SMTP id x19so2467951itl.1
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 09:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=39g8w68ir+kBtdlC5K2x7u8QX2Q28JWOq72mzt3jQ8Q=;
        b=DiR6SKFWH8+QapWb5fjkdTMj203AcocArd7fDcGX0d7yVHW5+Mnz2tZrSgPShGBJe2
         hLrY6gQmTZUs3Lu4lHqAcLaslJ35lHnQH78qxrFaWZeA7lsyd1DD4JYiBxt/FSm7iZke
         VcU/2KZWiTgFrpvjAqgogw9vkXGii2ZQ353t2jyVTeFFoUUcgyXsMS/VDu4yFZmjf7X1
         /s+cL+c5LLo5JpWfomFqJFzDaIrdI1qInsuiswpR10rWJijmySkGt3oZYn9K+4HNAuA8
         WA8YQGJ6D1grI6W3WuG3azGbUgOGzMs/aiE+WI/fQf2CqoNFZtUz6Z/5s5bvwucJ7afx
         xPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=39g8w68ir+kBtdlC5K2x7u8QX2Q28JWOq72mzt3jQ8Q=;
        b=GTLZ4oinNki40Euvq/VGRXvAeBfRhdrHEyUUBblfn4oxqMKPoUTKbh+8vDwvSwirCW
         5AHl2uHSqTyqnYZ30PSJiF+mZ+HcBKULDlIuUXw1Y6pNdEXpmebBbcGDz7dsJ9yAj3Sb
         Nko0C8ypEqhcyyjkbaES0HDRQl1oN4GNyy6lYoURgla3TT0rXQAguyj3lHzqOjETBNO1
         38pkxGfChCHuCzLGLudKyaEndEcajZqGHAO1cVRmT+c1QG57TpnhPCIZ4j9MXV71OpET
         vo4Um9Cz37cYTq98v+pXp4mT3aZ8cJG5a1Pp56HzHmNE7RuhdcUSU/pfatmAcTEcVG6o
         AGNw==
X-Gm-Message-State: AA+aEWaCMG21WoM6NELtnWFDClRFLi8LHyJAq/dRvonYxvJS/3s5Zdfn
        9eoDNYqjE6M/21jm1grHrvM1uKPKgBc=
X-Google-Smtp-Source: AFSGD/UOTlx3gNX5oy8e+rwfYT4JUMbpg1nR4MEsZuXU0nLjkq3emGODaG5RprSL2O4cmq5lqaA5ZA==
X-Received: by 2002:a24:5411:: with SMTP id t17mr18652240ita.32.1544115655765;
        Thu, 06 Dec 2018 09:00:55 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id n136sm622278itb.35.2018.12.06.09.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 09:00:54 -0800 (PST)
Subject: Re: for-next branch and blktests/srp
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <1544114872.185366.250.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <41bbac1e-7461-4378-a18d-531b625d6784@kernel.dk>
Date:   Thu, 6 Dec 2018 10:00:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544114872.185366.250.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 9:47 AM, Bart Van Assche wrote:
> Hello,
> 
> If I merge Jens' for-next branch with Linus' master branch, boot the
> resulting kernel in a VM and run blktests/tests/srp/002 then that test
> never finishes. The same test passes against Linus' master branch. I
> think this is a regression. The following appears in the system log if
> I run that test:

You are running that test on a dm device? Can you shed some light on
how that dm device is setup?

-- 
Jens Axboe

