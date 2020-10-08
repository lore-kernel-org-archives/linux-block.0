Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F85C43457
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 16:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF7F221F1
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 16:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="jNX5k7Wl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgJHQlM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 12:41:12 -0400
Received: from ale.deltatee.com ([204.191.154.188]:48798 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgJHQke (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Oct 2020 12:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6OG5y6dqCpzubmOr4AhBg3Vthy6MFMXRPZfk6ASRz7I=; b=jNX5k7WlCE0yZBTiSD8fVqsX1d
        xRzk0YoEdrAnVg8SJyjNLiC0ru9ywM+GHMQFsk6e6ogdLKEQt4qseG7weNyC+Hq78jv6BTQJKnmPn
        tofsvQ0IOwJMcgpBDrOmV3pQppOj1fXJWTvEdZsKuZ09Ta8N7o3zW3H2/wuvWO92IGsmZ8ikeR8I6
        XXn/hmoCSUnKMktYayCLkgiYi5Gf9qaUYuElkG2Nai2YzAnqcd547zJOnI18W/+4BtHhEnKHHkvYV
        rvaZExb/phIZBg4+vkKXWAsyDdyTLZ54IB41BmpmFoqE4nwH9oyjfMP0/1Xptc2C9Z4MDlPIYUl80
        juOgWODg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kQYxz-0000ik-Pp; Thu, 08 Oct 2020 10:40:33 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kQYxz-0003HO-2s; Thu, 08 Oct 2020 10:40:31 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  8 Oct 2020 10:40:16 -0600
Message-Id: <20201008164024.12546-4-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008164024.12546-1-logang@deltatee.com>
References: <20201008164024.12546-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests v3 03/11] common/xfs: Create common helper to verify block device with xfs
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
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
index 1d8d8e3cc271..a13cd08ce6bf 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -26,12 +26,9 @@ test() {
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
@@ -47,15 +44,7 @@ test() {
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
 
 	_nvme_disconnect_subsys "${subsys_name}"
 
@@ -66,7 +55,6 @@ test() {
 	losetup -d "${loop_dev}"
 
 	rm "${file_path}"
-	rm -fr "${mount_dir}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/013 b/tests/nvme/013
index 3819a2730d9b..1ac725ea83f2 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -24,13 +24,10 @@ test() {
 
 	local port
 	local nvmedev
-	local mount_dir="/mnt/blktests/"
 	local file_path="${TMPDIR}/img"
 
 	local subsys_name="blktests-subsystem-1"
 
-	mkdir -p "${mount_dir}" > /dev/null 2>&1
-
 	truncate -s 1G "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
@@ -44,15 +41,7 @@ test() {
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
 
 	_nvme_disconnect_subsys "${subsys_name}"
 
@@ -61,7 +50,6 @@ test() {
 	_remove_nvmet_port "${port}"
 
 	rm "${file_path}"
-	rm -fr "${mount_dir}"
 
 	echo "Test complete"
 }
-- 
2.20.1

