Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8C4CCA47C
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiFWTBF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiFWTAq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:00:46 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92E1B98E0
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:04 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id n10so1494280plp.0
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=We+G/zalrauIq8lDvwmMOV2UeXfICQKgYcNFNeW0WE8=;
        b=e4c68kK7N7tcPC685rUg/aBT8+1ORPHOND4D8maO05zEpYrUzGslnr2GvHTLheHWAt
         2LRGWK3BCbNHhUneXDc6yf8iTOYzTlnHQpI3/K63qB+Z07VacM5FnIUx47QIn0C0lMnk
         b+QyRD8cwAvMY5i3B22eswABXRBDGHshYM9SamNQOWehEHC7ZoSfM0sF5LcZGdvtd909
         Ue+bUxYFBPBouif6RJwoliu25EnCyjwc7JQlvaqBhVHNXew/SV90aeTLpJnDA3w4qEiY
         fXHK3HoTKVC9afBlEKSNyIEz2O8NhNKR1IqcwoyXDqPD4DIlExpN3tReWwsMnIF94Gqw
         cIUw==
X-Gm-Message-State: AJIora+J13A8B76KPrttw7gyjF/KzldDv5DPlVs/IdCw/jYIBpRxn2iV
        Iftyu34R2fW/glX1KIIei5g=
X-Google-Smtp-Source: AGRyM1ufgFpYlAhg8BfxdgBSrPNszKFuBTrZyzN4zKM77WDLJfXtE8QLR3HYvGvcSAqW6nHk4xzCqQ==
X-Received: by 2002:a17:90b:504:b0:1e6:a0a4:c823 with SMTP id r4-20020a17090b050400b001e6a0a4c823mr5346118pjz.190.1656007564322;
        Thu, 23 Jun 2022 11:06:04 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:03 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 19/51] dm/dm-integrity: Use the enum req_op and blk_opf_t types
Date:   Thu, 23 Jun 2022 11:04:56 -0700
Message-Id: <20220623180528.3595304-20-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Eric Biggers <ebiggers@google.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-integrity.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 148978ad03a8..8bb0c7a88176 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -551,7 +551,8 @@ static int sb_mac(struct dm_integrity_c *ic, bool wr)
 	return 0;
 }
 
-static int sync_rw_sb(struct dm_integrity_c *ic, int op, int op_flags)
+static int sync_rw_sb(struct dm_integrity_c *ic, enum req_op op,
+		      blk_opf_t op_flags)
 {
 	struct dm_io_request io_req;
 	struct dm_io_region io_loc;
@@ -1050,8 +1051,10 @@ static void complete_journal_io(unsigned long error, void *context)
 	complete_journal_op(comp);
 }
 
-static void rw_journal_sectors(struct dm_integrity_c *ic, int op, int op_flags,
-			       unsigned sector, unsigned n_sectors, struct journal_completion *comp)
+static void rw_journal_sectors(struct dm_integrity_c *ic, enum req_op op,
+			       blk_opf_t op_flags, unsigned sector,
+			       unsigned n_sectors,
+			       struct journal_completion *comp)
 {
 	struct dm_io_request io_req;
 	struct dm_io_region io_loc;
@@ -1096,7 +1099,8 @@ static void rw_journal_sectors(struct dm_integrity_c *ic, int op, int op_flags,
 	}
 }
 
-static void rw_journal(struct dm_integrity_c *ic, int op, int op_flags, unsigned section,
+static void rw_journal(struct dm_integrity_c *ic, enum req_op op,
+		       blk_opf_t op_flags, unsigned section,
 		       unsigned n_sections, struct journal_completion *comp)
 {
 	unsigned sector, n_sectors;
