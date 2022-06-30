Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643E2CCA47B
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 20:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbiF3Umq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 16:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbiF3Umo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 16:42:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2FEB491
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 13:42:43 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UH0plA002850
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 13:42:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=0xc3C+DXiwfPrlt4XSU9WIovS0CAm1/2e62U38mNxyc=;
 b=ZFsXMrTM1X8gcmIiwcWiyqIlNCU3OO7An8JzvXGBgo6qoY9vJ2Ppys7HzRhDjgYR+yWO
 6jhppSbO0mJgQMbW00nHDiuoGtvZDHizQIrblgYllWZ4C7FY6Cym9lBxA4KPZKpY/V+I
 SWCVmaNgEh0KIx/QGhr+ZfQETEGAZnAX2UU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h150eebc4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 13:42:42 -0700
Received: from twshared14577.08.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:41 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 1293D5932DB4; Thu, 30 Jun 2022 13:42:29 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 00/12] block: support for partial sector reads
Date:   Thu, 30 Jun 2022 13:42:00 -0700
Message-ID: <20220630204212.1265638-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: xsbAt_Z1Cy6l7aBgGCY4UkDLqNh4d2HV
X-Proofpoint-ORIG-GUID: xsbAt_Z1Cy6l7aBgGCY4UkDLqNh4d2HV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_14,2022-06-28_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

At LSFMM nearly 2 months ago, I discussed how some storage hardware
supports the ability to read at granularities smaller than a sector, and
the nvme protocol feature that enables this capability, "bit buckets".
This is useful in scenarios where only parts of sectors are used by the
application, and the primary benefits to support this are:

  * Improved link bandwidth usage
  * Reduced memory utilization

This series enables the block layer and nvme to set up bit bucket
descriptors for read commands, then enables user space direct-io to make
use of this capability by allowing the user to specify an arbitrary
offset and length. This allows truncating an arbitrary number of bytes
off sectors from the front and end of the transfer. =20

There are no current in-kernel users beyond the direct-io cases, but
this could also be used for to truncate bytes out of the middle of a
transfer as well. For example, if you wanted to read a page and knew you
wer going to immediately dirty some number of bytes in the middle, you
could set up a read request to skip those in the data transfer.

Keith Busch (12):
  block: move direct io alignment check to common
  iomap: save copy of bdev for direct io
  iomap: get logical block size directly
  iomap: use common blkdev alignment check
  block: add bit bucket capabilities
  nvme: add support for bit buckets
  block: allow copying pre-registered bvecs
  block: add bio number of vecs helper for partials
  block: add partial sector parameter helper
  block: add direct-io partial sector read support
  iomap: add direct io partial sector read support
  block: export and document bit_bucket attribute

 Documentation/ABI/stable/sysfs-block |  9 +++
 block/bio.c                          | 42 +++++++++++-
 block/blk-core.c                     |  5 ++
 block/blk-merge.c                    |  3 +-
 block/blk-mq.c                       |  2 +
 block/blk-sysfs.c                    |  3 +
 block/fops.c                         | 97 ++++++++++++++++++----------
 drivers/nvme/host/core.c             |  3 +
 drivers/nvme/host/nvme.h             |  6 ++
 drivers/nvme/host/pci.c              | 17 ++++-
 fs/iomap/direct-io.c                 | 43 ++++++++----
 include/linux/bio.h                  | 11 ++++
 include/linux/blk-mq.h               |  2 +
 include/linux/blk_types.h            |  1 +
 include/linux/blkdev.h               | 41 ++++++++++++
 include/linux/nvme.h                 |  2 +
 16 files changed, 236 insertions(+), 51 deletions(-)

--=20
2.30.2

