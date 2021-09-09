Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C310EC433F5
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 20:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A68611AF
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 20:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345212AbhIIUnW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 16:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344948AbhIIUnV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Sep 2021 16:43:21 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21379C061756
        for <linux-block@vger.kernel.org>; Thu,  9 Sep 2021 13:42:12 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z1so4059076ioh.7
        for <linux-block@vger.kernel.org>; Thu, 09 Sep 2021 13:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VMwlM4GyMZLXj8Fib8keX4XRi0UDBn+ujtEneqseAMU=;
        b=jDwT6b38OSIO6dlAh50hbay4fjrqkM8GLiVdhZTZXBBlD7OdbOkbGoLZo0uUvA463U
         7N1kBmkmWqrazTDs9egtgdslGoFE+huJQCrJ/MIe9VQfm1jWhLplnQ8xzUXbvoB8RKWm
         doKi9I2kCw0tCx+7g2+JZitd5Akx+ZWofu8RJMti8mc0H+v/d6AXK00/TIwSPJKvvtHg
         J8nTf7SG/xOvND0trDnMzMvgWsVnFuPpfnbrXXDDwYrQHr6S+cRPxdwIO3L9d93Y8N5q
         okBjG3D/4ZUiPNCO6cQRG7g2GdxEWJ36Yzpdy5N7d4BT6ipCrrO5pIywyf4A/L/KgOz2
         nW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VMwlM4GyMZLXj8Fib8keX4XRi0UDBn+ujtEneqseAMU=;
        b=rRPC9lFVvOJ8PMBZtSxDXS7CINVjrdrJPwR6atL84Fo/KMOoUHDlKwHt6j5o5gpsdI
         M5oaZY6zTbG/pA3CIX/n+yFtxK53byd87DQsfug0cXjvZfsdsGyWjQMrkBa20gFgoLwQ
         moD6YCcrgVVUrF9/4fLQ2fCBkiht8qc400+DYdnwQtq5ObL5gL0vhvZY8TV4QXxlKjdX
         W9u+jvYkK0a+JAbxHDxl0T7q07LUFNUBgUNQNhjZh3Lw5bRt2Ct7ld9/m2k8Yxw7gicW
         dkH2wkQKaK6DmcHLvo+WA8Nc6BxpCU1rAj4Ho9QZTFMqfKVH7OS3C8v2dSFgpsYZFbuZ
         mJaw==
X-Gm-Message-State: AOAM531UCmmroQmzfFuV7325VpHedWJbH7FVmy8rbfclT+rxvvq150vU
        8M5EUKa7MfIGPPWhAadX239/0g==
X-Google-Smtp-Source: ABdhPJx5/GznvKhLT6rvGZ+4I8MGwh86gDp/0GuBtqVrWW7mCTLsptR8tMOZ/TBavfaj2qmNZbCtgg==
X-Received: by 2002:a05:6638:d11:: with SMTP id q17mr1496935jaj.63.1631220131553;
        Thu, 09 Sep 2021 13:42:11 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f3sm1339667ilu.85.2021.09.09.13.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 13:42:11 -0700 (PDT)
Subject: Re: [PATCH] scsi: bsg: Fix device unregistration
From:   Jens Axboe <axboe@kernel.dk>
To:     Zenghui Yu <yuzenghui@huawei.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     fujita.tomonori@lab.ntt.co.jp, martin.petersen@oracle.com,
        hch@lst.de, gregkh@linuxfoundation.org, wanghaibin.wang@huawei.com
References: <20210909034608.1435-1-yuzenghui@huawei.com>
 <78c3c08b-ebba-8d46-7eae-f82d0b1c50fe@kernel.dk>
Message-ID: <ac61cf8b-061e-dd96-1730-edec5a886c62@kernel.dk>
Date:   Thu, 9 Sep 2021 14:42:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <78c3c08b-ebba-8d46-7eae-f82d0b1c50fe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/9/21 2:40 PM, Jens Axboe wrote:
> On 9/8/21 9:46 PM, Zenghui Yu wrote:
>> We use device_initialize() to take refcount for the device but forget to
>> put_device() on device teardown, which ends up leaking private data of the
>> driver core, dev_name(), etc. This is reported by kmemleak at boot time if
>> we compile kernel with DEBUG_TEST_DRIVER_REMOVE.
>>
>> Note that adding the missing put_device() is _not_ sufficient to fix device
>> unregistration. As we don't provide the .release() method for device, which
>> turned out to be typically wrong and will be complained loudly by the
>> driver core.
>>
>> Fix both of them.
> 
> Applied, thanks.

Actually, let's move this through the SCSI tree, as the offending patch
went that way (and my branches are behind that point).

-- 
Jens Axboe

