Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E68EC54EBD
	for <linux-block@archiver.kernel.org>; Thu, 12 Jan 2023 15:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbjALPrE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Jan 2023 10:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240613AbjALPqp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2023 10:46:45 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9ADB4B4
        for <linux-block@vger.kernel.org>; Thu, 12 Jan 2023 07:36:38 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230112153634euoutp02c63c0f06738f26b016847a1b4ace1578~5mcHLhkpr1588315883euoutp02S
        for <linux-block@vger.kernel.org>; Thu, 12 Jan 2023 15:36:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230112153634euoutp02c63c0f06738f26b016847a1b4ace1578~5mcHLhkpr1588315883euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673537794;
        bh=AxXNPCzhcRLbfvakD8TU3p2mCuLqRLlkAjJGkBiv5ss=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=oDZ/xh7e5AohtTKdexPyowJHKVDWNffEBkyEh4yV3QIGCCR25yXIQdI/ThmcR2SYe
         DyH3txAI9JyBU3QQYiAbqts813vRWY+vM2aVXU/z6TqcuJkbsMmDnPQ4Ift5kGGDAy
         LVWKxe3xeyH0ZRUY9XQkbdxUqOU7WU82jRdGgJkk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230112153633eucas1p11fa28ce9141dad4a23d115f8b110267d~5mcHAhGBp1940819408eucas1p14;
        Thu, 12 Jan 2023 15:36:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5D.71.56180.10920C36; Thu, 12
        Jan 2023 15:36:33 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230112153633eucas1p10f12606b5b4a64767a5aff1a35ac431e~5mcGwriLc2728127281eucas1p1j;
        Thu, 12 Jan 2023 15:36:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230112153633eusmtrp10ac34d34cc190a0fcb33464a721c1e67~5mcGwGZZa2225622256eusmtrp1d;
        Thu, 12 Jan 2023 15:36:33 +0000 (GMT)
X-AuditID: cbfec7f2-acbff7000000db74-11-63c0290119c8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 85.A8.23420.10920C36; Thu, 12
        Jan 2023 15:36:33 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230112153633eusmtip2ee025424441ad83d0b087cd2b2cb3693~5mcGmuurD0425704257eusmtip2a;
        Thu, 12 Jan 2023 15:36:33 +0000 (GMT)
