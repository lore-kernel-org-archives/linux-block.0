Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D13C04A95
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 06:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiI2GYi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 02:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbiI2GYh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 02:24:37 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0E8B60
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 23:24:32 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220929062428euoutp023cc3241e72f280b5232421fefe764cdd~ZQLGJs9WY0466604666euoutp02O
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 06:24:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220929062428euoutp023cc3241e72f280b5232421fefe764cdd~ZQLGJs9WY0466604666euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664432668;
        bh=V+SReoPnmYdd5bkVT6WmWQIUNggZX2crLzxh2sVCpc8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=pC200TzzGwY2wgCgeHzfJZgI4fCYoNZL4pvLu9s8vOKF2C70s8xgmKp69t6YToJ+h
         el0jkzunhMOrtkC2rnw0mKTFbOtSBMc1OwbFspjjVO/EKtMi2KaxOa1+dYBAk2j4KZ
         nYB7AY1kr7kRISN2u2H7Cm/zadwBDnyq7HfNNSjM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220929062427eucas1p21f673d730f697c71c4bca2e67b554e42~ZQLFWG1sR0035800358eucas1p2a;
        Thu, 29 Sep 2022 06:24:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BF.2A.19378.B1A35336; Thu, 29
        Sep 2022 07:24:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220929062427eucas1p1df45ba277e296b9dd67ebdef8ff088d4~ZQLEywYY60202902029eucas1p1B;
        Thu, 29 Sep 2022 06:24:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220929062426eusmtrp1aacd0a6f3601e4c81ebf9d3df7efa761~ZQLEr2Aqs0651006510eusmtrp1c;
        Thu, 29 Sep 2022 06:24:26 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-d2-63353a1bbbaa
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D9.23.07473.A1A35336; Thu, 29
        Sep 2022 07:24:26 +0100 (BST)
Received: from localhost (unknown [106.210.248.168]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220929062426eusmtip1d05f88c49dccffcab88e397cbc7ff0dc~ZQLEYIy8W0995809958eusmtip1F;
        Thu, 29 Sep 2022 06:24:26 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, hch@lst.de
Cc:     damien.lemoal@opensource.wdc.com, linux-block@vger.kernel.org,
        gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 0/2] plugging cleanup v2
