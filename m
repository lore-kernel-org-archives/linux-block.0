Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E74DC6FD1D
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 00:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCVAYA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Mar 2023 20:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCVAX6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 20:23:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6052FCE0
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 17:23:57 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 32M02Nk1007256
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 17:23:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=PqBhCyiwe+FbLj/O2dAwfE8VOdddZLf4CUTWFk8SpJw=;
 b=cSPTdatEUayRsDxdc0tqEpABPsy8Ld5arFoUP/JSqM5MVd5jHB68tcqUIgwXTJWK9vFl
 drpAW4Jcsh9CW2ZsQXAx+ys5viLF1Q/12FQourXrEEfLPZ7c2Ofh3i1hOsSqcJgew+7u
 Uy6RVLGkVcMjxNCUobZPWJ3zL78EWFQLEu9w43gjkE5prawgJqLM9wdIJzk+//xn326A
 eIYRBgylzg9XcTe0vHDVUUFgNK4oDOLOjve7zQyoQmy+A88amv/2ENdYiYQ8Uyrg4fjj
 Rw/CH+dAjm0+x2E9yH65ccIjcVoeh0c8Wz7nPXsE3By5eDEcjVnFAF9ts0bzCFHVzhIR uQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3pf7vkp2yc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 17:23:57 -0700
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 21 Mar 2023 17:23:55 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id C32131419697D; Tue, 21 Mar 2023 17:23:51 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC:     Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/3] nvme fabrics polling fixes
Date:   Tue, 21 Mar 2023 17:23:47 -0700
Message-ID: <20230322002350.4038048-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: aPz6avaE7svMtRIws-JscRDj3O1g0AWA
X-Proofpoint-ORIG-GUID: aPz6avaE7svMtRIws-JscRDj3O1g0AWA
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

I couldn't test the existing tcp or rdma options, so I had to make a
loop poll option. The last patch fixes the polling queues when used with
fabrics.

Note, this depends on patch I sent earlier today that I should have just
included in this series:

  https://lore.kernel.org/linux-block/20230321215001.2655451-1-kbusch@meta.=
com/T/#u

Keith Busch (3):
  nvme-fabrics: add queue setup helpers
  nvme: add polling options for loop target
  blk-mq: directly poll requests

 block/blk-mq.c              |  4 +-
 drivers/nvme/host/fabrics.c | 95 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h |  5 ++
 drivers/nvme/host/rdma.c    | 81 ++-----------------------------
 drivers/nvme/host/tcp.c     | 92 ++---------------------------------
 drivers/nvme/target/loop.c  | 63 ++++++++++++++++++++++--
 6 files changed, 168 insertions(+), 172 deletions(-)

--=20
2.34.1

