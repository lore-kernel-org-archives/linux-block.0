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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8017C48BDF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 22:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8C5561284
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 22:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhFRWSc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 18:18:32 -0400
Received: from mailout1.w2.samsung.com ([211.189.100.11]:64054 "EHLO
        mailout1.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbhFRWSc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 18:18:32 -0400
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20210618221620usoutp01743f05472056c80e9ef6f2b8ae3df622~JzQlgMdw02200622006usoutp01W;
        Fri, 18 Jun 2021 22:16:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20210618221620usoutp01743f05472056c80e9ef6f2b8ae3df622~JzQlgMdw02200622006usoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624054580;
        bh=sAYI8An98Q0PjkKpinp8KuWKCnkevzGqiD4c2wUnx0U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=SxGKZvsNSH1Eap9jvFIgOL+qDgKaBgePt9uzUd68o4ooMS33aqMFLnq8hhEe2Jdw2
         gLkNVq6oG1FuSxA72qqwADykyrf9zoajnH7/hc+7vfoO4OaTPUY6vpKroB3oj9wAVb
         zWVXONZCI246aCujlQx813SryIIUYORnCwou+wqc=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210618221620uscas1p103df988e5961704517f8e96526658fea~JzQlUzNAZ1674916749uscas1p1W;
        Fri, 18 Jun 2021 22:16:20 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 91.33.20835.43B1DC06; Fri,
        18 Jun 2021 18:16:20 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210618221620uscas1p2266833c00c801255b6072795e07ac2ce~JzQk6MSkP0664906649uscas1p2j;
        Fri, 18 Jun 2021 22:16:20 +0000 (GMT)
X-AuditID: cbfec36d-ce3ff70000015163-62-60cd1b349c74
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 6B.28.26904.33B1DC06; Fri,
        18 Jun 2021 18:16:20 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Fri, 18 Jun 2021 15:16:19 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::255d:1bae:c3ae:e3c3]) by
        SSI-EX1.ssi.samsung.com ([fe80::255d:1bae:c3ae:e3c3%7]) with mapi id
        15.01.2242.008; Fri, 18 Jun 2021 15:16:19 -0700
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
Subject: Re: [PATCH v3 07/16] block/mq-deadline: Remove two local variables
Thread-Topic: [PATCH v3 07/16] block/mq-deadline: Remove two local variables
Thread-Index: AQHXY9s38KhBfb4Pj0yUnrJ6i54yaKsazMKA
Date:   Fri, 18 Jun 2021 22:16:19 +0000
Message-ID: <20210618221619.GA210977@bgt-140510-bm01>
In-Reply-To: <20210618004456.7280-8-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EEE31B0F2B89EA4BA5B3F0E12BF18AD9@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7djXc7om0mcTDM5elbdYfbefzWLah5/M
        FrNuv2axaG3/xmSxZ9EkJouVq48yWdxY8IbR4sn6WcwWf7vuMVnsvaVtcWhyM5MDt8flK94e
        l8+Wemxa1cnmsftmA5vHx6e3WDze77vK5rH5dLXH501yHu0HupkCOKO4bFJSczLLUov07RK4
        MqbeWsBU0C9YsWnyApYGxm6+LkZODgkBE4lJv18xdTFycQgJrGSUuHuijw3CaWWS6D56jwWm
        akHPfBaIxFpGiW0rTkO1fGSUmDr3PDOEc4BRYsb2XWAtbAIGEr+Pb2QGsUUENCS+PVgO1s4s
        sJxZYtXevWBFwgLeEpMO3GaEKPKRaF6+DWgsB5BtJLGyKRAkzCKgKnG+dTdYCa+AqcT+rj9s
        IDangLnEk4dTwMYwCohJfD+1hgnEZhYQl7j1ZD4TxNmCEotm72GGsMUk/u16yAZhK0rc//6S
        HaJeR2LB7k9sIGuZBewkTt3TgwhrSyxb+JoZYq2gxMmZT6AhISlxcMUNsFckBCZzSsycMwdq
        povExAPbofZKS/y9u4wJomgXo8Sc2R9ZIZzDjBKbLixnhKiylrjxsotxAqPKLCSHz0Jy1CyE
        o2YhOWoWkqMWMLKuYhQvLS7OTU8tNsxLLdcrTswtLs1L10vOz93ECEx1p/8dzt3BuOPWR71D
        jEwcjIcYJTiYlUR4OTPPJAjxpiRWVqUW5ccXleakFh9ilOZgURLn/WQ4MV5IID2xJDU7NbUg
        tQgmy8TBKdXAtOV/edaehpJTnn4iVZ7L+KotfffNjF73noOX31PG7TCTedzBRzyrxfXuGCxb
        sLzPR9ZvJsvlyX8/7ylScZlZ8ylBoXvi6Y+cunF9m8V11jxkqTrfNFXqgz93y748fZPU+grx
        uwYPNjR9X5g5+7SAqb9WZegS5mN3NXzv83VOCTRMPqb/z/TsG0Xex3KbP3/tn5D215v5j1td
        Sdi5JlZD0YVG2//VlweejTKW08z5vEGp9dJK80bLydpz57Mx1Tv9Ylate32T++t5IUeno3um
        rQuZ/+d8dNpzq9m5n5Zs+6qx9X+L/W0GDbfw9/9vpa++5t5d3/ujvPDLtB2Pf6XcvTdBbdVh
        DY/lRbpbax/2K7EUZyQaajEXFScCAP/2knHkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsWS2cA0SddE+myCwevnTBar7/azWUz78JPZ
        Ytbt1ywWre3fmCz2LJrEZLFy9VEmixsL3jBaPFk/i9nib9c9Jou9t7QtDk1uZnLg9rh8xdvj
        8tlSj02rOtk8dt9sYPP4+PQWi8f7fVfZPDafrvb4vEnOo/1AN1MAZxSXTUpqTmZZapG+XQJX
        xtRbC5gK+gUrNk1ewNLA2M3XxcjJISFgIrGgZz5LFyMXh5DAakaJD3MvMkI4HxklDk1sYYZw
        DjBK/Jqzlw2khU3AQOL38Y3MILaIgIbEtwfLwdqZBZYzS6zau5cFJCEs4C0x6cBtRogiH4nm
        5duYuhg5gGwjiZVNgSBhFgFVifOtu8FKeAVMJfZ3/WGDWLadUWLhn1WsIAlOAXOJJw+ngM1k
        FBCT+H5qDROIzSwgLnHryXwmiB8EJJbsOc8MYYtKvHz8jxXCVpS4//0lO0S9jsSC3Z/YQG5g
        FrCTOHVPDyKsLbFs4WtmiBsEJU7OfMIC0SopcXDFDZYJjBKzkGybhWTSLIRJs5BMmoVk0gJG
        1lWM4qXFxbnpFcVGeanlesWJucWleel6yfm5mxiBKeL0v8PROxhv3/qod4iRiYPxEKMEB7OS
        CC9n5pkEId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwvoybGCwmkJ5akZqemFqQWwWSZODilGphq
        KuaIx69ys41p370xLqHr4/1VxY8qnt54N+FrFHscw0su3uBC1idsIdZ9sdl65tP/Mt9kfhFX
        0DCzojctvXDdSlfn5wvLhHo7WHg5PLSecsqa7/dLEI7Yr+T5682GphelDo5mwZ7y4UKnFRok
        HO0C5j//GTMx1Vpi7uZ/JXtvL/7dqRSos3nJ421PHG2+aXWH6e95tvrSTU1uQxHethmLPti4
        8l37v0nX+vjJktlNyU0ll6W+KF9Okz203Lmv4kik/MOkEocucbc2B1bxK+8014UL1MW1fvCJ
        LZ95qjfvtOHidfU2FsfXiDxkKb19SiRB8nbsMplkwYblbK5P1vZ8brzr7WQqE8bQ92mnEktx
        RqKhFnNRcSIAIKFScoADAAA=
