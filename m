Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B0BC07E9D
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 06:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbiI2GcD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 02:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiI2GcC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 02:32:02 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CE3120BF6
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 23:32:00 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220929063159euoutp01b7d5832d3e871b17ec6f60f43928c14a~ZQRqCHpAN3120831208euoutp01i
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 06:31:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220929063159euoutp01b7d5832d3e871b17ec6f60f43928c14a~ZQRqCHpAN3120831208euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664433119;
        bh=0ON8/mCjr5C3yURM9hVFRUO7gNPlxFnxKjNyT/NLCT8=;
        h=Date:From:Subject:To:CC:In-Reply-To:References:From;
        b=EP9zAC9LcGYRnvhaaHfv/har743gd6ShjZuscW8lFI7jdTEbX+epY957BWBXzxYRe
         L2FvxqgTgVFAbune9jGxhomIs7OExDB63ieadLVb4BnFBPAUkOKao9c8dnxqEW/uQN
         6Wql4fXVQMOLG9Sw17ofkXM8c2TEQh3V5GDfxxxc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220929063158eucas1p2e9dfe7e042f4407b1a8bc83acf6b1bc2~ZQRpoIge52200622006eucas1p2v;
        Thu, 29 Sep 2022 06:31:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 8D.CB.19378.EDB35336; Thu, 29
        Sep 2022 07:31:58 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220929063158eucas1p1504a8b7423d26e3d427ff32a22f2d70b~ZQRpQs4MM1792417924eucas1p1V;
        Thu, 29 Sep 2022 06:31:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220929063158eusmtrp192f85e25440ac5cdf854e3c85b84e268~ZQRpPvFps1200512005eusmtrp1J;
        Thu, 29 Sep 2022 06:31:58 +0000 (GMT)
X-AuditID: cbfec7f5-a35ff70000014bb2-2b-63353bdec0a6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 31.79.10862.EDB35336; Thu, 29
        Sep 2022 07:31:58 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220929063158eusmtip167fe71d619027c04012f0cb080b70c37~ZQRpBlKjj1340213402eusmtip15;
        Thu, 29 Sep 2022 06:31:58 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.168) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 29 Sep 2022 07:31:56 +0100
Message-ID: <5e9d678f-ffea-e015-53d8-7e80f3deda1e@samsung.com>
Date:   Thu, 29 Sep 2022 08:31:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
From:   Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v15 00/13] support zoned block devices with
 non-power-of-2 zone sizes
To:     <axboe@kernel.dk>, <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC:     <jaegeuk@kernel.org>, <agk@redhat.com>, <gost.dev@samsung.com>,
        <snitzer@kernel.org>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.de>, <matias.bjorling@wdc.com>,
        <Johannes.Thumshirn@wdc.com>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <pankydev8@gmail.com>,
        <dm-devel@redhat.com>
