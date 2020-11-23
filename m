Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FFFC63777
	for <linux-block@archiver.kernel.org>; Mon, 23 Nov 2020 08:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 760C42076E
	for <linux-block@archiver.kernel.org>; Mon, 23 Nov 2020 08:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D+kVJeQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgKWIM0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Nov 2020 03:12:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35508 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725320AbgKWIM0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Nov 2020 03:12:26 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AN81nvt181756;
        Mon, 23 Nov 2020 03:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=tAKNuYZffSpOFwBpuBhOnjzWOmBxw1tP/G3s35IS3+8=;
 b=D+kVJeQq7uqrgoLNzexLuqKXhrjITZt8YltULxTZEBhuHxgRxxB5vxY6ucEJJVzYkqPW
 5pONzb1ZFhxVstWPeJ4lTINfpidTjtASikT5Dnj/ukUhKR4QzSW/aHjovF8+j43Av0ZV
 uqirSWYA78mwjhxWE6Owl8y5Lk8z9zR3aF9Hs4B8tEcNgczb+/nBAHAdYNZy2GI9NFzc
 GYGkqu7XqQyx3t4z8UsMQ/2u1zic1J1gZhrzH6rNBa40Uw0nie45W6t4FcYlU1mTdSEp
 bwj7k00DRaGzSG/0hoalBFUlS6G8gMjaTTeqHX/gUKzJMdi8VioxY5HS/zYnC6UrjLuq QA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34ygtshvrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 03:12:25 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AN81jcp023277;
        Mon, 23 Nov 2020 08:12:22 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 34xth8958v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 08:12:21 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AN8CJDD7078618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 08:12:19 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1644852075;
        Mon, 23 Nov 2020 08:12:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D50105207E;
        Mon, 23 Nov 2020 08:12:18 +0000 (GMT)
From:   Julian Wiedmann <jwi@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH 1/2] block: update documentation for blk_rq_timeout()
Date:   Mon, 23 Nov 2020 09:12:15 +0100
Message-Id: <20201123081216.64025-1-jwi@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_02:2020-11-20,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011230052
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Requests don't have their own timers anymore, they share the queue's
timer instead.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 block/blk-timeout.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 1b8de0417fc1..61430575cb58 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -122,8 +122,8 @@ unsigned long blk_rq_timeout(unsigned long timeout)
  * @req:	request that is about to start running.
  *
  * Notes:
- *    Each request has its own timer, and as it is added to the queue, we
- *    set up the timer. When the request completes, we cancel the timer.
+ *    Each request has its own timeout. As a request is added to the queue,
+ *    we start/adjust the queue's timer to keep track of the earliest timeout.
  */
 void blk_add_timer(struct request *req)
 {
-- 
2.17.1

