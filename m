Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B56C678D5
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 11:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjCGL5T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 06:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCGL5S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 06:57:18 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859925BAD
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 03:57:14 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230307114200euoutp02281c859b1b1ac142f92602471eacfb2a~KIEvCuN5M0682306823euoutp02s
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 11:42:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230307114200euoutp02281c859b1b1ac142f92602471eacfb2a~KIEvCuN5M0682306823euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678189320;
        bh=dMicR/PqBnZ+y0Jbh6COUN5gjkfXWyDqHpF6T2VosZc=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=OuwRVuuISJLNt6+QuSSqC28N7Jbxm57wMACFSsr8tJkdrr307aAsB+txCNbA1ZUU+
         QMFp03zH5gslb1EHQGCADQ2uxTA74sSWITz0IGsVpfkFeX2m1nCgcBy/BLdnBnsBGN
         mckWwyEzZaOSz1HwFjO36sxD8c6ypgXGBh73mmRA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230307114200eucas1p23a9ec57c4927fb632a6f7ef0242f037d~KIEuyuj4v1888318883eucas1p2W;
        Tue,  7 Mar 2023 11:42:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 80.1D.09503.80327046; Tue,  7
        Mar 2023 11:42:00 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230307114200eucas1p296a60514feb40c4a08f380cc28aeeb51~KIEuehW2i1235712357eucas1p28;
        Tue,  7 Mar 2023 11:42:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230307114200eusmtrp2c82100022b28b387ed0f114317f18f7b~KIEud9Kh70982909829eusmtrp2J;
        Tue,  7 Mar 2023 11:42:00 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-29-6407230857af
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D3.71.09583.80327046; Tue,  7
        Mar 2023 11:42:00 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230307114200eusmtip2da680052f4827de75b4814dd44876a79~KIEuSYRPA3031530315eusmtip2c;
        Tue,  7 Mar 2023 11:42:00 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 7 Mar 2023 11:41:59 +0000
