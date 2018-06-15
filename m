Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:38380 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756429AbeFOW13 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jun 2018 18:27:29 -0400
From: Igor Konopko <igor.j.konopko@intel.com>
To: mb@lightnvm.io, javier@cnexlabs.com
Cc: linux-block@vger.kernel.org, michal.sorn@intel.com,
        marcin.dziegielewski@intel.com, igor.j.konopko@intel.com
Subject: [PATCH 2/5] lightnvm: pblk: Remove resv field for sec meta
Date: Sat, 16 Jun 2018 00:27:03 +0200
Message-Id: <20180615222706.3801-3-igor.j.konopko@intel.com>
In-Reply-To: <20180615222706.3801-1-igor.j.konopko@intel.com>
References: <20180615222706.3801-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Since we have flexible size of pblk_sec_meta
which depends on drive metadata size we can
remove not needed reserved field from that
structure

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index f82c3a0b0de5..27658dc6fc1a 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -82,7 +82,6 @@ enum {
 };
 
 struct pblk_sec_meta {
-	u64 reserved;
 	__le64 lba;
 };
 
-- 
2.14.3
