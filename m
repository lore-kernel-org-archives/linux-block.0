Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7D5C4360C
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 17:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F93207FF
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 17:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Uf7IIPmZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Fjbwifw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfI0R1U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 13:27:20 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44876 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfI0R1U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 13:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1569605239; x=1601141239;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=//5yS9QmXYtFwYRISUdNDorWL6ZUeu3TNTLvusD1r8g=;
  b=Uf7IIPmZdJ8gYTYhBbR7U1eosiF7w2eApOKizC9MgjFAeJ4oBZMSYkQ6
   KX/0nEq02dta3KwStidBDEpG/vm4hqHCwdt+ILylgvfIThfBwY6gBIP6w
   9jh0kFpu8i3WuHmOX1Cn26IXM3voPSdMA9xSOEaPsb+ejfAEGk0+H6fTQ
   VzAM8z6jZC1+j3iH4nqmKX5ZN/0DLvxL0PWKVbL8/zzvXJPyIgP8b982g
   K8thNdcensl181/+io4+/ToDZhKsuIOpcb//wHv9al8Dn/lEJE29dvhwj
   hNzYUovpEISiA4m3J1JlUIaqMJX4Z61/XwFh4QnNNEQ20zdbzHXC6OFkX
   g==;
IronPort-SDR: qk43hx0xc5174CTEflCGA1gRDvCD9dN5TzzPnuUZSTL6VAh0+VDxsQcGYwo9y+FRCPC+FPPXyc
 EXsI8wv8SnY7o9pJ+SkX4rW27NbP3MTnqmk9iUrkDOeC9AbG4eHpI4oxRWtDjHQrljXdl5yX0X
 52Bs50tlwbKNjkn8HbwoGn7SbD7ATGDyDpFBr9v/ca2QYsUlu/wU0b2Cs9cUfUDYm1dOTULiSz
 zBK1kfcDpaXI2Jmh1huVJCutzY1Gq8RfzHeT5S1tAakPlXNXveQqPQ6YjUizl7bteg+/XExGVD
 Hf0=
X-IronPort-AV: E=Sophos;i="5.64,556,1559491200"; 
   d="scan'208";a="119290015"
Received: from mail-dm3nam05lp2050.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.50])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2019 01:27:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1AyqaiYCkMGuMpyj4DNbwaSnPu6hJSyHDosQQJbJCcNZccZY2gRiLdD938drk4Rq1pOOHnhVTd+m/MnGBfEcRuXO2wXoPBxNmdY0gmY8CaVSBxB2mq7zjPCoxj/4ZdMLprcP7XkYAe6IQivH5d9sInTNVWSW0307JAxF5AxAF7+DuLGkRopDKikTYfs02oy75E/7JC49011Ktde2qL8BzHUWpdMn0xzlhY/ZspXdqI4XBUYBteJY7P78Q4t5M9tMTHpk0IrAOw/4tQtdffC5FooCf4852k8ex2KOAC3vXEjMnr9l7oEDWWPkZKg+1I8zh2IOLNBhRXqFCxU2zhUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxUFSubXhoZ3V3EWmogyWpWbdvYncSyL6LKcUSs9C2c=;
 b=gMUypyFGubV5IXDcuAeiZvFUiv0GpHymd/ei7OYBVk+qKJGCQpwxbIhf2Mu4MN8clFijJlBhBqs+wlzSFpxmg8R0H9rcclHRR4TCt+7oTVbbEC7KYW7tj7d4azQzdOrNfH0vcriRRuvzO5lxK4xdScVsmiUkTH6AO8VGnoC+qtFN0+tM4hborc1imtAkpYJfVM84yvveqUhsb7Swu905YiGtGlgutbi81FVL98uXpbUv9+a5Bx22UTZtUeq7sLUCk725UD6BcwTU7IbXLxECXCRop4vt27/XKFfrznIZ8Y9o8KiqmMLLaAHxRbpxccxbYHBa6AIrzeuNPc5XzJn6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxUFSubXhoZ3V3EWmogyWpWbdvYncSyL6LKcUSs9C2c=;
 b=Fjbwifw9zaTc2kotVi9Ypy/JsF7ElswQmY+6Sbv8lm15xznHff6ylvNQBqFS8K1ElzbZ06yDefkem6nhH4kIhscgyGRy931ycEwOoByIqYBVu0g2ji0o7vfvhj2ae3OKI3nYfknXIKDFv1Fd1W1QN8/1ZdXqOA1G9sSIvkRatgw=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4071.namprd04.prod.outlook.com (52.135.215.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 27 Sep 2019 17:27:17 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::9821:67e1:9799:b117]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::9821:67e1:9799:b117%3]) with mapi id 15.20.2284.028; Fri, 27 Sep 2019
 17:27:17 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 2/2] blk-mq: apply normal plugging for HDD
