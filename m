Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43040C76195
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 07:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCVHgb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 03:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjCVHgV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 03:36:21 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372CF5CEC2
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 00:36:14 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id r29so15962333wra.13
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 00:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679470572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aNoAYdGW52uAeLKeNmV0+1VSAmdx3xhtCtNvBXqRnwc=;
        b=g3gpQPN/cCR9761vWRTdryvxLaCTwyMjpaaYeJrwIBiAZsu66FuQL/lqRYzWDJW3VO
         AEY1lBiblxRtJReygkKjUvCleFUsuOfzb2ctHU6unB3IAAZWllXChmQZSq5KdENvm+j6
         jSRlqDpXtgckyOtARl5RJ9TC1n9o0ywzDnE3AiN96+New2VkCnhRYqItp5MAabRVbqSI
         gzwFjuUuEZo0icCe6GLUbkDChLn9xHaib7hNlwfFVcH5pjNmNB7+EPEADCbY9kKEvEsZ
         Wc+1mAxnYfqbrkRi7k8Q6lX3+K4eBkGh/yuv0XAfzQmuxcRg1CFOeDVjO/cYuy/ODf8L
         n0ag==
X-Gm-Message-State: AO0yUKV3VUP4s1b6G470qa9GEPUR7kuivEWvHlvY+6phgsxnNl/JEzpX
        GqnQ0NGPrKjuQKqTsiMXHno=
X-Google-Smtp-Source: AK7set9gxw/ptRZnz8Ssjjucs49QkDJwhPo1qRc3OQJBSaGukpZM9Ntc6xaM0SN8a5Cjrqsbtyj6rw==
X-Received: by 2002:a5d:50c4:0:b0:2c7:940c:26f8 with SMTP id f4-20020a5d50c4000000b002c7940c26f8mr3241888wrt.5.1679470572718;
        Wed, 22 Mar 2023 00:36:12 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r10-20020adfce8a000000b002cefcac0c62sm13275917wrn.9.2023.03.22.00.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 00:36:12 -0700 (PDT)
Message-ID: <423e7e1b-81f0-a4de-491d-4be189004bc7@grimberg.me>
Date:   Wed, 22 Mar 2023 09:36:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] blk-mq: directly poll requests
Content-Language: en-US
To:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, linux-nvme@lists.infradead.org, hch@lst.de
Cc:     Keith Busch <kbusch@kernel.org>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Daniel Wagner <dwagner@suse.de>
References: <20230322002350.4038048-1-kbusch@meta.com>
 <20230322002350.4038048-4-kbusch@meta.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230322002350.4038048-4-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Nice.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
