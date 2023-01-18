Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA79C32793
	for <linux-block@archiver.kernel.org>; Wed, 18 Jan 2023 10:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjARKI6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Jan 2023 05:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjARKIf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2023 05:08:35 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DA03B0FE
        for <linux-block@vger.kernel.org>; Wed, 18 Jan 2023 01:15:06 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230118091502epoutp0101d02afd6802e3c7022283714905dbbf~7XGs5hMYw1981119811epoutp01D
        for <linux-block@vger.kernel.org>; Wed, 18 Jan 2023 09:15:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230118091502epoutp0101d02afd6802e3c7022283714905dbbf~7XGs5hMYw1981119811epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674033302;
        bh=u18xnqeKMhav4fnt3mUg+27ASSOjCoOXwmJVd3vWrlU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kAJ8663LO21NHa8aaCaRM6SOIK2GvEJpBSISFQPjuiNK8QM9qE9hUq61T6gken04t
         qY7NoZAm8hu7KdwE9ikJLec6mU0CqJZOYEo+mzASP4cA/jJA+6PLd4OY7zzzgZpRMn
         SaUnPKJem/sQPJM6CEMF01k8oGTD+Casily/ls7Y=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230118091501epcas5p35c30c8183e48475eeafe0bba2a903cb5~7XGshxbKJ1773817738epcas5p3h;
        Wed, 18 Jan 2023 09:15:01 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Nxg84403Nz4x9Q6; Wed, 18 Jan
        2023 09:15:00 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.8D.02301.498B7C36; Wed, 18 Jan 2023 18:15:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230118091500epcas5p19c0399ce6ad8e33aed549dfcbd2af7cb~7XGrG8nDI0890808908epcas5p1j;
        Wed, 18 Jan 2023 09:15:00 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230118091500epsmtrp2185d532f6b934ac032ba606b03bd777d~7XGrGFs9Q0329303293epsmtrp2s;
        Wed, 18 Jan 2023 09:15:00 +0000 (GMT)
X-AuditID: b6c32a49-201ff700000108fd-7c-63c7b8940431
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.07.10542.498B7C36; Wed, 18 Jan 2023 18:15:00 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230118091458epsmtip1a60de434cdc4f8056bba60f149ff6534~7XGp4xi_E3167331673epsmtip1k;
        Wed, 18 Jan 2023 09:14:58 +0000 (GMT)
Date:   Wed, 18 Jan 2023 14:44:35 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Anuj Gupta <anuj20.g@samsung.com>, hch@lst.de, kbusch@kernel.org,
        asml.silence@gmail.com, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH for-next v1 0/2] enable pcpu bio-cache for IRQ
 uring-passthru I/O
