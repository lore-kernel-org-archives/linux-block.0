Return-Path: <SRS0=rsSL=Y2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBF4CA9EC7
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 14:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E76F2080F
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 14:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="m6LW3TEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfKBOD6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Nov 2019 10:03:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33221 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfKBOD6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Nov 2019 10:03:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id c184so8947586pfb.0
        for <linux-block@vger.kernel.org>; Sat, 02 Nov 2019 07:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cIqRCDelQ2QzV3ADiNrggvNsE7uK4SPsRu91QQliWOM=;
        b=m6LW3TEsSigobj/S/Uuy6wHLViVXGdoGFXMWyLaGj0NH+ujv0Ybt+rbgh51DMpHi6y
         lD1z1FRy7fXhTLx7dN225D0z0pUV3tdr9z36Yqfu/81U2zEhFRDzYWhapjzrp5TnZgm0
         7azXh9RhlCHlD4Q5VrNNB0cCiSrFYeKInvIdyIlze5/1RTWbavObzMnbLFj2lE8EmdQh
         Hr20d3llTHHbAttzTasScpYQTxOLVKVtI3A0Hb6R+yHhpQGQ4a3vGXj3lio0qV6E8wMB
         BXjgV/cPuKDjBC86VFPV1nYyoHprUEmWAlssZOr9FWNkzGH0IjL80Zw8Efn5vX/Qh++y
         npFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cIqRCDelQ2QzV3ADiNrggvNsE7uK4SPsRu91QQliWOM=;
        b=o4RUNClfXRPS1N4GNBvSPw6Zlj7kXA0g4rHs98zRr8TX/UxszcCLunprFE4ULSCqXy
         8+RGK47SK4Rp7LWXPmJY2lSQUxpCO4u+wDZHEnbDn2NJdejEqvM7zEiiHJsY6RgLJZU7
         8NaztM9VZA7hR0el7zD+dITc6SvP0ogMp9q/SpAq4QRQhAWHo4bS+2AHIGRzMVlQ0ZR1
         6VlXGJdF/qIywrYVOrq/OMiMTDgKyd0B91sgdhk/rXL5e0UfhoO1fcLLm46ORk56UN5a
         qM6XFtSEL6dxFEN+pc6SMMGRIiS0z8j0nHH/XtBbCjvHOW0H84Ko5N6jVYD/O5Pr3oIu
         xd4w==
X-Gm-Message-State: APjAAAWzfi4Um5U1Wsjl43a30Xc6xZYUxHtSLxHKacwkzr2Wupxpnt+U
        uMG4XGfbQ48BptkvaqVySsJVUA==
X-Google-Smtp-Source: APXvYqxFCfGRNK8kJt+Um+HkJ7nPNPJhWf7yglDrAdKMcBLPmJavyuWIE7Ywg6m99GLm5NcuYv83Cg==
X-Received: by 2002:a62:e214:: with SMTP id a20mr4798191pfi.193.1572703436397;
        Sat, 02 Nov 2019 07:03:56 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 18sm10302057pfp.100.2019.11.02.07.03.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Nov 2019 07:03:55 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: avoid sysfs buffer overflow by too many CPU cores
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, stable@vger.kernel.org
References: <20191102080215.20223-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e9438176-1dbf-ca2c-62f2-b0c37f8c9bab@kernel.dk>
Date:   Sat, 2 Nov 2019 08:03:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102080215.20223-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/2/19 2:02 AM, Ming Lei wrote:
> It is reported that sysfs buffer overflow can be triggered in case
> of too many CPU cores(>841 on 4K PAGE_SIZE) when showing CPUs of
> hctx via /sys/block/$DEV/mq/$N/cpu_list.
> 
> So use snprintf for avoiding the potential buffer overflow.
> 
> This version doesn't change the attribute format, and simply stop
> to show CPU number if the buffer is to be overflow.

Applied, thanks.

-- 
Jens Axboe

