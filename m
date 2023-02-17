Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF2BC64ED8
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 14:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjBQOw4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Feb 2023 09:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjBQOwy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2023 09:52:54 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0AF6D79E
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 06:52:24 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230217145222euoutp022868fd276342effd63b416bd1fc82101~EpDzJRZFs1360213602euoutp02Y
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 14:52:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230217145222euoutp022868fd276342effd63b416bd1fc82101~EpDzJRZFs1360213602euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676645542;
        bh=wVzL2zCs4/gQdKWThWeloX5TKQuVBfGEA69H9e8jahs=;
        h=Date:From:Subject:To:CC:In-Reply-To:References:From;
        b=kWOSs4nnEerZoDwuv7w2EIAB6yZTxILdsg5ZsIFRwfuwPpZXr9tZl9GvKQJFJbAfm
         Avlq3fvfpuJeOgxFOKIMOAiL4rnYP26+atEDOzBsJhUTDkoY4zrRolwWhWaVvAy+41
         O43qTv+Np+DIOekPoyXt6gRu/de/KK71FO/iNDsM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230217145221eucas1p1f15974505c3b86c9277bbe29fc38abe3~EpDydyXzI1886418864eucas1p1c;
        Fri, 17 Feb 2023 14:52:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 56.F0.61197.5A49FE36; Fri, 17
        Feb 2023 14:52:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230217145221eucas1p2e040979f83cd8f2223fde78136f9bc9e~EpDyC9wlb1283112831eucas1p2m;
        Fri, 17 Feb 2023 14:52:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230217145221eusmtrp2cf19b04b1282843973c0c43cbae4d3da~EpDyCUk3f3174631746eusmtrp2n;
        Fri, 17 Feb 2023 14:52:21 +0000 (GMT)
X-AuditID: cbfec7f5-7c5ff7000000ef0d-d8-63ef94a50100
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 30.D9.02722.4A49FE36; Fri, 17
        Feb 2023 14:52:21 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230217145220eusmtip176b23b5db213dc8b3e6ebf0ec524ec26~EpDx6Eyny1348613486eusmtip1C;
        Fri, 17 Feb 2023 14:52:20 +0000 (GMT)
Received: from [192.168.1.19] (106.210.248.118) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 17 Feb 2023 14:52:18 +0000
Message-ID: <a10f11a5-2646-6db9-ab25-f2bb41190cc8@samsung.com>
Date:   Fri, 17 Feb 2023 20:22:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.7.1
From:   Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 0/1] improve brd performance with blk-mq
To:     Jens Axboe <axboe@kernel.dk>
CC:     <hch@lst.de>, <mcgrof@kernel.org>, <gost.dev@samsung.com>,
        <linux-block@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>
