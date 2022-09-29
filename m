Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA89C07E9D
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 07:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiI2Hrx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 03:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbiI2Hrw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 03:47:52 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE711397D8
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 00:47:50 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220929074748euoutp0196f052e255dbcc7965bae45077632073~ZRT2gcYKN1771317713euoutp01w
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 07:47:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220929074748euoutp0196f052e255dbcc7965bae45077632073~ZRT2gcYKN1771317713euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664437668;
        bh=uYe0cjHVLKIEoq46d0KyYfaBElIogMYYkPbhaRKvDlQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=m/bVaTYyar0FOp1z6OQWxJophGOTWwEiVjXkOL1CizEZsi+x/YHTvcy94wu/pzZmy
         2+NoqRSFnOay5TNi4Ezv8fABIkra/3MmeaZacIssBd4lcp3hqQoys/K6UB0DjzKXdM
         asDagebW/+F+vSAo05BaVLwqZyE2JdP6qhCzmuyA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220929074747eucas1p14f5ca6432a9802dc958d223d375d420c~ZRT1s-t_R3109531095eucas1p1k;
        Thu, 29 Sep 2022 07:47:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 65.CC.19378.3AD45336; Thu, 29
        Sep 2022 08:47:47 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220929074747eucas1p1821a5b79ad24cb559b7b6ec324239e9e~ZRT1aiogG0530805308eucas1p1F;
        Thu, 29 Sep 2022 07:47:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220929074747eusmtrp2ccb6f17d7fa9288f08272d4b0e0334a9~ZRT1ZPZGE0658106581eusmtrp2Q;
        Thu, 29 Sep 2022 07:47:47 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-80-63354da3e312
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2E.60.07473.2AD45336; Thu, 29
        Sep 2022 08:47:47 +0100 (BST)
Received: from localhost (unknown [106.210.248.168]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220929074746eusmtip29f5a47ba8bd6fdc9adcc2c4fd94cb6b0~ZRT1Hxdr81041910419eusmtip2E;
        Thu, 29 Sep 2022 07:47:46 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, hch@lst.de
Cc:     gost.dev@samsung.com, linux-block@vger.kernel.org,
        damien.lemoal@opensource.wdc.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 0/2] plugging cleanup v3
Date:   Thu, 29 Sep 2022 09:47:43 +0200
Message-Id: <20220929074745.103073-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduzned3FvqbJBvuWiFqsvtvPZvH77Hlm
        i5sHdjJZrFx9lMli7y1ti89LW9gd2Dwuny312H2zgc1jZ+t9Vo++LasYPT5vkgtgjeKySUnN
        ySxLLdK3S+DKeLlgNmvBO/aKVyd6mBoYW9m6GDk5JARMJK483MXUxcjFISSwglHizuqT7BDO
        F0aJKa+Os0E4nxkllqxdygzT8vdpC1TVckaJ9gkTWSGcl4wSP159AMpwcLAJaEk0drKDNIgI
        yEt8ub2WBcRmFqiXaL7wEywuLKAtcWTvXrChLAKqEtfbnjKC2LwCVhIrN++Euk9eYual7+wQ
        cUGJkzOfQM2Rl2jeOpsZZK+EwEIOic1/D7BANLhIvN13HupSYYlXx7ewQ9gyEv93zmeCsKsl
        nt74DdXcwijRv3M9G8jREgLWEn1nckBMZgFNifW79CGijhK7e1IgTD6JG28FIS7gk5i0bToz
        RJhXoqNNCGK2ksTOn0+gdkpIXG6aA3WXh8SGXQ/B1ggJxEqsuJI9gVFhFpK3ZiF5axbCBQsY
        mVcxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEppXT/45/3cG44tVHvUOMTByMhxglOJiV
        RHh/HzVMFuJNSaysSi3Kjy8qzUktPsQozcGiJM7LNkMrWUggPbEkNTs1tSC1CCbLxMEp1cDU
        +zHzWoZGyZ6NuxekP9/7UfPwMtdN/3k6HnGkzrouc2btxd6o37nf17o/2RG3oS8p1irT/3FU
        wyzJhb5eCW92vTnQsPG8sKBwNss6Gd+fGgGdQtxsq7trtTN2TIi/Ufr93ubfKaqP/l1/t2Bu
        qbBMpaDkRyPTfydMll9+H5AVeVr+CGeM5Z3we1/0JpsZ6k0P4LrZ73u/PHDrulmPRSdIRJrO
        DuOK4Ja4c0JO/EZC6Kon+68t6lk1Jbp/mjV/ya7z8+rero5b133RYN/yzGdiOZbCEjL/T9fO
        cVXaaGGt0ysw5Wb2/rwvEWIvhGVCYt5dufB06srXiw4kLndd66Yx/fNBb7c8wc+PLl1Y0GOf
        psRSnJFoqMVcVJwIAL5XHFWaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsVy+t/xe7qLfU2TDdq3MlmsvtvPZvH77Hlm
        i5sHdjJZrFx9lMli7y1ti89LW9gd2Dwuny312H2zgc1jZ+t9Vo++LasYPT5vkgtgjdKzKcov
        LUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLeLlgNmvBO/aK
        Vyd6mBoYW9m6GDk5JARMJP4+bWHvYuTiEBJYyijxr+k5C0RCQuL2wiZGCFtY4s+1LjaIoueM
        Egc3TQbq4OBgE9CSaOxkB6kREVCU2PgRop5ZoJlR4vm8ChBbWEBb4sjevcwgNouAqsT1tqdg
        NbwCVhIrN++EOkJeYual72AjmQU0Jdbv0ocoEZQ4OfMJC8RIeYnmrbOZJzDyz0KomoWkahaS
        qgWMzKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECI2DbsZ+bdzDOe/VR7xAjEwfjIUYJDmYl
        Ed7fRw2ThXhTEiurUovy44tKc1KLDzGaAl09kVlKNDkfGIN5JfGGZgamhiZmlgamlmbGSuK8
        ngUdiUIC6YklqdmpqQWpRTB9TBycUg1Mzhc3zXvbnL5joXwLt6JL7w2+lav0Uxb/s2ZM5eGI
        LhWtX7FxolBlDXeFtGjDsVc18SLNopYTpLJUwu5ob9v5WHtBjfZf7cC7hdFhWUFOYfcub5QL
        nxdj4mv9VOedmNuD2Qn7U6bY7DMQVlKV7LzgL3LqRLCL4SYDkTnBfFl+0dmL1W2zOqQO3//8
        O/rVnm6L0rOl3ffuHBGTqRN642+znVfih1fDA37jU5O5pqd/Mmg8/+iAUy53V5vdO57PKz4v
        0P44J+2BPSu3t9CFlK2Jajq/Hh72DT3YtDEh88Md3zVXbCO+dz62PvN3h85X/107y92uZqpe
        u2CrfdBsfp6aRf6yC1EZDl2zvQ04dimxFGckGmoxFxUnAgAT2dApCQMAAA==
X-CMS-MailID: 20220929074747eucas1p1821a5b79ad24cb559b7b6ec324239e9e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220929074747eucas1p1821a5b79ad24cb559b7b6ec324239e9e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220929074747eucas1p1821a5b79ad24cb559b7b6ec324239e9e
References: <CGME20220929074747eucas1p1821a5b79ad24cb559b7b6ec324239e9e@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

1st patch modifies blk_mq_plug() function to disable plugging for
 write and write zeroes in zoned block devices.

2nd patch uses the blk_mq_plug function in the block layer consistently.

The patches are based on next-20220923.

Changes since v2:
- Enhance the commit log for the 2nd patch (Christoph)

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