Message-ID: <20230118091435.GA9052@green5>
MIME-Version: 1.0
In-Reply-To: <0e88f8e6-961e-28b2-0606-50c1a0de10fb@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmuu6UHceTDRZckrVomvCX2WLOqm2M
        Fqvv9rNZ3Dywk8li5eqjTBaTDl1jtNh7S9ti/rKn7A4cHjtn3WX3uHy21GPTqk42j81L6j12
        32xg8+jbsorR4/MmuQD2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTc
        VFslF58AXbfMHKCTlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV5
        6Xp5qSVWhgYGRqZAhQnZGcevsBQcE6z4dyS6gXE9fxcjJ4eEgIlE/4c/LF2MXBxCArsZJZp/
        vmGCcD4xSux43wCV+QzkbF3ACtMy+cBZqMQuRome6w9ZIZwnjBJbDp1jAqliEVCV2PuqD6iK
        g4NNQFPiwuRSkLCIgIJEz++VbCD1zAKbGSW6uteB1QsLhEucW/iAEcTmFdCSuNS4kgnCFpQ4
        OfMJC4jNKWAr8W7rT7ArRAWUJQ5sOw52q4TAVA6JS7vmMEOc5yIx6fd8KFtY4tXxLewQtpTE
        53d72SDsZIlLMyEOlRAokXi85yCUbS/ReqofrJdZIENi45OzjBA2n0Tv7ydMIM9ICPBKdLQJ
        QZQrStyb9BQaKuISD2csYYUo8ZDo/qwCCZMDjBIXLv5gnMAoNwvJO7OQbICwrSQ6PzSxzgJq
        ZxaQllj+jwPC1JRYv0t/ASPrKkbJ1ILi3PTUYtMCw7zUcngUJ+fnbmIEp1Etzx2Mdx980DvE
        yMTBeIhRgoNZSYSXf/3xZCHelMTKqtSi/Pii0pzU4kOMpsDomcgsJZqcD0zkeSXxhiaWBiZm
        ZmYmlsZmhkrivKlb5ycLCaQnlqRmp6YWpBbB9DFxcEo1MMUWPRaS+mQyz2baluhV0kwTfFZM
        /7Fq0XTb9sW+clU2p/+2dFjPrfl+7emjr5s76no0TmhtLUna9acgjYlVzufI6QoH7vTuE2Iy
        n9vv/yv+U18vlxlmnfKgh60nfVJ8ZuSDCrZZ2yRkmfW/9K/3nvxmpunFKc/XXzwqLNKvPPnD
        h46jYdZ9FvlyLdPWvV9reCO69Ob/rz5aHM9Y/9SZ/P7qz+Rg/u3XTO6uxvC9E2QMfI161J+z
        ZP3XEpu5wr9Q9MK5381P3cR6Ju1z2rjoYOQHjS+Td4t2/X+zVCtf5URmQY3HjBNSGwuedOyx
        Zgrom7s2v2351Zzy/Z3Xw+eH5M2dLGJ6aLL7hYhmpU28vUosxRmJhlrMRcWJAGMTex4sBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnO6UHceTDZ5uYbFomvCX2WLOqm2M
        Fqvv9rNZ3Dywk8li5eqjTBaTDl1jtNh7S9ti/rKn7A4cHjtn3WX3uHy21GPTqk42j81L6j12
        32xg8+jbsorR4/MmuQD2KC6blNSczLLUIn27BK6MlT+OsRT84Ks4/WIHWwPjb54uRk4OCQET
        ickHzrJ0MXJxCAnsYJS41dzMBpEQl2i+9oMdwhaWWPnvOTtE0SNGib7lR5hBEiwCqhJ7X/UB
        dXNwsAloSlyYXAoSFhFQkOj5vZINpJ5ZYDOjRFf3OiaQhLBAuMS5hQ8YQWxeAS2JS40rweJC
        AgcYJZr/WUHEBSVOznzCAmIzC5hJzNv8kBlkPrOAtMTyfxwgYU4BW4l3W3+ygtiiAsoSB7Yd
        Z5rAKDgLSfcsJN2zELoXMDKvYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjg0trR2M
        e1Z90DvEyMTBeIhRgoNZSYSXf/3xZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeW
        pGanphakFsFkmTg4pRqYVnDs2Db7V8u558nfNBdNWGDxT0aSLXzOsZb5toXun99opMTNLHkQ
        zznfJXHSP4va20mafas0fi24JecpWMHBsj7klIuC5Nmeljf7J9lHKUyf+bX1btZdyxfmj+Jv
        F0wvd3qu9tQozap7zhFXWc7/Hs9/7g2f1xf9hFW/sOjDtpMxoi9/tR3cmbHqobhx+1mFXK6c
        Z2p2D0/vuDF7/pyIqVafW05I5nS4L1j6W4B1zvfXZr7zMld/+yFZu/S6fWvipJxIcevzpQ5h
        J3sEdA0vHWR0SJ+/jP3yNuVK0aeH3tm+/NZapMNt7vpLruuklkH7vAffwhg2cAfzutvNzt7b
        uOvKlsbUj31/bNewz+T6pMRSnJFoqMVcVJwIACC6VDP8AgAA
