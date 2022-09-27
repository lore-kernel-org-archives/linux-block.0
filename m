Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194ECC6FA82
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 16:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbiI0QGc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 12:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiI0QGE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 12:06:04 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D376F1C4805
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 09:04:24 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id v128so8086003ioe.12
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 09:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=P/h+au/RV6zS7JwkmAAMAHLpqcGIXOhCfVVkHyP9QX4=;
        b=vlj8/t/Z6Rn+fYhK+e7IAajf3u+Y1UPiaBw5sbLTWg9TWAC8rxrCdY0erdAM/BgGgC
         M4rqGKWT/1C6EG6veUzqoci8lXvJrh6hsTGUDvBBVAbiryTtSPOuYF+g35GF0ligvbHm
         a5GVGBzXA+UnZ6ShmnchGXGK7mY4YC9XHD9UtK5SmUieOOscpPKMEzd67h9Ym426+GOe
         ih5yE60Wc4BJeZ6Hb1q1mqAfOokbStrEul5V4SNJ+QJDLGmI2NZjwE9ggKZgbx8rklF5
         XyEoyzfNX5O2uXfF2u9tVJAzE8b8+dXXP4wMn15jW6KhIi8TORno+E80wFOS4p0X1MPl
         ufbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=P/h+au/RV6zS7JwkmAAMAHLpqcGIXOhCfVVkHyP9QX4=;
        b=Fd/4QJ3vnR3yV1Tq+w5MKvz9ggsj2xTN+ijDxwUHZLni6JZLkSkLXNZ0pzDXFKXthU
         bSwAqX9NAKilaywZfSCQXOwdUTUbmAIn0xLI41e8YL4ZyAk9goG4dB6NbBa23IYfzxXE
         VzqY/RW+Rxfs/cw9ZZKeFOHDC7yRQUSX7FXoeaVNu6JzciaAV8kbZMgAfG8ng/CbzeF1
         roye3BjPIjG67j+hou12RAoUzXwuNnN5zllhYRlsh68KipTIR0aYtwESy3IBUhNxRAOQ
         zS39GBFX+ffr53+u6dSGLzBEpSSOxKX2vIOEPA3RAsqxm93iEwGKmuZfdEmePKuzDU+r
         OZqQ==
X-Gm-Message-State: ACrzQf0WmgqL8mQsn9V9EMjqK4Bnc200eSygxpMjN0lBizS9XAgjlXNR
        dIXj7qCJuzT7kT6TpXJ7R71qAw==
X-Google-Smtp-Source: AMsMyM6TYXYvrC+ZWRCL07SIwwVzM0eh4zalKbpzZPTdKnd6IuBelCePyMxC8W1qInsxpvmHKVYCdw==
X-Received: by 2002:a05:6638:1686:b0:35a:2566:6786 with SMTP id f6-20020a056638168600b0035a25666786mr14793806jat.180.1664294661842;
        Tue, 27 Sep 2022 09:04:21 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m10-20020a923f0a000000b002e97becb248sm750307ila.29.2022.09.27.09.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 09:04:21 -0700 (PDT)
Message-ID: <fa80eef0-42a4-6ffc-cced-18ecbe5b1f5a@kernel.dk>
Date:   Tue, 27 Sep 2022 10:04:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] block: modify blk_mq_plug() to allow only reads for
 zoned block devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        gost.dev@samsung.com
References: <20220925185348.120964-1-p.raghav@samsung.com>
 <CGME20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef@eucas1p1.samsung.com>
 <20220925185348.120964-2-p.raghav@samsung.com>
 <YzG5RgmWSsH6rX08@infradead.org>
 <d5975b62-f2e9-dcde-e332-a73cca1f7fbf@kernel.dk>
 <YzG6fZdz6XBDbrVB@infradead.org>
 <2ee6a897-87e7-0592-2482-9928a9a63ff6@kernel.dk>
 <a943acf8-f367-a1ba-0d57-2948a3ade6f4@samsung.com>
 <350366c3-1014-ac32-149f-689134631d73@kernel.dk>
 <6273f2c1-7889-1931-aec6-e567aa4d2d96@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6273f2c1-7889-1931-aec6-e567aa4d2d96@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/27/22 9:20 AM, Pankaj Raghav wrote:
>>> I guess the second patch should be enough to apply plugging when
>>> applicable for uring_cmd based nvme passthrough requests.
>>
>> Do we even need the 2nd patch? If we're just doing passthrough for the
>> blk_execute_nowait() API, then the condition should never trigger? 
> 
> I think this was the question I raised in your first version of the series.
> 
> If we do a NVMe write using the passthrough interface, then we will be
> using REQ_OP_DRV_OUT op, which is:
> 
> REQ_OP_DRV_OUT		= (__force blk_opf_t)35, // write bit is set
> 
> The condition in blk_mq_plug() will trigger as we only check if it is a
> _write_ (op & (__force blk_opf_t)1) to the device. Am I missing something?

Ah yes, good point. We used to have this notion of 'fs' request, don't
think we do anymore. Because it really should just be:

if (zoned && (op & REQ_OP_WRITE) && fs_request)
         return NULL;

for that condition imho. I guess we could make it:

if (zoned && (op & REQ_OP_WRITE) && !(op & REQ_OP_DRV_OUT))
         return NULL;

-- 
Jens Axboe
