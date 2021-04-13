Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662C3C43460
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 03:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42CCB613B1
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 03:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242164AbhDMDNW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 23:13:22 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:47982 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240462AbhDMDNU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 23:13:20 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210413031300epoutp02cd9496c0cffd14a2cda45055be6389c6~1TFeShPai2717227172epoutp02V
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 03:13:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210413031300epoutp02cd9496c0cffd14a2cda45055be6389c6~1TFeShPai2717227172epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618283580;
        bh=E59oJL75rFYvm6E0aq9p2/IepEJhpvDxf5DtHZbFvo0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ZI2x2o/OFuTdGNn0TdfF4dghPmfwrGlVfY6jWsUV/MbDP/uDdWTySFNvdZc/V+Vdv
         Z6LSG935VU/0dcD1e4e5kXWY9/BukvukcCZhFem1zJhjmoUsX2Yy+flmzUcAwF1K7W
         j9IplPjSUgnz0znBlveU3LzFcHDkEIMlG/ZuSSMU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210413031258epcas1p2a896cffe4130a70b8b2c404535d80c7e~1TFc2fE4O0459904599epcas1p2s;
        Tue, 13 Apr 2021 03:12:58 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FK9f123nkz4x9Pw; Tue, 13 Apr
        2021 03:12:57 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.5B.22618.93C05706; Tue, 13 Apr 2021 12:12:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210413031256epcas1p2f3c3f140192178928b92fc070010354d~1TFa7RCsD1606216062epcas1p2K;
        Tue, 13 Apr 2021 03:12:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210413031256epsmtrp1190f35a8e8f1dced9b9effeb2f7c6f20~1TFa5_oJe2206622066epsmtrp1H;
        Tue, 13 Apr 2021 03:12:56 +0000 (GMT)
X-AuditID: b6c32a38-e4dff7000001585a-33-60750c396deb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.95.33967.83C05706; Tue, 13 Apr 2021 12:12:56 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210413031256epsmtip253c954d12cdb01282a7df646b09c9174~1TFamREXH1215112151epsmtip2T;
        Tue, 13 Apr 2021 03:12:56 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     damien.lemoal@wdc.com, bvanassche@acm.org,
        Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, gregkh@linuxfoundation.org, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, Changheun Lee <nanich.lee@samsung.com>
