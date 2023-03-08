Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41B4C678D5
	for <linux-block@archiver.kernel.org>; Wed,  8 Mar 2023 14:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjCHOfn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Mar 2023 09:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjCHOfm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Mar 2023 09:35:42 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58ABB4221
        for <linux-block@vger.kernel.org>; Wed,  8 Mar 2023 06:35:38 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id y10so10350250pfi.8
        for <linux-block@vger.kernel.org>; Wed, 08 Mar 2023 06:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678286138;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQD4R0p59xc0wlS4lzBW2X31cx9x5bJ2LDM5iLuHKiA=;
        b=7WgpL6aComZ0lV2uFwlevdbQhP1FyvBD6EtPXcwxQKnfNjh/d5g7kzSNlRHjrQuTTz
         xcrwQ3HFU7cnUn6en7Rsh2q3ir5yKeaAIUrM99CBQkttYsTMBDltQ18ZdRqLSzvcLh9I
         YVr7SI5sFwD4K3R3FsbDLCX7lQrmLEMnpyO/83k2s+/LLB/o7RYVJrQzNzGrwZ0mGNH8
         raiC5mki1DIF+KSuMbeq6B8owL4TTvsB5GHVyECUZ+mlhtBCKAfmnqf5GihT2iwEAS4l
         2WhVuHjk/k4tx8742r90r027SbH2D2qwN7l8JNezMQQz7kWHrFY4bFrXNZm7KKIfpsjJ
         MBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678286138;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQD4R0p59xc0wlS4lzBW2X31cx9x5bJ2LDM5iLuHKiA=;
        b=2rSxZh8JcEndMc4xvaNrtSXyrv/Xt5U/Z9zKIdnaCNwnZepw/kYBI/LNbzpYPWQpEo
         LIc2//fJukaN5CsnYFILnrLclMXbQdWefQSrE3ZxaceOl0yk62i8Tg3F7b6KtCe00Xwg
         ka12j11OIFcffAKH5l4pLqfRCRwgwuKMHPZk3SYEx8qrAzQjMEVUnu6SntQOnjxLwBvv
         Ex591/3QoxD+mbe88dr1LcdSjOQvAaYQZKepsP+TTdUF2RMKnQ0ZTMnSuJegJA674sF+
         vZP3lnrsuKrRL67MTiGWcVU+83wkyzmLj1VyeKJW/mJrkb8ZsYx3hjTYx4zgWSk4jTNl
         x+vQ==
X-Gm-Message-State: AO0yUKVEz4vMosNrd5QeOp/anQUep4dlTKcs9m8JlzzPj/Da/V0Citc3
        ISVmsiJcviFdOyHhyPRIzEXgWg==
X-Google-Smtp-Source: AK7set+Dh42CNU1V5M8U4Rkrf+80aIUEbRP0v3h3CsqB6uPmUh1HyBeoBgw1JFg1lmODheJc2XnKKw==
X-Received: by 2002:aa7:8751:0:b0:5dc:6dec:da46 with SMTP id g17-20020aa78751000000b005dc6decda46mr15988194pfo.1.1678286138348;
        Wed, 08 Mar 2023 06:35:38 -0800 (PST)
Received: from [127.0.0.1] ([50.233.106.125])
        by smtp.gmail.com with ESMTPSA id h22-20020aa786d6000000b005e4c3e2022fsm9452574pfo.72.2023.03.08.06.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 06:35:37 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     jack@suse.cz, shinichiro.kawasaki@wdc.com,
        paolo.valente@linaro.org, glusvardi@posteo.net,
        damien.lemoal@opensource.wdc.com, felicigb@gmail.com,
        inbox@emilianomaccaferri.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230308023208.379465-1-yukuai1@huaweicloud.com>
References: <4e6e1606-1d9e-9903-8a44-ccac58a1fe06@kernel.dk>
 <20230308023208.379465-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] block, bfq: fix uaf for 'stable_merge_bfqq'
Message-Id: <167828613700.180504.7849236814026719917.b4-ty@kernel.dk>
Date:   Wed, 08 Mar 2023 07:35:37 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ebd05
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 08 Mar 2023 10:32:08 +0800, Yu Kuai wrote:
> Before commit fd571df0ac5b ("block, bfq: turn bfqq_data into an array
> in bfq_io_cq"), process reference is read before bfq_put_stable_ref(),
> and it's safe if bfq_put_stable_ref() put the last reference, because
> process reference will be 0 and 'stable_merge_bfqq' won't be accessed
> in this case. However, the commit changed the order and  will cause
> uaf for 'stable_merge_bfqq'.
> 
> [...]

Applied, thanks!

[1/1] block, bfq: fix uaf for 'stable_merge_bfqq'
      commit: e2f2a39452c43b64ea3191642a2661cb8d03827a

Best regards,
-- 
Jens Axboe



