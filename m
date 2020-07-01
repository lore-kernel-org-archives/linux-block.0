Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85EFC433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 14:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90CAC20760
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 14:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YBuXijxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgGAO61 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:58:27 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33820 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgGAO6Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 10:58:25 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200701145823euoutp01e889abd73ce2b2c6d78b67c80af93b0d~dqNuH3yfA0116001160euoutp019
        for <linux-block@vger.kernel.org>; Wed,  1 Jul 2020 14:58:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200701145823euoutp01e889abd73ce2b2c6d78b67c80af93b0d~dqNuH3yfA0116001160euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593615504;
        bh=EzBxy93blojTZ/Tecc1xr1H46UE3tiyDiyRN4ArmWZM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YBuXijxy3ZsdraTRkmqufQcQ0afQ1wcZZmNyzak94QMPRJQ5LJbpQ/nEeA2FRs+VT
         +1IIzKRLQgRuDvhoZq759Gpgzn8rmugxqjT9BolJMmVEaMaA1/PoNcs9/bIEnO46Z5
         as0jqDnrsO44zxdwwHbEthNa0kxz4S5LbkGx07Z8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200701145823eucas1p11a33b984472a9ebd6ddf85c6645757a1~dqNt5sWdf0931109311eucas1p19;
        Wed,  1 Jul 2020 14:58:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3D.0C.05997.F84ACFE5; Wed,  1
        Jul 2020 15:58:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200701145822eucas1p27cdc4fb14260593360eea7dec1294e49~dqNtGlfdQ1525515255eucas1p2B;
        Wed,  1 Jul 2020 14:58:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200701145822eusmtrp1142ab51d973227bb9b2cd19f4ef2422f~dqNtF6ny50173101731eusmtrp1P;
        Wed,  1 Jul 2020 14:58:22 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-cf-5efca48fddcd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 79.56.06017.E84ACFE5; Wed,  1
        Jul 2020 15:58:22 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200701145822eusmtip25afdd82ba5e563a3403c8f01af9d36d1~dqNst1_kY0862608626eusmtip2e;
        Wed,  1 Jul 2020 14:58:22 +0000 (GMT)
Subject: Re: [PATCH] blk-mq: put driver tag when this request is completed
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <cd3761d3-6bf8-33d5-29c7-58beaa4aa965@samsung.com>
Date:   Wed, 1 Jul 2020 16:58:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2fcd389f-b341-7cd1-692b-8c9d1918198a@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djP87r9S/7EGXRs0rJYfbefzWLjjPWs
        FitXH2Wy2HtL2+LQ5GYmB1aPy2dLPXbfbGDzeL/vKptH35ZVjB6fN8kFsEZx2aSk5mSWpRbp
        2yVwZWzasJul4LJAxa3VcxkbGE/ydjFyckgImEicb7vH2MXIxSEksIJRYuPne2wQzhdGiXV7
        lrBDOJ8ZJeauPcQC07L14nsmiMRyRol7x5uhnPeMEpd2HGYFqRIW8JJYdOgHWAebgKFE19su
        NhBbREBJ4u7d1WBjmQWmMkp09m1kAknwCthJrH21FKyIRUBFomHmQ3YQW1QgVqJv6QI2iBpB
        iZMzn4AN5RSwl1j2/TtYnFlAXmL72znMELa4xK0n88EukhBYxC4x59MDqLtdJM5MaWCCsIUl
        Xh3fwg5hy0icntzDAtHQzCjx8Nxadginh1HictMMRogqa4k7534BreMAWqEpsX6XPkTYUaLp
        6zFGkLCEAJ/EjbeCEEfwSUzaNp0ZIswr0dEmBFGtJjHr+Dq4tQcvXGKewKg0C8lrs5C8MwvJ
        O7MQ9i5gZFnFKJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kRmHBO/zv+ZQfjrj9JhxgFOBiV
        eHgzKv7ECbEmlhVX5h5ilOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQozQHi5I4r/Gil7FC
        AumJJanZqakFqUUwWSYOTqkGxm2JlzsKZnPH/DV8kJTsqji39k5W5A6GhxPvsAY9uFvf6T5j
        ieoq+SXhH12myf7R3x4YHV4S4fWif/kSnpXim7WPpDfw79kcbX6wvd5sMqfgDOanSg7HdlT8
        YHTNmXG8vFvB6O60mZMM/vUfrP9UdFHH5ml5hdrG8oObc1vcK11WvJrQpvX2ihJLcUaioRZz
        UXEiADg/ZkQ0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xe7p9S/7EGfQ8MrBYfbefzWLjjPWs
        FitXH2Wy2HtL2+LQ5GYmB1aPy2dLPXbfbGDzeL/vKptH35ZVjB6fN8kFsEbp2RTll5akKmTk
        F5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZWzasJul4LJAxa3Vcxkb
        GE/ydjFyckgImEhsvfieqYuRi0NIYCmjxKffM5kgEjISJ6c1sELYwhJ/rnWxQRS9ZZRoXjgT
        LCEs4CWx6NAPFhCbTcBQoustSBEnh4iAksTdu6vZQRqYBaYzSuw48Y8VonsWk8TvlbPAVvAK
        2EmsfbUUrINFQEWiYeZDdhBbVCBW4tu9LWwQNYISJ2c+AdvAKWAvsez7d7A4s4CZxLzND5kh
        bHmJ7W/nQNniEreezGeawCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGRXnFibnFpXrpe
        cn7uJkZghG079nPLDsaud8GHGAU4GJV4eDMq/sQJsSaWFVfmHmKU4GBWEuF1Ons6Tog3JbGy
        KrUoP76oNCe1+BCjKdBzE5mlRJPzgdGfVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7
        NbUgtQimj4mDU6qBkeUT17Tp6rF71JSuO5/w8zPRar+Q3+67b4pwhNkquTLdQxLcDg51/PGT
        Ow5Oy7TaL7fsx+vZb+YcaV9+5HXu+sUxe2pUtryLrmj4yTVPMYyl8aXolls3pqqsNz7rVDQ5
        zTU8iYFN921Opshb7+Mr92uvlYuz/Xbu/3TXc8KLSvO3R/CFfZp8QYmlOCPRUIu5qDgRAEcH
        ph3GAgAA