Subject: [PATCH v7 0/3] limit bio max size
Date:   Tue, 13 Apr 2021 11:54:59 +0900
Message-Id: <20210413025502.31579-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUxbVRzdfa+8FhSthcFdnYM1IwoOaFcKlwmMKJvPoAZFIyGa0sELEPq1
        vnabGh2uowhjAxzp+JZt6JaCq5aOAAlfrYjIWNACW0iAERh0sMHkY7ChiS2PRf77nXPP7557
        fvdeDs6bJficbKWW0ihlcgHhxWq2B4eHRj+vSxPOj3mhalMzQA1jxQQyPnqCo7z8xxjSXzET
        qL/kMoaKpk97oH8LxzG0Okmj9tHXkaOtmkC2C3oMXWyqxtHIxE02so8Ps9BkfSmObvUteaDa
        qXj09GoPQIvrt9noj5YLODK3PyHi/UjHUCJZql9gk62VY2yy6VoI6RjQkRZTAUF21jSyycWO
        YYI8bzUBctmyh8zvOoslPZcqj8miZBmUJpBSpqsyspWZsYLEZOlbUkmkUBQqikZRgkClTEHF
        ChLeTQo9ki13JRUEHpfJdS4qSUbTgvC4GI1Kp6UCs1S0NlZAqTPkapFQHUbLFLROmRmWrlIc
        FAmFByQuZZo8q944ANR3iJMzl66CXGBnFQIOB3IjYJf5RCHw4vC4LQC2FMxhDFgCsGz0BzYD
        HgOY11CFFwLPzY7m3g0Ws9AO4O2/bVuqZQALv2nE3CqCux+efzhKuBd8uX0YXG/oB26Ac6cA
        HOozEG6VDzcEjhpGgLtmcYOg417zpoc39w04cuMXFuMXAP+ZKNriX4J9FdObPO7i9TfcZ/Jy
        ae5yYKfeCpiGBLiWV81mah8412vdqvnwfrGBzTScBVBv+B4woATA+tkfMUYlhkvLy8A9HJwb
        DM1t4Qy9F7Zu1ADG+QW4sFrkwczPG35r4DGSffDmmQn8mdfsT61bO5JwvLZuMzCP+xnsKFhm
        lYCAym15KrflqfzfuA7gJuBHqWlFJkWL1BHbL9YCNl98CGoBNQ8fhdkAxgE2ADm4wNf7SJk2
        jeedIfv8C0qjkmp0coq2AYlrwqU4f2e6yvVllFqpSHJALBajiMioSIlY4O99VHhXyuNmyrRU
        DkWpKc2zPozjyc/FdiUKbT0z5waNnz4our5iObaj4UPLd5kVvI71zvTdv6ts98vW4bXW8ofJ
        fP8PnF0isXkt+NdU35MJ1kPWnak/l6wOoKK23s57VYn6tdCj/tF0vGn/Qh+bNfDyvNQzkjxT
        bgpcHLjcZVQtxL09tufrQafjt2H417Hdl+IidrwzquRtGC1+3Tn8YSr30EfdbLHzRdZGVFPQ
        g7mv+g35KZq9Zv3pxRXJndpXmnbNV63M5FxpHUmxfTky019vf60x5vBTR8V1n6kTAUbpe7Vj
        k9l61lD34OG86dryOnK157g11fPjU5+8X2Fvd/65ryTonLg45dZBXt6paftF6lXnmwpnocKW
        LGDRWTJRCK6hZf8BuaUufXoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSvK4FT2mCwf+DIhZzVm1jtFh9t5/N
        YtqHn8wWre3fmCyaF69nszg9YRGTRc+TJlaLv133mCy+Piy22HtL2+LyrjlsFocmNzNZTN88
        h9ni2v0z7BaH711lsXi4ZCKzxbmTn1gt5j12sPi1/Cijxfsf19ktTu2YzGyxfu9PNgcxj8tX
        vD0mNr9j99g56y67x+YVWh6Xz5Z6bFrVyeaxf+4ado/3+66yefRtWcXo8XmTnEf7gW6mAO4o
        LpuU1JzMstQifbsErowl084yFtxgq3i2cDljA+Nhli5GTg4JAROJbcd/A9lcHEICuxkljrRO
        ZYZISEkcP/GWtYuRA8gWljh8uBii5iOjxJ0rtxlBatgEdCT63t5iA0mICNxmkri05SjYJGaB
        14wSXY8Xga0QFtCSuNV2DayDRUBV4vLTbWAbeAWsJa5t3Qh1hrzEn/s9UHFBiZMzn4DFmYHi
        zVtnM09g5JuFJDULSWoBI9MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgeNPS3MG4
        fdUHvUOMTByMhxglOJiVRHjdppQkCPGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEk
        NTs1tSC1CCbLxMEp1cA081fFevPvq1W+xG+q6G/3N+zbJi3JskdleuS0Gv2zC+/8PP3KaX66
        TfL8I46b6resPPKeKfLpHDfTs0vqL85Q5xS+/qRrd2LTJ2slsTAvv/uztDfkW57pEpq0e0r0
        pw1L/heJBDmyfz5hEfkx7br20X43J8UVd9JN+S9s37mySuuKDr+Oaewfn9u9TwvXTpdZME/g
        LeNvbfGUvE9nJG//elW7K2BTelZYf78/++9+vogbp7laP/z/YjGzzVDjcPD8yc90ml6dzDmU
        +0fv+t776jFXZ17x3cXz4qNaje+MrkK7G5/y8hbdy98Y9C1M5k9NzoQnJ4LPSLkeNuDZ9sQm
        +8uHX9999/988vPuF13mZUosxRmJhlrMRcWJAPJ18L4mAwAA
X-CMS-MailID: 20210413031256epcas1p2f3c3f140192178928b92fc070010354d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210413031256epcas1p2f3c3f140192178928b92fc070010354d
References: <CGME20210413031256epcas1p2f3c3f140192178928b92fc070010354d@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I found a inefficient behavior from multipage bvec. Large chunk DIO
scenario is that. This patch series could be a solution to improve it.

Changheun Lee (3):
  bio: limit bio max size
  ufs: set QUEUE_FLAG_LIMIT_BIO_SIZE
  bio: add limit_bio_size sysfs

 Documentation/ABI/testing/sysfs-block | 10 ++++++++++
 Documentation/block/queue-sysfs.rst   |  7 +++++++
 block/bio.c                           | 13 ++++++++++++-
 block/blk-settings.c                  | 17 +++++++++++++++++
 block/blk-sysfs.c                     |  3 +++
 drivers/scsi/scsi_lib.c               |  2 ++
 drivers/scsi/ufs/ufshcd.c             |  1 +
 include/linux/bio.h                   |  4 +++-
 include/linux/blkdev.h                |  4 ++++
 include/scsi/scsi_host.h              |  2 ++
 10 files changed, 61 insertions(+), 2 deletions(-)

-- 
2.29.0

