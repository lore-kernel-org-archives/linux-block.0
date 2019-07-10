Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77055C74A23
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 13:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0142087F
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 13:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KRiM6njX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfGJN6R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:58:17 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45740 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfGJN6R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 09:58:17 -0400
Received: by mail-io1-f68.google.com with SMTP id g20so4834696ioc.12
        for <linux-block@vger.kernel.org>; Wed, 10 Jul 2019 06:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pIQpfAt1e83serf0hVzNYdFMyomenwlXspGATZm2D+Q=;
        b=KRiM6njX6t1vmNqlvvLgHkpdNJfqY8yiWa+WNZHlRI50xzf8g2DjiBP11Asz8EldIA
         j8ke0n88FJ85mmlAKXneocrdhp1AGtdWmM3PeY29oM7eJVYeCfs70qGMuuOPuGkDGgxZ
         1qnLR0XNkU4QbtQTbQDHdOaydTUuDyx7bgn/cfIOLWQr/DQeT36ve5gMZ6KShieAWDK6
         lzjRYKoj+Ggv3Bx65SNPdMSanWtxS/qvqjkLpOzv4w6/Vyw4/UlV8VnCTHFPJ5Wa+mEt
         0u2QkIQlbBIBYI0zzMTstE+DT1HvrwUkAvsFptT3vMbSIxM5sIGfH4FLvgLR5u0Eys36
         VT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pIQpfAt1e83serf0hVzNYdFMyomenwlXspGATZm2D+Q=;
        b=j/ADS9kkP3O+3Uo9doySL8NMKDSMZbIcCtxgl80Pj1JU8N++bYugbxAX67mshx7N2A
         8FoI8hFMVsVMzwatEOwhqL0B9z+Vxph/X+/GGuiZ1O67LufpFY4eIJOZcCDKUyY1I2Hi
         2JrVKlYbXlLO2EP3bKsQO0vqj/q7bAHKRuP7SMMZkA2KI4Oe/92gsZWbzMgUjP4FmZI4
         dQaDe/+6YkT5dAdIWv8XCbzjISwylZC82s7EepT4L96NxfwdHmynUpKOXnV0jXtzEhI2
         JEGEyFihgkiW8GFCwW+B3U94ULlFFCLUhQvxSbZrcn6GuB6b2HYiV3KlWCPZzsLDwfF3
         qiwA==
X-Gm-Message-State: APjAAAXNEelXR8aaHaRWtJoQo4qhi0KgcYf3I+sYtyDW2iqPbos2tGZj
        cPCmVAtoxE+aMiOD3UQOaMbtbw==
X-Google-Smtp-Source: APXvYqwnmX2gXE5q0b4q6nAa3nYRCxhoCoTXcCbs5d2I2xQNVHyM10JwQONjJeO8S5ahqWZBKEOmpw==
X-Received: by 2002:a02:ce35:: with SMTP id v21mr3732251jar.108.1562767096866;
        Wed, 10 Jul 2019 06:58:16 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z26sm2025659ioi.85.2019.07.10.06.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 06:58:16 -0700 (PDT)
Subject: Re: [PATCH V2] block: Fix potential overflow in blk_report_zones()
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
References: <20190710045310.12397-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7ae06bbb-cb83-0c34-6209-ee9da4abd7f9@kernel.dk>
Date:   Wed, 10 Jul 2019 07:58:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710045310.12397-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/9/19 10:53 PM, Damien Le Moal wrote:
> For large values of the number of zones reported and/or large zone
> sizes, the sector increment calculated with
> 
> blk_queue_zone_sectors(q) * n
> 
> in blk_report_zones() loop can overflow the unsigned int type used for
> the calculation as both "n" and blk_queue_zone_sectors() value are
> unsigned int. E.g. for a device with 256 MB zones (524288 sectors),
> overflow happens with 8192 or more zones reported.
> 
> Changing the return type of blk_queue_zone_sectors() to sector_t, fixes
> this problem and avoids overflow problem for all other callers of this
> helper too. The same change is also applied to the bdev_zone_sectors()
> helper.

Applied, thanks.

-- 
Jens Axboe

