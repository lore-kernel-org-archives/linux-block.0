Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD3CC38A2D
	for <linux-block@archiver.kernel.org>; Mon, 24 Oct 2022 06:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiJXGPm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 02:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJXGPK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 02:15:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DAEF1A
        for <linux-block@vger.kernel.org>; Sun, 23 Oct 2022 23:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666592066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M0gXq1Lc71bTwl8oDci+aZ7NB8vliFVN2WVxtP9Rj4k=;
        b=QxwjtPPOEb+81PG5SALUw9EbX/7GCLjpBK4hxcneZct5xrSMLVuD9Lo7Kwb76tRrwy04/s
        yAiF7Czx9bGl5b02VHGPK8rWhAYL7joQXjW8hH5kRkzSMu1mUwxxM3NQWBj18xKzmhWDnD
        tv9IiiHAPP3MhYgYviAoCxBJVueUPAk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-H4MDlhpiP7y4DM5yEBu5mw-1; Mon, 24 Oct 2022 02:14:22 -0400
X-MC-Unique: H4MDlhpiP7y4DM5yEBu5mw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FB403C0D180;
        Mon, 24 Oct 2022 06:14:22 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB8CE2028E94;
        Mon, 24 Oct 2022 06:14:20 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 3/3] common/xfs: update _xfs_run_fio_verify_io to accept the size parameter
Date:   Mon, 24 Oct 2022 14:13:19 +0800
Message-Id: <20221024061319.1133470-4-yi.zhang@redhat.com>
In-Reply-To: <20221024061319.1133470-1-yi.zhang@redhat.com>
References: <20221024061319.1133470-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This commit alo updated nvme/012 nvme/013 nvme/035 to pass the size
parameter to _xfs_run_fio_verify_io

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 common/xfs     | 3 ++-
 tests/nvme/012 | 2 +-
 tests/nvme/013 | 2 +-
 tests/nvme/035 | 9 ++++++++-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/common/xfs b/common/xfs
index 846a5ef..2c5d961 100644
--- a/common/xfs
+++ b/common/xfs
@@ -23,10 +23,11 @@ _xfs_mkfs_and_mount() {
 _xfs_run_fio_verify_io() {
 	local mount_dir="/mnt/blktests"
 	local bdev=$1
+	local sz=$2
 
 	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1
 
-	_run_fio_verify_io --size=950m --directory="${mount_dir}/"
+	_run_fio_verify_io --size="$sz" --directory="${mount_dir}/"
 
 	umount "${mount_dir}" >> "${FULL}" 2>&1
 	rm -fr "${mount_dir}"
diff --git a/tests/nvme/012 b/tests/nvme/012
index c9d2438..e60082c 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -44,7 +44,7 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
+	_xfs_run_fio_verify_io "/dev/${nvmedev}n1" "900m"
 
 	_nvme_disconnect_subsys "${subsys_name}"
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index 265b696..9d60a7d 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -41,7 +41,7 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
+	_xfs_run_fio_verify_io "/dev/${nvmedev}n1" "900m"
 
 	_nvme_disconnect_subsys "${subsys_name}"
 
diff --git a/tests/nvme/035 b/tests/nvme/035
index ee78a75..31de0d1 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -21,14 +21,21 @@ test_device() {
 	local ctrldev
 	local nsdev
 	local port
+	local test_dev_sz
 
 	echo "Running ${TEST_NAME}"
 
 	_setup_nvmet
 	port=$(_nvmet_passthru_target_setup "${subsys}")
 	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
+	test_dev_sz=$(_get_test_dev_size_mb)
 
-	_xfs_run_fio_verify_io "${nsdev}"
+	if (( "$test_dev_sz" < 1024 )); then
+		echo "Test dev: $TEST_DEV should at leat 1024m"
+		return 1
+
+	fi
+	_xfs_run_fio_verify_io "${nsdev}" "900m"
 
 	_nvme_disconnect_subsys "${subsys}"
 	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
-- 
2.34.1

