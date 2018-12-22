Return-Path: <SRS0=4yxV=O7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFB2C43387
	for <linux-block@archiver.kernel.org>; Sat, 22 Dec 2018 21:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F6621939
	for <linux-block@archiver.kernel.org>; Sat, 22 Dec 2018 21:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wtyhzseX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389549AbeLVVqN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Dec 2018 16:46:13 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:35057 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389327AbeLVVqM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Dec 2018 16:46:12 -0500
Received: by mail-pf1-f174.google.com with SMTP id z9so4219603pfi.2
        for <linux-block@vger.kernel.org>; Sat, 22 Dec 2018 13:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ytj7gMbpowbrGKDZt5NR1y1PXxhxqd5lg2zYd+Jzz6o=;
        b=wtyhzseX1SPmUWZOx1lCSevWkJhmGpkit64+C3V+GX7EBcEvuVVOkaMx55MIzUdcx3
         eeFl+si7T0xZ/Gd/FtCKCcL29XUAAamlLrCx8Hrw95wEF/OfCZS2xPbkL62j2HZZBQek
         HR5wTEsFps2o+xEEODmyhv5zQQ8rhZXOg/uxXZlsTK3GFmbLvwhj+P4s8pkT35Sy7CHG
         RysnDZki0j0qexs9qyGgPvfoxfQiq7PG6BC6muPzfErn8WfZq1CsHq9pJb5g+glf9qFr
         PGYLVoGv8U0eMQ2rXDkJuSr4VoXn8oimA/dda++VwZWhgKL+12OT356W1BnOTzbDU1JH
         yDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ytj7gMbpowbrGKDZt5NR1y1PXxhxqd5lg2zYd+Jzz6o=;
        b=d0ZMGIXFyvB0h7GfoihkOJaNDvZYisCn57DpVUyctDlNa3hZsf9Rx2/keXRgMkja/r
         4yymJHDN3H9TEjr4zoDSvwz8ubfRv3b7vioja6hIgAPIAPW2XZAewXojP93pjXo0SW33
         wDhb84X8VOGJZKbZnoXgKlomMGCprI/7hArKJk7ejMvmAAipbj0OcSHkOARYqG1W6LEG
         MVXvNa9ZTLWx46Aa/PnVIzx0/DCFG+HrZXAf30fqY6sSooxp6UpU+05a8PgbpYXtuKjB
         fHKfVXSvCnZ7RgIQenPXk/1WimhlM4CX9erYqEP+moqdnUBYFNExJxWq37bbfEWA6kMD
         6VIw==
X-Gm-Message-State: AA+aEWYxx5rLZPtO5AmqhtHQQnn43nVchsM70xPCdD7eiyBzuEsxc1Vf
        GadwUsZ0ytOkZFpz5sKCdbP7TjgfO6fQBw==
X-Google-Smtp-Source: ALg8bN5Rok0Fio7mdKRDX6BSO0rjDu2h95Xy4K6Lfnjy8J3MaL1HuCBbZt9ZgGXV2V6BMPoZ3HGHgg==
X-Received: by 2002:a62:5444:: with SMTP id i65mr8100586pfb.193.1545515171517;
        Sat, 22 Dec 2018 13:46:11 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id f6sm38743068pfg.188.2018.12.22.13.46.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 13:46:10 -0800 (PST)
Subject: Re: [PATCH] block: loop: remvoe redundant code
To:     Chengguang Xu <cgxu519@gmx.com>
Cc:     linux-block@vger.kernel.org
References: <20181222124715.29051-1-cgxu519@gmx.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ed18148-5dc0-8ac8-ea9c-e1676cbecf10@kernel.dk>
Date:   Sat, 22 Dec 2018 14:46:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181222124715.29051-1-cgxu519@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/22/18 5:47 AM, Chengguang Xu wrote:
> Code cleanup for removing redundant break in switch case.

Applied, thanks.

-- 
Jens Axboe

