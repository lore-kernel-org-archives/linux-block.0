Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19087C4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 15:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiKBPUQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 11:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiKBPTk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 11:19:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1793C17E38
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 08:19:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v7so5099529wmn.0
        for <linux-block@vger.kernel.org>; Wed, 02 Nov 2022 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9Y20rpLVvo5TBJHmlhFfyIhAn0kzicFV4WKChu5otc=;
        b=filVyL0Cr2NsXxSa7V2aV1vUQN0Kw/mMrkgXtu5BhQpaf1I2TO7CHTslMgukI7Qv55
         xXpZ4lvwmqSFgeduVh+u0T78+t7uPlPHj+qIPJi/4BejHhynBgNYydk0Ql1xQO2uGJpS
         wiT/7XkQqO1yffwfuZAmmlWN08gQLul+8EqC5npZnD5sFePzwsipyIpIUZ3Jn2nXfw+/
         qi5sCoJQhp97LqwRhkYz/RguBr9SbqjyPQTrZzxBG+2XvKMX0NeQKyjKY9kqt17KuCwP
         8EsFVb4E+0NiLxzk+MkfnnKbs2jMH3B+zVNz0xOIL+jlwW4eWdBxrlAyjX/5d/ZMsDpe
         /4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9Y20rpLVvo5TBJHmlhFfyIhAn0kzicFV4WKChu5otc=;
        b=j3d9pK+0iaPO/liJ5GA6avqqD4Z3uTy1jG5IvxdfExasJnZ6hxB0kbm8vQ1kPVlp5e
         aj2Z7pf+2k1We7iA8n8cZmeSgP8bXzEPXH7rU4l1H/cerzTmY6VOjva/3t9nSSvfNM/m
         Q4M2JQwJ9cpqm4PPQGx2sfS0vjBhJe76l9ScDomJEhcnpNVVStzZS3+iVp1c5AOo5Nnr
         cM+2my6+BjRxjC3H/g/xaHMPaB8mHLnBO/gqkKXqkPdPszN6YMM0wjlj1yHYJ1R8N4qE
         k7r8K1VX5VAV+5485ZAmJf9ny5hUE4WTcq/gnSMCDUvyA+mTgjgeT5+aOq4Pue1YHct8
         YVLA==
X-Gm-Message-State: ACrzQf0wB24jylltwrjAlmHd8h2YKPtqFIVe3Rp2jFrmodnJRcuvf7qU
        NfO0AIoHuDD5qjetI4bFK3g12YHGggY=
X-Google-Smtp-Source: AMsMyM7s+P+ZhTLHW4fnCpyqJDlvHmS83I3SBnor0krwMUjC9K5stQA7oDM0G8t5X7GVlEmShN9w4Q==
X-Received: by 2002:a05:600c:6023:b0:3cf:7dc1:e08e with SMTP id az35-20020a05600c602300b003cf7dc1e08emr6673920wmb.154.1667402377536;
        Wed, 02 Nov 2022 08:19:37 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.186.241])
        by smtp.gmail.com with ESMTPSA id a14-20020adff7ce000000b0022e66749437sm13043232wrq.93.2022.11.02.08.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:19:36 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH for-next v4 2/6] bio: don't rob starving biosets of bios
Date:   Wed,  2 Nov 2022 15:18:20 +0000
Message-Id: <aa150caf9c263fa92269e86d7826cc8fa65f38de.1667384020.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <cover.1667384020.git.asml.silence@gmail.com>
References: <cover.1667384020.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Biosets keep a mempool, so as long as requests complete we can always
can allocate and have forward progress. Percpu bio caches break that
assumptions as we may complete into the cache of one CPU and after try
and fail to allocate with another CPU. We also can't grab from another
CPU's cache without tricky sync.

If we're allocating with a bio while the mempool is undersaturated,
remove REQ_ALLOC_CACHE flag, so on put it will go straight to mempool.
It might try to free into mempool more requests than required, but
assuming than there is no memory starvation in the system it'll
stabilise and never hit that path.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 57c2f327225b..8afc3e78beff 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -526,6 +526,8 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 	}
 	if (unlikely(!p))
 		return NULL;
+	if (!mempool_is_saturated(&bs->bio_pool))
+		opf &= ~REQ_ALLOC_CACHE;
 
 	bio = p + bs->front_pad;
 	if (nr_vecs > BIO_INLINE_VECS) {
-- 
2.38.0

