Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD58C25B47
	for <linux-block@archiver.kernel.org>; Fri, 27 Oct 2023 18:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjJ0SUA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Oct 2023 14:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjJ0ST7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Oct 2023 14:19:59 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E04196
        for <linux-block@vger.kernel.org>; Fri, 27 Oct 2023 11:19:56 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RE5YgB006135
        for <linux-block@vger.kernel.org>; Fri, 27 Oct 2023 11:19:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=14K4aSvh9zzHeXc3eYmxxneQuIpMkFPFLr74aX4jAbM=;
 b=TGJuFBE1aQjjfurggepHZ27mNihKdx2Cf+0ozDFYC96is4pMipoL1wxmKukgQ4daoIXR
 U8S8JrYgx1OEvPlyXy2wyqzAiNZKENQHJIVAiv0oaJcQDpEdu+m/19eYTERHWTvLL0J6
 cfICDNy98PCDuTh1hB0uxaZb3cCg24DbS6XjF5pPnA6yT6PGfaHpqUGLuiY8OAyIxkKn
 FOoMGsjTg8pwNSSfbiiUSAydR3tYLBN2V8xm7OOAQ1b8feFhNTJhsFmJrTaKYZSrl5Gi
 eWKAzepqdRvvehXHXf0nKNB3LUXGbpa025Q/1V1Dnq/1Qs15LKoIYnAN1NcUvOEZw2Zw HA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u0c4pu407-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 27 Oct 2023 11:19:56 -0700
Received: from twshared16118.09.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 11:19:54 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 3ADAD20D0939E; Fri, 27 Oct 2023 11:19:36 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <io-uring@vger.kernel.org>
CC:     <axboe@kernel.dk>, <hch@lst.de>, <joshi.k@samsung.com>,
        <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/4] block integrity: directly map user space addresses
Date:   Fri, 27 Oct 2023 11:19:25 -0700
Message-ID: <20231027181929.2589937-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: H6QB65NB7nYSZsNatm27fcYAf1D9tRBz
X-Proofpoint-ORIG-GUID: H6QB65NB7nYSZsNatm27fcYAf1D9tRBz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_17,2023-10-27_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Handling passthrough metadata ("integrity") today introduces overhead
and complications that we can avoid if we just map user space addresses
directly. This patch series implements that, falling back to a kernel
bounce buffer if necessary.

v1->v2:

  Bounce to a kernel buffer if the user buffer fails to map to the
  device's integrity constraints. The user address remains pinned for
  the duration of the IO, which makes the copy out on completion safe
  within interrupt context.

  Merged up to current io_uring branch, which moved the driver owned
  flags to a different file.

Keith Busch (4):
  block: bio-integrity: directly map user buffers
  nvme: use bio_integrity_map_user
  iouring: remove IORING_URING_CMD_POLLED
  io_uring: remove uring_cmd cookie

 block/bio-integrity.c     | 202 ++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/ioctl.c | 174 +++++---------------------------
 include/linux/bio.h       |   9 ++
 include/linux/io_uring.h  |   9 +-
 io_uring/uring_cmd.c      |   1 -
 5 files changed, 240 insertions(+), 155 deletions(-)

--=20
2.34.1

