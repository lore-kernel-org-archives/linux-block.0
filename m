Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC1AC433F5
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 13:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiI2NsT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 09:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbiI2NsS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 09:48:18 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E0414C9D6
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 06:48:16 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220929134815euoutp012ee9390c486f3d23be326799b48f0e52~ZWOkNOe7G3001030010euoutp01-
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 13:48:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220929134815euoutp012ee9390c486f3d23be326799b48f0e52~ZWOkNOe7G3001030010euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664459295;
        bh=APzY2N7M0YbD3zCWBF4MIayviHGlXECP9I/t4XA+zcU=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=g3wQcZ1+Xxsyb8w0Fv06+SWnFAAaFA26Vlr6m/ssKudlt2Kez+rgsZ6T6aQmN8Cah
         uHOZbbB7XW5HkJlxw5zxvHCn2f+mzb9hRRUALN6ItwxT0crmpZwsD+r4pO/sJZjK4k
         uC9OIVqkD7cs593upRfushTNPhmDxkUxNAEaZ9Bs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220929134814eucas1p26ae9c536caee98348f07d49b760f12d5~ZWOj46DuO2978029780eucas1p2k;
        Thu, 29 Sep 2022 13:48:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 54.EA.29727.E12A5336; Thu, 29
        Sep 2022 14:48:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220929134814eucas1p2d30fe313259bcd04f75c289ff8360165~ZWOjcbkUB0974909749eucas1p27;
        Thu, 29 Sep 2022 13:48:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220929134814eusmtrp2a65b1e5db53761eb5922dc7856fa47d3~ZWOjbuA622442124421eusmtrp2M;
        Thu, 29 Sep 2022 13:48:14 +0000 (GMT)
X-AuditID: cbfec7f2-205ff7000001741f-22-6335a21ed94b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 22.55.10862.E12A5336; Thu, 29
        Sep 2022 14:48:14 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220929134814eusmtip287305b358893964f064ff6b7095c907c~ZWOjSYu2i0499704997eusmtip2j;
        Thu, 29 Sep 2022 13:48:14 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.199) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 29 Sep 2022 14:48:12 +0100
Message-ID: <59aa1b6c-2cbd-b342-b17d-a6965ed6239c@samsung.com>
Date:   Thu, 29 Sep 2022 15:48:11 +0200
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
In-Reply-To: <f6e54907-1035-2b2c-6387-ed178be05ccb@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.199]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduzneV25RabJBiv+GlmsvtvPZvH77Hlm
        i5WrjzJZ7L2l7cDicflsqcfumw1sHjtb77N6fN4kF8ASxWWTkpqTWZZapG+XwJXxdOYRtoKj
        AhXb3z5lamDs5e1i5OSQEDCR+Dx9OnMXIxeHkMAKRon2rv2MEM4XRonuu7uhnM+MEju23mPp
        YuQAa5n2lQMivpxR4teMPUxwRfMvXmOBcHYzSjzcdpkRZAmvgJ3Eh0sf2UG6WQRUJe7eqocI
        C0qcnPmEBcQWFYiUWLP7LDuILSwQJ3H28GVWEJtZQFzi1pP5TCC2iICexLufO8GOYBaIl5h3
        TA/EZBPQkmjsBOvkFLCVeN0PsZRZQFOidftvdghbXmL72znMEB8rS0y4NZ0Fwq6VWHvsDDvI
        xRICTzgk7m1cxQ7xo4vEsRu6EDXCEq+Ob2GHsGUk/u+EuEZCoFri6Y3fzBC9LYwS/TvXs0H0
        Wkv0ncmBqHGUON9+AhpsfBI33gpCnMMnMWnbdOYJjKqzkMJhFpJ/ZyH5YBaSDxYwsqxiFE8t
        Lc5NTy02zEst1ytOzC0uzUvXS87P3cQITCqn/x3/tINx7quPeocYmTgYDzFKcDArifCKF5gm
        C/GmJFZWpRblxxeV5qQWH2KU5mBREudlm6GVLCSQnliSmp2aWpBaBJNl4uCUamBSNEi+nBN8
        60S+k3VjWqrwtrYT+Ta7X2oKvL5ecuT464utF9a3Rhc+Y+QoKAo4unjx/W+JwaVKi7eufrQl
        qc3p7gO9Ojf+Bdmbc/8vf3LVWf2CtfYN73Jh268/Tq2bwpl1ZkKC9gYRNoV/Yfcj1mXnzd8c
        75yZGNUQ5hh9Vi1Bomm++vLi3reTSt7vMp3bPvHRDc2iZbGL75uXnfrjJrSomDEtgHmC4aO+
        rVaqG+dvO5F/6OW9M90mofH1e3bK+K5KTzy3JO+5E9dLrsLSx+sqZ9xn4VN+n+vIe76rrGQB
        Z9Fh8f+nw+x6i3cv8o1+XNDhVCmtoXn5aJb2860NjM9UEpd5i1/0yfC7ukJ0vrQSS3FGoqEW
        c1FxIgB3bgESmQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xe7pyi0yTDY5sEbdYfbefzeL32fPM
        FitXH2Wy2HtL24HF4/LZUo/dNxvYPHa23mf1+LxJLoAlSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j6cwjbAVHBSq2v33K1MDYy9vFyMEhIWAi
        Me0rRxcjF4eQwFJGiVUzd7F1MXICxWUkPl35yA5hC0v8udbFBlH0kVGir+sjE4Szm1HiwNlV
        zCBVvAJ2Eh8ugXRwcLAIqErcvVUPERaUODnzCQuILSoQKfFwWRMTiC0sECdx9vBlVhCbWUBc
        4taT+WBxEQE9iXc/d7KAjGEWiJeYd0wPYtUtJonn8++ygcTZBLQkGjvBbuMUsJV43X+ZEWKM
        pkTr9t/sELa8xPa3c5gh7leWmHBrOguEXSvx6v5uxgmMorOQXDcLyRWzkIyahWTUAkaWVYwi
        qaXFuem5xUZ6xYm5xaV56XrJ+bmbGIHRuO3Yzy07GFe++qh3iJGJg/EQowQHs5IIr3iBabIQ
        b0piZVVqUX58UWlOavEhRlNgCE1klhJNzgemg7ySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0
        xJLU7NTUgtQimD4mDk6pBiaejo/hO0UfNjFk7a8V+3le527oaQ2H0zEbl77Z4qQjZe2w+rzR
        bKts2+c5bAFXGkWLM21OHXhuUarspZdZu3KxVnjRpbQL/SuPzJi50rEm4v0CS4WuD78nrd0n
        u2Hf7oxdp6Paoo4bR7RLXKieckyk1XK/S1X85GePJAL8PJ+90iuKZWF9yvdu9Yt7em1M3/iW
        757a8rf5zRGWDs+z7Buid1y4z699XttJ4eKrZOM7Lyy4fp9ao+it8PJr5aeb+0qLCrxe/1zj
        NTn17PZXgR7FyTf+u+m+mNUi/U3uq/xk3iKpXZ85Ns7PK2h3M2rsWjr98m7xwGvO18+8LNin
        7JAq/JHtYVhmxeL9ArOP3eNTYinOSDTUYi4qTgQAG7lmL08DAAA=
