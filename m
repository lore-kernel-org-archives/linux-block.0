Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A017FC433FE
	for <linux-block@archiver.kernel.org>; Mon, 28 Nov 2022 15:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiK1PgK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Nov 2022 10:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiK1PgJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2022 10:36:09 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F00101C1
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 07:36:08 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id j12so10499020plj.5
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 07:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rj827wEsH1NqoBDuLsjEbAn8bHdiGqsXAWQLi2uAuwY=;
        b=MAW/x387LobbC2bDjGbN3EY1ZQhrv4+3vQyosY063PPWJZSZXE2g8O5QbYXyGQsESW
         Wx47lu1uyNGDc3zVhz4j0TkxYHupC47ThIC9cuTujwIU1Qf6JsVko41YwNzXAfJtPwjB
         KnUJ+b/fxmd0V+7FjlsKCc0XmUU2YjZJWiFdH8zxn4pNF1JlI24dsIMT9su/cjRQGtsS
         hEF8CZk2fE9YL6I3udwZBm5y0KlR+wXC01m/lq/a74QA86Hz2Pu9Ggrw/2FhxVoftb5p
         UFSaMm3ODaVa0ks23ZD17khkYMjlmcPQ7Kg4YHZZOaG57oUp10cmYh/L1j/tYpUZqAx8
         VHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rj827wEsH1NqoBDuLsjEbAn8bHdiGqsXAWQLi2uAuwY=;
        b=RoXf2YkShH7HIbjEW/v6HZTxudK19iryDoLIAWKy8ys558mw+cDsyz5so17IZSWwRi
         YeEGGIlQITO9wFA6jFA/IxxsBulai0Z28uyAejdIeDALjcIp3sfK0kvGfncP78gDQD1R
         lmbMItRLpYsKHklGN1GAraRC8QEsK1KYTHlFlUHW4GKUNyLB1KvnvxHPGhQS3GhpTaGg
         k4+Mijp0X+ziyBd/4efiJWF+NCROs8J2eFRSlL9vPGs7m98OCz9RtWOh/73RrL52aMmE
         eAAKZfxid92zRNLOxfAkRIXiSxdWJPFedUYXuA/5NBuHab0S9DejozD9/dyohOph52p0
         +ZUA==
X-Gm-Message-State: ANoB5pnOWfMk8RuPVowVDoYvLvLZ6PV7rEf3DrLH/iW27Gbboq/x9IXF
        IDSLMu1tfnT0oMmB5t1HHjhTUw==
X-Google-Smtp-Source: AA0mqf7DFGiofzbG4Kxwh04DCFhU3v4OX9kxYCYXgE53StRXn/UH5vfd/9HG8/GOqxfcqQ+MDsFozA==
X-Received: by 2002:a17:90b:804:b0:20a:7ec2:c96d with SMTP id bk4-20020a17090b080400b0020a7ec2c96dmr53704681pjb.178.1669649768381;
        Mon, 28 Nov 2022 07:36:08 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x8-20020aa79568000000b005633a06ad67sm8208214pfq.64.2022.11.28.07.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 07:36:07 -0800 (PST)
Message-ID: <b1157a4f-fa4d-76d0-69de-428f3940efbd@kernel.dk>
Date:   Mon, 28 Nov 2022 08:36:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/2] Minor fixes
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-block@vger.kernel.org
References: <20221126025550.967914-1-damien.lemoal@opensource.wdc.com>
 <166964494783.5680.1897835623013824110.b4-ty@kernel.dk>
 <Y4TT1S4AOAm+wemn@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y4TT1S4AOAm+wemn@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/22 8:29 AM, Christoph Hellwig wrote:
> On Mon, Nov 28, 2022 at 07:15:47AM -0700, Jens Axboe wrote:
>> [2/2] block: fops: Do not set REQ_SYNC for async IOs
>>       commit: 26a7bc153a19f3349fd8c2e262728b2eae6bfd6f
> 
> Urgg.  I don't think this is right.  And even if it was, block device
> I/O is not out of line with the other direct I/O implementations.

I'll drop it for now.

-- 
Jens Axboe


