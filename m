Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EE9C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbiGNSIR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240395AbiGNSII (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:08 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727BF68719
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:07 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 72so2307180pge.0
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X/ANA9un63YdxHXi+2X9cMprsuy05LDcr+pDEMnuyQg=;
        b=5iqI3YwGnbQNz756Hg0dSd/eAHmz9s05InfE+UhFBybz77pJrW6dA26Rk2JZPq+24G
         HJRBYcypw1L7HNQ1zxIs+9vI78P/sJ7wg0uMNKfNx5F1r1Wf564OUJNKF7dWDE4VFNXm
         AQwyDTmVGbTV+vfI/LL4HMDN2a5rSVQq+ay/m+OprnbrerQ5R/DeBihLUZfbuNHr7dln
         C4cx6ebkPCSUcZFW/1PGlbRzg9sH/4NHBiRTpguYA2QikSetoL7Dpfzv/Iv3Rkw0TXdU
         nrT20PI8uo+NPdZXORlhpxDObHnZQM3mHtjF/sskE2rH11JUKiwO57Y/Lin6z8h88YEO
         N3hQ==
X-Gm-Message-State: AJIora/Q3ujdOWosmQk71VpYLDfGIzeE3IIdmlt5lKB2DU1O7NgFX7Hh
        InnDWsNKNbDwrLO4IjhtMo0=
X-Google-Smtp-Source: AGRyM1vaB7he2eotJHxbswa/QyiM0CEeF69y4PRXGR6YQZA4WdOyZ9SBhghYsHniUSz3W6DaaSmuHw==
X-Received: by 2002:a63:f95c:0:b0:412:9d5b:fbfd with SMTP id q28-20020a63f95c000000b004129d5bfbfdmr8587378pgk.103.1657822087099;
        Thu, 14 Jul 2022 11:08:07 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:06 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v3 19/63] nvdimm-btt: Use the enum req_op type
Date:   Thu, 14 Jul 2022 11:06:45 -0700
Message-Id: <20220714180729.1065367-20-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type where
appropriate.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/nvdimm/btt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index dfbf73145d16..0297b7882e33 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1422,7 +1422,7 @@ static int btt_write_pg(struct btt *btt, struct bio_integrity_payload *bip,
 
 static int btt_do_bvec(struct btt *btt, struct bio_integrity_payload *bip,
 			struct page *page, unsigned int len, unsigned int off,
-			unsigned int op, sector_t sector)
+			enum req_op op, sector_t sector)
 {
 	int ret;
 
