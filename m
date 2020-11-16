Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B4FC6369E
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 15:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5346F20888
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 15:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oKCR+gJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbgKPPXz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Nov 2020 10:23:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731021AbgKPPXy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 10:23:54 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AGF5Fvs191473;
        Mon, 16 Nov 2020 10:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=YfyBAuxAoU/fCaWqFG6X/yKGgo8hTwdoVRlxvO2I2yY=;
 b=oKCR+gJC+GNkJH80mnO/KQK+C1lisQOJUDUvH0ogseYMLSsHYZxoZxGPUTxzNDxosGas
 IPFNpQevPoFo4n0ndzy2/7tlDS+ZjGEHl7Ue0hilQRlf0pxlt2jkwrXVjpjxFoCLPag9
 BN69dKIqjJWzKJwZk+UB0FvcAmhOLdWvoHibca+DtwhZsQ3qnoCTm8a2MoiQaGuiesg+
 Ivu6NR7Ti03dSDLi2W9QatO+ymn0Xo+8PkHqtEYvSah2m8dp8xRFXmfcT8S187D5HA9o
 bRko3b61fiWnByMVB+tKQwGTZBvX4nBhSU026Lsp/4zSZnjjgSr+Ak+Y+tIRdu0PXeIs Mw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34uu48srh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Nov 2020 10:23:53 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AGFH426011410;
        Mon, 16 Nov 2020 15:23:50 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 34t6v8a83u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Nov 2020 15:23:50 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AGFNmhX33227076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 15:23:48 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15030A4078;
        Mon, 16 Nov 2020 15:23:48 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03F1DA405D;
        Mon, 16 Nov 2020 15:23:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 16 Nov 2020 15:23:47 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 9DDA3E0367; Mon, 16 Nov 2020 16:23:47 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/1] fix null pointer dereference for ERP requests
Date:   Mon, 16 Nov 2020 16:23:46 +0100
Message-Id: <20201116152347.61093-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-16_08:2020-11-13,2020-11-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=767 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011160092
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

pleas apply the following patch that fixes a null pointer derefernce in the
DASD driver.

Stefan Haberland (1):
  s390/dasd: fix null pointer dereference for ERP requests

 drivers/s390/block/dasd.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.17.1

