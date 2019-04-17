Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A5BC10F12
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 09:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2BE2173C
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 09:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TH1Klrza";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Gv3/+qYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfDQJS6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:18:58 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44566 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQJS6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 05:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555492738; x=1587028738;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=a1txGCk0d/yKhiXnQfo8ru/QFvkVL90PaOA2cxaK4VI=;
  b=TH1KlrzaUwv2A1gFibYc8BtImedru2QwhxpKktX8HQBXOn7BAwvo2PLU
   oQJe9LIFAxDYPh+of8WJmGdezG6uwKWWtRU/PR6SolQXRuuIMNpXuTrK4
   g+bFX3l+d1Dh1V4setsogRR6Z45HGfmFXhW6aUAMeWakB7eEU1Grk7tl2
   UuPFzkZ3OzvGCDT/LieS8hd0I/yzhpBuPGULveffG/UNUIVFrgiA+EAdH
   zz9XuBqAVzH7ZHUubgklkL/3KsU1aj52CpSTtVWWYEtJdYgC3813TQLBv
   jkzuKsz1kRgYJP6eRHqXHF1XQDE57rgygaKW97xgpNoF16+X+N5pF1R0F
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,361,1549900800"; 
   d="scan'208";a="106171788"
Received: from mail-bl2nam02lp2051.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.51])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2019 17:18:57 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQG7qPNuofhWnuAuhqzpwUGEXi2sf7ZgCYxGjI9Y5KA=;
 b=Gv3/+qYiahFz7l/F5T3bmwIXLEnq+04OrQcdcH5cfjav26Son+vjecmPflT5w2BT557L5wr2FATzJG0Cth4kkTe9GjvCxR2OTCkWO3HZRyTwRBnt29FjhPPawm7MBRUmZRJ+Gra+Q+waE9AR73kT63JyHsc/v1DH96mHleTMl1U=
Received: from DM6PR04MB4521.namprd04.prod.outlook.com (20.176.105.142) by
 DM6PR04MB5754.namprd04.prod.outlook.com (20.179.52.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Wed, 17 Apr 2019 09:18:56 +0000
Received: from DM6PR04MB4521.namprd04.prod.outlook.com
 ([fe80::28d4:a80d:9761:f13a]) by DM6PR04MB4521.namprd04.prod.outlook.com
 ([fe80::28d4:a80d:9761:f13a%6]) with mapi id 15.20.1813.011; Wed, 17 Apr 2019
 09:18:55 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Pan Bian <bianpan2016@163.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: scsi: bsg-lib: drop device reference on error path
Thread-Topic: scsi: bsg-lib: drop device reference on error path
Thread-Index: AQHU9M15WReAXy70lEWY6YUkx1gTiA==
Date:   Wed, 17 Apr 2019 09:18:55 +0000
Message-ID: <DM6PR04MB4521101BBF8556CC861FA91C86250@DM6PR04MB4521.namprd04.prod.outlook.com>
References: <1555470715-55702-1-git-send-email-bianpan2016@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e1c3e7c-ab25-4e49-d030-08d6c315b781
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR04MB5754;
x-ms-traffictypediagnostic: DM6PR04MB5754:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM6PR04MB575421C0EE815DAA08D0519486250@DM6PR04MB5754.namprd04.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(366004)(376002)(396003)(189003)(199004)(51914003)(316002)(110136005)(54906003)(72206003)(25786009)(4326008)(14454004)(55016002)(33656002)(7696005)(68736007)(5660300002)(486006)(97736004)(86362001)(2906002)(6116002)(305945005)(3846002)(74316002)(7736002)(8936002)(6506007)(53546011)(81166006)(229853002)(446003)(26005)(105586002)(476003)(186003)(76176011)(106356001)(81156014)(478600001)(9686003)(53936002)(6246003)(71200400001)(71190400001)(102836004)(66066001)(8676002)(14444005)(256004)(99286004)(52536014)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5754;H:DM6PR04MB4521.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M1VH7tU7WcRwtMyBhUc4LiUoTQI0yHDYQ2pK+DcS4aY0j2FZYHsHlETVisdg5kUQeDxMV5nN31/M0H3RtG2h2oBOBhIZMO5nNQadGuz4TIjV1IA/nGCy7lOTF/8w2ssYLwcMIyd29fywsyGfNwu0sJt7qtfSarP0oVIQhs1vgKvhqf5Pw4438v3TWb7DBoNKwJUJsp4QWSeRkGdOe5DkJ2bH/C8TGuevgvrP7NiLEQNXPwZ0LrZWxq0kz9QSMIyZBtHPVurF/kr7DBbmAhdUCechSevghISeOk9rWwTn0D3yPuy1GG9I28N/hOxPXR21zyjH8hijCK8SOJT89uSscbxblqKKTXLNX3k24ocnBaaKE2GQIra024rMkeFUH23m234pzGejpR0uugpauxOfn2zJarADy/Oiztnox9yqSoI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1c3e7c-ab25-4e49-d030-08d6c315b781
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 09:18:55.8590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5754
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Pan,=0A=
=0A=
Thanks for the patch, purely cosmetics comments below.=0A=
=0A=
On 4/16/19 8:27 PM, Pan Bian wrote:=0A=
> The function put_device is not called to drop the device reference taken=
=0A=
> by get_device on error paths. This patch fixes the bug.=0A=
> =0A=
> Fixes: cd2f076f1d7("bsg: convert to use blk-mq")=0A=
> Signed-off-by: Pan Bian <bianpan2016@163.com>=0A=
> ---=0A=
>   block/bsg-lib.c | 11 +++++++----=0A=
>   1 file changed, 7 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/block/bsg-lib.c b/block/bsg-lib.c=0A=
> index 005e2b7..fe9e0cc 100644=0A=
> --- a/block/bsg-lib.c=0A=
> +++ b/block/bsg-lib.c=0A=
> @@ -281,21 +281,24 @@ static blk_status_t bsg_queue_rq(struct blk_mq_hw_c=
tx *hctx,=0A=
>   	struct bsg_set *bset =3D=0A=
>   		container_of(q->tag_set, struct bsg_set, tag_set);=0A=
>   	int ret;=0A=
> +	blk_status_t status =3D BLK_STS_IOERR;=0A=
>   =0A=
Not sure if we need status variable as the code written here pretty =0A=
straight forward.=0A=
>   	blk_mq_start_request(req);=0A=
>   =0A=
>   	if (!get_device(dev))=0A=
> -		return BLK_STS_IOERR;=0A=
> +		return status;=0A=
>   =0A=
Also if we are still considering having status variable then we should =0A=
add "err:" label at the end of function just before return and use that =0A=
for an error instead of having multiple returns.=0A=
>   	if (!bsg_prepare_job(dev, req))=0A=
> -		return BLK_STS_IOERR;=0A=
> +		goto out;=0A=
>   =0A=
>   	ret =3D bset->job_fn(blk_mq_rq_to_pdu(req));=0A=
>   	if (ret)=0A=
> -		return BLK_STS_IOERR;=0A=
> +		goto out;=0A=
>   =0A=
> +	status =3D BLK_STS_OK;=0A=
> +out:=0A=
>   	put_device(dev);=0A=
> -	return BLK_STS_OK;=0A=
> +	return status;=0A=
>   }=0A=
>   =0A=
>   /* called right after the request is allocated for the request_queue */=
=0A=
> =0A=
=0A=
