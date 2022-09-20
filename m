Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156F6C54EE9
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 08:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiITII5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 04:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiITIIO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 04:08:14 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB52ADFD5
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 01:04:48 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220920080444euoutp012f09e9a22178aa02ca67511b793132a7~WgvEesxw30043000430euoutp01G
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 08:04:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220920080444euoutp012f09e9a22178aa02ca67511b793132a7~WgvEesxw30043000430euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663661084;
        bh=1rmFZSXUP4sgzoCV9I5l4Ny3ZLAwA04H6tTr9N6nWNc=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=Nbt7nEnWDHXbUvnQtOxKwzdbZjLjswj0yhoz+KViMDO5ZNTHJ9eoAfWf6JbRUgs+e
         pw//hzt+Y3/B60pMIpzvHAhrOZtkjt9r/Nk9XYtGIfBIBdrAFLgc0ywrhPBO1gpxL0
         +QsQwvS2rQIYcShM4+prePjqISP5PvxKiIr598kU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220920080444eucas1p25317faa8e9b75ecbbd7a3cf35929cc56~WgvEH32uA0180601806eucas1p2n;
        Tue, 20 Sep 2022 08:04:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BA.1D.29727.C1479236; Tue, 20
        Sep 2022 09:04:44 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220920080443eucas1p1a3158d6d5ecc50020ea03b136fb7a223~WgvDnwWMi2661126611eucas1p1K;
        Tue, 20 Sep 2022 08:04:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220920080443eusmtrp1ce8557f009132bf8ad9259cbf316be85~WgvDm6gjN2431124311eusmtrp1I;
        Tue, 20 Sep 2022 08:04:43 +0000 (GMT)
X-AuditID: cbfec7f2-21dff7000001741f-3b-6329741c8a7b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 25.85.10862.B1479236; Tue, 20
        Sep 2022 09:04:43 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220920080443eusmtip1e60e293ab140ca03fb187567116af4ab~WgvDXtihZ3107831078eusmtip1d;
        Tue, 20 Sep 2022 08:04:43 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.192) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 20 Sep 2022 09:04:41 +0100
