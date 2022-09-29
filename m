Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6202C433FE
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 13:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbiI2NlO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 09:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiI2NlN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 09:41:13 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1BA149793
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 06:41:08 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220929134104euoutp017208ea988e744ea501c1500a8dbf750b~ZWITA2Yey2290822908euoutp01U
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 13:41:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220929134104euoutp017208ea988e744ea501c1500a8dbf750b~ZWITA2Yey2290822908euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664458864;
        bh=6Fvwg/HkWVXa4HE/luRH7Tcx+Adhx3M/UMFtZ/SXltY=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=RRSjhPjv6grbe85xP3zIRCPs77nqvmDNJLy+s1YFmikFuhEm/6N2j5WYUML7qaItI
         9gOXQ/7XLaoo5YmfcdSLlTnLwZMO7cyu7jc/R9Ph3XvLpycaTZibAL/D4ZeJNTq0GJ
         ayxPakSIhZpfXaLimsnmBZzib3XqZv3L5vfRio+c=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220929134104eucas1p1bdb9c6e3f4ceafc7901fbc5fbb140182~ZWISzGMh32987729877eucas1p1j;
        Thu, 29 Sep 2022 13:41:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C5.F5.07817.070A5336; Thu, 29
        Sep 2022 14:41:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220929134103eucas1p1ea582c82a23203c7c6c760a4b7f5aa3d~ZWISSr8C51860018600eucas1p17;
        Thu, 29 Sep 2022 13:41:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220929134103eusmtrp1fcc3e3601627df47b167014d22a8aa4c~ZWISSF8EK2159721597eusmtrp1D;
        Thu, 29 Sep 2022 13:41:03 +0000 (GMT)
X-AuditID: cbfec7f4-893ff70000011e89-00-6335a070cd21
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CB.4E.07473.F60A5336; Thu, 29
        Sep 2022 14:41:03 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220929134103eusmtip2aef4aab5ea4b51f4b34c8af2558acd96~ZWISGyejb3163031630eusmtip2W;
        Thu, 29 Sep 2022 13:41:03 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.199) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 29 Sep 2022 14:41:01 +0100
