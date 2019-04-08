Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ADEC10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A5021473
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PY7IxFzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfDHPBW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:01:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39783 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDHPBW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 11:01:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3so7479079pga.6
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LaHrubOReFozmFeTDPlIY0uKL2st1iavJ7Kz8XOZfys=;
        b=PY7IxFzlGhViayhuK99TrPj0sEfIyzGmIsmpiPAR0eTXVeAyy1vAnePpVk2xq7yvfn
         FSEHsUgnIFy2klXMulpcOk3ZRLOoD7RRQqUTi19hlHxb6QwM1dO8vN9DgA5z1AeR4GIT
         HgHZ7fGAJkyhMxK5L26uQImwrMiLq0J6umDLsO6ANyBP5rcP6cOYcv+JoCKfWO8YLzZV
         0+NXs3hSSqsmGQEWAqnfxnSFS2D1ubSQ6ID9wmJDbN4Ap+QmXnmPygr2YjKkZbtyc2Pd
         WX2kxwoZPN9CJAbUClA0xHih4zwbrWe1WEPzq0c5CZSbLyQ4CfXPfGrpnt4YAVBpZNWt
         uN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LaHrubOReFozmFeTDPlIY0uKL2st1iavJ7Kz8XOZfys=;
        b=QdrrGLiL9vY66gN+WFZspY7cwhdjZ7/uu97c6SHoOKOrH25JWUkenO9vD1UzQUoQP5
         kVPPStzLO/EGZmGFadnjRkzi0JHWmSJDpsY6+HCOLqwixzIn2a1N5MKwQrc6XP2Kv2vy
         sJD55SYF4u7z8cLh2mCuBuwR+PAjowiK2ylhbEGgTnOzBRKfXgjBbgzAwCU9vyF06hls
         hmkPp0OUJU4gZx8lSKggNbu09sMjGmk5QDq0/aufYbPSz0V5uIcsUEeXLmzJmxul5iKN
         WpeUqD+MmL57eZ0N4Hn3x/dnSI+jOtnvFfNdPMfFJ6AZCuOHqtzDbxYRzDvciTmY4m3o
         /ANw==
X-Gm-Message-State: APjAAAUCvDwNfVQiSjpgROFQQ9GsWUisIUoS4YpDyabPaKK3HRmVhvYz
        bAR1eBsRVEA45vWWr5i/W8Ydog==
X-Google-Smtp-Source: APXvYqw0zaknEpCG4OK+ILLdErXeU2cRIkVaARlhbFydAFDfocYLsIiWUd1NV84170jM3/tYlx2jHA==
X-Received: by 2002:a63:db10:: with SMTP id e16mr28762512pgg.142.1554735681626;
        Mon, 08 Apr 2019 08:01:21 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c1sm42564428pfd.114.2019.04.08.08.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:01:20 -0700 (PDT)
Subject: Re: [PATCH 1/1] block, bfq: delete "bfq" prefix from cgroup filenames
To:     Paolo Valente <paolo.valente@linaro.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        lennart@poettering.net
References: <20190408143935.9062-1-paolo.valente@linaro.org>
 <20190408143935.9062-2-paolo.valente@linaro.org>
 <20190408144925.GA23021@linux-x5ow.site>
 <7B68DAA9-61D9-4AE0-9FA9-05C07C7FE408@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <51290bbe-21e0-1f12-d163-78dfe0d09bac@kernel.dk>
Date:   Mon, 8 Apr 2019 09:01:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7B68DAA9-61D9-4AE0-9FA9-05C07C7FE408@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/19 8:54 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 8 apr 2019, alle ore 16:49, Johannes Thumshirn <jthumshirn@suse.de> ha scritto:
>>
>> On Mon, Apr 08, 2019 at 04:39:35PM +0200, Paolo Valente wrote:
>>> From: Angelo Ruocco <angeloruocco90@gmail.com>
>>>
>>> When bfq was merged into mainline, there were two I/O schedulers that
>>> implemented the proportional-share policy: bfq for blk-mq and cfq for
>>> legacy blk. bfq's interface files in the blkio/io controller have the
>>> same names as cfq. But the cgroups interface doesn't allow two
>>> entities to use the same name for their files, so for bfq we had to
>>> prepend the "bfq" prefix to each of its files. However no legacy code
>>> uses these modified file names. This naming also causes confusion, as,
>>> e.g., in [1].
>>>
>>> Now cfq has gone with legacy blk, so there is no need any longer for
>>> these prefixes in (the never used) bfq names. In view of this fact, this
>>> commit removes these prefixes, thereby enabling legacy code to truly
>>> use the proportional share policy in blk-mq.
>>>
>>> [1] https://github.com/systemd/systemd/issues/7057
>>
>> Hmm, but isn't this a user-space facing interface and thus some sort of ABI?
>> Do you know what's using it and what breaks due to this conversion?
>>
> 
> Yep, but AFAIK, the problem is exactly the opposite: nobody uses these
> names for the proportional-share policy, or wants to use these names.  I'm
> CCing Lennart too, in case he has some improbable news on this.
> 
> So the idea is to align names to what people expect, possibly before
> more confusion arises.

We can't just rename them since they've already been in a shipped kernel.
The window for doing this passed long ago.

-- 
Jens Axboe

