Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D08C61DA4
	for <linux-block@archiver.kernel.org>; Wed, 22 Feb 2023 16:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjBVQZN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Feb 2023 11:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjBVQZL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2023 11:25:11 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D4536FE3
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 08:25:09 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230222162507euoutp0233ffc5a82e00cd7e7b2b44c0fbcbde22~GMjNu6FXW1008210082euoutp02I
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 16:25:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230222162507euoutp0233ffc5a82e00cd7e7b2b44c0fbcbde22~GMjNu6FXW1008210082euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677083107;
        bh=OG6ec75jpg33G8FmKOjmPqBGUig+snLRDSHIt17BFhU=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=dPzik8d2FJGabM1vd+7MytooHp0pizr6nG3+LHdP5kPQindjAgU5lhDsx4I5nFbc7
         LrxNu20eDTj8POwU6HWApKddJlV7wB5hedWsJPpstGuKaJjm0LPJVO6xA2QAcnCNFm
         8HuVs4CDwslWk3sj4hZ07xKDMFYE+nL4nyZ/DjhY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230222162507eucas1p1faa13381202c73f420594e17ed74ae1f~GMjNo1Dxh2310623106eucas1p15;
        Wed, 22 Feb 2023 16:25:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 04.F8.61197.3E146F36; Wed, 22
        Feb 2023 16:25:07 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230222162507eucas1p29dbabaa7d5845000f4720e02254756ca~GMjNGKnNO2401024010eucas1p23;
        Wed, 22 Feb 2023 16:25:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230222162507eusmtrp25ff1836847293d2187cd6c8cbbaaf660~GMjNFnHt61136211362eusmtrp2d;
        Wed, 22 Feb 2023 16:25:07 +0000 (GMT)
X-AuditID: cbfec7f5-7dbff7000000ef0d-e7-63f641e3e7fe
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AD.E3.00518.2E146F36; Wed, 22
        Feb 2023 16:25:06 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230222162506eusmtip1cbca1bc0a04c7dab32b28a5d70e297e0~GMjM8UGDq0762907629eusmtip1Q;
        Wed, 22 Feb 2023 16:25:06 +0000 (GMT)
