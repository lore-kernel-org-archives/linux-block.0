Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17141C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 03:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D192420873
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 03:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HBC8OPj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D192420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeK1Own (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:52:43 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49882 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeK1Own (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 09:52:43 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAS3o1w4189542;
        Wed, 28 Nov 2018 03:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=doPh0A99tbpzeyOCosBZMXsWIBcU4kA51C4DZdtS5pY=;
 b=HBC8OPj9f6zELOxmIzRbGoM46zUv/6fuzwTDifggjBzqGCJd32nz9Yokq1wnSM3nV4yp
 SFcNjHaur9PAHWJCZH6C0P+FH39y3+4VjGq8/6eM1QTnOVfAItVZ8gLeuIJoMHOo68L8
 WEjvrSB0f9JhgYw9NBUeGz+grV0Q4X3eq5bfniT1CJ7Vq5dOxHQJF+UAF7ULuDWaO9Pt
 oyoGRw13UySV7XZe2XKvmPaFmuto/h8cRv6Q6rIUUkVM+mWZi19ywlZL4d+gDZ3pWAn0
 pkE+1NiBFkgn3EJjvgUhue8qgAPjBlUMsUBp7HBiZRbJc+vIzm5wxB8QrTPn66zwcijN og== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2nxy9r7rbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 03:52:35 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAS3qTUV018629
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 03:52:29 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAS3qTjx005851;
        Wed, 28 Nov 2018 03:52:29 GMT
Received: from localhost.localdomain (/70.176.225.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 19:52:29 -0800
From:   Allison Henderson <allison.henderson@oracle.com>
To:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     martin.petersen@oracle.com, shirley.ma@oracle.com,
        bob.liu@oracle.com, allison.henderson@oracle.com
Subject: [RFC PATCH v1 0/7] Block/XFS: Support alternative mirror device retry
Date:   Tue, 27 Nov 2018 20:49:44 -0700
Message-Id: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9090 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811280033
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

* Expanding bi_write_hint to bi_rw_hint, now @bi_rw_hint has three meanings.
 1.Original write_hint.
 2.end_io() will update @bi_rw_hint to reflect which mirror this i/o really happened.
 3.Fs set @bi_rw_hint to force driver e.g raid1 read from a specific mirror.

* Modify md/raid1 to support this retry feature.

* Add b_rw_hint to xfs_buf
  This patch adds a new field b_rw_hint to xfs_buf.  We will use this to set the
  new bio->bi_rw_hint when submitting the read request, and also to store the
  returned mirror when the read compleates

* Add device retry
  This patch add some logic to xfs_buf_read_map.  If the read verify
  fails, we loop over the available mirrors and retry the read

* Rewrite retried read
  When the read verification fails, but the retry succeedes
  write the buffer back to correct the bad mirror

* Add tracepoints and logging to alternate device retry.
  This patch adds new log entries and trace points to the alternate device retry
  error path.

We're not planning to take over all 16 bits of the read hint field; just looking for
feedback about the sanity of the overall approach.

Allison Henderson (4):
  xfs: Add b_rw_hint to xfs_buf
  xfs: Add device retry
  xfs: Rewrite retried read
  xfs: Add tracepoints and logging to alternate device retry

Bob Liu (3):
  block: add nr_mirrors to request_queue
  block: expand write_hint of bio/request to rw_hint
  md: raid1: handle bi_rw_hint accordingly

 Documentation/block/biodoc.txt |  7 ++++++
 block/bio.c                    |  2 +-
 block/blk-core.c               | 13 ++++++++++-
 block/blk-merge.c              |  8 +++----
 block/blk-settings.c           | 18 ++++++++++++++
 block/bounce.c                 |  2 +-
 drivers/md/raid1.c             | 33 ++++++++++++++++++++++----
 drivers/md/raid5.c             | 10 ++++----
 drivers/md/raid5.h             |  2 +-
 drivers/nvme/host/core.c       |  2 +-
 fs/block_dev.c                 |  6 +++--
 fs/btrfs/extent_io.c           |  3 ++-
 fs/buffer.c                    |  3 ++-
 fs/direct-io.c                 |  3 ++-
 fs/ext4/page-io.c              |  7 ++++--
 fs/f2fs/data.c                 |  2 +-
 fs/iomap.c                     |  3 ++-
 fs/mpage.c                     |  2 +-
 fs/xfs/xfs_aops.c              |  4 ++--
 fs/xfs/xfs_buf.c               | 53 ++++++++++++++++++++++++++++++++++++++++--
 fs/xfs/xfs_buf.h               |  8 +++++++
 fs/xfs/xfs_trace.h             |  6 ++++-
 include/linux/blk_types.h      |  2 +-
 include/linux/blkdev.h         |  5 +++-
 24 files changed, 169 insertions(+), 35 deletions(-)

-- 
2.7.4

