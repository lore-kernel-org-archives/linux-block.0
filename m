Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A487ECAAA1
	for <linux-block@archiver.kernel.org>; Tue,  6 Sep 2022 23:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiIFXAj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Sep 2022 19:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiIFXAi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Sep 2022 19:00:38 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904B52B639
        for <linux-block@vger.kernel.org>; Tue,  6 Sep 2022 16:00:37 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Mse28018768
        for <linux-block@vger.kernel.org>; Tue, 6 Sep 2022 16:00:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=rAGgpzVlQCp3oDb07MJiMkiNOXWEd2leUOKvHZRl/dM=;
 b=HQ20sqiIrP9otCn96yM6454hyXwi6ZGTGYPdLmwLmyNIeuaCm+L0R37u+/GBW71LBa+x
 wS7XFOBDN80abZ04H1vXiK2MPMl8ciK8g8ij0XcwlFpGbPh3C2Mz6cCWgsEQo/tn+xGw
 FrVPpllA0E1W5GC1Q7rO/+t4ezm+NC4BcUE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jc4eyt96b-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 06 Sep 2022 16:00:36 -0700
Received: from twshared30313.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 16:00:35 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id C6C1E84BC4B0; Tue,  6 Sep 2022 16:00:30 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/2] sbitmap wake fixes
Date:   Tue, 6 Sep 2022 16:00:27 -0700
Message-ID: <20220906230029.1287526-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: K8RQFDeTrVS5kxJYJuWtvuqqcWtKLL3N
X-Proofpoint-ORIG-GUID: K8RQFDeTrVS5kxJYJuWtvuqqcWtKLL3N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

changes from v2:

  Adding a prep patch that fixes a condition that can leave the wait_cnt
  at the wrong value.

  Changed the number to wake up to account for the number of bits
  released in previous batches instead of just the current batch.

Keith Busch (2):
  sbitmap: check waitqueue_active prior to decrement
  sbitmap: fix batched wait_cnt accounting

 block/blk-mq-tag.c      |  2 +-
 include/linux/sbitmap.h |  3 ++-
 lib/sbitmap.c           | 36 ++++++++++++++++++++----------------
 3 files changed, 23 insertions(+), 18 deletions(-)

--=20
2.30.2

