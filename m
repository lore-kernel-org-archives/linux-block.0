Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D874C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 09:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877C5610C9
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 09:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhJMJSW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 05:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhJMJSW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 05:18:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07768C061570;
        Wed, 13 Oct 2021 02:16:19 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k7so5876700wrd.13;
        Wed, 13 Oct 2021 02:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zyEmz/tB0Rrdz8IwvSoIaxMjG4aLpVCV8hROcWXqRMk=;
        b=F6rCYzxaQTTyTOj6ZsMzyD9QZkWGNPI8jg2TFOpxZ6Zyk8gyCFQrYq+u1Qr3hqLw10
         uMDZytBQ4Sw2JrreurmbF4HquFjWcx3Lc4g87eeZx22BkP8oKSMa1WgDvQvpQY1UeUMW
         VjQNnYxtIXj40FLdFlu3JaR23UQpMnsBzK6vYDQLkfbkrwOgHS2XvkJk5aS/1IIl/rEb
         JnKEemZlTnSrBwTLhIP+MhgdLUfxZfJf9HYLuYTZr51H5kEOclCd4Rk/URid+2Sbx6J5
         svC2cHhJ6pwfL9ngVL4kAR6a2BlCtjG27eBpoVIGOrhKYszPGKtF6M5P+R2jwMqLjlkY
         TkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zyEmz/tB0Rrdz8IwvSoIaxMjG4aLpVCV8hROcWXqRMk=;
        b=aDnFkmfj7ulVNYIpOebCvv9Y7Gdv1+P+CETOO0pGCfBG8uxfQOXvnVedhwKleF0WDV
         Sf6drq/ip63qpx9zZg5YKRSNlltT/4X/H60TwKaX6vdsVPpJZgl0cmq0FFxFmvRRG6kY
         Sa4LOKwtaBCpkWs9+iPnSWk+RhAvf2NYx6yRMe47jiEIlnIqLF2NmpCmnsHXbsJr4V5S
         sDX7j+ILdOKCTEcJ4EUGGJNR0pWoAEHENYO4FYJqYRCnzToEGlnS5uDz/bAPUfFoX2T/
         CeEZeAYmGr/Gls1owY4SRzlEcejX4OW1LBE10L1rfGoT0L1bpGR1yV3njEJ9KGRBPpVS
         twHg==
X-Gm-Message-State: AOAM532UYhg/Jx0ScWd00/bCmEocLsCRWnYnjGX7/HzeDz295ekcRSVF
        9Z/ea/sPSMYqNcBYVQouvuY=
X-Google-Smtp-Source: ABdhPJwGRaxSvIX5NpEHodd5tbp9peXVTaepz5YYcWXmrqI73fH1uiFPuaCmA/7KHvwLTV3vJqKC4Q==
X-Received: by 2002:a5d:47ae:: with SMTP id 14mr4043351wrb.120.1634116577652;
        Wed, 13 Oct 2021 02:16:17 -0700 (PDT)
Received: from [192.168.8.197] ([185.69.145.208])
        by smtp.gmail.com with ESMTPSA id z2sm11824327wrh.44.2021.10.13.02.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 02:16:17 -0700 (PDT)
Message-ID: <e52033e5-bff6-c2a3-9e23-ccfa505b064d@gmail.com>
Date:   Wed, 13 Oct 2021 10:15:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v2 0/3] on top of for-5.16/block
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>
References: <cover.1634115360.git.asml.silence@gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <cover.1634115360.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 09:57, Pavel Begunkov wrote:

Bodged subject, should've been block optimisation or so.

> ./io_uring -d32 -s32 -c32 -b512 -p1 /dev/nullb0
> ~3.3 MIOPS vs 3.5 MIOPS, so gives around extra ~4-5%.
> 
> The main part is caching struct block_device + some inlining.
> 
> v2: without applied patches, merge previous 6/6 into the second patch
>      get rid of helpers (Jens, Christoph)
>      kill bdev_inode and move inode into bdev (Christoph)
> 
> Pavel Begunkov (3):
>    block: cache bdev in struct file for raw bdev IO
>    block: don't hide inode from block_device users
>    blk-mq: optimise *end_request non-stat path
> 
>   block/bdev.c              | 44 ++++++++++-----------------------------
>   block/blk-mq.c            | 18 +++++++---------
>   block/fops.c              | 43 ++++++++++++++++----------------------
>   include/linux/blk_types.h |  1 +
>   include/linux/blkdev.h    |  8 +++++--
>   5 files changed, 44 insertions(+), 70 deletions(-)
> 

-- 
Pavel Begunkov
