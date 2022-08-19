Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54462C32771
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 09:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348197AbiHSJjl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348187AbiHSJjb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Aug 2022 05:39:31 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0EC7EFD8
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 02:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660901969; x=1692437969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PqmQnyM3qKpwghVIz6xzLRKD6Pyldj2w2Y8ZoWnvYvQ=;
  b=bojP8H2oK5JLBkPIfKtap2uxtIju+5UwoXt7TQFp3cJCZUqF9OXEBYV7
   kRLXWNn3olKxHwTog9fl2a9AOKKECN6YP0Ofp9yYtDDIqRmM4NX6G4jdK
   oe55ileHbhP/ihy5bqGNRDge7qDrjKCyuT0p0d1GohUud6g9c/2YY4KDe
   DDpyKW+7CeAvQq0mIJpkZLmpia9uswSY/WfqLRK/1L1/91CZnkznFPkEw
   h9/NMgGR2PeTw3i3E/mmkURkdHtTmD8lU0WfVeG0O8N4RvPE18kcoHkAX
   oEW8rU/OdvPh1PgSo1jd5NrEsfB5Xqdq1RBB2iGWquYc0cbVszI1kObhE
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654531200"; 
   d="scan'208";a="313411569"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2022 17:39:29 +0800
IronPort-SDR: 41QgVB17sAGI96/CO/e7KVEpaomTqMXwLwaKgaDD6XUwNM62J6Z9EvzsqKrVxtvU6dTR/90uVK
 mwpvLGGB5SQolnaI82DLL5wH5UabBbUOk+ROxsmFW8bKiXv18WvwcCFK6AO8GHRhOafkGlLNYD
 furBh0iW+YSSUeSrzaCmw6cRJIEeNUF5VXVTEW4N/uYjq3+NkYuiFnARbWUMRCh5dNCimqTwiL
 Ilwy9PWK1/mp+yV0oH9lSMBgJiQzJurb1YuzFO63SdHfOJKDMmGmV1DmT8lOCFczWfrebOH8AN
 NvoaI0zNNiXtbZ0RWjy2JGrC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Aug 2022 01:54:53 -0700
IronPort-SDR: SIfoVuw7uc5zpyNzMCE4cUxI1SJbqXy6oHsud+DpDgpuRY6mSzxaKuuSVTSNwAA5WV4ProztD3
 uCrJrRoziED3MwPqF+G5eOygXd2eWxl7SKYvSztiaeO3HT7/x/lZFoltoFVbWwgwzI5tbVijJU
 Pzln0iGDEsHWJ0fd4aj0cwljobryk8NH83O8D5nd0fihUictMWVKuS1Nl4q4GVqljuWyHD7V9d
 kMEXB+K2r5lbs5y0fxeyHLo0eBMuO+pTXInFuVJLEhv1Y7lXtzliAiIPKAKxDG1wQ9kDZgBKqP
 ztw=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Aug 2022 02:39:28 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v3 5/6] block/001: use _have_drivers() in place of _have_modules()
Date:   Fri, 19 Aug 2022 18:39:19 +0900
Message-Id: <20220819093920.84992-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819093920.84992-1-shinichiro.kawasaki@wdc.com>
References: <20220819093920.84992-1-shinichiro.kawasaki@wdc.com>
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

