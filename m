Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10F4C001DC
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 14:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbjGZO66 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbjGZO6w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 10:58:52 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCA32721
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 07:58:49 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1bbc87ded50so8256235ad.1
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 07:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690383529; x=1690988329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBsBIs4ErBKyQ10ofKZE6F/qGeF2POPedMK/RbEOJAU=;
        b=ShAraUr1gMEfjht97nl8MZtycIz74LeiJ/2IewqPZEOTID8PMT4myv0X5FaLB2Uwg1
         yPmQeY0KwIb1wWOd5pqitBT6+2gtc2I30S3rXRWLD/wLUZQs4jzu1fcIyzm2ABT5lQR1
         qJMQqxZwjeY1/34HGJ8pG+iEPq55fPrGNUNb1IXmM3I+lhQfrG4LAnKHrsbo9GLpyAmL
         TxyLoEBQhqxqQvXT/MOYiuJ3V22LYUatDQAqknzm9qHdGI6JEo2MmIRS5CSpntv7cNPc
         Aw3MgCK6zzeB/YJweUVu8syXnZcmiJVBIKXs5mTsB8HP+p8Ds6pH48Um8JU6pgNcf2Q5
         7XJw==
X-Gm-Message-State: ABy/qLbySdf8+YsxLFqNwAz6NC1JI9+h8wpKBuV623ainVp1k48zDBXf
        uPCvKFi7Zhhak28MkhWas9M=
X-Google-Smtp-Source: APBJJlGVsnaRiDTILS4wN+WzDUFKxN+UgwWTK2eJu2yQlElbqahGc/Cwi0LJ98JL9nihll9EbMe0MQ==
X-Received: by 2002:a17:903:2343:b0:1bb:2d0b:1a19 with SMTP id c3-20020a170903234300b001bb2d0b1a19mr2141925plh.62.1690383528764;
        Wed, 26 Jul 2023 07:58:48 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:7ecb:b0e6:dc38:b05f? ([2620:15c:211:201:7ecb:b0e6:dc38:b05f])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902bd8600b001a1b66af22fsm13266951pls.62.2023.07.26.07.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 07:58:48 -0700 (PDT)
Message-ID: <6b83afce-7478-986e-5ad8-ed7e82a87bad@acm.org>
Date:   Wed, 26 Jul 2023 07:58:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/6] block: Introduce the flag REQ_NO_WRITE_LOCK
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20230726005742.303865-1-bvanassche@acm.org>
 <20230726005742.303865-2-bvanassche@acm.org>
 <c853e8bb-5873-c63d-22ad-2292e39e9184@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c853e8bb-5873-c63d-22ad-2292e39e9184@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/23 01:37, Damien Le Moal wrote:
> REQ_NO_WRITE_LOCK indicates that a write request does
> not need zone write locking when the underlying device signaled that it can
> preserve command ordering. So we also need a queue flag for that...

My apologies: I accidentally left out the patch "block: Introduce the 
flag QUEUE_FLAG_NO_ZONE_WRITE_LOCK" from this series. I will repost this 
series.

Bart.

