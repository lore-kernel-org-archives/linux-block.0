Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9A5C43613
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3504A2173B
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XO75WRSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfAJJiE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:38:04 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:25562 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727934AbfAJJiE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 04:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547113086; x=1578649086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nkqv/ycijaqi1SgvdSnleRcBm5gIb4Cr9XrVnPiS8D8=;
  b=XO75WRSMat1lUMfsaEhS67nduEGUC+8E+L/8GcEeZowVw0ATDn5phVxq
   NyKFwqhKwAM6bLqwr3Wdu61/TFTOFtOidEoKR6/4MeByq3nO3PIWC0RIA
   qQLXyFCcZBYdKZ8nbbGRt99VT+nSW5D2Catn7OZjyJEWjBq7cjpQViz+7
   ReA1d0Cf+CQ/Yoy4JOlIQfOO5yaqjydSwJ+JlOyVxFRQakwcksbLNEO+o
   o8HMOzu5QxjlWj0yHzIx9zRLRG4p2RZn5ZgXcw+j9jZMvTIBQfIhPGISv
   M6CHHBY4+ysFYfI/RaEildpWZ7SCbBWXp5SS+KqXYPCX1UYiJEH03nYy9
   g==;
X-IronPort-AV: E=Sophos;i="5.56,460,1539619200"; 
   d="scan'208";a="196468995"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2019 17:38:06 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 10 Jan 2019 01:19:34 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jan 2019 01:38:00 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests v2 08/16] check: Introduce group_exit() function
Date:   Thu, 10 Jan 2019 18:37:17 +0900
Message-Id: <20190110093725.32675-9-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
References: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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

