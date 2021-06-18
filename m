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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FA8C48BDF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 22:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D73566128C
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 22:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhFRWU7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 18:20:59 -0400
Received: from mailout1.w2.samsung.com ([211.189.100.11]:10321 "EHLO
        mailout1.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbhFRWU5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 18:20:57 -0400
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20210618221847usoutp01016bd7fcebb4f215d8b0a74c96fa7d85~JzStz9A852215622156usoutp01x;
        Fri, 18 Jun 2021 22:18:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20210618221847usoutp01016bd7fcebb4f215d8b0a74c96fa7d85~JzStz9A852215622156usoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624054727;
        bh=SUsmy2QbfkCLkXfhWIm9xevsV9ayVEuyU+ULOZrUCSw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=gG99IVKHyG8IwnJb71RhE9hUFljwutibNw3k2MYGKRsvqR6W9jUaX1wiUEHliiDy3
         vzgLtqPI313W9TUEmwDV87MbgN+QPhauRzKD9ocOCgIfKysVZIvqOoJjVIXVqkpWQL
         ndDj7feT8PhHoffGPdyaKTu11IJLoRKqBcS4Zw3g=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210618221846uscas1p1003ed2b01a56b972e68ccdd29f64073b~JzStaX5-01854118541uscas1p1E;
        Fri, 18 Jun 2021 22:18:46 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 22.A1.53491.6CB1DC06; Fri,
        18 Jun 2021 18:18:46 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210618221846uscas1p24bc0c363096632a414e079767b95a318~JzSs8zelJ2610926109uscas1p2v;
        Fri, 18 Jun 2021 22:18:46 +0000 (GMT)
X-AuditID: cbfec36f-f21ff7000001d0f3-24-60cd1bc66996
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 00.38.26904.5CB1DC06; Fri,
        18 Jun 2021 18:18:46 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Fri, 18 Jun 2021 15:18:45 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::255d:1bae:c3ae:e3c3]) by
        SSI-EX1.ssi.samsung.com ([fe80::255d:1bae:c3ae:e3c3%7]) with mapi id
        15.01.2242.008; Fri, 18 Jun 2021 15:18:45 -0700
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
Subject: Re: [PATCH v3 08/16] block/mq-deadline: Rename dd_init_queue() and
 dd_exit_queue()
Thread-Topic: [PATCH v3 08/16] block/mq-deadline: Rename dd_init_queue() and
        dd_exit_queue()
