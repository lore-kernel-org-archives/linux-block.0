Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E32DC47420
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 13:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00D2B2184D
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 13:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m1gEblxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbgJHNNr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 09:13:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10630 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729718AbgJHNNn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 09:13:43 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098D86Fn075755;
        Thu, 8 Oct 2020 09:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=ryKj9K5g6fDu2DgKJ+22T5p33eF6zKNttbcr8+POoZY=;
 b=m1gEblxBwVtTRJ8KYAfFVjMHKFrfQkdAeXwHWIOun2RZg2Gzr3i8tRM85qno/70/5c+N
 0wnSTweZ37NXcebh9YDXOR0SDcfF/Xan4057crOcqh5HPH39ShfUmDPlFxnZMQxZmveZ
 tav2VXKNRZQ3A8bUch5UoByYPh9VrPBVt4L4gnGWYl+B2eOOmIU55p/MHRbW8ESCBqwM
 NOEpsFJH3TSaniOAdVgUzGgHp0vCGQZuJDbVI8f20RJjSc7MIPdADr07h8hqEqk8cJqR
 3vMSlaFAGbgDzgcWw7Kr+L6MONEpBNsP+qg7sA6PNAwxnB+MGXgmOpf9DIHBWzIjFv8W PA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34239a8f4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 09:13:41 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 098DD9La015067;
        Thu, 8 Oct 2020 13:13:39 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 33xgjh5c45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 13:13:39 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 098DDaAM21365172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Oct 2020 13:13:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD7DC4C052;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAFFE4C050;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 2D14CE24D0; Thu,  8 Oct 2020 15:13:36 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 06/10] s390/dasd: Store path configuration data during path handling
Date:   Thu,  8 Oct 2020 15:13:32 +0200
Message-Id: <20201008131336.61100-7-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008131336.61100-1-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_07:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 suspectscore=2 priorityscore=1501 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080094
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jan Höppner <hoeppner@linux.ibm.com>

Currently, the configuration data for a path is retrieved during a path
verification and used only temporarily. If a path is newly added to the
I/O setup after a boot, no configuration data will be stored for this
particular path.
However, this data is required for later use and should be present for
a valid I/O path anyway. Store this data during the path verification so
that newly added paths can provide all information necessary.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
[sth@linux.ibm.com: fix conf_data memleak]
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 497aa81778b6..3ff7b532a5bf 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1007,6 +1007,11 @@ static void dasd_eckd_store_conf_data(struct dasd_device *device,
 	struct subchannel_id sch_id;
 
 	ccw_device_get_schid(device->cdev, &sch_id);
+	/*
+	 * path handling and read_conf allocate data
+	 * free it before replacing the pointer
+	 */
+	kfree(device->path[chp].conf_data);
 	device->path[chp].conf_data = conf_data;
 	device->path[chp].cssid = sch_id.cssid;
 	device->path[chp].ssid = sch_id.ssid;
@@ -1263,9 +1268,10 @@ static void do_path_verification_work(struct work_struct *work)
 	struct dasd_uid *uid;
 	__u8 path_rcd_buf[DASD_ECKD_RCD_DATA_SIZE];
 	__u8 lpm, opm, npm, ppm, epm, hpfpm, cablepm;
+	struct dasd_conf_data *conf_data;
 	unsigned long flags;
 	char print_uid[60];
-	int rc;
+	int rc, pos;
 
 	data = container_of(work, struct path_verification_work_data, worker);
 	device = data->device;
@@ -1395,6 +1401,14 @@ static void do_path_verification_work(struct work_struct *work)
 			}
 		}
 
+		conf_data = kzalloc(DASD_ECKD_RCD_DATA_SIZE, GFP_KERNEL);
+		if (conf_data) {
+			memcpy(conf_data, data->rcd_buffer,
+			       DASD_ECKD_RCD_DATA_SIZE);
+		}
+		pos = pathmask_to_pos(lpm);
+		dasd_eckd_store_conf_data(device, conf_data, pos);
+
 		/*
 		 * There is a small chance that a path is lost again between
 		 * above path verification and the following modification of
-- 
2.17.1

