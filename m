Return-Path: <SRS0=eqh8=ZK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037C1C432C0
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 14:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB38C2075E
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 14:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vaWf2BnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfKRO3s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:29:48 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44906 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfKRO3s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 09:29:48 -0500
Received: by mail-io1-f66.google.com with SMTP id j20so7906944ioo.11
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2019 06:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eaV8CYdR5uOeQCmnoGEPpU8yHqsOWAa/bRd3tIwf3Rw=;
        b=vaWf2BnDQ9TvTRoUS/nyuhdFfhV5jQMkEBae2Ob28Sh7FpZnHg/j8C21d5Qel7GduI
         lHuU4TLCpbXHpYLlXIzMp1kJYaePSNXrXtPdJ0xukJvtuh/abaW5eKzWFq9Aer3MgqPv
         NWTKxXb4dmpN3/ErAhxr0Zf4/0GruDip6d49Jzr62N5+K3K32nDD8jT27clMBDRV/Tm3
         WMoopa+kCx1XmqgGI2plrqMcmC2f8QyJbpZzJekHH35YYrs5ba0q/bKUGO6OO/FMXt6x
         n3ctVN0IVDSmRdQUiJ0DylQHXJBkzYW+cx+20MwyXL7q4zW3cVr0xg18SrOrF3ACtUv8
         ceag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eaV8CYdR5uOeQCmnoGEPpU8yHqsOWAa/bRd3tIwf3Rw=;
        b=OK7Q0ZlXo0t8W4rTG8/+3yIhFUkKT5/3yvnyKDn/7TB2idzj986KVeiqizjBrA88vq
         ISMuG0N2bU9XSsxXZ3K5YE9BS/sGodkggq29QqnNEhrumbbgDt2atFB2ul5IBukYlJwT
         SqkT7ccPem/Bw7TXRCFvubB+VH+ecIVTPRJIhepeMzPd3PIDT4Tpb4y9Q4QwJFVZpmm8
         g/tLi60Mlv6HX5B2+N1Eekd4l3/U9naL7igE3jRS+ASz9Ze/MDnx7/J2JexLxnSZN0ga
         yQ8EmKBqb5dWvszen8j5chS/zvftIoomdAuNka14CvmlvbY7W4AFxv5e4U2/XTKErjkN
         yUzw==
X-Gm-Message-State: APjAAAWsmsln2+X/YeeDnQo7n7c/oEcd038mEiQZMIln7SeWxs+E4XD+
        FSFy3NPudZZqCE2WDbeUZ9DMMw==
X-Google-Smtp-Source: APXvYqzpAIMv2uD79MzRHPIlKiChbRp831lpdIEdEZBMS94NwLVI6IkqLG9TZEmxIMgGCkYhialPZg==
X-Received: by 2002:a5e:cb42:: with SMTP id h2mr9600192iok.39.1574087387195;
        Mon, 18 Nov 2019 06:29:47 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l15sm4608247ils.64.2019.11.18.06.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 06:29:46 -0800 (PST)
Subject: Re: [PATCH] block: Don't disable interrupts in trigger_softirq()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
References: <20191118110122.50070-1-bigeasy@linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <36c9455b-3185-537a-04fe-d82b2060f961@kernel.dk>
Date:   Mon, 18 Nov 2019 07:29:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191118110122.50070-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/18/19 4:01 AM, Sebastian Andrzej Siewior wrote:
> trigger_softirq() is always invoked as a SMP-function call which is
> always invoked with disables interrupts.
> 
> Don't disable interrupt in trigger_softirq() because interrupts are
> already disabled.

Applied, thanks.

-- 
Jens Axboe

