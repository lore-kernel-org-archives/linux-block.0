Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BDAC433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240489AbiGNSIT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240488AbiGNSIK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:10 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2321E67C94
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:09 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id e16so2537115pfm.11
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7nB/8fIrcZbusTl6uP2+f7zMnfIs2dSJzk2zUmHHCtI=;
        b=k+Ui/U+P+MRVSkfc6Qa82qXpPdOVKbE/NlaiIStGoQgTxvR++O+5UWOvbIclHRi4Ht
         LGWU6IzfFcDptlV2cefY65N22x/CiJggzkml0QmWqddjr5SZ7Lo1KN2cB6WqwiNJpETO
         WtVt4YfyuBiKa+tD+ZQVKO2NecxT4H0ZSx/wYWqbrVY31NIQM3Cq1eknTyRwM905sLef
         J2kDfaNPCcKTuPp6GEHO+SbdPOHicfG2XrJ8ezBszYGRJenGX9INZ8XhSMrb2/LDzdfJ
         5cOFsgwRX6CbtworyClDvtriL7ZDuamw9NklhO11tzs+JkwXXUynFhcu/CtyZuZ1rpDV
         eVdQ==
X-Gm-Message-State: AJIora/yUH7RM9ay15JyIl9Mge6iLuC/UPBjv8JTtQYw6GXMCHKClKVX
        lV3tzqzbGf45HsIgXFqXOAs=
X-Google-Smtp-Source: AGRyM1u5nbYkvpbPNFGlyPoXpdMBEKspCu0s9d/4fARzLA5FpvbncSLYoGPcx5np0HGn1TbzGBSw+w==
X-Received: by 2002:a63:f907:0:b0:411:cbe3:bb41 with SMTP id h7-20020a63f907000000b00411cbe3bb41mr8547821pgi.268.1657822088602;
        Thu, 14 Jul 2022 11:08:08 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:08 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH v3 20/63] um: Use enum req_op where appropriate
Date:   Thu, 14 Jul 2022 11:06:46 -0700
Message-Id: <20220714180729.1065367-21-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using type enum req_op instead of int where
appropriate.

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 arch/um/drivers/ubd_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 479b79e11442..eb2d2f0f0bcc 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1262,7 +1262,7 @@ static void ubd_map_req(struct ubd *dev, struct io_thread_req *io_req,
 	struct req_iterator iter;
 	int i = 0;
 	unsigned long byte_offset = io_req->offset;
-	int op = req_op(req);
+	enum req_op op = req_op(req);
 
 	if (op == REQ_OP_WRITE_ZEROES || op == REQ_OP_DISCARD) {
 		io_req->io_desc[0].buffer = NULL;
@@ -1325,7 +1325,7 @@ static int ubd_submit_request(struct ubd *dev, struct request *req)
 	int segs = 0;
 	struct io_thread_req *io_req;
 	int ret;
-	int op = req_op(req);
+	enum req_op op = req_op(req);
 
 	if (op == REQ_OP_FLUSH)
 		segs = 0;
