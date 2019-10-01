Return-Path: <SRS0=4xm9=X2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F16ECE587
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 14:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C8D21906
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 14:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ghk4OsGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387876AbfJAOJX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:09:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41627 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388689AbfJAOJW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Oct 2019 10:09:22 -0400
Received: by mail-io1-f67.google.com with SMTP id n26so19749135ioj.8
        for <linux-block@vger.kernel.org>; Tue, 01 Oct 2019 07:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8RatxRyirkC/4rfNMMyrhD+loNoE95qLYi7XTzhLkh0=;
        b=Ghk4OsGG6Oz7tZ5M6eRx1P6XEdLbmrF2aEY6vccsaJberBmlyClMkjTnCDUvfgSoy8
         oNi1eKeNRo3+bYcSn0gvIlsZKya2riDbF2MmiNMpb7tr9rGA5cB4bFPRVNLp4ol9yMiW
         QOU8U5m+QQemvlzF+O/n94HQ8AEX+KydRPxZLaXLyFrOhBDD0qb8JoT7+7HaiAsuSv5X
         3yeuYt/vsr2NBT/WYeEUw/mYX2/5yk5mfMBYthUynDq3HY2i1hMmJq87rszhxXsnTUL4
         vfcatmG2SXm3yADHfu0rFgwrswiTFriyhC9Ak6WlppWNDCzwuRW1URjT03nKqaIGOZ8v
         YlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8RatxRyirkC/4rfNMMyrhD+loNoE95qLYi7XTzhLkh0=;
        b=DOHcu8zhcVN+LOYb0ozULsqAnRgIjq6/u5JPbOO6G8p2WAa0vVWmDoutqXt1qDBaYS
         Ux0Ihw4v49hM2up9thyh1I/e0WT/nudLuz1HeEJFbB0diXQ+XYMRraF1u9AjhSHirjlC
         jbTmm4ZTt5IsF70NgyPWhgKXABve/1mcDZCGJg6sm0skV8DVCJwEV9yCRUWvL5Q4j/o/
         9/evhc/chH1BLXuBdnMxGlSfQwi7zSZfW97tii3GxAK1jU6gnpxmYKxMG5L+UWBc/Vj7
         ogd5Ygk5gkLSnap8O9ywZmgCuOdYaWQJm8ZZ3oi/eZ5/rMyv/grBenKImDaEueDKVbau
         9TTA==
X-Gm-Message-State: APjAAAU/+LZDtXtVbyn0TQ02F5yz0Wk4v2Mmy797rlLZVx/Czpj+ftXs
        KiS/zWqg0amwyaRwpZWqB9jigdG9fx+AVg==
X-Google-Smtp-Source: APXvYqwIU8KTZ8E+y38iJxYiNYbx3DqPrbV92LcVOROG8LhAavzL5GtuetwG67KAKXV7C4rnKXRPBw==
X-Received: by 2002:a92:6507:: with SMTP id z7mr23935789ilb.191.1569938961846;
        Tue, 01 Oct 2019 07:09:21 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b7sm7177343iod.42.2019.10.01.07.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 07:09:20 -0700 (PDT)
Subject: Re: [PATCH] io_uring: use __kernel_timespec in timeout ABI
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        Hannes Reinecke <hare@suse.com>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hristo Venev <hristo@venev.name>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190930202055.1748710-1-arnd@arndb.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8d5d34da-e1f0-1ab5-461e-f3145e52c48a@kernel.dk>
Date:   Tue, 1 Oct 2019 08:09:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190930202055.1748710-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/30/19 2:20 PM, Arnd Bergmann wrote:
> All system calls use struct __kernel_timespec instead of the old struct
> timespec, but this one was just added with the old-style ABI. Change it
> now to enforce the use of __kernel_timespec, avoiding ABI confusion and
> the need for compat handlers on 32-bit architectures.
> 
> Any user space caller will have to use __kernel_timespec now, but this
> is unambiguous and works for any C library regardless of the time_t
> definition. A nicer way to specify the timeout would have been a less
> ambiguous 64-bit nanosecond value, but I suppose it's too late now to
> change that as this would impact both 32-bit and 64-bit users.

Thanks for catching that, Arnd. Applied.

-- 
Jens Axboe

