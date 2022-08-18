Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D02C32771
	for <linux-block@archiver.kernel.org>; Thu, 18 Aug 2022 01:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242574AbiHRB0c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Aug 2022 21:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242600AbiHRB0c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Aug 2022 21:26:32 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98851A1A4D
        for <linux-block@vger.kernel.org>; Wed, 17 Aug 2022 18:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660785991; x=1692321991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PqmQnyM3qKpwghVIz6xzLRKD6Pyldj2w2Y8ZoWnvYvQ=;
  b=o6xtCprG7H7Bp7JNMPN04emd+G81XaX3e+RtEpX66irpUv0pF3HT2ZLL
   UaUjGOnB9EFDiItthQ7ZoemY3kDbkXfRLlLvW+UqiU4Q0iiZZPiSw+0yh
   Gbgut5ppuUPQBNXF41QacqDqMN0v1tua4/ru6FIoOO+lkMpz4XP/qYZ1X
   kz7jX6PBVJ7RTskKj9MFvllqzqrhMQbxLIFO1LIWosrCixA5bGAwEy+WF
   bKnEer60JSvC3WOhjh3CwFJiT0xxLY8vcEzMKXouRiDgHdRVDmstFl7H0
   Ub2jPsEZjnDwzZulQNRn8r73ub6VylpybjMEZF4Rkr+ywpqY7Pm4kma3g
   w==;
X-IronPort-AV: E=Sophos;i="5.93,244,1654531200"; 
   d="scan'208";a="321085644"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2022 09:26:31 +0800
IronPort-SDR: ehEvzukAONQgoqgn27d2zFjWsKe3OA8HujRa1566Tc0uopyHq2Y96g8WerIM2NOggsIrct3z78
 fti2SUlmIxa+stABaBzoHVcmn0Vg4KJlFGVDrNywE3HmJ4WJtRM3ipO3IuLS3c/+PLB5CZLt0t
 taarWJUOAnPK0tW/UNvU6lzqpOopR9L5E3MAbcxhKZRonL/HM70eq7cmWUcKMinQe8M/KjR25N
 +7VsEY4tABwi2tXeV7dZzNSdP5d+0U8EJH6D6SZPDx7ep59hjZO4jRibprINRL7L25Urr/ZyHv
 VjAiCBVwskA77DNPDXQbtFuI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 17:41:58 -0700
IronPort-SDR: BgWDNkaume6irAMSgX9SHaoAk/I3kQndzyQTv2H0Ha0hMGm4XJD0/ZKD+ieTMcsEWCo24nGEqL
 rK3eooZLHOSz5qJdK7kc0xdgvCVEZIbqJAUWRExaG6HblOtdwZe2AS3hlGTR1Z73pVI0zOj1Ae
 e3xEJzqGmsyjFyPYU7Tu4lyMn2EDMrko77wUui2MyxBUF9RzJ4t6XEctyZXOKUo46KN5GZEvmp
 Xm/1f18Wm4kvbkyAAA8n7mcCz8E+kHIYrIh5jw3EExGnqXOLyeSzzEno5j/Kp0t1KDAVntpUJS
 ehU=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Aug 2022 18:26:31 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 5/6] block/001: use _have_drivers() in place of _have_modules()
Date:   Thu, 18 Aug 2022 10:26:23 +0900
Message-Id: <20220818012624.71544-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220818012624.71544-1-shinichiro.kawasaki@wdc.com>
References: <20220818012624.71544-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The drivers sd_mod and sr_mod do not need to be loadable. Replace the
check with _have_drivers() and allow test with built-in modules.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/001 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/block/001 b/tests/block/001
index 5f05fa8..a84d0a1 100755
--- a/tests/block/001
+++ b/tests/block/001
@@ -13,7 +13,8 @@ DESCRIPTION="stress device hotplugging"
 TIMED=1
 
 requires() {
-	_have_scsi_debug && _have_modules sd_mod sr_mod
+	_have_scsi_debug
+	_have_drivers sd_mod sr_mod
 }
 
 stress_scsi_debug() {
-- 
2.37.1

