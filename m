Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60F4C433DF
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 09:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74FA7206A4
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 09:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VI7A68n+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CwOB9Vzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgFBJcj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:32:39 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22220 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgFBJci (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jun 2020 05:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591090358; x=1622626358;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ooAK5zSxoaAr2fsys5XWjexkMTHB7qPriDFKk7NMFVY=;
  b=VI7A68n+XStenLtpPAeZKDH1dMM2E0FqbVkks+sUeBAiAP4WnBBEaKuN
   l/xXn/AS81iZT9TrfJCl+T5/FjzGo738KJsH9vfNibnbSxDnYCbguWXA0
   +gwGOg8i01PCRTF4njJ+lCfJBMugSakBKEMW8sD5cZxj7iCMWDAMRixq6
   TSRetdt8VhiZJOQ5vYNDLv1T+WDN+Nx9ptmD45SgOGSEqPwk6/Bak40dO
   wqhhA2gGbrnkEXL7a6buUzkKCjCBtAd0C0Jaxq3t7wkj5aZgg6Ps+ORdd
   4oKl7swcpraGes2I5WkB8/tygJGZw6nq8M9Up4L6T6sBQMqgJ8/hdbJLk
   Q==;
IronPort-SDR: FvFpX/wJB1P+fggnzBpk/np+sRHH7lag+c/xWFift/yycDaCWvxitqqzkTIzvvflxCPPIn+p+a
 K/Od74txbobFAbBjhuqUcaVk54ifbmNQ37zsoAHyE0FlFk8SfmBQW9IFRa1Zpe8GQAWe9plBjt
 0gkzcBkDKzKLHgJES6vRpgS9NZL3rOOSC2BQs460UevFGQBdL+mmB2jbOhIPv/qwvFhqlqNlvm
 Y8LwNn7+9vJSCk9VTVlal8NcIlFyM5VucYnzOZgyvl5SYSYB/wzxtXSzkpbWM3y5NYIHxscunF
 OHQ=
X-IronPort-AV: E=Sophos;i="5.73,463,1583164800"; 
   d="scan'208";a="140438748"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 17:32:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMhPjqEUCs4Sm4qSMRR9as7sUTV/TMPh8PEeHQWpd5TR0UIB50pGp6MfDtQE9KPTITeOln/SLW9OI2pIDlz+Y/vbYUkWewG2YcsHuPgMKW9dJIN6wLnLJ1+UU9/IoO/pWizwMPA98vKLkyxYkQR6atVdH+xBdZuOU4HI3U2ERluvP1TXfJWeglqayG/UaEX8m4V3WOoxm3c6zNsBI2p92L40P7SPXGduMoa3bQRIVQ2/jL1JwXERMmy0BB/eqP5jO/hJaKLSVDUYJJJs4jWDTSZBcnfGjS6/TUeOrdlgtlI0P0e0KjLMLW4iU4Aco7mbkcgX1/hd7+BrA9TcDXjjaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2ThbLqiAawuvx/FBCi2GkZo/A8zjWnTbxAZq5Vlmd8=;
 b=IfWnGHcEZbCd/jEnR0cjJyhvdzvkpzMu2KhvWzdY2cObykp2321/+UQRTp9Q1XgVGHxlz+jzK7Oi3mj6fry+KBqkgtULCXvEAcAsQnPMmSJLILFWvFdRrobtrYZSuKWneIPk0lJPmE8aYws+azs/zKMFBnNjXdJaeoZjfPQCXGx88kT862jfOzYJma8v20nXWGKlLOy3ALuCyQ4N5qazHe6SiQ3ah2A2vVCdNnPyh/71LE5xuaB3CBmneCGffWta097lIwHdrzWOoc20o7JVK4ysqINHQskXGTT+qCCt+bWM9f0TWRiDI1MhoeiHmKAka0Z4YtJOVUmkTvlI4AN1ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2ThbLqiAawuvx/FBCi2GkZo/A8zjWnTbxAZq5Vlmd8=;
 b=CwOB9VzvN7xexHttK+vmtQhlZNYludEoAl2xYZnpV1JTKC4rRZ91kRlp1M8Y/QaNONx9iQirA84rVfeQhSCLnQZLE2ac395v5XLKQRzVrKFXO5ZDGdoVWb8anL8XtfNFa0mSljQew35YV5HN5pRmobf+Q90SH3k12ICK7AQTffc=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 09:32:34 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 09:32:34 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH V4 3/6] blk-mq: move getting driver tag and budget into
 one helper
Thread-Topic: [PATCH V4 3/6] blk-mq: move getting driver tag and budget into
 one helper
Thread-Index: AQHWOL5kHk7oTvats0W65pX8Ujt8Yg==
Date:   Tue, 2 Jun 2020 09:32:34 +0000
Message-ID: <CY4PR04MB3751B46EE3CCDA9ABEE829CFE78B0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200602091502.1822499-1-ming.lei@redhat.com>
 <20200602091502.1822499-4-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d347eb78-ccac-47c4-928f-08d806d7e191
