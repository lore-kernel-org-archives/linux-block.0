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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B33C48BE8
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 22:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35332613B4
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 22:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbhFRWL3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 18:11:29 -0400
Received: from mailout2.w2.samsung.com ([211.189.100.12]:41713 "EHLO
        mailout2.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbhFRWL2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 18:11:28 -0400
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20210618220918usoutp02381bacbb3fb807a55c4db1f8bdf7948c~JzKb2999C1581915819usoutp02a;
        Fri, 18 Jun 2021 22:09:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20210618220918usoutp02381bacbb3fb807a55c4db1f8bdf7948c~JzKb2999C1581915819usoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624054158;
        bh=GxK81MIa8tnHtiss/E3b4tLjXnllwJQVnZIqM4ZoLdA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=IQZasfg2CGdhr3Jno/LkBXsgPoksMMHQGd1UojpThJ/Am7ru324/0vnAlFtgWXY3o
         EhUF3YvSwycVTxIKhS76AgksE7qJer/dHGPL0piXHnai7qEQzu5YZmxUI7bvJ42gqx
         u9H4g1+ZtwX/N2FXgyI7I77mSFpVYPOzG+O/EBtg=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210618220917uscas1p1641c1db8e05b0c8084e65c3f24698068~JzKbr-kK02384223842uscas1p1X;
        Fri, 18 Jun 2021 22:09:17 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 4D.E0.53491.D891DC06; Fri,
        18 Jun 2021 18:09:17 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210618220917uscas1p2b7ac4488f7322e8ba5f460ed5e51d565~JzKbSY0Qk3175131751uscas1p2V;
        Fri, 18 Jun 2021 22:09:17 +0000 (GMT)
X-AuditID: cbfec36f-f09ff7000001d0f3-93-60cd198d3fa0
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 53.18.48268.D891DC06; Fri,
        18 Jun 2021 18:09:17 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Fri, 18 Jun 2021 15:09:16 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::255d:1bae:c3ae:e3c3]) by
        SSI-EX1.ssi.samsung.com ([fe80::255d:1bae:c3ae:e3c3%7]) with mapi id
        15.01.2242.008; Fri, 18 Jun 2021 15:09:16 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        "Damien Le Moal" <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        "Johannes Thumshirn" <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 06/16] block/mq-deadline: Add two
 lockdep_assert_held() statements
Thread-Topic: [PATCH v3 06/16] block/mq-deadline: Add two
        lockdep_assert_held() statements
