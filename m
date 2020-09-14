Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7B5C433E2
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 12:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 834E1208E4
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 12:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZA94u7eL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgINMiU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 08:38:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726183AbgINMg5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 08:36:57 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08EBfmNb001619;
        Mon, 14 Sep 2020 07:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=5Fv8kTlNA8GN8jW9Iq4dhFANuKdCe5Yzvf+1bvyv1nw=;
 b=ZA94u7eLnBKk6SAJNd4dHDd/vizukt4OJDCeo8GJNSLkQCO8VwLi8WWlN+RvtSrRhGiQ
 8A7mbih5oXs7TQMoK1wXkksS+tYaUjB/V4T6eJrpFp4wzQ5yeC8vFDGUwZN2UKvDYpL3
 dYr3DgII0vj5QIQQMphLO/ncRTdjYGkjJ9UWS/o2mup2SVE1QRePiwgK0DxGqaNbgdYc
 dS4Wtv1iDtsere7O6JRL0Y9IGkLPypxkVrdYH9DYPmN7ilpoVBU6o2ner1z6mTzAXMQc
 Lw0tNNCP1yv5Ax+GtRn1qxWzT0D0mSjQ+zLrh3K0RU9DP2agKv2jKKcUhyza0WXZp/uJ Jw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33j7v50cr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 07:56:52 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08EBr97o015057;
        Mon, 14 Sep 2020 11:56:51 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 33hb1j19a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 11:56:50 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08EBtENl19333396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Sep 2020 11:55:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 284D54C046;
        Mon, 14 Sep 2020 11:56:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14A324C040;
        Mon, 14 Sep 2020 11:56:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 14 Sep 2020 11:56:48 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id A1EA4E03DF; Mon, 14 Sep 2020 13:56:47 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
Subject: [PATCH 0/1] DASD: fix discard for FBA devices
Date:   Mon, 14 Sep 2020 13:56:46 +0200
Message-Id: <20200914115647.94062-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-14_02:2020-09-10,2020-09-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=1 adultscore=0 mlxlogscore=465 mlxscore=0
 phishscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140091
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

please see the following patch that fixes zero writes for DASD FBA devices under certain conditions.

Do you mind to take this for 5.9?

Jan Höppner (1):
  s390/dasd: Fix zero write for FBA devices

 drivers/s390/block/dasd_fba.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.17.1

