Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008FDC04A95
	for <linux-block@archiver.kernel.org>; Sun, 25 Sep 2022 18:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiIYSx4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Sep 2022 14:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiIYSxz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Sep 2022 14:53:55 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608862E6A0
        for <linux-block@vger.kernel.org>; Sun, 25 Sep 2022 11:53:52 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220925185350euoutp02b128f70e93791a3639b2bb4375e20b98~YL0O-459g2348323483euoutp02E
        for <linux-block@vger.kernel.org>; Sun, 25 Sep 2022 18:53:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220925185350euoutp02b128f70e93791a3639b2bb4375e20b98~YL0O-459g2348323483euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664132030;
        bh=MvGW8n6Q2ByTA+zFcuYwER+dN+OwxY+mOU1dIN79rJg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Qp/Khew3NnjOFDeanOP6v/GAxF0gNDl8Txp8UNoidqg4wtC+C/Zs4gX6EOy9hnqNy
         zlvB+WH90A2uDyLnaqPpZgeFkPowQ/CSM0+CiKkJGT1am6fRaiuqV49zWRpmzq+gQi
         YV9Xz/RwQnD2tRqqR1Q6v6jz75kwl0EyMju+TE6s=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220925185349eucas1p25797011189ac04acfab7f5873939aa4c~YL0OThL0f2818428184eucas1p2V;
        Sun, 25 Sep 2022 18:53:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 35.EF.29727.DB3A0336; Sun, 25
        Sep 2022 19:53:49 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220925185349eucas1p1dc689bac64668ca038ba8646c44fd580~YL0N6_KDu1286512865eucas1p1x;
        Sun, 25 Sep 2022 18:53:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220925185349eusmtrp2ccb96d3e23e7bd00f677660595172136~YL0N6ajxA1617516175eusmtrp2Q;
        Sun, 25 Sep 2022 18:53:49 +0000 (GMT)
X-AuditID: cbfec7f2-205ff7000001741f-c0-6330a3bdffde
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 54.37.10862.DB3A0336; Sun, 25
        Sep 2022 19:53:49 +0100 (BST)
Received: from localhost (unknown [106.210.248.168]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220925185348eusmtip1358c7bfa627615bfc487d52a0c2794f4~YL0NlwHlp0145001450eusmtip1z;
        Sun, 25 Sep 2022 18:53:48 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     damien.lemoal@opensource.wdc.com, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 0/2] enable plugging only for reads in zoned block devices
