Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3632C433F5
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 12:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B38A661057
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 12:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344525AbhIGNAl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 09:00:41 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:11319 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbhIGNAk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 09:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631019574; x=1662555574;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kdWrR0jAmHeEHr0FzLdO5frhtcLIIjxng6F1lXoEYy8=;
  b=UWYd7ETJWcmipFcOJTcJ/aEGRqJ8m6lyaPEOTTuvuwlGNXyIgbb5YiKy
   L39NJ7BRzGpL1CZZJFy6Hfd5A5+o9sT+fFtLVr7wJe7DEz4Kw62HOgZ/m
   VQTSuhmbkoyckUcnZuSPkoFpHZxNuAg6xjnxisD8vgForNpaF3KqYAP89
   4yYKzACitz7pWudmtFDg73NgvpSk0Xss8n7315ElKg3rXc92pMfo+Dmyr
   onxepqUY/TarWyhjdqyA3NFrOlBXS9VrvL7sDNoUqcVTkT5c5nmhnvmdQ
   Ec/yY+kGFOvAMcejL4epP7wvTRHqUMDOtKfLpPVDd8qk8m+zktbHkbGUK
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,274,1624291200"; 
   d="scan'208";a="184156855"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2021 20:59:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5LPC+MME2KRW3i51ft/PO9sqTM4l3aJoEqGi5G48iZYNOz+B8CeuIqELvClXTDcvcglsttnsoUbI9yQCQQOpCf//J1sJ7AfC8tE80ZGya1KSIqM5ALmi+A8WclvfM1PF+H/0Mh3EeccancujPab7BAq8PDFXJQJ8HdA0SbiFv8MVzG6NfwCLQFNBMpCt6ZUQ1dmdE0t5EKtauTscd/P60fQSQr8E7aTsKnArA/lMGagCVfvYw2cumC8PpmFrL0jOxPwbLiuCEQCQpSXrfwq6P8aklUGpgPYwzTzaxIEPUHcZDM8yvyM6BF++qR3Vn1sUOeVpE4vjm8EoGIPc6jq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bWYBtNDUXNAaVxIsGkkm4u1UB/ZVqqnosrGanu/lSRc=;
 b=EcRwDfpURTvo7Ef44A8Wl4iGStj0/1E+XQQxNPaqY08HsQFsj4ujvDN9IaGL2rPRD6nhX/16YbSkHO2Vdw3Eyle2SPl4w6Oub5h79ZTBVUajTR0hPE9kvD7hnTC01+Vc9D1PFMrVhnK6QEeMzGJmwwUILptq89jWKRHPf6HjyV3ncBfUlAriZ3ryT/tuxSvn+e1FX/V0TbpI4ID3cjlxijMpx+byK5YRVygEhytOCzeCrueLI3FKidkjLUvxzp+kgne2tp3TN5V+yw0DmxHpz7VSgiM8DXkGyP1WmOe0clUhWpneYUPsEvCcTr71rhFUcGZtWJUx8fbxILX4boQ/zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWYBtNDUXNAaVxIsGkkm4u1UB/ZVqqnosrGanu/lSRc=;
 b=oOHxOZdBv6TaHLNd8MMZaGNM8td+ex7pmGx08UTOIDb2rJZ0h3F0DxI8xtqx7FDAgC573r8LkYPaSVx6FLyzArPFRjGaG2IPgv9xZC3hhInCuC6jZe+WO1Eb5TPlQzoFixrKH7J5cS6AMlrEqGouwDDSZlKb/UWoWwpelte3BvU=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7367.namprd04.prod.outlook.com (2603:10b6:510:1c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 7 Sep
 2021 12:59:32 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8%6]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 12:59:32 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] blk-mq: don't call callbacks for requests that
 bypassed the scheduler
Thread-Topic: [RFC PATCH 1/2] blk-mq: don't call callbacks for requests that
 bypassed the scheduler
Thread-Index: AQHXm0DcNbCoMv+LuUuRBM4IFE0DyKuHWDyAgAR5gwCAAAZ3AIAMwawA
Date:   Tue, 7 Sep 2021 12:59:32 +0000
Message-ID: <YTdiMoPNa/10VWSC@x1-carbon>
References: <20210827124100.98112-1-Niklas.Cassel@wdc.com>
 <20210827124100.98112-2-Niklas.Cassel@wdc.com> <YSjoZ/cul4w2l8tG@T590>
 <YSypVLe8vxmA+pUn@x1-carbon> <YSyuwCKi2sS/RaXS@T590>
