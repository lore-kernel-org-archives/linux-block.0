Return-Path: <SRS0=oVJv=DJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7478DC4727D
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 19:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2209520795
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 19:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D0tzyK8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388416AbgJBTjt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Oct 2020 15:39:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388377AbgJBTjs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Oct 2020 15:39:48 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 092JWean084221;
        Fri, 2 Oct 2020 15:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=/LM26F8g3cNQnCO0khdM/oE2y/mz5Bzwib3hyMGmbCo=;
 b=D0tzyK8SvuZ867itwrnEbnAYF21zMOAmLizwvVoZHNo46RQ4Zo7wqH2vvWTAjOwDfUcF
 MnDJwwctf4db6dbG4xCRLHoAcmstZRPWHiPKeqrdCnwjZ+DpZ2tK0VDXuhkpMhAkmUF2
 lLIDVvW93a0hoT9pAJnnoUzzVbXvbCxAT10P6phYxAgGpHiCSNoRPrHSua8N9ekGgUAA
 qWRBeLd9ESP/EGde/mDCV4l49ADJ+Gy6PeNjt2kHE926q47l2cEj/brD/5Rf/I7YN1PS
 J5fQuxR3onEzV+e6WfNVhJRfh8PzXJnTMk2avurv/u12ijlYg4ja3ZVq18xsYhSguv3r QA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33xa7r0f0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 15:39:46 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 092JcIWl030722;
        Fri, 2 Oct 2020 19:39:44 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 33sw986vmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 19:39:44 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 092JdfOS18219410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Oct 2020 19:39:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 378794203F;
        Fri,  2 Oct 2020 19:39:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EB0A42045;
        Fri,  2 Oct 2020 19:39:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  2 Oct 2020 19:39:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id A8169E02FD; Fri,  2 Oct 2020 21:39:40 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
Subject: [PATCH 03/10] s390/cio: Add support for FCES status notification
Date:   Fri,  2 Oct 2020 21:39:33 +0200
Message-Id: <20201002193940.24012-4-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002193940.24012-1-sth@linux.ibm.com>
References: <20201002193940.24012-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-02_14:2020-10-02,2020-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 suspectscore=1 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020137
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Vineeth Vijayan <vneethv@linux.ibm.com>

Fibre Channel Endpoint-Security event is received as an sei:nt0 type
in the CIO layer. This information needs to be shared with the
CCW device drivers using the path_events callback.

Reference-ID: IO1812
Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Co-developed-by: Sebastian Ott <sebott@linux.ibm.com>
Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 arch/s390/include/asm/ccwdev.h |  2 ++
 drivers/s390/cio/chp.h         |  1 +
 drivers/s390/cio/chsc.c        | 62 +++++++++++++++++++++++++++++-----
 drivers/s390/cio/device.c      | 15 +++++++-
 4 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/ccwdev.h b/arch/s390/include/asm/ccwdev.h
index 3cfe1eb89838..14e1bbfd969e 100644
--- a/arch/s390/include/asm/ccwdev.h
+++ b/arch/s390/include/asm/ccwdev.h
@@ -104,6 +104,8 @@ struct ccw_device {
 					       was successfully verified. */
 #define PE_PATHGROUP_ESTABLISHED	0x4 /* A pathgroup was reset and had
 					       to be established again. */
+#define PE_PATH_FCES_EVENT		0x8 /* The FCES Status of a path has
+					     * changed. */
 
 /*
  * Possible CIO actions triggered by the unit check handler.
diff --git a/drivers/s390/cio/chp.h b/drivers/s390/cio/chp.h
index 20259f3fbf45..7ee9eba0abcb 100644
--- a/drivers/s390/cio/chp.h
+++ b/drivers/s390/cio/chp.h
@@ -23,6 +23,7 @@
 #define CHP_OFFLINE 1
 #define CHP_VARY_ON 2
 #define CHP_VARY_OFF 3
+#define CHP_FCES_EVENT 4
 
 struct chp_link {
 	struct chp_id chpid;
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index 513fc5748d6e..04fbcfcf9e42 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -37,6 +37,9 @@ static void *sei_page;
 static void *chsc_page;
 static DEFINE_SPINLOCK(chsc_page_lock);
 
+#define SEI_VF_FLA	0xc0 /* VF flag for Full Link Address */
+#define SEI_RS_CHPID	0x4  /* 4 in RS field indicates CHPID */
+
 /**
  * chsc_error_from_response() - convert a chsc response to an error
  * @response: chsc response code
@@ -285,6 +288,15 @@ static void s390_process_res_acc(struct chp_link *link)
 	css_schedule_reprobe();
 }
 
+static int process_fces_event(struct subchannel *sch, void *data)
+{
+	spin_lock_irq(sch->lock);
+	if (sch->driver && sch->driver->chp_event)
+		sch->driver->chp_event(sch, data, CHP_FCES_EVENT);
+	spin_unlock_irq(sch->lock);
+	return 0;
+}
+
 struct chsc_sei_nt0_area {
 	u8  flags;
 	u8  vf;				/* validity flags */
@@ -362,6 +374,16 @@ static char *store_ebcdic(char *dest, const char *src, unsigned long len,
 	return dest + len;
 }
 
+static void chsc_link_from_sei(struct chp_link *link,
+				struct chsc_sei_nt0_area *sei_area)
+{
+	if ((sei_area->vf & SEI_VF_FLA) != 0) {
+		link->fla	= sei_area->fla;
+		link->fla_mask	= ((sei_area->vf & SEI_VF_FLA) == SEI_VF_FLA) ?
+							0xffff : 0xff00;
+	}
+}
+
 /* Format node ID and parameters for output in LIR log message. */
 static void format_node_data(char *params, char *id, struct node_descriptor *nd)
 {
@@ -451,15 +473,7 @@ static void chsc_process_sei_res_acc(struct chsc_sei_nt0_area *sei_area)
 	}
 	memset(&link, 0, sizeof(struct chp_link));
 	link.chpid = chpid;
-	if ((sei_area->vf & 0xc0) != 0) {
-		link.fla = sei_area->fla;
-		if ((sei_area->vf & 0xc0) == 0xc0)
-			/* full link address */
-			link.fla_mask = 0xffff;
-		else
-			/* link address */
-			link.fla_mask = 0xff00;
-	}
+	chsc_link_from_sei(&link, sei_area);
 	s390_process_res_acc(&link);
 }
 
