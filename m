Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EE9C43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiGNSI1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240493AbiGNSIU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:20 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110286871D
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:20 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id 5so1116737plk.9
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYN+z8YXhiwlM9h20/i7DEnZqOdFe4dlzQhIALAAaSk=;
        b=hw47DXxxTj2B50RW17cmaRtnG/EP6GBnfz6zS9++Je3KqBvD+Dio+cIxpPba4RAXnd
         op8o1QBoXjhnE/hOqg5P0X8IgpNV4z7Xv4KvLASmf+D5cbjwJL6FAnCTRXEg0l+wXuCL
         bIdrZnG4LisSF/CjgCPU51JNiLYquxtfG4tTvNQ1ON/umtGGG5vLGOqK5t5g3zkikLiI
         jV+bYn3DVHYzJ8ZbYU2XEKPRtCVjzSmn5hSkAXmsHjDSa0+DTo69E4thKDFX4si2ih4+
         ri1hhwdPbW6mx3LKJ2jSR/mS/e7kjoWbP+K+v8jPbfVo6bWH7g6U8NGrZvnXKrFYLGL7
         Eu5A==
X-Gm-Message-State: AJIora81g/f2Ri4XoYv4LOmoGlhI7jarQg1Krd6aRJAOz5V8/M1mka1j
        D56SVzvrvR2lLlxhYSVH5Dg=
X-Google-Smtp-Source: AGRyM1sRC/bhCPiPLeM5cRC54Is3jCsSEycT/S9ZIBSdZpS9YWgb9kJF74+6UOTWHbB+3yZuJiMYTg==
X-Received: by 2002:a17:902:f54e:b0:16c:5119:d4a8 with SMTP id h14-20020a170902f54e00b0016c5119d4a8mr9384046plf.22.1657822099710;
        Thu, 14 Jul 2022 11:08:19 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:19 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v3 27/63] dm mirror log: Use the new blk_opf_t type
Date:   Thu, 14 Jul 2022 11:06:53 -0700
Message-Id: <20220714180729.1065367-28-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for a function
argument that represents a request operation type.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-log.c b/drivers/md/dm-log.c
index 56ad13f9347b..cf10fa667797 100644
--- a/drivers/md/dm-log.c
+++ b/drivers/md/dm-log.c
@@ -291,7 +291,7 @@ static void header_from_disk(struct log_header_core *core, struct log_header_dis
 	core->nr_regions = le64_to_cpu(disk->nr_regions);
 }
 
-static int rw_header(struct log_c *lc, int op)
+static int rw_header(struct log_c *lc, enum req_op op)
 {
 	lc->io_req.bi_opf = op;
 