X-CMS-MailID: 20210618221620uscas1p2266833c00c801255b6072795e07ac2ce
CMS-TYPE: 301P
X-CMS-RootMailID: 20210618004518uscas1p17b741e8806ed8b9c860c6664b58f8626
References: <20210618004456.7280-1-bvanassche@acm.org>
        <CGME20210618004518uscas1p17b741e8806ed8b9c860c6664b58f8626@uscas1p1.samsung.com>
        <20210618004456.7280-8-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 17, 2021 at 05:44:47PM -0700, Bart Van Assche wrote:
> Make __dd_dispatch_request() easier to read by removing two local
> variables.
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
>  block/mq-deadline.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 191ff5ce629c..caa438f62a4d 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -276,7 +276,6 @@ deadline_next_request(struct deadline_data *dd, int d=
ata_dir)
>  static struct request *__dd_dispatch_request(struct deadline_data *dd)
>  {
>  	struct request *rq, *next_rq;
> -	bool reads, writes;
>  	int data_dir;
> =20
>  	lockdep_assert_held(&dd->lock);
> @@ -287,9 +286,6 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd)
>  		goto done;
>  	}
> =20
> -	reads =3D !list_empty(&dd->fifo_list[READ]);
> -	writes =3D !list_empty(&dd->fifo_list[WRITE]);
> -
>  	/*
>  	 * batches are currently reads XOR writes
>  	 */
> @@ -306,7 +302,7 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd)
>  	 * data direction (read / write)
>  	 */
> =20
> -	if (reads) {
> +	if (!list_empty(&dd->fifo_list[READ])) {
>  		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[READ]));
> =20
>  		if (deadline_fifo_request(dd, WRITE) &&
> @@ -322,7 +318,7 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd)
>  	 * there are either no reads or writes have been starved
>  	 */
> =20
> -	if (writes) {
> +	if (!list_empty(&dd->fifo_list[WRITE])) {
>  dispatch_writes:
>  		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[WRITE]));
>=20

Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
