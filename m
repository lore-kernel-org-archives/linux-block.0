Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D540C6FA92
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 15:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiI0P7U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 11:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiI0P7S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 11:59:18 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45759F6F5A
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 08:59:17 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id l4so5331348ilq.3
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 08:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=ieqSPoPPXvToph9UkAK3dT1zsB/1ueBJ9Q64+MHjZPs=;
        b=EVn7rax2irDjha4Uxv5kmVnTdqxF+xpCpELWPrdV/YtILS/JtCSX/1Vzhx7oVq/+1V
         4ETqrV6Pge3j5mcYlZthRdz8MYIlYatMxIrifu1Df7VG8uhIt+xJcWYv9nviO7XoSGkE
         JyMYQ1xpz1fwTWZ7cbJAwIXMGblQCCcbwKRM2n2M1JzoBzK04w91zGELVyaqi9MwLbn8
         Nl7la68p1UXvZ8ma0UOKFYdsmzUZLFE3YccXpzLMZIVw48nPLGC5op4n1dKBGLq/aRTD
         SMfsK2VIM4mBuOhDNkBzNhlHu1nzeXoQtzJdWm+c9TEUsrx8/j3NA8LX5bEMGsaxKtx5
         il6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ieqSPoPPXvToph9UkAK3dT1zsB/1ueBJ9Q64+MHjZPs=;
        b=y1ZYf7Os+c3S2a1KhBu7Jllg5iFnqK1FeE4VkJ+nVQYL7o0dYLibCaieKQ6lvBKrZD
         8bLGCj4DtUqjnVmjWD/Qzw8bJ8E19ESaXJL5bgBpL2KCLA/Qd4BisCBag0LU+b9H0sJb
         JFAIGK++i4xM95laL3dF/WDOQBfSLdmUXuXsN49OMz2aQ5dGMTMv8quwzT/y02qRS3Tf
         2TWiDIDJbGNCfAEq7UZS7wobQ+GQ8cdK92IIScPNdY2uTwkcauRdbP6ha9oS2eaip9F9
         85lacM42IprtStP1t3Sv09jXil2j8fBsL3iz8x5+JTmFEWbEdLXrWs9Kbi4uMk0v72DQ
         C7Yw==
X-Gm-Message-State: ACrzQf1B1+oU4Pizbfh6W5rkb+dtRwWguwmxMTcL7BNRbf7aLCBPfCS/
        FgS1lvevT7mio5CHi/1jqdah8yLP6wgvXg==
X-Google-Smtp-Source: AMsMyM5565+zic0KRkSuCKa8riMrm3vQP2yzjsEZ5x7tfb+QM5xPpvT5cZ6AL5VUB9RJ3McI2Tl2jA==
X-Received: by 2002:a92:ca4b:0:b0:2f8:5f8f:4067 with SMTP id q11-20020a92ca4b000000b002f85f8f4067mr5208546ilo.218.1664294356635;
        Tue, 27 Sep 2022 08:59:16 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y41-20020a02952c000000b0035672327fe5sm743760jah.149.2022.09.27.08.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:59:16 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220927075815.269694-1-hch@lst.de>
References: <20220927075815.269694-1-hch@lst.de>
Subject: Re: [PATCH] block: replace blk_queue_nowait with bdev_nowait
Message-Id: <166429435598.148580.10596124675187539380.b4-ty@kernel.dk>
Date:   Tue, 27 Sep 2022 09:59:15 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 27 Sep 2022 09:58:15 +0200, Christoph Hellwig wrote:
> Replace blk_queue_nowait with a bdev_nowait helpers that takes the
> block_device given that the I/O submission path should not have to
> look into the request_queue.
> 
> 

Applied, thanks!

[1/1] block: replace blk_queue_nowait with bdev_nowait
      commit: 568ec936bf1384fc15873908c96a9aeb62536edb

Best regards,
-- 
Jens Axboe