Date:   Thu, 29 Sep 2022 08:24:23 +0200
Message-Id: <20220929062425.91254-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduzneV1pK9Nkgy2flSxW3+1ns/h99jyz
        xc0DO5ksVq4+ymSx95a2xeelLewObB6Xz5Z67L7ZwOaxs/U+q0ffllWMHp83yQWwRnHZpKTm
        ZJalFunbJXBlTLw3m61gIXtFX5dNA+NJ1i5GTg4JAROJ3s4ZzF2MXBxCAisYJQ5/X80K4Xxh
        lFgw8TMLhPOZUeL/tilwLfv2f2OHSCxnlNj58SsjhPOSUeLdw4lALRwcbAJaEo2d7CANIgLy
        El9ur2UBsZkF6iVWXu9mBLGFBbQlzrccZAaxWQRUJfbMnQhm8wpYSlxYtY0RYpm8xMxL39kh
        4oISJ2c+gZojL9G8dTYzRM1SDokrr/MgbBeJHd/eMUHYwhKvjm9hh7BlJE5P7mGBsKslnt74
        DfazhEALo0T/zvVsIDdLCFhL9J3JATGZBTQl1u/Sh4g6Svy4rwdh8knceCsIcQCfxKRt05kh
        wrwSHW1CELOVJHb+fAK1U0LictMcFogSD4mNk8HOEhKIlbjw4ybjBEaFWUi+moXkq1kIFyxg
        ZF7FKJ5aWpybnlpsnJdarlecmFtcmpeul5yfu4kRmFJO/zv+dQfjilcf9Q4xMnEwHmKU4GBW
        EuH9fdQwWYg3JbGyKrUoP76oNCe1+BCjNAeLkjgv2wytZCGB9MSS1OzU1ILUIpgsEwenVAOT
        suhLeU+l9M9Higr0NGz0TaziT4ff2Ns1J9lcjWuyDcu6TQLL/fjel1QHZnrFV01r0OPIeJvM
        6Xfq5jGH6ELexAefv3hOPKtTJ9oWcE1D03OypMZK3fNlU+2eVD3bI+f0Rc8t6U/2rvVhZ1q4
        z2tOUb527rTNY0WxJ9NYHbSk7LcY5ma/bWdvDipqnHHdouKdzZ2shW9WqvNICoc9mfy/vXcj
        q6/j+2XVnVI31Bf5KslV7Xp/pPqJl0hRnk8+u6nFo4ajvu+yn8xZV76GVe3Pu1cKYoYGAhyS
        Cpkc0jwunVs5tv59tiAp1XWeDxdvQ/DDdyJb7BvENLpO7ll5cumkKa4S5VppjUnvRYNqlViK
        MxINtZiLihMB/KyAXpgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsVy+t/xu7pSVqbJBl/PGlusvtvPZvH77Hlm
        i5sHdjJZrFx9lMli7y1ti89LW9gd2Dwuny312H2zgc1jZ+t9Vo++LasYPT5vkgtgjdKzKcov
        LUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLmHhvNlvBQvaK
        vi6bBsaTrF2MnBwSAiYS+/Z/YwexhQSWMkrsXOkAEZeQuL2wiRHCFpb4c62LrYuRC6jmOaPE
        zaWXmLoYOTjYBLQkGjvBekUEFCU2fgSp5+JgFmhmlLh8sx9sgbCAtsT5loPMIDaLgKrEnrkT
        wWxeAUuJC6u2QS2Ql5h56Ts7yExmAU2J9bv0IUoEJU7OfMICYjMDlTRvnc08gZF/FkLVLCRV
        s5BULWBkXsUoklpanJueW2yoV5yYW1yal66XnJ+7iREY/tuO/dy8g3Heq496hxiZOBgPMUpw
        MCuJ8P4+apgsxJuSWFmVWpQfX1Sak1p8iNEU6OqJzFKiyfnACMwriTc0MzA1NDGzNDC1NDNW
        Euf1LOhIFBJITyxJzU5NLUgtgulj4uCUamBqOrTzuoLs6bkLePX9Zl1Yl+z8aJvA5ibbshcz
        F7QtbDkkF3nBqvJpvvVtfhvLOdH7IubP4PnWbapk//5y0d/yhNzfTelWAryFk758KbX68KHi
        Gdc6tm2S610K5syctvPoffVLKo5qr730J06/olLIMeHgv4Ad02LktF6y6yX3CnzYYvd+76rE
        J5z5ER9FT35eVj818NYDA9vVzC1zBZfv6Wk3zE9U/Mv7wbzNkTc18++a0LVTAo9+3NHArZ30
        zVY24XXLHROVlaI6nuaqcrHyvcVnnjhZP25lCPgx44BDxSPzTWeN/u7fqZjYpRjd5HjrgUD3
        Y43rZuwcohuev1QpEm/ZdOZY959jG3mOFmkpsRRnJBpqMRcVJwIA/Yn6GggDAAA=
X-CMS-MailID: 20220929062427eucas1p1df45ba277e296b9dd67ebdef8ff088d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220929062427eucas1p1df45ba277e296b9dd67ebdef8ff088d4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220929062427eucas1p1df45ba277e296b9dd67ebdef8ff088d4
References: <CGME20220929062427eucas1p1df45ba277e296b9dd67ebdef8ff088d4@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

1st patch modifies blk_mq_plug() function to disable plugging for
 write and write zeroes in zoned block devices.

2nd patch uses the blk_mq_plug function in the block layer consistently.

The patches are based on next-20220923.

Changes since v1:
- Explicltly check only for write and write zeroes as they require zone
  locking in blk_mq_plug
- create a new helper to check for ops that require zone locking for
  zoned devices and also reuse it in blk_req_needs_zone_write_lock

Pankaj Raghav (2):
  block: adapt blk_mq_plug() to not plug for writes that require a zone
    lock
  block: use blk_mq_plug() wrapper consistently in the block layer

 block/blk-core.c       | 2 +-
 block/blk-mq.c         | 6 ++++--
 block/blk-mq.h         | 3 ++-
 block/blk-zoned.c      | 9 +++------
 include/linux/blkdev.h | 9 +++++++++
 5 files changed, 19 insertions(+), 10 deletions(-)

-- 
2.25.1

