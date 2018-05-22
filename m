Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:37641 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbeEVHgP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 May 2018 03:36:15 -0400
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org
Cc: osandov@osandov.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH blktests] blktests: use consistent helper returns
Date: Tue, 22 May 2018 03:36:11 -0400
Message-Id: <20180522073611.4022-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is a cleanup patch which uses consistent return values
for helper functions.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 common/rc | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/common/rc b/common/rc
index e59ae0b..936b21d 100644
--- a/common/rc
+++ b/common/rc
@@ -51,10 +51,9 @@ _have_root() {
 _have_module() {
 	if modprobe -n -q "$1"; then
 		return 0
-	else
-		SKIP_REASON="$1 module is not available"
-		return 1
 	fi
+	SKIP_REASON="$1 module is not available"
+	return 1
 }
 
 _have_module_param() {
@@ -62,15 +61,15 @@ _have_module_param() {
 		SKIP_REASON="$1 module does not have parameter $2"
 		return 1
 	fi
+	return 0
 }
 
 _have_program() {
 	if command -v "$1" >/dev/null 2>&1; then
 		return 0
-	else
-		SKIP_REASON="$1 is not available"
-		return 1
 	fi
+	SKIP_REASON="$1 is not available"
+	return 1
 }
 
 _have_src_program() {
-- 
2.9.5
