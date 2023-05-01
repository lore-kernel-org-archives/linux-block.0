Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBDFC77B61
	for <linux-block@archiver.kernel.org>; Mon,  1 May 2023 15:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjEAPd1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 May 2023 11:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjEAPd0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 11:33:26 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0F6118
        for <linux-block@vger.kernel.org>; Mon,  1 May 2023 08:33:22 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341AnmLx016456
        for <linux-block@vger.kernel.org>; Mon, 1 May 2023 08:33:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=iLgVdrB4oVPgC3k99vUC3+6QNoVQOw4/ZWLtGA4hzNQ=;
 b=OG/ZId0D9ynI23fxnLyv4CjDrHEs3F1bg+hEa0G9+7X6yu9cETjK2Wwx9JhOGDzYdYLB
 TRAvI/RgehqYIXFSu0c3oiMJavvg/siNH8cCBwAUS4MubMHIPo1wTKp/A+9Ln6+sUAQ2
 Kkty4YTxeMrqL+JbxahHCflg3XlfOb1YSdZs8sfLA+V/oyG6B1wPjltvWfFbW0jbnl5w
 sKh+kuB58TFuH43P/KGguJzgT4WFHkSekKzzLn7N6W8sAP4E0/IqEmObW5BGWoZleS0s
 I/+cB/w80oJvXM9BR2I+HEFeYSk1Wm5T3Nky9m15IExQtflRZF7oOkcbLN3/khe0DnCH 2g== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qac0g1k5r-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 01 May 2023 08:33:21 -0700
Received: from twshared4006.05.ash7.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 1 May 2023 08:33:20 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 3A1F01777ADBA; Mon,  1 May 2023 08:33:07 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <joshi.k@samsung.com>, <axboe@kernel.dk>, <hch@lst.de>,
        <xiaoguang.wang@linux.alibaba.com>
CC:     Keith Busch <kbusch@kernel.org>
Subject: [RFC 0/3] nvme uring passthrough diet
Date:   Mon, 1 May 2023 08:33:03 -0700
Message-ID: <20230501153306.537124-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: lB3dEHoc3X3uhVCWJwJ87QcjCfHSPvJg
X-Proofpoint-ORIG-GUID: lB3dEHoc3X3uhVCWJwJ87QcjCfHSPvJg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_08,2023-04-27_01,2023-02-09_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

When you disable all the optional features in your kernel config and
request queue, it looks like the normal request dispatching is just as
fast as any attempts to bypass it. So let's do that instead of
reinventing everything.

This doesn't require additional queues or user setup. It continues to
work with multiple threads and processes, and relies on the well tested
queueing mechanisms that track timeouts, handle tag exhuastion, and sync
with controller state needed for reset control, hotplug events, and
other error handling.

Marked RFC right now because I haven't tested out multipath or teardown.

Keith Busch (3):
  nvme: skip block cgroups for passthrough commands
  nvme: fix cdev name leak
  nvme: create special request queue for cdev

 drivers/nvme/host/core.c  | 39 ++++++++++++++++++++++++++++++++++-----
 drivers/nvme/host/ioctl.c |  6 +++---
 drivers/nvme/host/nvme.h  |  1 +
 include/linux/bio.h       |  7 ++++++-
 4 files changed, 44 insertions(+), 9 deletions(-)

--=20
2.34.1

