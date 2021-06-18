Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B281C48BE8
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 17:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F55C610C7
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 17:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhFRRLu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 13:11:50 -0400
Received: from mailout1.w2.samsung.com ([211.189.100.11]:15223 "EHLO
        mailout1.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbhFRRLs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 13:11:48 -0400
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20210618170935usoutp018bc7a36319a8e03fbbba3978de04697e~JvEwmx1gl0882008820usoutp01K;
        Fri, 18 Jun 2021 17:09:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20210618170935usoutp018bc7a36319a8e03fbbba3978de04697e~JvEwmx1gl0882008820usoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624036175;
        bh=ZYziCn3cDjW1bOVnZbnsmC7fdCrfrpv2XKHRh9T76U4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=jnmOcZ/AhEJAdBghNPkD7bS3u1nrNquv/Cli8+rOUaedCyrcAekiZLC0VScExDD+6
         4LnE1iXfdcuekoIW4OB5KU8FyHvwrRrNFIyyLNfMdvw0YR8jtWLbjmBwkMtrfUArtY
         MUApAGabEs7+MkS6r37J/e65QJbsgLMeRhfjpyGQ=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210618170935uscas1p1ce7b8621fc09f0873d37ae9f3ee5ef2f~JvEwYXirH0494304943uscas1p1S;
        Fri, 18 Jun 2021 17:09:35 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id AD.1B.20835.F43DCC06; Fri,
        18 Jun 2021 13:09:35 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210618170935uscas1p2c838b6c36300bfb77f86d95d779431c2~JvEwFpvrk1897018970uscas1p2u;
        Fri, 18 Jun 2021 17:09:35 +0000 (GMT)
X-AuditID: cbfec36d-ce3ff70000015163-f4-60ccd34f3d26
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 35.F4.47882.E43DCC06; Fri,
        18 Jun 2021 13:09:35 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Fri, 18 Jun 2021 10:09:34 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::255d:1bae:c3ae:e3c3]) by
        SSI-EX1.ssi.samsung.com ([fe80::255d:1bae:c3ae:e3c3%7]) with mapi id
        15.01.2242.008; Fri, 18 Jun 2021 10:09:34 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Johannes Thumshirn" <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        "Ming Lei" <ming.lei@redhat.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v3 01/16] block/Kconfig: Make the BLK_WBT and BLK_WBT_MQ
 entries consecutive
Thread-Topic: [PATCH v3 01/16] block/Kconfig: Make the BLK_WBT and
        BLK_WBT_MQ entries consecutive
