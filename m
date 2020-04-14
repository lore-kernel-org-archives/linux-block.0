Return-Path: <SRS0=NWvS=56=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72CAC38A29
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 22:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7FE2076A
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 22:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634290AbgDNWMb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Apr 2020 18:12:31 -0400
Received: from charlie.dont.surf ([128.199.63.193]:36576 "EHLO
        charlie.dont.surf" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634282AbgDNWME (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Apr 2020 18:12:04 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by charlie.dont.surf (Postfix) with ESMTPSA id 21A20BF7D5;
        Tue, 14 Apr 2020 22:12:01 +0000 (UTC)
From:   Klaus Jensen <its@irrelevant.dk>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Klaus Jensen <its@irrelevant.dk>
Subject: [PATCH blktests] Fix unintended skipping of tests
Date:   Wed, 15 Apr 2020 00:11:51 +0200
Message-Id: <20200414221151.449946-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Klaus Jensen <k.jensen@samsung.com>

cd11d001fe86 ("Support skipping tests from test{,_device}()") breaks a
handful of tests in the block group.

For example, block/005 uses _test_dev_is_rotational to check if the
device is rotational and uses the result to size up the fio run. As a
side-effect, _test_dev_is_rotational also sets SKIP_REASON, which (since
commit cd11d001fe86) causes the test to print out a "[not run]" even
through the test actually ran successfully.

Fix this by adding a _dev_is_rotational function and amend the affected
tests to use it.

Fixes: cd11d001fe86 ("Support skipping tests from test{,_device}()")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 common/rc       | 9 ++++++++-
 tests/block/005 | 2 +-
 tests/block/007 | 2 +-
 tests/block/008 | 2 +-
 tests/block/011 | 2 +-
 5 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/common/rc b/common/rc
index 1893dda2b2f7..04755ca6b018 100644
--- a/common/rc
+++ b/common/rc
@@ -181,6 +181,13 @@ _have_tracepoint() {
 	return 0
 }
 
+_dev_is_rotational() {
+	if [[ $(cat "${TEST_DEV_SYSFS}/queue/rotational") -eq 0 ]]; then
+		return 1
+	fi
+	return 0
+}
+
 _test_dev_can_discard() {
 	if [[ $(cat "${TEST_DEV_SYSFS}/queue/discard_max_bytes") -eq 0 ]]; then
 		SKIP_REASON="$TEST_DEV does not support discard"
@@ -190,7 +197,7 @@ _test_dev_can_discard() {
 }
 
 _test_dev_is_rotational() {
-	if [[ $(cat "${TEST_DEV_SYSFS}/queue/rotational") -eq 0 ]]; then
+	if ! _dev_is_rotational; then
 		SKIP_REASON="$TEST_DEV is not rotational"
 		return 1
 	fi
diff --git a/tests/block/005 b/tests/block/005
index 77b9e2f57203..35c21d5c368a 100755
--- a/tests/block/005
+++ b/tests/block/005
@@ -21,7 +21,7 @@ test_device() {
 	# shellcheck disable=SC2207
 	scheds=($(sed 's/[][]//g' "${TEST_DEV_SYSFS}/queue/scheduler"))
 
-	if _test_dev_is_rotational; then
+	if _dev_is_rotational; then
 		size="32m"
 	else
 		size="1g"
diff --git a/tests/block/007 b/tests/block/007
index f03935084ce6..6cffc453c1fa 100755
--- a/tests/block/007
+++ b/tests/block/007
@@ -19,7 +19,7 @@ device_requires() {
 }
 
 run_fio_job() {
-	if _test_dev_is_rotational; then
+	if _dev_is_rotational; then
 		size="32m"
 	else
 		size="1g"
diff --git a/tests/block/008 b/tests/block/008
index 3d3fcb51be2e..d63c6b0fee2b 100755
--- a/tests/block/008
+++ b/tests/block/008
@@ -17,7 +17,7 @@ requires() {
 test_device() {
 	echo "Running ${TEST_NAME}"
 
-	if _test_dev_is_rotational; then
+	if _dev_is_rotational; then
 		size="32m"
 	else
 		size="1g"
diff --git a/tests/block/011 b/tests/block/011
index c3432a63e274..50beb9b94095 100755
--- a/tests/block/011
+++ b/tests/block/011
@@ -23,7 +23,7 @@ test_device() {
 
 	pdev="$(_get_pci_dev_from_blkdev)"
 
-	if _test_dev_is_rotational; then
+	if _dev_is_rotational; then
 		size="32m"
 	else
 		size="1g"
-- 
2.26.0

