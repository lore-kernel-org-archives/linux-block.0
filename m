Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95626C433DB
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 22:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F99B64DCD
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 22:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbhA0WJZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 17:09:25 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:40742 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbhA0WJX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 17:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611785363; x=1643321363;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OuMyKbMl9mfhwAdABbIlKkjmNW+zFB/EseW1NcmlF28=;
  b=WKwKYR1eVGsp9NI+C/oEqbzKPhUZ+4LDJsKkx5qj61P+PGd+TjpHd5nL
   tRcKSqomUnEGX/fejQ6CGV0TlldDE1mLT8j/FgsF8ZoaxDFizIL5IzQZN
   qSjVAxM0Sy4VbsJOzXp2K+W8tWsLCfJ54HhTNp19ayQGt8gseCSNO8JfV
   eXCETl4Zc5qms9X7UNK0pijlck24/cLSkU+QnTNe1ogxpm3aUbSNOmxEX
   9h5mDk/TDLBpVnQpQc4HMnyN8+nRBOVA8NPXsQ9YvBnOCeofbK66GDIBR
   wPaqIXeg+DIQnnCI5j78RGq/N8ATHbtPJFMSZGigz/k2Mvc3Q6CGHK0LG
   g==;
IronPort-SDR: gILY+FR+rgrNNNCd6NY7EPGpxUTA/LaJlDxXURjZh9EdwoTc+YNxtIU84nKNDiK80tIgQbLFgc
 rSlxurCV8+sqqNr+SGryBexwgFFrABwviVFvW2N0IstDM7QReYfDFTvHhFGKJtyJ+7tn+o4Fx7
 tXihtJoKPBhodib2vy5y/q3aGg2eoN4/FiOVUQZb6wKoN67T9KfnfF2D3esNEyu4/sRBEMf+YI
 0HF/pKIg+S/4RKd5FQ/PYR3O/nzaVrK88iT+5DMoQJ+CKfKBKlU82INh7rdCvBXtLfpYa4bjZI
 SBw=
X-IronPort-AV: E=Sophos;i="5.79,380,1602518400"; 
   d="scan'208";a="162931146"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 06:08:17 +0800
IronPort-SDR: uEgvNnH5D4PNOipI8Jx+YoldOUUYINQRNdTwMPU8AqsmQ0fiUOnw9hPL23e6+ZjQgnoG1D9QP4
 TF1iwjz3oBlNlNSBzkKJq+fWkKTaPnAFQcMTnBEu+stnoSQHhg9en8TAtyImVtT6zc1TH9UA9V
 Gr73OK6KP+wHWR1hgbNFjZzy6hHqHnCQMFzb61hrnGDjpjSXE1ZtpTeejvYY60krOhU/4B4H2i
 74pEuQHNBZ+z1Ml6R2IAbl99oPzYIu6bxLUX5/VmUrZoNq5mBOU+ZxrTAmqjpWfEjMQQCQ+lR/
 BBJo94EF80X3HIlZX2Tuahq5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 13:52:38 -0800
IronPort-SDR: GvN6qUNehbBvrQk0sRqJWbPO5Gqmx3Eo3ItD4IXdUQzJKG8nPPx6hf0w3qem1FEw2nOhcUhDXh
 /4ppPfxyxp5dVdJ31YdKaCSMCwOJkqu5hPa8Ko+ujwkaGlHCtrUgp/snTWlTrp9RG32nmlKVOG
 Sawe5kRU0ulbdoqL+p/O5pd8svPsNOp9t79V6HyzSHa2VUsS8dRlUNqsky9JJG7FqPNfhacQhA
 bsNm0z6n20UFWLh0xTl7UgE2gIjvG/Q0E+AnCwlKkYyux30eqX6DmW4mWU4fn+sEFHXGn8LyDc
 Nx0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 14:08:17 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [COMPILE ONLY RFC PATCH] loop: avoid page allocation in the fast path
Date:   Wed, 27 Jan 2021 14:08:15 -0800
Message-Id: <20210127220815.57624-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The functions lo_write_transfer() and lo_read_transfer() allocte and
free the page everytime it is called from the do_req_filebacked().

Add a member to the loop_cmd structure and use that page in read/write
transfer functions.

This is *compile only* RFC, if this is accepted I'll send tested
version.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 22 ++++++++--------------
 drivers/block/loop.h |  1 +
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 578fc034db3f..08bd17afbdff 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -318,14 +318,13 @@ static int lo_write_simple(struct loop_device *lo, struct request *rq,
  * access to the destination pages of the backing file.
  */
 static int lo_write_transfer(struct loop_device *lo, struct request *rq,
-		loff_t pos)
+			     struct loop_cmd *cmd, loff_t pos)
 {
-	struct bio_vec bvec, b;
+	struct page *page = &cmd->page;
 	struct req_iterator iter;
-	struct page *page;
+	struct bio_vec bvec, b;
 	int ret = 0;
 
-	page = alloc_page(GFP_NOIO);
 	if (unlikely(!page))
 		return -ENOMEM;
 
@@ -343,7 +342,6 @@ static int lo_write_transfer(struct loop_device *lo, struct request *rq,
 			break;
 	}
 
-	__free_page(page);
 	return ret;
 }
 
@@ -377,19 +375,15 @@ static int lo_read_simple(struct loop_device *lo, struct request *rq,
 }
 
 static int lo_read_transfer(struct loop_device *lo, struct request *rq,
-		loff_t pos)
+		struct loop_cmd *cmd, loff_t pos)
 {
-	struct bio_vec bvec, b;
+	struct page *page = &cmd->page;
 	struct req_iterator iter;
+	struct bio_vec bvec, b;
 	struct iov_iter i;
-	struct page *page;
 	ssize_t len;
 	int ret = 0;
 
-	page = alloc_page(GFP_NOIO);
-	if (unlikely(!page))
-		return -ENOMEM;
-
 	rq_for_each_segment(bvec, rq, iter) {
 		loff_t offset = pos;
 
@@ -622,14 +616,14 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_WRITE:
 		if (lo->transfer)
-			return lo_write_transfer(lo, rq, pos);
+			return lo_write_transfer(lo, rq, cmd, pos);
 		else if (cmd->use_aio)
 			return lo_rw_aio(lo, cmd, pos, WRITE);
 		else
 			return lo_write_simple(lo, rq, pos);
 	case REQ_OP_READ:
 		if (lo->transfer)
-			return lo_read_transfer(lo, rq, pos);
+			return lo_read_transfer(lo, rq, cmd, pos);
 		else if (cmd->use_aio)
 			return lo_rw_aio(lo, cmd, pos, READ);
 		else
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index a3c04f310672..dd949b22e9c9 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -71,6 +71,7 @@ struct loop_cmd {
 	atomic_t ref; /* only for aio */
 	long ret;
 	struct kiocb iocb;
+	struct page page;
 	struct bio_vec *bvec;
 	struct cgroup_subsys_state *css;
 };
-- 
2.22.1

