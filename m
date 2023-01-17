Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E83C63797
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 12:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbjAQMub (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 07:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbjAQMuQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 07:50:16 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8A839BB4
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 04:49:09 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230117124907epoutp03bd628c778cc6091cccc62a22dee132e4~7GYVuRU_21399013990epoutp03K
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 12:49:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230117124907epoutp03bd628c778cc6091cccc62a22dee132e4~7GYVuRU_21399013990epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673959747;
        bh=ITyqR+kOGep49QGF32BuyKqQqqH3Aby7sI+XkMDFbsE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Vh0jtsJpW2OVFicRfiJZgTQUBCIzfSSQFOoQZdWDBTi5D9/6ucEPRc+hSJZBx/4G0
         T2qmjiCuo4SjCyk2nvGzERCoVbbM9fkrB1qmEw98PSRwMDrHvM/innoWiewwHs0elz
         a5lFfhUm8Fra8jXgK8alEQULEDGECd8STnWwKEGs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230117124906epcas5p39e48b2814e0cb546b5c6be3d451e0021~7GYVO6y-M0791307913epcas5p3g;
        Tue, 17 Jan 2023 12:49:06 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Nx7xY4hScz4x9Pv; Tue, 17 Jan
        2023 12:49:05 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.64.02301.14996C36; Tue, 17 Jan 2023 21:49:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230117120741epcas5p2c7d2a20edd0f09bdff585fbe95bdadd9~7F0KhVxG73045230452epcas5p2v;
        Tue, 17 Jan 2023 12:07:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230117120741epsmtrp1e32031ff065f1ba18a0657ad264c572c~7F0Kgrew72434624346epsmtrp1B;
        Tue, 17 Jan 2023 12:07:41 +0000 (GMT)
X-AuditID: b6c32a49-473fd700000108fd-9c-63c699410f78
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.00.10542.D8F86C36; Tue, 17 Jan 2023 21:07:41 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230117120740epsmtip2d99da0d05650d118792c33caf8a1c30f~7F0JQATxN0365703657epsmtip2i;
        Tue, 17 Jan 2023 12:07:39 +0000 (GMT)
From:   Anuj Gupta <anuj20.g@samsung.com>
To:     axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
        asml.silence@gmail.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH for-next v1 0/2] enable pcpu bio-cache for IRQ
 uring-passthru I/O
Date:   Tue, 17 Jan 2023 17:36:36 +0530
Message-Id: <20230117120638.72254-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTQ9dx5rFkg7l7lC2aJvxltpizahuj
        xeq7/WwWNw/sZLJYufook8WkQ9cYLfbe0raYv+wpuwOHx85Zd9k9Lp8t9di0qpPNY/OSeo/d
        NxvYPPq2rGL0+LxJLoA9KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
        1VbJxSdA1y0zB+gkJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWle
        ul5eaomVoYGBkSlQYUJ2xteGOUwFn3gqnrybzNrA+Imri5GTQ0LAROLl4ROsXYxcHEICuxkl
        fnx5xgzhfGKU6D76iwmkSkjgM6NE62NTmI55W1qgOnYxSly9ux7KASqatr6LEaSKTUBd4sjz
        VjBbRMBL4v7t96wgNrNAlUTPkc3MILawQLDEpCVXgGo4OFgEVCVWPrYECfMKWEr8OP+VCWKZ
        vMTMS9/ZIeKCEidnPmGBGCMv0bx1NtilEgL32CVOvl4P1eAicenFFhYIW1ji1fEt7BC2lMTL
        /jYoO13ix+WnUPUFEs3H9jFC2PYSraf6mUHuYRbQlFi/Sx8iLCsx9dQ6Joi9fBK9v59AtfJK
        7JgHYytJtK+cA2VLSOw918AEMkZCwEOi+7MKJAxjJbbfuMIygVF+FpJvZiH5ZhbC4gWMzKsY
        JVMLinPTU4tNCwzzUsvh0Zqcn7uJEZwutTx3MN598EHvECMTB+MhRgkOZiURXr9dh5OFeFMS
        K6tSi/Lji0pzUosPMZoCQ3gis5Rocj4wYeeVxBuaWBqYmJmZmVgamxkqifOmbp2fLCSQnliS
        mp2aWpBaBNPHxMEp1cBU/v2skiRLtFXqw1YGoY+FZTzVCR+b31if8NeXXbdTL9Xyg5bZ1Ifx
        T+wOnn4Tt2OnZPDmfdLT3Z68/3NT8PWJL/cqd6WcS7TI2PPX16Xq6OrD65v/V6j1J+6OzLaZ
        GnTxssVTMa3eQmXJ/tRLikV/JH/M6W9e0BO+xIzvru2zFzP0dtS/27ljUqVf471LZdLmzDal
        FW3VCq/ezGhcvOLPdIOS4KD+Y9mOfIIf8yqNX60KD6xLUZjM4TVRK2B7X9nxOwkZn7sfRgdW
        zYh5PC8yW9XrYpIOB9vbZa0TF6/fGuzXWLdku1vgCf279RK7neNXi4fyvOjjzVSR6j7N5H5u
        kmCju1Ylr9ayvlg/LiWW4oxEQy3mouJEADc1Tv8gBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSvG5v/7Fkg203BS2aJvxltpizahuj
        xeq7/WwWNw/sZLJYufook8WkQ9cYLfbe0raYv+wpuwOHx85Zd9k9Lp8t9di0qpPNY/OSeo/d
        NxvYPPq2rGL0+LxJLoA9issmJTUnsyy1SN8ugSvja8McpoJPPBVP3k1mbWD8xNXFyMkhIWAi
        MW9LC2sXIxeHkMAORoldN7czQiQkJE69XAZlC0us/PecHaLoI6PE6fff2EESbALqEkeet4IV
        iQgESBxsvAwWZxaok3jc+AkozsEhLBAocXNLIojJIqAqsfKxJUgFr4ClxI/zX5kgxstLzLz0
        nR0iLihxcuYTFogp8hLNW2czT2Dkm4UkNQtJagEj0ypGydSC4tz03GLDAqO81HK94sTc4tK8
        dL3k/NxNjODQ1dLawbhn1Qe9Q4xMHIyHGCU4mJVEeP12HU4W4k1JrKxKLcqPLyrNSS0+xCjN
        waIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgSm5Uefaal0uliMxHw7aNfQw790bsPxEYKdV
        3TW3V96JfFbvda4qv750wStT67jHXT9LRudJcw59ytwhcK+CbbeggojS5kOOB/YXOjpstG8w
        K/QSfxt569KRexMNpzBz9RfevjhtR/bq/nqbXdViVaxOASdX996sOPMx6cjXQ5rlDkvMZ0yc
        72zG/9TQwlNmK0NHuK6S/8FdgZ/+VsR3KMw+pVLgFT15pupnrR0xH6dEz+HKWfOq83T2LP+e
        5xqvYwMy3u17sniJ6ZYltXOcFte/OM5o/nvrAr818lt6TkifvRWf65i5cWWl3+/Qn/ceX2io
        mOtpNa9oes1s6wbFeVGrzb7yz9jSq/+vZWZwdq4SS3FGoqEWc1FxIgCEpp+/zAIAAA==
