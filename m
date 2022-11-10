Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67506C433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Nov 2022 18:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiKJSpN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Nov 2022 13:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKJSpM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2022 13:45:12 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E0E64CE
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 10:45:11 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAIf5nf026097
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 10:45:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=h5nTzWmlP97Ftk8I/hQ8vmoAm4v6ZWQL6DsGNvGauG4=;
 b=cGNA7mpn3mFcfsdXQOljvaIUBLXJ5hlVbbJJ85ddG9TiRXKxR6/bbMbyKjxD5x+mH44k
 mZKgLzHaM2qpmEiNwedb9fh0iYlJnC6y+1k+GpO7Aiw4p+0RxM3NdwKkHIxMeZyBr3TE
 RKqj1QTLty8YB6jmYE14jK3Bm70c1V/3XINmjmM+67h/DFwvw84lkRsUZGFdCf+DxH6o
 ZC6y6P8flUcAnhHazXJXWpqdYzwAjPslsvThuCSX/f74YjIagv8Of3kYjSQQqO6csTdW
 PX43NuYWwwaDPdygQTmixTqD+kutgRGU36kbgK/wgscdso3yK+nWnEpfTc7yD4pSC9CG WA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3krmkeqper-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 10:45:11 -0800
Received: from twshared5287.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 10:45:10 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id BA18FB08CDE0; Thu, 10 Nov 2022 10:45:02 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
        <axboe@kernel.dk>
CC:     <stefanha@redhat.com>, <ebiggers@kernel.org>, <me@demsh.org>,
        <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/5] fix direct io device mapper errors
Date:   Thu, 10 Nov 2022 10:44:56 -0800
Message-ID: <20221110184501.2451620-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: YCcLJ0vOkPeWzz1-m5GGBmQEMQAmGg4P
X-Proofpoint-ORIG-GUID: YCcLJ0vOkPeWzz1-m5GGBmQEMQAmGg4P
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_12,2022-11-09_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The 6.0 kernel made some changes to the direct io interface to allow
offsets in user addresses. This based on the hardware's capabilities
reported in the request_queue's dma_alignment attribute.

dm-crypt, -log-writes and -integrity require direct io be aligned to the
block size. Since it was only ever using the default 511 dma mask, this
requirement may fail if formatted to something larger, like 4k, which
will result in unexpected behavior with direct-io.

Changes since v1: Added the same fix for -integrity and -log-writes

The first three were reported successfully tested by Dmitrii Tcvetkov,
but I don't have an official Tested-by: tag.

  https://lore.kernel.org/linux-block/20221103194140.06ce3d36@xps.demsh.org=
/T/#mba1d0b13374541cdad3b669ec4257a11301d1860

Keitio errors on Busch (5):
  block: make dma_alignment a stacking queue_limit
  dm-crypt: provide dma_alignment limit in io_hints
  block: make blk_set_default_limits() private
  dm-integrity: set dma_alignment limit in io_hints
  dm-log-writes: set dma_alignment limit in io_hints

 block/blk-core.c           |  1 -
 block/blk-settings.c       |  9 +++++----
 block/blk.h                |  1 +
 drivers/md/dm-crypt.c      |  1 +
 drivers/md/dm-integrity.c  |  1 +
 drivers/md/dm-log-writes.c |  1 +
 include/linux/blkdev.h     | 16 ++++++++--------
 7 files changed, 17 insertions(+), 13 deletions(-)

--=20
2.30.2