Thread-Topic: [PATCH 2/2] blk-mq: apply normal plugging for HDD
Thread-Index: AQHVdQS1etuPt1XGoE+vY/xtqu3qkQ==
Date:   Fri, 27 Sep 2019 17:27:17 +0000
Message-ID: <BYAPR04MB58163C5CE6C700779E2FABADE7810@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190927072431.23901-1-ming.lei@redhat.com>
 <20190927072431.23901-3-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f20fec8d-b95a-4c68-90aa-08d7436ff1ed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB4071;
x-ms-traffictypediagnostic: BYAPR04MB4071:
x-microsoft-antispam-prvs: <BYAPR04MB4071309DC3E006E82FC6E2B5E7810@BYAPR04MB4071.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:454;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(189003)(199004)(2906002)(66946007)(256004)(3846002)(6116002)(486006)(316002)(8936002)(52536014)(476003)(446003)(478600001)(74316002)(26005)(53546011)(7696005)(86362001)(99286004)(6506007)(71190400001)(229853002)(71200400001)(7736002)(66066001)(33656002)(5660300002)(14444005)(76176011)(186003)(14454004)(25786009)(76116006)(6246003)(4326008)(305945005)(6436002)(110136005)(54906003)(81156014)(81166006)(8676002)(55016002)(66556008)(9686003)(66446008)(102836004)(66476007)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4071;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ob8HrjY2DnvyHEZZKJemhflVRCklS7RWt+Hj2b4R7XC8pUHw1j5pum1wZmtuU/wrHg5y45QRk9lhhW5nqKz2/TcFPdMTOlHWqKcHs+8nVyGvkCu50R9pVbWjheCOsY+jeBdJkzwIuBmza2cB06XoV6GyIrP4nYMj6Lx2LKVjN5bBAs/Ri0H7MKThOH87RD/7L0EHokHHWTUX/UkjXb6V0pNfiLiLzHaAzv7O/5yOJx2hgtc4rE1/CjbvIofmtdfX4kewae7SRMPJxKj586pE5odhviTDNRCtb+twA0E41YI2kc1bH2kiOpaJ/S/kvM5veAeseMkT5bzKNXVkDYl3dancKZ48RkhqzkHTCGGUYjEUU1m6tMH/bEv7JhTJ4qRaEfpAydfVlaXt8iBjSxeSeUFN94V+Cd0YORFuRA0v2/8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20fec8d-b95a-4c68-90aa-08d7436ff1ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 17:27:17.3984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGsFNz1xWDwMbVwzKdln2PYsOB/rNwthAIkezl9S5fuREAOezudH9tDvr+KwfavRvTiWdPAbNH4kU6qhUNWIJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4071
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/09/27 0:25, Ming Lei wrote:=0A=
> Some HDD drive may expose multiple hw queue, such as MegraRaid, so=0A=
> still apply the normal plugging for such devices because sequential IO=0A=
> may benefit a lot from plug merging.=0A=
> =0A=
> Cc: Bart Van Assche <bvanassche@acm.org>=0A=
> Cc: Hannes Reinecke <hare@suse.com>=0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Dave Chinner <dchinner@redhat.com>=0A=
> Signed-off-by: Ming Lei <ming.lei@redhat.com>=0A=
> ---=0A=
>  block/blk-mq.c | 6 +++++-=0A=
>  1 file changed, 5 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
> index d7aed6518e62..969dfe02fa7c 100644=0A=
> --- a/block/blk-mq.c=0A=
> +++ b/block/blk-mq.c=0A=
> @@ -1983,10 +1983,14 @@ static blk_qc_t blk_mq_make_request(struct reques=
t_queue *q, struct bio *bio)=0A=
>  		/* bypass scheduler for flush rq */=0A=
>  		blk_insert_flush(rq);=0A=
>  		blk_mq_run_hw_queue(data.hctx, true);=0A=
> -	} else if (plug && (q->nr_hw_queues =3D=3D 1 || q->mq_ops->commit_rqs))=
 {=0A=
> +	} else if (plug && (q->nr_hw_queues =3D=3D 1 || q->mq_ops->commit_rqs |=
|=0A=
> +				!blk_queue_nonrot(q))) {=0A=
>  		/*=0A=
>  		 * Use plugging if we have a ->commit_rqs() hook as well, as=0A=
>  		 * we know the driver uses bd->last in a smart fashion.=0A=
> +		 *=0A=
> +		 * Use normal plugging if this disk is slow HDD, as sequential=0A=
> +		 * IO may benefit a lot from plug merging.=0A=
>  		 */=0A=
>  		unsigned int request_count =3D plug->rq_count;=0A=
>  		struct request *last =3D NULL;=0A=
> =0A=
=0A=
Cc stable needed ?=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
