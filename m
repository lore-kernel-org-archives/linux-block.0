Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751840AbeDQJEX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Apr 2018 05:04:23 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3H91BXL110814
        for <linux-block@vger.kernel.org>; Tue, 17 Apr 2018 05:04:23 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hdb50g1fn-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 17 Apr 2018 05:04:22 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <maier@linux.ibm.com>;
        Tue, 17 Apr 2018 10:04:20 +0100
From: Steffen Maier <maier@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: Steffen Maier <maier@linux.ibm.com>, linux-scsi@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Lee Duncan <lduncan@suse.com>
Subject: [PATCH blktests] scsi/004: add regression test for false BLK_STS_OK with non good SAM status
Date: Tue, 17 Apr 2018 11:03:37 +0200
To: linux-block@vger.kernel.org
Message-Id: <1523955817-15790-1-git-send-email-maier@linux.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 tests/scsi/004     |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/scsi/004.out |    3 ++
 2 files changed, 62 insertions(+), 0 deletions(-)
 create mode 100755 tests/scsi/004
 create mode 100644 tests/scsi/004.out

diff --git a/tests/scsi/004 b/tests/scsi/004
new file mode 100755
index 0000000..4852efc
--- /dev/null
+++ b/tests/scsi/004
@@ -0,0 +1,59 @@
+#!/bin/bash
+#
+# Ensure repeated SAM_STAT_TASK_SET_FULL results in EIO on timing out command.
+#
+# Regression test for commit cbe095e2b584 ("Revert "scsi: core: return
+# BLK_STS_OK for DID_OK in __scsi_error_from_host_byte()"")
+#
+# Found independently of corresponding commit mail threads while
+# experimenting with storage mirroring. This test is a storage-independent
+# reproducer for the error case I ran into.
+#
+# Copyright IBM Corp. 2018
+# Author: Steffen Maier <maier@linux.ibm.com>
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 3 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+
+. common/scsi_debug
+
+DESCRIPTION="ensure repeated TASK SET FULL results in EIO on timing out command"
+
+requires() {
+	_have_scsi_debug
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	if ! _init_scsi_debug add_host=1 max_luns=1 statistics=1 every_nth=1; then
+	    return 1
+	fi
+	# every_nth RW with full queue gets SAM_STAT_TASK_SET_FULL
+	echo 0x800 > /sys/bus/pseudo/drivers/scsi_debug/opts
+	# delay to reduce response repetition: around 1..10sec depending on HZ
+	echo 1000 > /sys/bus/pseudo/drivers/scsi_debug/delay
+	# a single command fills device queue to satisfy 0x800 opts condition
+	echo 1 > "/sys/block/${SCSI_DEBUG_DEVICES[0]}/device/queue_depth"
+	dd if="/dev/${SCSI_DEBUG_DEVICES[0]}" iflag=direct of=/dev/null bs=512 count=1 |& grep -o "Input/output error"
+	# stop injection
+	echo 0 > /sys/bus/pseudo/drivers/scsi_debug/opts
+	# dd closing SCSI disk causes implicit TUR also being delayed once
+	while grep -q -F "in_use_bm BUSY:" "/proc/scsi/scsi_debug/${SCSI_DEBUG_HOSTS[0]}"; do
+		sleep 1
+	done
+	echo 1 > /sys/bus/pseudo/drivers/scsi_debug/delay
+	_exit_scsi_debug
+
+	echo "Test complete"
+}
diff --git a/tests/scsi/004.out b/tests/scsi/004.out
new file mode 100644
index 0000000..b1126fb
--- /dev/null
+++ b/tests/scsi/004.out
@@ -0,0 +1,3 @@
+Running scsi/004
+Input/output error
+Test complete
-- 
1.7.1
