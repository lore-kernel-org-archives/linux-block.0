Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAA7C7618B
	for <linux-block@archiver.kernel.org>; Mon, 13 Mar 2023 22:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjCMWaB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Mar 2023 18:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjCMW37 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Mar 2023 18:29:59 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948A57B9B2
        for <linux-block@vger.kernel.org>; Mon, 13 Mar 2023 15:29:57 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id p20so14576968plw.13
        for <linux-block@vger.kernel.org>; Mon, 13 Mar 2023 15:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678746597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xa07PDDOnj/X6NHN+d/QgDm/+DQki57Tyzb3ho/cDuY=;
        b=bylvb4fxugyVDyToLt5KgTYX0EeU8moTM+EGxcxevMVmFAAwBd/b8qm1kmZvfBvdqg
         xrvhBGF1I/rw0V2kUxdFKH8/ATrtXkDfLxsHhbAcMfTUdZ8YL91kykyDgtDPC5rPCAtw
         G7yuXDGBulWFqWPG85pX3lZvecfT3ebaG7yRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678746597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xa07PDDOnj/X6NHN+d/QgDm/+DQki57Tyzb3ho/cDuY=;
        b=N+Pk6OcXldRZ19LXphK8TI+pJPzVwH205DxHnZ8CU8vXkQEcCav3R7KhZW7BoGc8q4
         +ZJ4sCr3PtlfEzukUfPix0oejpVSQTODxYinSjkDdjaxZt8mfDdtVBqkSVAdOCise6yr
         xirRqivWzd1nbYlvB7fmcn1c2OVP6nz0ghQTMlEVrEbljbPGctikycFmsy3AtpwGxJLo
         vbEg0pMA1gkewztus1Iik+0+6vtYGlXDEg8YqQLIyQzhLgZ3vkctvsQDeSMft0C3HrUs
         07QkBorLrTTkuIOp1vPRMZpXgEb2dKJe91FvXI3V19WuurBOJnuyQYa1OMTyLFdnDiJn
         cFdg==
X-Gm-Message-State: AO0yUKXleUcc8Pc4mtvDLMntsCc/EavkzGB/+17hLpn6rxosmsEDJrp6
        XSN1tzyNGN14gUe0D9epIjT5xA==
X-Google-Smtp-Source: AK7set8ijmeCDZTeQ5anQRrCdK+T4bnN0nNP0w7J4l9Ofm1NnmHTTqjHYMYqUtegpiLW2JeXvfPgEw==
X-Received: by 2002:a17:902:d4c8:b0:19e:7bce:cc65 with SMTP id o8-20020a170902d4c800b0019e7bcecc65mr39459482plg.66.1678746596837;
        Mon, 13 Mar 2023 15:29:56 -0700 (PDT)
Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2d4:203:157:b07d:930a:fb24])
        by smtp.gmail.com with ESMTPSA id km8-20020a17090327c800b0019aa8149cb9sm352440plb.79.2023.03.13.15.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 15:29:56 -0700 (PDT)
From:   Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To:     stable@vger.kernel.org
Cc:     linux-block@vger.kernel.org, NeilBrown <neilb@suse.de>,
        Jens Axboe <axboe@kernel.dk>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Chao Yu <chao@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Paolo Valente <paolo.valente@linaro.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH v5.10 3/5] block/bfq-iosched.c: use "false" rather than "BLK_RW_ASYNC"
Date:   Mon, 13 Mar 2023 15:27:55 -0700
Message-Id: <20230313222757.1103179-4-khazhy@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230313222757.1103179-1-khazhy@google.com>
References: <20230313222757.1103179-1-khazhy@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: NeilBrown <neilb@suse.de>

[ Upstream commit f6bad159f5d5e5b33531aba3d9b860ad8618afe0 ]

bfq_get_queue() expects a "bool" for the third arg, so pass "false"
rather than "BLK_RW_ASYNC" which will soon be removed.

Link: https://lkml.kernel.org/r/164549983746.9187.7949730109246767909.stgit@noble.brown
Signed-off-by: NeilBrown <neilb@suse.de>
Acked-by: Jens Axboe <axboe@kernel.dk>
Cc: Anna Schumaker <Anna.Schumaker@Netapp.com>
Cc: Chao Yu <chao@kernel.org>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Paolo Valente <paolo.valente@linaro.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Wu Fengguang <fengguang.wu@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Stable-dep-of: b600de2d7d3a ("block, bfq: fix uaf for bfqq in bic_set_bfqq()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0a53b653a7e2..35b240cba092 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5071,7 +5071,7 @@ static void bfq_check_ioprio_change(struct bfq_io_cq *bic, struct bio *bio)
 	bfqq = bic_to_bfqq(bic, false);
 	if (bfqq) {
 		bfq_release_process_ref(bfqd, bfqq);
-		bfqq = bfq_get_queue(bfqd, bio, BLK_RW_ASYNC, bic);
+		bfqq = bfq_get_queue(bfqd, bio, false, bic);
 		bic_set_bfqq(bic, bfqq, false);
 	}
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

