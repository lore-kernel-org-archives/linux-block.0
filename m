Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE653C433EF
	for <linux-block@archiver.kernel.org>; Mon, 23 May 2022 21:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiEWVBs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 May 2022 17:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiEWVBn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 May 2022 17:01:43 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9522DD7C
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 14:01:41 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NKGuKC005150
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 14:01:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=5fMjlk145vpbIKp77AqFBrgeVY3SvIMRB4KWULUSKNY=;
 b=B2C3kj7/87URDm1YVOadEpPJFu0LUeaf3B6rcFiQw3EeVLEgXmpyMO1B0gpzIuh7B9ka
 qTaHIs1qQGn4R9r74YTd5FEg1ErGNAbcIuCVWzd+gupGs3cLNqJM6OTHTLpm9CWmXzSl
 gCaO2Z4RJLC/ggl0ommT0hBehoL6TSfbbeY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g6wtx3s0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 14:01:40 -0700
Received: from twshared8508.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 23 May 2022 14:01:39 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 5CB19446414C; Mon, 23 May 2022 14:01:34 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/6] direct io dma alignment
Date:   Mon, 23 May 2022 14:01:13 -0700
Message-ID: <20220523210119.2500150-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Q2V0pD0uGyigGMhYLyYgVYrKFh0A2tuf
X-Proofpoint-GUID: Q2V0pD0uGyigGMhYLyYgVYrKFh0A2tuf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_09,2022-05-23_01,2022-02-23_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Here is the 3rd version enabling non-block aligned user space addresses
for O_DIRECT.

Changes since v2:

  Folded in improvements cleanin gup zone append pages (Christoph)

  Added documentation the exported attribute (Bart)

  Split bdev_dma_alignment() into its own patch (Christoph)

  Removed fs/ from implementing support for these address offsets for
  now

  Fixed up a couple places assuming SECTOR_SIZE multiple bv_len

On that last point, I searched through much of the code and found a few
other places that also assumed this bv_len size, but they didn't apply
to this change since they don't set 'dma_alignment'. This got me
thinking, though, should this be a new attribute, 'dio_alignment',
instead of using the pre-existing 'dma_alignment' for this purpose? Or
is it clear enough that drivers setting the existing attribute ought to
know what they're getting into?

Keith Busch (6):
  block/bio: remove duplicate append pages code
  block: export dma_alignment attribute
  block: introduce bdev_dma_alignment helper
  block/merge: count bytes instead of sectors
  block/bounce: count bytes instead of sectors
  block: relax direct io memory alignment

 Documentation/ABI/stable/sysfs-block |   9 ++
 block/bio.c                          | 118 +++++++++++++--------------
 block/blk-merge.c                    |  35 ++++----
 block/blk-sysfs.c                    |   7 ++
 block/bounce.c                       |   5 +-
 block/fops.c                         |  41 +++++++---
 include/linux/blkdev.h               |   5 ++
 7 files changed, 127 insertions(+), 93 deletions(-)

--=20
2.30.2