Date:   Sun, 25 Sep 2022 20:53:45 +0200
Message-Id: <20220925185348.120964-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsWy7djP87p7FxskGzxcJWux+m4/m8Xvs+eZ
        LW4e2MlksfeWtsXnpS3sDqwel8+Weuxsvc/q0bdlFaPH501yASxRXDYpqTmZZalF+nYJXBn7
        VicVHGOt+PxkAnMD4yGWLkZODgkBE4nZix+wdTFycQgJrGCUmLJjJjuE84VR4sfxiywQzmdG
        iRknljPCtMxs+wrVshyo5eFtVgjnJaNE075/QFUcHGwCWhKNnewgDSICBhKr1nWwgdjMAkkS
        X/6uZAaxhQW8JM4u7wIbyiKgKvFyci/YTbwCVhIntrexQSyTl5h56Ts7RFxQ4uTMJywQc+Ql
        mrfOZoaomcoh0b3KFGSthICLxJXPYhBhYYlXx7ewQ9gyEv93zmeCsKslnt74zQxysoRAC6NE
        /871bBC91hJ9Z3JATGYBTYn1u/Qhyh0lDi96ywRRwSdx460gxAF8EpO2TWeGCPNKdLQJQVQr
        Sez8+QRqqYTE5aY50HD2kLjbDBEXEoiV+Lb0POMERoVZSN6aheStWQg3LGBkXsUonlpanJue
        WmyYl1quV5yYW1yal66XnJ+7iRGYQE7/O/5pB+PcVx/1DjEycTAeYpTgYFYS4U25qJssxJuS
        WFmVWpQfX1Sak1p8iFGag0VJnJdthlaykEB6YklqdmpqQWoRTJaJg1OqgSlrytQT6+brGZ8q
        dXn8SydaYbFl/NSCpGlPC3jedcpUHvqnum57xq15rurrL65jWqNup7pqQ82OefsfB+z7avbG
        puHksafldnO+lBr9c53+kplD32t61+d777UVd3tnX/TiOMYf8qk8YNfhI9tvey7nSHihP6Fq
        np7WLH2OxK4n5YuiLijdn835f/feo4fmBL6+zjQ7ju20+oZgs+e+XreuN53s2/uqcZOez68t
        e1vqpPpfb6r3yiqZv6+nwejU8SBW/sPHNRo45nlu7g547NHVX7RbaWZIj0t1kFNieYaCWfxy
        z4au6r92Z4+lJyxvjp+SGuPPKvvQnMP81dc6VkvboF8udyNyXUwvr9uzzV+JpTgj0VCLuag4
        EQDDO3NzjwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsVy+t/xu7p7FxskG+zdxG6x+m4/m8Xvs+eZ
        LW4e2MlksfeWtsXnpS3sDqwel8+Weuxsvc/q0bdlFaPH501yASxRejZF+aUlqQoZ+cUltkrR
        hhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehn7VicVHGOt+PxkAnMD4yGWLkZO
        DgkBE4mZbV/Zuhi5OIQEljJKrP57mAkiISFxe2ETI4QtLPHnWhdU0XNGie/bp7J2MXJwsAlo
        STR2soPUiAgYSfxee40VxGYWSJFY+wZijrCAl8TZ5V1gc1gEVCVeTu4FW8wrYCVxYnsbG8R8
        eYmZl76zg4xkFtCUWL9LH6JEUOLkzCcsECPlJZq3zmaewMg/C6FqFpKqWUiqFjAyr2IUSS0t
        zk3PLTbSK07MLS7NS9dLzs/dxAgM9W3Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeFMu6iYL8aYk
        VlalFuXHF5XmpBYfYjQFunois5Rocj4w2vJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tS
        s1NTC1KLYPqYODilGpisVu5wel8RkXxHdG9V2a75TvU17YwKpXmy3265vbWzr5d//stOZnuN
        6/tW7tSvLE+NLNdafI65mf30mepk50Ijz95g98i0wkVfLNYuvlERwvzre2/Hz5QmVe6PBpWO
        gqebJFfqnNi85g8f//WsLdU/erhtz5x0KXxn/tP1V6HGrd2hAWGKi+u2Sr5vXb/l5psH3ip3
        8pVfuB06c/Nv1Px/53WXRp6e3ib8NztR+Ooq7neyFUVXC54cnjI/4vDP1W/3TZj4hi1f7dYM
        tmmi/Fm6hpf1C0+WRocu/RnGt2q+3XqWMGcG9jXLg+15c/pE8kLVmf8e+//L3MO5Wn/C4auc
        qQ91OstKP9hNvBUrJazEUpyRaKjFXFScCADN5pyT/gIAAA==
X-CMS-MailID: 20220925185349eucas1p1dc689bac64668ca038ba8646c44fd580
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220925185349eucas1p1dc689bac64668ca038ba8646c44fd580
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220925185349eucas1p1dc689bac64668ca038ba8646c44fd580
References: <CGME20220925185349eucas1p1dc689bac64668ca038ba8646c44fd580@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,
 This patch series addresses the issue that was discussed in your plugging
 for passthrough patch series[1].

1st patch modifies blk_mq_plug() function to accept plugging only for
reads in zoned block devices.

2nd patch uses the blk_mq_plug function in blk_execute_rq_nowait().

The patches are based on next-20220923.

[1] https://lore.kernel.org/linux-block/2e484ccb-b65b-2991-e259-d3f7be6ad1a6@kernel.dk/

Pankaj Raghav (2):
  block: modify blk_mq_plug() to allow only reads for zoned block
    devices
  block: use blk_mq_plug() in blk_execute_rq_nowait()

 block/blk-mq.c | 2 +-
 block/blk-mq.h | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.25.1