Content-Language: en-US
In-Reply-To: <20220923173618.6899-1-p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.168]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djPc7r3rE2TDVY/NbZYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS32LJrEZLFy9VEmiyfrZzFb/O26x2Qx6dA1Rou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLdbcfMpiceKWtIOAx+Ur3h47Z91l97h8ttRj06pONo/NS+o9dt9sYPPY2Xqf
        1eP9vqtAodPVHp83yXm0H+hmCuCO4rJJSc3JLEst0rdL4Mo4f+8dW8FlxorGPfoNjHMZuxg5
        OSQETCQmbXvO2sXIxSEksIJR4sm1OewQzhdGif+L9zFDOJ8ZJWY+38MM09LW+ZUFIrGcUWJR
        1xMWuKrOK01Q/bsZJXo79gK1cHDwCthJXD6bA9LNIqAq8XzHXLBJvAKCEidngjRzcogKREqs
        2X2WHaScTUBLorGTHSQsLBAt8eDQFyYQW0TAReJm7yGwi5gFvjBJzL++mxUkwSwgLnHryXwm
        kF5OAUuJ/sYaiLCmROv23+wQtrzE9rdzoB5Qllh+eiaUXSux9tgZsJMlBJ5xSvx5/YgNIuEi
        8ebPOiYIW1ji1fEt7BC2jMTpyT0sEHa1xNMbv5khmlsYJfp3rmcDOUJCwFqi70wORI2jxMfD
        T9ghwnwSN94KQtzDBwz36cwTGFVnIYXELCTfzELywiwkLyxgZFnFKJ5aWpybnlpsnJdarlec
        mFtcmpeul5yfu4kRmA5P/zv+dQfjilcf9Q4xMnEwHmKU4GBWEuH9fdQwWYg3JbGyKrUoP76o
        NCe1+BCjNAeLkjgv2wytZCGB9MSS1OzU1ILUIpgsEwenVAPTzLinYkkbJcWuWLmaTWic0pdS
        Z/PB//u5c4cFrdsul/2bduqk/OqDhXFxM2ql9nyfa+sicMv4/c9v8srR8yRK51xeFbG478NJ
        J4/OK893ijVOO1t4apeFw80g8/Taab9LF/+IuxSuvaqUxfiI9AFjruPJJw9/qlvAejv14k3e
        cw83vl639y3/c4VnpWdFd7zOTFJtj9gg+Gk7+4qnS0NKPftDFt26yG+gxL9zf77NU70SId20
        xiiuM22e5UbvdfOlJnVKuOd6CUgEpB891yNS9trtxZ9t/ww0p6xqmNXZFX4jtneybDTzmzaX
        qQ9PqyufeLDJbavl8hvL+VPU6je785n4RlfZaa3+/KTj4gY9JZbijERDLeai4kQAaSGnVvYD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsVy+t/xu7r3rE2TDY5ekrJYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS32LJrEZLFy9VEmiyfrZzFb/O26x2Qx6dA1Rou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLdbcfMpiceKWtIOAx+Ur3h47Z91l97h8ttRj06pONo/NS+o9dt9sYPPY2Xqf
        1eP9vqtAodPVHp83yXm0H+hmCuCO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7Uy
        MlXSt7NJSc3JLEst0rdL0Ms4f+8dW8FlxorGPfoNjHMZuxg5OSQETCTaOr+ydDFycQgJLGWU
        +LDtHRNEQkbi05WP7BC2sMSfa11sEEUfGSXOn9wA1bGbUWLWnZVAGQ4OXgE7ictnc0AaWARU
        JZ7vmMsMYvMKCEqcnPmEBcQWFYiUeLisiQmknE1AS6KxE2y+sEC0xOUzT9hAbBEBF4mbvYeY
        QcYzC3xhkph/fTcrxK4eRomFy7eCdTALiEvcejIfbBCngKVEf2MNRFhTonX7b6gSeYntb+cw
        QzygLLH89Ewou1bi1f3djBMYRWchOW8WkqmzkIyahWTUAkaWVYwiqaXFuem5xUZ6xYm5xaV5
        6XrJ+bmbGIFJZNuxn1t2MK589VHvECMTB+MhRgkOZiUR3t9HDZOFeFMSK6tSi/Lji0pzUosP
        MZoCw2gis5Rocj4wjeWVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBK
        NTClHXvtNfHVFvEXvB5mL6dLqhZuKAlh/Wi05NxF5Z3fIv5XzDtzQCzpXpdNRDGD3K0SObZH
        7Pwf7p0XnM/71ats1syjUdfXtVtqMij5Jr5MLHHpFzi45lBcmATjhdezFM43qYhsvFuvuPDd
        ga2W+VekHm1Vcps1W26BR8OiLPfP5yNetqSnyq5/H52UP/Uyo4/ywvmdW/czneyaKKvosIYv
        eP/UatPgwt/7phVNC536YI1b7OEf9tq2bT5bZytK/Xu3o6DCziLk0uqgvmi/qGjfBMM5me+/
        b7U2EHb6E75t9Rnn5z2qijwh9ie+aRzPfKjPp2nqknCd/+tNPU9Vx2vxuR1aDaLls9d+/+4b
        1aDEUpyRaKjFXFScCADA9Ta9qwMAAA==
X-CMS-MailID: 20220929063158eucas1p1504a8b7423d26e3d427ff32a22f2d70b
X-Msg-Generator: CA
X-RootMTR: 20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65
References: <CGME20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65@eucas1p1.samsung.com>
        <20220923173618.6899-1-p.raghav@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Hi Jens,
>   Please consider this patch series for the 6.1 release.
> 

Hi Jens, Christoph, and Keith,
 All the patches have a Reviewed-by tag at this point. Can we queue this up
for 6.1?

--
Pankaj
