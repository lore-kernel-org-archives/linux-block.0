Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F79CC43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A1920821
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a5n2zLQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfAIBgX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:36:23 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65001 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfAIBgW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 20:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1546997782; x=1578533782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k5dgo8/zMtUHAt6RIFyt1DusA3YxQwa0YXqOEA6Oy+o=;
  b=a5n2zLQu4Gq+uTqZV3if3TddUisB4hNAXLE5jxxDFxtgtJTFPyiIb9v+
   vx7njkbpfjmfjBFvME5+GegBMwLBDqDQ4X5GOYnYFRhfw1bqRsrMgZQUi
   G4BzbUgGcQtmLChH4AzJLQCHeIohsL4NOBOUQ26pOGaqfrDDpYne8yz2w
   ZcccjHU+g7NVds/6dh73fk6+EwgT77GpLwrZa1cZwTpozq6FO5DG4bPJs
   5b7nv5VeUDTIKghDikYaCzIu0tL5xWHaRXX6x+HemCd8uvLEWCF3xeVRo
   vt0QMAGQnDcXF+ZmcULMDSAHLSrWWyH5ezwNFBL+YnVK7a/vWjcVuFBwx
   w==;
X-IronPort-AV: E=Sophos;i="5.56,455,1539619200"; 
   d="scan'208";a="203169200"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2019 09:36:22 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 08 Jan 2019 17:16:23 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jan 2019 17:36:20 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH blktests 07/14] check: Introduce group_exit() function
Date:   Wed,  9 Jan 2019 10:35:35 +0900
Message-Id: <20190109013542.23686-8-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109013542.23686-1-damien.lemoal@wdc.com>
References: <20190109013542.23686-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

This optional function can be defined by a test group rc script. When
defined, it is executed after all tests of the group complete, allowing
cleaning up resources used by all tests of the group.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/check b/check
index 141ebb6..360f61b 100755
--- a/check
+++ b/check
@@ -467,6 +467,11 @@ _run_group() {
 			ret=1
 		fi
 	done
+
+	if declare -fF group_exit >/dev/null ; then
+		group_exit
+	fi
+
 	return $ret
 }
 
-- 
2.20.1