Thread-Index: AQHXY9sx5ooGXE9byEqO/8LTPFlq6Ksadw0A
Date:   Fri, 18 Jun 2021 17:09:34 +0000
Message-ID: <20210618170934.GA89662@bgt-140510-bm01>
In-Reply-To: <20210618004456.7280-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BDFCA3389A218449BD0C388D16459CA1@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djXc7r+l88kGLSdV7BYfbefzWLah5/M
        Fq3t35gs9iyaxGSxcvVRJosbC94wWjxZP4vZ4m/XPSaLvbe0LQ5NbmZy4PK4fMXb4/LZUo9N
        qzrZPHbfbGDz+Pj0FovH+31X2Tw2n672+LxJzqP9QDdTAGcUl01Kak5mWWqRvl0CV8ai29vY
        CibzV/z/Zd7AuJKni5GTQ0LARGL6plmMXYxcHEICKxkl3pxtZIFwWpkkuqbPYO9i5ACr+vA0
        GSK+llFiy/MedgjnI6PE5n9zmSGcA4wSLTN/MoPMZRMwkPh9fCOYLSKgIfHtwXKwscwC35gk
        /k14C5YQFkiSePy2kxVkhYhAskT3RjeIeiOJ6csWsYDYLAKqEk9WXQezeYGuOPn4HFg5p4C5
        xKVvLiBhRgExie+n1jCB2MwC4hK3nsxngnhNUGLR7D3MELaYxL9dD9kgbEWJ+99fskPU60gs
        2P2JDcK2kzj6ZDMrhK0tsWzha2aItYISJ2c+YYHolZQ4uOIG2CsSAt2cEptnfIZa4CIx/eoj
        qMXSEtPXXIYq2sUoMWf2R1YI5zCjxKYLyxkhqqwlbrzsYpzAqDILyeWzkFw1C8lVs5BcNQvJ
        VQsYWVcxipcWF+empxYb5qWW6xUn5haX5qXrJefnbmIEprfT/w7n7mDcceuj3iFGJg7GQ4wS
        HMxKIrycmWcShHhTEiurUovy44tKc1KLDzFKc7AoifN+MpwYLySQnliSmp2aWpBaBJNl4uCU
        amDqWf6Rx6ZBtH5uD+tC3kPxx9YlWd2fvEXhIGPsxlubny64ldRy8Hysrmjd/Neq+1b+fnt5
        Tm/y7LhFlrNlCjJF/laEvFNv9NFZZXKoPHo7e15l2OWN8VV5e6xjWaZaPP8dFMz44B2DzpE5
        m0S8Wh9LbfHvePL4VEuEzKU51XJHNn/Y6GS6vvB+3M4Ha6SVz3EpfhOaNsXAbfPn3FW88wXq
        ZbfzHU48Ih5Y8JSx7NCrpdx9XtUR3R4MJxf+1LrS1TnhxCUexi7v342Tj/y/cbOyJeS6obeY
        z6WHiYYpvLeezX4W2fHaQjryVsyhMOZ/VgnpeyR4DrZnHlthEnx0mv25XYEMRyZO3/7s4bl3
        +RdqlFiKMxINtZiLihMBGCyJgt4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWS2cA0Sdf/8pkEg1u/uCxW3+1ns5j24Sez
        RWv7NyaLPYsmMVmsXH2UyeLGgjeMFk/Wz2K2+Nt1j8li7y1ti0OTm5kcuDwuX/H2uHy21GPT
        qk42j903G9g8Pj69xeLxft9VNo/Np6s9Pm+S82g/0M0UwBnFZZOSmpNZllqkb5fAlbHo9ja2
        gsn8Ff9/mTcwruTpYuTgkBAwkfjwNLmLkYtDSGA1o8StgysZIZyPjBLzDuxmh3AOMErs+rSQ
        uYuRk4NNwEDi9/GNYLaIgIbEtwfLWUCKmAW+MUn8m/AWLCEskCTx+G0nK0RRssTZxj2MELaR
        xPRli1hAbBYBVYknq66D2bxAZ5x8fI4VYtt2Rokt294xgtzHKWAucembC0gNo4CYxPdTa5hA
        bGYBcYlbT+aD2RICAhJL9pxnhrBFJV4+/scKYStK3P/+kh2iXkdiwe5PbBC2ncTRJ5tZIWxt
        iWULXzND3CAocXLmExaIXkmJgytusExglJiFZN0sJKNmIRk1C8moWUhGLWBkXcUoXlpcnJte
        UWycl1quV5yYW1yal66XnJ+7iRGYGE7/Oxyzg/HerY96hxiZOBgPMUpwMCuJ8HJmnkkQ4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkzusROzFeSCA9sSQ1OzW1ILUIJsvEwSnVwHThurK7eovpfh2r
        Hd9lTTQP80s4hL3n1ztrzPkgN9n+Xe6DB5oXXS/7zff20LT/2fDjz/k9HK937Hp3sTmn7IGF
        8yMlJ6v9fekHBA9d9BaYJHv6zGORGReOTd6o7VR2PrBV7u0PvSdR7zauPnRneXl9cMOZDazN
        p5Yd0q1LfnfIRO5Z9NcDi/uzQhtmz+s1meJetFFyRtDBoyzHf3QedFvMKD3hZ9PVUuEflUZ1
        Z+1nu5t/mOq7eXZHevSPGt/bSxd+0G3yUJq+Y+t1D03h3U/0df6lbg67IPuP60vtytfrv3r7
        LW5996RdaNvd1onLFyhKZn87c/DLGnvdC79ul9Tse9tYLB41x32+tGlg7I41SizFGYmGWsxF
        xYkAXa3om3sDAAA=
X-CMS-MailID: 20210618170935uscas1p2c838b6c36300bfb77f86d95d779431c2
CMS-TYPE: 301P
X-CMS-RootMailID: 20210618004508uscas1p1a8a39f3da709875733b77a60ce7d23fe
References: <20210618004456.7280-1-bvanassche@acm.org>
        <CGME20210618004508uscas1p1a8a39f3da709875733b77a60ce7d23fe@uscas1p1.samsung.com>
        <20210618004456.7280-2-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 17, 2021 at 05:44:41PM -0700, Bart Van Assche wrote:
> These entries were consecutive at the time of their introduction but are =
no
> longer consecutive. Make these again consecutive. Additionally, modify th=
e
> help text since it refers to blk-mq and since the legacy block layer has
> been removed.
>=20
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/Kconfig | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/block/Kconfig b/block/Kconfig
> index a2297edfdde8..6685578b2a20 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -133,6 +133,13 @@ config BLK_WBT
>  	dynamically on an algorithm loosely based on CoDel, factoring in
>  	the realtime performance of the disk.
> =20
> +config BLK_WBT_MQ
> +	bool "Enable writeback throttling by default"
> +	default y
> +	depends on BLK_WBT
> +	help
> +	Enable writeback throttling by default for request-based block devices.
> +
>  config BLK_CGROUP_IOLATENCY
>  	bool "Enable support for latency based cgroup IO protection"
>  	depends on BLK_CGROUP=3Dy
> @@ -155,13 +162,6 @@ config BLK_CGROUP_IOCOST
>  	distributes IO capacity between different groups based on
>  	their share of the overall weight distribution.
> =20
> -config BLK_WBT_MQ
> -	bool "Multiqueue writeback throttling"
> -	default y
> -	depends on BLK_WBT
> -	help
> -	Enable writeback throttling by default on multiqueue devices.
> -
>  config BLK_DEBUG_FS
>  	bool "Block layer debugging information in debugfs"
>  	default y

Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
