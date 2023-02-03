Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755D4C64EC5
	for <linux-block@archiver.kernel.org>; Fri,  3 Feb 2023 10:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjBCKda (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Feb 2023 05:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjBCKdD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Feb 2023 05:33:03 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE043A42A1
        for <linux-block@vger.kernel.org>; Fri,  3 Feb 2023 02:31:27 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230203103123euoutp027d9996c6e888be3adf33d4e5a0d7752c~ASd8Cx45C1725317253euoutp02k
        for <linux-block@vger.kernel.org>; Fri,  3 Feb 2023 10:31:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230203103123euoutp027d9996c6e888be3adf33d4e5a0d7752c~ASd8Cx45C1725317253euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1675420283;
        bh=Jq6iXqpZ9e7Ra5CnnhoZy/TfLR/LPtqnu6l3J9AYbU8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=i2NRWMKsEW/FuQb3BFmEp/BqMgNOO4NLothw7VcG4EmI/ZqVr8OEVwxe1B8Ei2wBg
         Gr6AqziuZNpTyOiGsg/IyN2SzUyuCmrfH43VVmsvPN98bNzRafHXB/6aNKxkN7sJDR
         YWTEEZfTx0rIlsijvs53zoC0O0XeFj40RNFawHY0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230203103122eucas1p1dc5563a0d52518ce858276852d613e84~ASd7M6tQp1498914989eucas1p1C;
        Fri,  3 Feb 2023 10:31:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BE.9E.13597.A72ECD36; Fri,  3
        Feb 2023 10:31:22 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e~ASd6xdf6H1498714987eucas1p14;
        Fri,  3 Feb 2023 10:31:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230203103122eusmtrp26b450b1579dea5b33f646324eed7cc5b~ASd6wxfQq2941029410eusmtrp2l;
        Fri,  3 Feb 2023 10:31:22 +0000 (GMT)
X-AuditID: cbfec7f4-207ff7000000351d-59-63dce27a2e8f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 03.20.02722.A72ECD36; Fri,  3
        Feb 2023 10:31:22 +0000 (GMT)
Received: from localhost (unknown [106.210.248.242]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230203103121eusmtip2b48e5ca03bb8c492af923a000792efdc~ASd6YiReK2316323163eusmtip2O;
        Fri,  3 Feb 2023 10:31:21 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, mcgrof@kernel.org, gost.dev@samsung.com,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 0/1] improve brd performance with blk-mq 
Date:   Fri,  3 Feb 2023 16:00:05 +0530
Message-Id: <20230203103005.31290-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduzned2qR3eSDf4+k7dYfbefzeLmgZ1M
        FitXH2Wy2HtL2+LGhKeMFp+XtrA7sHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAGsVlk5Ka
        k1mWWqRvl8CVcWj+bbaCdUIV/7ftY2xgvM7bxcjJISFgIrH5026WLkYuDiGBFYwS3w+sZoZw
        vjBK7N+zhRmkSkjgM6PE9KnaMB1XNt1ngyhazijR8n4dlPOSUeLr4vnsXYwcHGwCWhKNnewg
        DSICwhL7O1pZQGxmgRqJpaf2gw0VFrCU2Hp/F1icRUBVom3pYbB6XqD4469XGSGWyUvMvPQd
        Ki4ocXLmE6g58hLNW2eDXSohMJFD4sfsWewQDS4SEzddgLKFJV4d3wJly0j83zmfCcKulnh6
        4zdUcwujRP/O9WwgR0sIWEv0nckBMZkFNCXW79KHKHeUaDz3hBWigk/ixltBiBP4JCZtm84M
        EeaV6GgTgqhWktj58wnUUgmJy01zWCBsD4ldl9cxQYIzVuJj8wHGCYwKs5A8NgvJY7MQbljA
        yLyKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMLGc/nf8yw7G5a8+6h1iZOJgPMQowcGs
        JMK7/PSdZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK82rYnk4UE0hNLUrNTUwtSi2CyTBycUg1M
        6nY9f/refiieFNtcrq2avGbR24f/u9TP3DJucDmQ1rSLUznr7P1285ALZ/dMDsp+FfXM4bxO
        5kv7gxyNT/ZYB9Qbme3O6drUXLX0iv822delGzuDAgqeni7aaLv4dbRAjE76mqipu5IVH5V0
        Cf09a89sUvDv6Urv1RvnP+t8e/3q5Q72rglrHJT1RO8yTL3W2pHYfvHWbPf9uo1tKRF+35T2
        +4VZrHxr9pr1RsntpQzl3U1hhz7VSMfnbdTgMRZSeHPSIzR6yssFvbVrTrxSsZpaYMc98d6H
        He2NVqcTAjObtgUe5JPTdfjvK78w318w6tuOVz96BHa93rP9hHQs1yWRQPGQvja/Qr0Mpg4l
        luKMREMt5qLiRACsiB0+mwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsVy+t/xe7pVj+4kG+w6wm6x+m4/m8XNAzuZ
        LFauPspksfeWtsWNCU8ZLT4vbWF3YPO4fLbUY9OqTjaP3Tcb2Dz6tqxi9Pi8SS6ANUrPpii/
        tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv49D822wF64Qq
        /m/bx9jAeJ23i5GTQ0LAROLKpvtsXYxcHEICSxkl9q/awQqRkJC4vbCJEcIWlvhzrQuq6Dmj
        xLId/4ESHBxsAloSjZ3sIDUiQDX7O1pZQGqYBZoYJZYvnc0CkhAWsJTYen8XmM0ioCrRtvQw
        WAMvUPzx16tQC+QlZl76DhUXlDg58wlYPTNQvHnrbOYJjHyzkKRmIUktYGRaxSiSWlqcm55b
        bKhXnJhbXJqXrpecn7uJERjW24793LyDcd6rj3qHGJk4GA8xSnAwK4nwLj99J1mINyWxsiq1
        KD++qDQntfgQoynQfROZpUST84GRlVcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpa
        kFoE08fEwSnVwLR48r4/iwJ8HjrOmTu59shcn9i9P+2usy7OEJNnsJt8Ql3k5LwLQiFedns3
        BJsYL977Yj/7zJbeNzWb939OWHXzl4ULi+qP2Yk7N0r9PiktNueSuk1Dmb/c0oO1k1kd0zu/
        Hp20c6bUq0Jlp4UfpyocerS+qfCzSYRIzwVlcUf31Z4Fk/WYQ+Lbsy55fShscxae5zcpcf/i
        o3s8jx//me4Q3P9IZ/6Tdf0hh16vnJHywatAM6RI/HzRkT+2UiohL8X4v649y/fdOW3ZzwIV
        jc9x37o/bTS+ppZo3xm1ZmPjzK3mJc5hUoF2b+5kXwxpXBTzeMkx95wrL4X1DnhwVG9YyH2x
        tcVQb27+6vzyHgYlluKMREMt5qLiRACBIEZi9AIAAA==
X-CMS-MailID: 20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e
References: <CGME20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,
 brd is one of the few block drivers that still uses submit_bio instead
 of blk-mq framework. The following patch converts brd to start using
 blk-mq framework. Performance gains are pretty evident for read workloads.
 The performance numbers are also attached as a part of
 the commit log.

 Performance (WD=[read|randread|write|randwrite]):
 $ modprobe brd rd_size=1048576 rd_nr=1
 $ echo "none" > /sys/block/ram0/queue/scheduler
 $ fio --name=<WD>  --ioengine=io_uring --iodepth=64 --rw=<WD> --size=1G \
   --io_size=20G --loop=4 --cpus_allowed=1 --filename=/dev/ram0 --iodepth=64
   --direct=[0/1]

  --direct=0
  ------------------------------------------------------
  |            | bio(base) | blk-mq            | delta |
  ------------------------------------------------------
  | randread   | 133       | 223               | +75%  |
  ------------------------------------------------------
  | read       | 150       | 313               | +108% |
  -----------------------------------------------------
  | randwrite  | 111       | 109               | -1.8% |
  -----------------------------------------------------
  | write      | 118       | 117               | -0.8%|
  -----------------------------------------------------
  
  --direct=1
  ------------------------------------------------------
  |            | bio(base) | blk-mq            | delta |
  ------------------------------------------------------
  | randread   | 182       | 414               | +127% |
  ------------------------------------------------------
  | read       | 190       | 429               | +125% |
  -----------------------------------------------------
  | randwrite  | 378       | 387               | +2.38%|
  -----------------------------------------------------
  | write      | 443       | 420               | -5.1% |
  -----------------------------------------------------

 I also added some simple blktests for the brd device to test the changes,
 and it can be found here:
 https://github.com/Panky-codes/blktests/tree/brd

 I will send the blktests patches once this gets merged.

Pankaj Raghav (1):
  brd: improve performance with blk-mq

 drivers/block/brd.c | 64 +++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 17 deletions(-)

-- 
2.39.0

