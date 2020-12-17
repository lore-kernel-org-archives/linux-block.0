Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F649C4361B
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 15:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3314E23975
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 15:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgLQP7y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 10:59:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727414AbgLQP7y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 10:59:54 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BHFXXnf095058;
        Thu, 17 Dec 2020 10:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=LxuXlenOw3u38eA8cby72t9kF/x2anm6e4snxX8fuxI=;
 b=khQkX1a2H1mAYZubhzij+NH6oJSMXeizpVtfQAV0WFa6XJAFcVkDAAaBwFjDcSyioBfD
 6iqHMjpulCOouXRMqk/ht0wa+KCbpFfx5jLDqmWar6owu2sWP8Iba8VOiV+1s8oeCwyR
 IInKAqqt7CEgBirCy9xiMzw8C3rVxRkBpiOtno00C/1XqUJScnR4WauuwTzZBn3aOjc6
 5IeVVX+i5CtyVG6i3rBodkygRN407JYq10hcifeOHydfcfq2HQ3uQklC7SqFeZv/AKWq
 eD9QCcd7varVbbu6Yr+bsibhbf3J7y84QO5fOHCGwaYU0AC+yZw5OrPI9M26AiFQZZyM rA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35g8mv430j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 10:59:13 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BHFsWtE011180;
        Thu, 17 Dec 2020 15:59:10 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 35fmywgj0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 15:59:10 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BHFx7wH34799904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Dec 2020 15:59:07 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 941D2AE056;
        Thu, 17 Dec 2020 15:59:07 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F318AE04D;
        Thu, 17 Dec 2020 15:59:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Dec 2020 15:59:07 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 2C4A8E01DC; Thu, 17 Dec 2020 16:59:07 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/4] Fix DASD control unit updates
Date:   Thu, 17 Dec 2020 16:59:03 +0100
Message-Id: <20201217155907.36436-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_10:2020-12-15,2020-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012170106
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

please apply the following patches that address problems during DASD
control unit updates.
Thanks.

Stefan Haberland (4):
  s390/dasd: fix hanging device offline processing
  s390/dasd: prevent inconsistent LCU device data
  s390/dasd: fix list corruption of pavgroup group list
  s390/dasd: fix list corruption of lcu list

 drivers/s390/block/dasd_alias.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

-- 
2.17.1

