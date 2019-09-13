Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777A1C4CEC5
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465E5208C2
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BFD10GXP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AhKr7LpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403952AbfIMWPO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:15:14 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:51031 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403947AbfIMWPN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 18:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568412911; x=1599948911;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=MG1P+wBKWo9wmYc6dAECd3FHMjDlfawVx0cq2A1BTik=;
  b=BFD10GXPVSj0LSLgPRAfVfIUkhq/X3axkj9LgSX4uHwW0hahpxOBx+Uy
   DZFamVN/3ZX+0JL7Z2tZRrQVlp+pyQZZIZ6h3seWHs88xQbIomAPsgSh4
   2jGtellWKTZbO6v9Fx8kktr1/OFzI1kCoxc0IO4af6TveZze1lTh91Pfv
   mP3csPrUOhu0SQdzuZIjP7st6GLCH7N23eXYan4aHyA5TIh77IbOmjZ6A
   WhlCpN8UaO5EE2q6MtFyN4IDVf/tipTFlTHrLsNj9/41W0In9iXOY15zK
   dwJpcDDaJ0u1q8kHico2St+BFeN09QiTA8oSZ4mb7Gg5Nvw0kvEzxaxmV
   g==;
IronPort-SDR: JwkE82/mk+HA++7V+dYuMiTGnHBti9nTUtFq7EPTlPaW0JrsiTu+NkMtdwJBCdY8E6BBav3Xjd
 0b0whhhd/7Ia8UJPN71MMejDXl0G6l+3Zv08redPKAIlsPvSnEOC0cl+Cf+xaTURQSJifoPofl
 Shpkw58e2Xz8XZimhjDouxaBs//I2CbtuFhNN6F/U74G2T/1O6JMPeWbQfIbFUGzobduZUiVH+
 O8GEHue7xDI1vLT7UhCNMg/1m+AIdpKC9/tgJddGn6LV5ZSrpKJxjhKJBiE2bXmyE+TaOV6xjX
 yQI=
X-IronPort-AV: E=Sophos;i="5.64,501,1559491200"; 
   d="scan'208";a="122734184"
