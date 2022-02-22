Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E1DC433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 17:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbiBVR0q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 12:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiBVR0o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 12:26:44 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDF316EABD
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 09:26:18 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id u16so12738000pfg.12
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 09:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yDLlAFvK+T/73Yb8RG3JwCW99zMzcCE47Ha3YISA/WM=;
        b=sQzn11lhKdbc+BS2hXds+Hg7XcO5TKw7NEfuTf02Dm+mnB/MtaxmRAt0QilC+dboFi
         41/oi6nusHAwhKjrG+P3P42PKCarV8f4ENhro/+G7NvVdWP/ahHDBGxEFwYaKIEshYj9
         /f7zW0+F+3FAAQFbxtJxwvcuMzEQZfAMQfRWGpA6iwBMMz4/e6+2kboowIV1wEtMNVBM
         Esq9XfFIz8ZXwmA9nvPiVrNnzixs2+TKmakqyAyEshMUwPoXisqzH3il6oKmdNSYxrAS
         EGa3tBHWYPpzUeOlGihzKR8bJZVM/x/Y/Qt5/y+2LQ+8qrBsmmSP4Cnbem1iQvrkvb5e
         YhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yDLlAFvK+T/73Yb8RG3JwCW99zMzcCE47Ha3YISA/WM=;
        b=VQ99xdztMjSgRytidyJGgTIDo0f9nvFUKDIl/Y9IBT1Dza7dE49Eo2SmGssxUX+MEi
         LFOX7GKXbcnsyjWjcSG6ArwrL9g7YYIm/d9gjmqXau93syr3eKCvmkirWS5P7+Ni0EqD
         LIl5naVpYaTnsLQlNm3JCrWPwnDT1BYBtCXvKHGghGYR69dH8p0YavsYHp4JW3/+qExf
         1HM3KzkXw32u0vzqz3KEfg9AECDBcBhgXwaewf2lhCcZn9a6QQ59kgUZxoZDS+wdWYxY
         8NAKkgg9YG4ug5X0CQUcWFTvEacqLb4g7xyphrurcx1NFhhMm+GoMhDl/Wc8dZWfVml+
         cR5Q==
X-Gm-Message-State: AOAM533G07klzW4oJt+4hEWrfakReJLAGk96u59Ygdrj7rZ7DJJjai2N
        MW2r8S3kEehYzCKgtDbT3iVOWg==
X-Google-Smtp-Source: ABdhPJw/t5pc/d+LYCVOrTwPf7iKCyOLog7MvyjF1anbmzVS6DNLfKo/e6d6TxoLSSpgOgkLp9HjPQ==
X-Received: by 2002:a63:27c7:0:b0:343:984e:3428 with SMTP id n190-20020a6327c7000000b00343984e3428mr20790817pgn.528.1645550777909;
        Tue, 22 Feb 2022 09:26:17 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id my18sm69139pjb.57.2022.02.22.09.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 09:26:17 -0800 (PST)
Message-ID: <e8c9e5e2-05d3-6051-92c6-b18f46d42494@kernel.dk>
Date:   Tue, 22 Feb 2022 10:26:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [GIT PULL] nvme fixes for Linux 5.17
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YgTB0csAbKyI5WvN@infradead.org>
 <d165d411-4499-12aa-fb59-05ff1e2faaa2@kernel.dk>
 <YhUbhsy+C7Q16ihM@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YhUbhsy+C7Q16ihM@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/22 10:21 AM, Christoph Hellwig wrote:
> On Thu, Feb 10, 2022 at 06:57:10AM -0700, Jens Axboe wrote:
>> On 2/10/22 12:42 AM, Christoph Hellwig wrote:
>>> The following changes since commit b13e0c71856817fca67159b11abac350e41289f5:
>>>
>>>   block: bio-integrity: Advance seed correctly for larger interval sizes (2022-02-03 21:09:24 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://git.infradead.org/nvme.git tags/nvme-5.17-2022-02-10
>>
>> Pulled, thanks.
> 
> Looks like it isn't in the block-5.17 branch any more.  Should I
> just resend it for this week?

Hmm?

https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.17&id=93e2c52d71a6067d08ee927e2682e9781cb911ef

It also went upstream last week.


-- 
Jens Axboe