x-ms-traffictypediagnostic: CY4PR04MB3751:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB375170BE15972E7736FE3F5EE78B0@CY4PR04MB3751.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HGxoSoeVkXUwFwKu8wHL4Gy7IXJOYm2thXIyryjrTHu1ez+L/n+TQG2DLM0FBNoOcW6vL+slkJ5foPCA0hM8SvKqSYmaECRCwu6dQc2l3GOou3WOB0wzTz+iC3RhLmn4L9GQxApMtQsTHeUy4SVwwYE/btH6UmGQuvQkK9JMcAgZFmTiJ43hDCJwy8Ztl0JapuT4cZXjk+olTZIyF9AEUHlOyG0LQLEhvLN0vTARDiEqWUi47HLgb4m3bBB5nLGG1GgU4X2FNXla0/y5ahDsHKQO6WHmtjXyQOi1rl2Y3q6asuwVAK0IIl+l0FcBxScly9yU1H8tGB92ENUXDk6hmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(110136005)(478600001)(26005)(8936002)(5660300002)(8676002)(33656002)(4326008)(83380400001)(316002)(54906003)(66556008)(66446008)(76116006)(66476007)(64756008)(7696005)(91956017)(71200400001)(53546011)(6506007)(86362001)(55016002)(186003)(9686003)(66946007)(2906002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: PE5pK8eDj8L8rPaTee2nfBqmJGotvBlR9XnaZR0Q247gqPaDADniaAbGe0QabYgLqEd9F7WNXmlcFLnQRIKFZJuvoRqm5ceumzEK1bKL6PNShu09UbBQIZ2kWmI/gtaq4vmtK86aH7GoSCEruyAK769c1i66I7tE/iPHYHritURG9x7sigZpyUaC7/LORsbU/RexcoxBgo+S47Pv4O+tjWkgga6FAqy50i8yGjx/yH/wv5WyHNmPbVbj0kucXtRgXFcqQes6uPPblLQh0UGpCgUBviHeEi+YXYnoP7aVYlQmzBjU8OezXddUIrwaALTK87j5BBQnl6NQsY0IV1K0lxBiZ2wImYV2u4uXiFW8iPRe/P6RfUp3ru7N1SGRz22hFOiUXSTC/BWZ6aIyU5xEZplOPbyugr/aWQoX1B9I9WepaTRSQWQm+pUPofJnmMS27b1b/W6/KVz+AJKvTZ+6N2JilIcGPA0CFV75p7d/mGJ0HKpBPDVXqyO1OSFpKclj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d347eb78-ccac-47c4-928f-08d806d7e191
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 09:32:34.3615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dRrxI7v0FMBhN7+OWnv9Vacz1w45N1bq1nTZer9z++3Xa9YVbAx4fjtzkdkhgG+FvHEvDQt89abnf/qj05lp4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB3751
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/02 18:15, Ming Lei wrote:=0A=
> Move code for getting driver tag and budget into one helper, so=0A=
> blk_mq_dispatch_rq_list gets a bit simplified, and easier to read.=0A=
> =0A=
> Meantime move updating of 'no_tag' and 'no_budget_available' into=0A=
> the branch for handling partial dispatch because that is exactly=0A=
> consumer of the two local variables.=0A=
> =0A=
> Also rename the parameter of 'got_budget' as 'ask_budget'.=0A=
> =0A=
> No functional change.=0A=
> =0A=
> Cc: Sagi Grimberg <sagi@grimberg.me>=0A=
> Cc: Baolin Wang <baolin.wang7@gmail.com>=0A=
> Cc: Christoph Hellwig <hch@infradead.org>=0A=
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>=0A=
> Reviewed-by: Christoph Hellwig <hch@infradead.org>=0A=
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> Tested-by: Baolin Wang <baolin.wang7@gmail.com>=0A=
> Signed-off-by: Ming Lei <ming.lei@redhat.com>=0A=
> ---=0A=
>  block/blk-mq.c | 75 +++++++++++++++++++++++++++++++++-----------------=
=0A=
>  1 file changed, 49 insertions(+), 26 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
> index 723bc39507fe..ee9342aac7be 100644=0A=
> --- a/block/blk-mq.c=0A=
> +++ b/block/blk-mq.c=0A=
> @@ -1233,18 +1233,51 @@ static void blk_mq_handle_zone_resource(struct re=
quest *rq,=0A=
>  	__blk_mq_requeue_request(rq);=0A=
>  }=0A=
>  =0A=
> +enum prep_dispatch {=0A=
> +	PREP_DISPATCH_OK,=0A=
> +	PREP_DISPATCH_NO_TAG,=0A=
> +	PREP_DISPATCH_NO_BUDGET,=0A=
> +};=0A=
> +=0A=
> +static enum prep_dispatch blk_mq_prep_dispatch_rq(struct request *rq,=0A=
> +						  bool ask_budget)=0A=
=0A=
"need_budget" may  be a better argument name instead of ask_budget. More=0A=
reflective of the fact that this is a boolean.=0A=
=0A=
> +{=0A=
> +	struct blk_mq_hw_ctx *hctx =3D rq->mq_hctx;=0A=
> +=0A=
> +	if (ask_budget && !blk_mq_get_dispatch_budget(rq->q)) {=0A=
> +		blk_mq_put_driver_tag(rq);=0A=
> +		return PREP_DISPATCH_NO_BUDGET;=0A=
> +	}=0A=
> +=0A=
> +	if (!blk_mq_get_driver_tag(rq)) {=0A=
> +		/*=0A=
> +		 * The initial allocation attempt failed, so we need to=0A=
> +		 * rerun the hardware queue when a tag is freed. The=0A=
> +		 * waitqueue takes care of that. If the queue is run=0A=
> +		 * before we add this entry back on the dispatch list,=0A=
> +		 * we'll re-run it below.=0A=
> +		 */=0A=
> +		if (!blk_mq_mark_tag_wait(hctx, rq)) {=0A=
> +			/* budget is always obtained before getting tag */=0A=
=0A=
This is clear since it was down a few lines above. Maybe drop this comment =
?=0A=
=0A=
> +			blk_mq_put_dispatch_budget(rq->q);=0A=
> +			return PREP_DISPATCH_NO_TAG;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	return PREP_DISPATCH_OK;=0A=
> +}=0A=
> +=0A=
>  /*=0A=
>   * Returns true if we did some work AND can potentially do more.=0A=
>   */=0A=
>  bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_hea=
d *list,=0A=
>  			     bool got_budget)=0A=
>  {=0A=
> +	enum prep_dispatch prep;=0A=
>  	struct request_queue *q =3D hctx->queue;=0A=
>  	struct request *rq, *nxt;=0A=
> -	bool no_tag =3D false;=0A=
>  	int errors, queued;=0A=
>  	blk_status_t ret =3D BLK_STS_OK;=0A=
> -	bool no_budget_avail =3D false;=0A=
>  	LIST_HEAD(zone_list);=0A=
>  =0A=
>  	if (list_empty(list))=0A=
> @@ -1262,31 +1295,9 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx =
*hctx, struct list_head *list,=0A=
>  		rq =3D list_first_entry(list, struct request, queuelist);=0A=
>  =0A=
>  		WARN_ON_ONCE(hctx !=3D rq->mq_hctx);=0A=
> -		if (!got_budget && !blk_mq_get_dispatch_budget(q)) {=0A=
> -			blk_mq_put_driver_tag(rq);=0A=
> -			no_budget_avail =3D true;=0A=
> +		prep =3D blk_mq_prep_dispatch_rq(rq, !got_budget);=0A=
> +		if (prep !=3D PREP_DISPATCH_OK)=0A=
>  			break;=0A=
> -		}=0A=
> -=0A=
> -		if (!blk_mq_get_driver_tag(rq)) {=0A=
> -			/*=0A=
> -			 * The initial allocation attempt failed, so we need to=0A=
> -			 * rerun the hardware queue when a tag is freed. The=0A=
> -			 * waitqueue takes care of that. If the queue is run=0A=
> -			 * before we add this entry back on the dispatch list,=0A=
> -			 * we'll re-run it below.=0A=
> -			 */=0A=
> -			if (!blk_mq_mark_tag_wait(hctx, rq)) {=0A=
> -				blk_mq_put_dispatch_budget(q);=0A=
> -				/*=0A=
> -				 * For non-shared tags, the RESTART check=0A=
> -				 * will suffice.=0A=
> -				 */=0A=
> -				if (hctx->flags & BLK_MQ_F_TAG_SHARED)=0A=
> -					no_tag =3D true;=0A=
> -				break;=0A=
> -			}=0A=
> -		}=0A=
>  =0A=
>  		list_del_init(&rq->queuelist);=0A=
>  =0A=
> @@ -1339,6 +1350,18 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx =
*hctx, struct list_head *list,=0A=
>  	 */=0A=
>  	if (!list_empty(list)) {=0A=
>  		bool needs_restart;=0A=
> +		bool no_tag =3D false;=0A=
> +		bool no_budget_avail =3D false;=0A=
> +=0A=
> +		/*=0A=
> +		 * For non-shared tags, the RESTART check=0A=
> +		 * will suffice.=0A=
> +		 */=0A=
> +		if (prep =3D=3D PREP_DISPATCH_NO_TAG &&=0A=
> +				(hctx->flags & BLK_MQ_F_TAG_SHARED))=0A=
> +			no_tag =3D true;=0A=
=0A=
You could drop the variable declaration initialization and simply have:=0A=
=0A=
		no_tag =3D prep =3D=3D PREP_DISPATCH_NO_TAG &&=0A=
			(hctx->flags & BLK_MQ_F_TAG_SHARED)=0A=
=0A=
> +		if (prep =3D=3D PREP_DISPATCH_NO_BUDGET)=0A=
> +			no_budget_avail =3D true;=0A=
=0A=
Same here:=0A=
=0A=
		no_budget =3D prep =3D=3D PREP_DISPATCH_NO_BUDGET;=0A=
=0A=
Also to be symmetric with "no_tag", "no_budget" may be a better variable na=
me ?=0A=
=0A=
>  =0A=
>  		/*=0A=
>  		 * If we didn't flush the entire list, we could have told=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
