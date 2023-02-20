Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5509C636CC
	for <linux-block@archiver.kernel.org>; Mon, 20 Feb 2023 11:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjBTL7V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Feb 2023 06:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjBTL7U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Feb 2023 06:59:20 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8871E05F
        for <linux-block@vger.kernel.org>; Mon, 20 Feb 2023 03:59:17 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230220115916euoutp02bf76bb56be3425c098e8bf8fa3a64c10~FhohG37vP2021720217euoutp02X
        for <linux-block@vger.kernel.org>; Mon, 20 Feb 2023 11:59:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230220115916euoutp02bf76bb56be3425c098e8bf8fa3a64c10~FhohG37vP2021720217euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676894356;
        bh=M9A3gERF5ytAhKlXK3OOjQMQS2WqYZuuSeGP4YaVU2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ql35mKcaCC2vigxPZx8Cwy7vqT27gvLS8YyJekpZ/hk43wNgjnCvE/2FmhIg2af+d
         akL8/BzV9NhPgSPdzAE4AIyvIoNcvyu2Ez4R3ydMQSd3i9gNTwjxYjNeVfof5A3USN
         HYZWJ+hoehnB2tzFcn1UW8RLTolfb9ycCErMJDXw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230220115915eucas1p1c3f806ad59b2b12ad0303b73959288e3~Fhog_EczB0324403244eucas1p1x;
        Mon, 20 Feb 2023 11:59:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 60.71.01471.39063F36; Mon, 20
        Feb 2023 11:59:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230220115915eucas1p164d1b65b3cb0b140468af33e0f966807~FhogicAC91237612376eucas1p1I;
        Mon, 20 Feb 2023 11:59:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230220115915eusmtrp26dc96d81855cf22e94c44523218c7245~Fhogh2U640559305593eusmtrp2P;
        Mon, 20 Feb 2023 11:59:15 +0000 (GMT)
X-AuditID: cbfec7f2-29bff700000105bf-47-63f36093af75
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BA.E8.00518.39063F36; Mon, 20
        Feb 2023 11:59:15 +0000 (GMT)
Received: from localhost (unknown [106.210.248.118]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230220115915eusmtip1a5be940fee2f35268907106675c148d0~FhogFUiqB3249932499eusmtip1O;
        Mon, 20 Feb 2023 11:59:15 +0000 (GMT)
Date:   Mon, 20 Feb 2023 17:29:11 +0530
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Juhyung Park <qkrwngud825@gmail.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v2] block: remove more NULL checks after
 bdev_get_queue()
