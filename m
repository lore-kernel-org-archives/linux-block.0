Return-Path: <SRS0=MX1A=5N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C77C43331
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 18:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B877F20714
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 18:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U75l8mgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgC1S1j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Mar 2020 14:27:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32940 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgC1S1j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Mar 2020 14:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585420059; x=1616956059;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8HmoQbg8EJqpRgkXzzz0Qq4/SPBEEioeTaMHePC25fg=;
  b=U75l8mgz/W1dGnJOdupdyT1MOCa8mRPBnJFpkG3/Nef3CEn3XflaXoa/
   jPvayizXDIkCRjy0ypfYQsldHtj49FqJfHS8JqawLOL9GSHooNLSlsao2
   UqP+RxDDsfe1g3MnCTsPGJ9MdBCQYBbhk3XtyJteuMXmynTCXAn+xEUSa
   dj6VCuTl2Oy4FNcU5o5qwglemznTwENVxf49/S4wJT0bnw2973wsI7ZzF
   nQ9ixjaqBKqeQdMvTiTaIPyuVTDoLre1JQvGcG0VZRnF9yHssYaxDM42g
   dOmM7KedUZU5UmdLB0dCQgqjwMwaO81wWvbKXTa5q3Vil8ehstVzi+DkN
   A==;
IronPort-SDR: h1XWt0b3KpmQp4vmlCwIbgB7sg0MO2Y22H9PiuGlHDrB0nB3mLUfXwJbIMmsF5Uwkxzt7x7sGQ
 oWj3Tn5wwI4FAgyTSZVZAxUy5xoqncasACpcNoxXTo12fwhxHHyYZHmWFWymCUVK3G7crasL9y
 pEZKdtjQGkgv8cZfHRiCIcju9z9OxLDnUwFOsWBTFsi05xrFc4Ji/SuhlBMelb+dhtTy761dNL
 dGnEmirAOXcl4dhLCNbLuCVI7or1qy0RaPR24toxoPsQb5qp/Qq5WR/Y9y0561PXSHB9Wt62hF
 di8=
X-IronPort-AV: E=Sophos;i="5.72,317,1580745600"; 
   d="scan'208";a="134202631"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2020 02:27:39 +0800
IronPort-SDR: 3yXI9TklQB/VtVE0VfLyq0TlHXBtPCOCqYNBaohwQsNhM9J7TLkfS+du0bCvwpT/gAHcBvmcNv
 s34L7+7OTcFcnAD9n9SER19lxrvMWnOHoCWYBWLXX3v4skH/ysHFjt6bOYPFh5z7gXHH3bKQcK
 gbn79BARRlc6S4mTPWFd8icmuah+LXAghwGE/EOrHzgMmFHzdByjc2Sa7M0cGdG0rhTzMhmLs0
 F2sFQpVkB+zu5jHVj5xUfw3Rx5RV8+k6F46BedUnKwvzKFr2DJlbMtdrJkFskBR6m132WYVjru
 vfcLGsFqQhInD6ex1YOmDZQZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 11:18:37 -0700
IronPort-SDR: YAiBIFF1Ktrg3rQfXLt9J1d1Y2HJQwMOWGci+6RDNWEpw6L/sdpEdoiNECDIxua/Epgp5tgXIf
 ji2257cY/gUk5Sxcw/ws9yYTKrQ5PUZLACXxApzhqqV1lEdu6+Mm/RhOf1sFCMx2unacXtmvjN
 W5SM4RqyZCoi8mFABcIzcRJf3ALGf2gTDeDM791ffVoxDMuJm3r0MvGQkpttD9ycWDI067xNm6
 8SzPY8nVLiWSTwr7pcSdoDF2NegSgURZmmo4m9wGZxLEN/KkUhS1BqiIPDT6NA99SOfIiDezA4
 5oM=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Mar 2020 11:27:37 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] block: return NULL in blk_alloc_queue() on error
Date:   Sat, 28 Mar 2020 11:27:34 -0700
Message-Id: <20200328182734.5585-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch fixes follwoing warning:

block/blk-core.c: In function ‘blk_alloc_queue’:
block/blk-core.c:558:10: warning: returning ‘int’ from a function with return type ‘struct request_queue *’ makes pointer from integer without a cast [-Wint-conversion]
   return -EINVAL;

Fixes: 3d745ea5b095a ("block: simplify queue allocation")
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 18b8c09d093e..7e4a1da0715e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -555,7 +555,7 @@ struct request_queue *blk_alloc_queue(make_request_fn make_request, int node_id)
 	struct request_queue *q;
 
 	if (WARN_ON_ONCE(!make_request))
-		return -EINVAL;
+		return NULL;
 
 	q = __blk_alloc_queue(node_id);
 	if (!q)
-- 
2.22.1

