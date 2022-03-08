Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47632C433F5
	for <linux-block@archiver.kernel.org>; Tue,  8 Mar 2022 16:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbiCHQzQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 11:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbiCHQzP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 11:55:15 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E33B4EA31
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 08:54:17 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220308165415euoutp01e4b2bb1ab5a58a7691288f2b40c8ba33~adhclI2vL3222332223euoutp01P
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 16:54:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220308165415euoutp01e4b2bb1ab5a58a7691288f2b40c8ba33~adhclI2vL3222332223euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646758455;
        bh=DVWYiQZI1nKd9R78r+5DqRDkHxcFQwzM1wM8Z6qv000=;
        h=From:To:Cc:Subject:Date:References:From;
        b=EUv3SSAYU9jEOjNPE+kups+KTKXf1nPeu3x5oYixY4Y/hDJfMINvKlhmFliNu6GGI
         2qyFMUyXvOpL/4qkIUbWTP4yFZ7i07vrA4CYemyqu033PasLOEQZtfPWzb7e92JTP7
         kvj5DDu/fD2pNu0PCQkuMn7ItWLr75bXWO7H2mW4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220308165415eucas1p198934546e51c58554f75ca43224f8813~adhcIEtwN0389503895eucas1p1d;
        Tue,  8 Mar 2022 16:54:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 10.AD.09887.63A87226; Tue,  8
        Mar 2022 16:54:14 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220308165414eucas1p106df0bd6a901931215cfab81660a4564~adhbjebPQ0451504515eucas1p1a;
        Tue,  8 Mar 2022 16:54:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220308165414eusmtrp12bfc3e097f2865107747e511b8275ede~adhbiV7KW0499204992eusmtrp1a;
        Tue,  8 Mar 2022 16:54:14 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-f8-62278a36700e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D2.73.09522.63A87226; Tue,  8
        Mar 2022 16:54:14 +0000 (GMT)
