Return-Path: <SRS0=oVJv=DJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F910C47095
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 19:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4FDC20758
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 19:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YptR3Ltj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388367AbgJBTjs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Oct 2020 15:39:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24544 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726224AbgJBTjr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Oct 2020 15:39:47 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 092Ja5gq039869;
        Fri, 2 Oct 2020 15:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=MOQQdNbPOMiNQtKca8KciHgWM+uaX6eiOuWBfLUHIcI=;
 b=YptR3Ltjnjl9+dOI7fqPxBvIWA4T7AYiXVgoQ3iUouDbXMi5cLAhxbYCKmkpJqD2OyWV
 9RJTOloDmclTuDAcOP7+Iy80JOZMIVdw3m6NlBneXKcuzCJtC0hpZBN1lpPnE3tOGJ3P
 IglcpBJjwupNR0ZadxhTDSKmDH7MRJLT9w6hG8yGdv2LQITrbPs4N7WL3ZQ0W4sF2MKS
 nhSZsEQqRQomKnHAcIZ7xlRIb30EGtJSnNbWRCvDe7lDHyTVv29ZN7C8NYCIF1Xbdvvl
 LYPM4+x6zlTk1kQjziccWr2d0nf1IIpYyiEzs3ZEWbi8RarOWXzPeR/HWozYU0TZ6jc3 +g== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33xa0ygps4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 15:39:46 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 092JcGlJ017638;
        Fri, 2 Oct 2020 19:39:44 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 33sw983m2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 19:39:44 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 092JdfJE26607888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Oct 2020 19:39:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30F7642042;
        Fri,  2 Oct 2020 19:39:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E36242041;
        Fri,  2 Oct 2020 19:39:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  2 Oct 2020 19:39:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id A2BBBE02E4; Fri,  2 Oct 2020 21:39:40 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
Subject: [PATCH 01/10] s390/cio: Export information about Endpoint-Security Capability
Date:   Fri,  2 Oct 2020 21:39:31 +0200
Message-Id: <20201002193940.24012-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002193940.24012-1-sth@linux.ibm.com>
References: <20201002193940.24012-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-02_14:2020-10-02,2020-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 impostorscore=0
 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=1
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020137
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

Reference-ID: IO1812
Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
[vneethv@linux.ibm.com: cleaned-up & modified description]
Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
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

