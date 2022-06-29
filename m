Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294CBC433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiF2XcY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiF2XcY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:24 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4821329
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:23 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id x20so9875288plx.6
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X/ANA9un63YdxHXi+2X9cMprsuy05LDcr+pDEMnuyQg=;
        b=g3Mg2hhO5p/LFslsWSwwiM3tebXYH/12qv3/qCWBPiySjRUXneGD7zuJ/08OCnzkdX
         FwhG4Ito4gRHs7WG8iSxEcORiV6n86g2LOwz/uIhpE+9vqRpf+rLPEzRhNXrh/v5Bglo
         4fZFrsgKAIaCE2VG7Q2WHNQ5YPnnkMBeb2ndLISqKMmBm3sIZBR0ddgTiBxGhnKGBmG4
         LsKaf0dJnwzmkCpWwafV5xmoxAA5L/qy3k+CWTFepVRhoXwjX9CgbFaNmtTP0RcaCqoo
         CCmdKQIIUGq+85kgs/cLbY3vFdNmgDhXX1g+R7CyyAfeRmvnW9REgaDfF1RroVu+izn/
         kusw==
X-Gm-Message-State: AJIora+ELDzDawjwjTRD3z8gVBH0JtlYbeKDtzJ5/wUmvQFLROTA1MXj
        JyXt2qCYKd9cGHf6DpyI5SnTxn8ZYdw=
X-Google-Smtp-Source: AGRyM1tYQzWYcrGig7WhLVpZlHkZVMO9nQmCzKsARjLEf20yCqWjImrj817mA+vhMDd0oNcrRpu3FQ==
X-Received: by 2002:a17:90b:1982:b0:1ec:e2fa:99ae with SMTP id mv2-20020a17090b198200b001ece2fa99aemr8280390pjb.228.1656545543446;
        Wed, 29 Jun 2022 16:32:23 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:22 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 19/63] nvdimm-btt: Use the enum req_op type
Date:   Wed, 29 Jun 2022 16:31:01 -0700
Message-Id: <20220629233145.2779494-20-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
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
 
