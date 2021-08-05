Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA0FC4338F
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 20:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E7561104
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 20:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241017AbhHEUim (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Aug 2021 16:38:42 -0400
Received: from mailout1.w2.samsung.com ([211.189.100.11]:20207 "EHLO
        mailout1.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240914AbhHEUil (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Aug 2021 16:38:41 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Aug 2021 16:38:41 EDT
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20210805203116usoutp014a2632d46529d4130f0988bc5465a2f0~YgyjBT_DL2440024400usoutp01R;
        Thu,  5 Aug 2021 20:31:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20210805203116usoutp014a2632d46529d4130f0988bc5465a2f0~YgyjBT_DL2440024400usoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1628195476;
        bh=43tR8Moms8OR3NTFOHoEpq67B8BNRY8gfFAAyg9XIzg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=eH/XNLMFqshRubjD23u+Sgix1JKTWyhZOihv4JPT7szSz+zhB7242deF9g7EC9V3h
         vBy6wRzM5LIil3jude/G03et9DXuZ0FnFWY++usVxsHfh1lZKrula3mQnSyE3lmE2B
         X1FBQ2PJZGJTgvjc/oxy6IRh7JL50vGu5uar+O3M=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210805203116uscas1p2765c0c3ad1845d73fd69c3e67f7402dc~Ygyi6E4aN0235502355uscas1p2L;
        Thu,  5 Aug 2021 20:31:16 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id E6.22.36945.49A4C016; Thu, 
        5 Aug 2021 16:31:16 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210805203115uscas1p2f1e7d2801b60a327b972e8f1f92de576~Ygyikhydj1679616796uscas1p2l;
        Thu,  5 Aug 2021 20:31:15 +0000 (GMT)
X-AuditID: cbfec36d-15d28a8000019051-07-610c4a94c0b6
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id BA.8E.47905.39A4C016; Thu, 
        5 Aug 2021 16:31:15 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Thu, 5 Aug 2021 13:31:15 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::1014:4c20:6d82:fe0e]) by
        SSI-EX1.ssi.samsung.com ([fe80::1014:4c20:6d82:fe0e%7]) with mapi id
        15.01.2242.008; Thu, 5 Aug 2021 13:31:15 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Vincent Fu <vincent.fu@samsung.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] kyber: make trace_block_rq call consistent with
 documentation
Thread-Topic: [PATCH] kyber: make trace_block_rq call consistent with
        documentation
