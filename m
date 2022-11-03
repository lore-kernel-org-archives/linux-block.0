Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC730C4332F
	for <linux-block@archiver.kernel.org>; Thu,  3 Nov 2022 15:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiKCP0P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Nov 2022 11:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiKCP0O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Nov 2022 11:26:14 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A450D5A
        for <linux-block@vger.kernel.org>; Thu,  3 Nov 2022 08:26:13 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3CAdCF010471
        for <linux-block@vger.kernel.org>; Thu, 3 Nov 2022 08:26:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=c1LL6PntKBv/Iz5G0/ylwJgKXQ1mJtEBPZcaAIbotZI=;
 b=kw1lx7xNXqxZJKF5KC0c55nZo82fgTbqPllD6VrHrJAk36q1uKG2U1ZUaZsXRUs4JG3d
 Hq8uCP5GOkRpELZUDE82ECSgwF79WqIOcvbBdrrzDzmVRvEDjiZtP2zu8p12KAIh3u8t
 m2Uh+EbqRnyQtskNJlNQCnfGoDQpFv0mWlOrdz2Fh8gAeDMTepOQ80IisRgLtyuKIv/F
 IwmMjCThwPOr6gjJOhOYflAHVDyF7B5Kbi+MLOL9TqlFSKoM72u3qjq3iBo4vB80gnpz
 o31BTc1tAtY7R2ID5SZc+rZ0SmJWkPx0U6ZmF3r8T1F2sNAtCp6XauYttJ2YgGoyoghA dA== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kmddh1kqu-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 03 Nov 2022 08:26:12 -0700
Received: from twshared21592.39.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 08:26:10 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 1652BAA9A072; Thu,  3 Nov 2022 08:26:00 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
        <axboe@kernel.dk>
CC:     <stefanha@redhat.com>, <ebiggers@kernel.org>, <me@demsh.org>,
        <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/3] fix direct io errors on dm-crypt
Date:   Thu, 3 Nov 2022 08:25:56 -0700
Message-ID: <20221103152559.1909328-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UDu8OgsPL2zw2lRQVmx4T_jpF0oM4DqC
X-Proofpoint-GUID: UDu8OgsPL2zw2lRQVmx4T_jpF0oM4DqC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The 6.0 kernel made some changes to the direct io interface to allow
offsets in user addresses. This based on the hardware's capabilities
reported in the request_queue's dma_alignment attribute.

dm-crypt requires direct io be aligned to the block size. Since it was
only ever using the default 511 dma mask, this requirement may fail if
formatted to something larger, like 4k, which will result in unexpected
behavior with direct-io.

There are two parts to fixing this:

  First, the attribute needs to be moved to the queue_limit so that it
  can properly stack with device mappers.

  Second, dm-crypt provides its minimum required limit to match the
  logical block size.

Keith Busch (3):
  block: make dma_alignment a stacking queue_limit
  dm-crypt: provide dma_alignment limit in io_hints
  block: make blk_set_default_limits() private

 block/blk-core.c       |  1 -
 block/blk-settings.c   |  9 +++++----
 block/blk.h            |  1 +
 drivers/md/dm-crypt.c  |  1 +
 include/linux/blkdev.h | 16 ++++++++--------
 5 files changed, 15 insertions(+), 13 deletions(-)

--=20
2.30.2

