Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9431BC4321E
	for <linux-block@archiver.kernel.org>; Thu,  1 Dec 2022 01:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiLABrL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Nov 2022 20:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiLABrJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 20:47:09 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA445A6D7
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 17:47:06 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso3144445pjb.1
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 17:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wG1FRF6NvvTrQgh7hkGSM1RofK5aGr38w3ooW7oI78w=;
        b=nue/1SmJ1LCPfvm3ohnTASWGXwKcSs3WqqLHKlqlyaFhuQ1+BPaoBv38LB/i/Mm6x+
         kgdpsRx520nsbxizSIgZdsSF94bQdGEG7rKZ+nzgfedNWWYuY8btrChtXNxbgwj6G1EU
         EP9dR0OW85GOBoxGKYXThtht9b/kVgQJA760EHWDfN+2xoRaQ9lzmgVZ9AAdDbqqenqj
         WcMNXZXx21mAm5js47qVwwZr2OU2QaWTojn12g85PxwmurYyyezYF3ItaVhTTRtMK2hT
         kFtHStmx1pC/xPqSYSQN6fQW2tlywRzXKaeONI45fZvV4Ia9oQr/5swgQU45jLaKZcxU
         2Viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wG1FRF6NvvTrQgh7hkGSM1RofK5aGr38w3ooW7oI78w=;
        b=YXyXZxCSlDu+ldK3gWk/aE16PWb/q/TBFP4cXUz+tXSgHKMRYqdFKddsD8ZyxpQEHy
         HQVOuVF6BqowoHNE9XuR79PkGWtqacuXplnWTr2nb4XaC2aKhzJrI41Ia7ERcNRDjNWz
         bF8Vr7UYL4ecFVGlvZ+/P76hZ4MwZQKDWrX3G8hY4zars5bNNA8yCGH/JUmtns54rKJL
         x5okvcTnrAGZQadVOvjZL53/Wnf7jN3DiUvQ2v9JM62QD7MUruXzYvy2XW/cj7O6qDZn
         4i+xOQXo43BTimTy67sqwUgI4FeizSuj8k5xdtRdsH8CJbIvZj5pzcKAuhXaF2Ky7vFY
         vRGw==
X-Gm-Message-State: ANoB5pn4gkjM21TlowDUWmJFsU8ipxso1VYbAV6ILNi+MIrZAuefv95+
        rAf+qbGWVxMLosSrg/6mvTq6Sw==
X-Google-Smtp-Source: AA0mqf6Xq5rFthMl9MozMuFDWfE41NWQOupHJghdq9afHJdJf4VxHFmZjkVlNCm5/e0cUCYkjYpHww==
X-Received: by 2002:a17:903:452:b0:189:6574:7ac2 with SMTP id iw18-20020a170903045200b0018965747ac2mr31099929plb.65.1669859225822;
        Wed, 30 Nov 2022 17:47:05 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090a088800b00213a9e1ec44sm3671307pjc.52.2022.11.30.17.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 17:47:05 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     josef@toxicpanda.com, Kemeng Shi <shikemeng@huawei.com>,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org
In-Reply-To: <20221018121932.10792-1-shikemeng@huawei.com>
References: <20221018121932.10792-1-shikemeng@huawei.com>
Subject: Re: [PATCH v2 0/5] A few cleanup and bugfix patches for blk-iocost
Message-Id: <166985922489.517656.7936907108096958272.b4-ty@kernel.dk>
Date:   Wed, 30 Nov 2022 18:47:04 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d377f
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 18 Oct 2022 20:19:27 +0800, Kemeng Shi wrote:
> This series contain a few patch to correct comment, correct trace of
> vtime_rate and so on. More detail can be found in the respective
> changelogs.
> 

Applied, thanks!

[1/5] blk-iocost: Fix typo in comment
      commit: e12d34fce7652a870fac62e9749a6623883d6fd8
[2/5] blk-iocost: Reset vtime_base_rate in ioc_refresh_params
      commit: c81d97a61c8c3c25a576c3db4c4dd34316256f05
[3/5] blk-iocost: Trace vtime_base_rate instead of vtime_rate
      commit: 0c0d362dc97d19d898219c13a357e167a9ee77ee
[4/5] blk-iocost: Remove vrate member in struct ioc_now
      commit: f44ed8722034ef7d214fa121ae2402100a3590e1
[5/5] blk-iocost: Correct comment in blk_iocost_init
      commit: b4c0482bfe89cd6c4f030314c86aae35642c44a5

Best regards,
-- 
Jens Axboe


