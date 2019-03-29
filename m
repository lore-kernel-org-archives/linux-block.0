Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478F9C4360F
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DA32173C
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NOwXYeY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfC2OYh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:24:37 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58390 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfC2OYh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 10:24:37 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2TEDr48004516;
        Fri, 29 Mar 2019 14:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=NhsbCJkVn8eg+6dbm/erLnyPd4CV77cHPOVL/X2BcFM=;
 b=NOwXYeY+EdFXL5GjBkgWBqkTCrb1yd5NHSeQKyHvtSOitYLnk98qtCuSMzTvI31UNQHz
 Jdh85BhYTffExQcbaYyUrtpa9IilS/9zCkWcyvOGTcsUqCmeiBHrWUU9X6uWiNt/Fxde
 rEnDK1k+XyHy8hiNeGUxn3vVlikZOnwVL864cs+jwWEdBEFFF2BQDzXHYa/xsnv5sLEA
 KoEMNldysO4m6ttjdFeHKGsA3zwCbb0T8zY2ERvwmeTMdeQnCICZMm1Hi1HpdGaml+Yb
 D8Wazw/JYkpVJEy0+qwmV9n6eVIkaA5CqlO9BYDFWYgLFQcWptd+Ciplwp6DSzdf2GVS Ng== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2re6g1crda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:24:20 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2TEOEbW006429
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:24:15 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2TEOCXR019030;
        Fri, 29 Mar 2019 14:24:13 GMT
Received: from localhost.localdomain (/180.165.90.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 07:24:11 -0700
From:   Bob Liu <bob.liu@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca,
        axboe@kernel.dk, tytso@mit.edu, Bob Liu <bob.liu@oracle.com>
Subject: [RFC PATCH v3 0/3] Block/XFS: Support alternative mirror device retry
Date:   Fri, 29 Mar 2019 22:23:43 +0800
Message-Id: <20190329142346.1677-1-bob.liu@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9210 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=977 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903290102
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Motivation:
When fs data/metadata checksum mismatch, lower block devices may have other
correct copies. e.g. If XFS successfully reads a metadata buffer off a raid1 but
decides that the metadata is garbage, today it will shut down the entire
filesystem without trying any of the other mirrors.  This is a severe
loss of service, and we propose these patches to have XFS try harder to
avoid failure.

This patch prototype this mirror retry idea by adding a function verifier
callback to submit_bio.  Filesystem can use submit_bio_verify() to pass a
callback to the block layer which can then be used to verify if the data read is
correct.

Reused some of bio-integrity code, can be separated if necessary.

Changes v3:
- Total new implementation, pass down verify function to block layer as
  suggested by Dave.

Bob Liu (3):
  block: introduce submit_bio_verify()
  block: verify data when endio
  fs: xfs: add read_verifier() function

 block/bio-integrity.c     | 45 +++++++++++++++++++++++++++++++++++++++
 block/bio.c               |  3 +++
 block/blk-core.c          | 17 ++++++++++++---
 block/blk.h               |  8 +++++++
 block/bounce.c            |  1 +
 drivers/md/raid1.c        |  1 +
 drivers/md/raid5-ppl.c    |  1 +
 fs/xfs/xfs_buf.c          | 23 ++++++++++++++++++--
 fs/xfs/xfs_buf.h          |  1 +
 include/linux/bio.h       |  2 ++
 include/linux/blk_types.h |  5 +++++
 11 files changed, 102 insertions(+), 5 deletions(-)

-- 
2.17.1
