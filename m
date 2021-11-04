Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1200FC433EF
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 06:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA05E60EB4
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 06:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhKDGuh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhKDGuF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 02:50:05 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC90C0432E5;
        Wed,  3 Nov 2021 23:45:50 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f5so4583090pgc.12;
        Wed, 03 Nov 2021 23:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E7Lb39v8JgwIKFwWNwZqrpLx/viQ/ss7YEIY/nQme7w=;
        b=gugSXww73OmmqMpEsCtSDZM8HVRRBRxmWRe9oJkR23JO0J3vA1DTW4wgBsp0/lp/Zd
         TYAnDN89AYVcOS5zkTIyntZC6yqVJZ4eITwgNPGafaCZ4kO0maZisXQQBHu4rM5fFq1h
         i1+yDPEBfS8+ZDOR6NQhPmY79GH1EYiEcxt4F391CJiVvTLuCM8N5Ey0mw6xuvjN3aaw
         6WIX0FPlEl0APw//zhtlbGxghcc7BeiLCyNaelxj8TQZKq2jAzn3QQmH/cl8UJZ//SY8
         yapaQVfo1ieYYR4bgQ/c8Qr50oTaefS5OlNj+5HZHmM2vSUkago9Gs0LJLuEUFxX20wa
         RbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E7Lb39v8JgwIKFwWNwZqrpLx/viQ/ss7YEIY/nQme7w=;
        b=soLPNQaJdoReX8ojCRN5Go/frIb58X2dGsMlUOmYNa75bNob3ZDbX6SxqzXQO6nFJD
         Iw2SygVNGmxFtnQIsUWaON9Ki+P2GHHZgchAOwGQGZ3hmAvc+pxF5KQh5ruMAUqBbMjz
         75+J1z+OvwghaTdfCnK6Gaahve3aIuf0UKcMm2nQ+mDtlozpeszOW2UeclW+2ZUFoxQ3
         1SjmX11TI2Vwih9cKsUG2ChfNbvAmFxSptWbrJURe+VT1FD3B4YBcLqlAvuhUMkEykqA
         xLn1mNSHKHtbH7ekDmzUSqVltpHUaMdBmEodqdnVOgipqxrG2ChaQ+jJVUlKQED7iIIm
         jhrA==
X-Gm-Message-State: AOAM533/ri+jnzZgVPRndL1DvYI/CuuE4JnM9MduMHI7oegJMGFtlynA
        WntC4ExTCdKx8LCWp8r97ww=
X-Google-Smtp-Source: ABdhPJyA/GoGVwuBCfGdyyVh881wkybitfSFS9R9yp1OxsScVtwixpX63gcN7eiXhuLSyKj8gkBAPg==
X-Received: by 2002:a05:6a00:b82:b0:494:63ab:d61b with SMTP id g2-20020a056a000b8200b0049463abd61bmr2073779pfj.30.1636008350589;
        Wed, 03 Nov 2021 23:45:50 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d20sm4502359pfl.173.2021.11.03.23.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 23:45:50 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com.cn
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] loop: Remove duplicate assignments
Date:   Thu,  4 Nov 2021 06:45:46 +0000
Message-Id: <20211104064546.3074-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

The assignment and operation there will be overwritten later, so
it should be deleted.

The clang_analyzer complains as follows:

drivers/block/loop.c:2330:2 warning:

Value stored to 'err' is never read

change in v2:

Repair the sending email box

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 drivers/block/loop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1f91bd4..941b482 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2329,7 +2329,6 @@ static int loop_add(int i)
 		goto out_free_dev;
 	i = err;
 
-	err = -ENOMEM;
 	lo->tag_set.ops = &loop_mq_ops;
 	lo->tag_set.nr_hw_queues = 1;
 	lo->tag_set.queue_depth = 128;
-- 
2.15.2


