Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F18FC433F5
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 14:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiCIODe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Mar 2022 09:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiCIODc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Mar 2022 09:03:32 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B5665A1
        for <linux-block@vger.kernel.org>; Wed,  9 Mar 2022 06:02:30 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220309140228euoutp02a2b6f3428964b2e40dbdc24ac1f0fb5e~au0v2Uuum1628716287euoutp02A
        for <linux-block@vger.kernel.org>; Wed,  9 Mar 2022 14:02:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220309140228euoutp02a2b6f3428964b2e40dbdc24ac1f0fb5e~au0v2Uuum1628716287euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646834548;
        bh=OYo7hf+j7VbA2i4lDyn2aZ5haP/s67p3rTw5NypDRC8=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=HOWLN6RYeDRftWnTIscl25s/Y7mCQD2ssKMIsoKxBwUXZU0n6LQFLidewzYhnAYTk
         cxGokNbTf7T1cKttThg+NTyrEXhQOxDPL4Q6tqW3XFhuw5ppDkviTK2PCHdf0HjQHA
         vWxhNp2Ba5YdeYAhQsKfGvCcH4clkY22Ow4UL4DI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220309140228eucas1p22f736b1a9b1b0cde9af9e10c21756789~au0vffTFx2329923299eucas1p2g;
        Wed,  9 Mar 2022 14:02:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E4.6C.09887.473B8226; Wed,  9
        Mar 2022 14:02:28 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220309140227eucas1p2d7733afa607ba7af585e0171a9fa5383~au0u9Y6NS2604726047eucas1p2H;
        Wed,  9 Mar 2022 14:02:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220309140227eusmtrp10eab4cdbbabaf54c7b622be71b3a2f03~au0u739Cf0233602336eusmtrp1M;
        Wed,  9 Mar 2022 14:02:27 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-d8-6228b3746895
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7A.2F.09404.373B8226; Wed,  9
        Mar 2022 14:02:27 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220309140227eusmtip1029aa127ba9cdbc9c49973a21aa12d4c~au0uv50W82915329153eusmtip1x;
        Wed,  9 Mar 2022 14:02:27 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.212) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 9 Mar 2022 14:02:23 +0000
