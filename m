Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A64C77B73
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 07:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjDSHnG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 03:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjDSHmb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 03:42:31 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF5A976B
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 00:42:29 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230419074227euoutp01c40be9ee42690d9f6279f0ff15e8e4ea~XRi2FfDxh1325713257euoutp01d
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 07:42:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230419074227euoutp01c40be9ee42690d9f6279f0ff15e8e4ea~XRi2FfDxh1325713257euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681890147;
        bh=5GvSJK95S5DMsxBdDMe2nrPS6uWuFlJMhjWUr98pxNE=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=aX7MbjbTUtWlLF8fzmgs+o/AnmEF8mcuJbT83uNC2sUMLh5bJZu8JhFdWolJh+6OB
         CSrUT4/2/75/j6h1kf6bGgZwhKSnYzeOx5DokdrmK4lfDaF0kD1trrS+HQOnUyO5ZA
         6IijuFT8QaUWSBFcPvQWuTdHYD8XJ4PYbYFbXlGA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230419074226eucas1p1dd4f8813972d3cf522e4d069ec02306d~XRi12U0b10473504735eucas1p1I;
        Wed, 19 Apr 2023 07:42:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 06.61.10014.26B9F346; Wed, 19
        Apr 2023 08:42:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230419074226eucas1p23fa6048fd35f60eec459aac088ce9887~XRi1bonZU0560805608eucas1p20;
        Wed, 19 Apr 2023 07:42:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230419074226eusmtrp2118f73dbe875855682df348ba3003568~XRi1bD8BB2690826908eusmtrp2h;
        Wed, 19 Apr 2023 07:42:26 +0000 (GMT)
X-AuditID: cbfec7f5-b8bff7000000271e-97-643f9b626141
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E1.47.34412.26B9F346; Wed, 19
        Apr 2023 08:42:26 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230419074226eusmtip2dd54e23ce2c231f554a24366f0195af3~XRi1SF6P_1213912139eusmtip2P;
        Wed, 19 Apr 2023 07:42:26 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 19 Apr 2023 08:42:25 +0100
