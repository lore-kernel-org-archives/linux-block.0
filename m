Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753551AbdFWIPA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jun 2017 04:15:00 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH blktests] sg/001: don't require scsi_debug
Date: Fri, 23 Jun 2017 10:14:48 +0200
Message-Id: <20170623081448.8121-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Don't require scsi_debug but check if TEST_DEV is a SCSI device and use it
instead.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 tests/sg/001 | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tests/sg/001 b/tests/sg/001
index a4cfabe25ba0..fc883ebd1c8a 100755
--- a/tests/sg/001
+++ b/tests/sg/001
@@ -24,13 +24,13 @@ DESCRIPTION="try triggering a kernel GPF with 0 byte SG reads"
 QUICK=1
 
 requires() {
-	_have_src_program sg/syzkaller1 && _have_scsi_debug
+	_have_src_program sg/syzkaller1
 }
 
-test() {
+test_device() {
 	echo "Running ${TEST_NAME}"
 
-	if ! _get_scsi_debug_dev; then
+	if ! _test_dev_is_scsi; then
 		return 1
 	fi
 
@@ -38,7 +38,5 @@ test() {
 	cd "$TMPDIR" || return 1
 	timeout -s INT 10s "$SRCDIR/sg/syzkaller1" "$SG_DEV"
 
-	_put_scsi_debug_dev
-
 	echo "Test complete"
 }
-- 
2.12.3