X-CMS-MailID: 20200701145822eucas1p27cdc4fb14260593360eea7dec1294e49
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200701130104eucas1p1f8dcce58bf704b726aee1e89980fe19e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200701130104eucas1p1f8dcce58bf704b726aee1e89980fe19e
References: <20200629094759.2002708-1-ming.lei@redhat.com>
        <CGME20200701130104eucas1p1f8dcce58bf704b726aee1e89980fe19e@eucas1p1.samsung.com>
        <57fb09b1-54ba-f3aa-f82c-d709b0e6b281@samsung.com>
        <20200701134512.GA2443512@T590>
        <2fcd389f-b341-7cd1-692b-8c9d1918198a@samsung.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 01.07.2020 16:16, Marek Szyprowski wrote:
> On 01.07.2020 15:45, Ming Lei wrote:
>> On Wed, Jul 01, 2020 at 03:01:03PM +0200, Marek Szyprowski wrote:
>>> On 29.06.2020 11:47, Ming Lei wrote:
>>>> It is natural to release driver tag when this request is completed by
>>>> LLD or device since its purpose is for LLD use.
>>>>
>>>> One big benefit is that the released tag can be re-used quicker since
>>>> bio_endio() may take too long.
>>>>
>>>> Meantime we don't need to release driver tag for flush request.
>>>>
>>>> Cc: Christoph Hellwig <hch@lst.de>
>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> This patch landed recently in linux-next as commit 36a3df5a4574. Sadly
>>> it causes a regression on one of my test systems (ARM 32bit, Samsung
>>> Exynos5422 SoC based Odroid XU3 board with eMMC). The system boots fine
>>> and then after a few seconds every executed command hangs. No
>>> panic/ops/any other message. I will try to provide more information 
>>> asap
>>> I find something to share. Simple reverting it in linux-next is not
>>> possible due to dependencies.
>> What is the exact eMMC's driver code(include the host driver)?
>
> dwmmc-exynos (drivers/mmc/host/dw_mmc-exynos.c)
>
>> The usual way for handling completion is that host driver notifies block
>> layer via blk_mq_complete_request() after the LLD specific handling for
>> this request is done.
>>
>> However, there might be driver which may use rq->tag in its rq 
>> completion
>> handler. I will see if the special case can be dealt with once you share
>> the driver info.

One more information: revering 37f4a24c2469a10a4c16c641671bd766e276cf9f, 
723bf178f158abd1ce6069cb049581b3cb003aab and 
36a3df5a4574d5ddf59804fcd0c4e9654c514d9a on top of today's linux-next 
fixes the issues on the tested system, what shows that the bisect is 
indeed correct and there is no other hidden issue.

The most surprising thing to me is that other Exynos5422-based boards I 
have, which also use same eMMC controller, work fine...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

