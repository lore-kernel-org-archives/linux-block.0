Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46E7C47095
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 13:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B9A421927
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 13:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jn6gwaQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbgJHNNo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 09:13:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725871AbgJHNNn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 09:13:43 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098D7w9r178381;
        Thu, 8 Oct 2020 09:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=kETLHD8uMVR2voLK2TxuO0GzuACR6BXwoRCypfYqfSc=;
 b=jn6gwaQYT3vVbJCwFhXc+zapLXNIK2wf0lE90EdwzoGMMFhukrreitSFEGO6b7PS6aCu
 ABlz3578bAwmLTSHGRmiBKdaU02cXAIjvDQfOR8Rs+5vgr/Lfw6wDqwKroQlmZ8WK/Br
 0bi+eCLpbq8jo945/LyQTcJfldt2Q0ityTJ4vGHD5ymuy8Wr2bnKifqVk1obFCB3Nzmy
 c1Wo2QkPzp7df8FVtYpnmHwsBvLFPxG5fM9/GMMF/tY+Yh2vKHdCAeYvMkGd8xyHTg42
 jWR4KcukA9/amPX0lrkup7UjYCKhNWiPgHVps0D5S90njxMvUa/GvLpLpkiCTgwN6TVV Ow== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3422ng1txg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 09:13:41 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 098DDa9T017781;
        Thu, 8 Oct 2020 13:13:39 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 33xgx85c2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 13:13:39 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 098DDaZU10551570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Oct 2020 13:13:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 895744204B;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7623342041;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 1FD92E24C7; Thu,  8 Oct 2020 15:13:36 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 01/10] s390/cio: Export information about Endpoint-Security Capability
Date:   Thu,  8 Oct 2020 15:13:27 +0200
Message-Id: <20201008131336.61100-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008131336.61100-1-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_08:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010080094
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sebastian Ott <sebott@linux.ibm.com>

Add a new sysfs attribute 'esc' per chpid. This new attribute exports
the Endpoint-Security-Capability byte of channel-path description block,
which could be 0-None, 1-Authentication, 2 and 3-Encryption.

For example:
$ cat /sys/devices/css0/chp0.34/esc
0

Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
[vneethv@linux.ibm.com: cleaned-up & modified description]
Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/cio/chp.c  | 15 +++++++++++++++
 drivers/s390/cio/chsc.h |  3 ++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index dfcbe54591fb..8d0de6adcad0 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -384,6 +384,20 @@ static ssize_t chp_chid_external_show(struct device *dev,
 }
 static DEVICE_ATTR(chid_external, 0444, chp_chid_external_show, NULL);
 
+static ssize_t chp_esc_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct channel_path *chp = to_channelpath(dev);
+	ssize_t rc;
+
+	mutex_lock(&chp->lock);
+	rc = sprintf(buf, "%x\n", chp->desc_fmt1.esc);
+	mutex_unlock(&chp->lock);
+
+	return rc;
+}
+static DEVICE_ATTR(esc, 0444, chp_esc_show, NULL);
+
 static ssize_t util_string_read(struct file *filp, struct kobject *kobj,
 				struct bin_attribute *attr, char *buf,
 				loff_t off, size_t count)
@@ -414,6 +428,7 @@ static struct attribute *chp_attrs[] = {
 	&dev_attr_shared.attr,
 	&dev_attr_chid.attr,
 	&dev_attr_chid_external.attr,
+	&dev_attr_esc.attr,
 	NULL,
 };
 static struct attribute_group chp_attr_group = {
diff --git a/drivers/s390/cio/chsc.h b/drivers/s390/cio/chsc.h
index 7ecf7e4c402e..4f049d17355d 100644
--- a/drivers/s390/cio/chsc.h
+++ b/drivers/s390/cio/chsc.h
@@ -27,7 +27,8 @@ struct channel_path_desc_fmt1 {
 	u8 lsn;
 	u8 desc;
 	u8 chpid;
-	u32:24;
+	u32:16;
+	u8 esc;
 	u8 chpp;
 	u32 unused[2];
 	u16 chid;
-- 
2.17.1