Message-ID: <ff8bfd82-d4aa-4263-28c0-9c4788e45da8@samsung.com>
Date:   Thu, 29 Sep 2022 15:41:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] block: use blk_mq_plug() wrapper consistently in
 the block layer
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, <hch@lst.de>
CC:     <gost.dev@samsung.com>, <linux-block@vger.kernel.org>,
        <damien.lemoal@opensource.wdc.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <d9a86bdd-bcba-51e9-16d4-287b333e18ad@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.199]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduznOd2CBabJBj9ucVmsvtvPZvH77Hlm
        i5WrjzJZ7L2l7cDicflsqcfumw1sHjtb77N6fN4kF8ASxWWTkpqTWZZapG+XwJWxcvlvxoIF
        XBWHZv5jb2Ds5Ohi5OSQEDCR+Dh/AmsXIxeHkMAKRonpX48zQThfGCVm7F3IAuF8ZpRY9eQa
        G0zLuVuroFqWM0qce97EBle19MweqP7djBKfV65mBmnhFbCTuP92D1g7i4CqxIJry5gg4oIS
        J2c+YQGxRQUiJdbsPssOYgsLxEmcPXyZFcRmFhCXuPVkPli9iICexLufO4HqOYDi8RLzjumB
        mGwCWhKNnWCdnAK2Ep3zmqA6NSVat/9mh7DlJba/ncMM8YCyxIRb01kg7FqJtcfOsIOcLCFw
        h0Oi7dhcqCIXiTOn57BD2MISr45vgbJlJE5P7oFqrpZ4euM3M0RzC6NE/871bCAHSQhYS/Sd
        yYGocZQ4336CBSLMJ3HjrSDEPXwSk7ZNZ57AqDoLKSBmIXl4FpIXZiF5YQEjyypG8dTS4tz0
        1GKjvNRyveLE3OLSvHS95PzcTYzA1HL63/EvOxiXv/qod4iRiYPxEKMEB7OSCK94gWmyEG9K
        YmVValF+fFFpTmrxIUZpDhYlcV62GVrJQgLpiSWp2ampBalFMFkmDk6pBqa26RHM+ezty/5b
        mhWda9v5TmapN8eL68fidjm9/elqozjrmbKHyl29kNu291/u6mNs36dv/N8gVjk01uqfW4y+
        yfYrq2bPSah8sUK1v/fh52v5NT8yv+tHfjlXnvzz/zMpN8PvvdFp739vFkxZeDHTvnSR/cqW
        ifPnMfgkNVY2/zXwXdR+z5cjyNXpooPkmnjdK/9u9JWkld0MueMkpv58wkVdV4YLp/ccyTM4
        WuOjf3ib7Oyv69+rybdtK5vRaJcRYi2x8tfnqLw2dlnrU1zVdlq/ChztppcvKdgb+mti/4QP
        55avfcC4xIDF85aoTxlL34yjh/30/R81pk5UnbU8+pjDPA+FInGNq/Ib1yuxFGckGmoxFxUn
        AgDBU84rnAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xe7r5C0yTDZ5fV7VYfbefzeL32fPM
        FitXH2Wy2HtL24HF4/LZUo/dNxvYPHa23mf1+LxJLoAlSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j5fLfjAULuCoOzfzH3sDYydHFyMkhIWAi
        ce7WKtYuRi4OIYGljBKXt8xlgkjISHy68pEdwhaW+HOtiw2i6COjxLeNy6A6djNKTG6aBdbB
        K2Ancf/tHjYQm0VAVWLBtWVQcUGJkzOfsIDYogKREg+XNYHFhQXiJM4evswKYjMLiEvcejIf
        LC4ioCfx7udOoHoOoHi8xLxjeiBhIYFPjBJfNgWDhNkEtCQaO8Fu4xSwleic1wQ1RVOidftv
        dghbXmL72znMEPcrS0y4NZ0Fwq6VeHV/N+MERtFZSI6bheSIWUhGzUIyagEjyypGkdTS4tz0
        3GJDveLE3OLSvHS95PzcTYzAeNx27OfmHYzzXn3UO8TIxMF4iFGCg1lJhFe8wDRZiDclsbIq
        tSg/vqg0J7X4EKMpMIQmMkuJJucDE0JeSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZq
        akFqEUwfEwenVAMTz8nneif/xCrFLLAzvazzqPabwOQNe3XPzXY543KtNOb/kvkGz9pMIn7e
        u2x8xVHnfyL/ExnNhRIWj7PKm/4duBrm7Jp+b1pmcv1Pq8fbN9afUylpct25fu6rxzwXUhQ1
        m5NXaMgzdB/yVA36eMZ5l2zWs9e6WXprq5ZedqtfLvu3Iv+O9x3tVcJJV2y8L0TUFQplL9+Q
        dXjy7DTRsBztQ789zvc9KnC2nnptk7Ow5sGsPy8rhZ/vuSvbIfnKoqtGfu1KvtWKmw+5Lzrd
        d/7MzLczdb/MSJtQy3RvnqCaeF5c5tqz/6xdgpMnvy5suv5m1htnc4ZHwvGL8s99ltbfIqTt
        4JQnOD3a1/jK9DO9SizFGYmGWsxFxYkAc2QgvFADAAA=
X-CMS-MailID: 20220929134103eucas1p1ea582c82a23203c7c6c760a4b7f5aa3d
X-Msg-Generator: CA
X-RootMTR: 20220929074749eucas1p206ebab35a37e629ed49924506e325554
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220929074749eucas1p206ebab35a37e629ed49924506e325554
References: <20220929074745.103073-1-p.raghav@samsung.com>
        <CGME20220929074749eucas1p206ebab35a37e629ed49924506e325554@eucas1p2.samsung.com>
        <20220929074745.103073-3-p.raghav@samsung.com>
        <d9a86bdd-bcba-51e9-16d4-287b333e18ad@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>> Either of the changes should not have led to a bug in zoned devices:
>>
>> - blk_execute_rq_nowait:
>>   Only passthrough requests can use this function, and plugging can be
>>   performed on those requests in zoned devices. So no issues directly
>>   accessing the plug.
>>
>> - blk_flush_plug in bio_poll:
>>   As we don't plug the requests that require a zone lock in the first
>>   place, flushing should not have any impact. So no issues directly
>>   accessing the plug.
>>
>> This is just a cleanup patch to use this wrapper to get the plug
>> consistently across the block layer.
> 
> While I did suggest to make this consistent and in principle it's
> the right thing to do, it also irks me to add extra checks to paths
> where we know that it's just extra pointless code. Maybe we can
> just comment these two spots? Basically each of the sections above
> could just go into the appropriate file.
> 
The checks should go away, and the plug could be inlined by the compiler if
we don't have CONFIG_BLK_DEV_ZONED. Otherwise, I do agree with you that it
is a pointless check.

I am fine with either, though I prefer what this patch is doing. So if you
feel strongly against calling the blk_mq_plug function, I can turn this
patch into just adding comments as you suggested.
