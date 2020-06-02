Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6848C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 09:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD9F20734
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 09:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kMA3c2rX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TZdCx6Sp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgFBJZG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:25:06 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:18446 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBJZF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jun 2020 05:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591089905; x=1622625905;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=wHeGy27qQ90+M1l+Vc7b4kipWE4yw9HlhKLM+FSf8OI=;
  b=kMA3c2rXjhJ3xpbW7HC8isn79RBXpo/SvlQK+BsWcxIfrArzwWdA52gM
   3tz8cjuVud4TWXS21DmyckXpeh6USm6W7JOgnGFC8k3OHAZUgGWRo+VaN
   2P5ckrdGr/sY1UAwscmdsQ7T0/AL8TPvyvhh98cbQI9pEXwhuH/HVrdjR
   lard5JnC+u+xfVmgSF/DT0A9+xwUQ0BihLbv6Qd/R0U7hkC42tLASzzgH
   bFLvX7e/Pzl7OeCV/EAVGqNWltxhDyE7d9G498g4rOsoFuy7GKifxvjTT
   6HRe8MOrmTQwOUNwXVfJDj8KOViw62yUsWs3mzkcUEE5V9GHiiJf9nYEj
   Q==;
IronPort-SDR: C0aQDB6eE/R4X4j/D4h6GHSloLrG8445ZyFWtS6jBwQIHdrlt5Y9Fn+Jl4oIvq7u9S0j11YnSn
 gPbsoohfmQctDBUSksWHEekBmXDb+9U6j3D40G2lsvZ4n+sCiH4BLhJyrWp+MBKY4ptqQk/YV5
 aU0Z4weuSOto9uHALOHWugWMAirqoM3/ah/zdsL3BZPFqFoiUGQBiAwXZC7GWQ9ox6Vny9YKKl
 FpQvb3UBu1m1yActw+uC7UTXVwgbaKOIgPySBgg955pgZ7xzur3h9AS0z1KLxoChh+++l53YW4
 mBE=
X-IronPort-AV: E=Sophos;i="5.73,463,1583164800"; 
   d="scan'208";a="139336274"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 17:25:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SksIgcMotnu5PNkzZtDvSwmALjCmPTjFAPBLFqovRqlz3JwXXpxz6xdtrxFUNIKOAaxQgSkdxDF3jsPKlxqmukfiPDM75hEfe16t3G8csI1sz/r+oBrFf8Qdkfw5CIQWSWVfGo4oWT4eO9eqvJ4mcA+6iC7qhHfZt/gHwCVEAufWaR+X9EojLInY3I1eDm1IKMYg2lgdCC5wod+rHNOtyciOg6XpnfchZn1P+CJsM+10Xfao28dYLtVuDB73B0GnI6mcgY94TA1cOfj3eFKwamCXDwNUygIk9khs2jWlb9RMSBIyBV3aI7AiZmNiMk+7SbT/HuwCX8sdiq3yV2bvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gL9yYIbISall8Wvb8wU0BfmDlSI+Jmi3W8nIYBktDEc=;
 b=DZqLlTJ6OqCgTL+xqxUJP5UFJV3K7hv0DLb41V8AzTScshKWV3ynjYGUtizfTDgtGj58rQxRHcRpSN9j5BFft/NSUM6HWScgpCZUWumwkanlfNcRxoggeLWjJY4efvKX74xplq3rmuhsHyW/wRUVzn1i+bjOBYdlSHazaR4fKBMaycIZPzMt+xbvz4fe6uGlFLiM29dzipUbeVSuYOBMgUNOjdAM13BUpECt7jUM49wDjKQ9/igUGMWJkRDKK2RCGXCBP+TgmttW1HFVXB5GkytyuwLP4YKGWLmai1iEI6MGxLlTWE2lsYsw5JzK0qBXwpXyK9YhjCZQTwjmeE+XHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gL9yYIbISall8Wvb8wU0BfmDlSI+Jmi3W8nIYBktDEc=;
 b=TZdCx6SphYVHPATLT5By+9x7FKA0o9zVDNZTQN+RaJQk8tSm2EDUiisfHcDc81gVACcPIDLjInwnl+qMA1NPnCJ9O9N2m7cbd4dZMY/0utFfP7xRTgd17CxM+ekrANHvOdMXh0Ej8SlpgP2QoCYOWXgj0j40buW/EPEZtCbANlQ=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 09:25:02 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 09:25:02 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH V4 2/6] blk-mq: pass hctx to blk_mq_dispatch_rq_list
Thread-Topic: [PATCH V4 2/6] blk-mq: pass hctx to blk_mq_dispatch_rq_list
Thread-Index: AQHWOL5iseEcgxJkNk6kYf4/2sZnyQ==
Date:   Tue, 2 Jun 2020 09:25:01 +0000
Message-ID: <CY4PR04MB37517114D6BD53D212D8F0B2E78B0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200602091502.1822499-1-ming.lei@redhat.com>
 <20200602091502.1822499-3-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d922966e-1e3f-462d-6ad0-08d806d6d3e4
