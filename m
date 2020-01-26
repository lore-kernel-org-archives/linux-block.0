Return-Path: <SRS0=p+1D=3P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8AEC2D0DB
	for <linux-block@archiver.kernel.org>; Sun, 26 Jan 2020 16:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CA42064C
	for <linux-block@archiver.kernel.org>; Sun, 26 Jan 2020 16:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="A0RTVikr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgAZQ7a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jan 2020 11:59:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40145 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgAZQ73 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jan 2020 11:59:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so3767863pfh.7
        for <linux-block@vger.kernel.org>; Sun, 26 Jan 2020 08:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CfnACrmYaqe18th+pDc23LsCSX3tL+iczGYFf6nx5OQ=;
        b=A0RTVikrJQN4vCWg5vPL54PYt5iM2/cYMTHroG0yBwSffKNwaks0yUt9mhPefnwAI9
         o5hNHUZLL2g2mXPIkidQoT7FYSYNEumRxK/PEMyQR1j8j8YEPwvWaq900REl2SbbCDIP
         0hRXx5yNTDzA5egwzZGoajFuqtobEiWW/YtFT2H4iJRn36o9kygAmJbwZGFXuKxThqLV
         z2uIOvOofVOhmUAekV7Vabwmrrnc2tJ4eM8f6Nutxser12Dg8a7k9CQO1gYTzoQJtTQ+
         svgSuCtnK/RsHHnL0JxwIHQHdnLcmQ4PsntkuHaMiof9evSBq04nQBp50FJXGNe4zoX6
         IIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CfnACrmYaqe18th+pDc23LsCSX3tL+iczGYFf6nx5OQ=;
        b=TeaJy2TCWNjT6Ug+sDaOJMOKJMGFndkjsNboTFyf08jWP7Znn9xVfNgRgxWjlblmZo
         PS6Je3l0GpZrUyt0KHJKotiDg8Vmnq3UD9xzAMY9gNigxnQl9D+0T01G9DTiLArSZeSv
         R6NqMBLoAO+eKi8Cnoap9bLoOR674/bmiTYDGALrJt/MTGPSv1ZcHNpVhhMCuz3cEDOu
         5tpKnb5TpQRoUL8TWpEWrfSjMZMh1Jzauqg0JZjrXMzgzEzKVkadukiv2DUzvT+nyJww
         A8ZMSEbrGuBnFmY0aAxeayywPHWDU2UGbXP8uUIlR0K0NbEPeImfoaWFbEmJcaiLyHNI
         qXiw==
X-Gm-Message-State: APjAAAXclmAK3HQDTq8k68pdPRbTFgk/7plDpTd40DSYlkeF58k/5A7g
        gYwSCBN5fHuO6jzfY5NaK/9C7Z5y9dY=
X-Google-Smtp-Source: APXvYqwsa1TpKQLZ1rI9/UKN+waI9KxWHIo098kUPfF05yzCm+RhZIzYWuHSVd/ZgwwsvI7hltRzGQ==
X-Received: by 2002:a62:8602:: with SMTP id x2mr12635419pfd.39.1580057969092;
        Sun, 26 Jan 2020 08:59:29 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id q6sm12581375pfh.127.2020.01.26.08.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2020 08:59:28 -0800 (PST)
Subject: Re: [PATCH] block: allow partitions on host aware zone devices
To:     Christoph Hellwig <hch@lst.de>
Cc:     bp@suse.de, damien.lemoal@wdc.com, linux-block@vger.kernel.org
References: <20200126130543.798869-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <21da6aad-107e-e053-bec9-574faaabc265@kernel.dk>
Date:   Sun, 26 Jan 2020 09:59:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200126130543.798869-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/26/20 6:05 AM, Christoph Hellwig wrote:
> Host-aware SMR drives can be used with the commands to explicitly manage
> zone state, but they can also be used as normal disks.  In the former
> case it makes perfect sense to allow partitions on them, in the latter
> it does not, just like for host managed devices.  Add a check to
> add_partition to allow partitions on host aware devices, but give
> up any zone management capabilities in that case, which also catches
> the previously missed case of adding a partition vs just scanning it.
> 
> Because sd can rescan the attribute at runtime it needs to check if
> a disk has partitions, for which a new helper is added to genhd.h.

Applied, thanks.

-- 
Jens Axboe

