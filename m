Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BF3C31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 23:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F02920896
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 23:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfFMXc2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 19:32:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726265AbfFMXc1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 19:32:27 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DNDevW031221
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 19:32:26 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t3x36v96r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 19:32:26 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <leonardo@linux.ibm.com>;
        Fri, 14 Jun 2019 00:32:25 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Jun 2019 00:32:23 +0100
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5DNWMKT35389762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 23:32:22 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A8CFBE04F;
        Thu, 13 Jun 2019 23:32:22 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F4D9BE051;
        Thu, 13 Jun 2019 23:32:21 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.18.235.170])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jun 2019 23:32:20 +0000 (GMT)
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     linux-block@vger.kernel.org
Cc:     Leonardo Bras <leonardo@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] block/cfq : Include check to avoid NULL Pointer Dereferencing
Date:   Thu, 13 Jun 2019 20:31:59 -0300
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613233159.26687-1-leonardo@linux.ibm.com>
References: <20190613233159.26687-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061323-0004-0000-0000-0000151BFBD0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011257; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01217587; UDB=6.00640288; IPR=6.00998699;
 MB=3.00027300; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-13 23:32:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061323-0005-0000-0000-00008C143C90
Message-Id: <20190613233159.26687-2-leonardo@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130176
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Checks if cfqg is a valid pointer before dereferencing.

There is a explicit chance for cfqg = cfq_get_next_cfqg() to return NULL,
so 'cfqg->saved_wl_slice' would be a Null dereferencing.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 block/cfq-iosched.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 2eb87444b157..2c5dd5a295ee 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -3210,9 +3210,13 @@ static struct cfq_group *cfq_get_next_cfqg(struct cfq_data *cfqd)
 
 static void cfq_choose_cfqg(struct cfq_data *cfqd)
 {
-	struct cfq_group *cfqg = cfq_get_next_cfqg(cfqd);
+	struct cfq_group *cfqg;
 	u64 now = ktime_get_ns();
 
+	cfqg = cfq_get_next_cfqg(cfqd);
+	if (unlikely(!cfqg))
+		return;
+
 	cfqd->serving_group = cfqg;
 
 	/* Restore the workload type data */
-- 
2.20.1

