Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43E1C4332F
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 22:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348873AbiEPW4g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 18:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349865AbiEPW4M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 18:56:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE110B1E1
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 15:56:10 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GKmYn0027268;
        Mon, 16 May 2022 22:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=4cSRM56yx314zwddwl96r4nlqQm6Po1u05oEsxosimg=;
 b=PQTQppW1WbRErAzLQMGQpqJDZsjONdhwnhqysU3LYs9ImNT46o4gZhTuS0lltC4pUS+0
 HugauyuuzsREZ90LPAV7my/dqgnGHWMEcdXq4l3r72ZH37TrmEYZdkXRvVMeeejfLHfU
 yCEuft7/ITmgReOSxdrq6IOUSgs5DC/dfcmPnEg7L7ri8U+MGpQe1rK6RfastwombzfS
 i0PAJvE7FUP66jjN92KZJ2Ny6v9lyWLC3dRg3kQdxwAnAkW8dk+nMpL2Oh/xtzJmnVD4
 Pyx88oaFcX/4PML8BfBR+/2QLndB/IUKzt3g9IHXkze8UcTfaCcTu9H1mRq3IzTLzpSj JA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2371vqfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 22:55:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24GMtt2g013381;
        Mon, 16 May 2022 22:55:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v7xv3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 22:55:59 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24GMtul7013443;
        Mon, 16 May 2022 22:55:58 GMT
Received: from dhcp-10-65-131-124.vpn.oracle.com (dhcp-10-65-131-124.vpn.oracle.com [10.65.131.124])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v7xuyu-3;
        Mon, 16 May 2022 22:55:58 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     alan.adamson@oracle.com, linux-nvme@lists.infradead.org,
        osandov@fb.com
Subject: [PATCH v4 blktests 2/2] tests/nvme: add tests for error logging
Date:   Mon, 16 May 2022 15:55:39 -0700
Message-Id: <20220516225539.81588-3-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220516225539.81588-1-alan.adamson@oracle.com>
References: <20220516225539.81588-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2PTVGG9CHBW_ikiMBQQ9CbrjiEhV5wx6
X-Proofpoint-ORIG-GUID: 2PTVGG9CHBW_ikiMBQQ9CbrjiEhV5wx6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Test nvme error logging by injecting errors. Kernel must have FAULT_INJECTION
and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can be
run with or without NVME_VERBOSE_ERRORS configured.

Test for commit bd83fe6f2cd2 ("nvme: add verbose error logging").

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 tests/nvme/039     | 153 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/039.out |   7 +++
 2 files changed, 160 insertions(+)
 create mode 100755 tests/nvme/039
 create mode 100644 tests/nvme/039.out

diff --git a/tests/nvme/039 b/tests/nvme/039
new file mode 100755
index 000000000000..9ed5059787a3
--- /dev/null
+++ b/tests/nvme/039
@@ -0,0 +1,153 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Oracle and/or its affiliates
+#
+# Test nvme error logging by injecting errors. Kernel must have FAULT_INJECTION
+# and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can be
+# run with or without NVME_VERBOSE_ERRORS configured.
+#
+# Test for commit bd83fe6f2cd2 ("nvme: add verbose error logging").
+
+. tests/nvme/rc
+DESCRIPTION="test error logging"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_kernel_option FAULT_INJECTION && \
+	    _have_kernel_option FAULT_INJECTION_DEBUG_FS
+}
+
+inject_unrec_read_on_read()
+{
+	# Inject a 'Unrecovered Read Error' (0x281) status error on a READ
+	_nvme_enable_err_inject "$1" 0 100 1 0x281 1
+
+	dd if=/dev/"$1" of=/dev/null bs=512 count=1 iflag=direct \
+	    2> /dev/null 1>&2
+
+	_nvme_disable_err_inject "$1"
+
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
+inject_invalid_status_on_read()
+{
+	# Inject an invalid status (0x375) on a READ
+	_nvme_enable_err_inject "$1" 0 100 1 0x375 1
+
+	dd if=/dev/"$1" of=/dev/null bs=512 count=1 iflag=direct \
+	    2> /dev/null 1>&2
+
+	_nvme_disable_err_inject "$1"
+
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
+inject_write_fault_on_write()
+{
+	# Inject a 'Write Fault' 0x280 status error on a WRITE
+	_nvme_enable_err_inject "$1" 0 100 1 0x280 1
+
+	dd if=/dev/zero of=/dev/"$1" bs=512 count=1 oflag=direct \
+	    2> /dev/null 1>&2
+
+	_nvme_disable_err_inject "$1"
+
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
+inject_access_denied_on_identify()
+{
+	# Inject a 'Access Denied' (0x286) status error on an
+	# Identify admin command
+	_nvme_enable_err_inject "$1" 0 100 1 0x286 1
+
+	nvme admin-passthru /dev/"$1" --opcode=0x06 --data-len=4096 \
+	    --cdw10=1 -r 2> /dev/null 1>&2
+
+	_nvme_disable_err_inject "$1"
+
+	if ${nvme_verbose_errors}; then
+		dmesg -t | tail -1 | grep "Access Denied (" | \
+		    sed 's/nvme.*://g'
+	else
+		dmesg -t | tail -1 | grep "Admin Cmd(" | \
+		    sed 's/Admin Cmd/Identify/g' | \
+		    sed 's/I\/O Error/Access Denied/g' | \
+		    sed 's/nvme.*://g'
+	fi
+}
+
+inject_invalid_admin_cmd()
+{
+	# Inject a 'Invalid Command Opcode' (0x1) on an invalid command (0x96)
+	 _nvme_enable_err_inject "$1" 0 100 1 0x1 1
+
+	nvme admin-passthru /dev/"$1" --opcode=0x96 --data-len=4096 \
+	    --cdw10=1 -r 2> /dev/null 1>&2
+
+	_nvme_disable_err_inject "$1"
+
+	if ${nvme_verbose_errors}; then
+		dmesg -t | tail -1 | grep "Invalid Command Opcode (" | \
+		    sed 's/nvme.*://g'
+	else
+		dmesg -t | tail -1 | grep "Admin Cmd(" | \
+		    sed 's/Admin Cmd/Unknown/g' | \
+		    sed 's/I\/O Error/Invalid Command Opcode/g' | \
+		    sed 's/nvme.*://g'
+	fi
+}
+
+test_device() {
+	local nvme_verbose_errors
+	local ns_dev
+	local ctrl_dev
+
+	echo "Running ${TEST_NAME}"
+
+	if _have_kernel_option NVME_VERBOSE_ERRORS; then
+		nvme_verbose_errors=true
+	else
+		unset SKIP_REASON
+		nvme_verbose_errors=false
+	fi
+
+	ns_dev=${TEST_DEV##*/}
+	ctrl_dev=${ns_dev%n*}
+
+	_nvme_err_inject_setup "${ns_dev}" "${ctrl_dev}"
+
+	inject_unrec_read_on_read "${ns_dev}"
+	inject_invalid_status_on_read "${ns_dev}"
+	inject_write_fault_on_write "${ns_dev}"
+
+	inject_access_denied_on_identify "${ctrl_dev}"
+	inject_invalid_admin_cmd "${ctrl_dev}"
+
+	_nvme_err_inject_cleanup "${ns_dev}" "${ctrl_dev}"
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

