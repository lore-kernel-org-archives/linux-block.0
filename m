Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63848C7EE37
	for <linux-block@archiver.kernel.org>; Fri,  9 Jun 2023 20:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjFIUpq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Jun 2023 16:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFIUpp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Jun 2023 16:45:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A2E26B1
        for <linux-block@vger.kernel.org>; Fri,  9 Jun 2023 13:45:44 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 359GZHVJ029943
        for <linux-block@vger.kernel.org>; Fri, 9 Jun 2023 13:45:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=1kZjeiWSwR0l0AHDID9w8iNkq6BqXuyHlq5IGLxTmXc=;
 b=ihq0nR7GzmXeIHgpFcbkUS/Wt0cGqkh8v7JpOh4Oud+ZAXc/WN5U6PoFch22p1hPOuLF
 PAikMmi5HjgondPR1YCGqltq3fkjugpi2+doa7uo/qU4kURdQsyJf0zU32OF3MZtWnQ8
 N/B5nGvI+8Dp6sUlToexLxriCPEE4PluHPu3N2uA4rmIo7u4J/xmsd82MvBTFlDMOS7y
 0JINKFKYARUOe6upHPA34q76ieQIYcHcykHekjB+JBGOqT82V0Oue4+6B6Pfw7avT8Tb
 OE57xzOsgDL7qfxAy+JEkBysaXONHBkvQASMNfQl8t7KlWKeb3LLNI5g815IACi8L1R1 uw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3r3ugpex1b-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 09 Jun 2023 13:45:43 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 13:45:39 -0700
Received: from twshared5974.02.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 13:45:39 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id E007F19D4CC35; Fri,  9 Jun 2023 13:45:19 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <io-uring@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <hch@lst.de>, <axboe@kernel.dk>
CC:     <sagi@grimberg.me>, <joshi.k@samsung.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/2] enhanced nvme uring command polling
Date:   Fri, 9 Jun 2023 13:45:15 -0700
Message-ID: <20230609204517.493889-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9WBcEeXx_cljwSYB0BFzLSotSBBSyHyL
X-Proofpoint-GUID: 9WBcEeXx_cljwSYB0BFzLSotSBBSyHyL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_16,2023-06-09_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Changes from previous version:

  Used the new hctx polling for the existing request polling use case.
  (Christoph)

  Open coded the qc/rq conversion functions since they're simple and
  have one caller each. (Christoph)

  Merged up to block/for-6.5/io_uring because (1) this series touches
  io_uring uapi, and (2) using this baseline prevents a future merge
  conflict.

Keith Busch (2):
  block: add request polling helper
  nvme: improved uring polling

 block/blk-mq.c                | 48 ++++++++++++++++--------
 drivers/nvme/host/ioctl.c     | 70 ++++++++++-------------------------
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/nvme.h      |  2 -
 include/linux/blk-mq.h        |  2 +
 include/uapi/linux/io_uring.h |  2 +
 6 files changed, 56 insertions(+), 70 deletions(-)

--=20
2.34.1