Content-Language: en-US
In-Reply-To: <db1d7cd7-6c89-7d6b-3fe5-3778bb3cb5e9@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.118]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djP87pLp7xPNrixVdZi9d1+NouVq48y
        Wey9pW1xY8JTRotDk5uZHFg9Lp8t9di0qpPNY/fNBjaP9/uusnl83iQXwBrFZZOSmpNZllqk
        b5fAlTHxx3zWgqdcFR8eHmBqYPzN3sXIySEhYCKx4+5Gli5GLg4hgRWMEv2/+9khnC+MEnde
        NTJCOJ8ZJZauWs8E03Kt4wIziC0ksJxR4sE3PbiiJfcnsUIkdjFKLF4iAWLzCthJXFg6iwXE
        ZhFQlXjafZAZIi4ocXLmE7C4qECUxKmfr4EWcHCwCWhJNHaCnScsYCOxbs4+sHIRAQWJnt8r
        2UBsZoE6if6mNmYIW1zi1pP5YLdxCthKrOtaxQ4R15Ro3f4bypaX2P52DjPE/coSp548YIWw
        ayVObbnFBHK/hMALDokXH2Hh4iJx9tdlqAZhiVfHt0DFZST+75wPDYhqiac3fjNDNLcAw27n
        ejaQByQErCX6zuRA1DhKNJ57wgoR5pO48VYQ4h4+iUnbpjNPYFSdhRQSs5C8MwvJC7OQvLCA
        kWUVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYLI5/e/41x2MK1591DvEyMTBeIhRgoNZ
        SYR30803yUK8KYmVValF+fFFpTmpxYcYpTlYlMR5tW1PJgsJpCeWpGanphakFsFkmTg4pRqY
        qsrP2146YrX/N9c/ftafz3yNy6qv81xbIK+7mOtvr+/eptK1gkFL12hzrsnOn773o3No+Rfj
        /QcnPa95PW3fND25jOqXBx+GsUQnpKTzXdtbkrXvl+Oua2/mXFvFdfDSy/Xp3yKEjp7/fXLK
        C/1Vd67Nv7VOW9GxZ0Jy1qfKDV8L+IWKjsf/szv25cTkngV+0eKeFfNaN891knhR9Ofv0WMC
        Nd8/S55+dCOUn1d4i1lWi9WRQwtEyrZ/eXxcOszqdpf/rx+xCUKC8vO5jypZyWtqdK5aZLog
        y+6QYqZ6R3vBnOxEvTjbu9rhF/9H+e7kfbhkweGlv3IX5/BZ3/K/V+lRmCeee17uNO+kDVZv
        hZRYijMSDbWYi4oTAY12SIulAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xu7pLp7xPNvj0msli9d1+NouVq48y
        Wey9pW1xY8JTRotDk5uZHFg9Lp8t9di0qpPNY/fNBjaP9/uusnl83iQXwBqlZ1OUX1qSqpCR
        X1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eglzHxx3zWgqdcFR8eHmBq
        YPzN3sXIySEhYCJxreMCcxcjF4eQwFJGiePv7jNDJGQkPl35CFUkLPHnWhcbRNFHRommvxNZ
        IZxdjBLr9l5iA6niFbCTuLB0FguIzSKgKvG0+yAzRFxQ4uTMJ2BxUYEoidMr1wFN5eBgE9CS
        aOwEWyAsYCOxbs4+sHIRAQWJnt8rwUYyC9RJ9De1QV13iFniyfYHTBAJcYlbT+aD2ZwCthLr
        ulaxQ8Q1JVq3/4ay5SW2v50D9Y2yxKknD1gh7FqJz3+fMU5gFJ2F5LxZSMbOQjJqFpJRCxhZ
        VjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTG6bZjPzfvYJz36qPeIUYmDsZDjBIczEoivJtu
        vkkW4k1JrKxKLcqPLyrNSS0+xGgKDKOJzFKiyfnARJFXEm9oZmBqaGJmaWBqaWasJM7rWdCR
        KCSQnliSmp2aWpBaBNPHxMEp1cC0pbBFhiV5lgF71OrzQT9ex1a015zl+HLyV+jahwmqfLdF
        2f+/OJbz4uEpYT8R/Vuidsr/evtdu/e1rsj/6DdFXjKRreDvhru/A9gnreXXiLbjPZYYnXGs
        co1RvOulNcsi3C6qrVUNOasurbJB61nYqQlv9/OZsfl6/9zn5u9YuFiGJ1b8d2zIlgk1BdfX
        1mS3v/iT7D8pbL6GGfvOyNKG2Xx7eG3/dDI94mxZHc0VvGb576/18k23jSZG+d3zbcj6suiC
        RM/6Uw22alfTI7/c3zTT0zjyiZ/AqV22q17k8544ty5Q7MJ3jhSBhWeTpqU6Zx/usbRV6pll
        JWl7VPFfyPbUGKkivc23Z3CyuymxFGckGmoxFxUnAgDHlCUrXAMAAA==
X-CMS-MailID: 20230217145221eucas1p2e040979f83cd8f2223fde78136f9bc9e
X-Msg-Generator: CA
X-RootMTR: 20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e
References: <CGME20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e@eucas1p1.samsung.com>
        <20230203103005.31290-1-p.raghav@samsung.com> <Y+Gsu0PiXBIf8fFU@T590>
        <6035da22-5667-93d5-fe00-62b988425cb5@samsung.com> <Y+nwh7V5xehxMWDR@T590>
        <95506a88-c89c-0f41-3ab4-eb5741410c02@samsung.com>
        <7c28caf6-931e-0a7a-a3c0-e4a430f860ff@kernel.dk>
        <8cc2659b-b7f9-eb8a-e73b-3056b82f159b@samsung.com>
        <db1d7cd7-6c89-7d6b-3fe5-3778bb3cb5e9@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>> +-----------+-----------+--------+--------+
>> | io_uring  | bio(base) | blk-mq | delta  |
>> +-----------+-----------+--------+--------+
>> |   read    |    577    |  446   | -22.7  |
>> | randread  |    504    |  416   | -17.46 |
>> |   write   |    554    |  424   | -23.47 |
>> | randwrite |    484    |  381   | -21.28 |
>> +-----------+-----------+--------+--------+
>>
>> +-----------+-----------+--------+--------+
>> |  libaio   | bio(base) | blk-mq | delta  |
>> +-----------+-----------+--------+--------+
>> |   read    |    412    |  341   | -17.23 |
>> | randread  |    389    |  335   | -13.88 |
>> |   write   |    401    |  329   | -17.96 |
>> | randwrite |    351    |  304   | -13.39 |
>> +-----------+-----------+--------+--------+
> 
> This is pretty much expected, as blk-mq adds a bunch of things that
> brd doesn't really care about. One example of such would be tag
> management.

Got it. That was my conclusion as well.

> My reaction to your initial report wasn't a surprise that blk-mq
> would be slower than bio based for this use case, rather that
> io_uring was slower than libaio.
> 

Yeah! So with nowait option, that isn't the case anymore.

I will park this effort as blk-mq doesn't improve the performance for brd,
and we can retain the submit_bio interface.

Thanks for the input Jens, Christoph and Ming!