Date:   Tue, 7 Mar 2023 12:33:48 +0100
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Hannes Reinecke <hare@suse.de>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/5] brd: Allow to change block sizes
Message-ID: <20230307113348.vhthkahkut7ve5tq@blixen>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230306120127.21375-1-hare@suse.de>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduznOV0OZfYUg4XrlCxW3+1ns9izaBKT
        xaRD1xgt9t7Strgx4Smjxe8fc9gc2Dw2r9DyuHy21GPTqk4g53S1x+dNcgGsUVw2Kak5mWWp
        Rfp2CVwZi4+dYi14pVVx/PVJ9gbG+7JdjBwcEgImEh+PqHUxcnEICaxglDg0ZTsbhPOFUWL3
        ysnMEM5nRonO3gnsMB0bugIg4ssZJZ4sX88IV/Rl1QSgdk4gZzOjxNsDYSA2i4CKxKdLl9lA
        mtkEtCQaO9lBwiICShIf2w+xg/QyC2xglGi4/5kRJCEsYCnx+/szJhCbF2jZ40+/GCFsQYmT
        M5+wgNjMAjoSC3Z/ApvJLCAtsfwfB0iYU8BIYvH152AnSADNb9h8hgXCrpU4teUWE8guCYEb
        HBJLVhxihki4SMz7vI0RwhaWeHV8CzuELSPxf+d8Jgi7WuLpjd/MEM0tjBL9O9ezQULCWqLv
        TA6E6ShxodEPwuSTuPFWEOJKPolJ26YzQ4R5JTrahCAGqknsaNrKOIFReRaSv2Yh+WsWwl8L
        GJlXMYqnlhbnpqcWG+allusVJ+YWl+al6yXn525iBKaU0/+Of9rBOPfVR71DjEwcjIcYJTiY
        lUR4375jSxHiTUmsrEotyo8vKs1JLT7EKM3BoiTOq217MllIID2xJDU7NbUgtQgmy8TBKdXA
        lP3C037nBiHre0/UU/axVJy5eah018FVx4JK+6dF/Ei43HTz0+ZlMt/rT1+beOCsy8L2Ld8j
        vzw1L7BfPS2Vg2ve3SW6i5mb9142/b5moWiT/M0VNxbe/WE1Q06k11UodtK68gXLw/7FNTbY
        GU51jvEMKpyV+U7sbtOjGe90Hq7+Zl62K3Ilf1WCWuDJ2U0/nOurv714o5la+Xnvz7hm3nS9
        RV+qQjYKL3HgF2fMPOUx1+VCl+z79FzmgNvbjB88Of/V4XHFJI0n9/Q2LdloPunBi6gljYzH
        j5wVuOT+R+fdu4SoPTdkRfU5nh78ESG9g/GUbeMam7mr5a055jB8fXEh0p9zZcfEN8oHyxM6
        K5uUWIozEg21mIuKEwGfUcSomAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7ocyuwpBk/381msvtvPZrFn0SQm
        i0mHrjFa7L2lbXFjwlNGi98/5rA5sHlsXqHlcflsqcemVZ1Azulqj8+b5AJYo/RsivJLS1IV
        MvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyFh87xVrwSqvi+OuT
        7A2M92W7GDk4JARMJDZ0BXQxcnEICSxllLi4+TNLFyMnUFxG4tOVj+wQtrDEn2tdbBBFHxkl
        uu78ZYdwNjNKzOrsBetgEVCR+HTpMhvIVDYBLYnGTrBmEQEliY/th8DqmQU2MEoc+HCSCSQh
        LGAp8fv7MzCbF+iKx59+MYLYQgKGEsfnLoWKC0qcnPkEbD6zgI7Egt2fwOYzC0hLLP/HARLm
        FDCSWHz9ORvEoUoSDZvPQD1QK/H57zPGCYzCs5BMmoVk0iyESQsYmVcxiqSWFuem5xYb6RUn
        5haX5qXrJefnbmIExte2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrxv37GlCPGmJFZWpRblxxeV
        5qQWH2I0BYbERGYp0eR8YITnlcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0
        MXFwSjUw8W3ex9TnWOsxbZHZpYBd7h+1P/LEXI7dsF7vrWBJcpNRt5CrHutC9f0mQuecXxzv
        WnK4emkg165ClbeOTLOK7yh/XXG2dsKBOUUrs18rlXR/lWeqNf2y83TE7fVpmT9cPVxexE2r
        3DVVm+vuiskS/4Vvyd/eUbiueNqqmHl8R04/uihd+veby5/SCpb/F33qa939b879Ftx492GO
        2oLpMytemxwpvy5V4b/+bX1Jfl389upTfa9/72/bt7vGteLCN8l736/WXJY9fMSyceF51SOn
        dwsueb73n95HF36zzOsSAVVz5y8tlpz89xcf53XumhfVB1ZsbmA0/eQ6mc34dNfW3tCfd3X2
        HOO73neydK8SS3FGoqEWc1FxIgCsHTnpOAMAAA==
X-CMS-MailID: 20230307114200eucas1p296a60514feb40c4a08f380cc28aeeb51
X-Msg-Generator: CA
X-RootMTR: 20230307114200eucas1p296a60514feb40c4a08f380cc28aeeb51
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230307114200eucas1p296a60514feb40c4a08f380cc28aeeb51
References: <20230306120127.21375-1-hare@suse.de>
        <CGME20230307114200eucas1p296a60514feb40c4a08f380cc28aeeb51@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Hannes,

On Mon, Mar 06, 2023 at 01:01:22PM +0100, Hannes Reinecke wrote:
> Hi all,
> 
> meat to the bone: with this patchset one can change the physical and
> logical block size of the 'brd' ramdisk driver.
> Default is 512 (for both); one can easily increase the physical block
> size to 16k and the logical block size to 4k.
> Increasing the logcial block size beyond 4k gives some 'interesting'
> crashes.

I did something similar for an internal prototype to test large block
size. I ran the perf test suite I created on your changes and I can
clearly see a perf increase for large block IOs.

I enabled huge pages and used the iomem=mmaphuge option in fio to test
large block IOs. Here are my results:

base: next-20230307
new: base with your changes on top

bw: bandwith in MiB/s

For each set of rd_blksize and rd_logical_blksize, I ran the test with
different fio blocksize as indicated by `io_uring_iod_128_bs_4k`

