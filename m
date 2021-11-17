Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E063C433EF
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 15:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E27860EE4
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 15:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhKQQBg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 11:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhKQQBg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 11:01:36 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C50C061570
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 07:58:37 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id a15so224388ilj.8
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 07:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wTA1ZkRpxf4CSm+JnHBA2saxjcW6mD7x/S65ivDUxGA=;
        b=sBbfs7dMA4vSgpPZnHtaaD9Kk53aFCZknJTNAXlwT+/FMthrGz3kmYTLINYy+JLHQ+
         lcDHPTizmfaIFHywsGm6b92ryhUsSPZaPGB5cyC7eHdtFC3JSRmkB/9xS6vNmSuLkdvV
         Xqjprwu2MmoJv4n+5whTAKmmyZ5Ki6Jco1YsxF05JVhqlSKhGubVd9X31Hn0Y3U3hgTu
         0OIeHEsvFKDwYIYJsjU3lAhxMuyeAlvjYCgyu5vOCMVlZN8N1T/aDyb83XJd2fEfS3yD
         1XQqRDMutA1EFKJWIpfEXBzuiozLvXZzuExrpX6XXaLYlzXzQtBkTWzkNFfgHwbnDh8o
         EmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wTA1ZkRpxf4CSm+JnHBA2saxjcW6mD7x/S65ivDUxGA=;
        b=mPUkX5AO8RWbeXAr98Iwoq364IEvSH+W7Fj8qG7wbUUC+yZfbKni/p//Yeg22vpOOI
         dyLhEXwjH4s+3gXb7NWg7DMJ9CkzwfRZPkHdrd1Pdba5lxz3fANWHrYZFgPrBuOcr2HB
         kFkkG/WsD79qC6YbjclzFDnrwTS58WUOdgZnDtbqo2fxE7nQRv7CffqmBcLX012bv9ec
         k/Knj/FooYBB/gFXCz9mvGOHwFu8O+PO1LFjABzDrShW3gjzqSBvwrR0xe9sLpR1fSL2
         NuKNqfaLUo4mVy0ra9jl524xcOO4v+xJ1XBk6SDuyBigrcWW+AxLYTO1CknD2EwK3bay
         nZeQ==
X-Gm-Message-State: AOAM531GLzhRT/MwVHKFbUI1fiv/NPxw5zGTS9TlbCSkc5rCwKx4Y41w
        y2+Eq3YJU1x/MFSpJzJNzb4SEA==
X-Google-Smtp-Source: ABdhPJxalLmanKSCAq9ReDqiBN0pEZL4NAx3KWXg5JnQU5yNco474SWjuUg55oCdWLELUoWiIroEWg==
X-Received: by 2002:a92:c245:: with SMTP id k5mr10843070ilo.280.1637164717327;
        Wed, 17 Nov 2021 07:58:37 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c22sm103287ioz.15.2021.11.17.07.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 07:58:37 -0800 (PST)
Subject: Re: [regression] nvme pci sysfs remove operation hang during fio test
 observed on 5.16.0-rc1
To:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs97spcWGFjz4JPzaRuzHnRGZkKP6HWMSPkbKLS9EmWMJA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9095c05e-659f-dd4c-95f9-617026216550@kernel.dk>
Date:   Wed, 17 Nov 2021 08:58:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHj4cs97spcWGFjz4JPzaRuzHnRGZkKP6HWMSPkbKLS9EmWMJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/17/21 8:57 AM, Yi Zhang wrote:
> Hello
> 
> I found this regression issue on 5.16.0-rc1, pls check it and let me
> know if you need any test/debug info for it, thanks.

Pull in block-5.16 and it should be fixed.

-- 
Jens Axboe

