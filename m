Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5526FC07E9D
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 07:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbiI2HPu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 03:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbiI2HP1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 03:15:27 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC212183AE
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 00:15:20 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220929071515euoutp028917f0a9a0b6066d31118c80caef74a2~ZQ3cLGN7m3188531885euoutp02H
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 07:15:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220929071515euoutp028917f0a9a0b6066d31118c80caef74a2~ZQ3cLGN7m3188531885euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664435715;
        bh=iBJbQOT23Qdzn3vTMgjPXlOK9gt+vdzz7vDanIHuv6o=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=pzQPYQXTUPpKgVKeMZ0e3TA6QaMz15xV2a2xuDwZ6tJRWxTw4W6Fk1micPPVCSJwr
         +P1+uE8qkA2MFcb8suYpOYPHhqVtqicAAeOlYxVg9J1xrZ1pugNU3bAzelI6ZmzhuH
         XxCHJVvj6HVDoflpFPkDxB83K4aL37ZThIQzkaAA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220929071515eucas1p1b2e666610a1f5004e4e41bb5503d61cd~ZQ3b-3Wz01955219552eucas1p1C;
        Thu, 29 Sep 2022 07:15:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4B.60.29727.30645336; Thu, 29
        Sep 2022 08:15:15 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220929071515eucas1p1722cfcc489bbf1fecba287949ef340fd~ZQ3bjW1x71956219562eucas1p1B;
        Thu, 29 Sep 2022 07:15:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220929071515eusmtrp29c1fa563923f2c4ded76038e02edb6d3~ZQ3bhyTJ82006820068eusmtrp2t;
        Thu, 29 Sep 2022 07:15:15 +0000 (GMT)
X-AuditID: cbfec7f2-21dff7000001741f-c8-63354603a3d8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CF.00.10862.30645336; Thu, 29
        Sep 2022 08:15:15 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220929071515eusmtip12926413871f71201bfb879d648a513b0~ZQ3bY5c8I2116821168eusmtip1R;
        Thu, 29 Sep 2022 07:15:15 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.168) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 29 Sep 2022 08:15:13 +0100
