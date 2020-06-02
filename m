Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9095DC433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 09:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657D32081A
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 09:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MsriFe5Q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="i45t4h5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFBJpy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:45:54 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20173 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgFBJpw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jun 2020 05:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591091152; x=1622627152;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SMBBaXz5D09dmKrNDpTpV8upT+QuoDC5wddZWSzQM4g=;
  b=MsriFe5QORSZMpCvOjVqKFMeDa+2BdABTZ0xTZnK/AXvpBMbR3zFDORe
   dPcCqg/REh/mM4QYx2wW21LJR84ilcKZx/2CsjwhyxsNLvzA/ncgYn2Ur
   RHgmZDJZRRJhuPjeq5a49s20G7LI348VsSaW6x4q7LhxLLL23SUU77nsO
   Q6NTmNuBRX9gQ3whAL/X0zapxtDY5gk8RjYVMkkbPXWGvkuXUm/Yc3tPI
   9hlEkBOesFOL4KFZ1PV9oEzlM/O4wqkXslQAxCgy6qcR01csuc5PudFB6
   Lkn1fVWoBnpCcfii+qBaDsO1PJ7Xp5aUmOPEG8cX4T4QQMVoWtxCmqaLc
   Q==;
IronPort-SDR: L7JUnPcHevoIiAXPHw32CJjOAbTN4khlu7vUQo2NKRDyxnVWoBE4aCf0z6H2woYXA4xUrsLa9B
 qdaLn5NzsxyNFGLtfzLjJQ3fHIH0QXX6hIa6+TrQtUuzJlJtyHwzT+aW+7omsV07Sa6XLG6yf9
 R1zqU7PUIu9Q2Ukq/ldTt08ZcoAhBusz/FtQZo+2cbQr3zd0cHo0lgkDvzhyWXbRC/FUQiuIRv
 4QLMaBx1UytgOpx6Vr2A2Whek8diIz++DuWKmqrS3SJ9+zhPLcrJz0EBGPQWqrQIdTAjmP6W1L
 9oc=
X-IronPort-AV: E=Sophos;i="5.73,463,1583164800"; 
   d="scan'208";a="139337461"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 17:45:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgGlaLXhyNjnhtUkNXU5gRiaJUmiscM8Y3z9m9rAAHqnZ+6Z3uj8XZiVYl3UcJHzCQZ+Ghyelrmv6ueJ5FDd8k/5nlXjMafnC4LrOCo1dzONtoV+SQDqO/gd+Eiiy9dJjbgJaUmea+LhsGuV+mV9WNarWPGvbSIJRhuTRD302BYaVeua8O4rG0UNdD1I3kjzp+SlMhkc2yw9FiOuixQE5SNMfOAziomENY81ICTj3OEBMeWumOgvAod8nnx32vFmb5HZJkYUQef/6h0SzWx0+Sgh2xbrgGcZ0C4xs1ZAyIcIUepoqjMYkcyT+58sj58SJydR9l1/gKoEPr4eGZUUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHK15Jz0vrMtTAaT+wuRDRHUZYug3zbemFps2AtYSRg=;
 b=euX8DuSdsln2l8Owql/RRjxngBw/vk/phD73J334Sz56CD5gZ6fH8llU4sJ2zhI6GihGb2YJVFt9v5X11yGKTkwQbLKXsRlkOW44HulYCEnF1716i6buGLl3+MuKw6x5xxzxpQT3b1t3UKAYdqjsDKFWno2XqtmoUMqlg4za6yhjXBeNki+mE/Kt0wvTjJiz8r9c65xQZbnuqvrc6QyQNSJXUM87voipzscSIrFIbXQQop5WbCo2Y8mZN08zmXp/PsTR+PwCWYB9iEgyYYm7GLTUZ2Ih/Xf4K4JU9beYDe4EmH/UuDFzO4gd4Nt52YRHuawVT0ocEu1bewGy/TehJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHK15Jz0vrMtTAaT+wuRDRHUZYug3zbemFps2AtYSRg=;
 b=i45t4h5WMlDfWsQqlHjSkyLde03DFw77ZpBtpZQpk++BCq47xw2UIwDODZACx3G4IpEPWEe8w9C6Xd0Wx6TtKE3YUVRAD8sTl0BB/ko+zjCnlLFgCKrvZfo8vLRsxQvoObUSz9Exp3tEprDI0UC7beZmh+dcHllzgGD+Lm2+2Kc=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0439.namprd04.prod.outlook.com (2603:10b6:903:b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 2 Jun
 2020 09:45:48 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 09:45:48 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH V4 5/6] blk-mq: pass obtained budget count to
 blk_mq_dispatch_rq_list
