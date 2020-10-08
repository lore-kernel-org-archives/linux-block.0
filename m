Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DD6C4363A
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 13:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235512083B
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 13:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mgy0rG8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgJHNNn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 09:13:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729765AbgJHNNn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 09:13:43 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098D3L2K030955;
        Thu, 8 Oct 2020 09:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=9K8Ji6kxZAJ/7H2MIaoejqwSW9wlzOJdIkad+gvZWH0=;
 b=Mgy0rG8Q7YGOL3XfVUAK4jOUwzHqc+LFk8SfebCgB+gVdE/IPhgzF+MJ3OXHzNpRVMpk
 dV/TbtImJ5+FPSDFaQuBrSuflwjK0w8GQPWRs4Q1F3yNrGT7ZEc0JhBr00PVUiDRn+EE
 dO8iwqURhQ4LxWrMwLQlrogNnNpBIo/6U5UJE/X/MTnzOpkysD1H1/MXvplw5IB7febf
 8lZHfI2DgZQB1xWrdpU1F0SsIl8npZHnqwsFzOSsDq9JO5Q/J4opGrSkufYRX9+SL+si
 ZpsyDth6wK1/8BxvzuZSY6+tYQUPA1llDAWQEPuoVRCtKoRkq6cFZHlnYnXGEzB/YpBa vw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3421q0try8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 09:13:41 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 098DDdeu017785;
        Thu, 8 Oct 2020 13:13:39 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 33xgx85c2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 13:13:39 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 098DDage14942540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Oct 2020 13:13:36 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 731BE5204F;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 6B0F952051;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 1E944E24C9; Thu,  8 Oct 2020 15:13:36 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 00/10] DASD FC endpoint security
Date:   Thu,  8 Oct 2020 15:13:26 +0200
Message-Id: <20201008131336.61100-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_08:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2010080097
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

please apply the following patches that add a new DASD feature to show
fibre channel endpoint security.

The patches apply on you for-next branch and are intended for 5.10.

The s390/cio patches should also go upstream through your tree this time
since they are required for the DASD patches to build.

Best regards,
Stefan

v1->v2:
 - fix memleak in "s390/dasd: Fix operational path inconsistency"
 - add comment suggested by Cornelia Huck

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
 drivers/s390/block/dasd_devmap.c | 109 +++++++++++++++++++
 drivers/s390/block/dasd_eckd.c   | 175 +++++++++++++++++++++----------
 drivers/s390/block/dasd_fba.c    |   2 +-
 drivers/s390/block/dasd_int.h    | 111 +++++++++++++++++++-
 drivers/s390/cio/chp.c           |  15 +++
 drivers/s390/cio/chp.h           |   1 +
 drivers/s390/cio/chsc.c          | 145 +++++++++++++++++++++++--
 drivers/s390/cio/chsc.h          |   3 +-
 drivers/s390/cio/device.c        |  15 ++-
 12 files changed, 523 insertions(+), 78 deletions(-)

-- 
2.17.1