Received: from localhost (unknown [106.210.248.181]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220308165414eusmtip1be13002a57f36e518a5408b47888d556~adhbNGoHv0472304723eusmtip1k;
        Tue,  8 Mar 2022 16:54:14 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        jiangbo.365@bytedance.com
Cc:     Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Date:   Tue,  8 Mar 2022 17:53:43 +0100
Message-Id: <20220308165349.231320-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7djPc7pmXepJBotOW1tMP6xosfpuP5vF
        77PnmS1Wrj7KZPH4zmd2i54DH1gsjv5/y2Zx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5M
        eMpo8XlpC7vFmptPWSzWvX7P4iDg8e/EGjaPnbPusnucv7eRxePy2VKPTas62Tw2L6n32H2z
        ASjXep/Vo2/LKkaPz5vkPNoPdDMFcEdx2aSk5mSWpRbp2yVwZRx8s465YGdqxcIfP5gbGB/7
        dDFyckgImEjcPtbC0sXIxSEksIJRov/IBjYI5wujxOwzH6Gcz4wSGzqmMsG0LDp/kgkisZxR
        ouP2Z3aQhJDAS0aJfROAEhwcbAJaEo2dYGERgQvMEj9uKoLUMwtsZpT4MGkFK0iNsICbRPdL
        EZAaFgFViQP/DzOC2LwCVhK3pzawQOySl5h56Ts7RFxQ4uTMJ2BxZqB489bZzBA13ZwSS697
        Q9guEj/Wr4DqFZZ4dXwLO4QtI3F6cg/YmxIC/YwSU1v+MEE4Mxgleg5vBjtaQsBaou9MDojJ
        LKApsX6XPkSvo8T/79NYISr4JG68FYQ4gU9i0rbpzBBhXomONiGIaiWJnT+fQG2VkLjcNAfq
        Gg+JPZeXs0ICKlZi/pHbrBMYFWYheWwWksdmIdywgJF5FaN4amlxbnpqsVFearlecWJucWle
        ul5yfu4mRmDSO/3v+JcdjMtffdQ7xMjEwXiIUYKDWUmE9/55lSQh3pTEyqrUovz4otKc1OJD
        jNIcLErivMmZGxKFBNITS1KzU1MLUotgskwcnFINTI3P1fVTv06qe75os0nwonsH+/sVtGde
        NPtVd2Z+14k/e0+eSU7T3qJ70N2ecUJMbZnOmeXLsyU+nPR43vur9lr9EutDwdaCR07Xc195
        NDm82vCdQsDyZ8+itFUt4w03V6+/vLF77R6TDJ0d3A67ai6KHTh3/PpOuzVTlPYf1reJ/x82
        +VikqHzAVV8mycL7nvVOoVEHl5/8uCztzRGGVftmZCyo9NvuOzvtN/c3tVvfb970PPd/L/+T
        2WxcexjiZHmnid6fsvq1TWKEddnlHVfqr169HRI291zW46y1b1X1TSuUlVfe89sZuZ5ZVCI0
        OvN2zdTJv0T+FqUeuXTxpMXinA8Lm6Jbfwj9WvssZZWdEktxRqKhFnNRcSIAhlkwiOkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t/xu7pmXepJBh93i1hMP6xosfpuP5vF
        77PnmS1Wrj7KZPH4zmd2i54DH1gsjv5/y2Zx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5M
        eMpo8XlpC7vFmptPWSzWvX7P4iDg8e/EGjaPnbPusnucv7eRxePy2VKPTas62Tw2L6n32H2z
        ASjXep/Vo2/LKkaPz5vkPNoPdDMFcEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvH
        WhmZKunb2aSk5mSWpRbp2yXoZRx8s465YGdqxcIfP5gbGB/7dDFyckgImEgsOn+SCcQWEljK
        KDG9rwwiLiFxe2ETI4QtLPHnWhdbFyMXUM1zRomDR86wdDFycLAJaEk0drKDxEUEbjBLLJva
        xgjiMAtsZ5TYsHIOG0iRsICbRPdLEZBBLAKqEgf+HwYbyitgJXF7agMLxAJ5iZmXvrNDxAUl
        Ts58AhZnBoo3b53NPIGRbxaS1CwkqQWMTKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECI27b
        sZ+bdzDOe/VR7xAjEwfjIUYJDmYlEd7751WShHhTEiurUovy44tKc1KLDzGaAt03kVlKNDkf
        GPN5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MoVb6N7v3n9Vo
        ju8XO2um8eUY/57eg3pfdvkpP9Yv4rWTirWUOV0XckbdRuWdVWjBo8rH4v4rOC5Mvb905eH3
        H0K35mdWC/rb7f4gF7+yKmeunviOI6tPvJ1Zeo1l2mmud7/MD2qef+DIMKfBfrvu7VPnGvc3
        fnzfIpWT9W6NkOC8eN64nW9WLVpmz3WLJ+7GJc6Qxx66cvqJxYe2PhK0mv10+uo5D29P5Zvw
        uuTzXDF5/ltOsydNc5Q8Xfi0zbUubrfqdP0V24T8mvs/PMhwU0qa2v/2n7Mh2/K48+wfW5t9
        1x6tCml+GjutIXp1699t/e7WB3b8PnRSSszojls+7x52K5792yvvXni6L3C1sxJLcUaioRZz
        UXEiAMb7MZxBAwAA
X-CMS-MailID: 20220308165414eucas1p106df0bd6a901931215cfab81660a4564
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220308165414eucas1p106df0bd6a901931215cfab81660a4564
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220308165414eucas1p106df0bd6a901931215cfab81660a4564
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


#Motivation:
There are currently ZNS drives that are produced and deployed that do
not have power_of_2(PO2) zone size. The NVMe spec for ZNS does not
specify the PO2 requirement but the linux block layer currently checks
for zoned devices to have power_of_2 zone sizes.

As a result there are many applications in the kernel such as F2FS,
BTRFS and other userspace applications that are designed based on the assumption
that zone sizes are PO2.

This patchset aims at supporting non-power_of_2 zoned devices without
affecting the existing applications by adding an emulation layer for
NVMe ZNS devices without regressing the current upstream implementation.

#Implementation:
A new callback is added to the block device operation fops which is
called when a special handling is required by the driver when a
non-power_of_2 zoned device is discovered. This patchset adds support
only to NVMe ZNS and null block driver to measure performance.
The scsi ZAC/ZBC implementation is untouched.

Emulation is enabled by doing a static remapping of the zones only in
the host and whenever a request is sent to the device via the block
layer, a transformation is done to the actual device sector.

#Testing:
There are two things that need to be tested: no regression on the
upstream implementation for PO2 zone sizes and testing the
implementation of the emulation itself.

To do apple-apples comparison, the following device specs were chosen
for testing (both on null_blk and QEMU):
PO2 device:  zone.size=128M zone.cap=96M
NPO2 device: zone.size=96M zone.cap=96M

##Regression:
These tests are done on a **PO2 device**.
PO2 device used:  zone.size=128M zone.cap=96M

###blktests:
Blktests were executed with the following config:

TEST_DEVS=(/dev/nvme0n2)
TIMEOUT=100
RUN_ZONED_TESTS=1

block and zbd tests were performed and no regression were found in the
tests.

###Performance:
Performance tests were performed on a null blk device. The following fio
script was used to measure the performance:

fio --name=zbc --filename=/dev/nullb0 --direct=1 --zonemode=zbd  --size=23G
--io_size=<iosize> --ioengine=io_uring --iodepth=<iod> --rw=<mode> --bs=4k --loops=4

No regressions were found with the patches on a **PO2 device** compared
to the existing upstream implementation.

The following results are an average of 4 runs on AMD Ryzen 5 5600X with
32GB of RAM:

Sequential Write:
x-----------------x---------------------------------x---------------------------------x
|     IOdepth     |             1                   |             4                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
| Without patches |  155     |  604     |   6.00    |  426     |  1663    |   8.77    |
x-----------------x---------------------------------x---------------------------------x
|  With patches   |  157     |  613     |   5.92    |  425     |  1741    |   8.79    |
x-----------------x---------------------------------x---------------------------------x

x-----------------x---------------------------------x---------------------------------x
|     IOdepth     |            8                    |            16                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
| Without patches |  607     |  2370    |   12.06   |  622     |  2431    |   23.61   |
x-----------------x---------------------------------x---------------------------------x
|  With patches   |  621     |  2425    |   11.80   |  633     |  2472    |   23.24   |
x-----------------x---------------------------------x---------------------------------x

Sequential read:
x-----------------x---------------------------------x---------------------------------x
| IOdepth         |             1                   |             4                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
| Without patches |  165     |  643     |   5.72    |  485     |  1896    |   8.03    |
x-----------------x---------------------------------x---------------------------------x
|  With patches   |  167     |  654     |   5.62    |  483     |  1888    |   8.06    |
x-----------------x---------------------------------x---------------------------------x

x-----------------x---------------------------------x---------------------------------x
| IOdepth         |            8                    |            16                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
| Without patches |  696     |  2718    |   11.29   |  692     |  2701    |   22.92   |
x-----------------x---------------------------------x---------------------------------x
|  With patches   |  696     |  2718    |   11.29   |  730     |  2835    |   21.70   |
x-----------------x---------------------------------x---------------------------------x

Random read:
x-----------------x---------------------------------x---------------------------------x
| IOdepth         |             1                   |             4                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
| Without patches |  159     |  623     |   5.86    |  451     |  1760    |   8.58    |
x-----------------x---------------------------------x---------------------------------x
|  With patches   |  163     |  635     |   5.75    |  462     |  1806    |   8.36    |
x-----------------x---------------------------------x---------------------------------x

x-----------------x---------------------------------x---------------------------------x
| IOdepth         |            8                    |            16                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
| Without patches |  544     |  2124    |   14.44   |  553     |  2162    |   28.64   |
x-----------------x---------------------------------x---------------------------------x
|  With patches   |  554     |  2165    |   14.15   |  556     |  2171    |   28.52   |
x-----------------x---------------------------------x---------------------------------x

##Emulated device
NPO2 device: zone.size=96M zone.cap=96M

###blktests:
Blktests were executed with the following config:

TEST_DEVS=(/dev/nvme0n2)
TIMEOUT=100
RUN_ZONED_TESTS=1

block and zbd tests were performed and they are passing.

###Performance:
Performance tests were performed on a null blk device. The following fio
script was used to measure the performance:

fio --name=zbc --filename=/dev/nullb0 --direct=1 --zonemode=zbd  --size=23G
--io_size=<iosize> --ioengine=io_uring --iodepth=<iod> --rw=<mode> --bs=4k --loops=4

On an average, the NPO2 devices had a performance degradation of less than 1%
compared to the PO2 devices.

The following results are an average of 4 runs on AMD Ryzen 5 5600X with
32GB of RAM:

Write:
x-----------------x---------------------------------x---------------------------------x
|     IOdepth     |             1                   |             4                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
|  With patches   |  155     |  606     |   5.99    |  424     |  1655    |   8.83    |
x-----------------x---------------------------------x---------------------------------x

x-----------------x---------------------------------x---------------------------------x
|     IOdepth     |            8                    |            16                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
|  With patches   |  609     |  2378    |   12.04   |  620     |  2421    |   23.75   |
x-----------------x---------------------------------x---------------------------------x

SEQREAD:
x-----------------x---------------------------------x---------------------------------x
| IOdepth         |             1                   |             4                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
|  With patches   |  160     |  623     |   5.91    |  481     |  1878    |   8.11    |
x-----------------x---------------------------------x---------------------------------x

x-----------------x---------------------------------x---------------------------------x
| IOdepth         |            8                    |            16                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
|  With patches   |  696     |  2720    |   11.28   |  722     |  2819    |   21.96   |
x-----------------x---------------------------------x---------------------------------x

RANDREAD:
x-----------------x---------------------------------x---------------------------------x
| IOdepth         |             1                   |             4                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
|  With patches   |  155     |  607     |   6.03    |  465     |  1817    |   8.31    |
x-----------------x---------------------------------x---------------------------------x

x-----------------x---------------------------------x---------------------------------x
| IOdepth         |            8                    |            16                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
|  With patches   |  552     |  2158    |   14.21   |  561     |  2190    |   28.27   |
x-----------------x---------------------------------x---------------------------------x

#TODO:
- The current implementation only works for the NVMe pci transport to
  limit the scope and impact.
  Support for NVMe target will follow soon.

Pankaj Raghav (6):
  nvme: zns: Allow ZNS drives that have non-power_of_2 zone size
  block: Add npo2_zone_setup callback to block device fops
  block: add a bool member to request_queue for power_of_2 emulation
  nvme: zns: Add support for power_of_2 emulation to NVMe ZNS devices
  null_blk: forward the sector value from null_handle_memory_backend
  null_blk: Add support for power_of_2 emulation to the null blk device

 block/blk-zoned.c                 |   3 +
 drivers/block/null_blk/main.c     |  18 +--
 drivers/block/null_blk/null_blk.h |  12 ++
 drivers/block/null_blk/zoned.c    | 203 ++++++++++++++++++++++++++----
 drivers/nvme/host/core.c          |  28 +++--
 drivers/nvme/host/nvme.h          | 100 ++++++++++++++-
 drivers/nvme/host/pci.c           |   4 +
 drivers/nvme/host/zns.c           |  86 +++++++++++--
 include/linux/blk-mq.h            |   2 +
 include/linux/blkdev.h            |  25 ++++
 10 files changed, 428 insertions(+), 53 deletions(-)

-- 
2.25.1

