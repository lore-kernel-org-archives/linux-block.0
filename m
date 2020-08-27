Return-Path: <SRS0=E5Vf=CF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC9AC433E1
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 19:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625E9207F7
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 19:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="PfEZncNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgH0TtS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:49:18 -0400
Received: from ale.deltatee.com ([204.191.154.188]:54790 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0TtR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 15:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TbglSCmtcusKByd+MVC/aRpDHF4BLLRY+0AJcHvM4e4=; b=PfEZncNMyEFbJJQZktuy1vbXxm
        aFfLZMEV4uilkjxs7kqcPybdXN1QNK4SIjXG3XvFdkoE9/vhxIYdoAYs08nuhk9FpAKjjYeEg9xdQ
        j3+FPqYBSYECt3UnSwhsdnz+mkG4k9mS0/HM5BGdqdI1GXW2JO7BxZpkuVqThdSwZ2kV7NMaZMLwV
        MecavZXVH5JFdR2Yza8ehuvgo8XAKhQLydo4yI6kxgUT+TeP5mqYTQuMDgPqecBz4U1+GOUh3uKxs
        m1Ti2iMOy6l5+S0XC3RC28fsEtVvT7J4cEvHEO9DWQCOmN/PYiQK16A+eFylAT4BS35MvbBdlf7RQ
        /9rN+m/A==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kBNta-0000Cf-Tu; Thu, 27 Aug 2020 13:49:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kBNtZ-0001bz-VJ; Thu, 27 Aug 2020 13:49:13 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 27 Aug 2020 13:49:04 -0600
Message-Id: <20200827194912.6135-4-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827194912.6135-1-logang@deltatee.com>
References: <20200827194912.6135-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests 03/11] common/xfs: Create common helper to verify block device with xfs
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make a common helper from the code in tests nvme/012 and nvme/013
to run an fio verify on a XFS file system backed by the
specified block device.

While we are at it, all the output is redirected to $FULL instead of
/dev/null.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 common/xfs     | 22 ++++++++++++++++++++++
 tests/nvme/012 | 14 +-------------
 tests/nvme/013 | 14 +-------------
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/common/xfs b/common/xfs
index d1a603b8c7b5..210c924cdd41 100644
--- a/common/xfs
+++ b/common/xfs
@@ -9,3 +9,25 @@
 _have_xfs() {
 	_have_fs xfs && _have_program mkfs.xfs
 }
+
+_xfs_mkfs_and_mount() {
+	local bdev=$1
+	local mount_dir=$2
+
+	mkdir -p "${mount_dir}"
+	umount "${mount_dir}"
+	mkfs.xfs -l size=32m -f "${bdev}"
+	mount "${bdev}" "${mount_dir}"
+}
+
+_xfs_run_fio_verify_io() {
+	local mount_dir="/mnt/blktests"
+	local bdev=$1
+
+	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1
+
+	_run_fio_verify_io --size=950m --directory="${mount_dir}/"
+
+	umount "${mount_dir}" >> "${FULL}" 2>&1
+	rm -fr "${mount_dir}"
+}
diff --git a/tests/nvme/012 b/tests/nvme/012
index 981e7779e21d..1dae795d17ac 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -23,12 +23,9 @@ test() {
 	local port
 	local nvmedev
 	local loop_dev
-	local mount_dir="/mnt/blktests"
 	local file_path="${TMPDIR}/img"
 	local subsys_name="blktests-subsystem-1"
 
-	mkdir -p "${mount_dir}" > /dev/null 2>&1
-
 	truncate -s 1G "${file_path}"
 
 	loop_dev="$(losetup -f --show "${file_path}")"
@@ -44,15 +41,7 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	umount ${mount_dir} > /dev/null 2>&1
-
-	mkfs.xfs -l size=32m -f /dev/"${nvmedev}n1" > /dev/null 2>&1
-
-	mount /dev/"${nvmedev}n1" "${mount_dir}"
-
-	_run_fio_verify_io --size=950m --directory="${mount_dir}/"
-
-	umount "${mount_dir}" > /dev/null 2>&1
+	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
 
 	nvme disconnect -n "${subsys_name}"
 
@@ -63,7 +52,6 @@ test() {
 	losetup -d "${loop_dev}"
 
 	rm "${file_path}"
-	rm -fr "${mount_dir}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/013 b/tests/nvme/013
index 228fab9ff02b..c7b0f16ef504 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -22,13 +22,10 @@ test() {
 
 	local port
 	local nvmedev
-	local mount_dir="/mnt/blktests/"
 	local file_path="${TMPDIR}/img"
 
 	local subsys_name="blktests-subsystem-1"
 
-	mkdir -p "${mount_dir}" > /dev/null 2>&1
-
 	truncate -s 1G "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
@@ -42,15 +39,7 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	umount ${mount_dir} > /dev/null 2>&1
-
-	mkfs.xfs -l size=32m -f /dev/"${nvmedev}n1" > /dev/null 2>&1
-
-	mount /dev/"${nvmedev}n1" "${mount_dir}"
-
-	_run_fio_verify_io --size=800m --directory="${mount_dir}/"
-
-	umount "${mount_dir}" > /dev/null 2>&1
+	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
 
 	nvme disconnect -n "${subsys_name}"
 
@@ -59,7 +48,6 @@ test() {
 	_remove_nvmet_port "${port}"
 
 	rm "${file_path}"
-	rm -fr "${mount_dir}"
 
 	echo "Test complete"
 }
-- 
2.20.1

