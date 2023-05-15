Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD22FC7EE23
	for <linux-block@archiver.kernel.org>; Mon, 15 May 2023 14:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbjEOOWz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 May 2023 10:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241699AbjEOOWc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2023 10:22:32 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B261BFD
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 07:22:15 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230515142214euoutp02d6e5ce0facea49c06a0737a19699a007~fVxU2jq3_0268702687euoutp02B
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 14:22:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230515142214euoutp02d6e5ce0facea49c06a0737a19699a007~fVxU2jq3_0268702687euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684160534;
        bh=UDBSxf0+TdD2t4DH3FJIABr9bfnvYLTiKuUBeIUrnlE=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=PyWNzXTAY3MPuaYIc0QcSRLjrqZu7F0sdZwTHX+bBdlsT4BlIMGiXbkOisepaca57
         ZgnKB+0c5tTH+F4wnUp3MwufbcoR0B0C8GJg9PkRN7QpdFIpW9W0G5t8rxFGfNfyyW
         8Wziy6c6cJ4sa8cxcTCot3q/+XhFv5Y0GdS254F4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230515142214eucas1p16e0a4186bf5632aa455696a438acab6d~fVxUuj77U1128411284eucas1p1x;
        Mon, 15 May 2023 14:22:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 50.0F.35386.61042646; Mon, 15
        May 2023 15:22:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230515142213eucas1p21bef52dc62f8fd5f40b8beaa2b86a748~fVxUaBFDc2770527705eucas1p2A;
        Mon, 15 May 2023 14:22:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230515142213eusmtrp2050529238ff5c661a846b326f553f99a~fVxUZhxIT1943419434eusmtrp2w;
        Mon, 15 May 2023 14:22:13 +0000 (GMT)
X-AuditID: cbfec7f4-cc9ff70000028a3a-49-646240168a64
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BA.B6.14344.51042646; Mon, 15
        May 2023 15:22:13 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230515142213eusmtip26a9de7f8930e14934192faeb48f38826~fVxUQuBt51453114531eusmtip2t;
        Mon, 15 May 2023 14:22:13 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 15 May 2023 15:22:12 +0100
