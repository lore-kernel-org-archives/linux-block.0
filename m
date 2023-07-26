Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A32C41513
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 00:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjGZA6P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jul 2023 20:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjGZA6O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jul 2023 20:58:14 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C586DBC
        for <linux-block@vger.kernel.org>; Tue, 25 Jul 2023 17:58:10 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6b9d562f776so4808250a34.2
        for <linux-block@vger.kernel.org>; Tue, 25 Jul 2023 17:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690333090; x=1690937890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfP3G2FLUFJYJUQB/WuAG4l/dYwNhxCDQudwlLXJrQI=;
        b=VsrVGVgf39kgg7g9fyFnsf9v+dgtIWaqYGn8/IiVChWUO6dsNykL/KwruTtgQVxTbT
         qKyPntpzBcD9+s+2jhz0Xk0+Ghz/p8r6ewx16y9nQ9FAvBYVP6Bi5ppvHhxgMXw1kK85
         JYdSvM6K0go3Pj2XpE19ZjxK83D8Vzgqhucs7eqD/vgHPO8of4vyKfTBfK1y2XOz8lg/
         EbjBwMq02EvDajB5AwMwTXOPOjL1eDbHAzHT501251/VLXK0+MZecurzO3i9Kee3C9fE
         r22QjXbtM4A7OQGvML5AoYu9GBpfjvZih9+bWYa+W3JOg+qx4/1fXSN7WTtuHxSLy+fA
         LFWQ==
X-Gm-Message-State: ABy/qLb0C71OWZkCe1XTbO+wT7nTTtTxkXUDZCMpWaGYqStWuEGvJeCf
        tk4IOwp5TZTLZvzJZo5kDhY=
X-Google-Smtp-Source: APBJJlE21D+lqUdbF1XyQw61O1QCMKCqlVfeo2Pa6AKQFnu4xBYGIfV6EZXRskomeAYGqg/ppamR2w==
X-Received: by 2002:a05:6358:2817:b0:135:89d6:22e9 with SMTP id k23-20020a056358281700b0013589d622e9mr357992rwb.13.1690333089854;
        Tue, 25 Jul 2023 17:58:09 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([2601:642:4c05:4a8d:dbda:6b13:2798:9795])
        by smtp.gmail.com with ESMTPSA id t10-20020a63954a000000b005634bd81331sm11090138pgn.72.2023.07.25.17.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 17:58:09 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Chao Yu <chao@kernel.org>
Subject: [PATCH v3 6/6] fs/f2fs: Disable zone write locking
Date:   Tue, 25 Jul 2023 17:57:30 -0700
Message-ID: <20230726005742.303865-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230726005742.303865-1-bvanassche@acm.org>
References: <20230726005742.303865-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Set the REQ_NO_ZONE_WRITE_LOCK flag to inform the block layer that F2FS
allocates and submits zoned writes in LBA order per zone.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/f2fs/data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5882afe71d82..6361553f4ab1 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -569,6 +569,7 @@ static void f2fs_submit_write_bio(struct f2fs_sb_info *sbi, struct bio *bio,
 		}
 	}
 
+	bio->bi_opf |= REQ_NO_ZONE_WRITE_LOCK;
 	trace_f2fs_submit_write_bio(sbi->sb, type, bio);
 	iostat_update_submit_ctx(bio, type);
 	submit_bio(bio);
