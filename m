Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA31DC25B0D
	for <linux-block@archiver.kernel.org>; Fri,  5 Aug 2022 16:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241089AbiHEQZ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Aug 2022 12:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237901AbiHEQYx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Aug 2022 12:24:53 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DB71DA5A
        for <linux-block@vger.kernel.org>; Fri,  5 Aug 2022 09:24:52 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 275G7ZFA002830
        for <linux-block@vger.kernel.org>; Fri, 5 Aug 2022 09:24:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=8lReZdcTYdIHAj71wx1nJeUfZ+0HnE66EFO+CeaoAJE=;
 b=hDLVPUbDviGVwoUuIjajlQlposOw+/tuaTOc9OU/mScEWupEPQ3ufruiOeBG/ak0IMu2
 lhS7pEo/XM0v+FsjsHuoEdY55hUT/clKJEmL6XFkUXa3RVi+7uYGqsp1Hcax1jvKH4Db
 mi/TMLpelQNQkdC/mBW3Mn1IUwSTaJUQIgE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hrfvf84dh-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 05 Aug 2022 09:24:52 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 09:24:50 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 3C17F70374FD; Fri,  5 Aug 2022 09:24:45 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <io-uring@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Team <Kernel-team@fb.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/7] dma mapping optimisations
Date:   Fri, 5 Aug 2022 09:24:37 -0700
Message-ID: <20220805162444.3985535-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: sOAXvebUV9KKwvbNN2RA-hN5Kz6P0i_-
X-Proofpoint-ORIG-GUID: sOAXvebUV9KKwvbNN2RA-hN5Kz6P0i_-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_08,2022-08-05_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Changes since v2:

  Fixed incorrect io_uring io_fixed_file index validit checksy: this shou=
ld
  have been validating the file_ptr (Ammar)

  Various micro-optimizations: move up dma in iov type checks, skip
  iov_iter_advance on async IO (Jens).

  NVMe driver cleanups splitting the fast and slow paths.

  NVMe driver prp list setup fixes when using the slow path.

Summary:

A user address undergoes various represenations for a typical read or
write command. Each consumes memory and CPU cycles. When the backing
storage is NVMe, the sequence looks something like the following:

  __user void *
  struct iov_iter
  struct pages[]
  struct bio_vec[]
  struct scatterlist[]
  __le64[]

Applications will often use the same buffer for many IO, so these
potentially costly per-IO transformations to reach the exact same
hardware descriptor can be skipped.

The io_uring interface already provides a way for users to register
buffers to get to 'struct bio_vec[]'. That still leaves the scatterlist
needed for the repeated dma_map_sg(), then transform to nvme's PRP list
format.

This series takes the registered buffers a step further. A block driver
can implement a new .dma_map() callback to reach the hardware's DMA
mapped address format, and return a cookie so a user can reference it
later for any given IO. When used, the block stack can skip significant
amounts of code, improving CPU utilization and IOPs.

The implementation is currently limited to mapping a registered buffer
to a single io_uring fixed file.

Keith Busch (7):
  blk-mq: add ops to dma map bvec
  file: add ops to dma map bvec
  iov_iter: introduce type for preregistered dma tags
  block: add dma tag bio type
  io_uring: introduce file slot release helper
  io_uring: add support for dma pre-mapping
  nvme-pci: implement dma_map support

 block/bdev.c                   |  20 +++
 block/bio.c                    |  24 ++-
 block/blk-merge.c              |  19 ++
 block/fops.c                   |  24 ++-
 drivers/nvme/host/pci.c        | 314 +++++++++++++++++++++++++++++++--
 fs/file.c                      |  15 ++
 include/linux/bio.h            |  22 ++-
 include/linux/blk-mq.h         |  24 +++
 include/linux/blk_types.h      |   6 +-
 include/linux/blkdev.h         |  16 ++
 include/linux/fs.h             |  20 +++
 include/linux/io_uring_types.h |   2 +
 include/linux/uio.h            |   9 +
 include/uapi/linux/io_uring.h  |  12 ++
 io_uring/filetable.c           |  34 ++--
 io_uring/filetable.h           |  10 +-
 io_uring/io_uring.c            | 139 +++++++++++++++
 io_uring/net.c                 |   2 +-
 io_uring/rsrc.c                |  27 +--
 io_uring/rsrc.h                |  10 +-
 io_uring/rw.c                  |   2 +-
 lib/iov_iter.c                 |  27 ++-
 22 files changed, 724 insertions(+), 54 deletions(-)

--=20
2.30.2

