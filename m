Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A04C433F5
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 16:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 177D1610F8
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 16:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhIGQJL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 12:09:11 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39068 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhIGQJG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 12:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631030880; x=1662566880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QAIL1S81CuZ9yBpsaAaSG7R5HOfTLCmzOkoTxYHd+zI=;
  b=E/ie7SFuzNiqyvdDE420SVt9FFh9frqjcCsCnErO8smVAi+VLuSmIlUd
   spthRuyR8eRtwaLFWKIAPHyTTgWV0D53pLoyJTLnnlJYplJjZ5u9VVIcR
   ad2BUr8XjKiFLnee8B2Pjucw2D5zFMcnWt14ldxGSSXcLil2NSL7Vsl1j
   EumLIAWD0HHO/AxMy/oVVPY1z3raqVMnvrhnjEr8wPWv6Cqu8xrTBdS4b
   PIUeDaJHy5nZXPe3Y4U08qaq5/Mh48ypydQl1beFrW9oNc/XT6dG+pF8m
   NF6PTPFLRZAFljfO1VbZfQv192hHKpsk9Vx35CDCHMtOvt9pBYoJHeZux
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,274,1624291200"; 
   d="scan'208";a="283180879"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2021 00:07:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYX3K9YiC77pCvFsLi19WGumk0d3m779oXRrxLQeok+nvmr+PADDxFKdJis8kaVIiqKYZqpdR7l1fAMeG8Lajh96CZbV1gn2cOmDkA4g03xKy9tVwboO20vALS6D+efk1UJBRKtSwGblcPHUewoAARZTZMbbj9GEbYeRrdfinz0H+0Y2FOpqIL3fdqBtPwbKuJdaZgn7bORpY0e7bCapT17Vx3P1VniBSHRxkoP9HX/YKqvkYXGo3YHTl334YN7hPcnJf5nc5otMjxneTZxgeFCW75+5wh3VeUP+uRCKuhqMt30GK3SkcuCJj62WQB59xQGGM7R7z/wNieE/XMERvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fROdlB3pFqL33YVE71n+sa/746B/Qft93v1xH39Bg2U=;
 b=VjihhKmz+mWmcEvf6ll1akIULFY7PrYg5USP+53foa+IZTKt5ar9wS9SucLp2CQzowcYzc5ZwMbIWzNjcs7uMOVrKinCqMEVVQE5EYBPEtlvpAffYhmBz3sWSsU1znv2I2RrMDMN1bZBLzOUKYKmwWwLHqY4s44fpDGIJ+/4AAxHbD6dpigIlUrdZc5io6nFJLLwTS8yr8f43nmnHlE7jWQHUr4SyqhVWjD/jA31GgagbDQhaR5NYR6w2HW15FaV4l+rJ62uSRjR3dwUB9IvQBhltAuTAh6No12YqKrCN4YxD3zF+8xV6Kl9GQYBP+lxr5GqRvmkYaMZWiBreAodSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fROdlB3pFqL33YVE71n+sa/746B/Qft93v1xH39Bg2U=;
 b=JtzVuludNASjxlCe2IxFxQnQ+JSehRp+KT09saxu2MoBuS7VC+Rr250TnIo0PcOgrjysBS9nUJ8MgCpXr3O8SZ97/xrdG+ynPFyv0epSL6UM0msAMOGS2cUJJjmtq2t6QID8+EmgcU14w57Tm9ZalpgkAsGEg13dnTxS1jOBcLQ=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7525.namprd04.prod.outlook.com (2603:10b6:510:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Tue, 7 Sep
 2021 16:07:58 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8%6]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 16:07:57 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Revert "mq-deadline: Fix request accounting"
Thread-Topic: [PATCH 2/2] Revert "mq-deadline: Fix request accounting"
Thread-Index: AQHXo/O2L+LBuS/YJECb1WaT3ju4YKuYqIWAgAAUnIA=
Date:   Tue, 7 Sep 2021 16:07:57 +0000
Message-ID: <YTeOW+GoW/Ps2NXq@x1-carbon>
References: <20210907142145.112096-1-Niklas.Cassel@wdc.com>
 <20210907142145.112096-3-Niklas.Cassel@wdc.com>
 <d544384b-617f-b7a4-f895-72adc900f41b@acm.org>
