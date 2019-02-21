Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239ECC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 15:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE07C20842
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 15:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rNzKRQSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbfBUPao (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:30:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58792 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBUPao (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Feb 2019 10:30:44 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1LFSn6u034404;
        Thu, 21 Feb 2019 15:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=iXiQgktfeKi5lJ8Pdi8w6XgPPzUkJam9ZAVNwnWvbhc=;
 b=rNzKRQSrFaSODpMcBHz3hgdgTeTJeew3N9khqNVE/1Mbeq/UYvoUJSiotiUXStUQNSDv
 hpQMLBYH+1+/QRaXZViXg5J8GKbQA3ODMS0eQ4QF+5SIt8NMuDcg5hei9patcn9ioxPt
 259XYEMu0DFGo6D7ehwP02pJNUhHtREpeUQHIWpVPx/LxOzRP/KNWYA6DsU9+Yhr23Cq
 KLic1KNh23bJTm3kAojN6wR2nJzY48/rPJZfdfUCUYbUWjEI3Wbba7+arfnFTiP+J+RW
 q2hdc3EcuZ4xnQpViNHngkhC5N9WAQk8X9BYjV5E1VS3757n9jdZOgnoZ4sLx9goGF69 dA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qpb5rrmhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 15:30:39 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1LFUc4p008212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 15:30:38 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1LFUcRE024030;
        Thu, 21 Feb 2019 15:30:38 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Feb 2019 07:30:37 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, jack@suse.cz
Subject: [PATCH v2 0/2] loop: fix two issues introduced by prior commit
Date:   Thu, 21 Feb 2019 23:33:41 +0800
Message-Id: <1550763223-21764-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9174 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=759 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210112
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch set fix two issues introduced by prior commit.


[PATCH v2 1/2] loop: do not print warn message if partition scan is successful

[PATCH v2 1/2] fixes d57f3374ba48 ("loop: Move special partition reread
handling in loop_clr_fd()") to not always print warn message even when
partition scan is successful.


[PATCH v2 2/2] loop: set GENHD_FL_NO_PART_SCAN after blkdev_reread_part()

[PATCH v2 2/2] fixes 0da03cab87e6 ("loop: Fix deadlock when calling
blkdev_reread_part()") to not set GENHD_FL_NO_PART_SCAN before partition
scan when detaching loop device from the file.

Changed since v1:
  * move the setting of lo->lo_state to Lo_unbound after partscan has finished as well
    (suggested by Jan Kara)


Dongli Zhang