x-ms-traffictypediagnostic: CY4PR04MB3751:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB375104BB83DE8EFECC4BB07CE78B0@CY4PR04MB3751.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SxnuZbbxaoYFZgWkGyhP5lcjMmo6i4Cect5sQ6/Lrc/qf5uRavycsZ5aBSBD9kyr7X+KSUGwRns3V+aU6iIbTUbBhxmDUYE5of4wnWv/dRty/evn5ZyRiEQ77XSBFwmTcgykaav2TH5qS9WcT9rP5CwyTgOdcOdL12gDMlk3O8b/nXsb/bsBYGbjWhc3BSg8KlmorKbq4KYl6EKrtoJ+iLs3kcTAFtghn2lUv81ZnqxIeVirC8WAZ/6zSfsYKN0LCe7Kr6wwGaz52ysmU9j2rwp6TS+BVd+6eptYuquIllRB8pguOBjTVpy6ZI7VOcH/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(110136005)(478600001)(26005)(8936002)(5660300002)(8676002)(33656002)(4326008)(83380400001)(316002)(54906003)(66556008)(66446008)(76116006)(66476007)(64756008)(7696005)(91956017)(71200400001)(53546011)(6506007)(86362001)(55016002)(186003)(9686003)(66946007)(2906002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Wqtw2NIcGFOaQ3F87cuXGuIykkB8KF4Lyz6sELyvzZCyq8ApkQ967GM8vK58NyF7LEbDN8yboedYneJgX8nsob1D+9URSCCWr1p2YvcNvDF7rVPHsPwVlq/qKbjWGa5oJjnIBprITJr5P3zWOgvVKuBynIYTwSN665ZOI+gMFzEuBg2t+7UG12uei7Fwd5T+HuBFRBDQh4p5rmizN4Xs3Ss5NH7/IGOxV3W/kY6GexxuJ/DFDKSO9A1KaQ4DbxR1yoAkuTbvYI/9QZ9bPDj/2huwE0Pr9FVI+ipEXOorSbMAum5o2qAmlRMbgpferGucu0nJnOuHiUrLtKZALF9lpSep0lYlDtDy2e8OfRkBjpvsSy5fe39OdLcqXB+LB3QSlDQiHNIOqE7eU4bSyjS8QMe8aiS4hDKmkYMAWlhSi9IpcGdyAR8DGZs9fxjjEWGukvN85wiSHckC7yk0MD4iCDGiK2eV0AOGHfbWgGwRbIrWM+1hy5yaSbOzoLtONYhY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d922966e-1e3f-462d-6ad0-08d806d6d3e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 09:25:01.9235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /w/UgkJhTGKSkF0cG0iCQBcSu04+GWW6khCUj77vNszuTRckgJw4ytDeDEjqwMtm9y8dz1ZNjhP8cy2XX5kLkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB3751
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/02 18:15, Ming Lei wrote:=0A=
> All requests in the 'list' of blk_mq_dispatch_rq_list belong to same=0A=
> hctx, so it is better to pass hctx instead of request queue, because=0A=
> blk-mq's dispatch target is hctx instead of request queue.=0A=
> =0A=
> Cc: Sagi Grimberg <sagi@grimberg.me>=0A=
> Cc: Baolin Wang <baolin.wang7@gmail.com>=0A=
> Cc: Christoph Hellwig <hch@infradead.org>=0A=
> Reviewed-by: Christoph Hellwig <hch@lst.de>=0A=
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>=0A=
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> Tested-by: Baolin Wang <baolin.wang7@gmail.com>=0A=
> Signed-off-by: Ming Lei <ming.lei@redhat.com>=0A=
> ---=0A=
>  block/blk-mq-sched.c | 14 ++++++--------=0A=
>  block/blk-mq.c       |  6 +++---=0A=
>  block/blk-mq.h       |  2 +-=0A=
>  3 files changed, 10 insertions(+), 12 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c=0A=
> index a31e281e9d31..632c6f8b63f7 100644=0A=
> --- a/block/blk-mq-sched.c=0A=
> +++ b/block/blk-mq-sched.c=0A=
> @@ -96,10 +96,9 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_c=
tx *hctx)=0A=
>  	struct elevator_queue *e =3D q->elevator;=0A=
>  	LIST_HEAD(rq_list);=0A=
>  	int ret =3D 0;=0A=
> +	struct request *rq;=0A=
>  =0A=
>  	do {=0A=
> -		struct request *rq;=0A=
> -=0A=
>  		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))=0A=
>  			break;=0A=
>  =0A=
> @@ -131,7 +130,7 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_=
ctx *hctx)=0A=
>  		 * in blk_mq_dispatch_rq_list().=0A=
>  		 */=0A=
>  		list_add(&rq->queuelist, &rq_list);=0A=
> -	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));=0A=
> +	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, true));=0A=
=0A=
Why not use the hctx argument passed to the function instead of rq->mq_hctx=
 ?=0A=
