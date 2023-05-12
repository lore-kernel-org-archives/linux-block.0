Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F55C77B7C
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 08:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239984AbjELIRu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 04:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239803AbjELIRt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 04:17:49 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7D81FC8
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 01:17:46 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230512081743euoutp017c1dfaeeb4ca62d2798afd1759bbdfb1~eV3Ni4AP_0984009840euoutp01R
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 08:17:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230512081743euoutp017c1dfaeeb4ca62d2798afd1759bbdfb1~eV3Ni4AP_0984009840euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683879463;
        bh=qdEYDvt7a7O08va7W/8/l97RTjJar3JXBPRXdk1W0m0=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=Kz3W+T4ljBHiNRWXUJ60n1fCmCAbYLRQXa7qi7ziDUKlwqYfPvjX2I0U5sjSISZON
         1zIILP7z1/Ue0oa5Dm7XsxFWIYa5Gq0zL4KIdjJiYdolgeb4Ix4VRRfG1Usd/hrKiF
         viS0XHESdkiYEPQxhq4stwhmRYoLGp2XCVNjfcIo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230512081743eucas1p170350da54a3cbe32ac27371f58086dbf~eV3NIvfxG0257302573eucas1p13;
        Fri, 12 May 2023 08:17:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 79.BE.35386.726FD546; Fri, 12
        May 2023 09:17:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230512081743eucas1p14510c36baa35aead4a1b28802d730a91~eV3M7EOJH0466604666eucas1p1N;
        Fri, 12 May 2023 08:17:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230512081743eusmtrp1b839435ff34d8948cfefb044caa010f9~eV3M6kwZD2864228642eusmtrp1Y;
        Fri, 12 May 2023 08:17:43 +0000 (GMT)
X-AuditID: cbfec7f4-cc9ff70000028a3a-e4-645df6274a6f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 31.74.14344.626FD546; Fri, 12
        May 2023 09:17:42 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230512081742eusmtip22f43223edff327c2d2b854d3ed4da3fc~eV3Mu7WWH2606726067eusmtip2V;
        Fri, 12 May 2023 08:17:42 +0000 (GMT)
