Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E5AC4363A
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 13:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ACB82083B
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 13:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EUdp5j3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgJHNNo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 09:13:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49578 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729806AbgJHNNn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 09:13:43 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098D2r3u081745;
        Thu, 8 Oct 2020 09:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=AoP1SaUljEBZmdrPcXfki8yEAcXNvdlICdKYL3vte1s=;
 b=EUdp5j3IshcblRGwkSb+eiPSr2OLIBV7Gqrl55/UXXWieBKub+oQmfdP2Kp67eTp1dzy
 2xfdPaPBp5fu9PM8RvyySgsFiEBbB+rKiQic+5NetowzwDXkehnXM5Vpnz4E9kZsKwI/
 7Z8IJcD/bcftOc0OT8XJcNf6SwhiNBjFFak1XhjJw52YoJHwRysIoq9z/IxLhWnHw+0S
 f+Bga8h8HzIlXt6fQ+/r8bPXLzZ0TsHnb6z8dQMlro/5DY5qZ5X8xfhZ9y05L42ct4KH
 iuqtF9vjOZTDtATlElOdn7gxeuWrio6mxQUKH1OsonM/D414ut09B+XU3N7rq0aj4/Y7 gA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3422uk9bn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 09:13:41 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 098DCij8014546;
        Thu, 8 Oct 2020 13:13:39 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 33xgjh5c46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 13:13:39 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 098DDbuj10551576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Oct 2020 13:13:37 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1BCD4204B;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE4EC42047;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 2FA07E24D1; Thu,  8 Oct 2020 15:13:36 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 07/10] s390/dasd: Fix operational path inconsistency
Date:   Thu,  8 Oct 2020 15:13:33 +0200
Message-Id: <20201008131336.61100-8-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008131336.61100-1-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_08:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=892
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010080097
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jan Höppner <hoeppner@linux.ibm.com>

During online processing and setting up a DASD device, the configuration
data for operational paths is read and validated two times
(dasd_eckd_read_conf()). The first time to provide information that are
necessary for the LCU setup. A second time after the LCU setup as a
device might report different configuration data then.

When the configuration setup for each operational path is being
validated, an initial call to dasd_eckd_clear_conf_data() is issued.
This call wipes all previously available configuration data and path
information for each path.
However, the operational path mask is not updated during this process.

As a result, the stored operational path mask might no longer correspond
to the operational paths mask reported by the CIO layer, as several
paths might be gone between the two dasd_eckd_read_conf() calls.

This inconsistency leads to more severe issues in later path handling
changes. Fix this by removing the channel paths from the operational
path mask during the dasd_eckd_clear_conf_data() call.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 3ff7b532a5bf..3273b26b25b0 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1034,6 +1034,7 @@ static void dasd_eckd_clear_conf_data(struct dasd_device *device)
 		device->path[i].cssid = 0;
 		device->path[i].ssid = 0;
 		device->path[i].chpid = 0;
+		dasd_path_notoper(device, i);
 	}
 }
 
-- 
2.17.1

