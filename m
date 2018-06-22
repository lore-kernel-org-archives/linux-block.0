Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59818 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933738AbeFVWTs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jun 2018 18:19:48 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH blktests 02/15] Annotate include statements in shell scripts where the source file is a variable
Date: Fri, 22 Jun 2018 15:19:33 -0700
Message-Id: <20180622221946.10987-3-bart.vanassche@wdc.com>
In-Reply-To: <20180622221946.10987-1-bart.vanassche@wdc.com>
References: <20180622221946.10987-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This causes shellcheck to stop complaining about these include statements.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 check | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/check b/check
index 4baa8dde2436..5e1ba7bc8401 100755
--- a/check
+++ b/check
@@ -23,6 +23,7 @@ _found_test() {
 
 	unset DESCRIPTION QUICK TIMED requires device_requires test test_device
 
+	# shellcheck disable=SC1090
 	if ! . "tests/${test_name}"; then
 		return 1
 	fi
@@ -392,6 +393,7 @@ _run_test() {
 	CHECK_DMESG=1
 	DMESG_FILTER=cat
 
+	# shellcheck disable=SC1090
 	. "tests/${TEST_NAME}"
 
 	if declare -fF test >/dev/null; then
@@ -432,6 +434,7 @@ _run_group() {
 	local tests=("$@")
 	local group="${tests[0]%/*}"
 
+	# shellcheck disable=SC1090
 	. "tests/${group}/group"
 
 	if declare -fF group_requires >/dev/null && ! group_requires; then
-- 
2.17.1
