Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46D0ECAAA1
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 14:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiJaObL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Oct 2022 10:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiJaObK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2022 10:31:10 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326E265A6
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 07:31:09 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q71so10839436pgq.8
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 07:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxCaUCeOv04svZ2y77cTIK0oMsYuJugdQM+dBKql0sI=;
        b=IRZ7eArpvlGdYkmcQnoG9wRJvZZRYTOjv+75+y7qrqJKP2eRSqTED0/2qbTkhBWLQW
         qn6F2oOnAkXe27Mlw/oX0MzgGhHNnKSSeUVp1LwXVkfASc9oJmR9NUJDoZLNK/A3QG1B
         GmbS7ns5SNp/q1n+LLOfa64KEfp0iHYPXHbvbaCa9ITNIC1pR/x7eGt/GQF2iXVRZSqA
         qomXVk0ErCe9GL1yOpI0pfSEa6Mxrkb4r8R8yFhVatklAs3hKVhzpxNSUak7jLw2GCqM
         aeScFdmz9vKOOVTOm5EL0jHJ1+f6j4vYA5SoJm/ZacGiQQNgyROHfnSxjZHBastsJFPd
         +Kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxCaUCeOv04svZ2y77cTIK0oMsYuJugdQM+dBKql0sI=;
        b=1PEtPwTPDiWW4csBXM12cr2Tw4QUEyGU5FlIreQ/nYfEwsJgoTEP/t2A3M3z8iC0Zm
         ++UMMmKi/AftIuywhkvzJ/wjVbmjqswGQUDcr7hxG8uxEayc/bq/8eKoX2lGJ5PrhDIP
         Y0GgVdOM2oDkvVG3h0Xa8m2opwoWgbeGY1XPtMkIp5DExcwF9TpQT/PSoUQmXKRFrWxC
         gmqjDk/lFvWfPOpgLXVTOikJ6HXb8IylfWQv3WTbQH34UxjO/k2VZ4C8TOQ8KkvA9sgQ
         ZAhmhJxTB7WanHnv8AH0WnFwuVWcHxMJmfIVegOwrd0vn8UyPzGaQia2QpOt8trGUskj
         nnjg==
X-Gm-Message-State: ACrzQf3kJT2FXXdUDAsw3b8WDukJutVRRf/u7ljLcZ7o8ZLCBuae3Kan
        hbld0DMNUxbZ9nJeCrFbR03P2g==
X-Google-Smtp-Source: AMsMyM6k2sHCrwoWqguXpQcWH+977dJthW1xU3lPj4RysM6XzuN+9vHs092ZksVUjGHPd1nUx3Gv5w==
X-Received: by 2002:a05:6a00:16c4:b0:535:890:d4a with SMTP id l4-20020a056a0016c400b0053508900d4amr14795660pfc.0.1667226668625;
        Mon, 31 Oct 2022 07:31:08 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b0017f36638010sm4552508plg.276.2022.10.31.07.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 07:31:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Chen Jun <chenjun102@huawei.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, will@kernel.org, ming.lei@redhat.com
Cc:     xuqiang36@huawei.com
In-Reply-To: <20221031031242.94107-1-chenjun102@huawei.com>
References: <20221031031242.94107-1-chenjun102@huawei.com>
Subject: Re: [PATCH] blk-mq: Fix kmemleak in blk_mq_init_allocated_queue
Message-Id: <166722666769.125558.7022234189834891609.b4-ty@kernel.dk>
Date:   Mon, 31 Oct 2022 08:31:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 31 Oct 2022 03:12:42 +0000, Chen Jun wrote:
> There is a kmemleak caused by modprobe null_blk.ko
> 
> unreferenced object 0xffff8881acb1f000 (size 1024):
>   comm "modprobe", pid 836, jiffies 4294971190 (age 27.068s)
>   hex dump (first 32 bytes):
>     00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
>     ff ff ff ff ff ff ff ff 00 53 99 9e ff ff ff ff  .........S......
>   backtrace:
>     [<000000004a10c249>] kmalloc_node_trace+0x22/0x60
>     [<00000000648f7950>] blk_mq_alloc_and_init_hctx+0x289/0x350
>     [<00000000af06de0e>] blk_mq_realloc_hw_ctxs+0x2fe/0x3d0
>     [<00000000e00c1872>] blk_mq_init_allocated_queue+0x48c/0x1440
>     [<00000000d16b4e68>] __blk_mq_alloc_disk+0xc8/0x1c0
>     [<00000000d10c98c3>] 0xffffffffc450d69d
>     [<00000000b9299f48>] 0xffffffffc4538392
>     [<0000000061c39ed6>] do_one_initcall+0xd0/0x4f0
>     [<00000000b389383b>] do_init_module+0x1a4/0x680
>     [<0000000087cf3542>] load_module+0x6249/0x7110
>     [<00000000beba61b8>] __do_sys_finit_module+0x140/0x200
>     [<00000000fdcfff51>] do_syscall_64+0x35/0x80
>     [<000000003c0f1f71>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> [...]

Applied, thanks!

[1/1] blk-mq: Fix kmemleak in blk_mq_init_allocated_queue
      commit: 943f45b9399ed8b2b5190cbc797995edaa97f58f

Best regards,
-- 
Jens Axboe


