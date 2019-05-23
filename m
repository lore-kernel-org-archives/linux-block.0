Return-Path: <SRS0=5kok=TX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B860C282DD
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 20:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8F82175B
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 20:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558642224;
	bh=3yF8w2VV4QBGzb5d6BH5b3ScZobgQIIiUX1uFAiyMjA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jMfMEG7C9ucTz/XQNmnxfCni8vL8RdykWNXM7L+j1AzYp2wEBotRuQUh4Jj/XCpxy
	 g6f0LYSkkxJQCiT7uyQ1n9+qT0R3QUnHmFMNuQ9XaAlCwtp3kxuj4kCb1FrJR/29Ze
	 gbBlKFnib+cWpQ09R0rqDeSXj7ARc4Wi+Ag6TnbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbfEWUKX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 May 2019 16:10:23 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34695 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfEWUKX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 May 2019 16:10:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id h1so8335321qtp.1;
        Thu, 23 May 2019 13:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=585EA/9QdrC8ttaOegqbqCYCmJj3t9y5kPeRgmFvmQU=;
        b=BjDQx/aqRTL8cmzbKP9ozYJ06Rudmjm02bUEfaWfs3xbg8AEuFu4zJWCqJzllfcUdi
         jes759ywoNSZMRnn9E988WjqqHdMYsRUR3q8nnZSeLba27gShwrpvHVCgcwfs60QGTrl
         agdV2eCr5U2bDc+5C3VS9lXtvMc7ZkgvSgXnvMAY6hp4+VmyOCqjjjHSKk4dl3DrfCiP
         CUeUV7xV9B9E3CE0KEht2oI7/9aacBfFhrkS+NhetypXHkB8D9tgiAwW4rXso9W0GLnF
         TkL/17DY5VdsNbXfYlbWEXinJCJ26yB9K1hIbX7PyPfqVtirnekr++H2FToXKa8T9L9c
         MqSQ==
X-Gm-Message-State: APjAAAX3BbY/9QcT6VnH2Ac6wWyJvr+Wfjo5EDoPzXSyK/dd/2MzXHLk
        yCiD9xV4IKrRjnkI9TO9iQA=
X-Google-Smtp-Source: APXvYqwXxUwgW3G6qNOTwdf3P1C0u9M0H/XrqaywYGlY0Hb4zIk0gySRyF/2GR7F7YsZcRvg59GGVw==
X-Received: by 2002:ac8:3708:: with SMTP id o8mr82304369qtb.237.1558642221889;
        Thu, 23 May 2019 13:10:21 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id d17sm166171qkb.91.2019.05.23.13.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 May 2019 13:10:20 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] blk-iolatency: only account submitted bios
Date:   Thu, 23 May 2019 16:10:18 -0400
Message-Id: <20190523201018.49615-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As is, iolatency recognizes done_bio and cleanup as ending paths. If a
request is marked REQ_NOWAIT and fails to get a request, the bio is
cleaned up via rq_qos_cleanup() and ended in bio_wouldblock_error().
This results in underflowing the inflight counter. Fix this by only
accounting bios that were actually submitted.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-iolatency.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 507212d75ee2..58bac44ba78a 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -599,6 +599,10 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 	if (!blkg || !bio_flagged(bio, BIO_TRACKED))
 		return;
 
+	/* We didn't actually submit this bio, don't account it. */
+	if (bio->bi_status == BLK_STS_AGAIN)
+		return;
+
 	iolat = blkg_to_lat(bio->bi_blkg);
 	if (!iolat)
 		return;
-- 
2.17.1

