Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EF9C636CC
	for <linux-block@archiver.kernel.org>; Mon, 13 Feb 2023 05:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjBMF4f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 00:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBMF4e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 00:56:34 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BAFC65F
        for <linux-block@vger.kernel.org>; Sun, 12 Feb 2023 21:56:32 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230213055628euoutp0292a8ab83f16354608ee16d72470ce386~DTKw4HwGx1221512215euoutp02m
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 05:56:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230213055628euoutp0292a8ab83f16354608ee16d72470ce386~DTKw4HwGx1221512215euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676267788;
        bh=ISsdTQTeK7liZoz0b/nm3Wln81KqyEZLrQsHUjany6s=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=mHJ8DobXzEPjDBO/ypC4Lfjf/zsPEcqV4qEy0A/uRdvHPCU/lXSSgRSXm0aD3aZdE
         bTlOPJDtkY0w37dL36bw00mz03onw+oQuqElnbj+6BvaK51UjA0MWTQeWYNOqkuQkw
         rkveMdPrhs0Ha1WJ614TdH65EhQSNLW28ZCqX+2s=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230213055628eucas1p24a5ea73a1005027ab04f0fbf207180bc~DTKwjyGjf1315413154eucas1p2h;
        Mon, 13 Feb 2023 05:56:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EE.E5.13597.C01D9E36; Mon, 13
        Feb 2023 05:56:28 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230213055628eucas1p24c29451099073253fef567f34162985e~DTKwROzCK1316913169eucas1p2d;
        Mon, 13 Feb 2023 05:56:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230213055628eusmtrp1d429ebf918c757cdb59682072fcda921~DTKwQuW1Q3271032710eusmtrp1T;
        Mon, 13 Feb 2023 05:56:28 +0000 (GMT)
X-AuditID: cbfec7f4-1f1ff7000000351d-f6-63e9d10c6010
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 26.BB.02722.C01D9E36; Mon, 13
        Feb 2023 05:56:28 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230213055628eusmtip1750ba7df81a0f263100963ad1b3670d1~DTKwIfA7n0336503365eusmtip1b;
        Mon, 13 Feb 2023 05:56:28 +0000 (GMT)
