Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5615C47423
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 13:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 897722184D
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 13:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gmTS6tU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgJHNNr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 09:13:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729810AbgJHNNn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 09:13:43 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098CWZao140634;
        Thu, 8 Oct 2020 09:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=qBz++3K/F5KsjvjI2n8k626PHO4M9VzBHZW9Axd8MjE=;
 b=gmTS6tU+FiMsf+jf+qlp77LnUO+nsFZ0PnLnnAcn3YDcS/fkicLm0oXqdUUrazP5hz1J
 uymAsufhOvwChDZZZumDSARqm168MoMVJ6PYGUHd7QqeZamL8QXibyC/WUcmLIl1mgej
 MW+Wca/aAEqsPGg4Zl7mHUgaHvSQGrLBw32H0U3mITzK5iCbRgotKkAPxCGM9avHbgv4
 SCxk9Ofh2Ag+3sr5m1gDr9AiDQwn7xujsotZLWOQgP0Zi7DJ19BMp3e91vTxitx7l4j4
 H3V3QDoltNwMB32S62G2iMlkjjK4J103PrNrJkL/9WLi7ZjCtCYwNbk8YxObS0EN42v7 GQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3422u09evg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 09:13:41 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 098DDdWW030583;
        Thu, 8 Oct 2020 13:13:39 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 33xgx82t2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 13:13:39 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 098DDaCx33948128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Oct 2020 13:13:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 907054204D;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76A7542047;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 22B6FE24CC; Thu,  8 Oct 2020 15:13:36 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 02/10] s390/cio: Provide Endpoint-Security Mode per CU
Date:   Thu,  8 Oct 2020 15:13:28 +0200
Message-Id: <20201008131336.61100-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008131336.61100-1-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_07:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=790 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010080094
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Vineeth Vijayan <vneethv@linux.ibm.com>

Add an interface in the CIO layer to retrieve the information about the
Endpoint-Security Mode (ESM) of the specified CU. The ESM values are
defined as 0-None, 1-Authenticated or 2, 3-Encrypted.

Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
[vneethv@linux.ibm.com: cleaned-up and modified description]
Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 arch/s390/include/asm/cio.h |  1 +
 drivers/s390/cio/chsc.c     | 83 +++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/arch/s390/include/asm/cio.h b/arch/s390/include/asm/cio.h
index b5bfb3123cb1..66e06d0efb72 100644
--- a/arch/s390/include/asm/cio.h
+++ b/arch/s390/include/asm/cio.h
@@ -373,5 +373,6 @@ struct gen_pool *cio_gp_dma_create(struct device *dma_dev, int nr_pages);
 int chsc_sstpc(void *page, unsigned int op, u16 ctrl, u64 *clock_delta);
 int chsc_sstpi(void *page, void *result, size_t size);
 int chsc_sgib(u32 origin);
+int chsc_scud(u16 cu, u64 *esm, u8 *esm_valid);
 
 #endif
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index c314e9495c1b..513fc5748d6e 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -1403,3 +1403,86 @@ int chsc_sgib(u32 origin)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(chsc_sgib);
+
+#define SCUD_REQ_LEN	0x10 /* SCUD request block length */
+#define SCUD_REQ_CMD	0x4b /* SCUD Command Code */
+
+struct chse_cudb {
+	u16 flags:8;
+	u16 chp_valid:8;
+	u16 cu;
+	u32 esm_valid:8;
+	u32:24;
+	u8 chpid[8];
+	u32:32;
+	u32:32;
+	u8 esm[8];
+	u32 efla[8];
+} __packed;
+
+struct chsc_scud {
+	struct chsc_header request;
+	u16:4;
+	u16 fmt:4;
+	u16 cssid:8;
+	u16 first_cu;
+	u16:16;
+	u16 last_cu;
+	u32:32;
+	struct chsc_header response;
+	u16:4;
+	u16 fmt_resp:4;
+	u32:24;
+	struct chse_cudb cudb[];
+} __packed;
+
+/**
+ * chsc_scud() - Store control-unit description.
+ * @cu:		number of the control-unit
+ * @esm:	8 1-byte endpoint security mode values
+ * @esm_valid:	validity mask for @esm
+ *
+ * Interface to retrieve information about the endpoint security
+ * modes for up to 8 paths of a control unit.
+ *
+ * Returns 0 on success.
+ */
+int chsc_scud(u16 cu, u64 *esm, u8 *esm_valid)
+{
+	struct chsc_scud *scud = chsc_page;
+	int ret;
+
+	spin_lock_irq(&chsc_page_lock);
+	memset(chsc_page, 0, PAGE_SIZE);
+	scud->request.length = SCUD_REQ_LEN;
+	scud->request.code = SCUD_REQ_CMD;
+	scud->fmt = 0;
+	scud->cssid = 0;
+	scud->first_cu = cu;
+	scud->last_cu = cu;
+
+	ret = chsc(scud);
+	if (!ret)
+		ret = chsc_error_from_response(scud->response.code);
+
+	if (!ret && (scud->response.length <= 8 || scud->fmt_resp != 0
+			|| !(scud->cudb[0].flags & 0x80)
+			|| scud->cudb[0].cu != cu)) {
+
+		CIO_MSG_EVENT(2, "chsc: scud failed rc=%04x, L2=%04x "
+			"FMT=%04x, cudb.flags=%02x, cudb.cu=%04x",
+			scud->response.code, scud->response.length,
+			scud->fmt_resp, scud->cudb[0].flags, scud->cudb[0].cu);
+		ret = -EINVAL;
+	}
+
+	if (ret)
+		goto out;
+
+	memcpy(esm, scud->cudb[0].esm, sizeof(*esm));
+	*esm_valid = scud->cudb[0].esm_valid;
+out:
+	spin_unlock_irq(&chsc_page_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(chsc_scud);
-- 
2.17.1