X-CMS-MailID: 20230117120741epcas5p2c7d2a20edd0f09bdff585fbe95bdadd9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230117120741epcas5p2c7d2a20edd0f09bdff585fbe95bdadd9
References: <CGME20230117120741epcas5p2c7d2a20edd0f09bdff585fbe95bdadd9@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series extends bio pcpu caching for normal / IRQ-driven
uring-passthru I/Os. Earlier, only polled uring-passthru I/Os could
leverage bio-cache. After the series from Pavel[1], bio-cache can be
leveraged by normal / IRQ driven I/Os as well. t/io_uring with an Optane
SSD setup shows +7.21% for batches of 32 requests.

[1] https://lore.kernel.org/io-uring/cover.1666347703.git.asml.silence@gmail.com/

IRQ, 128/32/32, cache off

# taskset -c 0 t/io_uring -b512 -d128 -c32 -s32 -p0 -F1 -B1 -P0 -O0 -u1 -n1 /dev/ng0n1
submitter=0, tid=13207, file=/dev/ng0n1, node=-1
polled=0, fixedbufs=1/0, register_files=1, buffered=1, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
IOPS=3.05M, BW=1488MiB/s, IOS/call=32/31
IOPS=3.04M, BW=1483MiB/s, IOS/call=32/31
IOPS=3.03M, BW=1477MiB/s, IOS/call=32/32
IOPS=3.03M, BW=1481MiB/s, IOS/call=32/32
^CExiting on signal
Maximum IOPS=3.05M

IRQ, 128/32/32, cache on

# taskset -c 0 t/io_uring -b512 -d128 -c32 -s32 -p0 -F1 -B1 -P0 -O0 -u1 -n1 /dev/ng0n1
submitter=0, tid=6755, file=/dev/ng0n1, node=-1
polled=0, fixedbufs=1/0, register_files=1, buffered=1, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
IOPS=3.27M, BW=1596MiB/s, IOS/call=32/31
IOPS=3.27M, BW=1595MiB/s, IOS/call=32/32
IOPS=3.26M, BW=1592MiB/s, IOS/call=32/31
IOPS=3.26M, BW=1593MiB/s, IOS/call=32/32
^CExiting on signal
Maximum IOPS=3.27M

Anuj Gupta (2):
  nvme: set REQ_ALLOC_CACHE for uring-passthru request
  block: extend bio-cache for non-polled requests

 block/blk-map.c           | 6 ++----
 drivers/nvme/host/ioctl.c | 4 ++--
 2 files changed, 4 insertions(+), 6 deletions(-)

-- 
2.25.1

