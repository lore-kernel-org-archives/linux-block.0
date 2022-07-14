Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161A3CCA47B
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240184AbiGNSH4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240129AbiGNSHz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:07:55 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FA06870F
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:52 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 84so1454835pgb.6
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QxRGWQiqiVqRIyqrvKRuiU55CLI52HzASsXdjT0k49A=;
        b=uZhYDGZdzwk/OU98RaZ5Mpul16QJpZUsyKzo1RlRY1XUhlNG8Hp9rPFNUZvGkQjWwE
         WUI6dBBIREjtMKSIXWJw1VA3YkghF3ttIicBrdfc4NG5CKVLzohXa0Dif8aoPGsoQujv
         lQRpU8SpNPw7CSx0rP2v4KbYK8UQR82lKr3LOrKf8TtWnWBHmsGaSizOSWGIEk7KbMpv
         2MEM9nG1TW5i6ybUxA/Izf+SfIn5M28J03PmFOMl+ix0nFu/DUepZcw1OyzPEiOTuxCR
         o8MoKRxMR3tM3qqW30Ie6vjzhCpxv/64Sj2RGDk7oWhBXszcvx+eoDFPTpybXoDds3Td
         X2wA==
X-Gm-Message-State: AJIora/lRmLvViaUoNl38haevmFxdQ56Xj0q+7Ka2cqstHj0O35Sahm2
        ZR0UxDe0eXoEypYg5h7Uf+U=
X-Google-Smtp-Source: AGRyM1u9t5B9TcWH/xLy/2RI57SHSMgXxlbOv8HOVpHf0ew/116CM4j5ZmywwNcLTPhlq6n/l+5YYw==
X-Received: by 2002:a65:6bd3:0:b0:3fd:63c3:a84b with SMTP id e19-20020a656bd3000000b003fd63c3a84bmr8768697pgw.572.1657822072008;
        Thu, 14 Jul 2022 11:07:52 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:07:51 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jun'ichi Nomura <junichi.nomura@nec.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mike Christie <michael.christie@oracle.com>,
        Li Zefan <lizf@cn.fujitsu.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v3 10/63] blktrace: Trace remapped requests correctly
Date:   Thu, 14 Jul 2022 11:06:36 -0700
Message-Id: <20220714180729.1065367-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Trace the remapped operation and its flags instead of only the data
direction of remapped operations. This issue was detected by analyzing
the warnings reported by sparse related to the new blk_opf_t type.

Reviewed-by: Jun'ichi Nomura <junichi.nomura@nec.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Mike Christie <michael.christie@oracle.com>
Cc: Li Zefan <lizf@cn.fujitsu.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Fixes: 1b9a9ab78b0a ("blktrace: use op accessors")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/trace/blktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 4752bda1b1a0..4327b51da403 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1058,7 +1058,7 @@ static void blk_add_trace_rq_remap(void *ignore, struct request *rq, dev_t dev,
 	r.sector_from = cpu_to_be64(from);
 
 	__blk_add_trace(bt, blk_rq_pos(rq), blk_rq_bytes(rq),
-			rq_data_dir(rq), 0, BLK_TA_REMAP, 0,
+			req_op(rq), rq->cmd_flags, BLK_TA_REMAP, 0,
 			sizeof(r), &r, blk_trace_request_get_cgid(rq));
 	rcu_read_unlock();
 }
