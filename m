Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11EEC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 11:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670AC20854
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 11:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kYhGBOVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfCNLl0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:41:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44030 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfCNLl0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 07:41:26 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2EBXbNE024067;
        Thu, 14 Mar 2019 11:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=ll7wbk95E57+Rcp+dSHxDkzlncUfTnurc5502V1vdqA=;
 b=kYhGBOViSLD3R+U6K2fLxEbGZD82+zY6OXRzZu9OWSb4tti+EYISSXfY7RK+JGf9vW/2
 uWjlFKzACanLqIkpPrArL9sID5amIC7THFrbcaAVBGbtyhZKfUE/yRFprCNE1G0wxRgV
 oTi/m3XwSXBeoOoyvOV9dQbWh6sIEmO4sXmkIGan7IBGnvYpVf+lHjc1XWP5oSmPjsYm
 E7+qSLv4dYuk7ejU4vvFzC5qpiLYQA7X1H/pLpBPsN8+1TjSpG5vuD9jiO6F+UsrRqqx
 fAn0kJ/vFru8gl087R6Q2l6uAw2/k3RBS2okAk61OSLg1daefN6V5k3bSmdbGUbDY6pZ Jw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2r430f0vh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 11:41:21 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2EBfKv7011996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 11:41:20 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2EBfJmH000553;
        Thu, 14 Mar 2019 11:41:19 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Mar 2019 11:41:19 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-block@vger.kernel.org, osandov@fb.com
Cc:     jack@suse.cz
Subject: [PATCH blktests 1/2] loop/001: fix typo 'paritition' to 'partition'
Date:   Thu, 14 Mar 2019 19:45:16 +0800
Message-Id: <1552563917-8388-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9194 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=888 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903140082
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 tests/loop/001 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/loop/001 b/tests/loop/001
index b70e8c0..47f760a 100755
--- a/tests/loop/001
+++ b/tests/loop/001
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-3.0+
 # Copyright (C) 2017 Omar Sandoval
 #
-# Test loop device paritition scanning. Regression test for commit e02898b42380
+# Test loop device partition scanning. Regression test for commit e02898b42380
 # ("loop: fix LO_FLAGS_PARTSCAN hang").
 
 . tests/loop/rc
-- 
2.7.4

