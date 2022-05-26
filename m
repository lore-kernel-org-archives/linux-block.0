Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71D0C433EF
	for <linux-block@archiver.kernel.org>; Thu, 26 May 2022 01:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbiEZBGd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 May 2022 21:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiEZBGc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 May 2022 21:06:32 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A559156B
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 18:06:31 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PGtc0M031514
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 18:06:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=FoehZFY8dn92kUgW6RhXQmp2lptLH/3FvzJBgwbMCsE=;
 b=GwJS0/YIAFEGci+FouybFgZt9oZzJPni8GaRCUUsbcrVCTx7usP70vL4iMFyOJGnHXzs
 j0/VMv8Q4nwqfTCEzSZ/lQi1ltfAi+zDcApMTPmGOa/PDVucG/EhVEa4dEYWpXXX+eWr
 y29/ewk9i2FATZC1/3wyQzpuFr/EWVdxNG8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g9bky75vd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 18:06:30 -0700
Received: from twshared14577.08.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 25 May 2022 18:06:29 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id D243045C0BC5; Wed, 25 May 2022 18:06:19 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 0/9] direct io dma alignment
Date:   Wed, 25 May 2022 18:06:04 -0700
Message-ID: <20220526010613.4016118-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: z2IZQbSDpgENv9SgHNA2qXHu4lFk_1Nj
X-Proofpoint-ORIG-GUID: z2IZQbSDpgENv9SgHNA2qXHu4lFk_1Nj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_07,2022-05-25_02,2022-02-23_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

This is mostly the same as v3, but with more code comments, prep
patches, replace '9' with 'SECTOR_SHIFT', and added reviews.

The biggest thing is I brought fs support back in the last patch.

For testing, I used 'fio', which has an 'iomem_align' parameter that can
force arbitrary memory offsets, even with direct-io. I created two data
integrity verifying profiles: one for raw block, the other for
filesystems, and ran each of them on two nvme namespaces. One namespace
was formatted 512b, the other was 4k.

The profile has different jobs: one smaller transfers, and one larger.
This to exercise both the simple and normal direct io cases, as well as
bio_split() conditions.

For filesystems testing, I used xfs, ext4 and btrfs to represent iomap,
and just ext2 for the older direct io. Note, btrfs falls back to
buffered anyway (see check_direct_IO()), so btrfs was essentially not
testing the direct io path.

Here is an example of one of the profiles for the raw block test:

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

Keith Busch (9):
  block: fix infiniate loop for invalid zone append
  block/bio: remove duplicate append pages code
  block: export dma_alignment attribute
  block: introduce bdev_dma_alignment helper
  block: add a helper function for dio alignment
  block/merge: count bytes instead of sectors
  block/bounce: count bytes instead of sectors
  block: relax direct io memory alignment
  fs: add support for dma aligned direct-io

 Documentation/ABI/stable/sysfs-block |   9 +++
 block/bio.c                          | 117 +++++++++++++--------------
 block/blk-merge.c                    |  41 ++++++----
 block/blk-sysfs.c                    |   7 ++
 block/bounce.c                       |  12 ++-
 block/fops.c                         |  40 ++++++---
 fs/direct-io.c                       |  11 ++-
 fs/iomap/direct-io.c                 |   3 +-
 include/linux/blkdev.h               |   5 ++
 9 files changed, 146 insertions(+), 99 deletions(-)

--=20
2.30.2

