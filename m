Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19834 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932370AbcIFJAH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Sep 2016 05:00:07 -0400
From: Tomasz Majchrzak <tomasz.majchrzak@intel.com>
To: linux-block@vger.kernel.org
Cc: neilb@suse.com
Subject: [PATCH] badblocks: fix overlapping check for clearing
Date: Tue,  6 Sep 2016 10:58:58 +0200
Message-Id: <1473152338-30539-1-git-send-email-tomasz.majchrzak@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Current bad block clear implementation assumes the range to clear
overlaps with at least one bad block already stored. If given range to
clear precedes first bad block in a list, the first entry is incorrectly
updated.

Check not only if stored block end is past clear block end but also if
stored block start is before clear block end.

Signed-off-by: Tomasz Majchrzak <tomasz.majchrzak@intel.com>
---
 block/badblocks.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 7be53cb..b2ffcc7 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -354,7 +354,8 @@ int badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
 		 * current range.  Earlier ranges could also overlap,
 		 * but only this one can overlap the end of the range.
 		 */
-		if (BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > target) {
+		if ((BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > target) &&
+		    (BB_OFFSET(p[lo]) <= target)) {
 			/* Partial overlap, leave the tail of this range */
 			int ack = BB_ACK(p[lo]);
 			sector_t a = BB_OFFSET(p[lo]);
@@ -377,7 +378,8 @@ int badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
 			lo--;
 		}
 		while (lo >= 0 &&
-		       BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > s) {
+		       (BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > s) &&
+		       (BB_OFFSET(p[lo]) <= target)) {
 			/* This range does overlap */
 			if (BB_OFFSET(p[lo]) < s) {
 				/* Keep the early parts of this range. */
-- 
1.8.3.1

