Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B164C433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 02:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiKBCJy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 22:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKBCJy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 22:09:54 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36E21D32A
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 19:09:52 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 128so15039807pga.1
        for <linux-block@vger.kernel.org>; Tue, 01 Nov 2022 19:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/9nbqKAy6prDAS3oMmtklZfg/ZbEspQaEJ48FmeAmc=;
        b=TrwwCrLqC7JAM1Uu/+yafOAtWgX5dY7pPM2NvZ69AMrgl3UEFM/DscGiTUUHN3pc+L
         uS7v2QJimbqhm1WnG9dnmFDRtAK7Yte8g4pmcY2GKK2Ytn0tZg9J9Dfz0LlYaXEDDxsx
         iiTD4UyqQ9/VzWkjBXBux22f7w4atH83ns9iux6Su51579Sjj45hARf3lqY0yH2OoybV
         v0M5WTlBw12gNGR7yEzNR+v5pJXL2RhLDZb6KkB4LTw9dVwWz1JNVzxYWwMm3Og/CFZy
         yEUtvs6A3IVvM93m1EbIcurAyJwCjGIC2c1FgMU708u88XVXA0b3UxJKLzPm463agT6c
         ZJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/9nbqKAy6prDAS3oMmtklZfg/ZbEspQaEJ48FmeAmc=;
        b=N7T0VntqnKgq1ImMYzJmr4PSEXGS/OalXEYGERy0xOZZmEtFvrwAfxrNqoiQSWR0DM
         +7lDXP3+uwVk/GcRXdlEN87HNNXtgQ6/XYu1GiCUzysr+ggmbfKORvD6ObdQhY5Ml6Mz
         OyJdJ10GxIUHRus0GICHI35ZjOevJIVKL+106Nej+jyPw4Y8nI5DBLFlaVqsqpA6ws9s
         dS3Z/APF3CrfjgWht7IPUh9lFkYFmu6/X5GUfTF3hPKEC5ipT55kenRx1SFClWRSzTDK
         /WIv12ASMUOwlW7bhMEWK2s4Di8oMHH2vT8yYNR0JVouq2yZu17sBQDdHScyoQZsEqcC
         Tz3Q==
X-Gm-Message-State: ACrzQf2Ikm5NheJVFxuXyNtxwMteXuBY/iZaVR19ja9QVWEAAkpqa4Po
        /NGAlppXiigA9gbmkn97UScWhA==
X-Google-Smtp-Source: AMsMyM6nfZ1Xf117LD/8Qlkj1bOJKmYdrnP9WwitZHJYBeZMfYqBJCmperWW+vBpF2o56y/62TQwcQ==
X-Received: by 2002:a63:35c6:0:b0:470:d38:7c63 with SMTP id c189-20020a6335c6000000b004700d387c63mr17783pga.249.1667354992155;
        Tue, 01 Nov 2022 19:09:52 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902c40100b0016c9e5f291bsm7018876plk.111.2022.11.01.19.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 19:09:51 -0700 (PDT)
Message-ID: <7f7e59cb-e0b8-0db5-7c46-11aea963bcfa@kernel.dk>
Date:   Tue, 1 Nov 2022 20:09:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH -next v4 1/5] block, bfq: remove set but not used variable
 in __bfq_entity_update_weight_prio
To:     Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz,
        paolo.valente@linaro.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
References: <20221102022542.3621219-1-yukuai1@huaweicloud.com>
 <20221102022542.3621219-2-yukuai1@huaweicloud.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221102022542.3621219-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/1/22 8:25 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> After the patch "block, bfq: cleanup bfq_weights_tree add/remove apis"),
> the local variable 'bfqd' is not used anymore, thus remove it.

Please add a Fixes tag.

-- 
Jens Axboe