Thread-Index: AQHXiWnSzGvWUauQbEyrvzyTV854v6tl1DAA
Date:   Thu, 5 Aug 2021 20:31:14 +0000
Message-ID: <20210805203114.GA55576@bgt-140510-bm01>
In-Reply-To: <20210804194913.10497-1-vincent.fu@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1FA37E4A9463ED43ABE4856EEC00B194@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZduzred0pXjyJBu/fsVusvtvPZrH3lrYD
        k8fls6UenzfJBTBFcdmkpOZklqUW6dslcGWcebuHrWABV8X+s8uZGxg3cnQxcnJICJhIdOxr
        YOpi5OIQEljJKNG38w47hNPKJHHxx2RWmKpjHz4wQiTWMkr0PN4D5XxglHgz5ysrhLOfUWLx
        7ktsIC1sAgYSv49vZAaxRQTUJQ597wMq4uBgFkiT6J4cBhIWFgiRWPHuJQtESajErOUvWCFs
        I4lpbWvAylkEVCQOHFMFMXmBjvh6XwikglPARmLf693sIDajgJjE91NrmEBsZgFxiVtP5jNB
        3CwosWj2HmYIW0zi366HbBC2osT97y/ZIep1JBbs/sQGYdtJzDqyE8rWlli28DVYLy/QnJMz
        n7BA9EpKHFxxgwXkWwmBmRwSPbM/QC1zkeg50wS1TFri6vWpUPYuRon3l30gGg4zShx/9YgR
        ImEtsfDPeqYJjCqzkBw+C8lRs5AcNQvJUbOQHLWAkXUVo3hpcXFuemqxYV5quV5xYm5xaV66
        XnJ+7iZGYCo5/e9w7g7GHbc+6h1iZOJgPMQowcGsJMKbvJgrUYg3JbGyKrUoP76oNCe1+BCj
        NAeLkjjvJ8OJ8UIC6YklqdmpqQWpRTBZJg5OqQamHMXwBbutpX/9VPifzOh5vaY2uz8o/Z32
        zHet0Tv6PuQ8zLzo37XDRNx+Rnrz+hyhpLdbfi3Yrf9AOIp1rk1HQrnHB5tZfz3sNJ+/WPNF
        /K/EI2Up9YvK6ZnT5ZbmqF77sIpPxb3AX3Dewv+F5aHvFldXP8zVPqvhnMMh8vHfw/08azt+
        nLvc1ZJ4UWSZxhbuzX/vfXbtF2MV9ndOENnD2bVQ9cTaexZHfVz2mDbvL2dObJX8ssgs792y
        inkiWq+2347Sn/hyAf/97DerVC2fXljssFrrfsOBqkKWqr2ugYujjSb51ca9WzUp/+/8C9VL
        t0XV33w2W//C4/nqW19uTd3rLO0Z9crx3+NvBgweSizFGYmGWsxFxYkA0e1bxZQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWS2cA0SXeyF0+iQcNyPYvVd/vZLPbe0nZg
        8rh8ttTj8ya5AKYoLpuU1JzMstQifbsErowzb/ewFSzgqth/djlzA+NGji5GTg4JAROJYx8+
        MHYxcnEICaxmlOj7/pQVwvnAKLHv1Bl2CGc/o8T6j5PYQVrYBAwkfh/fyAxiiwioSxz63gfU
        wcHBLJAm0T05DCQsLBAiseLdSxaQsIhAqMT1hxkQ1UYS09rWgFWzCKhIHDimCmLyAt3w9b4Q
        xKJ+Romm3XvBhnMK2Ejse70bbCmjgJjE91NrmEBsZgFxiVtP5jNB3C8gsWTPeWYIW1Ti5eN/
        rBC2osT97y/ZIep1JBbs/sQGYdtJzDqyE8rWlli28DVYL6+AoMTJmU9YIHolJQ6uuMEygVFi
        FpJ1s5CMmoVk1Cwko2YhGbWAkXUVo3hpcXFuekWxYV5quV5xYm5xaV66XnJ+7iZGYAye/nc4
        cgfj0Vsf9Q4xMnEwHmKU4GBWEuFNXsyVKMSbklhZlVqUH19UmpNafIhRmoNFSZxXyHVivJBA
        emJJanZqakFqEUyWiYNTqoGJ48NlxSNGIt1nzuy7vWVmUs3Flx4LDxk1SN7zPcc812Xi1WLF
        FNnQLplTecVBXO3Xc/e36bbu6565ZErDR8092j9uyczKXqjhnlG1yVv297zz0gE9Gy80uPzL
        3JseE70wmy/a7fdGJeeY0mIJaXE20QVOv5d0yjy8qcXQGvHtmp199YppP1dIxx/vj5ox/1xS
        1tlGr/M27Nk8wec2uHMH9O85uu3YH+Go0GXFSTsuvbRXjWuU4HC3Lbj6RK5brSD19dG5nzLe
        X22yzJk4LXsCr7CQhQKz1IZiqbRuxv+PS/7GnCr36lB5rqy3k+mAQWz4mu0vbno2n1u/3+SA
        pJbvvw77N2Vavm6Bt/0X7lBiKc5INNRiLipOBAANZKqZMAMAAA==
X-CMS-MailID: 20210805203115uscas1p2f1e7d2801b60a327b972e8f1f92de576
CMS-TYPE: 301P
X-CMS-RootMailID: 20210804194924uscas1p2922dc9e7bb44fbfa10abe8157fdd43e1
References: <CGME20210804194924uscas1p2922dc9e7bb44fbfa10abe8157fdd43e1@uscas1p2.samsung.com>
        <20210804194913.10497-1-vincent.fu@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 04, 2021 at 07:49:23PM +0000, Vincent Fu wrote:
> The kyber ioscheduler calls trace_block_rq_insert() *after* the request
> is added to the queue but the documentation for trace_block_rq_insert()
> says that the call should be made *before* the request is added to the
> queue.  Move the tracepoint for the kyber ioscheduler so that it is
> consistent with the documentation.
>=20
> Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
> ---
>  block/kyber-iosched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
> index 81e3279ec..15a8be572 100644
> --- a/block/kyber-iosched.c
> +++ b/block/kyber-iosched.c
> @@ -596,13 +596,13 @@ static void kyber_insert_requests(struct blk_mq_hw_=
ctx *hctx,
>  		struct list_head *head =3D &kcq->rq_list[sched_domain];
> =20
>  		spin_lock(&kcq->lock);
> +		trace_block_rq_insert(rq);
>  		if (at_head)
>  			list_move(&rq->queuelist, head);
>  		else
>  			list_move_tail(&rq->queuelist, head);
>  		sbitmap_set_bit(&khd->kcq_map[sched_domain],
>  				rq->mq_ctx->index_hw[hctx->type]);
> -		trace_block_rq_insert(rq);
>  		spin_unlock(&kcq->lock);
>  	}
>  }
> --=20
> 2.25.1

Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
