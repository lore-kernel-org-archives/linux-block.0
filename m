Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47590 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967138AbeFSUX4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jun 2018 16:23:56 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 7/9] Avoid passing tests/block/002 arguments to _init_scsi_debug
Date: Tue, 19 Jun 2018 13:23:51 -0700
Message-Id: <20180619202353.23631-8-bart.vanassche@wdc.com>
In-Reply-To: <20180619202353.23631-1-bart.vanassche@wdc.com>
References: <20180619202353.23631-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch avoids that shellcheck reports the following:

tests/block/002:34:7: note: Use _init_scsi_debug "$@" if function's $1 should mean script's $1. [SC2119]

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 common/scsi_debug | 3 +++
 tests/block/002   | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/common/scsi_debug b/common/scsi_debug
index e26e85637369..d8e6b71899a3 100644
--- a/common/scsi_debug
+++ b/common/scsi_debug
@@ -21,7 +21,10 @@ _have_scsi_debug() {
 	_have_module scsi_debug
 }
 
+# The _init_scsi_debug() argument list is passed to modprobe scsi_debug. "--"
+# is filtered out from the start of the argument list.
 _init_scsi_debug() {
+	[ "$1" = "--" ] && shift
 	if ! modprobe -r scsi_debug || ! modprobe scsi_debug "$@"; then
 		return 1
 	fi
diff --git a/tests/block/002 b/tests/block/002
index 32a0f818b95b..10e3f157c018 100755
--- a/tests/block/002
+++ b/tests/block/002
@@ -31,7 +31,7 @@ requires() {
 test() {
 	echo "Running ${TEST_NAME}"
 
-	if ! _init_scsi_debug; then
+	if ! _init_scsi_debug --; then
 		return 1
 	fi
 
-- 
2.17.1
