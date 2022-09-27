Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EA0C6FA82
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 15:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiI0PUg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 11:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiI0PUd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 11:20:33 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4817391D
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 08:20:29 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220927152023euoutp01b8538c17ef3976caf9bf1aeb91e6253e~YwMcQK5mD0954209542euoutp01P
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 15:20:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220927152023euoutp01b8538c17ef3976caf9bf1aeb91e6253e~YwMcQK5mD0954209542euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664292023;
        bh=6c6/laBjlI+b87yCcwvUENUzPnrsDHE9XZP/QWnR9N0=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=DXwV2MCS1w4X6M6SwFEX+adwwtGrQxwiHOfZc+PmocwDdg/FAU3QSUQ543t2HRtKn
         DAKBt5gJeX/zdVYfQgplAYJWPuLBP6rkPJP0FWAJWV1EkoBEFgN3zrHVKhdK2Z0ou2
         78WXoKCE0EWWyyRen5jv60nqD3CMqENMBAieZGt8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220927152023eucas1p2652baf4b94a690083fadd0f4e81a477b~YwMcDNDt01860118601eucas1p2B;
        Tue, 27 Sep 2022 15:20:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B3.F7.19378.7B413336; Tue, 27
        Sep 2022 16:20:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220927152022eucas1p1ec76aba02a1e88405ce74684ac075e6d~YwMbpiONH1639616396eucas1p1S;
        Tue, 27 Sep 2022 15:20:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220927152022eusmtrp29bb53d3f33a7f4a189db392e1d347f6f~YwMbo1bZF0409604096eusmtrp2R;
        Tue, 27 Sep 2022 15:20:22 +0000 (GMT)
X-AuditID: cbfec7f5-a35ff70000014bb2-ea-633314b71e04
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5B.25.07473.6B413336; Tue, 27
        Sep 2022 16:20:22 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220927152022eusmtip19d67d0a33bb4fc408cf8af05614e6bb1~YwMbgit5X1285812858eusmtip1f;
        Tue, 27 Sep 2022 15:20:22 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.168) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 27 Sep 2022 16:20:21 +0100
