Return-Path: <SRS0=oVJv=DJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FB2C4727F
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 19:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29EB420719
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 19:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NGLGbOk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388386AbgJBTjs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Oct 2020 15:39:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388374AbgJBTjr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Oct 2020 15:39:47 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 092JXBf0106567;
        Fri, 2 Oct 2020 15:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=xQEfcfyQeytCGtoTE0iEKoHn7uZ+8tDjtxw2YE4mDCc=;
 b=NGLGbOk2IoytJANJaVyJnBD7LPbpKCFeu03t4uapIcbVQOrnKKmjKZ2X1GhzpnVFvSMv
 4ki6vvzzOo0gBg6Ipye3YKsLOPZDxes9xm/HNNiBk8Tl8dJnIHaEkX5gwjMTqBeP2g+G
 7YBrFfkkw34atF+Fj/blR+/LjpkWFJmsluQBk4TlpH0zrX9WSXVtaw9CbPAfZfloV1tF
 QLWbgWDEqch868tt//F0PqhENklY2RZeP3RhAsJUHLF55y+/W9n1FSsk2f1BX+SSjIv/
 /VSnrUt2oA6tBYohhM3/Tcp0v0uX/lwOz5JBV5E/fOk5Ooo9VwbIwpVrpSBj1uvYJOSt 2Q== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33x9a2a10s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 15:39:46 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 092JbU3V030555;
        Fri, 2 Oct 2020 19:39:44 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 33sw986vmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 19:39:44 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 092JdfHQ29753812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Oct 2020 19:39:41 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20700A4053;
        Fri,  2 Oct 2020 19:39:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1734DA4055;
        Fri,  2 Oct 2020 19:39:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  2 Oct 2020 19:39:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id A11C7E00C1; Fri,  2 Oct 2020 21:39:40 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
Subject: [PATCH 00/10] DASD FC endpoint security
Date:   Fri,  2 Oct 2020 21:39:30 +0200
Message-Id: <20201002193940.24012-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-02_14:2020-10-02,2020-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=1 priorityscore=1501 mlxlogscore=967
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020141
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

please see following patches that add a new DASD feature to show
fibre channel endpoint security.
The patches apply on you for-next branch and are intended for 5.10.

The s390/cio patches should also go upstream through your tree this time
since they are required for the DASD patches to build.

Best regards,
Stefan

Jan Höppner (7):
  s390/dasd: Remove unused parameter from dasd_generic_probe()
  s390/dasd: Move duplicate code to separate function
  s390/dasd: Store path configuration data during path handling
  s390/dasd: Fix operational path inconsistency
  s390/dasd: Display FC Endpoint Security information via sysfs
  s390/dasd: Prepare for additional path event handling
  s390/dasd: Process FCES path event notification

Sebastian Ott (1):
  s390/cio: Export information about Endpoint-Security Capability

Vineeth Vijayan (2):
  s390/cio: Provide Endpoint-Security Mode per CU
  s390/cio: Add support for FCES status notification

 arch/s390/include/asm/ccwdev.h   |   2 +
 arch/s390/include/asm/cio.h      |   1 +
 drivers/s390/block/dasd.c        |  22 ++--
 drivers/s390/block/dasd_devmap.c | 105 +++++++++++++++++++
 drivers/s390/block/dasd_eckd.c   | 170 ++++++++++++++++++++-----------
 drivers/s390/block/dasd_fba.c    |   2 +-
 drivers/s390/block/dasd_int.h    | 111 +++++++++++++++++++-
 drivers/s390/cio/chp.c           |  15 +++
 drivers/s390/cio/chp.h           |   1 +
 drivers/s390/cio/chsc.c          | 145 ++++++++++++++++++++++++--
 drivers/s390/cio/chsc.h          |   3 +-
 drivers/s390/cio/device.c        |  15 ++-
 12 files changed, 514 insertions(+), 78 deletions(-)

-- 
2.17.1