Received: from [192.168.1.19] (106.210.248.32) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 13 Feb 2023 05:56:25 +0000
Message-ID: <6035da22-5667-93d5-fe00-62b988425cb5@samsung.com>
Date:   Mon, 13 Feb 2023 11:26:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.7.1
Subject: Re: [PATCH 0/1] improve brd performance with blk-mq
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <hch@lst.de>, <mcgrof@kernel.org>,
        <gost.dev@samsung.com>, <linux-block@vger.kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <Y+Gsu0PiXBIf8fFU@T590>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.32]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djP87o8F18mG7z7J22x+m4/m8XK1UeZ
        LPbe0ra4MeEpo8Whyc1MDqwel8+Wemxa1cnmsftmA5vH+31X2Tw+b5ILYI3isklJzcksSy3S
        t0vgyrj8eQFjwWyOivP3WpgaGE+zdTFycEgImEg8/wJkcnEICaxglNg8+RZTFyMnkPOFUaJj
        qQZE4jOjxM+v31lBEiANuz+vZ4dILGeU6P/3jBWu6vnFm2wQ7TsZJWYv4gWxeQXsJL6smMIO
        YrMIqEosedPABBEXlDg58wkLiC0qECVx6udrsLiwgI3Eujn7mEFsZgFxiVtP5oPFRQSUJO7e
        Xc0OES+UOLPuBjvIC2wCWhKNnWBhTgEVib55bUwQJZoSrdt/Q5XLS2x/O4cZ4gElib/HprNB
        2LUSp7ZAfCwh8IJDYmprIoTtItGx4BBUXFji1fEt7BC2jMTpyT0sEHa1xNMbv5lBfpcQaAEG
        xM710CC1lug7kwNR4yjReO4JK0SYT+LGW0GIc/gkJm2bzjyBUXUWUkDMQvLwLCQfzELywQJG
        llWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiBieb0v+NfdjAuf/VR7xAjEwfjIUYJDmYl
        EV7hpy+ShXhTEiurUovy44tKc1KLDzFKc7AoifNq255MFhJITyxJzU5NLUgtgskycXBKNTCF
        xGlUKvyITS3kfnRd9nDAHgsf167Pq7Wm9KT8iG/OO98qVZAkbrLrFnNAVsoWiy1Ll/P8ODHz
        tJDhiis56u+66z60z92sfP65rUsqI/NvlujVrl2hG9JCzjHNtWTilq0467S4OSZn07fXk391
        pTm+VFgelrjj/qlLO5h281q8eHHz02bhqn0Oh6OTY+tPs71rmaZaHrU4nWf9eZb1DDYvdnzf
        d/z9tL3Bkx+ffPxlVdZhFhP+97kyO/5IL7f8yrrI/l3neov9R6b1O5XLP3TyTGjZYbTT4IFE
        xKmg5Iycud+tA8Uk12q5HgtSf/omM0nEdu2d+ydniByfwfzmhD/n0+7WL5fn9DZNXnylOvOH
        EktxRqKhFnNRcSIAzAkBOqMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xu7o8F18mG1y8wWWx+m4/m8XK1UeZ
        LPbe0ra4MeEpo8Whyc1MDqwel8+Wemxa1cnmsftmA5vH+31X2Tw+b5ILYI3SsynKLy1JVcjI
        Ly6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy7j8eQFjwWyOivP3Wpga
        GE+zdTFyckgImEjs/ryeHcQWEljKKHF7ljdEXEbi05WP7BC2sMSfa11A9VxANR8ZJX68vgHV
        sJNRonGVHIjNK2An8WXFFLA4i4CqxJI3DUwQcUGJkzOfsIDYogJREqdXrgOrERawkVg3Zx8z
        iM0sIC5x68l8sHoRASWJu3dXs0PECyXOrAPZxQVxXM/W1UBXcHCwCWhJNHaC1XAKqEj0zWtj
        gqjXlGjd/huqV15i+9s5zBAPKEn8PTYd6uFaic9/nzFOYBSdheS8WUjOmIVk1CwkoxYwsqxi
        FEktLc5Nzy021CtOzC0uzUvXS87P3cQIjNFtx35u3sE479VHvUOMTByMhxglOJiVRHiFn75I
        FuJNSaysSi3Kjy8qzUktPsRoCgyjicxSosn5wCSRVxJvaGZgamhiZmlgamlmrCTO61nQkSgk
        kJ5YkpqdmlqQWgTTx8TBKdXAxOfcNXXffAeZPvZ3zGYmXzfs13j84uTWDdWPdyy87iy4ePUd
        GZfMNzmbJj2NNRFIrH3A+mx+LOuNRRGfb1wP02aIfG6hWfX99f5D6iuUCr6Kcy9oOujr+cdo
        ThOH9r3jbYHvb/actv1vfmZOURLjxG3iivt2Hy5MTktfddt2QtgXqRd5fF9a9557W7DOyW1X
        xJaK/eK35yUKKm1897D7HoN8pFjXgqCp8vENC/TXL3AL5d7LMP1WmXs054evOy+vPXzmiUuP
        SgOv1+LCB1s8T/y5c/vN9R2iWtmt/L9iL0ms2uAarB5+YZF51ieGifIXdtx9rvrR8mZN1amr
        XtqG2SZ2ele9Q7cUaUvc3LPuTokSS3FGoqEWc1FxIgDek/WVWgMAAA==
X-CMS-MailID: 20230213055628eucas1p24c29451099073253fef567f34162985e
X-Msg-Generator: CA
X-RootMTR: 20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e
References: <CGME20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e@eucas1p1.samsung.com>
        <20230203103005.31290-1-p.raghav@samsung.com> <Y+Gsu0PiXBIf8fFU@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023-02-07 07:13, Ming Lei wrote:
> On Fri, Feb 03, 2023 at 04:00:05PM +0530, Pankaj Raghav wrote:
>> Hi Jens,
>>  brd is one of the few block drivers that still uses submit_bio instead
>>  of blk-mq framework. The following patch converts brd to start using
>>  blk-mq framework. Performance gains are pretty evident for read workloads.
>>  The performance numbers are also attached as a part of
>>  the commit log.
>>
>>  Performance (WD=[read|randread|write|randwrite]):
>>  $ modprobe brd rd_size=1048576 rd_nr=1
>>  $ echo "none" > /sys/block/ram0/queue/scheduler
>>  $ fio --name=<WD>  --ioengine=io_uring --iodepth=64 --rw=<WD> --size=1G \
>>    --io_size=20G --loop=4 --cpus_allowed=1 --filename=/dev/ram0 --iodepth=64
>>    --direct=[0/1]
>>
>>   --direct=0
> 
> Can you share perf data on other non-io_uring engine often used? The
> thing is that we still have lots of non-io_uring workloads, which can't
> be hurt now.
> 
Sounds good. Does psync and libaio along with io_uring suffice?

> 
> Thanks
> Ming
> 