Message-ID: <d1be50b6-f204-cdd3-5539-578b4978aee4@samsung.com>
Date:   Tue, 20 Sep 2022 10:04:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] virtio-blk: add support for zoned block devices
Content-Language: en-US
To:     Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>
CC:     "faithilikerun@gmail.com" <faithilikerun@gmail.com>,
        "hare@suse.de" <hare@suse.de>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "k.jensen@samsung.com" <k.jensen@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "stefanha@gmail.com" <stefanha@gmail.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <79186306eecace92e779dee7b2d4a86a38b5dca4.camel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.192]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djPc7oyJZrJBm/nMVusvtvPZvH77Hlm
        i7Xt3WwW/2Y3sFnsWTSJyWLvLW2LNTefsljcnD6VyeL9wi52B06PnbPusntcPlvq8edusMfO
        1vusHptPV3t83iTn0X6gmymAPYrLJiU1J7MstUjfLoErY9Hlw6wF3zgqNrzdwdTA2MHexcjJ
        ISFgInF+xXemLkYuDiGBFYwSvVN+MUM4Xxgltu5oZYFwPjNKTNj2k7WLkQOs5eA6DYj4ckaJ
        vcfmscIVtfZPZ4NwdgNl9n5hBFnCK2AnMWHpOTCbRUBVYunJFSwQcUGJkzOfgNmiApESa3af
        BTtKWMBD4uyFfawgNrOAuMStJ/OZQGwRgaWMErMeW4MsYBaYxixxd8MbJpCT2AS0JBo7wXo5
        BVwlGnuWs0H0akq0bv/NDmHLS2x/O4cZ4mlliZk3p0LZtRJrj51hB5kpITCbU6K7ZykLRMJF
        4vK5y2wQtrDEq+NboCEmI3F6cg9UTbXE0xu/mSGaWxgl+neuZ4OEkbVE35kciBpHicZJp6BB
        xydx460gxD18EpO2TWeewKg6CykoZiF5eRaSF2YheWEBI8sqRvHU0uLc9NRiw7zUcr3ixNzi
        0rx0veT83E2MwER1+t/xTzsY5776qHeIkYmD8RCjBAezkghvi79mshBvSmJlVWpRfnxRaU5q
        8SFGaQ4WJXHe5MwNiUIC6YklqdmpqQWpRTBZJg5OqQYmnXnVBZt8LWsWPTZ5N+cpk86sbcmz
        a8+uruVT8N/6/L7B/nPf/ZQavxz9FHsrbpvKen+TqQfTdixY6PinZ63jhgvnqtvvlHcXJqSf
        VuOJYb+qGxNsuXrP2Qs/LeesbXA337PfWfVgQUZtSQvDlph3e4IsHVZr3N2k1xh821N2zvlO
        ASvZXyvP7U3gZt/dE3KP+6BAy1O/guruiX/rsj9Pl/z4i/vCvf1KcjNTaj+/nV5tYRDflzJl
        3pUnz3NKzOx/bwr1290uGmJZ+jhL8M+mspqnMhu5jZujn/mv8nx3XWtv5en+e0f2OcvPubnt
        9PyDjQ/qy2ZYpj5deeHjstnpu/9I/uebeia0U7Jrh1UfrxJLcUaioRZzUXEiAIp4UwvDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xu7rSJZrJBmffSVisvtvPZvH77Hlm
        i7Xt3WwW/2Y3sFnsWTSJyWLvLW2LNTefsljcnD6VyeL9wi52B06PnbPusntcPlvq8edusMfO
        1vusHptPV3t83iTn0X6gmymAPUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshU
        Sd/OJiU1J7MstUjfLkEvY9Hlw6wF3zgqNrzdwdTA2MHexcjBISFgInFwnUYXIxeHkMBSRokD
        B9+xdjFyAsVlJD5d+cgOYQtL/LnWxQZR9JFR4tWtZawQzm5GifurJ4FV8QrYSUxYeo4RxGYR
        UJVYenIFC0RcUOLkzCdgtqhApMTDZU1MILawgIfE2Qv7wLYxC4hL3HoyHywuAnLGrMfWIAuY
        BaYxS9zd8IYJYtsLJonde9czgdzNJqAl0dgJtphTwFWisWc5G8QgTYnW7b/ZIWx5ie1v5zBD
        vKAsMfPmVCi7VuLV/d2MExhFZyG5bxaSO2YhGTULyagFjCyrGEVSS4tz03OLjfSKE3OLS/PS
        9ZLzczcxAuN727GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRHeFn/NZCHelMTKqtSi/Pii0pzU4kOM
        psBAmsgsJZqcD0wweSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFIN
        TE55KSurLM4/eHXh44umk2dWmWXftPddNakhbNUq74urdM0L1rdU7ixVCFZXnjNZzqRdy/KP
        dXTMrpddAoJK+2I+tH1efmSja+mWWxPSeKaUf+ZWOKC3uU9ada3j3ZSAQlUL3jmG/xtljE/e
        m+t1/NL0JeWcnPvEo+acnx7xM6p/oso6Se3/K/6dmiZjKfJ9c/Sk/rMvg75LF5ol3bV6+/nt
        icC1H7czq3ssFylxi1w+z7AmPSan+H5tJsON5zniO+x1Y+pTD9mJ7d5dMudv11mu2Ty1j/nO
        nr91dN6mHomLnPMm3Vzj0Gs/b9se8z5WFtZTyy3M35013lDrd+eH5padAU8ZJn0OfGPFseL3
        9R1KLMUZiYZazEXFiQBqhnAleAMAAA==
X-CMS-MailID: 20220920080443eucas1p1a3158d6d5ecc50020ea03b136fb7a223
X-Msg-Generator: CA
X-RootMTR: 20220920015128eucas1p2c8a017065fd945e3aa3ba9ab6b039eb0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220920015128eucas1p2c8a017065fd945e3aa3ba9ab6b039eb0
References: <20220919022921.946344-1-dmitry.fomichev@wdc.com>
        <20220919022921.946344-4-dmitry.fomichev@wdc.com>
        <20220919133853.2xsamyvr66qeogko@quentin>
        <44dfb47f-a59f-b236-03bf-5d25d7f206b5@opensource.wdc.com>
        <CGME20220920015128eucas1p2c8a017065fd945e3aa3ba9ab6b039eb0@eucas1p2.samsung.com>
        <79186306eecace92e779dee7b2d4a86a38b5dca4.camel@wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>>> There is a parallel work going on to support non-po2 zone sizes in Linux
>>> block layer and drivers[1]. I don't see any reason why we shouldn't make
>>> the calculations generic here instead of putting the constraint on zone
>>> sectors to be po2 as the virtio spec also supports it.
>>
>> That series is not upstream, so implementing against would not be the
>> correct approach, especially given that this would also impact qemu code.
>>
> 
> I am aware about the effort to support non-^2 zone sizes in the kernel and this
> activity actually made me drop the ^2 zone size requirement from the virtio-zbd
> specification. I think that the best way to add non-^2 zone size support to this
> driver could be a follow up patch to this series. This way, we won't rely on the
> code that is not yet merged upstream.
> 

It is actually not relying on the code that is not merged upstream but
rather future proofing the code with generic calculations that will not
have any performance impact. But if you don't want to pick up these changes
now, I can do it in the future as well as the changes are trivial.

--
Pankaj