Message-ID: <72d2f463-a0b1-db96-acb4-28617893407b@samsung.com>
Date:   Thu, 29 Sep 2022 09:15:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] block: use blk_mq_plug() wrapper consistently in
 the block layer
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <linux-block@vger.kernel.org>, <gost.dev@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220929065641.GB31325@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.168]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduzneV1mN9Nkg32LVSxW3+1ns/h99jyz
        xcrVR5ks9t7SdmDxuHy21GP3zQY2j52t91k9Pm+SC2CJ4rJJSc3JLEst0rdL4Mq4Pv8JY8Fs
        9or9Z7uYGhjvsnYxcnJICJhIXDk5ibGLkYtDSGAFo8TTTdOYIJwvjBKtK3dBZT4zSjya0c8M
        07J3xnkmEFtIYDmjxNIzOXBFLZ1rodp3M0pM7lwJ1sErYCexbvEasA4WAVWJaf8uMUHEBSVO
        znzCAmKLCkRKrNl9lh3EFhaIk3izaCMjiM0sIC5x68l8sHoRASWJp6/OQsWLJM5+uQZUz8HB
        JqAl0dgJ1sopoCNxYspKdogSTYnW7b+hbHmJ7W/nQD2gLLH89Ewou1Zi7bEz7CA3Swjc4ZDY
        fXIxE0TCRWLmySXsELawxKvjW6BsGYn/O+dD1VRLPL3xmxmiuYVRon/nejaQgyQErCX6QKEC
        YjpKnD6eBWHySdx4KwhxDp/EpG3TmScwqs5CCohZSB6eheSDWUg+WMDIsopRPLW0ODc9tdgw
        L7Vcrzgxt7g0L10vOT93EyMwsZz+d/zTDsa5rz7qHWJk4mA8xCjBwawkwvv7qGGyEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcV62GVrJQgLpiSWp2ampBalFMFkmDk6pBqZFbfHHu38naCuFL/x/
        4HLgj/06YmslcjMmJKXctwzX3tXPZBmX+P+/XLPITq/+d6I+P1JuLk88/bDsvYRHOeuugzP+
        TQw2Wm2qaS/m8NJf1jtO4GKmxfoae4HVv1X7V2/ZJL+k+t/+rnNiPRdNb0WXTorx/O75Y79E
        +Kqr3TYMajH/ePfPyDmmHXku/3z9Pd/VAlfEpx3n/8WZedjmYtI9AQ+lm25/2wQd5BlORRo5
        RNnsFy6WvnevtlT4R14Bh9Dym5O1HoSlN/v2fOtYGHr0ufjHXVzKa7R7V8d63tXJvSz8sX51
        mtsL1qv+mtIBU9I9l9f/cq264eP22eP1WqvP/J9e9newc4XJsHOcVWIpzkg01GIuKk4EAOqV
        vh+bAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xu7rMbqbJBn/Ws1usvtvPZvH77Hlm
        i5WrjzJZ7L2l7cDicflsqcfumw1sHjtb77N6fN4kF8ASpWdTlF9akqqQkV9cYqsUbWhhpGdo
        aaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJdxff4TxoLZ7BX7z3YxNTDeZe1i5OSQEDCR
        2DvjPFMXIxeHkMBSRomPE+4yQSRkJD5d+cgOYQtL/LnWxQZR9JFR4sq8HmYIZzejxKQfV5hB
        qngF7CTWLV4D1s0ioCox7d8lJoi4oMTJmU9YQGxRgUiJh8uawOLCAnESbxZtZASxmQXEJW49
        mQ8WFxFQknj66ixUvEji7Jdr7BDL7jJKtEw5C7SMg4NNQEuisRPsOk4BHYkTU1ayQ9RrSrRu
        /w1ly0tsfzuHGeIDZYnlp2dC2bUSr+7vZpzAKDoLyXmzkJwxC8moWUhGLWBkWcUoklpanJue
        W2ykV5yYW1yal66XnJ+7iREYk9uO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8P4+apgsxJuSWFmV
        WpQfX1Sak1p8iNEUGEYTmaVEk/OBSSGvJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1
        tSC1CKaPiYNTqoGpJang/DWVDs7ONxEC360MelbtLPP7uk+5951//+PdBhk7Ny6Mqip1z5uS
        yiPyrMJcNEjveB/7uh+fyybkcDoL7H/pXLIp/ZSL1YbpEkxLJv+5ddGk4rDGmVa7HfMeuB0+
        tmAZZ5+P9mqrjNzJFyqniHF0VGzI4Xv2MeC2Id+18x3H5bRnJVQJH3Oru2TvseLVgrV7TCqf
        J/3QuyayWqfP6axMTeBmq0rltbf+Ny1/JCR6v2MeF5PeSl/1hPrYlQJcEdcUWdh/b+/LVmk+
        sjTexoWzb1l12DYdZpmUD9OC8uNM3z4MFQkVf2zO8EaI9cfVNQ1u63basvS5pgk7P5BzOrrU
        6uP35YJSJ9bU2yuxFGckGmoxFxUnAgAMUFQKUgMAAA==
X-CMS-MailID: 20220929071515eucas1p1722cfcc489bbf1fecba287949ef340fd
X-Msg-Generator: CA
X-RootMTR: 20220929062429eucas1p24790a979fa780e8bff61d9fd5ec05f8e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220929062429eucas1p24790a979fa780e8bff61d9fd5ec05f8e
References: <20220929062425.91254-1-p.raghav@samsung.com>
        <CGME20220929062429eucas1p24790a979fa780e8bff61d9fd5ec05f8e@eucas1p2.samsung.com>
        <20220929062425.91254-3-p.raghav@samsung.com>
        <20220929065641.GB31325@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022-09-29 08:56, Christoph Hellwig wrote:
> On Thu, Sep 29, 2022 at 08:24:25AM +0200, Pankaj Raghav wrote:
>> Use blk_mq_plug() wrapper to get the plug instead of directly accessing
>> it in the block layer.
> 
> I think this should explain why that is useful (or maybe even a bug
> fix?).

I mentioned it in the commit header: to use this wrapper consistently
across block layer because I am not sure if either of the changes would
have led to a bug in zoned devices.

1) blk_execute_rq_nowait:
No issues here because only passthrough request can use this function.

2) calling blk_flush_plug in bio_poll:
As we don't plug the request that do a write or write zeroes to zoned
devices in the first place, flushing should not have any impact.

This is just a cleanup patch to use this helper consistently. Maybe I
should mention it explicitly again in the commit log to make it clear?

--
Pankaj