Message-ID: <ed8f2a08-65ec-52fe-227d-db4d2b64cc60@samsung.com>
Date:   Wed, 9 Mar 2022 15:02:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.5.0
Subject: Re: [PATCH 2/6] block: Add npo2_zone_setup callback to block device
 fops
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        <jiangbo.365@bytedance.com>
CC:     Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <f08307fe-75f0-0c13-04b3-1b5074d32ec8@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.212]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djP87olmzWSDLZ1cVmsvtvPZvH77Hlm
        i5WrjzJZ9Bz4wGJx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5MeMposebmUxaLda/fszjw
        ePw7sYbNY+esu+we5+9tZPG4fLbUY9OqTjaPzUvqPXbfbADKtd5n9fi8Sc6j/UA3UwBXFJdN
        SmpOZllqkb5dAlfG5ANOBTO5Kl7PuMjUwNjP0cXIySEhYCJx83EXcxcjF4eQwApGiY8XnrNA
        OF8YJdZ+P8AO4XxmlFhyZS4LTMvmD7dYIRLLGSUWXNnPBlfVvv8HI0iVkMAuRok3BzJAbF4B
        O4k1O3cBFXFwsAioSNxs54cIC0qcnPkEbKioQITEyyN/mUBsYYFgicv7Z4DFmQXEJW49mc8E
        Ml9E4ByzxMWOyawQiYmMEp27zEFmsgloSTR2soOEOQXcJD7t+8MGUaIp0br9NzuELS+x/e0c
        ZpByCQFlidfrbSB+qZVYe+wM2JMSAoc5JQ6+WcIKkXCR+PHyKDuELSzx6vgWKFtG4vTkHhaI
        hn5Giaktf5ggnBmMEj2HNzNBbLCW6DuTA2E6Styb5gRh8knceCsIcQ6fxKRt05knMKrOQgqJ
        WUg+noXkg1lIPljAyLKKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMMGd/nf8yw7G5a8+
        6h1iZOJgPMQowcGsJMLbFKqRJMSbklhZlVqUH19UmpNafIhRmoNFSZw3OXNDopBAemJJanZq
        akFqEUyWiYNTqoFpUpfab0kjEx21t0nWYu0Ho9OSs1ZNyg9bYyevKl9iddbC7GJp2P5VfNEs
        3qb7356UY5AIVrDKaOnMXf55u/Le6b4LPt69eMHnQujxLT8V34pcv7LK4HnR8tUGhyMfzBe9
        ekBw+tb5ZxRWro46UxPz7+wng4MrFL9ybraJ9T2wfdda3q/FDGeVpJIvX1y+Y1nu6a/5gdeP
        qOi+FIrhjPuwa4vZYp3WrgDR49bP5EzfWYQVeK0s3vbgm7l7+3KWi08i/9/n3bXs9bWXgT9L
        Du/a++0uB+fkWY+MjV7MunumUbuq5GD2b+smydtWbq0itT5ck591X3ujm2x2vUt7yoMKz32y
        xzc42H7kXHhAs7ygQomlOCPRUIu5qDgRAFuUUFffAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42I5/e/4Xd3izRpJBlvXqVisvtvPZvH77Hlm
        i5WrjzJZ9Bz4wGJx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5MeMposebmUxaLda/fszjw
        ePw7sYbNY+esu+we5+9tZPG4fLbUY9OqTjaPzUvqPXbfbADKtd5n9fi8Sc6j/UA3UwBXlJ5N
        UX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G5ANOBTO5
        Kl7PuMjUwNjP0cXIySEhYCKx+cMt1i5GLg4hgaWMElvvz2KHSMhIfLryEcoWlvhzrYsNougj
        o8SK6X3sEM4uRon/rw8ygVTxCthJrNm5C6iKg4NFQEXiZjs/RFhQ4uTMJywgtqhAhETbsinM
        ILawQLDE5f0zwOLMAuISt57MZwKZKSJwjlniYsdksJOYBfoZJZZM+QF1329GiWV928A2sAlo
        STR2gp3HKeAm8WnfHzaISZoSrdt/s0PY8hLb385hBimXEFCWeL3eBuKbWolX93czTmAUnYXk
        vllI7piFZNIsJJMWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECEwN24793LKDceWrj3qH
        GJk4GA8xSnAwK4nwNoVqJAnxpiRWVqUW5ccXleakFh9iNAWG0URmKdHkfGByyiuJNzQzMDU0
        MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYFq0xz4haMYK6S0HD2x8JNH5WvqI
        tOe39WcN9lVr3Zo6ZdMNced5yZqOLusk55toz1r9XvPGGZXoVNMCe8GC3sibko0u4faTDt1+
        Fql4oMhmzZo+p8+v5QyUt5wJ4cpwCew8M9H/gTXfBssfjlflttR+99WTFekMZC1jcqpna3WV
        KuRb8+/iisv98882eUnJXnoR7pdxvODtxPWvZt2x9QpQanzAzqjd3r3yKH/pJm2+5+8Cqs+v
        spjJqpF7dnqMWpbKkojjWWttz0ebu9m1dy5WW2PYedXXYcUNlaZnojNZPbPdymd8OsI8lytP
        +KDGjaQTfrZZs79O1wpctu3B6+gZCneL2rcesXFnktxuocRSnJFoqMVcVJwIAKPxTQeWAwAA
X-CMS-MailID: 20220309140227eucas1p2d7733afa607ba7af585e0171a9fa5383
X-Msg-Generator: CA
X-RootMTR: 20220308165428eucas1p14ea0a38eef47055c4fa41d695c5a249d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220308165428eucas1p14ea0a38eef47055c4fa41d695c5a249d
References: <20220308165349.231320-1-p.raghav@samsung.com>
        <CGME20220308165428eucas1p14ea0a38eef47055c4fa41d695c5a249d@eucas1p1.samsung.com>
        <20220308165349.231320-3-p.raghav@samsung.com>
        <f08307fe-75f0-0c13-04b3-1b5074d32ec8@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022-03-09 04:46, Damien Le Moal wrote:
> On 3/9/22 01:53, Pankaj Raghav wrote:
>> A new fops is added to block device which will be used to setup the
>> necessary hooks when a non-power_of_2 zone size is detected in a zoned
>> device.
>>
>> This fops will be called as a part of blk_revalidate_disk_zones.
> 
> And what does this new hook do ? You are actually not explaining it, nor
> why it should be called from blk_revalidate_disk_zones().
I should have elaborated the "why" and "how" a bit more in my commit log.
I will fix it in my next revision.

The main idea why it was added and called as a part of blk_revalidate_disk_zones
is this: As the block layer expects the zone sizes to be po2, this fops can be used
by the driver to configure a npo2 device to be presented as a po2 device before the parameters
such as zone bitmaps and chunk sectors are set.

> Also, blk_revalidate_zone_cb() uses bit shift but this patch, nor the
> previous one fix that.
> 
The answer I gave to blkdev_nr_zones question for patch 1/6 applies here as well.
The zone sizes used by blk_revalidate_zone_cb will be the emulated po2 zone size
and not the actual device zone size which is npo2. So the math currently used in
blk_revalidate_zone_cb is still applicable.

-- 
Regards,
Pankaj