Thread-Topic: [PATCH V4 5/6] blk-mq: pass obtained budget count to
 blk_mq_dispatch_rq_list
Thread-Index: AQHWOL5tXI3XHpMYwE2GgROq8WjpRg==
Date:   Tue, 2 Jun 2020 09:45:48 +0000
Message-ID: <CY4PR04MB37514B91EB542E797A1337D0E78B0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200602091502.1822499-1-ming.lei@redhat.com>
 <20200602091502.1822499-6-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 129f830b-577e-404e-74f1-08d806d9badc
x-ms-traffictypediagnostic: CY4PR04MB0439:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <CY4PR04MB0439FA40353646CD7692C93FE78B0@CY4PR04MB0439.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fwt2VncijNpa8wkqP4T9BUcqWY/XvpwU6FRa59Xmtr3aCHGusmKio9bFerqryPOuO8Pz43kuU/YH3Jnw0fkSqXhlZLOs13xoRbbQx74BtPB812mopeHP81HG3/BMLBs9bYdkMmtb4NVasNO2WWVpJVmQcShUExyYcle333b5CC+lUm4Hpz/ufmVs+d8L17a7IWKOVIvsIf8s+aEBoxk8uSX2mZr1St9buHn+AY/qJ0SYKuWBPACOV4a9YSAWOUsEuWt5ZPLv/F6e/nsf2XYepFH5Cf+Qc7MO22C+jaodnPilJ9ZekNj+Yziuux7wEXSCgD2T+2tEXq3hmnrX9/Hj4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(186003)(2906002)(54906003)(83380400001)(9686003)(478600001)(26005)(110136005)(4326008)(71200400001)(8936002)(316002)(8676002)(6506007)(53546011)(7696005)(66556008)(86362001)(66476007)(66946007)(76116006)(33656002)(91956017)(52536014)(64756008)(5660300002)(66446008)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: f8fg8c3ZEAAhQl/DBsv4wqhzzrK7I6pAgMVTKDnFPPkDwMWbsj3NYp99urRtENJVl775jxM74S81TgVSrRSKVDgicgL6PutlfDmXuGvqAekYzQAyx+/Wts1hfKrYpCW4XfOigT44Q0wO03p590SaZcrgXEgjVq9VWXe8kGLj8HplyL9dBm5bjm9JKkoNorj/l84MyhaVMmVAaympNMl2JJklj5s5CfyRsOmoe2CDLrqji2vIb5aSDpEB929mZ5YFiwt3zU3SXYAnacGva1HJTBoTr+pAelwHzYof3qqBpVqz4+11SkxI1xrz8/fWWP6DalumIhgS9c5siDoPeXfbdY3+K74kF4d/fpkXeekI294jIHfNsfFqsxOJer2wFsDkXaI3hl7ECuahl+GaykXJzy86dHFg1IXm+fN+5PlpCeOXUqeJYoCPBJIjgbc3fEACm9qaNWFeovEtkVW4BvqWsUOgVOsB3vq7PVZbdmDeYUFQIgSKexCLgcSvkrlHYlDe
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129f830b-577e-404e-74f1-08d806d9badc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 09:45:48.4195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XSim8osZDKL0r3Oa4brhJ80Na4bQnYbbJzdcEYL8c0lTjg+5dIcYiMMejVbDlRUH+eP7zMykUK3LxzVsyUNweQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0439
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/02 18:15, Ming Lei wrote:=0A=
> Pass obtained budget count to blk_mq_dispatch_rq_list(), and prepare=0A=
> for supporting fully batching submission.=0A=
> =0A=
> With the obtained budget count, it is easier to put extra budgets=0A=
> in case of .queue_rq failure.=0A=
> =0A=
> Meantime remove the old 'got_budget' parameter.=0A=
> =0A=
> Cc: Sagi Grimberg <sagi@grimberg.me>=0A=
> Cc: Baolin Wang <baolin.wang7@gmail.com>=0A=
> Cc: Christoph Hellwig <hch@infradead.org>=0A=
> Tested-by: Baolin Wang <baolin.wang7@gmail.com>=0A=
> Signed-off-by: Ming Lei <ming.lei@redhat.com>=0A=
> ---=0A=
>  block/blk-mq-sched.c |  8 ++++----=0A=
>  block/blk-mq.c       | 27 +++++++++++++++++++++++----=0A=
>  block/blk-mq.h       |  3 ++-=0A=
>  3 files changed, 29 insertions(+), 9 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c=0A=
> index 632c6f8b63f7..4c72073830f3 100644=0A=
> --- a/block/blk-mq-sched.c=0A=
> +++ b/block/blk-mq-sched.c=0A=
> @@ -130,7 +130,7 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_=
ctx *hctx)=0A=
>  		 * in blk_mq_dispatch_rq_list().=0A=
>  		 */=0A=
>  		list_add(&rq->queuelist, &rq_list);=0A=
> -	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, true));=0A=
> +	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, 1));=0A=
>  =0A=
>  	return ret;=0A=
>  }=0A=
> @@ -198,7 +198,7 @@ static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_ct=
x *hctx)=0A=
>  		/* round robin for fair dispatch */=0A=
>  		ctx =3D blk_mq_next_ctx(hctx, rq->mq_ctx);=0A=
>  =0A=
> -	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, true));=0A=
> +	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, 1));=0A=
>  =0A=
>  	WRITE_ONCE(hctx->dispatch_from, ctx);=0A=
>  	return ret;=0A=
> @@ -238,7 +238,7 @@ static int __blk_mq_sched_dispatch_requests(struct bl=
k_mq_hw_ctx *hctx)=0A=
>  	 */=0A=
>  	if (!list_empty(&rq_list)) {=0A=
>  		blk_mq_sched_mark_restart_hctx(hctx);=0A=
> -		if (blk_mq_dispatch_rq_list(hctx, &rq_list, false)) {=0A=
> +		if (blk_mq_dispatch_rq_list(hctx, &rq_list, 0)) {=0A=
>  			if (has_sched_dispatch)=0A=
>  				ret =3D blk_mq_do_dispatch_sched(hctx);=0A=
>  			else=0A=
> @@ -251,7 +251,7 @@ static int __blk_mq_sched_dispatch_requests(struct bl=
k_mq_hw_ctx *hctx)=0A=
>  		ret =3D blk_mq_do_dispatch_ctx(hctx);=0A=
>  	} else {=0A=
>  		blk_mq_flush_busy_ctxs(hctx, &rq_list);=0A=
> -		blk_mq_dispatch_rq_list(hctx, &rq_list, false);=0A=
> +		blk_mq_dispatch_rq_list(hctx, &rq_list, 0);=0A=
>  	}=0A=
>  =0A=
>  	return ret;=0A=
> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
> index 0e3aab91e6c0..901ef0264e44 100644=0A=
> --- a/block/blk-mq.c=0A=
> +++ b/block/blk-mq.c=0A=
> @@ -1259,7 +1259,8 @@ static enum prep_dispatch blk_mq_prep_dispatch_rq(s=
truct request *rq,=0A=
>  		 */=0A=
>  		if (!blk_mq_mark_tag_wait(hctx, rq)) {=0A=
>  			/* budget is always obtained before getting tag */=0A=
> -			blk_mq_put_dispatch_budget(rq->q);=0A=
> +			if (ask_budget)=0A=
> +				blk_mq_put_dispatch_budget(rq->q);=0A=
>  			return PREP_DISPATCH_NO_TAG;=0A=
>  		}=0A=
>  	}=0A=
> @@ -1267,11 +1268,21 @@ static enum prep_dispatch blk_mq_prep_dispatch_rq=
(struct request *rq,=0A=
>  	return PREP_DISPATCH_OK;=0A=
>  }=0A=
>  =0A=
> +static void blk_mq_release_budgets(struct request_queue *q,=0A=
> +		unsigned int nr_budgets)=0A=
> +{=0A=
> +	int i =3D 0;=0A=
> +=0A=
> +	/* release got budgets */=0A=
> +	while (i++ < nr_budgets)=0A=
=0A=
A for loop would be simpler I think...=0A=
=0A=
> +		blk_mq_put_dispatch_budget(q);=0A=
> +}=0A=
> +=0A=
>  /*=0A=
>   * Returns true if we did some work AND can potentially do more.=0A=
>   */=0A=
>  bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_hea=
d *list,=0A=
> -			     bool got_budget)=0A=
> +			     unsigned int nr_budgets)=0A=
>  {=0A=
>  	enum prep_dispatch prep;=0A=
>  	struct request_queue *q =3D hctx->queue;=0A=
> @@ -1283,7 +1294,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *=
hctx, struct list_head *list,=0A=
>  	if (list_empty(list))=0A=
>  		return false;=0A=
>  =0A=
> -	WARN_ON(!list_is_singular(list) && got_budget);=0A=
> +	WARN_ON(!list_is_singular(list) && nr_budgets);=0A=
>  =0A=
>  	/*=0A=
>  	 * Now process all the entries, sending them to the driver.=0A=
> @@ -1295,7 +1306,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *=
hctx, struct list_head *list,=0A=
>  		rq =3D list_first_entry(list, struct request, queuelist);=0A=
>  =0A=
>  		WARN_ON_ONCE(hctx !=3D rq->mq_hctx);=0A=
> -		prep =3D blk_mq_prep_dispatch_rq(rq, !got_budget);=0A=
> +		prep =3D blk_mq_prep_dispatch_rq(rq, !nr_budgets);=0A=
>  		if (prep !=3D PREP_DISPATCH_OK)=0A=
>  			break;=0A=
>  =0A=
> @@ -1314,6 +1325,12 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx =
*hctx, struct list_head *list,=0A=
>  			bd.last =3D !blk_mq_get_driver_tag(nxt);=0A=
>  		}=0A=
>  =0A=
> +		/*=0A=
> +		 * once the request is queued to lld, no need to cover the=0A=
> +		 * budget any more=0A=
> +		 */=0A=
> +		if (nr_budgets)=0A=
> +			nr_budgets--;=0A=
>  		ret =3D q->mq_ops->queue_rq(hctx, &bd);=0A=
>  		if (ret =3D=3D BLK_STS_RESOURCE || ret =3D=3D BLK_STS_DEV_RESOURCE) {=
=0A=
>  			blk_mq_handle_dev_resource(rq, list);=0A=
> @@ -1353,6 +1370,8 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *=
hctx, struct list_head *list,=0A=
>  		bool no_tag =3D false;=0A=
>  		bool no_budget_avail =3D false;=0A=
>  =0A=
> +		blk_mq_release_budgets(q, nr_budgets);=0A=
> +=0A=
>  		/*=0A=
>  		 * For non-shared tags, the RESTART check=0A=
>  		 * will suffice.=0A=
> diff --git a/block/blk-mq.h b/block/blk-mq.h=0A=
> index d2d737b16e0e..f3a93acfad03 100644=0A=
> --- a/block/blk-mq.h=0A=
> +++ b/block/blk-mq.h=0A=
> @@ -40,7 +40,8 @@ struct blk_mq_ctx {=0A=
>  void blk_mq_exit_queue(struct request_queue *q);=0A=
>  int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);=
=0A=
>  void blk_mq_wake_waiters(struct request_queue *q);=0A=
> -bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_hea=
d *, bool);=0A=
> +bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_hea=
d *,=0A=
> +			     unsigned int);=0A=
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