Received: from [192.168.1.19] (106.210.248.119) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 22 Feb 2023 16:25:04 +0000
Message-ID: <299c512b-06d6-cd79-9193-936bcabd2d69@samsung.com>
Date:   Wed, 22 Feb 2023 21:55:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.7.1
Subject: Re: [PATCH] block: shift with PAGE_SHIFT instead of dividing with
 PAGE_SIZE
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>
CC:     <hch@lst.de>, <gost.dev@samsung.com>, <linux-block@vger.kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <4686cf1d-d618-d7b0-48f2-26ab94bf3985@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.119]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduzned3Hjt+SDZ5PVbZYfbefzWLah5/M
        FitXH2Wy2HtL24HF4/IVb4/LZ0s9dt9sYPP4vEkugCWKyyYlNSezLLVI3y6BK2Pt/J9sBb9Y
        Kh6+529g/MncxcjJISFgIjH58zn2LkYuDiGBFYwSry9sZoFwvjBK/Fz9iRnC+cwosetnLxtM
        y7r+O1AtyxkltpzfyA5XdfvedEYIZxejRP/TD0AtHBy8AnYSM256g3SzCKhK7Oy4DzaJV0BQ
        4uTMJywgtqhAlMSpn6+ZQGxhgTCJWa9msIPYzALiEreezAeLiwhYS2zbNpsNIu4u8X/bViaQ
        8WwCWhKNnWDlnEAl57buYoEo0ZRo3f4baoy8xPa3c5hByiUElCU+/qqB+KVW4tSWW0wQ9h0O
        icsfhCFsF4mtR64yQtjCEq+Ob2GHsGUk/u+cD1VfLfH0xm9wAEkItAB9u3M9G8R8a4m+MzkQ
        NY4S0zf/YYII80nceCsIcQ2fxKRt05knMKrOQgqHWUj+nYXkgVlIHljAyLKKUTy1tDg3PbXY
        OC+1XK84Mbe4NC9dLzk/dxMjMKWc/nf86w7GFa8+6h1iZOJgPMQowcGsJML7n/dzshBvSmJl
        VWpRfnxRaU5q8SFGaQ4WJXFebduTyUIC6YklqdmpqQWpRTBZJg5OqQam2rfNggrLXi4+oJbk
        vWDOG4Mtp55ePWEc0Jq77C5XwBprj8Ny2zTUhG5mxqxsntX1Qu0E4/0klt8T9P4xpGgI/pFO
        1qpkNN3wxoDzw8fSs78KHxV5/3k1fVLSqvmyarLFPxe+DKtjmq0fffzxtVssz/0Olc5cenP3
        RLsj009vbH+0yOAj64rNy/OlQqJZJXec4jG/tTQpdElLgaf/AZ9J9av6dqVMyo6e93nv/nkl
        b/8ar7t8rSOhKOV+YZy8xNtPXTYne5Vb2pdEGKofOvBw2623SxqjDRwCHh0/4HhUK73PzL3r
        2IL0wws46n2nhCut/bXBRc7JwPdy5GrpWPPMqRsd7py66i6U/3Z+2p5n/EosxRmJhlrMRcWJ
        ABSZGEWYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xu7qPHL8lGzR/sLZYfbefzWLah5/M
        FitXH2Wy2HtL24HF4/IVb4/LZ0s9dt9sYPP4vEkugCVKz6Yov7QkVSEjv7jEVina0MJIz9DS
        Qs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2Pt/J9sBb9YKh6+529g/MncxcjJISFgIrGu
        /w57FyMXh5DAUkaJtuVNUAkZiU9XPrJD2MISf651sUEUfWSU+Pd1AxOEs4tR4s29W6xdjBwc
        vAJ2EjNueoM0sAioSuzsuM8GYvMKCEqcnPmEBcQWFYiSOL1yHdhQYYEwiVmvZoDZzALiEree
        zGcCsUUErCW2bZvNBhF3l/i/bSvUrn2MErc/vmcE2cUmoCXR2AnWywlUf27rLhaIek2J1u2/
        oWbKS2x/O4cZpFxCQFni468aiF9qJT7/fcY4gVF0FpLrZiG5YhaSSbOQTFrAyLKKUSS1tDg3
        PbfYSK84Mbe4NC9dLzk/dxMjMBa3Hfu5ZQfjylcf9Q4xMnEwHmKU4GBWEuH9z/s5WYg3JbGy
        KrUoP76oNCe1+BCjKTCIJjJLiSbnA5NBXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2
        ampBahFMHxMHp1QDE9/ci5EFZYWfW4w7JkZL7OO5G32X68OZZNs3alMfaAmeULaf2RNY2eat
        U7alQ8adc4LKeZl5LUFzt11Ky5qa5q0u4Muy0FjR5YJYb27MB+dNvPk17il3H/xTY2JnfnQs
        ymvfmlM8Lge4OFzylIy+2rx6qn715LwgyaSo8E52vaOzfYokLnF8m3pafuVpu+yI/3/VHxdM
        uqZza7dsqxLnpnSVmZ9fZz7ztyhSjLj09MKxwP9mc7IY+Cuvtl3SiwhlVVOabmSbHLhion/K
        ZMfomdwHX7K9svf3nnG/uOPGPcb/ps1Lc0WnFchzSt5MrwgJkV67sflf5PIzur9PfCtRkj5n
        ubHJ607rTnfHWCklluKMREMt5qLiRAAiROY9TgMAAA==
X-CMS-MailID: 20230222162507eucas1p29dbabaa7d5845000f4720e02254756ca
X-Msg-Generator: CA
X-RootMTR: 20230222143450eucas1p1a63ff021e0aba16184197ac386c5a3c5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230222143450eucas1p1a63ff021e0aba16184197ac386c5a3c5
References: <CGME20230222143450eucas1p1a63ff021e0aba16184197ac386c5a3c5@eucas1p1.samsung.com>
        <20230222143443.69599-1-p.raghav@samsung.com>
        <4686cf1d-d618-d7b0-48f2-26ab94bf3985@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2023-02-22 20:57, Bart Van Assche wrote:
> On 2/22/23 06:34, Pankaj Raghav wrote:
>> No functional change. Division will be costly, especially in the hot
>> path (page_is_mergeable() and bio_copy_user_iov())
> 
> Although the change looks fine to me, is there any compiler for which this
> patch makes a difference? I would expect that a compiler performs this
> optimization even without this patch.
>

I didn't notice any for x86_64. But I was thinking this also as a way to
maintain consistency across block code where we do a shift with PAGE_SHIFT
instead of dividing with PAGE_SIZE.

> Thanks,
> 
> Bart.
> 
