Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242A1C43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 01:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED50F206B6
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 01:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfCEBud (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 20:50:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfCEBud (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Mar 2019 20:50:33 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07E80308425B;
        Tue,  5 Mar 2019 01:50:33 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23829600C2;
        Tue,  5 Mar 2019 01:50:29 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2] blktests: add userspace IO test
Date:   Tue,  5 Mar 2019 09:50:26 +0800
Message-Id: <20190305015026.10751-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 05 Mar 2019 01:50:33 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add one test to cover changes on block passthrough IO interface,
such as blk_rq_map_user(), blk_rq_map_user_iov(), blk_rq_unmap_user()
and blk_rq_map_kern().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tests/block/029     | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/block/029.out |   4 ++
 2 files changed, 115 insertions(+)
 create mode 100755 tests/block/029
 create mode 100644 tests/block/029.out

diff --git a/tests/block/029 b/tests/block/029
new file mode 100755
index 000000000000..c7c674464285
--- /dev/null
+++ b/tests/block/029
@@ -0,0 +1,111 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2019 Ming Lei <ming.lei@redhat.com>
+#
+# Test userspace IO on NVMe loop device
+
+. tests/nvme/rc
+
+DESCRIPTION="test userspace IO via nvme-cli read/write interface"
+QUICK=1
+
+requires() {
+	_have_program nvme && _have_modules loop nvme-loop nvmet && \
+		_have_configfs
+}
+
+__test_user_io()
+{
+	local disk="$1"
+	local start=$2
+	local cnt=$3
+
+	local bs=$(blockdev --getss $disk)
+	local size=$(($cnt * $bs))
+
+	local img=`mktemp /tmp/blk_img_XXXXXX`
+	local img1=`mktemp /tmp/blk_img_XXXXXX`
+
+	dd if=/dev/urandom of=$img bs=$bs count=$cnt status=none
+
+	cnt=$(($cnt - 1))
+
+	nvme write --start-block=$start --block-count=$cnt --data-size=$size --data=$img $disk
+	[ $? -ne 0 ] && return -1
+	nvme read --start-block=$start --block-count=$cnt --data-size=$size --data=$img1 $disk
+	[ $? -ne 0 ] && return -1
+
+	diff -q -u $img $img1
+	res=$?
+
+	rm -f $img $img1
+	return $res
+}
+
+test_user_io()
+{
+	local dev="$1"
+
+	__test_user_io $dev 1 512  > "$FULL" 2>&1
+	[ -$? -ne 0 ] && echo "FAIL"
+
+	__test_user_io $dev 1 511  > "$FULL" 2>&1
+	[ -$? -ne 0 ] && echo "FAIL"
+
+	__test_user_io $dev 1 513  > "$FULL" 2>&1
+	[ -$? -ne 0 ] && echo "FAIL"
+
+	__test_user_io $dev 511 1024  > "$FULL" 2>&1
+	[ -$? -ne 0 ] && echo "FAIL"
+
+	__test_user_io $dev 511 1023  > "$FULL" 2>&1
+	[ -$? -ne 0 ] && echo "FAIL"
+
+	__test_user_io $dev 511 1025  > "$FULL" 2>&1
+	[ -$? -ne 0 ] && echo "FAIL"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	modprobe nvmet
+	modprobe nvme-loop
+
+	local port
+	local nvmedev
+	local loop_dev
+	local file_path="$TMPDIR/img"
+	local subsys_name="blktests-subsystem-1"
+
+	truncate -s 1G "${file_path}"
+
+	loop_dev="$(losetup -f --show "${file_path}")"
+
+	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
+		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+	port="$(_create_nvmet_port "loop")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+
+	nvme connect -t loop -n "${subsys_name}"
+
+	nvmedev="$(_find_nvme_loop_dev)"
+	cat "/sys/block/${nvmedev}n1/uuid"
+	cat "/sys/block/${nvmedev}n1/wwid"
+
+	test_user_io "/dev/${nvmedev}n1"
+
+	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_port "${port}"
+
+	losetup -d "${loop_dev}"
+
+	rm "${file_path}"
+
+	modprobe -r nvme-loop
+	modprobe -r nvmet
+
+	echo "Test complete"
+}
diff --git a/tests/block/029.out b/tests/block/029.out
new file mode 100644
index 000000000000..6defa8e84f0a
--- /dev/null
+++ b/tests/block/029.out
@@ -0,0 +1,4 @@
+Running block/029
+91fdba0d-f87b-4c25-b80f-db7be1418b9e
+uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
+Test complete
-- 
2.9.5

