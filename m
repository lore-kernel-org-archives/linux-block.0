Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2551C4321E
	for <linux-block@archiver.kernel.org>; Sun,  4 Dec 2022 15:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiLDPzQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 4 Dec 2022 10:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiLDPzP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 4 Dec 2022 10:55:15 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EFC13D72
        for <linux-block@vger.kernel.org>; Sun,  4 Dec 2022 07:55:14 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id w37so8434928pga.5
        for <linux-block@vger.kernel.org>; Sun, 04 Dec 2022 07:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SZaaXSaZ3rhZbc/fbjMaKgGU3Pwlz35jgq+Lxq3L3fM=;
        b=0eGXUP6djpDlhjQrvirA+ZlWvtL/GKUavYyNWW34OQAAmGI4kqlYSTMAS2dTZ+3UQZ
         8LmPA2eVlgFXC3PD3sqWNwFtRmHvJVaZ8Kn+rVxwowxcqu3Lt/EysrkBJdNQSpR5LgGB
         4d3CsuuxxG+0/Qv/a3917E7zti4revTM+juUqwmAf84jzOIVuci4tV7VY0Xe/GsN4kTQ
         wxtocJzPbTgQN0Sgg0AyFh0rN5sojqwYHioRmc5e0EHdaXJMBvdPDmJ9luPwiyKI2OHt
         hJwwuniOSLmsA0zDtXVEbdZIz2zXzUyuR4YbgS+8JkAJHyLZIDLCW8CGYu5aUW2Z0Hes
         krNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZaaXSaZ3rhZbc/fbjMaKgGU3Pwlz35jgq+Lxq3L3fM=;
        b=aEvj/Tg7OrYRWc1N48yWAjoBteCBrztKVX+FQ3qT3zW3YUUq0nxFcBdAVVHA1mmcB/
         +9FNuD5sqV8DnoHDP/H4n9+CDLPyzIEKTDU/2Oflr+KbPHNSmxJ8oOLFnafkhQvoWKPn
         wmnIrkP8qf86Z/93KbknKYu3w4KPA4yMqA0JLmrkOEwmZCfNDsrskOzEUnuCXBlvVg2C
         p9mcSapJrUKsJRymYegHjZHjAqzuD8B/0mnKY2/bAql3iGCs/wBl2Vnm3MGrNSngD5dP
         nNBfjGzcn5L//D5jRISmNSZ/qBAOEuAz3qOK7p/2sXAntt/u0BMDqmJX1fIBaEsONV81
         AFWQ==
X-Gm-Message-State: ANoB5pmwIUUF4eQgk1kbt1fLN9W8WTTl1SyWFQWQVNuVXwhJz2PmMHcM
        sC7XJdBSu/4OxHQ4QILjNjyvvQ==
X-Google-Smtp-Source: AA0mqf64xFl/RjpCi/9yQ2rE6gxObGVVg/1hUkpUHNYS/Ef9MH32NIgEoDFZRO3AGOr21tcZ4FfTqA==
X-Received: by 2002:a63:195a:0:b0:477:c9d9:f8a0 with SMTP id 26-20020a63195a000000b00477c9d9f8a0mr45278528pgz.228.1670169313462;
        Sun, 04 Dec 2022 07:55:13 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id px13-20020a17090b270d00b00218fb3bec27sm7744840pjb.56.2022.12.04.07.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 07:55:12 -0800 (PST)
Message-ID: <4362a118-48fe-8d45-5b52-77b23f093ae2@kernel.dk>
Date:   Sun, 4 Dec 2022 08:55:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [GIT PULL] Floppy changes for 6.2
Content-Language: en-US
To:     efremov@linux.com
Cc:     linux-block@vger.kernel.org,
        Linux-kernel <linux-kernel@vger.kernel.org>
References: <805d7405-2e2f-ddda-8e17-97ac1934738c@linux.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <805d7405-2e2f-ddda-8e17-97ac1934738c@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/4/22 8:42 AM, Denis Efremov wrote:
> The following changes since commit 85d6ce58e493ac8b7122e2fbe3f41b94d6ebdc11:
> 
>   block: remove devnode callback from struct block_device_operations (2022-12-03 09:19:48 -0700)
> 
> are available in the Git repository at:
> 
>   https://github.com/evdenis/linux-floppy tags/floppy-for-6.2
> 
> for you to fetch changes up to f8ace2e304c5dd8a7328db9cd2b8a4b1b98d83ec:
> 
>   floppy: Fix memory leak in do_floppy_init() (2022-12-04 18:03:41 +0400)
> 
> ----------------------------------------------------------------
> Floppy patch for 6.2
> 
> The patch from Yuan Can fixes a memory leak in floppy init code.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> 
> ----------------------------------------------------------------
> Yuan Can (1):
>       floppy: Fix memory leak in do_floppy_init()
> 
>  drivers/block/floppy.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Pulled, thanks.

-- 
Jens Axboe


