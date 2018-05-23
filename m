Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25419 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932070AbeEWMas (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 May 2018 08:30:48 -0400
From: Igor Konopko <igor.j.konopko@intel.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, marcin.dziegielewski@intel.com,
        Igor Konopko <igor.j.konopko@intel.com>
Subject: [PATCH 2/3] lightnvm: Handling when whole line is bad
Date: Wed, 23 May 2018 14:29:55 +0200
Message-Id: <20180523122956.24137-3-igor.j.konopko@intel.com>
In-Reply-To: <20180523122956.24137-1-igor.j.konopko@intel.com>
References: <20180523122956.24137-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When all the blocks (chunks) in line are marked as bad (offline)
we shouldn't try to read smeta during init process.

Currently we are trying to do so by passing -1 as PPA address,
what causes multiple warnings, that we issuing IOs to out-of-bound PPAs.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
---
 drivers/lightnvm/pblk-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 6d21f9dbca5f..5d197f19b77b 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -867,6 +867,11 @@ int pblk_line_read_smeta(struct pblk *pblk, struct pblk_line *line)
 {
 	u64 bpaddr = pblk_line_smeta_start(pblk, line);
 
+	if (bpaddr == -1) {
+		/* Whole line is bad - do not try to read smeta. */
+		return 1;
+	}
+
 	return pblk_line_submit_smeta_io(pblk, line, bpaddr, PBLK_READ_RECOV);
 }
 
-- 
2.14.3