Message-ID: <496ae9b7-576e-5e10-9a20-35827ab4c2c1@samsung.com>
Date:   Wed, 19 Apr 2023 09:42:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] null_blk: allow user to set QUEUE_FLAG_NOWAIT
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Content-Language: en-US
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <0ac55d31-8db4-d645-4528-f0987ca871cb@nvidia.com>
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djPc7pJs+1TDDavM7FYfbefzWLah5/M
        Fu8PPma1+H32PLPF3657TBZ7b2lb7JvlaTFnIZsDh8flK94eLUfesnpcPlvq0dv8js1jZ+t9
        Vo/Pm+Q82g90MwWwR3HZpKTmZJalFunbJXBldDd9Yy2Yxlaxe/FC5gbGdtYuRk4OCQETiauL
        m4FsLg4hgRWMEj+6HrBAOF8YJTYsuccE4XxmlFjy8hoTTMu1ZY1sILaQwHJGidt/AuGKzt36
        yg6R2Mkocb/ZGsTmFbCTOH1lClicRUBV4suiLewQcUGJkzOfsIDYogLREov3TQGzhQXcJG59
        fwd2n4iAnsTVWzfYQRYwC+xglmjtWAq2mVlAXOLWk/lAF3FwsAloSTR2gs3kBNq1auokVogS
        eYntb+cwQxytKDHp5nuon2slTm25BfaZhMBkTomHN99BfeYi8fTvUqgiYYlXxyEOlRCQkfi/
        cz5UTbXE0xu/mSGaWxgl+neuZwM5QkLAWqLvTA6IySygKbF+lz5EuaPEjzu7mCAq+CRuvBWE
        OI1PYtK26cwTGFVnIYXELCSPzULywSyEoQsYWVYxiqeWFuempxYb56WW6xUn5haX5qXrJefn
        bmIEpqXT/45/3cG44tVHvUOMTByMhxglOJiVRHjPuFqlCPGmJFZWpRblxxeV5qQWH2KU5mBR
        EufVtj2ZLCSQnliSmp2aWpBaBJNl4uCUamDKdAnYI9Yp/qvvUMX7I8ZZ6b2CfAaxat2hd9cm
        Xk8J+HfwUlqit9J633spnaYvBN5IKj7m6tj2/vqcrLtzws/vtXtySXFXNwvHlr0+b+2OK1z+
        HDmPyUzNcqqHUuJ/daZguXrud9Vxt9edzAt6U/Uhao2fsUHl0Z8qPjUH9sX25jT9Mpzgw19Z
        e9E37d9f9p+Z5S7L1vy8W2w/W/LdBJ6/kXo3HuUYrlZoyEqefKVZ+XRQB+fLNn+LbfMdWBIb
        DgfUuaxbpHZq97tL5sbb3u9OL/K/dPnkoi15UbosLHNSeyQn7rJKbRbjX+r/cLpV+q223bu7
        1YvmuvLar1p/6LiK4tSW4DkdMZKrJ9sXRCuxFGckGmoxFxUnAgA0pPHtugMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsVy+t/xe7pJs+1TDE6clrRYfbefzWLah5/M
        Fu8PPma1+H32PLPF3657TBZ7b2lb7JvlaTFnIZsDh8flK94eLUfesnpcPlvq0dv8js1jZ+t9
        Vo/Pm+Q82g90MwWwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTm
        ZJalFunbJehldDd9Yy2Yxlaxe/FC5gbGdtYuRk4OCQETiWvLGtm6GLk4hASWMkrcmf6WHSIh
        I7Hxy1WoImGJP9e6oIo+Mkps+PqGEcLZySjxd/ZBFpAqXgE7idNXpoB1swioSnxZtIUdIi4o
        cXLmE7AaUYFoiRvLvzGB2MICbhK3vr8D2yAioCdx9dYNdpChzAI7mCVaO5aygSSEBCYwSdxY
        FApiMwuIS9x6Mh+omYODTUBLorETbD4n0N5VUyexQpRoSrRu/80OYctLbH87hxniA0WJSTff
        Q31TK/H57zPGCYyis5CcNwvJhllIRs1CMmoBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2M
        wJjeduznlh2MK1991DvEyMTBeIhRgoNZSYT3jKtVihBvSmJlVWpRfnxRaU5q8SFGU2AYTWSW
        Ek3OByaVvJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGpskHzHZF
        LZQOL2g6Z/mf59st2/ddqqemrczV+HDry0aznZktMlpbWX9+YDnKd7eldJrDX7ktIrbcc8we
        H0+/favKOJl7m/5M4abtU9P78n5xTFbmPzBxV2Kl7v3lWW/k3OwPBK0Q9u8WKPsTHVje7D5f
        6/RRl4bkOB+fK3Yryo/fM5i01aYjls176sSvH21bioSjG5VDH+9lfpu+3njlv3srql+uEFgU
        /7fPfcODgpnfWY4vm1m0437bgS/XGFiZ+C2+3y3vN/ZzvcSnHnEufXL/ex6muXJOBrJlZ24t
        l9vFmijq8+GLV63jufTFE87vKxb9oLfvbPalHd/sHizb8XLHwxblC09F09cxRWgVeyuxFGck
        GmoxFxUnAgBDbbFCcgMAAA==
X-CMS-MailID: 20230419074226eucas1p23fa6048fd35f60eec459aac088ce9887
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230418114947eucas1p2350d60e2643c11bd01964805ef9baded
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230418114947eucas1p2350d60e2643c11bd01964805ef9baded
References: <20230412084730.51694-1-kch@nvidia.com>
        <20230412084730.51694-2-kch@nvidia.com>
        <CGME20230418114947eucas1p2350d60e2643c11bd01964805ef9baded@eucas1p2.samsung.com>
        <20230418114115.zhcabb5lelbeyyeu@blixen>
        <0ac55d31-8db4-d645-4528-f0987ca871cb@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023-04-18 21:46, Chaitanya Kulkarni wrote:
> On 4/18/23 04:41, Pankaj Raghav wrote:
>>
>> This is not correct. You need to use radix_tree_maybe_preload because
>> GFP_NOWAIT should not block and this WARN_ON_ONCE flag will trigger in
>> radix_tree_preload:
>>
>> /* Warn on non-sensical use... */
>> WARN_ON_ONCE(!gfpflags_allow_blocking(gfp_mask));
>>
>> I also verified this locally with your patch and while doing a simple fio
>> write with setting memory_backed=1.
>>
>>
> 
> plz share the exact fio job you have used to generate this error,
> I need add that to the patch testlog.
> 
This should do it:

$ modprobe null_blk nowait=1 queue_mode=0 memory_backed=1
$ fio -iodepth=1 -rw=write -ioengine=io_uring -size=2M -name=io_uring_1  -filename=/dev/nullb0

