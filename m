Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B89C433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 02:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiKBC6w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 22:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiKBC6v (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 22:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708CB22B0D
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 19:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667357874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C9JpiXbhyFkNGKhMyn02ZG+LNY6lgQjj9R+rEZcAN+U=;
        b=XB2Y45EfXRrS51kpgb7OHVEgzkDk5V7xo6Tu4wrbSEi91/8+d8VCx00ntb6WOkVY4rQ8+d
        RSGZMRR8L8oei59OUDGMr56POvct+5FbYNTKArsGII6rc/5kfaoQFFT9Ent5kJ/+NRHFSg
        lZr/gkpBr3j89hO5vTDN341kdTZqMCY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-eL_0t7YDMCm8obpFB8VBuQ-1; Tue, 01 Nov 2022 22:57:53 -0400
X-MC-Unique: eL_0t7YDMCm8obpFB8VBuQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C919101A52A;
        Wed,  2 Nov 2022 02:57:53 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7084C422A9;
        Wed,  2 Nov 2022 02:57:51 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     shinichiro.kawasaki@wdc.com
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org
Subject: [PATCH V2 blktests 3/3] nvme/012,013,035: change fio I/O size and move size definition place
Date:   Wed,  2 Nov 2022 10:57:02 +0800
Message-Id: <20221102025702.1664101-4-yi.zhang@redhat.com>
In-Reply-To: <20221102025702.1664101-1-yi.zhang@redhat.com>
References: <20221102025702.1664101-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change fio I/O size of nvme/012,013,035 from 950m to 900m, since recent change
increased the xfs log size and it caused fio failure with I/O size 950m.

Also add size parameter to _run_fio_verify_io. This allows to move the fio I/O
size definition from common/xfs to the test case, so that device size and fio
I/O size are both defined at single place.

Link: https://lore.kernel.org/linux-block/20221019051244.810755-1-yi.zhang@redhat.com/
Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 common/xfs     | 3 ++-
 tests/nvme/012 | 2 +-
 tests/nvme/013 | 2 +-
 tests/nvme/035 | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

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
index e8581ef..d169e35 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -32,7 +32,7 @@ test_device() {
 	port=$(_nvmet_passthru_target_setup "${subsys}")
 	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
 
-	_xfs_run_fio_verify_io "${nsdev}"
+	_xfs_run_fio_verify_io "${nsdev}" "900m"
 
 	_nvme_disconnect_subsys "${subsys}"
 	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
-- 
2.34.1

