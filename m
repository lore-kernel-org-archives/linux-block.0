Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FB4C43219
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 13:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiJTNWl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 09:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiJTNWc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 09:22:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5275196376
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 06:22:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so2145140wmb.3
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 06:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=AWvMFLF4ecYHHBBkOklrdfPCGPasYwAFJMxh/MX223EOXKtu/yI/oI8X864HSnOcXv
         X3Z4ZF+TRcbBaG4uWojy0IrpmRX4za22PNikbt1K1bzI2zckt11SvoO/B3xt7c3eAGv5
         vncIAlrP4WliyUazSnSLSDiClOdsXWik2eGp9NQ2ZmafDNKrs1ygIGFelwdkHASO+ycw
         cPCLyNu+EbtP0ju7d2ivymHkHLqcPSkE/5ijhKV/aAlBSfAw7ueAs2xe5AUo9/IGfl+Q
         XGjp43zyC/1TdBscgopxyNFSLDnMQGQh1bgdBrWH+V2bQK6deHdk464rJja/beLVufm/
         hwQQ==
X-Gm-Message-State: ACrzQf08jGRdaKYnBPqGfSFnM/egkLYCDMplUtl2FSWGvp/qWlgJPqgk
        7sr5EnqvcPXAoMGcslBIZsY=
X-Google-Smtp-Source: AMsMyM4BA/hLXI1lD4bBUcnFM3vOLks+kWhmvPK0kW1kM2Us3kUvwpQxyIIwYoyWd+WvsMXjy9PxXg==
X-Received: by 2002:a05:600c:4410:b0:3c6:f04b:daa2 with SMTP id u16-20020a05600c441000b003c6f04bdaa2mr9600494wmn.186.1666271820916;
        Thu, 20 Oct 2022 06:17:00 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u11-20020adff88b000000b0022e2eaa2bdcsm16207614wrp.98.2022.10.20.06.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:17:00 -0700 (PDT)
Message-ID: <048eb761-f423-5b0e-f900-a6b0a4819f64@grimberg.me>
Date:   Thu, 20 Oct 2022 16:16:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/8] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-3-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020105608.1581940-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
