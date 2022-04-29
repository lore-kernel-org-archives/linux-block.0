Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB7FC433F5
	for <linux-block@archiver.kernel.org>; Fri, 29 Apr 2022 22:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbiD2WNd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Apr 2022 18:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381343AbiD2WNd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Apr 2022 18:13:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A106320
        for <linux-block@vger.kernel.org>; Fri, 29 Apr 2022 15:10:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TLe7S9018603;
        Fri, 29 Apr 2022 22:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=7oU0BjBbIH4bWDeznY9F7cAZOpX1StOpO0ybGAm0ECc=;
 b=wOmx4x0QE+6wxV4LBnI4UvxZ/IP5qMEhVTWZVAj9S0xVEeJFQEZ0TMkWFrohnSx97UFF
 /2GFx8M7JBsamuAV5U7YB49lcA4eR/CyayosbQGRnA4rVC5b0VF0wclo9NwneY2WxdLn
 V6Ic/RTNW6uJek+VNtbgfeLMjXxZhwsNyXxRkwCCqQ5gc208OUWC8Z6DkF7EMIUg1Ie5
 kMlFYbC1Img5MgTWqyE6y4bquvtfpUpoe1oZfYCwNl0p2HhBAJXaQHzTu/80CsK2tpBE
 flKgu6Dx9RWsaHfKPxMiZHygYQc80WERZs5PWXcFDEi9Dsah7q+SU7wP+fCjtKVaa0uB WQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5k8096-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 22:09:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23TLujim019187;
        Fri, 29 Apr 2022 22:09:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yqnrv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 22:09:59 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 23TM9wwZ010219;
        Fri, 29 Apr 2022 22:09:58 GMT
Received: from dhcp-10-159-244-56.vpn.oracle.com (dhcp-10-159-244-56.vpn.oracle.com [10.159.244.56])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yqnru6-1;
        Fri, 29 Apr 2022 22:09:58 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     alan.adamson@oracle.com, linux-nvme@lists.infradead.org,
        osandov@fb.com
Subject: [PATCH blktests] tests/nvme: add tests for error logging
Date:   Fri, 29 Apr 2022 15:09:46 -0700
Message-Id: <20220429220946.22099-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: n3h_dZIpD33FFYfExSZRIPjEeKeu70f5
X-Proofpoint-ORIG-GUID: n3h_dZIpD33FFYfExSZRIPjEeKeu70f5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Test nvme error logging by injecting errors. Kernel must have FAULT_INJECTION
and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can be
run with or without NVME_VERBOSE_ERRORS configured.

These test verify the functionality delivered by the follow commit:
        nvme: add verbose error logging

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 tests/nvme/039     | 174 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/039.out |   7 ++
 2 files changed, 181 insertions(+)
 create mode 100755 tests/nvme/039
 create mode 100644 tests/nvme/039.out

