Return-Path: <SRS0=aPd3=VR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A525DC76188
	for <linux-block@archiver.kernel.org>; Sat, 20 Jul 2019 12:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724F82085A
	for <linux-block@archiver.kernel.org>; Sat, 20 Jul 2019 12:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iG7FrbSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfGTMIn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Jul 2019 08:08:43 -0400
Received: from condef-08.nifty.com ([202.248.20.73]:33223 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbfGTMIn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Jul 2019 08:08:43 -0400
Received: from conuserg-09.nifty.com ([10.126.8.72])by condef-08.nifty.com with ESMTP id x6KC5ttF024891
        for <linux-block@vger.kernel.org>; Sat, 20 Jul 2019 21:05:55 +0900
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x6KC5TD2027657;
        Sat, 20 Jul 2019 21:05:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x6KC5TD2027657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563624330;
        bh=PlqRxZpGx0lOam9T/VREmCDkQVEbRoPfBxPqGOy+QWw=;
        h=From:To:Cc:Subject:Date:From;
        b=iG7FrbSfoyn7dFgAfshNE6gxv6mGNxGPGDUmcIFQqy/gHgLcMFDk5uREb0RqxGUT8
         s/+GFXYPaTrmOVnB1QFq7vVunnd/nxgVNddLUwp8rzTTwkZUjvzAduJT4ONPJiDPPX
         oKS0ztwIB0J2SaEXxGPx3E8dR4ym5mUzL/XN+fN/cMJfml0dvbFfHUR/PM3Go0fWSf
         JbqnXKfvzDSc2Xx21kKrgksPMCuwUVnjzIDK4oI55WbeqaCHk1JE5pMdW7mx6Z0wBA
         6UMdMwWKbUMaKXLNoBzn0tVIHjC5q54d9jPz9mQXw0arKXgi54IS+LZnukwRD72CKy
         IZr6s3uWkOh4Q==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block: pg: add header include guard
Date:   Sat, 20 Jul 2019 21:05:25 +0900
Message-Id: <20190720120526.7722-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a header include guard just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/uapi/linux/pg.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/pg.h b/include/uapi/linux/pg.h
index 364c350e85cd..62b6f69bd9fb 100644
--- a/include/uapi/linux/pg.h
+++ b/include/uapi/linux/pg.h
@@ -35,6 +35,9 @@
 
 */
 
+#ifndef _UAPI_LINUX_PG_H
+#define _UAPI_LINUX_PG_H
+
 #define PG_MAGIC	'P'
 #define PG_RESET	'Z'
 #define PG_COMMAND	'C'
@@ -61,4 +64,4 @@ struct pg_read_hdr {
 
 };
 
-/* end of pg.h */
+#endif /* _UAPI_LINUX_PG_H */
-- 
2.17.1