rd_blksize=8192 and rd_logical_blksize=4096
+------------------------+-------------+------------+-------+----------+---------+-------+
| io_uring_iod_128_bs_4k | base[kiops] | new[kiops] | delta | base[bw] | new[bw] | delta |
+------------------------+-------------+------------+-------+----------+---------+-------+
|          read          |     567     |    605     |  6.7  |   2214   |  2362   | 6.68  |
|        randread        |     517     |    529     | 2.32  |   2019   |  2066   | 2.33  |
|         write          |     551     |    558     | 1.27  |   2154   |  2179   | 1.16  |
|       randwrite        |     481     |    502     | 4.37  |   1880   |  1962   | 4.36  |
+------------------------+-------------+------------+-------+----------+---------+-------+
+------------------------+-------------+------------+-------+----------+---------+-------+
| io_uring_iod_128_bs_8k | base[kiops] | new[kiops] | delta | base[bw] | new[bw] | delta |
+------------------------+-------------+------------+-------+----------+---------+-------+
|          read          |     462     |    512     | 10.82 |   3611   |  3997   | 10.69 |
|        randread        |     426     |    445     | 4.46  |   3326   |  3480   | 4.63  |
|         write          |     442     |    472     | 6.79  |   3454   |  3687   | 6.75  |
|       randwrite        |     401     |    426     | 6.23  |   3134   |  3328   | 6.19  |
+------------------------+-------------+------------+-------+----------+---------+-------+
+-------------------------+-------------+------------+-------+----------+---------+-------+
| io_uring_iod_128_bs_16k | base[kiops] | new[kiops] | delta | base[bw] | new[bw] | delta |
+-------------------------+-------------+------------+-------+----------+---------+-------+
|          read           |     343     |    390     | 13.7  |   5360   |  6086   | 13.54 |
|        randread         |     317     |    364     | 14.83 |   4946   |  5694   | 15.12 |
|          write          |     335     |    346     | 3.28  |   5235   |  5414   | 3.42  |
|        randwrite        |     305     |    327     | 7.21  |   4759   |  5106   | 7.29  |
+-------------------------+-------------+------------+-------+----------+---------+-------+

rd_blksize=16384 and rd_logical_blksize=4096
+------------------------+-------------+------------+-------+----------+---------+-------+
| io_uring_iod_128_bs_4k | base[kiops] | new[kiops] | delta | base[bw] | new[bw] | delta |
+------------------------+-------------+------------+-------+----------+---------+-------+
|          read          |     576     |    586     | 1.74  |   2250   |  2291   | 1.82  |
|        randread        |     524     |    548     | 4.58  |   2046   |  2139   | 4.55  |
|         write          |     533     |    545     | 2.25  |   2081   |  2129   | 2.31  |
|       randwrite        |     484     |    496     | 2.48  |   1892   |  1938   | 2.43  |
+------------------------+-------------+------------+-------+----------+---------+-------+
+------------------------+-------------+------------+-------+----------+---------+-------+
| io_uring_iod_128_bs_8k | base[kiops] | new[kiops] | delta | base[bw] | new[bw] | delta |
+------------------------+-------------+------------+-------+----------+---------+-------+
|          read          |     461     |    491     | 6.51  |   3601   |  3836   | 6.53  |
|        randread        |     425     |    472     | 11.06 |   3323   |  3684   | 10.86 |
|         write          |     454     |    465     | 2.42  |   3543   |  3632   | 2.51  |
|       randwrite        |     395     |    430     | 8.86  |   3086   |  3357   | 8.78  |
+------------------------+-------------+------------+-------+----------+---------+-------+
+-------------------------+-------------+------------+-------+----------+---------+-------+
| io_uring_iod_128_bs_16k | base[kiops] | new[kiops] | delta | base[bw] | new[bw] | delta |
+-------------------------+-------------+------------+-------+----------+---------+-------+
|          read           |     338     |    400     | 18.34 |   5282   |  6255   | 18.42 |
|        randread         |     317     |    384     | 21.14 |   4959   |  5997   | 20.93 |
|          write          |     335     |    354     | 5.67  |   5239   |  5525   | 5.46  |
|        randwrite        |     303     |    326     | 7.59  |   4728   |  5097   |  7.8  |
+-------------------------+-------------+------------+-------+----------+---------+-------+

