Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7997CE7C4F6
	for <linux-block@archiver.kernel.org>; Wed,  4 Oct 2023 20:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244634AbjJDUUx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Oct 2023 16:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244546AbjJDUUa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Oct 2023 16:20:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA31C1
        for <linux-block@vger.kernel.org>; Wed,  4 Oct 2023 13:20:27 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394KCMBV004454;
        Wed, 4 Oct 2023 20:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=H3GAnxdaWU6YXUbl1Sapn5P/nTcpL6i48TQjNagf5SU=;
 b=Eo4DOtxUkgpfL2v6F2olxLQ7bBpm0Z8tS2b5MK+t62kgPUzexiORVjX77hVFy6t7Q3iD
 uJ+cZSaohZdCeIRMOzLPQmVYl7/pRfsDkGNNIBcOHOH+ltclo8HFKRPu94oOgTjasnPY
 QUUdDouXelXEgvGCf7pvRA4n/0C17zq9oQLcRdR6o92HcSfA9FdUkIsiuzNft85ooKE9
 M3rEwgOPb+05Ru0urcqTZmBaZtTjgqT5OyeIBv7xr6OyWhKYbLFCzkHGAMpSu3mmfiyj
 nYCkA4epbSVMdpN50uAyyTe2omNnELDCsUZ0upa1WqwF75N5HXQ9bqbBoa1rPbBXUJn+ 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thevgg5r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 20:20:01 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 394KD9Le005747;
        Wed, 4 Oct 2023 20:20:01 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thevgg5qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 20:20:01 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 394JcMNf005859;
        Wed, 4 Oct 2023 20:20:00 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tex0t3vv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 20:20:00 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 394KJx3C34734638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Oct 2023 20:19:59 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 898BD58059;
        Wed,  4 Oct 2023 20:19:59 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D792C58055;
        Wed,  4 Oct 2023 20:19:58 +0000 (GMT)
Received: from rhel-laptop.ibm.com (unknown [9.61.54.52])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  4 Oct 2023 20:19:58 +0000 (GMT)
From:   gjoyce@linux.vnet.ibm.com
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        nayna@linux.ibm.com, akpm@linux-foundation.org,
        gjoyce@linux.vnet.ibm.com, ndesaulniers@google.com,
        nathan@kernel.org, jarkko@kernel.org, okozina@redhat.com
Subject: [PATCH v8 1/3] block:sed-opal: SED Opal keystore
Date:   Wed,  4 Oct 2023 15:19:55 -0500
Message-Id: <20231004201957.1451669-2-gjoyce@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231004201957.1451669-1-gjoyce@linux.vnet.ibm.com>
References: <20231004201957.1451669-1-gjoyce@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4Si9UprvJzwhr4tUr1rquv1oOCfKKGCx
X-Proofpoint-GUID: 6X2j_zO2KXDdLoPzEDoXsNbr33qAlZLT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_10,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=605 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040148
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Greg Joyce <gjoyce@linux.vnet.ibm.com>

Add read and write functions that allow SED Opal keys to stored
in a permanent keystore.

Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
 include/linux/sed-opal-key.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 include/linux/sed-opal-key.h

diff --git a/include/linux/sed-opal-key.h b/include/linux/sed-opal-key.h
new file mode 100644
index 000000000000..0ca03054e8f6
--- /dev/null
+++ b/include/linux/sed-opal-key.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SED key operations.
+ *
+ * Copyright (C) 2023 IBM Corporation
+ *
+ * These are the accessor functions (read/write) for SED Opal
+ * keys. Specific keystores can provide overrides.
+ *
+ */
+
+#include <linux/kernel.h>
+
+#ifdef CONFIG_PSERIES_PLPKS_SED
+int sed_read_key(char *keyname, char *key, u_int *keylen);
+int sed_write_key(char *keyname, char *key, u_int keylen);
+#else
+static inline
+int sed_read_key(char *keyname, char *key, u_int *keylen) {
+	return -EOPNOTSUPP;
+}
+static inline
+int sed_write_key(char *keyname, char *key, u_int keylen) {
+	return -EOPNOTSUPP;
+}
+#endif
-- 
gjoyce@linux.vnet.ibm.com