In-Reply-To: <d544384b-617f-b7a4-f895-72adc900f41b@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff834ed0-96df-427d-8a1b-08d97219a8b2
x-ms-traffictypediagnostic: PH0PR04MB7525:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7525C69C1793706DB79E47ECF2D39@PH0PR04MB7525.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RmMV1hu39kdvyN85RFIGjDtlHYCqI0MarWJ46ffrDSMb38YdQ4X3pl1nxmh/WhuvsfFDWgHpn6jqdC7EhIQzCEFvochiG5j/Gd0XV2ByylOaBsanxCuusnxTn6EDDyPwNkX2yIEARAXuDkonZQukvA/oz0QgZ0v2XUUQZKCdS8XGuDqfr9C96MtNLyCyKCgs0QsO8pfCCS3hfrE2x6VB71BpjBnGJx9JwoQ/x/V9NjW2on0lqrSg+qAZT+MnfDW0UNk9iQk01y0ojfWs4Lxt+LYLPamAfHf/BPYwM1rd9NkPZ4xE4WtFw/AfOvzZJ/xl7EkkYe6ISkyqLZXaEXqy+X0C+qM1FZR3Enc9YNQDqP0eN/kbn6j+TXnyaNJxV1zzosyKJnxrzhFar7VzhaEhl+3dRBPvWCQKmCHfJOty8ISnuCOeFtj7lAChMez1nQgx9bvBuJ5SytKlnVq2mRsbNkfIVxb3NjzNPgKZJwbLr0SYasVBGP4SDcSfMPnxi2foo3hrRufbvOE87H1x4ftZ1CdqorrXg8i4fj0BH4GoEXr72+K/hZY0/4zkDQVCgDe7D9lGmKAvpTy5r7AeG9Mf9lgiZ7uts2G6MviyHZ6S+SI3X7v3Vr9tzA7PkAup8i7EVniPhdy8h6yDJUwFySwwNHkfJv0yEGt4+lMIycRm3xtyoVLLqMKWBv+eyXRCAdqWjatLtduh653wOahtIVPxXlq1R9eWhZ4lSWN0RzqrGTRh7NhJ0xochbJq9oqdjEJoBnoPp9RGvHHUhsR+W2ZYtBgS7B86d4H3+X+kJ0zjaG4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(136003)(39860400002)(396003)(346002)(376002)(6512007)(9686003)(38100700002)(33716001)(66446008)(64756008)(91956017)(8676002)(66946007)(53546011)(6506007)(26005)(76116006)(8936002)(6916009)(4326008)(66556008)(54906003)(66476007)(86362001)(71200400001)(966005)(83380400001)(186003)(2906002)(122000001)(38070700005)(6486002)(5660300002)(316002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uCYm7FXc/LP4CUuxmNCWEzXptW8FEjiIBTJ4TP0gbiUIdHnWO+/4YyQ/g+gs?=
 =?us-ascii?Q?Qysa36zQfzcGki4mD7TeMb2lsHj9Vjnd64loxy92xJrzk8TUx1wgPwl11ozY?=
 =?us-ascii?Q?nHZquei5KrJbXXejfN4TynXBqklKtSslba5VulHekfNfeUpjf5giqB1sxUO4?=
 =?us-ascii?Q?hUNe+vBJevmxrThTwz3c/h0VugTufOrhaUjjVJxQrXqbpf68Jjj+BLaA2NTx?=
 =?us-ascii?Q?QMwGBm5PY45rS2NhKOpOZ4ZFSdZqWyMgiB9YbboCoYSlufKeli3/Y8E6Wly5?=
 =?us-ascii?Q?A/4FokQ99KfX/1tfpsIDoEzn/cjCjQq0Dj0PdU1ZjvK2d6XD/DMLSSC/HsvR?=
 =?us-ascii?Q?HsuUAcuhB+YxqraMJth+HDqQrSzqGkmdDxD2tYkzqJlXuRLfa8xcBHrSVDN7?=
 =?us-ascii?Q?6Ogl3TbH40UUKnwNjKnLo9Urt2VIH4efa2U3cn3e6hmGWa5nwCUsJTxQ/U0a?=
 =?us-ascii?Q?QCaLQyN/7eKUsyLQTiCWAxcZPhEsq8yk3iuEz6We0x1SxK1U6E6HIBC71Phf?=
 =?us-ascii?Q?7VP48ViY3UqEtwO+vWwbYoFEtJqXH9bpJ4eshkx3j5GG2ydXOX4YEGD/BRvk?=
 =?us-ascii?Q?9t4DDnbBBy10jlxRw3fveWLh7CfUS2exQhNQMMIToXn9DcqRwwyCzpKHXkop?=
 =?us-ascii?Q?NIcLSwrG11bA5uYheoAj9tHg5PJQKOG/HbDr522wJQl3cONzo7UyQ2Ia0mMT?=
 =?us-ascii?Q?l5bmr/0Otr0E1PiihME1YCchOdD8mCxofwNWwC7iz1QegjvTKsITnpzm8O/L?=
 =?us-ascii?Q?oSvTJ/mHve/6eAPg94TAbC/U0Nq+3KMhGTIqKeXScId9rDBJ0DOUcHmK8sh/?=
 =?us-ascii?Q?8x7EqmevHDsUj6H0niuTQA4/JpLiAikzKnEztsaltNxo4gLxuwZEYkPL4dkR?=
 =?us-ascii?Q?R+8RE4+Aaa4yhe5THyFiJdT7XgRbuzZPjl7UBAiigVUkaP8HLLMPBbH+5CeV?=
 =?us-ascii?Q?rLpca38oPZYYv8tvUyx+3LIwJGmOAZzYrVlC9PYoAk3vxZpah2sMqHcHZ6L8?=
 =?us-ascii?Q?VMdP7CW0sdpOpJMstbrRBAzMinG8OgNdxQfgbBkVS7hR60Jk55uEoGCqAdyu?=
 =?us-ascii?Q?7ktPS6hH4JndKpv9KzWvzhsgs7+psWSvzNpm9J9TwPwWig+EqQMnn6uc1LYX?=
 =?us-ascii?Q?I18Xndp0TTnigCzdsCpg8JFtB1yXJXYGw86FkEEyfs0yyaGxQYHGa3k0X3sH?=
 =?us-ascii?Q?ET6qWrXqkFzonp/ps5xzsaBinXcdEUrpXydA4BS7Gy/gh2xHQUGXZK5U7vys?=
 =?us-ascii?Q?XLFR4v6g6kBWhN324n72CXUEbnEeLdWRLuO+Vg9qFl00P06f0AEtGh/2Cv9D?=
 =?us-ascii?Q?xOln4df6/9ctuaiBB75EI4NXqB2TmiWkkGSyj16BrmxvYA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E2F03432B74834479D310D66FD0CF990@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff834ed0-96df-427d-8a1b-08d97219a8b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 16:07:57.7885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y+XSYRz4dFf/zDARUK/UEpcNlJ07zzANZqJsWDvOrz9pAeNq6QQuw7P/Rh7KfVmNaRW+tEIHq8COBTam9yuCFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7525
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 07, 2021 at 07:54:09AM -0700, Bart Van Assche wrote:
> On 9/7/21 7:21 AM, Niklas Cassel wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> >=20
> > This reverts commit b6d2b054e8baaee53fd2d4854c63cbf0f2c6262a.
> >=20
> > blk-mq will no longer call the I/O scheduler .finish_request() callback
> > for requests that were never inserted to the I/O scheduler.
> >=20
> > Therefore, we can remove the logic inside mq-deadline that was added to
> > workaround the (no longer existing) quirky behavior of blk-mq.
> >=20
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > ---
> >   block/mq-deadline.c | 16 +++++-----------
> >   1 file changed, 5 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> > index 7f3c3932b723..b2d1e3adcb39 100644
> > --- a/block/mq-deadline.c
> > +++ b/block/mq-deadline.c
> > @@ -678,7 +678,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx =
*hctx, struct request *rq,
> >   	prio =3D ioprio_class_to_prio[ioprio_class];
> >   	dd_count(dd, inserted, prio);
> > -	rq->elv.priv[0] =3D (void *)(uintptr_t)1;
> >   	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
> >   		blk_mq_free_requests(&free);
> > @@ -727,10 +726,12 @@ static void dd_insert_requests(struct blk_mq_hw_c=
tx *hctx,
> >   	spin_unlock(&dd->lock);
> >   }
> > -/* Callback from inside blk_mq_rq_ctx_init(). */
> > +/*
> > + * Nothing to do here. This is defined only to ensure that .finish_req=
uest
> > + * method is called upon request completion.
> > + */
> >   static void dd_prepare_request(struct request *rq)
> >   {
> > -	rq->elv.priv[0] =3D NULL;
> >   }
>=20
> Please take a look at
> https://lore.kernel.org/linux-block/18594aff-4a94-8a48-334c-f21ae32120c6@=
acm.org/
> If dd_prepare_request() is removed I will have to reintroduce it.

dd_prepare_request() itself is not removed, just the
rq->elv.priv[0] =3D NULL; inside dd_prepare_request().

If you need to modify dd_prepare_request() in a future
commit, that should be fine, no?

Without patch 1/2, e->type->ops.requeue_request() can get called
both for requests that bypassed the I/O scheduler, and for requests
that were inserted in the I/O scheduler.

See:
block/blk-mq-sched.h:blk_mq_sched_requeue_request()
If the RQF_ELVPRIV flag is not set, e->type->ops.requeue_request()
will not be called.

Perhaps you are having issues with requests that were inserted
in the scheduler, but later requeued?

If so, shouldn't these fixes help you, since you do not need to
worry about passthrough requests resulting in spurious calls to
the I/O scheduler callbacks?


Kind regards,
Niklas=
