Return-Path: <SRS0=KgRV=V2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AFBC76186
	for <linux-block@archiver.kernel.org>; Mon, 29 Jul 2019 21:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669A1206DD
	for <linux-block@archiver.kernel.org>; Mon, 29 Jul 2019 21:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Aa2vh5RM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfG2VZU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:25:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38551 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729545AbfG2VZU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jul 2019 17:25:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so28663313pfn.5
        for <linux-block@vger.kernel.org>; Mon, 29 Jul 2019 14:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e4UROmkEn8ifoxqunHEl1ezq48oKFVyKfsWKm4P+BWo=;
        b=Aa2vh5RMfizdjhMmmlTmKp4+1DiKR0n/vsDn7XRoWN+XIEsK2lWOXPXD9TqUT9Ce56
         J+ps7d7S86zJwqFA4r7B5aGKoEgoCzbCjLSqZdF4tBr8OLA6T4gD1PJTaawV+fd+axPm
         2w6TagTMAIV5M9JhuF+Bl1k2AucZnS2szKD/5lACq/3/AV5UPtU5aNp89gt/e5m0delk
         15FPKi3gj5jLPKMXaKdGj9KKPBBnc5Xge0tEfYVmh6MkoClXLjfh2cR+3IA64DK218wr
         6Js5bDB2IZpJYonONMlhAFJt0KRNHmTOw+B/EwRRgteqRgARG4jKrfa93fU6l0Et77DM
         OlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e4UROmkEn8ifoxqunHEl1ezq48oKFVyKfsWKm4P+BWo=;
        b=d8oaGL+foD/1cGBMD0wf45nyQmujwGUJqzDFLMLW8NHc2fmvzujiwisFVeHvvd5AZe
         3KTUQlmyFAZuQCqL0SlT5xxXh0h18/TYkSVjgHtMzSCnzsXkTo/r7PwqFLPTbk+nLjpx
         8tYRYD8/xwFGEgao+P/ACwoDQZjW5YRSNBsMEwlmCTfiBQKmzD2ZOXILQtMJg7oM6XAq
         B2AKZ5WBtUDQ6PkGqHaFfoBiu1TafvrZNBCPTXGYEJIX9yDqfoVAXxTzuahZbfnWqkTY
         IeyEKyU9RaCKhFoTiHUmxB0m4AwJmYKqtgxspo4cguXD1ZpGcpH+wLajHhAQEojKOuHQ
         nAKw==
X-Gm-Message-State: APjAAAU3em4raqpitbanBjnsiKpXwapTcxxqBz9JB9i8QypPYqA02T5H
        QPfCFnesuvqqmcttS0azM20=
X-Google-Smtp-Source: APXvYqzv3Q0CqVHgm2hXgvaa1Jz0BmulxQb73Hbija/wpgeNdtCDipnA5j1gttMeRogJ0XRd/SpPtA==
X-Received: by 2002:a63:6fc9:: with SMTP id k192mr104672369pgc.20.1564435519803;
        Mon, 29 Jul 2019 14:25:19 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id t9sm64032388pji.18.2019.07.29.14.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 14:25:18 -0700 (PDT)
Subject: Re: [PATCH] ataflop: Mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20190729211053.GA6735@embeddedor>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <80ad9bf9-4d50-a436-586c-dd9775e3e186@kernel.dk>
Date:   Mon, 29 Jul 2019 15:25:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729211053.GA6735@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/29/19 3:10 PM, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warning (Building: m68k):
> 
> drivers/block/ataflop.c: In function ‘fd_locked_ioctl’:
> drivers/block/ataflop.c:1728:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     set_capacity(floppy->disk, MAX_DISK_SIZE * 2);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/block/ataflop.c:1729:2: note: here
>    case FDFMTEND:
>    ^~~~

Applied, thanks.

-- 
Jens Axboe

