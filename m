Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C36AC282C2
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 09:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC43222CA
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 09:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cT4Hbafv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387415AbfBMJx2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:53:28 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48686 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfBMJx2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 04:53:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1D9mgHN158205;
        Wed, 13 Feb 2019 09:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=16pKHh2rAxYe7Xu9JR8PkSQC6HvrBJBMQjAObWw12rA=;
 b=cT4Hbafv8k0IVWOH7YBe2bn002aCdFNzdJhxtakPykLzJJ69BHyiUfC0pzNIoMECbQ6n
 ZX27zZQUpb84wBWMnrlAVq8hMUTzWleK5sBHO7V5a7umVP/IEKOjLMz6L3F7iA7TI+gH
 TeCsz9n4V3CMe8lBmjzSxXKsVsc0WyuTmI0XrE/urCO+w7hxi42LzxIETvPOZDIaJp1P
 HvtEpvsRKcolpGoCg0V9B7SEg8TDmznDbG1le3Vgg56SGt1o33WU0uyHrHIeCOBfmUNH
 eA/8HMEefDpG5jev+CFqvT343GnSsbHXwDaHqJHJjn1YeTSUwhVsIZEkF0Evo/5YwLGi YQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qhrekh0ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 09:53:13 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1D9rDFd019226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 09:53:13 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1D9rCZ7026330;
        Wed, 13 Feb 2019 09:53:12 GMT
Received: from localhost.localdomain (/116.239.187.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 09:53:12 +0000
From:   Bob Liu <bob.liu@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca,
        Bob Liu <bob.liu@oracle.com>
Subject: [RFC PATCH v2 0/9] Block/XFS: Support alternative mirror device retry
Date:   Wed, 13 Feb 2019 17:50:35 +0800
Message-Id: <20190213095044.29628-1-bob.liu@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130072
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

This patch prototype this mirror retry idea by:
* Adding @nr_mirrors to struct request_queue which is similar as
  blk_queue_nonrot(), filesystem can grab device request queue and check max
  mirrors this block device has.
  Helper functions were also added to get/set the nr_mirrors.

* Introducing bi_rd_hint just like bi_write_hint, but bi_rd_hint is a long bitmap
in order to support stacked layer case.

* Modify md/raid1 to support this retry feature.

* Adapter xfs to use this feature.
  If the read verify fails, we loop over the available mirrors and retry the read.

* Rewrite retried read
  When the read verification fails, but the retry succeedes
  write the buffer back to correct the bad mirror

* Add tracepoints and logging to alternate device retry.
  This patch adds new log entries and trace points to the alternate device retry
  error path.

Changes v2:
- No more reuse bi_write_hint
- Stacked layer support(see patch 4/9)
- Other feedback fix

Allison Henderson (5):
  Add b_alt_retry to xfs_buf
  xfs: Add b_rd_hint to xfs_buf
  xfs: Add device retry
  xfs: Rewrite retried read
  xfs: Add tracepoints and logging to alternate device retry

Bob Liu (4):
  block: add nr_mirrors to request_queue
  block: add rd_hint to bio and request
  md:raid1: set mirrors correctly
  md:raid1: rd_hint support and consider stacked layer case

 Documentation/block/biodoc.txt |   3 +
 block/bio.c                    |   1 +
 block/blk-core.c               |   4 ++
 block/blk-merge.c              |   6 ++
 block/blk-settings.c           |  24 +++++++
 block/bounce.c                 |   1 +
 drivers/md/raid1.c             | 123 ++++++++++++++++++++++++++++++++-
 fs/xfs/xfs_buf.c               |  58 +++++++++++++++-
 fs/xfs/xfs_buf.h               |  14 ++++
 fs/xfs/xfs_trace.h             |   6 +-
 include/linux/blk_types.h      |   1 +
 include/linux/blkdev.h         |   4 ++
 include/linux/types.h          |   3 +
 13 files changed, 244 insertions(+), 4 deletions(-)

-- 
2.17.1

