Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0848CC77B73
	for <linux-block@archiver.kernel.org>; Mon,  5 Jun 2023 22:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjFEWP6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jun 2023 18:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjFEWP5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jun 2023 18:15:57 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A0AF7
        for <linux-block@vger.kernel.org>; Mon,  5 Jun 2023 15:15:56 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6584553892cso482037b3a.0
        for <linux-block@vger.kernel.org>; Mon, 05 Jun 2023 15:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686003355; x=1688595355;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMXtmKfbmokYLB7uQ5WSAk4+F8MAIPB5154UaLInYwo=;
        b=vei6ExKysQ7iDwD6QEZv3q1BJOraZZbXS7bWyFKfXKTEJyQtnx+0vEvTGw1ZiK6AY1
         6U9nvYngrLgVK7yZTOwk/g426NNAzZK50mh13tss5VFpfWgM29HcogMwhRrAlPaIPDvE
         g4b1PLcezAipJxKae1nfnVVV6bq5AG/XuydPg7PapwT32xiJ1mu0boaqkQ5UTZc0WK5S
         9IQ/On5lGqZIXJs4Dhr0iwRIAxkG/H9CicAXHj/ssv3lY14UXiL2y5DpIbAafB73gFnL
         6Geb/6tAg/+mVL913Xu4NpErQajq4JO+A3mRMoY3WUBjnBWz7jIWyx/ucmI9LoQ8p9B9
         xY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686003355; x=1688595355;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMXtmKfbmokYLB7uQ5WSAk4+F8MAIPB5154UaLInYwo=;
        b=jCoPJG9p8N5xmFjWAVHOb9+JEixRDceLI8F5tmqFITX6ZbSHld4Dhz3pfjHffQgLAa
         6jmlPgWWaaZ+n4hf3rhc2MW/xT2ZMyH3VLIjPH9KXG+kXE6dOc9E0VkW9XQ3Zg/FLdkP
         nDw9+P9y7bSrs8GTzpnE9lo6WhH6SHETYr/SZspIVoPTa4kDWB2DdtscLD4tnN2V2YcC
         wIRVV0WyA1uY+ijXkJmZUdQn1ogSonIqy7PZ7EZ1UcUH2Zjz6R2ns6+2lrMxbxJxgrWA
         wIbpuLUqPC+8tEJdlrtdb7rZ4QyqTjVheEY5/U6qPEy34OFzmu2oxDAk6PcPVtI42OEP
         Va2g==
X-Gm-Message-State: AC+VfDyVHZSbQCU/KUyQ4zipoSMRuBiXpEbXVSabVAFk2GFkO0tePYz3
        CS5qgTtHOkdXKPR8/kq8nxlZp8MeVWuvTdWgOWPGlw==
X-Google-Smtp-Source: ACHHUZ67jn+VdenMIEOVfi+mg7Ss98shsK/fQiwlJI+PQXlvvUsREifLADhk/fPRpTResEnTuVRfkA==
X-Received: by 2002:a05:6a00:2490:b0:656:7b53:fed4 with SMTP id c16-20020a056a00249000b006567b53fed4mr6852360pfv.1.1686003355126;
        Mon, 05 Jun 2023 15:15:55 -0700 (PDT)
Received: from [127.0.0.1] ([2600:380:c017:83c2:f698:1aad:6875:3e53])
        by smtp.gmail.com with ESMTPSA id x17-20020a056a00271100b0064f39c6474fsm2804545pfv.56.2023.06.05.15.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 15:15:54 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230605062354.24785-1-nj.shetty@samsung.com>
References: <CGME20230605062713epcas5p15f43412fdef92c01567dd9c59a931d9b@epcas5p1.samsung.com>
 <20230605062354.24785-1-nj.shetty@samsung.com>
Subject: Re: [PATCH] null_blk: Fix: memory release when memory_backed=1
Message-Id: <168600335395.173234.7376041996345283408.b4-ty@kernel.dk>
Date:   Mon, 05 Jun 2023 16:15:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 05 Jun 2023 11:53:53 +0530, Nitesh Shetty wrote:
> Memory/pages are not freed, when unloading nullblk driver.
> 
> Steps to reproduce issue
>   1.free -h
>         total        used        free      shared  buff/cache   available
> Mem:    7.8Gi       260Mi       7.1Gi       3.0Mi       395Mi       7.3Gi
> Swap:      0B          0B          0B
>   2.modprobe null_blk memory_backed=1
>   3.dd if=/dev/urandom of=/dev/nullb0 oflag=direct bs=1M count=1000
>   4.modprobe -r null_blk
>   5.free -h
>         total        used        free      shared  buff/cache   available
> Mem:    7.8Gi       1.2Gi       6.1Gi       3.0Mi       398Mi       6.3Gi
> Swap:      0B          0B          0B
> 
> [...]

Applied, thanks!

[1/1] null_blk: Fix: memory release when memory_backed=1
      commit: 8cfb98196cceec35416041c6b91212d2b99392e4

Best regards,
-- 
Jens Axboe



