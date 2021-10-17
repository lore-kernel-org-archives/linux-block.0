Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F098AC433F5
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 02:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF41660F8F
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 02:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhJQCIg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 22:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhJQCIg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 22:08:36 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C55C061765
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 19:06:27 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id s3so11373753ild.0
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 19:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7RnEanK8GB2EKAZiF/hm5X8WYcUjZEy6zLM2kjFdLlA=;
        b=jXZwTH80lMIdty6uYQKWoBcy/H5CgB0wZT9nsfiy8wgo6ZcbTHc/7GVR6ZlkJzbmsT
         unbe4oUj844rZUh/l+t5qgvFqvVIzki2vrc13PNFd71QmbCnjovqFH1tlMk8edJyNEB+
         yoRqMuQoIY0y6T7vZDBsiD3vtde37rN2211p01mI50lVEss9D4p1e82emLq0/ryVL5DB
         kgu2Jtf2yPepL+iDzT4RRTf4WJaX3+DwsF1DTWz54It4qDw+CPk7MmZ9kkmK2eOBGMD9
         u+KPPAmZJZaSfx3EVoTRNXScn+n7+oWtScPY0Ycu6GEfJZTfq6RXY2XrkY85FhAOLhWh
         DLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7RnEanK8GB2EKAZiF/hm5X8WYcUjZEy6zLM2kjFdLlA=;
        b=H/Tjmq+FXMYc092NLxEwo3C12NMwAM5VS2d41Ixn37hNy6Dh9qdgbN/bg/fnVS0Igz
         nPi9AOew9zK7hbO8K2MyvaMY1sFRVQEyMT4t0FIbjpfnI/YZwZjCysS8evkGEtBBW6V9
         FuhnlB1zlddBOiN+iOD3srnaPGifH2s8fGJZwuWHtRA+u9CDEU2PWi7quL2HXNZ1d37B
         tPCc5yTtkm20BcLTCzQy8Xva3JmP3VFdJwE+alyMGQ82+u/SAO5MI2pOfZf1Jqt5D2B0
         EP0Ia9jBIwdqXjZNoocF67WnCiXqQilrr+6MoXds/KzYhXe9qsaa4WXcVVnQ1Wy5dzE7
         OZTw==
X-Gm-Message-State: AOAM532qUoGR2drniRwm3TGGYN9L9FgR+lYclUARjUYn4G2IUHm8s8W4
        mXiG+Uz3Ff+BjuXLQd9I5WeQLlXM+VvQoA==
X-Google-Smtp-Source: ABdhPJx23jTfJ6LXMXLW03lSvMyxMXVAs7rFWBYjEiHH2Ez52QOwFRUfpegbZfeWqo9CQQ3MBsydUQ==
X-Received: by 2002:a05:6e02:12e6:: with SMTP id l6mr2128424iln.16.1634436386108;
        Sat, 16 Oct 2021 19:06:26 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id n25sm5072127ioz.51.2021.10.16.19.06.25
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 19:06:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCHSET v3] Batched completions
Date:   Sat, 16 Oct 2021 20:06:17 -0600
Message-Id: <20211017020623.77815-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

We now do decent batching of allocations for submit, but we still
complete requests individually. This costs a lot of CPU cycles.

This patchset adds support for collecting requests for completion,
and then completing them as a batch. This includes things like freeing
a batch of tags.

This version is looking pretty good to me now, and should be ready
for 5.16.

Changes since v2:
- Get rid of dev_id
- Get rid of mq_ops->complete_batch
- Drop now unnecessary ib->complete setting in blk_poll()
- Drop one sbitmap patch that was questionnable
- Rename io_batch to io_comp_batch
- Track need_timestamp on per-iob basis instead of for each request
- Drop elevator support for batching, cleaner without
- Make the batched driver addition simpler
- Unify nvme polled/irq handling
- Drop io_uring file checking, no longer neededd
- Cleanup io_uring completion side

-- 
Jens Axboe