@@ -568,6 +582,33 @@ static void chsc_process_sei_ap_cfg_chg(struct chsc_sei_nt0_area *sei_area)
 	ap_bus_cfg_chg();
 }
 
+static void chsc_process_sei_fces_event(struct chsc_sei_nt0_area *sei_area)
+{
+	struct chp_link link;
+	struct chp_id chpid;
+	struct channel_path *chp;
+
+	CIO_CRW_EVENT(4,
+	"chsc: FCES status notification (rs=%02x, rs_id=%04x, FCES-status=%x)\n",
+		sei_area->rs, sei_area->rsid, sei_area->ccdf[0]);
+
+	if (sei_area->rs != SEI_RS_CHPID)
+		return;
+	chp_id_init(&chpid);
+	chpid.id = sei_area->rsid;
+
+	/* Ignore the event on unknown/invalid chp */
+	chp = chpid_to_chp(chpid);
+	if (!chp)
+		return;
+
+	memset(&link, 0, sizeof(struct chp_link));
+	link.chpid = chpid;
+	chsc_link_from_sei(&link, sei_area);
+
+	for_each_subchannel_staged(process_fces_event, NULL, &link);
+}
+
 static void chsc_process_sei_nt2(struct chsc_sei_nt2_area *sei_area)
 {
 	switch (sei_area->cc) {
@@ -609,6 +650,9 @@ static void chsc_process_sei_nt0(struct chsc_sei_nt0_area *sei_area)
 	case 14: /* scm available notification */
 		chsc_process_sei_scm_avail(sei_area);
 		break;
+	case 15: /* FCES event notification */
+		chsc_process_sei_fces_event(sei_area);
+		break;
 	default: /* other stuff */
 		CIO_CRW_EVENT(2, "chsc: sei nt0 unhandled cc=%d\n",
 			      sei_area->cc);
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index b29fe8d50baf..aab13c78db9f 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1170,7 +1170,8 @@ static int io_subchannel_chp_event(struct subchannel *sch,
 				   struct chp_link *link, int event)
 {
 	struct ccw_device *cdev = sch_get_cdev(sch);
-	int mask;
+	int mask, chpid, valid_bit;
+	int path_event[8];
 
 	mask = chp_ssd_get_mask(&sch->ssd_info, link);
 	if (!mask)
@@ -1205,6 +1206,18 @@ static int io_subchannel_chp_event(struct subchannel *sch,
 			cdev->private->path_new_mask |= mask;
 		io_subchannel_verify(sch);
 		break;
+	case CHP_FCES_EVENT:
+		/* Forward Endpoint Security event */
+		for (chpid = 0, valid_bit = 0x80; chpid < 8; chpid++,
+				valid_bit >>= 1) {
+			if (mask & valid_bit)
+				path_event[chpid] = PE_PATH_FCES_EVENT;
+			else
+				path_event[chpid] = PE_NONE;
+		}
+		if (cdev)
+			cdev->drv->path_event(cdev, path_event);
+		break;
 	}
 	return 0;
 }
-- 
2.17.1