Thread-Index: AQHXY9s2MAp/F9oD/kugmc06gKgLaqsaysoA
Date:   Fri, 18 Jun 2021 22:09:16 +0000
Message-ID: <20210618220916.GC210778@bgt-140510-bm01>
In-Reply-To: <20210618004456.7280-7-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CD8DA458A9649E469265C3856869BC3D@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsWy7djXc7q9kmcTDLrfGFisvtvPZjHtw09m
        i1m3X7NYtLZ/Y7LYs2gSk8XK1UeZLG4seMNo8WT9LGaLv133mCz23tK2ODS5mcmB2+PyFW+P
        y2dLPTat6mTz2H2zgc3j49NbLB7v911l89h8utrj8yY5j/YD3UwBnFFcNimpOZllqUX6dglc
        GRcXbWUsmM5bcWvXJsYGxt9cXYycHBICJhKPl+1l62Lk4hASWMkocXTBHEYIp5VJ4s7HPSww
        VW+f3WOCSKxllNg3+w8zhPORUaJ532cWCOcAUP/MS0wgLWwCBhK/j29kBrFFBDQkvj1YDlbE
        LLCcWWLV3r1gc4UFoiXWvtzIClEUI7Fm4j8mCNtI4sq0Y2A2i4CqxKIFLWwgNq+AqcSsqysZ
        QWxOAXOJizMPgMUZBcQkvp9aA1bPLCAucevJfCaIuwUlFs3ewwxhi0n82/WQDcJWlLj//SU7
        RL2OxILdn9ggbDuJ3a83QtnaEssWvmaG2CsocXLmE2hYSEocXHED7BkJgX5OiTfzm4CKOIAc
        F4lPz+UgaqQlrl6fygxRs4tRYs7sj6wQzmFGiU0XljNCVFlL3HjZxTiBUWUWksNnITlqFpKj
        ZiE5ahaSoxYwsq5iFC8tLs5NTy02ykst1ytOzC0uzUvXS87P3cQITHen/x3O38F4/dZHvUOM
        TByMhxglOJiVRHg5M88kCPGmJFZWpRblxxeV5qQWH2KU5mBREudlipgYLySQnliSmp2aWpBa
        BJNl4uCUamByUl3o8aDMQ5NX/ami8n832YLLUq+Tn/7caWqyKFqkXf1sRmbn9TkvFmWHCE44
        w7A5uPnzj/4bUzaaPD9y+KnggcW7jonuqZfJtg8pdsw+Zx0zkSnN+m29s2DW+Vt7eI7bds73
        Lb5246yJAX+zOmelR+oM1eMTHsiHLey7qX8pYNUZgSPf1/Qzf2L4sXab30TO1d++azgdfqEr
        dmT/ybJpe7+bRVZm3Z3w72Sj54V7Eup3m+zubH7Jp1o4YXP7dxtWI6NgIZYljziPVF3mmXje
        SYXpyql/kU2P13Owx1z7NL/SNOGOWpKo2MYPKdFHjec+Z8l9dHXd+Uu5D3fe3j01fvfcf2F+
        C3Qdt/7qLLxjqcRSnJFoqMVcVJwIAGmkNNfmAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWS2cA0SbdX8myCwd6n4har7/azWUz78JPZ
        Ytbt1ywWre3fmCz2LJrEZLFy9VEmixsL3jBaPFk/i9nib9c9Jou9t7QtDk1uZnLg9rh8xdvj
        8tlSj02rOtk8dt9sYPP4+PQWi8f7fVfZPDafrvb4vEnOo/1AN1MAZxSXTUpqTmZZapG+XQJX
        xsVFWxkLpvNW3Nq1ibGB8TdXFyMnh4SAicTbZ/eYuhi5OIQEVjNKHPt/gQXC+cgocefNWXYI
        5wCjxOvfOxlBWtgEDCR+H9/IDGKLCGhIfHuwHKyDWWA5s8SqvXtZQBLCAtESu9r2MUEUxUjM
        7PoOZRtJXJl2DMxmEVCVWLSghQ3E5hUwlZh1dSUjxLbtjBK3Tu5lB0lwCphLXJx5AKyIUUBM
        4vupNWDNzALiEreezGeCeEJAYsme88wQtqjEy8f/WCFsRYn731+yQ9TrSCzY/YkNwraT2P16
        I5StLbFs4WtmiCMEJU7OfMIC0SspcXDFDZYJjBKzkKybhWTULCSjZiEZNQvJqAWMrKsYxUuL
        i3PTK4oN81LL9YoTc4tL89L1kvNzNzECE8Xpf4cjdzAevfVR7xAjEwfjIUYJDmYlEV7OzDMJ
        QrwpiZVVqUX58UWlOanFhxilOViUxHmFXCfGCwmkJ5akZqemFqQWwWSZODilGpgY1l+6o/5u
        RbrB0u6u1frGvyqCN3/Yu3TDkz07YptCpNalSWlsj9ggu2yB2uGL0zndE3uTU4/1ccn96a79
        OYPf9MStMwEhR7q2HamfnVi9NWrC74inCzmfxM2uznq8Wt+7wWiO+K44kS2xkhLrrzks7otU
        SdR4lvgkd7HdXl3urW+mbZ7HYyz4jcNh9gaV6lJf4/+bFRc0smonBvRssG3l0+Te3dD8cqO0
        6PaOy7E5cX1aMf8kK33PvI09un3roWc6p/p4k59o+gdt6klPjL+wyejCYnb1g473sy7r7r32
        +7Vn8b/vHHxCh81Ndyj8sNXetSPm4+7VbAeq+v7HZJsLeYZJ/lwq88QuZMZufkslluKMREMt
        5qLiRACsHN26gwMAAA==
X-CMS-MailID: 20210618220917uscas1p2b7ac4488f7322e8ba5f460ed5e51d565
CMS-TYPE: 301P
X-CMS-RootMailID: 20210618004517uscas1p2f3b8ae04467aeb436c678b4ba21d8de9
References: <20210618004456.7280-1-bvanassche@acm.org>
        <CGME20210618004517uscas1p2f3b8ae04467aeb436c678b4ba21d8de9@uscas1p2.samsung.com>
        <20210618004456.7280-7-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 17, 2021 at 05:44:46PM -0700, Bart Van Assche wrote:
> Document the locking strategy by adding two lockdep_assert_held()
> statements.
>=20
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 31418e9ce9e2..191ff5ce629c 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -279,6 +279,8 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd)
>  	bool reads, writes;
>  	int data_dir;
> =20
> +	lockdep_assert_held(&dd->lock);
> +
>  	if (!list_empty(&dd->dispatch)) {
>  		rq =3D list_first_entry(&dd->dispatch, struct request, queuelist);
>  		list_del_init(&rq->queuelist);
> @@ -501,6 +503,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *h=
ctx, struct request *rq,
>  	struct deadline_data *dd =3D q->elevator->elevator_data;
>  	const int data_dir =3D rq_data_dir(rq);
> =20
> +	lockdep_assert_held(&dd->lock);
> +
>  	/*
>  	 * This may be a requeue of a write request that has locked its
>  	 * target zone. If it is the case, this releases the zone lock.

Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
