Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09CFC77B73
	for <linux-block@archiver.kernel.org>; Wed, 31 May 2023 01:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjEaBHT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 May 2023 21:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbjEaBHQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2023 21:07:16 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7377210E
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 18:07:11 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="106936045"
X-IronPort-AV: E=Sophos;i="6.00,205,1681138800"; 
   d="scan'208";a="106936045"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 10:07:08 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 86F5EC68E5
        for <linux-block@vger.kernel.org>; Wed, 31 May 2023 10:07:06 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id C292DD5E86
        for <linux-block@vger.kernel.org>; Wed, 31 May 2023 10:07:05 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3A91D68957;
        Wed, 31 May 2023 10:07:05 +0900 (JST)
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     shinichiro.kawasaki@wdc.com
Cc:     linux-block@vger.kernel.org, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH blktests] nvme/{016,017}: use _check_genctr instead of _filter_discovery
Date:   Wed, 31 May 2023 09:07:01 +0800
Message-Id: <1685495221-4598-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27662.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27662.003
X-TMASE-Result: 10--5.136600-10.000000
X-TMASE-MatchedRID: QAAr3LZ6Q9JjQyqvHoYnesYv//yaWh0DMVVFhl7NwvOKq/D4QvW9B+LS
        dVP2tZn5kVyTXkTfaH+12HagvbwDji/7QU2czuUNA9lly13c/gFr2qJoNIuCjeoVFCysx0YEzXI
        BDORx1c/qge/68MGvDXGUYQKLXWQNpoPHQXywp1eeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8h+IC
        quNi0WJFFAWepx2jfDajzDEBOPkHFdf91TjnJLE/NtspA7z/eVftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since commit 328943e3 ("Update tests for discovery log page changes"),
blktests also include the discovery subsystem itself. But it
will lead these cases fails on older nvme-cli system.

To avoid this, like nvme/002, use _check_genctr to check instead of
comparing many discovery Log Entry output.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/nvme/016     | 4 +++-
 tests/nvme/016.out | 7 -------
 tests/nvme/017     | 5 ++++-
 tests/nvme/017.out | 7 -------
 4 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/tests/nvme/016 b/tests/nvme/016
index c0c31a5..f617cf1 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -24,6 +24,7 @@ test() {
 	_setup_nvmet
 
 	loop_dev="$(losetup -f)"
+	local genctr=1
 
 	_create_nvmet_subsystem "${subsys_nqn}" "${loop_dev}"
 
@@ -34,7 +35,8 @@ test() {
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "$port" "${subsys_nqn}"
 
-	_nvme_discover loop | _filter_discovery
+	genctr=$(_check_genctr "${genctr}" "adding a subsystem to a port")
+
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_nqn}"
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/016.out b/tests/nvme/016.out
index ee631a4..fd244d5 100644
--- a/tests/nvme/016.out
+++ b/tests/nvme/016.out
@@ -1,9 +1,2 @@
 Running nvme/016
-Discovery Log Number of Records 2, Generation counter X
-=====Discovery Log Entry 0======
-trtype:  loop
-subnqn:  nqn.2014-08.org.nvmexpress.discovery
-=====Discovery Log Entry 1======
-trtype:  loop
-subnqn:  blktests-subsystem-1
 Test complete
diff --git a/tests/nvme/017 b/tests/nvme/017
index e167450..3dbb7c1 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -27,6 +27,8 @@ test() {
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
+	local genctr=1
+
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 
@@ -37,7 +39,8 @@ test() {
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_discover loop | _filter_discovery
+	genctr=$(_check_genctr "${genctr}" "adding a subsystem to a port")
+
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/017.out b/tests/nvme/017.out
index 12787f7..6ce9a80 100644
--- a/tests/nvme/017.out
+++ b/tests/nvme/017.out
@@ -1,9 +1,2 @@
 Running nvme/017
-Discovery Log Number of Records 2, Generation counter X
-=====Discovery Log Entry 0======
-trtype:  loop
-subnqn:  nqn.2014-08.org.nvmexpress.discovery
-=====Discovery Log Entry 1======
-trtype:  loop
-subnqn:  blktests-subsystem-1
 Test complete
-- 
2.39.1

