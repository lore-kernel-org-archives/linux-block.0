Return-Path: <SRS0=hB6L=Q5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618DFC43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 14:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B43B2075A
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 14:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2aYk1spj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfBVOHY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:07:24 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37134 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfBVOHY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Feb 2019 09:07:24 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1ME3oCY016440;
        Fri, 22 Feb 2019 14:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=41lg6YyiA6BvTFq9WY/0yE9AGyjeG1PLGqgODsLO3gI=;
 b=2aYk1spj3P7Z+gNweLqFrfF841VbbiER2goOmJkF3MZem55fvHit5JO4ErywqO+6tCTX
 tESJkTWYoUEAEY9S/LbStMSTFRB6f8g3WbKCmQSXDWMzTUqtTa0h4vAwV5/mGRq3p6Vj
 JOQcuMAIz8Zic7CqreHJv7vVa5CbuKVQ3Wv8yosK/D/ytTil5A3HpXFgBbWEN1DKsZRg
 3q+kCCg1d0g28BsH1mSoy9kHslpl1K+rFtngjG8/H2gwNftwkCakTbD9XDb1vRPni9gy
 uUP+daHOhH5KlAdVEq5v9IaM6DoQw+bsjoBpSOx3Zz8wH3tkEvOdVJpBiMz1SxXlxhH3 Nw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qp81eqjqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Feb 2019 14:07:16 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1ME7FFe012216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Feb 2019 14:07:15 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1ME7FeJ004812;
        Fri, 22 Feb 2019 14:07:15 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Feb 2019 06:07:14 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jack@suse.cz
Subject: [PATCH v3 0/2] loop: fix two issues introduced by prior commit
Date:   Fri, 22 Feb 2019 22:10:18 +0800
Message-Id: <1550844620-6550-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9174 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=811 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902220100
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch set fix two issues introduced by prior commit.


[PATCH v3 1/2] loop: do not print warn message if partition scan is successful
[PATCH v3 1/2] fixes d57f3374ba48 ("loop: Move special partition reread
handling in loop_clr_fd()") to not always print warn message even when
partition scan is successful.


[PATCH v3 2/2] loop: set GENHD_FL_NO_PART_SCAN after blkdev_reread_part()
[PATCH v3 2/2] fixes 0da03cab87e6 ("loop: Fix deadlock when calling
blkdev_reread_part()") to not set GENHD_FL_NO_PART_SCAN before partition
scan when detaching loop device from the file.

Changed since v1:
  * move the setting of lo->lo_state to Lo_unbound after partscan has finished as well
    (suggested by Jan Kara)

Changed since v2:
  * Put the code inline in __loop_clr_fd() but not introduce new function
    (suggested by Jan Kara)


Dongli Zhang