=0A=
>  =0A=
>  	return ret;=0A=
>  }=0A=
> @@ -161,10 +160,9 @@ static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_c=
tx *hctx)=0A=
>  	LIST_HEAD(rq_list);=0A=
>  	struct blk_mq_ctx *ctx =3D READ_ONCE(hctx->dispatch_from);=0A=
>  	int ret =3D 0;=0A=
> +	struct request *rq;=0A=
>  =0A=
>  	do {=0A=
> -		struct request *rq;=0A=
> -=0A=
>  		if (!list_empty_careful(&hctx->dispatch)) {=0A=
>  			ret =3D -EAGAIN;=0A=
>  			break;=0A=
> @@ -200,7 +198,7 @@ static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_ct=
x *hctx)=0A=
>  		/* round robin for fair dispatch */=0A=
>  		ctx =3D blk_mq_next_ctx(hctx, rq->mq_ctx);=0A=
>  =0A=
> -	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));=0A=
> +	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, true));=0A=
=0A=
Same here.=0A=
=0A=
>  =0A=
>  	WRITE_ONCE(hctx->dispatch_from, ctx);=0A=
>  	return ret;=0A=
> @@ -240,7 +238,7 @@ static int __blk_mq_sched_dispatch_requests(struct bl=
k_mq_hw_ctx *hctx)=0A=
>  	 */=0A=
>  	if (!list_empty(&rq_list)) {=0A=
>  		blk_mq_sched_mark_restart_hctx(hctx);=0A=
> -		if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {=0A=
> +		if (blk_mq_dispatch_rq_list(hctx, &rq_list, false)) {=0A=
>  			if (has_sched_dispatch)=0A=
>  				ret =3D blk_mq_do_dispatch_sched(hctx);=0A=
>  			else=0A=
> @@ -253,7 +251,7 @@ static int __blk_mq_sched_dispatch_requests(struct bl=
k_mq_hw_ctx *hctx)=0A=
>  		ret =3D blk_mq_do_dispatch_ctx(hctx);=0A=
>  	} else {=0A=
>  		blk_mq_flush_busy_ctxs(hctx, &rq_list);=0A=
> -		blk_mq_dispatch_rq_list(q, &rq_list, false);=0A=
> +		blk_mq_dispatch_rq_list(hctx, &rq_list, false);=0A=
>  	}=0A=
>  =0A=
>  	return ret;=0A=
> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
> index bcbf49bd7ebe..723bc39507fe 100644=0A=
> --- a/block/blk-mq.c=0A=
> +++ b/block/blk-mq.c=0A=
> @@ -1236,10 +1236,10 @@ static void blk_mq_handle_zone_resource(struct re=
quest *rq,=0A=
>  /*=0A=
>   * Returns true if we did some work AND can potentially do more.=0A=
>   */=0A=
> -bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *=
list,=0A=
> +bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_hea=
d *list,=0A=
>  			     bool got_budget)=0A=
>  {=0A=
> -	struct blk_mq_hw_ctx *hctx;=0A=
> +	struct request_queue *q =3D hctx->queue;=0A=
>  	struct request *rq, *nxt;=0A=
>  	bool no_tag =3D false;=0A=
>  	int errors, queued;=0A=
> @@ -1261,7 +1261,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *=
q, struct list_head *list,=0A=
>  =0A=
>  		rq =3D list_first_entry(list, struct request, queuelist);=0A=
>  =0A=
> -		hctx =3D rq->mq_hctx;=0A=
> +		WARN_ON_ONCE(hctx !=3D rq->mq_hctx);=0A=
>  		if (!got_budget && !blk_mq_get_dispatch_budget(q)) {=0A=
>  			blk_mq_put_driver_tag(rq);=0A=
>  			no_budget_avail =3D true;=0A=
> diff --git a/block/blk-mq.h b/block/blk-mq.h=0A=
> index 21d877105224..d2d737b16e0e 100644=0A=
> --- a/block/blk-mq.h=0A=
> +++ b/block/blk-mq.h=0A=
> @@ -40,7 +40,7 @@ struct blk_mq_ctx {=0A=
>  void blk_mq_exit_queue(struct request_queue *q);=0A=
>  int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);=
=0A=
>  void blk_mq_wake_waiters(struct request_queue *q);=0A=
> -bool blk_mq_dispatch_rq_list(struct request_queue *, struct list_head *,=
 bool);=0A=
> +bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_hea=
d *, bool);=0A=
>  void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,=0A=
>  				bool kick_requeue_list);=0A=
>  void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head=
 *list);=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