diff --git a/tests/nvme/039 b/tests/nvme/039
new file mode 100755
index 000000000000..e30de0731247
--- /dev/null
+++ b/tests/nvme/039
@@ -0,0 +1,174 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Oracle and/or its affiliates
+#
+# Test nvme error logging by injecting errors. Kernel must have FAULT_INJECTION
+# and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can be
+# run with or without NVME_VERBOSE_ERRORS configured.
+
+. tests/nvme/rc
+DESCRIPTION="test error logging"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_kernel_option FAULT_INJECTION && \
+	    _have_kernel_option FAULT_INJECTION_DEBUG_FS
+	_have_program dd && _have_program nvme _have_program sed
+	_require_nvme_trtype_is_loop
+}
+
+save_err_inject_attr()
+{
+	ns_dev_verbose_save=$(cat /sys/kernel/debug/"${ns_dev}"/fault_inject/verbose)
+	ns_dev_probability_save=$(cat /sys/kernel/debug/"${ns_dev}"/fault_inject/probability)
+	ns_dev_dont_retry_save=$(cat /sys/kernel/debug/"${ns_dev}"/fault_inject/dont_retry)
+	ns_dev_dont_status_save=$(cat /sys/kernel/debug/"${ns_dev}"/fault_inject/status)
+	ns_dev_dont_times_save=$(cat /sys/kernel/debug/"${ns_dev}"/fault_inject/times)
+	ctrl_dev_verbose_save=$(cat /sys/kernel/debug/"${ctrl_dev}"/fault_inject/verbose)
+	ctrl_dev_probability_save=$(cat /sys/kernel/debug/"${ctrl_dev}"/fault_inject/probability)
+	ctrl_dev_dont_retry_save=$(cat /sys/kernel/debug/"${ctrl_dev}"/fault_inject/dont_retry)
+	ctrl_dev_dont_status_save=$(cat /sys/kernel/debug/"${ctrl_dev}"/fault_inject/status)
+	ctrl_dev_dont_times_save=$(cat /sys/kernel/debug/"${ctrl_dev}"/fault_inject/times)
+}
+
+restore_error_inject_attr()
+{
+	echo "${ns_dev_verbose_save}" > /sys/kernel/debug/"${ns_dev}"/fault_inject/verbose
+	echo "${ns_dev_verbose_save}" > /sys/kernel/debug/"${ns_dev}"/fault_inject/verbose
+	echo "${ns_dev_probability_save}" > /sys/kernel/debug/"${ns_dev}"/fault_inject/probability
+	echo "${ns_dev_dont_retry_save}" > /sys/kernel/debug/"${ns_dev}"/fault_inject/dont_retry
+	echo "${ns_dev_dont_status_save}" > /sys/kernel/debug/"${ns_dev}"/fault_inject/status
+	echo "${ns_dev_dont_times_save}" > /sys/kernel/debug/"${ns_dev}"/fault_inject/times
+	echo "${ctrl_dev_verbose_save}" > /sys/kernel/debug/"${ctrl_dev}"/fault_inject/verbose 
+	echo "${ctrl_dev_probability_save}" > /sys/kernel/debug/"${ctrl_dev}"/fault_inject/probability
+	echo "${ctrl_dev_dont_retry_save}" > /sys/kernel/debug/"${ctrl_dev}"/fault_inject/dont_retry
+	echo "${ctrl_dev_dont_status_save}" > /sys/kernel/debug/"${ctrl_dev}"/fault_inject/status
+	echo "${ctrl_dev_dont_times_save}" > /sys/kernel/debug/"${ctrl_dev}"/fault_inject/times
+}
+
+set_verbose_prob_retry()
+{
+	echo 0 > /sys/kernel/debug/"$1"/fault_inject/verbose
+	echo 100 > /sys/kernel/debug/"$1"/fault_inject/probability
+	echo 1 > /sys/kernel/debug/"$1"/fault_inject/dont_retry
+}
+
+set_status_time()
+{
+	echo "$1" > /sys/kernel/debug/"$3"/fault_inject/status
+	echo "$2" > /sys/kernel/debug/"$3"/fault_inject/times
+}
+
+inject_unrec_read_err()
+{
+	set_verbose_prob_retry "${ns_dev}"
+#	Inject a 'Unrecovered Read Error' error on a READ
+	set_status_time 0x281 1 "${ns_dev}"
+	dd if="${TEST_DEV}" of=/dev/null bs=512 count=1 iflag=direct 2> /dev/null 1>&2
+	if ${nvme_verbose_errors}; then
+		dmesg -t | tail -2 | grep "Unrecovered Read Error (" | \
+		    sed 's/nvme.*://g'
+	else
+		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
+		    sed 's/I\/O Error/Unrecovered Read Error/g' | \
+		    sed 's/nvme.*://g'
+	fi
+}
+
+inject_invalid_read_err()
+{
+#	Inject a valid invalid error status (0x375) on a READ
+	set_status_time 0x375 1 "${ns_dev}"
+	dd if="${TEST_DEV}" of=/dev/null bs=512 count=1 iflag=direct 2> /dev/null 1>&2
+	if ${nvme_verbose_errors}; then
+		dmesg -t | tail -2 | grep "Unknown (" | \
+		    sed 's/nvme.*://g'
+	else
+		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
+		    sed 's/I\/O Error/Unknown/g' | \
+		    sed 's/nvme.*://g'
+	fi
+}
+
+inject_write_fault()
+{
+#	Inject a 'Write Fault' error on a WRITE
+	set_status_time 0x280 1 "${ns_dev}"
+	dd if=/dev/zero of="${TEST_DEV}" bs=512 count=1 oflag=direct 2> /dev/null 1>&2
+	if ${nvme_verbose_errors}; then
+		dmesg -t | tail -2 | grep "Write Fault (" | \
+		    sed 's/nvme.*://g'
+	else
+		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Write/g' | \
+		    sed 's/I\/O Error/Write Fault/g' | \
+		    sed 's/nvme.*://g'
+	fi
+}
+
+inject_id_admin()
+{
+#	Inject a valid (Identify) Admin command
+	set_status_time 0x286 1000 "${ctrl_dev}"
+	nvme admin-passthru /dev/"${ctrl_dev}" --opcode=0x06 --data-len=4096 --cdw10=1 -r 2> /dev/null 1>&2
+	if ${nvme_verbose_errors}; then
+		dmesg -t | tail -1 | grep "Access Denied (" | \
+		    sed 's/nvme.*://g'
+	else
+		dmesg -t | tail -1 | grep "Admin Cmd(" | sed 's/Admin Cmd/Identify/g' | \
+		    sed 's/I\/O Error/Access Denied/g' | \
+		    sed 's/nvme.*://g'
+	fi
+}
+
+inject_invalid_cmd()
+{
+#	Inject an invalid command (0x96)
+	set_status_time 0x1 1 "${ctrl_dev}"
+	nvme admin-passthru /dev/"${ctrl_dev}" --opcode=0x96 --data-len=4096 --cdw10=1 -r 2> /dev/null 1>&2
+	if ${nvme_verbose_errors}; then
+		dmesg -t | tail -1 | grep "Invalid Command Opcode (" | \
+		    sed 's/nvme.*://g'
+	else
+		dmesg -t | tail -1 | grep "Admin Cmd(" | sed 's/Admin Cmd/Unknown/g' | \
+		    sed 's/I\/O Error/Invalid Command Opcode/g' | \
+		    sed 's/nvme.*://g'
+	fi
+}
+
+test_device() {
+	local nvme_verbose_errors;
+	local ns_dev;
+	local ctrl_dev;
+
+	echo "Running ${TEST_NAME}"
+
+	if _have_kernel_option NVME_VERBOSE_ERRORS; then
+		nvme_verbose_errors=true;
+	else
+		unset SKIP_REASON
+		nvme_verbose_errors=false;
+	fi
+
+	ns_dev=$(echo "${TEST_DEV}" | sed 's/\/dev\///g')
+	ctrl_dev=$(echo "${TEST_DEV}" | sed 's/\/dev\///g' | sed 's/n[0-9]*//2')
+
+#	Save Error Injector Attributes
+	save_err_inject_attr
+
+	inject_unrec_read_err
+
+	inject_invalid_read_err
+
+	inject_write_fault
+
+	set_verbose_prob_retry "${ctrl_dev}"
+	inject_id_admin
+
+	inject_invalid_cmd
+
+#	Restore Error Injector Attributes
+	restore_error_inject_attr
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/039.out b/tests/nvme/039.out
new file mode 100644
index 000000000000..162935eb1d7b
--- /dev/null
+++ b/tests/nvme/039.out
@@ -0,0 +1,7 @@
+Running nvme/039
+ Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR 
+ Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR 
+ Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR 
+ Identify(0x6), Access Denied (sct 0x2 / sc 0x86) DNR 
+ Unknown(0x96), Invalid Command Opcode (sct 0x0 / sc 0x1) DNR 
+Test complete
-- 
2.27.0

