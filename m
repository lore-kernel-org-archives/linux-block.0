Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10780C7EE23
	for <linux-block@archiver.kernel.org>; Wed, 31 May 2023 13:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjEaNfZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 May 2023 09:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbjEaNez (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2023 09:34:55 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C56188
        for <linux-block@vger.kernel.org>; Wed, 31 May 2023 06:34:51 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1b011cffe7fso35382745ad.1
        for <linux-block@vger.kernel.org>; Wed, 31 May 2023 06:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685540091; x=1688132091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9la2dqWlaDLXFId6v9AQxCwpi0Eo1V0BAfkI7Fm9zOw=;
        b=jdvZnMM0BQ/vXaAvat4CxRKxKb8xT06nJMhRlKpcdOwfcLylbsDqVXP1dykmOoHQI6
         b4D85+av4NuIYKqSqCikYRTO/mEQl3rniJHKrgAYT+o4/vgdnD3NAVNYX7FS9KtdP/U4
         rXeFpHTR+ceFRGRaf8sY10/05pXPuv3wUit3MbCn/BZCYAJwso1LfyTR2ATj0lMAHnZq
         hh259gosCbrm536gSkFErzJpGBiMdHFcYZugSLVMYnBnZNNLW76AFB3sqZkWVh1A8aEd
         DGV0dT3gEVfVmW/AjqmDikn7bwLJGR0GGlY/UF3yTjuC78V/CHvNV/l53Uj/CvaPeqcb
         13Fg==
X-Gm-Message-State: AC+VfDzjKyHZINeQos9QAjRB7vAg0zsd/kgURxMxtDH9y56q6cZx75LR
        qosf/5fPRBMELN/KgH95wwQ=
X-Google-Smtp-Source: ACHHUZ60MrK522nitIKNfFXLlINMWfhwBXH7Amv3fcaq3hZUSBPhGRPnq485Zu4echxOSgcAHRvdig==
X-Received: by 2002:a17:902:e884:b0:1b0:7c3c:31f9 with SMTP id w4-20020a170902e88400b001b07c3c31f9mr2522567plg.53.1685540090946;
        Wed, 31 May 2023 06:34:50 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id im16-20020a170902bb1000b001a95c7742bbsm1403720plb.9.2023.05.31.06.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 06:34:50 -0700 (PDT)
Message-ID: <7ad83f37-cf3d-952c-741c-a70fb0d363e2@acm.org>
Date:   Wed, 31 May 2023 06:34:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/7] blk-mq: use the I/O scheduler for writes from the
 flush state machine
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
References: <20230519044050.107790-1-hch@lst.de>
 <20230519044050.107790-5-hch@lst.de> <20230524055327.GA19543@lst.de>
 <d2e12e08-3a5f-2f5b-e3d1-2c1ea39d716b@acm.org>
 <20230530145516.GA11237@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230530145516.GA11237@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/30/23 07:55, Christoph Hellwig wrote:
> No, I mean block/001

Test block/001 also passes on my test setup. That setup is as follows:
* Kernel commit 0cac5b67c168 ("Merge branch 'for-6.5/block' into
   for-next").
* Multiple debugging options enabled in the kernel config (DEBUG_LIST,
   PROVE_LOCKING, KASAN, UBSAN, ...).

I ran this test twice: once with /dev/vdb as test device and once with 
/dev/ram0 as test device.

Bart.
