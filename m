Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E7AC3DA66
	for <linux-block@archiver.kernel.org>; Fri, 18 Aug 2023 01:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbjHRBWS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Aug 2023 21:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356939AbjHRBWE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2023 21:22:04 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE13448E
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 18:21:28 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5657659a8a1so82381a12.1
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 18:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692321685; x=1692926485;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HgV6QkCXuVGaj9r0bY3pZeAJ8G99Uwd4RPEeNO69yg=;
        b=IPqgAMfBdYYudPJZ3jiKRcp3VbazelPGKFQVhZG2NUyZUiny65YCFU46ZNvyNYPQSR
         79XlMozAxk4vMjyLE/LI/e+Bky+IbXZ1nP3+uEdyKqdPIFtbxa8fYxQbQ/+vhYamcWmd
         6d4okcffkYW1FfbHsVdOyrfOjaPxKNGbnyisdD7TQzgvJY9sAH16UxU4r84WeYuNVKJi
         6j+laNxgU8MVGQjnn5vrXzgTwadNfCAZM1VpScJ2wbS2SpgJaWNOyLpiDlIcmtkGg+kN
         EyuTjfXSsL6OwMZs41R3jNIj5P7YDOPEA/z8brP9nJBbx4wzur271I+1ul0hEF4Nnv2x
         5OQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692321685; x=1692926485;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HgV6QkCXuVGaj9r0bY3pZeAJ8G99Uwd4RPEeNO69yg=;
        b=B0KYs+VbQQG2cd+mRPt6Vr4BxFC971yxRQu1VbdKyJaQOWhQUNZoia/rWJbqxoxR3Q
         Y7jVCrsw2dhP0hKzV0yncm8eOV4wLYtSLWhb6rm7l7/gRMf1zc5DkZ3a/zjro2MK8GwH
         BjG9xTE5G3tLnXw0nJ5IqoRtm6A8Xags8NovezCOhZ6CAQG2CY/35W3Re5U/fC/YECzH
         1RIFth4S5RB6aO7T/aPJW3xvdb3j4sqEmXhACztfDsyWUQvc8CXiPq9OiLYRaOw9ldIP
         kSR6XIXqy53MR7003Xv31tLbY/EelsvafoL/RqomHvFXUOOmhFUvaMtO/zT2A+I5xoYn
         JCIg==
X-Gm-Message-State: AOJu0YzZ8kEViD0nMyiigqs3BISqBNr1eXhn303pPijTrJW9OGhQ+Rbj
        zSU+stM2Vy0G5ecI24qRu6NMFQ==
X-Google-Smtp-Source: AGHT+IHz9skIyACs/5ZpVcrRBMRJ3gozd8Eigs/K1LrxV18BUJnanVhXoQ5J7YF6JICU1sl9UWwMeg==
X-Received: by 2002:a05:6a21:9989:b0:112:cf5:d5cc with SMTP id ve9-20020a056a21998900b001120cf5d5ccmr1741595pzb.1.1692321684715;
        Thu, 17 Aug 2023 18:21:24 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78705000000b0068746ab9aebsm387139pfo.14.2023.08.17.18.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 18:21:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Breno Leitao <leitao@debian.org>, kernel-team@meta.com
In-Reply-To: <ZN0p5_W-Q9mAHBVY@slm.duckdns.org>
References: <ZN0p5_W-Q9mAHBVY@slm.duckdns.org>
Subject: Re: [PATCH for-6.6/block] blk-cgroup: Fix NULL deref caused by
 blkg_policy_data being installed before init
Message-Id: <169232168362.702027.10446286850922079635.b4-ty@kernel.dk>
Date:   Thu, 17 Aug 2023 19:21:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 16 Aug 2023 09:56:23 -1000, Tejun Heo wrote:
> blk-iocost sometimes causes the following crash:
> 
>   BUG: kernel NULL pointer dereference, address: 00000000000000e0
>   ...
>   RIP: 0010:_raw_spin_lock+0x17/0x30
>   Code: be 01 02 00 00 e8 79 38 39 ff 31 d2 89 d0 5d c3 0f 1f 00 0f 1f 44 00 00 55 48 89 e5 65 ff 05 48 d0 34 7e b9 01 00 00 00 31 c0 <f0> 0f b1 0f 75 02 5d c3 89 c6 e8 ea 04 00 00 5d c3 0f 1f 84 00 00
>   RSP: 0018:ffffc900023b3d40 EFLAGS: 00010046
>   RAX: 0000000000000000 RBX: 00000000000000e0 RCX: 0000000000000001
>   RDX: ffffc900023b3d20 RSI: ffffc900023b3cf0 RDI: 00000000000000e0
>   RBP: ffffc900023b3d40 R08: ffffc900023b3c10 R09: 0000000000000003
>   R10: 0000000000000064 R11: 000000000000000a R12: ffff888102337000
>   R13: fffffffffffffff2 R14: ffff88810af408c8 R15: ffff8881070c3600
>   FS:  00007faaaf364fc0(0000) GS:ffff88842fdc0000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00000000000000e0 CR3: 00000001097b1000 CR4: 0000000000350ea0
>   Call Trace:
>    <TASK>
>    ioc_weight_write+0x13d/0x410
>    cgroup_file_write+0x7a/0x130
>    kernfs_fop_write_iter+0xf5/0x170
>    vfs_write+0x298/0x370
>    ksys_write+0x5f/0xb0
>    __x64_sys_write+0x1b/0x20
>    do_syscall_64+0x3d/0x80
>    entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: Fix NULL deref caused by blkg_policy_data being installed before init
      commit: ec14a87ee1999b19d8b7ed0fa95fea80644624ae

Best regards,
-- 
Jens Axboe