X-CMS-MailID: 20230118091500epcas5p19c0399ce6ad8e33aed549dfcbd2af7cb
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----E3zA.v0xxZ.Y.HquaBez13lU9xt4d7bTbMsaftJOpIJom8Sz=_b8916_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230117120741epcas5p2c7d2a20edd0f09bdff585fbe95bdadd9
References: <CGME20230117120741epcas5p2c7d2a20edd0f09bdff585fbe95bdadd9@epcas5p2.samsung.com>
        <20230117120638.72254-1-anuj20.g@samsung.com>
        <0e88f8e6-961e-28b2-0606-50c1a0de10fb@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------E3zA.v0xxZ.Y.HquaBez13lU9xt4d7bTbMsaftJOpIJom8Sz=_b8916_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Tue, Jan 17, 2023 at 10:11:08AM -0700, Jens Axboe wrote:
>On 1/17/23 5:06?AM, Anuj Gupta wrote:
>> This series extends bio pcpu caching for normal / IRQ-driven
>> uring-passthru I/Os. Earlier, only polled uring-passthru I/Os could
>> leverage bio-cache. After the series from Pavel[1], bio-cache can be
>> leveraged by normal / IRQ driven I/Os as well. t/io_uring with an Optane
>> SSD setup shows +7.21% for batches of 32 requests.
>>
>> [1] https://lore.kernel.org/io-uring/cover.1666347703.git.asml.silence@gmail.com/
>>
>> IRQ, 128/32/32, cache off
>
>Tests here -
>
>before:
>
>polled=0, fixedbufs=1/0, register_files=1, buffered=1, QD=128
>Engine=io_uring, sq_ring=128, cq_ring=128
>IOPS=62.88M, BW=30.70GiB/s, IOS/call=32/31
>IOPS=62.95M, BW=30.74GiB/s, IOS/call=32/31
>IOPS=62.52M, BW=30.53GiB/s, IOS/call=32/32
>IOPS=62.61M, BW=30.57GiB/s, IOS/call=31/32
>IOPS=62.52M, BW=30.53GiB/s, IOS/call=32/31
>IOPS=62.40M, BW=30.47GiB/s, IOS/call=32/32
>
>after:
>
>polled=0, fixedbufs=1/0, register_files=1, buffered=1, QD=128
>Engine=io_uring, sq_ring=128, cq_ring=128
>IOPS=76.58M, BW=37.39GiB/s, IOS/call=31/31
>IOPS=79.42M, BW=38.78GiB/s, IOS/call=32/32
>IOPS=78.06M, BW=38.12GiB/s, IOS/call=31/31
>IOPS=77.64M, BW=37.91GiB/s, IOS/call=32/31
>IOPS=77.17M, BW=37.68GiB/s, IOS/call=32/32
>IOPS=76.73M, BW=37.47GiB/s, IOS/call=31/31
>IOPS=76.94M, BW=37.57GiB/s, IOS/call=32/31
>
>Note that this includes Pavel's fix as well:
>
>https://lore.kernel.org/linux-block/80d4511011d7d4751b4cf6375c4e38f237d935e3.1673955390.git.asml.silence@gmail.com/

So I was thinking whether we need this fix for passthru path too. We do
not.
For block path, blk_mq_get_cached_request() encountered a
mismatch since type was different (read vs default).
For passthru, blk_mq_alloc_cached_request() sees no mismatch since
passthrough opf is not treated as read (default vs default).

------E3zA.v0xxZ.Y.HquaBez13lU9xt4d7bTbMsaftJOpIJom8Sz=_b8916_
Content-Type: text/plain; charset="utf-8"


------E3zA.v0xxZ.Y.HquaBez13lU9xt4d7bTbMsaftJOpIJom8Sz=_b8916_--
