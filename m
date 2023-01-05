Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647BBC3DA7D
	for <linux-block@archiver.kernel.org>; Thu,  5 Jan 2023 20:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbjAEUvx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Jan 2023 15:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjAEUvw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Jan 2023 15:51:52 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D911B4FCE7
        for <linux-block@vger.kernel.org>; Thu,  5 Jan 2023 12:51:51 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305HoH9W001683
        for <linux-block@vger.kernel.org>; Thu, 5 Jan 2023 12:51:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=OOa8a9pHVB2FXcdZdxRJiAyajTZToXXWLiYTSpXiJ7s=;
 b=QEKVz5OuTn38ShRc1Nrvs4xoBa1PzWciSNqQqEPNyFonDKZB5o/O/crDfiUntD2miz4y
 8tMc58fzMD1zf1MB5/MJOHzQeALYPC6JeHtGi89MUIlpNarFBm1eDBUKgwy8sb+AM593
 XEzPDnjhrWf8cjOW6S6MXGBBqU8BmnlDUh3a1zRYFoan3cf6JtlYVhy7PCuolrfvnDhz
 66zxb9Ik5lTMp+M7e6p5MAtD7o4dIQL2pbgZa5wa1qSqnWn55uQ1eolKYOPaHCLJPduG
 JTnmMSrP2y6w7jK0mRpRVbah0S/GU0K5ChYGMhHRUFSZcbHZSYdc1GMdOq4gKMBs4GkS Fg== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mwnjynb53-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 05 Jan 2023 12:51:51 -0800
Received: from twshared16996.15.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 5 Jan 2023 12:51:49 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 41071E45DCBB; Thu,  5 Jan 2023 12:51:47 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC:     <hch@lst.de>, <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 0/2] block: don't forget user settings
Date:   Thu, 5 Jan 2023 12:51:44 -0800
Message-ID: <20230105205146.3610282-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jwvGYq8qQvT3_KlDq-7jhmnUkJ7g2IU8
X-Proofpoint-GUID: jwvGYq8qQvT3_KlDq-7jhmnUkJ7g2IU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_12,2023-01-05_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

If the user overrides the max sectors for their device (which is
currently defaulting to quite a low value for modern hardware), their
request is lost on a rescan. Save it and fix the weird type issues.

Changes since v3: Fixed the unsigned long/unsigned int issue raised by
clang.

Keith Busch (2):
  block: make BLK_DEF_MAX_SECTORS unsigned
  block: save user max_sectors limit

 Documentation/ABI/stable/sysfs-block |  3 ++-
 block/blk-settings.c                 |  9 +++++++--
 block/blk-sysfs.c                    | 21 +++++++++++++++------
 drivers/block/null_blk/main.c        |  3 +--
 include/linux/blkdev.h               |  4 +++-
 5 files changed, 28 insertions(+), 12 deletions(-)

--=20
2.30.2

