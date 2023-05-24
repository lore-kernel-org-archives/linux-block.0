Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7177BC77B7A
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 18:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjEXSHp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 14:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjEXSHo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 14:07:44 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62B798
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 11:07:43 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-64d30ab1f89so947452b3a.3
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 11:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684951663; x=1687543663;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMnVkfy9AQd2wHeS1FAg33AK4xE/0SBY77R8xvaoZKY=;
        b=bqPGHRfKoN+HGnbvnX1UVKKY0tFVdja/RfCHM2O2K43gTaHuY+0PrxULz3ARl2P4+7
         W7d6pqHszslORQgtBDbfSSDi/YsMFHsqmPmCMG7iQLuHv6no8Ua2t3eNOCEybUCe5mVu
         ZlvWjI0cI7DWSdREfEV66GOiprWy9XZnzehAkh47Wo+fk5jCLJ11AhlgjDal9QpwfDPC
         O2CjDncJ73b3Ser2ZpftOcrYR8gBG5S9TNsNecSTBDjAr83BT8sepjvrIaI1pCNpnFIY
         5wnJoygYESCZzOP/7WEHbAMujHnALjUXb4xKquV09lIiexfvgeWL1cQxVvNF/5vsWU5t
         mZ5g==
X-Gm-Message-State: AC+VfDw5Zx6qlHdXrh8rcI6PIQ47U/6mtliCC8i5eEKhbfw7ne8g2ndP
        k5rGTYGhC9izP7s4XKIZW7UDmXWZUGs=
X-Google-Smtp-Source: ACHHUZ6CCj8RDEei7u6hVyQ67HTXaibcLHNMjpgaerRbSKiNdRXcj3r6/Xh/5/VdcW4Jav2rMmPpNg==
X-Received: by 2002:a05:6a00:2daa:b0:64b:20cd:6d52 with SMTP id fb42-20020a056a002daa00b0064b20cd6d52mr4676732pfb.14.1684951663073;
        Wed, 24 May 2023 11:07:43 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id v11-20020aa7808b000000b006466d70a30esm7958144pff.91.2023.05.24.11.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 11:07:42 -0700 (PDT)
Message-ID: <f7a7595f-6fd6-5fdf-4c64-b4fff367239c@acm.org>
Date:   Wed, 24 May 2023 11:07:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/7] blk-mq: use the I/O scheduler for writes from the
 flush state machine
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20230519044050.107790-1-hch@lst.de>
 <20230519044050.107790-5-hch@lst.de> <20230524055327.GA19543@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230524055327.GA19543@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/23/23 22:53, Christoph Hellwig wrote:
> I turns out this causes some kind of hang I haven't been able to
> debug yet in blktests' hotplug test.   Can you drop this and the
> subsequent patches for now?

Hi Christoph,

I haven't seen this hang in my tests. If you can tell me how to run 
blktests I can help with root-causing this issue. This is how I run 
blktests:

modprobe brd
echo "TEST_DEVS=(/dev/ram0)" > config
export use_siw=1
./check -q

Thanks,

Bart.