Message-ID: <d8b9c4c3-9782-6451-44e9-ef737d53e1b3@samsung.com>
Date:   Mon, 15 May 2023 16:22:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
Subject: Re: [PATCH] brd: use XArray instead of radix-tree to index backing
 pages
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "willy@infradead.org" <willy@infradead.org>
Content-Language: en-US
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <bf2daf76-ebfd-8ca2-0e40-362bcaecfc3f@nvidia.com>
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7piDkkpBt0PWS1W3+1ns3h/8DGr
        xcrVR5ks9t7Stvj9Yw6bA6vH5hVaHpfPlnrsvtnA5tHb/I7N4/MmuQDWKC6blNSczLLUIn27
        BK6MddukC44zVUx5Np+lgfENYxcjJ4eEgInErY6dzF2MXBxCAisYJd6cmALlfGGUOLv5DSuE
        85lRYum/XSwwLdfetjFBJJYzSpy+/5kdrurHiWOMEM5OoJbny5lBWngF7CRuru5jArFZBFQl
        HjxdzggRF5Q4OfMJ2FhRgWiJxfumgNnCAsES91YdAKsXEdCTuHrrBtgGZoGHjBJP7l8FG8os
        IC5x68l8oCIODjYBLYnGTnaQMCfQrsuzV7NDlMhLbH87hxnibEWJSTffs0LYtRKnttwCe0FC
        4AWHxK0v+6ESLhIrXh+ABo2wxKvjW9ghbBmJ/zvnM0HY1RJPb/xmhmhuYZTo37meDeQICQFr
        ib4zOSAms4CmxPpd+hDljhLXN75gh6jgk7jxVhDiND6JSdumM09gVJ2FFBKzkDw2C8kHsxCG
        LmBkWcUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGYak7/O/5lB+PyVx/1DjEycTAeYpTg
        YFYS4W2fGZ8ixJuSWFmVWpQfX1Sak1p8iFGag0VJnFfb9mSykEB6YklqdmpqQWoRTJaJg1Oq
        gUlOWPokn2TV9B2Jh2MXLp59fOWdc+1P9V4+MnM2mh7oeHTp6wcrmF79mTedO1c9b3XuqY16
        xofZl7ccmdjG52M7Tbi70v72WeUQ76UJlc/881+bSdzddPjA1Uxzn3Lh6aEb90vIFSUzewqf
        O7t0stJRewfD0Lhn9T010tcZ+sQtJ5d+Of/zqHBg0M4rSytmrp8pNf9bqdf8B52TTTRXPn6c
        f9i1+/CS2Z46y36u/JhwMe/ImTOy0XPvrDTbKdhtd3nnvs5rhw9IzRe6IzNhztL3V5rYF2rO
        +MbzNVRx203rl6oTUlIYpWKrYvc66W+Jntejsyfw+cEFTydcsg18ejTLflJRS9uEN9umFmzd
        PPXOEyWW4oxEQy3mouJEAIqFNA+kAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xe7qiDkkpBoeb9SxW3+1ns3h/8DGr
        xcrVR5ks9t7Stvj9Yw6bA6vH5hVaHpfPlnrsvtnA5tHb/I7N4/MmuQDWKD2bovzSklSFjPzi
        ElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MddukC44zVUx5Np+lgfEN
        YxcjJ4eEgInEtbdtTF2MXBxCAksZJTbemsMMkZCR2PjlKiuELSzx51oXG4gtJPCRUaJjmylE
        w05GifU7VoE18ArYSdxc3ccEYrMIqEo8eLqcESIuKHFy5hMWEFtUIFrixvJvYDXCAsES91Yd
        ALNFBPQkrt66wQ4ylFngIaPEk/tXmSE2HGKUmDP9HVgVs4C4xK0n84FsDg42AS2Jxk52kDAn
        0OLLs1ezQ5RoSrRu/w1ly0tsfwvzjaLEpJvvob6plfj89xnjBEbRWUjum4Vkwywko2YhGbWA
        kWUVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYIxuO/Zzyw7Gla8+6h1iZOJgBDqdg1lJhLd9
        ZnyKEG9KYmVValF+fFFpTmrxIUZTYCBNZJYSTc4HJom8knhDMwNTQxMzSwNTSzNjJXFez4KO
        RCGB9MSS1OzU1ILUIpg+Jg5OqQYmebMnRvdleye35ha+aPh7Y/VLqyVNQtJLuI/J5GYd2vXR
        yv8t8xH3vTP23Gw/ljujNV/ww1tW1iufpyzO+NhzLOObWNTpY7ev6Lz5+PKg6ML27U0HN6dv
        4tsSUrBS7MXjjM+NF9517J8QKpGuEnWs9AEP+2WWtA33o3rs9m5XL5ytrj+1zUT6ZKrFslna
        ZdM31W5tL2xfcnZeyjv7T4U8m1nEn7vpNpkbVV694prR8XApcxTfKZlnN96bv5vU/EbsSLTc
        0hO96jpGfqJJ0zItY8J3bOrZs/ZN7vva0osZAqkX/fq4t+2o2SZyTztkkU+5hOTC9yXSK6at
        X9r6vtaW+Ztu8Cu56xr939uEsv58VmIpzkg01GIuKk4EADwk+fBaAwAA
X-CMS-MailID: 20230515142213eucas1p21bef52dc62f8fd5f40b8beaa2b86a748
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230511121547eucas1p17acca480b5e1d0e04c6595b70c1c92a1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230511121547eucas1p17acca480b5e1d0e04c6595b70c1c92a1
References: <CGME20230511121547eucas1p17acca480b5e1d0e04c6595b70c1c92a1@eucas1p1.samsung.com>
        <20230511121544.111648-1-p.raghav@samsung.com>
        <bf2daf76-ebfd-8ca2-0e40-362bcaecfc3f@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

> I've few concerns, can you please share the fio jobs that
> have used to gather this data ? I want to test it on my
> setup in order to provide tested-by tag.
> 

Did you manage to test it in your setup by any chance?

> also, please wait until I finish my testing to apply this
> patch ..
> 
> -ck
> 
> 