Received: from [192.168.8.209] (106.210.248.191) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 12 May 2023 09:17:42 +0100
Message-ID: <b45b3578-857d-a13b-6fdc-6ceb178ddb84@samsung.com>
Date:   Fri, 12 May 2023 10:17:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
Subject: Re: [PATCH] brd: use XArray instead of radix-tree to index backing
 pages
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "willy@infradead.org" <willy@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Content-Language: en-US
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <bf2daf76-ebfd-8ca2-0e40-362bcaecfc3f@nvidia.com>
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.191]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djPc7rq32JTDKZ1ClmsvtvPZvH+4GNW
        i5WrjzJZ7L2lbfH7xxw2B1aPzSu0PC6fLfXYfbOBzaO3+R2bx+dNcgGsUVw2Kak5mWWpRfp2
        CVwZ1/vWsBbMYq+48qimgfEJSxcjB4eEgInEoZVKXYxcHEICKxglpszZzQ7hfGGUaG8+wAbh
        fGaUWNR/AcjhBOtY9X87VGI5o0Tfhr/McFX3lj+D6t/NKDF53mx2kBZeATuJq9sns4DYLAKq
        Ek1rr7JCxAUlTs58AhYXFYiWWLxvCpgtLBAscW/VASYQW0RAT+LqrRtgQ5kFHjJKfP22mREk
        wSwgLnHryXwmkC/YBLQkGjvBdnEC7bo8ezU7RIm8xPa3c5ghzlaWmDz5P9QLtRKnttxiApkp
        IfCEQ2Lj3G3sEAkXicUfVzJC2MISr45vgYrLSJye3MMCYVdLPL3xmxmiuYVRon/nejZIUFpL
        9J3JATGZBTQl1u/Shyh3lLi+8QU7RAWfxI23ghCn8UlM2jadeQKj6iykkJiF5LFZSD6YhTB0
        ASPLKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMBEc/rf8S87GJe/+qh3iJGJg/EQowQH
        s5II79sl0SlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEebVtTyYLCaQnlqRmp6YWpBbBZJk4OKUa
        mDSsjzgzHSi9fiI67rgV0zWXXsUtam5dwkl7W+q54lPu7rtjunrmG7fdZUc+KZZrdkxITd8h
        dOOy2LRLW7leqBlJCXA2NJjdD76yyOutr8U/3l8vnPQLlH/rch/h9Fg+uZnpwPYj/LkHGgSO
        ds24xlHTpzvn9+q5x5SX1z74MEmR47nQwcMi7IpbpG66WFsxbFyjpnyhembw7akXj/psu/Zj
        PVPyXzUfK4W1i4N0bGfK65r+/nVi39X3N/eu/LJtvuL6K1eTNT6/fbBYvs5IV/XY7SilHbvc
        A4/fXByyw/E999z5M/IZ7pQ89frw2sxN70w/w/sfPpctdMrsb7VrRPy6Ljh/auezt1v+yd/M
        6ZytxFKckWioxVxUnAgAanLyM6MDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xe7rq32JTDJ5aWqy+289m8f7gY1aL
        lauPMlnsvaVt8fvHHDYHVo/NK7Q8Lp8t9dh9s4HNo7f5HZvH501yAaxRejZF+aUlqQoZ+cUl
        tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnX+9awFsxir7jyqKaB8QlL
        FyMnh4SAicSq/9vZuhi5OIQEljJKLDzdxgSRkJHY+OUqK4QtLPHnWhdU0UdGib0zNrJAOLsZ
        JZbc3A02ilfATuLq9slgNouAqkTTWohuXgFBiZMzIdaJCkRL3Fj+DWyDsECwxL1VB8BsEQE9
        iau3brCDDGUWeMgo8fXbZkaIDYcYJeZMfwdWxSwgLnHryXwgm4ODTUBLorGTHSTMCbT48uzV
        7BAlmhKt239D2fIS29/OYYZ4QVli8uT/bBB2rcTnv88YJzCKzkJy3ywkG2YhGTULyagFjCyr
        GEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAmN027GfW3Ywrnz1Ue8QIxMHI9DpHMxKIrxvl0Sn
        CPGmJFZWpRblxxeV5qQWH2I0BQbSRGYp0eR8YJLIK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQS
        SE8sSc1OTS1ILYLpY+LglGpgir31Jdk0rM9Bz6b/aFrY5bWbzH9EK014VBG1/4/Dyh3f0kJ5
        HpTtrSpfLFTHualsGcfcIp3nH90j698Kic3YLn2phlffuiX4wadVynLt0j+zWf9eWyZ4cd7B
        7ROldv+w2ux5LTnrA1Pl22aRLStkfYvcA27+bpR6kxAY3RDdz+0lsIT15wuu487z1ePWL9B7
        dDyM6/Mr4zkXmadaZNTO4XOW1H6+6NdFnttHHt9T+uFrN9337Y8zW5mZhKccPPR7eq/tF+d9
        jqde1lpFxDfk7z3nEd7x+M6lVfMvTDb6Y82wOHPVLJm6pc+cjtjar/2zv/7SjrOR8zkeyTCk
        Zx7vLrvg4tYwm+lUkkK+NEffYiWW4oxEQy3mouJEALWpz8laAwAA
X-CMS-MailID: 20230512081743eucas1p14510c36baa35aead4a1b28802d730a91
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

>> [1] Performance in KIOPS:
>>
>>            |  radix-tree |    XArray  |   Diff
>>            |             |            |
>> write     |    315      |     313    |   -0.6%
>> randwrite |    286      |     290    |   +1.3%
>> read      |    330      |     335    |   +1.5%
>> randread  |    309      |     312    |   +0.9%
>>
> 
> I've few concerns, can you please share the fio jobs that
> have used to gather this data ? I want to test it on my
> setup in order to provide tested-by tag.
> 

That would be great. This is my fio job:

$ modprobe brd rd_size=10485760 rd_nr=1
$ fio --name=brd  --rw=<type>  --size=10G --io_size=100G --cpus_allowed=1 --filename=/dev/ram0
--direct=1 --iodepth=64 --ioengine=io_uring --loop=8

I ran the above job four times and averaged it as I noticed some variance. I ran the test in QEMU
as we were using a block device where the backing storage lives in RAM.