X-CMS-MailID: 20220929134814eucas1p2d30fe313259bcd04f75c289ff8360165
X-Msg-Generator: CA
X-RootMTR: 20220929074749eucas1p206ebab35a37e629ed49924506e325554
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220929074749eucas1p206ebab35a37e629ed49924506e325554
References: <20220929074745.103073-1-p.raghav@samsung.com>
        <CGME20220929074749eucas1p206ebab35a37e629ed49924506e325554@eucas1p2.samsung.com>
        <20220929074745.103073-3-p.raghav@samsung.com>
        <d9a86bdd-bcba-51e9-16d4-287b333e18ad@kernel.dk>
        <ff8bfd82-d4aa-4263-28c0-9c4788e45da8@samsung.com>
        <f6e54907-1035-2b2c-6387-ed178be05ccb@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022-09-29 15:45, Jens Axboe wrote:
> On 9/29/22 7:41 AM, Pankaj Raghav wrote:
>>>> Either of the changes should not have led to a bug in zoned devices:
>>>>
>>>> - blk_execute_rq_nowait:
>>>>   Only passthrough requests can use this function, and plugging can be
>>>>   performed on those requests in zoned devices. So no issues directly
>>>>   accessing the plug.
>>>>
>>>> - blk_flush_plug in bio_poll:
>>>>   As we don't plug the requests that require a zone lock in the first
>>>>   place, flushing should not have any impact. So no issues directly
>>>>   accessing the plug.
>>>>
>>>> This is just a cleanup patch to use this wrapper to get the plug
>>>> consistently across the block layer.
>>>
>>> While I did suggest to make this consistent and in principle it's
>>> the right thing to do, it also irks me to add extra checks to paths
>>> where we know that it's just extra pointless code. Maybe we can
>>> just comment these two spots? Basically each of the sections above
>>> could just go into the appropriate file.
>>>
>> The checks should go away, and the plug could be inlined by the
>> compiler if we don't have CONFIG_BLK_DEV_ZONED. Otherwise, I do agree
>> with you that it is a pointless check.
> 
> But that's my general complaint with the argument that "it doesn't
> matter if this feature isn't configured" - distros enable features.
> Anything that uses IS_ENABLED() is handy for testing, but assuming it
> all pretty much gets enabled in the distro kernel, it does absolutely
> nothing to help the added overhead. It's something that gets done to
> create the illusion that an added feature CAN have zero core overhead,
> while in reality that's utterly wrong.
> Got it!
>> I am fine with either, though I prefer what this patch is doing. So if
>> you feel strongly against calling the blk_mq_plug function, I can turn
>> this patch into just adding comments as you suggested.
> 
> I think we should. I can pick patch 1 here, and then you can send a
> patch 2 for that when you have time.
> 

I will do it right away as a separate patch! Thanks.