In-Reply-To: <YSyuwCKi2sS/RaXS@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29eb25a2-b516-4911-a3fd-08d971ff561a
x-ms-traffictypediagnostic: PH0PR04MB7367:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7367AF352CDD4A4A9164F175F2D39@PH0PR04MB7367.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T0wXPmCnat6lqrrEqq4T6EAY4YAtQLht/AEjZ3cjELuLhS4S/eBe4RG5NCnr4hOxhOIVBVMXzwVblMMNWBc7lvns7OR20AMaPvp3zYfRBDtq6YODcoUmPNkto3SdCfCUUUuLVIJgWV4rqFgVygm/Mb7tWxJn2+5BSA4nvtSWvuBaa2Xp11kkJv1Msad0thLKrtL+O+4TqdKZOIeSmzR+cL6NQ2nwH1GxMTFXWbIKoiBtUHoUvZ1njbQGHmWtfLGDcAWGrzDPWc28A3xLMhJB71lbDM13qpkGfGBWijmcPczF7UbTY+stLK+CI7hLzguVnsl0yxkmMlhAqZZ8lRJxGw6PXJplOxPq5autlMZOmoucuAOEibifMleIXbLYnVZIJ0npCL3XY0zTuq6TsZXQpSiqm1hpuPMPRZiRHFimdqwfQeB07FPmzgwa0hPfHWyBFnjwXWsmmhh/oNaFz0V3ObaVyg7WKi1ZMxHMeQ41fAJf3EOTE2X0DCOSOsR99gjJ05rrMgLGrMZj3owz1eOT+LkzjIBXYoWSZQg5UbWsMI0sIv5l1zUvxu/BfE9fhBsMv0mND6Wane+w/K1UhBdTUkCzwusxEIPDKP/CwxYrQAdDEi4MmKEBHgeA9plI/ly/1TuDwSJJOUolmbEgSHQwpD+F0gKHcaJUQo+7TS31QzdlCxkW/rVQvW1TDiO/kc9B/0x18Sde2mXVScWKMTpTng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(376002)(346002)(366004)(136003)(39860400002)(396003)(4326008)(38100700002)(6916009)(5660300002)(66556008)(8676002)(64756008)(66446008)(66476007)(71200400001)(26005)(186003)(91956017)(76116006)(8936002)(6506007)(66946007)(54906003)(6486002)(2906002)(316002)(86362001)(83380400001)(9686003)(478600001)(6512007)(122000001)(33716001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pHBUsIwAcUI+AsOaGFcE+zgqbZlx9x65G47sfPyrH5sW8Rcpc8v4CUnYf1Wm?=
 =?us-ascii?Q?X9oXv9b5FYzUKRp2PQRGb++iQDkLSX/z9AwveVsoW+f29F9UYeq7jjinfYTG?=
 =?us-ascii?Q?zT65nR3CubUUoQxGN8Jx5EolsnS336xipqiw7YGoFSTMaO/h1ySRy+yGYGYu?=
 =?us-ascii?Q?ae82eBnh/Oyg41Vx0l22Duz02wwRxyP3XYdA/GkD5sMZWDCnyjucCzk1CTRK?=
 =?us-ascii?Q?9cxM97vc3pZeHN1sCqchhPg4a3Die/UB/Jg+CcQafHsO55aLkRw0sWxTvs1U?=
 =?us-ascii?Q?4eXq6901E3kkNyB1LfM96NAGbQkuxIYW/Ytk0ruAOU7DTF3i6nrzDjw6R//Y?=
 =?us-ascii?Q?9KBP4HjM5hD0K+JVhKCwVHWIJKNdE5ETLVGrfbqyjW44ECj4BdLSLKH75n/1?=
 =?us-ascii?Q?Ra2BSKQqPndkD1s8QFaGbB0HBDiK8LlovNZapk/Mf7i14ycOcoT2Xf6zClJT?=
 =?us-ascii?Q?7T99/5t3/W+fTOy7+y1s/s9CMRhPld4gNpE4nwDUWZYBod118l3bjI6w10i4?=
 =?us-ascii?Q?yegdzJKd09FKEj+wPoaMdJK3iRy7wdY1HmaMZgF6lmGEvxDva2juyQd6TQp6?=
 =?us-ascii?Q?VHCaQba5AuwX6u+gP7kTVjbAfttYoAelHyGWw4q+s9eobYXK+Idjugyq+3vB?=
 =?us-ascii?Q?qQk602CsS1KXHPQGA96210Q1Iu4kprBgn4rtLwcO9VBjOCSjYa/BpaUGZNDe?=
 =?us-ascii?Q?ZtD3ZQoKWj78CzX4jhCE8luVi+0LSsZoHjqYwfOeH137MXNLChO3fVthi/X6?=
 =?us-ascii?Q?Q4dBfGdkIiuAzSoa/Dp23focFA4ZwmINOtbL7NCgnQEB2fNBBb9+6BmReUbb?=
 =?us-ascii?Q?wItYnq8fQHeQQo++YLx7BYHz+RoryuWP3o6E1JyjctW6LyovJXo8orqbM5VZ?=
 =?us-ascii?Q?O2v7LUJeClLjd9PgTZ+I6SdPY0I4rc3R88uEhdsPAS5z43QYM6NpwSJN8U16?=
 =?us-ascii?Q?gdalS79d5JZycV+S52CPWVgUocgb1LdbTGOQhrxQZeHSgj4wKAAqRrqdoknk?=
 =?us-ascii?Q?0m5+KjbRkY+d4NzDyR03Nek1p3NIArh/xnIwDMC+L1PObB1dePvqi3dsnnbU?=
 =?us-ascii?Q?OPR4IxiHkaL38knCH9xzSh86eUZ83V0AEDs3QWJ+hoT8GletiEtIKtI6IWBi?=
 =?us-ascii?Q?xqsQzIJChqyprTu+vReAK9Z6yDEHEOsRHFEITPdQCgbOhy4rFjqoCHL2GpW6?=
 =?us-ascii?Q?uMvXl57+eYP5r3Z3Eog8qBjQmIpE8xmi2Vs/o8bCAccZnjDMDuJz+jKHB0W+?=
 =?us-ascii?Q?yKvIgG2lv6rHWlRfCrEXwf+ieRAFJ9DFQVaZHtkCX/PHAhaTwsKSCDtJTx+Q?=
 =?us-ascii?Q?kTT0mqUU9nX+cxEOoSXxqs64//2ce9LATBkV/XoEOrVeog=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <83CF8B41F3CAFE4088AFCE48D291926C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29eb25a2-b516-4911-a3fd-08d971ff561a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 12:59:32.3099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJafDJtlZEaCVUSIUQuu+df4Dl7BsWgq+l0DdM3cvAx5g68nfFk6FTrRdpqL1eBdg7AAGRM7iMoLNe8buXL4Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7367
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 30, 2021 at 06:11:12PM +0800, Ming Lei wrote:
> On Mon, Aug 30, 2021 at 09:48:06AM +0000, Niklas Cassel wrote:
> > On Fri, Aug 27, 2021 at 09:28:07PM +0800, Ming Lei wrote:
> > > On Fri, Aug 27, 2021 at 12:41:31PM +0000, Niklas Cassel wrote:
> > > > From: Niklas Cassel <niklas.cassel@wdc.com>
> > > >=20
> > > > Currently, __blk_mq_alloc_request() calls ops.prepare_request and s=
ets
> > > > RQF_ELVPRIV.
> > > >=20
> > > > Therefore, (if the request is not a flush) the RQF_ELVPRIV flag wil=
l be
> > > > set for the request in blk_mq_submit_bio(), regardless if the reque=
st
> > > > was submitted to a scheduler, or bypassed the scheduler.
> > > >=20
> > > > Later, blk_mq_free_request() checks if the RQF_ELVPRIV flag is set,
> > > > if it is, the ops.finish_request callback will be called.
> > > >=20
> > > > The problem with this is that the finish_request scheduler callback
> > > > will be called for requests that bypassed the scheduler.
> > > >=20
> > > > Fix this by calling the scheduler ops.prepare_request callback, and
> > > > set the RQF_ELVPRIV flag only immediately before calling the insert
> > > > callback.
> > >=20
> > > One request could be inserted more than one times, such as requeue,
> > > however __blk_mq_alloc_request() is just run once, so is it fine to
> > > call ->prepare_request more than one time for same request?
> >=20
> > Calling ->prepare_request multiple times is fine.
> > All the different I/O schedulers (BFQ, mq-deadline, kyber)
> > simply use .prepare_request to clear/set elv->priv to a fixed value.
> >=20
> > >=20
> > > Or I am wondering why not call ->prepare_request when the following
> > > check is true?
> > >=20
> > > 	if (e && e->type->ops.prepare_request && !op_is_flush(data->cmd_flag=
s) &&
> > > 		!blk_op_is_passthrough(data->cmd_flags))
> > > 		e->type->ops.prepare_request()
> >=20
> >=20
> > That might work, and might be a nicer solution indeed.
> >=20
> > If a request got plugged, it will be inserted to the scheduler through
> > blk_flush_plug_list() -> blk_mq_flush_plug_list() -> blk_mq_sched_inser=
t_requests()
> > which will insert them unconditionally.
> > In this case. we know that !op_is_flush() (because if it was, blk_mq_su=
bmit_bio()
> > would have inserted directly.)
> >=20
> >=20
> > If we didn't plug, we do blk_mq_sched_insert_request(), which will add =
it if
> > blk_mq_sched_bypass_insert() returns false:
> >=20
> > blk_mq_sched_bypass_insert() is defined as:
> >=20
> >         if ((rq->rq_flags & RQF_FLUSH_SEQ) || blk_rq_is_passthrough(rq)=
)
> >                 return true;
> > Also in this case. we know that !op_is_flush() (blk_mq_submit_bio() wou=
ld have
> > inserted directly.)
> >=20
> >=20
> > So, we could easily add && !blk_op_is_passthrough(data->cmd_flags) to t=
he
> > ->prepare_request condition in blk_mq_rq_ctx_init() like you suggested,
> > but since the bypass condition also seems to look at RQF_FLUSH_SEQ, wou=
ldn't
> > we need to add RQF_FLUSH_SEQ to the condition in blk_mq_rq_ctx_init() a=
s well?
> >=20
> > This flag is set after blk_mq_rq_ctx_init(). Are we sure that RQF_FLUSH=
_SEQ
> > flag will only be set for a request which op_is_flush() returned true?
> >=20
> > (If so, then only adding  && !blk_op_is_passthrough(data->cmd_flags) sh=
ould
> > be fine.)
>=20
> BTW, what I meant is the following change, is it fine?
>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 0a33d16a7298..f98f8cc05644 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -327,20 +327,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk=
_mq_alloc_data *data,
> =20
>  	data->ctx->rq_dispatched[op_is_sync(data->cmd_flags)]++;
>  	refcount_set(&rq->ref, 1);
> -
> -	if (!op_is_flush(data->cmd_flags)) {
> -		struct elevator_queue *e =3D data->q->elevator;
> -
> -		rq->elv.icq =3D NULL;
> -		if (e && e->type->ops.prepare_request) {
> -			if (e->type->icq_cache)
> -				blk_mq_sched_assign_ioc(rq);
> -
> -			e->type->ops.prepare_request(rq);
> -			rq->rq_flags |=3D RQF_ELVPRIV;
> -		}
> -	}
> -
>  	data->hctx->queued++;
>  	return rq;
>  }
> @@ -359,17 +345,25 @@ static struct request *__blk_mq_alloc_request(struc=
t blk_mq_alloc_data *data)
>  	if (data->cmd_flags & REQ_NOWAIT)
>  		data->flags |=3D BLK_MQ_REQ_NOWAIT;
> =20
> -	if (e) {
> +	if (e && !op_is_flush(data->cmd_flags) &&
> +			!blk_op_is_passthrough(data->cmd_flags)) {
>  		/*
>  		 * Flush/passthrough requests are special and go directly to the
>  		 * dispatch list. Don't include reserved tags in the
>  		 * limiting, as it isn't useful.
>  		 */
> -		if (!op_is_flush(data->cmd_flags) &&
> -		    !blk_op_is_passthrough(data->cmd_flags) &&
> -		    e->type->ops.limit_depth &&
> -		    !(data->flags & BLK_MQ_REQ_RESERVED))
> +		if (e->type->ops.limit_depth &&
> +			    !(data->flags & BLK_MQ_REQ_RESERVED))
>  			e->type->ops.limit_depth(data->cmd_flags, data);
> +
> +		rq->elv.icq =3D NULL;
> +		if (e->type->ops.prepare_request) {
> +			if (e->type->icq_cache)
> +				blk_mq_sched_assign_ioc(rq);
> +
> +			e->type->ops.prepare_request(rq);
> +			rq->rq_flags |=3D RQF_ELVPRIV;
> +		}
>  	}
> =20
>  retry:
>=20

Hello Ming,


Sorry for the delayed reply.

Your patch does not compile, because rq is not defined in this function.

Another problem seems to be that in __blk_mq_alloc_request(), at the end
of the function, calls blk_mq_rq_ctx_init(), which will unconditionally
set rq->rq_flags =3D 0;


The simple patch:

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -328,7 +328,8 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq=
_alloc_data *data,
        data->ctx->rq_dispatched[op_is_sync(data->cmd_flags)]++;
        refcount_set(&rq->ref, 1);
=20
-       if (!op_is_flush(data->cmd_flags)) {
+       if (!op_is_flush(data->cmd_flags) &&
+           !blk_op_is_passthrough(data->cmd_flags)) {
                struct elevator_queue *e =3D data->q->elevator;
=20
                rq->elv.icq =3D NULL;



Does appear to solve the problem.

My only worry was RQF_FLUSH_SEQ flag, but as far as I can tell, it is
only ever set for a request that which op_is_flush() returned true.


Kind regards,
Niklas=