Received: from mail-bn3nam01lp2057.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.57])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2019 06:15:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfM50pB5zpcI2fsiQLYmdzTZZHbtHDAwXYz76SLHiRs/npZ5T4aG01KXeT/1t+bev3nmYTwDmsdRSYHj38Ztf/OHVeIW+U8jEQOR0KfpMjbJt3NI9+BvDhZlP04sa6glDe00/R+sp31HHkKZbd5h7WiTV11tf3XFf84mkKY9v9UBAzbSHTzYiRC+3iiWHzLMqnC2IUypPEruYOdEipK1/fTk+uBUXLc8AapYG/OKv9wdxoOuSfzQ3/8q5ToHW+e6uNPQCTRoDIyTKsljIKjFudDXu+nAlFtC/6FVWh3EfWqAbfZn4t5U1ZPii1jj9mxODvzcryVdK72Op29mJRppjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sz3KTqsoPEwiEq6Eu2BNQEbzpfUgrHGRU9DjqbSeLWk=;
 b=AoBJjUoRNyk2BbJ26hxB+LL67C7TtE9a3lyG4DioQ3gNJHdgAYldaK52Xx8x6efOh4c/ZAWq53btaU/ee+uBJEFtW8F+9JSQtVKqrl2lur26prrLoTAiF9C05Z+QGZhGoB+x92sJxD9Exzit7/2wKDeV/8r5gl7ILoTDCkl2MlvrdOrHUwRerH3NlO2ZJAvj2ie9dKhz9Z/dBafvAN5HE3jIVaAHRbN7A4ZraqtGbDor5y9hahbWFr7ZN/rmQsSL6WV1JzjVy97G36caA7ZkOkX6w0gLdkR7QbxFjzY+ELP/WyyQa+f2OA1wZNQV00kRYz5152g2JRoIELV0VtiLlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sz3KTqsoPEwiEq6Eu2BNQEbzpfUgrHGRU9DjqbSeLWk=;
 b=AhKr7LpFkli3/+RBIpfo21YW6ycPEQZhOsNRx07cLL/cCDONiYFRJfA64Mh7q/prPSmEgjsDb6NDth/4kEl9FKGWgOwOTLDp145DA4Giw4Arg81o3CFUMg1ZZXA61qysr/4w9rdQjfzmEF7jSWCAntVmCAXvX+MhFOqrxQCfNQo=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4294.namprd04.prod.outlook.com (52.135.204.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.20; Fri, 13 Sep 2019 22:15:07 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2263.018; Fri, 13 Sep 2019
 22:15:07 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     =?iso-8859-1?Q?Andr=E9_Almeida?= <andrealmeid@collabora.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "krisman@collabora.com" <krisman@collabora.com>
Subject: Re: [PATCH v2 1/4] null_blk: do not fail the module load with zero
 devices
Thread-Topic: [PATCH v2 1/4] null_blk: do not fail the module load with zero
 devices
Thread-Index: AQHVan85AifiRz+yRUqzbl6jvX3qQA==
Date:   Fri, 13 Sep 2019 22:15:07 +0000
Message-ID: <BYAPR04MB5749CB3F25FC6F18C48C58F986B30@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190913220300.422869-1-andrealmeid@collabora.com>
 <20190913220300.422869-2-andrealmeid@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bf5778f-d281-4ab6-6927-08d73897d60f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB4294;
x-ms-traffictypediagnostic: BYAPR04MB4294:
x-microsoft-antispam-prvs: <BYAPR04MB42948DC98AA1404E422FB74886B30@BYAPR04MB4294.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(99286004)(478600001)(54906003)(110136005)(3846002)(229853002)(316002)(52536014)(9686003)(55016002)(7696005)(76176011)(86362001)(14454004)(6116002)(81166006)(81156014)(8936002)(5660300002)(4326008)(8676002)(33656002)(25786009)(71200400001)(71190400001)(53936002)(76116006)(476003)(6246003)(64756008)(2201001)(6436002)(66446008)(66066001)(2906002)(53546011)(14444005)(256004)(2501003)(102836004)(446003)(486006)(7736002)(66556008)(66946007)(66476007)(305945005)(6506007)(26005)(186003)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4294;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LmtYL3MEPdCeTiyKNFKQg/kJ0qT70zXISxnPU5t39CISLuJ+91j0Xw8+7awVg7w11pDP8oPU6LYohk7wMPMTvfQzG7QFj4O28BxyQufzvhnoyb6YZUQsCjk/5+BpfacjXERfkwhKpxsL47ysZlpxzscDDAU/rCKnb6wk7dAbKBG7UzgrTSBEAaVQqBH9r9B1Rlg4fErscTDxFJmGvLrP5yu/oG2ANm/EeAbYqDDq2sleyiKD8Z4fOBXkK5IYxBhIrw5560QJUjR99+mOtop7vK9wMo35c26iyz06F0e7IUYmQpgaW5MBGnLv6QIM/ff31O9xF4ebut4vGqfYujBfgwsD+SovmBO8efo0/sGTCTI36iUnf/8Er+lnln7o3n+uNeaz9qGuA3mTzazRjIFPgb4f2IXLBBQWgHe/m3ZAqCI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf5778f-d281-4ab6-6927-08d73897d60f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 22:15:07.6167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSrzpxWctC6Cmazdd7JVGIxt+xPNunEk7FGq+H6E9D0R0EJpS/gwX5pdMj7XYu1sKmVaC9TENmDKOVilpDU1d0VVzsWVmsMXtKHO+jpEut4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4294
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 09/13/2019 03:04 PM, Andr=E9 Almeida wrote:=0A=
> The module load should fail only if there is something wrong with the=0A=
> configuration or if an error prevents it to work properly. The module=0A=
> should be able to be loaded with (nr_device =3D=3D 0), since it will not=
=0A=
> trigger errors or be in malfunction state. Preventing loading with zero=
=0A=
> devices also breaks applications that configures this module using=0A=
> configfs API. Remove the nr_device check to fix this.=0A=
>=0A=
> Signed-off-by: Andr=E9 Almeida <andrealmeid@collabora.com>=0A=
> Fixes: f7c4ce890dd2 ("null_blk: validate the number of devices")=0A=
> ---=0A=
> Changes since v1:=0A=
> - None=0A=
> ---=0A=
>   drivers/block/null_blk_main.c | 4 ----=0A=
>   1 file changed, 4 deletions(-)=0A=
>=0A=
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.=
c=0A=
> index ab4b87677139..be32cb5ed339 100644=0A=
> --- a/drivers/block/null_blk_main.c=0A=
> +++ b/drivers/block/null_blk_main.c=0A=
> @@ -1758,10 +1758,6 @@ static int __init null_init(void)=0A=
>   		pr_err("null_blk: legacy IO path no longer available\n");=0A=
>   		return -EINVAL;=0A=
>   	}=0A=
> -	if (!nr_devices) {=0A=
> -		pr_err("null_blk: invalid number of devices\n");=0A=
> -		return -EINVAL;=0A=
> -	}=0A=
>   	if (g_queue_mode =3D=3D NULL_Q_MQ && g_use_per_node_hctx) {=0A=
>   		if (g_submit_queues !=3D nr_online_nodes) {=0A=
>   			pr_warn("null_blk: submit_queues param is set to %u.\n",=0A=
>=0A=
=0A=
