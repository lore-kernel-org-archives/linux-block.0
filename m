Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C963C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 06:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668D62173C
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 06:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfCMGga (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 02:36:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbfCMGga (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 02:36:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 360DC30EEF89
        for <linux-block@vger.kernel.org>; Wed, 13 Mar 2019 06:36:30 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.66.70.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 205B6605AE;
        Wed, 13 Mar 2019 06:36:28 +0000 (UTC)
From:   Xiao Liang <xiliang@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     xiliang@redhat.com
Subject: [PATCH] Fix checking multiple modules error in _have_modules()
Date:   Wed, 13 Mar 2019 14:35:48 +0800
Message-Id: <20190313063548.7624-1-xiliang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 13 Mar 2019 06:36:30 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Xiao Liang <xiliang@redhat.com>
---
 common/rc      | 2 +-
 tests/nvme/002 | 2 +-
 tests/nvme/003 | 2 +-
 tests/nvme/004 | 2 +-
 tests/nvme/015 | 2 +-
 tests/nvme/018 | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/common/rc b/common/rc
index 0c354a2..282d137 100644
--- a/common/rc
+++ b/common/rc
@@ -33,7 +33,7 @@ _have_modules() {
 	local module
 
 	for module in "$@"; do
-		if ! modprobe -n -q "$1"; then
+		if ! modprobe -n -q $module; then
 			missing+=("$module")
 		fi
 	done
diff --git a/tests/nvme/002 b/tests/nvme/002
index 0132ac0..106a5a8 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -10,7 +10,7 @@
 DESCRIPTION="create many subsystems and test discovery"
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop && _have_configfs
+	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs
 }
 
 test() {
diff --git a/tests/nvme/003 b/tests/nvme/003
index f304071..c6b3d40 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -11,7 +11,7 @@ DESCRIPTION="test if we're sending keep-alives to a discovery controller"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop && _have_configfs
+	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs
 }
 
 test() {
diff --git a/tests/nvme/004 b/tests/nvme/004
index 346f309..0506fa2 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -12,7 +12,7 @@ DESCRIPTION="test nvme and nvmet UUID NS descriptors"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop && _have_configfs
+	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs
 }
 
 test() {
diff --git a/tests/nvme/015 b/tests/nvme/015
index 29cf954..47e1b04 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -10,7 +10,7 @@ DESCRIPTION="unit test for NVMe flush for file backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop && _have_configfs
+	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs
 }
 
 test() {
diff --git a/tests/nvme/018 b/tests/nvme/018
index b09c29c..e29fa92 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -11,7 +11,7 @@ DESCRIPTION="unit test NVMe-oF out of range access on a file backend"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules nvme-loop && _have_modules loop && \
+	_have_program nvme && _have_modules loop nvme-loop nvmet && \
 		_have_configfs
 }
 
-- 
2.17.2