Message-ID: <6273f2c1-7889-1931-aec6-e567aa4d2d96@samsung.com>
Date:   Tue, 27 Sep 2022 17:20:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] block: modify blk_mq_plug() to allow only reads for
 zoned block devices
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
CC:     <linux-block@vger.kernel.org>, <damien.lemoal@opensource.wdc.com>,
        <gost.dev@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <350366c3-1014-ac32-149f-689134631d73@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.168]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduznOd3tIsbJBgc/sVmsvtvPZvH77Hlm
        i9MTFjFZ7L2l7cDisXmFlsfls6UeO1vvs3p83iQXwBLFZZOSmpNZllqkb5fAlXHh3yTGggds
        FQu//2FuYFzJ2sXIySEhYCLxc9ZTIJuLQ0hgBaPEos0zWSCcL4wSfd8OQzmfGSWOL9vOAtOy
        ZvFxqMRyRoldNxqY4Kqmr1oP5exmlHj3sI0dpIVXwE5i19ftbF2MHBwsAqoSl57mQIQFJU7O
        fAI2VVQgUmLN7rNg5cICSRIH/5wHO5BZQFzi1pP5TCC2iIC7xP0DJ6Di8RJ7m/qZQEayCWhJ
        NHaCtXIK2EpcOH2SCaJEU6J1+292CFteYvvbOcwQDyhLLD89E8qulVh77Aw7yMkSAnc4JLZ8
        3wyVcJH4PvExNJCEJV4d38IOYctI/N8JcY+EQLXE0xu/mSGaWxgl+neuB/tRQsBaou9MDkSN
        o8SZfwuYIcJ8EjfeCkLcwycxadt05gmMqrOQQmIWko9nIXlhFpIXFjCyrGIUTy0tzk1PLTbO
        Sy3XK07MLS7NS9dLzs/dxAhMLKf/Hf+6g3HFq496hxiZOBgPMUpwMCuJ8P4+apgsxJuSWFmV
        WpQfX1Sak1p8iFGag0VJnJdthlaykEB6YklqdmpqQWoRTJaJg1OqganXsGzFwdM9DOsk52+z
        bApi8lUPFjXYc3jJAQ83/5KOrrLPfo6PxM7ePqd7KyNh966dXCwTbpmY6K3f77gkZMbb5Vlc
        LzpeMi2b6984yYIjs3iLicbuJ7frCkp4xFoiXojbn3OI4510rLk6Y53MkTb7l6vaGZg09p/U
        3R9ymOPBnCWvLe617XionVw1i/k91ySFbw5KAnsXReVEOqizMZ+ZrvbDQ/dFf4RC4/lolg37
        Zlycsva0w7vpD7WEtX/fW+jxb7O48MQjMo2XK90DshRE/K56Po8RrpI7ryLYtaT+96TtAT/E
        eua+mGoSpBDMdvwKm1/c9Gff3LLEknS7mD7PWLl+tqry2ayPN2wKu5RYijMSDbWYi4oTAXqQ
        UDabAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xu7rbRIyTDQ4uNbJYfbefzeL32fPM
        FqcnLGKy2HtL24HFY/MKLY/LZ0s9drbeZ/X4vEkugCVKz6Yov7QkVSEjv7jEVina0MJIz9DS
        Qs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+PCv0mMBQ/YKhZ+/8PcwLiStYuRk0NCwERi
        zeLjLF2MXBxCAksZJZ6e+sgIkZCR+HTlIzuELSzx51oXG0TRR0aJ31MfQ3XsZpTYunI9M0gV
        r4CdxK6v24GqODhYBFQlLj3NgQgLSpyc+YQFxBYViJR4uKyJCcQWFkiSOPjnPNgVzALiEree
        zAeLiwi4S9w/cAIqHi+xt6mfCWLXZWaJta+2M4HMZxPQkmjsBDuOU8BW4sLpk0wQ9ZoSrdt/
        s0PY8hLb385hhnhAWWL56ZlQdq3Eq/u7GScwis5Cct4sJGfMQjJqFpJRCxhZVjGKpJYW56bn
        FhvqFSfmFpfmpesl5+duYgTG47ZjPzfvYJz36qPeIUYmDsZDjBIczEoivL+PGiYL8aYkVlal
        FuXHF5XmpBYfYjQFBtFEZinR5HxgQsgriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5N
        LUgtgulj4uCUamDiyliScD9fbFnd4TWuO6WVlA3Zj65jqv+srPOH7dKksgC7dsfUVxs0XoT3
        RB82svy24831L1f7Li1/rWCyWODtxM9zJsXw1UpH2E34Gc9tvSZPeGHaxx1Kk3b3X/k93bEr
        6mzZ2/nbzxszbFzIeXmSY1eZcd2pBd+WudlVn7OXvHrNsikl88uLWBZ2x+1lk2LORF+PyJBb
        p32s+mnWt93ixprTReZPuyHF96j8ozKzbuyF4gMnF13ZLepw+NLFC9YX7ZeW/L7cllDN9OnE
        ijX1m5dKuX6cZ/YkPr9rggzDvqBjTlOYA+Mv7FaVDo+58O6ey87XOn2TF95ZcS3A+YBxjtFy
        pdurY2V1+5y3nVlopsRSnJFoqMVcVJwIAKz6tZhQAwAA
X-CMS-MailID: 20220927152022eucas1p1ec76aba02a1e88405ce74684ac075e6d
X-Msg-Generator: CA
X-RootMTR: 20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef
References: <20220925185348.120964-1-p.raghav@samsung.com>
        <CGME20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef@eucas1p1.samsung.com>
        <20220925185348.120964-2-p.raghav@samsung.com>
        <YzG5RgmWSsH6rX08@infradead.org>
        <d5975b62-f2e9-dcde-e332-a73cca1f7fbf@kernel.dk>
        <YzG6fZdz6XBDbrVB@infradead.org>
        <2ee6a897-87e7-0592-2482-9928a9a63ff6@kernel.dk>
        <a943acf8-f367-a1ba-0d57-2948a3ade6f4@samsung.com>
        <350366c3-1014-ac32-149f-689134631d73@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>> I guess the second patch should be enough to apply plugging when
>> applicable for uring_cmd based nvme passthrough requests.
> 
> Do we even need the 2nd patch? If we're just doing passthrough for the
> blk_execute_nowait() API, then the condition should never trigger? 

I think this was the question I raised in your first version of the series.

If we do a NVMe write using the passthrough interface, then we will be
using REQ_OP_DRV_OUT op, which is:

REQ_OP_DRV_OUT		= (__force blk_opf_t)35, // write bit is set

The condition in blk_mq_plug() will trigger as we only check if it is a
_write_ (op & (__force blk_opf_t)1) to the device. Am I missing something?

> If so, then it would be a cleanup just to ensure we're using a consistent
> API for getting the plug, which may be worthwhile to do separately for
> sure.
> 

--
Pankaj