Message-ID: <20230220115911.2lmxkmietqqywpwp@quentin>
MIME-Version: 1.0
In-Reply-To: <20230203024029.48260-1-qkrwngud825@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7djPc7qTEz4nG/zZYmax+m4/m8XeW9oW
        Rx8vZHNg9tg56y67x+WzpR6fN8kFMEdx2aSk5mSWpRbp2yVwZSyc8pC9YCN7xcTJ0xkbGDew
        dTFyckgImEg0P57A1MXIxSEksIJRYvb//0wgCSGBL4wSWw/oQyQ+M0pc2zmHtYuRA6zj605j
        iPhyRolJKx5Adb9klPj/8AIzSDeLgKrEwhtfmEEa2AS0JBo72UHCIgIaEq0XzrOA2MwCBhJP
        zj0BiwsL+EvMubcPLM4rYCqx+ddjKFtQ4uTMJ2A2p4C1xLlrIDVcQDf0ckh03vsM9YKLxOep
        PYwQtrDEq+Nb2CFsGYn/O+czQdjVEk9v/GaGaG5hlOjfuZ4N4htrib4zORAHZUrc+vGWFaLe
        UeLAxaNQJXwSN94KQpTwSUzaNp0ZIswr0dEmBFGtJLHz5xOorRISl5vmsEDYHhI3/oFcCQqe
        PkaJxf+XM01glJ+F5LVZSDZD2DoSC3Z/YpsFtIJZQFpi+T8OCFNTYv0u/QWMrKsYxVNLi3PT
        U4sN81LL9YoTc4tL89L1kvNzNzEC08fpf8c/7WCc++qj3iFGJg7GQ4wSHMxKIrz/eT8nC/Gm
        JFZWpRblxxeV5qQWH2KU5mBREufVtj2ZLCSQnliSmp2aWpBaBJNl4uCUamByr76Rylj7oJa1
        d6vyoy/bJ94xCOFqntWw2eucS3hTSMQrG/vr6XJzA4XFnmmxrHr7N+cxf4nc8fki69lELzRz
        3tAOmeo2L/mg4NpvW8p+X2W/l2p2rGTHxW0JIa8cFnfVGRWpsIn89Vn2gVHPsPHFqc/vz4VH
        +3N+XfLcWH5P6Rpb2czbDF5JfbtOqZZmXl7w2Xfe+oqMNz7hjOw9s//u1Oy/e+P3V15e5blf
        Ntcfl7NcuiXnwpo+hWZOOZZj7AnN8tL7tAPbvadkVZ/4aRj/+3aNrosib9ybtpqP73XvFO4t
        3zU13+3FlqLVU9Sfix9/m5C2kb39YUTf++ezddudJhrk77M5JnKhIK2hf7cSS3FGoqEWc1Fx
        IgD1rw+cjgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsVy+t/xu7qTEz4nG1z/K2Gx+m4/m8XeW9oW
        Rx8vZHNg9tg56y67x+WzpR6fN8kFMEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvH
        WhmZKunb2aSk5mSWpRbp2yXoZWz5MJGx4B1LxYblM9kbGNtYuhg5OCQETCS+7jTuYuTiEBJY
        yigx7d4SoDgnUFxC4vbCJkYIW1jiz7UuNoii54wSE6c9BkuwCKhKLLzxhRlkEJuAlkRjJztI
        WERAQ6L1wnmwOcwCBhJPzj0BiwsL+Eq0/HrNCmLzCphKbP71GOwGIQEribUPJSHCghInZz6B
        atWSuPHvJRNICbOAtMTyfxwgYU4Ba4lz1/axTGAUmIWkYxaSjlkIHQsYmVcxiqSWFuem5xYb
        6RUn5haX5qXrJefnbmIEhvi2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrz/eT8nC/GmJFZWpRbl
        xxeV5qQWH2I0Bfp3IrOUaHI+MMrySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtS
        i2D6mDg4pRqYZAoUZJJ6jb3YuN08f1wP+eZ88mQU36ZVLLO1vKfZH97z55+n7V9XwwweC506
        huSVkowJKjM6my8VL45eP3VB6Tq5XcuWh57+LaPQELbmyYTING/XOdNvS5w9MClyvpXy7fJL
        uwqym3iFn7Lv13EuYIro4dBfe0eqZkFu4atapolRG+/MDpO4ZSX1fFF0ePqOug9eW+/9cGbf
        UrHxgNIk8VmCi7K1v4Y1lvwp2tvbfeX7/FZ30XuPD2Vv9JxsGd5zqDvifjzLzv9zEwvP6rFe
        N9t/piHAdr3Sw3Bp8Q1zz1rEnUwpS/Te3y1bfUhfNfmlKnfSL2VJIdUbXlvWHT++1T9Y7O+h
        0Lr6L187ns9SYinOSDTUYi4qTgQAOjqqivoCAAA=
X-CMS-MailID: 20230220115915eucas1p164d1b65b3cb0b140468af33e0f966807
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----ne2T92axF1zxmICHxTGG9HmPt4_QlnxLDzDMENhgOSO8xpR3=_13b0fc_"
X-RootMTR: 20230220115915eucas1p164d1b65b3cb0b140468af33e0f966807
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230220115915eucas1p164d1b65b3cb0b140468af33e0f966807
References: <20230203024029.48260-1-qkrwngud825@gmail.com>
        <CGME20230220115915eucas1p164d1b65b3cb0b140468af33e0f966807@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------ne2T92axF1zxmICHxTGG9HmPt4_QlnxLDzDMENhgOSO8xpR3=_13b0fc_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Feb 03, 2023 at 11:40:29AM +0900, Juhyung Park wrote:
> bdev_get_queue() never returns NULL. Several commits [1][2] have been made
> before to remove such superfluous checks, but some still remained.
> 
> For places where bdev_get_queue() is called solely for NULL checks, it is
> removed entirely.
> 
> [1] commit ec9fd2a13d74 ("blk-lib: don't check bdev_get_queue() NULL check")
> [2] commit fea127b36c93 ("block: remove superfluous check for request queue in bdev_is_zoned()")
> 
> Signed-off-by: Juhyung Park <qkrwngud825@gmail.com>

Looks good,
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

------ne2T92axF1zxmICHxTGG9HmPt4_QlnxLDzDMENhgOSO8xpR3=_13b0fc_
Content-Type: text/plain; charset="utf-8"


------ne2T92axF1zxmICHxTGG9HmPt4_QlnxLDzDMENhgOSO8xpR3=_13b0fc_--