Received: from [192.168.8.107] (106.210.248.231) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 12 Jan 2023 15:36:32 +0000
Message-ID: <2c04a2bd-9f5d-a55f-4936-ff111e8b0305@samsung.com>
Date:   Thu, 12 Jan 2023 16:36:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/3] block zoned cleanups
Content-Language: en-US
To:     <axboe@kernel.dk>
CC:     <linux-nvme@lists.infradead.org>, <hch@lst.de>,
        <bvanassche@acm.org>, <linux-block@vger.kernel.org>,
        <damien.lemoal@opensource.wdc.com>, <gost.dev@samsung.com>,
        <snitzer@kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20230110143635.77300-1-p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.231]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djP87qMmgeSDY6ctrRYfbefzWLah5/M
        Fr/Pnme2WLn6KJPF3lvaFvOXPWW3OHFL2oHd4/IVb4/LZ0s9Nq3qZPPYvKTeY/fNBjaPna33
        WT0+b5ILYI/isklJzcksSy3St0vgypj68gZLwV3OiqkXjjE2MN5m72Lk4JAQMJH40pnWxcjF
        ISSwglHiwes9LBDOF0aJn1PuMEI4nxklGjbuAergBOs4tWAeO0RiOaPEv1n/EKpOP3kAldnN
        KHHkzxs2kBZeATuJY2dmMoHYLAKqEl+f9bNAxAUlTs58AmaLCkRJNF34CWYLCxhI3N9xlxnE
        ZhYQl7j1ZD4TyLEiAqIScxZVgsxnFtjLKLHp0SNGkDibgJZEYyfYdZwCVhIXJv5mhGjVlGjd
        /psdwpaX2P52DjPEz8oSn54nQDxTK7H22BmwkyUEujklTszcwwiRcJE419nNDGELS7w6vgXq
        exmJ05N7WCDsaomnN34zQzS3MEr071zPBrHAWqLvTA6E6SjRf1cRwuSTuPFWEOIaPolJ26Yz
        T2BUnYUUDrOQ/DsLyQOzkDywgJFlFaN4amlxbnpqsWFearlecWJucWleul5yfu4mRmAyOv3v
        +KcdjHNffdQ7xMjEwXiIUYKDWUmEd8/R/clCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeWdsnZ8s
        JJCeWJKanZpakFoEk2Xi4JRqYDJni5R9uv397Dkq6zvb5n24kuj5rjToiuE+oVt2C95IL7kk
        J7T3/WvLV3OWH5og1tW3p8po4yefjAvzfKYzzNqTdTWzs9fZtOUc694NerVPI+u/MAgqfrtc
        fy9lUW3R7VeL7P3sNZ78i2ms5Sy/kvDfr8f+TM+ryyr/ig/2bUzg35relHfi/2Xnyf/EOPXF
        vCwnda35qepa5zJR9edRjmNlNoxHrK4unfTdPn9v3a1/ewIEZj6donivJZfpjFTZgS5xxz2x
        c8wuPf167ZTURZ+jeg9M1c5yaM002HVpUcpx9/PZJVxbjQXyvlY/nFRhe150BePnmH8s52/7
        lToIVvIVHbeP0onZ9vfE/ce7DT4rsRRnJBpqMRcVJwIAkTIvpbUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xe7qMmgeSDZ71aVisvtvPZjHtw09m
        i99nzzNbrFx9lMli7y1ti/nLnrJbnLgl7cDucfmKt8fls6Uem1Z1snlsXlLvsftmA5vHztb7
        rB6fN8kFsEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp
        2yXoZUx9eYOl4C5nxdQLxxgbGG+zdzFyckgImEicWjAPyObiEBJYyihx4+kLRoiEjMSnKx+h
        ioQl/lzrYoMo+sgo8evvXSYIZzejxI6WRhaQKl4BO4ljZ2YygdgsAqoSX5/1Q8UFJU7OfAJm
        iwpESdw8/xCsRljAQOL+jrvMIDazgLjErSfzgeIcHCICohJzFlWCzGcW2MsosenRI0aIZb2M
        Ej//9zGCFLEJaEk0doJdxylgJXFh4m9GiDmaEq3bf7ND2PIS29/OYQYplxBQlvj0PAHimVqJ
        V/d3M05gFJ2F5LpZSK6YhWTSLCSTFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM423H
        fm7ewTjv1Ue9Q4xMHIyHGCU4mJVEePcc3Z8sxJuSWFmVWpQfX1Sak1p8iNEUGEQTmaVEk/OB
        iSSvJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoFJty/If6reY6t5
        8tXb9BXDVs09mSzdMDGMZS5H4MWce5XNn93qHzK965nD/6muzG7tTPE5ByP1zUO8Zs6cqOvR
        179MTKKN1UOrM7ciUTTJJ3if2Bz/hz7C1403HboqJGjhk7ChMqDKRP8fq46cntHy3O3Pz1hz
        8s279OB4o+DtXb/fXAyJjgrmZD597FFm3f1yDdMptefdHeb0ah5+NOFqgf/bT+f1J/Scytiq
        uuRBYPFMrmrnOZN85H4KZ963aeuRfDdh7nzDw8fnsBnmTMi8bKrt/ujtdb60o2e407qmxf6r
        lOtfMPvxOb6wB2sfN91UnN3i2KmSxnhV4PKGd9MjWOvfpbp5WTEoyOpsVVdiKc5INNRiLipO
        BAAut17sbAMAAA==
X-CMS-MailID: 20230112153633eucas1p10f12606b5b4a64767a5aff1a35ac431e
X-Msg-Generator: CA
X-RootMTR: 20230110143637eucas1p1d82528b632ccda1de4fb2795ff691fe2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230110143637eucas1p1d82528b632ccda1de4fb2795ff691fe2
References: <CGME20230110143637eucas1p1d82528b632ccda1de4fb2795ff691fe2@eucas1p1.samsung.com>
        <20230110143635.77300-1-p.raghav@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping....

On 2023-01-10 15:36, Pankaj Raghav wrote:
> Hi Jens,
>   It is still unclear whether the support for non-po2 zone size devices
>   will be added anytime soon [1]. I have extracted out the cleanup
>   patches that doesn't do any functional change but improves the
>   readability by adding helpers. This also helps a bit to
>   maintain off-tree support as there is an interest to have this feature
>   in some companies.
> 
> [1] https://lore.kernel.org/lkml/20220923173618.6899-1-p.raghav@samsung.com/
> 
> Changes since v1:
> - Remove blk_is_zoned() check in bdev_{is_zone_start, offset_from_zone_start} (Damien)
> - Minor spelling and variable name changes (Bart and Johannes)
> - Remove zonefs patch for now (Damien)
> - Send dm patches separately(Christoph)
> 
> Pankaj Raghav (3):
>   block: remove superfluous check for request queue in bdev_is_zoned()
>   block: add a new helper bdev_{is_zone_start, offset_from_zone_start}
>   block: introduce bdev_zone_no helper
> 
>  block/blk-core.c          |  2 +-
>  block/blk-zoned.c         |  4 ++--
>  drivers/nvme/target/zns.c |  3 +--
>  include/linux/blkdev.h    | 22 +++++++++++++++++-----
>  4 files changed, 21 insertions(+), 10 deletions(-)
> 
