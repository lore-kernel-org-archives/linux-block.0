Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF802C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 04:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49982070B
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 04:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5iSPw8+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfBUEOi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 23:14:38 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48434 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfBUEOi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 23:14:38 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1L4E9Kn061963;
        Thu, 21 Feb 2019 04:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=ps0ptR50eaiMWgl6T40Fdw2v8Beoblsk9WHbXomdRpY=;
 b=5iSPw8+PlpDx9d4WMpB5qE9qcCTbjw+tkkxsQTwdLgxkofH70sWCRsVSh56nRS/mxC/D
 9/S6OGjs9vT3nrJ8XVZzRRPK3MraMPe/w/VznWKIj7sEVyUgEDBnpAdX/ckX8gokWaUG
 0AHHFdqINhdFcb/rNARRzFWTOvm54IcSceqXFNGrTc20te0HvvG5SEY66lA8dPjTLdNP
 dYY0fGhBwSdIAk6O3T5zsyujZxkGnFFDD3SaRAoNX3AqM7n8FY3DiV+KrKUDoztkPldq
 L1QOeNmB7sUDesWv7/CMv/Y/87pJ2s2tSDD/puFxHjjeE+buySTg2LQwSgAfuqpv1BHg mw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qpb5rngj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 04:14:32 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1L4EUdp029122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 04:14:31 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1L4EUDX011203;
        Thu, 21 Feb 2019 04:14:30 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 20:14:29 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, jack@suse.cz
Subject: [PATCH 0/2] loop: fix two issues introduced by prior commit
Date:   Thu, 21 Feb 2019 12:17:33 +0800
Message-Id: <1550722655-15102-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=713 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210031
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch set fix two issues introduced by prior commit.


[PATCH 1/2] loop: do not print warn message if partition scan is successful

[PATCH 1/2] fixes d57f3374ba48 ("loop: Move special partition reread
handling in loop_clr_fd()") to not always print warn message even when
partition scan is successful.

[PATCH 2/2] loop: set GENHD_FL_NO_PART_SCAN after blkdev_reread_part()

[PATCH 2/2] fixes 0da03cab87e6 ("loop: Fix deadlock when calling
blkdev_reread_part()") to not set GENHD_FL_NO_PART_SCAN before partition
scan when detaching loop device from the file.

Thank you very much!

Dongli Zhang