Thread-Index: AQHXY9s4cPZvoLgrSUiaoEHw/S4hGasazXCA
Date:   Fri, 18 Jun 2021 22:18:45 +0000
Message-ID: <20210618221845.GB210977@bgt-140510-bm01>
In-Reply-To: <20210618004456.7280-9-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C0D8003D6A0A9C40A1340B2102F74B38@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djX87rHpM8mGDyYr2yx+m4/m8W0Dz+Z
        LWbdfs1i0dr+jcliz6JJTBYrVx9lsrix4A2jxZP1s5gt/nbdY7LYe0vb4tDkZiYHbo/LV7w9
        Lp8t9di0qpPNY/fNBjaPj09vsXi833eVzWPz6WqPz5vkPNoPdDMFcEZx2aSk5mSWpRbp2yVw
        ZXw4dpe5YKJAxbTZ1Q2MK3m7GDk4JARMJHa1mnQxcnEICaxklGh+uJgdwmllkuie0wTkcIIV
        tV05yQKRWMso0fN3KiuE85FRom/2QqjMAaD+/VtYQVrYBAwkfh/fyAxiiwhoSHx7sBysiFlg
        ObPEqr17WUASwgKxEn2P1zFCFMVJLFj9mwXCNpL43vqYDcRmEVCV2PrpE9hQXgFTiY3N/8Fq
        OAXMJba9vg5WwyggJvH91BomEJtZQFzi1pP5TBB3C0osmr2HGcIWk/i36yEbhK0ocf/7S3aI
        eh2JBbs/sUHYdhLP1hxnhrC1JZYtfM0MsVdQ4uTMJywQvZISB1fcAHtGQqCbU6Jt0guoZS4S
        H8+sh1ogLfH37jImiKJdjBJzZn9khXAOM0psurCcEaLKWuLGyy7GCYwqs5BcPgvJVbOQXDUL
        yVWzkFy1gJF1FaN4aXFxbnpqsVFearlecWJucWleul5yfu4mRmCyO/3vcP4Oxuu3PuodYmTi
        YDzEKMHBrCTCy5l5JkGINyWxsiq1KD++qDQntfgQozQHi5I4L1PExHghgfTEktTs1NSC1CKY
        LBMHp1QDk6u+3cJKw1ah7Qty//9vWdzzyVHjXahAxp85m8wXN2053jTvj2eN1e2oZWFnEw6J
        718jfrRnFkuZ/DYNe96EU57WNyJ3P638eMg+J3uxRci2/reSDkJHf+00238/1PpxlUvpIb7j
        Chbuq/L7juffqGJREOy4tqAoK/2bz713z7r45tj+3y8p/Fc+eu3uyTMinqz39jf4rMu96yJD
        FG9j5csVd2PD131sLz/TeYKroMf0aq2rwnauRJeOj0ZHzh7X5c9+vEAp4GhXmNQr/wDpLSlt
        Ezp4gqMi5DgWbxTinH/GdtfX8inea+2YVMtPXeJftW+v+scV/k2ZJzK7XWU21a5uL12V/cvd
        9L2YmeB6JZbijERDLeai4kQAonhK4+UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWS2cA0SfeY9NkEg7Mb2S1W3+1ns5j24Sez
        xazbr1ksWtu/MVnsWTSJyWLl6qNMFjcWvGG0eLJ+FrPF3657TBZ7b2lbHJrczOTA7XH5irfH
        5bOlHptWdbJ57L7ZwObx8ektFo/3+66yeWw+Xe3xeZOcR/uBbqYAzigum5TUnMyy1CJ9uwSu
        jA/H7jIXTBSomDa7uoFxJW8XIyeHhICJRNuVkyxdjFwcQgKrGSVm7XjPDOF8ZJT42XIUKnOA
        UeLFlbvMIC1sAgYSv49vBLNFBDQkvj1YDlbELLCcWWLV3r0sIAlhgViJvsfrGCGK4iROvjwP
        ZRtJfG99zAZiswioSmz99IkVxOYVMJXY2Pwfatt2RolLuxeCNXAKmEtse30drIFRQEzi+6k1
        TCA2s4C4xK0n85kgnhCQWLLnPDOELSrx8vE/VghbUeL+95fsEPU6Egt2f2KDsO0knq05zgxh
        a0ssW/iaGeIIQYmTM5+wQPRKShxccYNlAjBIkKybhWTULCSjZiEZNQvJqAWMrKsYxUuLi3PT
        K4qN8lLL9YoTc4tL89L1kvNzNzEC08Tpf4ejdzDevvVR7xAjEwfjIUYJDmYlEV7OzDMJQrwp
        iZVVqUX58UWlOanFhxilOViUxHlfRk2MFxJITyxJzU5NLUgtgskycXBKNTApWSj4pO8Iqg9+
        lqcmc0BNtlUr78EBleBDmRfW7JhrWfmKZW5zRN387VNmmz4Oilkdt2zRDSOmmcsmPz8h+3Tr
        4bTnYmnBO/01vBPUFRn+GzByL/yRlV+9gY37iv/XKPOaTTwndHev/Pb0/+EHwquEmCOSvE9Y
        +jNtrJq4TcH6VHXlI7Hch5azNatb9k44zWBTf9bn9tk5Am85D17ie1h4xUCu+Jp3VclBgTx2
        i3ezo+7YtpTpv18b0j637b8bz4MUhQLnU1/WLt+xODgzr15Xu2LG7gsC5/v6A+fUrYguKdvi
        /3WW1IP42b9LBBzjfT3efPteYdrhXZdvHvqTY5bYM0s2zxUzH2UwdPc9S1BiKc5INNRiLipO
        BACeFQo7ggMAAA==
X-CMS-MailID: 20210618221846uscas1p24bc0c363096632a414e079767b95a318
CMS-TYPE: 301P
X-CMS-RootMailID: 20210618004520uscas1p144aaae523ee3bbb60c8401af8c80ba73
References: <20210618004456.7280-1-bvanassche@acm.org>
        <CGME20210618004520uscas1p144aaae523ee3bbb60c8401af8c80ba73@uscas1p1.samsung.com>
        <20210618004456.7280-9-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 17, 2021 at 05:44:48PM -0700, Bart Van Assche wrote:
> Change "queue" into "sched" to make the function names reflect better the
> purpose of these functions.
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
>  block/mq-deadline.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index caa438f62a4d..d823ba7cb084 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -395,7 +395,7 @@ static struct request *dd_dispatch_request(struct blk=
_mq_hw_ctx *hctx)
>  	return rq;
>  }
> =20
> -static void dd_exit_queue(struct elevator_queue *e)
> +static void dd_exit_sched(struct elevator_queue *e)
>  {
>  	struct deadline_data *dd =3D e->elevator_data;
> =20
> @@ -408,7 +408,7 @@ static void dd_exit_queue(struct elevator_queue *e)
>  /*
>   * initialize elevator private data (deadline_data).
>   */
> -static int dd_init_queue(struct request_queue *q, struct elevator_type *=
e)
> +static int dd_init_sched(struct request_queue *q, struct elevator_type *=
e)
>  {
>  	struct deadline_data *dd;
>  	struct elevator_queue *eq;
> @@ -800,8 +800,8 @@ static struct elevator_type mq_deadline =3D {
>  		.requests_merged	=3D dd_merged_requests,
>  		.request_merged		=3D dd_request_merged,
>  		.has_work		=3D dd_has_work,
> -		.init_sched		=3D dd_init_queue,
> -		.exit_sched		=3D dd_exit_queue,
> +		.init_sched		=3D dd_init_sched,
> +		.exit_sched		=3D dd_exit_sched,
>  	},
> =20
>  #ifdef CONFIG_BLK_DEBUG_FS


Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
