Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AEBC54EED
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 03:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbjA3DEU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Jan 2023 22:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjA3DET (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Jan 2023 22:04:19 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2501BAE1
        for <linux-block@vger.kernel.org>; Sun, 29 Jan 2023 19:04:19 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id w6-20020a17090ac98600b0022c58cc7a18so5309190pjt.1
        for <linux-block@vger.kernel.org>; Sun, 29 Jan 2023 19:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8Si42SXg3p/v53oJ0WjlF8k3KsK7TZIWpI9Yvs65QY=;
        b=WuhUZYxmdEamJ7MTQv7gXySaugh6wsay/KucjPUY7UTZunQF2Oj8O48IIqX52uwJNK
         FudTHPXMQlmcRGdnlT4NruW4dDqtYCBPNKbHYmTTy/obx9bHeXMweEhCfgLCQd6qhwQ5
         mVIoPs9VN1rLs++Qf6948YE8IXPHoDyK4P5ZbkyqNK8uX0DMirIQUbeOE/Wk3/f8Ek9u
         t01LXmOx4/1x/ScCYVgzJo5btpqq3DmgDb2PQ/dlJAywxhgCas+N6S7AKFYK7EV55ljI
         rNvbkIqDFrsbfbbcjfrI0ZhgiS1KHj3Z0Tk5n8i5B0ZvXLWkL449UXdgoMpMgq2DLBeG
         C/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8Si42SXg3p/v53oJ0WjlF8k3KsK7TZIWpI9Yvs65QY=;
        b=IGAE80cHK2woRJOpq1GedrANNb+meOcuK1YeBZCl4i3xJ0PZYTL6LvRUaDFiXStdLi
         eB83hYkecQluJTWOzTsH/rEiPKBjMfJ0n3nag98G/PCrgwF1YeNWvd3oL10r8FqN5Puj
         /Jl66koh4X9NoJXTmHzsQuhjxRjS9tp0PbZjDbKdk0S5V7x0kZE2p0IVMBzFr+auISlf
         asvQAIrOd06skmvn3DYmBoIJxpeLwiIfbqeyR/ZTZVS1+bqvRDTQNK2JHjdtBV1DZPVe
         YGc2a1A7zjG8I9yGq2KLNSpzKzR9kyYLmE79h+qzVsSPtTGw2uja9y+RqsCggjYyoGe9
         8L7g==
X-Gm-Message-State: AO0yUKWBN6379XlW6JJtlm4reruO004cN3QInp/CUpJTyQ2X1aY1d/mz
        o9YVTh6bLzNX54bFG8fyZE5L/SKvBQh6/+sS
X-Google-Smtp-Source: AK7set8DFQrFTyZucJy1+vvi0YxAOyNhuvl8iU5Ir2sxb6MJhK81v1pGMjv69eoJkFdOYZ8t1OGSsg==
X-Received: by 2002:a05:6a21:86a9:b0:bc:83c0:b002 with SMTP id ox41-20020a056a2186a900b000bc83c0b002mr1573818pzb.1.1675047858455;
        Sun, 29 Jan 2023 19:04:18 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n29-20020a638f1d000000b004d3f518eea7sm5667103pgd.94.2023.01.29.19.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 19:04:17 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     jack@suse.cz, Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     kbusch@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230116205059.3821738-1-shikemeng@huaweicloud.com>
References: <20230116205059.3821738-1-shikemeng@huaweicloud.com>
Subject: Re: [PATCH v3 0/5] A few bugfix and cleanup patches for sbitmap
Message-Id: <167504785731.199828.11213297504442207729.b4-ty@kernel.dk>
Date:   Sun, 29 Jan 2023 20:04:17 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 17 Jan 2023 04:50:54 +0800, Kemeng Shi wrote:
> recalculation to avoid potential IO hung and a few cleanup patches to
> remove unnecessary check and repeat code in sbitmap. Thanks.
> 

Applied, thanks!

[1/5] sbitmap: remove unnecessary calculation of alloc_hint in __sbitmap_get_shallow
      commit: f1591a8bb3e02713f4ee2efe20df0d84ed80da48
[2/5] sbitmap: remove redundant check in __sbitmap_queue_get_batch
      commit: 903e86f3a64d9573352bbab2f211fdbbaa5772b7
[3/5] sbitmap: rewrite sbitmap_find_bit_in_index to reduce repeat code
      commit: 08470a98a7d7e32c787b23b87353f13b03c23195
[4/5] sbitmap: add sbitmap_find_bit to remove repeat code in __sbitmap_get/__sbitmap_get_shallow
      commit: 678418c6128f112fc5584beb5cdd21fbc225badf
[5/5] sbitmap: correct wake_batch recalculation to avoid potential IO hung
      commit: b5fcf7871acb7f9a3a8ed341a68bd86aba3e254a

Best regards,
-- 
Jens Axboe



