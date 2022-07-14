Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36D9C43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239994AbiGNSH7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240281AbiGNSH5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:07:57 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B21168725
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:56 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id r186so2285356pgr.2
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mhPIAl52SGdCw8OIB9YQLSAjw9f6OZgP6XBN+juRKMc=;
        b=jXqpjmyPoz01FiCn6SL8cqOFK+YASWfmxlvedguZ2qHpjNohbxFlVMowF17f0DkdFw
         f2zVZhW0gBsBmnaOoNNMjlW8rGJ5XgG/NEjmJ2+1IXZ8jtEKFMhP9/Z4Ku7TA/APYDUI
         PVBs8qSQcg/W2agYOJ1RIyLRRO17Ncii077A3pFP9KzerVlc9qLY8SofSXaEpXEY777N
         X8mUlqgNqiHLmsyeN7tYQxt6NEII3isHVzfWYEEnJIH1hJlxWA9kO+hD+HaN94QsVGMb
         1uPLFmPRbuaSCYsCkyYhCxS1/GQJp4CZKK5Gz+sk5s95D9r35S83gCHyVk6JDCk7KgG5
         Fd1Q==
X-Gm-Message-State: AJIora9JpqDVhv4ndnspkHTAsF2YcRJ8im5XPNKrtSVL55jjUWeU80DZ
        zWghrQeNB9pnv+Bx7Z3jUxUU6FB5/4E=
X-Google-Smtp-Source: AGRyM1twEzGsFcKSegVhVwAAKQ6Ez00Ui6/YH0YrF1M1mk4AwfPVNhnpIM84vogTVo4UmRqz2nf2nw==
X-Received: by 2002:a63:165a:0:b0:415:4564:6ae1 with SMTP id 26-20020a63165a000000b0041545646ae1mr8406854pgw.526.1657822075322;
        Thu, 14 Jul 2022 11:07:55 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:07:54 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 12/63] block/brd: Use the enum req_op type
Date:   Thu, 14 Jul 2022 11:06:38 -0700
Message-Id: <20220714180729.1065367-13-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for a
function argument that represents a request operation.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/brd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 7b82876af36e..859499cd1ff8 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -256,7 +256,7 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
  * Process a single bvec of a bio.
  */
 static int brd_do_bvec(struct brd_device *brd, struct page *page,
-			unsigned int len, unsigned int off, unsigned int op,
+			unsigned int len, unsigned int off, enum req_op op,
 			sector_t sector)
 {
 	void *mem;
