Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E747DC43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 13:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B548820848
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 13:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfCENyR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:54:17 -0500
Received: from mga18.intel.com ([134.134.136.126]:64693 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfCENyR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Mar 2019 08:54:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 05:54:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,444,1544515200"; 
   d="scan'208";a="129161545"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2019 05:54:15 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v2 2/8] lightnvm: pblk: Fix put line back behaviour
Date:   Tue,  5 Mar 2019 14:51:14 +0100
Message-Id: <20190305135120.29284-3-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190305135120.29284-1-igor.j.konopko@intel.com>
References: <20190305135120.29284-1-igor.j.konopko@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In current implementation of pblk_put_line_back behaviour
there are two cases which are not handled.

First one is the race condition with __pblk_map_invalidate in
which function we check for line state, which might be closed,
but still not added to any list and thus explode in list_move_tail.
This is due to lack of locking both gc_lock and line lock
in pblk_put_line_back current implementation.

The second issue is that when we are in that function, line
is not on any list and pblk_line_gc_list might hit the same
gc group and thus not return any move_list. Then our line
will stuck forever unassigned to any list. Simply resetting
gc_list to none will fix that.

Fixes: a4bd217 ("lightnvm: physical block device (pblk) target")
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-gc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index ea9f392..e23b192 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -64,19 +64,23 @@ static void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line)
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct list_head *move_list;
 
+	spin_lock(&l_mg->gc_lock);
 	spin_lock(&line->lock);
 	WARN_ON(line->state != PBLK_LINESTATE_GC);
 	line->state = PBLK_LINESTATE_CLOSED;
 	trace_pblk_line_state(pblk_disk_name(pblk), line->id,
 					line->state);
+
+	/* We need to reset gc_group in order to ensure that
+	 * pblk_line_gc_list will return proper move_list
+	 * since right now current line is not on any of the
+	 * gc lists.
+	 */
+	line->gc_group = PBLK_LINEGC_NONE;
 	move_list = pblk_line_gc_list(pblk, line);
 	spin_unlock(&line->lock);
-
-	if (move_list) {
-		spin_lock(&l_mg->gc_lock);
-		list_add_tail(&line->list, move_list);
-		spin_unlock(&l_mg->gc_lock);
-	}
+	list_add_tail(&line->list, move_list);
+	spin_unlock(&l_mg->gc_lock);
 }
 
 static void pblk_gc_line_ws(struct work_struct *work)
-- 
2.9.5

