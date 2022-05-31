Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389E8C433F5
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 19:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346839AbiEaTRD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 15:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347023AbiEaTRC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 15:17:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D7BA186
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:17:00 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24VFiHXV013628
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:17:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Mbib1ViGeF93pbpt1Bcfb59VC28wz2gnpd4HmD/hJts=;
 b=AWQUm4u+BfxjPb8xSB0y0h6y1hQbdqNC04gGkOZoktGVMtiidHvuuuQg7+qAgSp0YlCu
 SP6xKkCbJJOb3f/u02y8auTIcLtZ0s1eW+aA1s+cC8ZI0IuPg6ZAsbocFTCLLnHTMir2
 kSpA0u2Xm5KdaKFYFidwnacqKIHyOormT9c= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3gbfdtg5gc-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:17:00 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 31 May 2022 12:16:58 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id C123E4924B08; Tue, 31 May 2022 12:11:38 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 00/11] direct-io dma alignment
Date:   Tue, 31 May 2022 12:11:26 -0700
Message-ID: <20220531191137.2291467-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: G7cyj6wyeuKT_ryJPDGgwkZXgwUS4HoH
X-Proofpoint-GUID: G7cyj6wyeuKT_ryJPDGgwkZXgwUS4HoH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_07,2022-05-30_03,2022-02-23_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The most significant change from v4 is the alignment is now checked
prior to building the bio. This gets the expected EINVAL error for
misaligned userspace iovecs in all cases now (Eric Biggers).

I've removed the legacy fs change, so only iomap filesystems get to use
this alignement capability (Christoph Hellwig).

The block fops check for alignment returns a bool now (Damien).

Adjusted some comments, docs, and other minor style issues.

Reviews added for unchanged or trivially changed patches, removed
reviews for ones that changed more significantly.

As before, I tested using 'fio' with forced misaligned user buffers on
raw block, xfs, and ext4 (example raw block profile below).

  [global]
  filename=3D/dev/nvme0n1
  ioengine=3Dio_uring
  verify=3Dcrc32c
  rw=3Drandwrite
  iodepth=3D64
  direct=3D1

  [small]
  stonewall
  bsrange=3D4k-64k
  iomem_align=3D4

  [large]
  stonewall
  bsrange=3D512k-4M
  iomem_align=3D100

Keith Busch (11):
  block: fix infinite loop for invalid zone append
  block/bio: remove duplicate append pages code
  block: export dma_alignment attribute
  block: introduce bdev_dma_alignment helper
  block: add a helper function for dio alignment
  block/merge: count bytes instead of sectors
  block/bounce: count bytes instead of sectors
  iov: introduce iov_iter_aligned
  block: introduce bdev_iter_is_aligned helper
  block: relax direct io memory alignment
  fs: add support for dma aligned direct-io

 Documentation/ABI/stable/sysfs-block |   9 +++
 block/bio.c                          | 114 ++++++++++++---------------
 block/blk-merge.c                    |  41 ++++++----
 block/blk-sysfs.c                    |   7 ++
 block/bounce.c                       |  13 ++-
 block/fops.c                         |  16 ++--
 fs/iomap/direct-io.c                 |   4 +-
 include/linux/blkdev.h               |  12 +++
 include/linux/uio.h                  |   2 +
 lib/iov_iter.c                       |  92 +++++++++++++++++++++
 10 files changed, 219 insertions(+), 91 deletions(-)

--=20
2.30.2

