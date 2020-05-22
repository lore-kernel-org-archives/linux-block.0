Return-Path: <SRS0=5dBz=7E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76671C433DF
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 07:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F03206DD
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 07:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CZxgaFss";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cHuc9crZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgEVH1S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 May 2020 03:27:18 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:56612 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgEVH1R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 May 2020 03:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590132436; x=1621668436;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Jb2f5lZ8a5sGcrvzMYyEBjFpq/XiH+L6IzlGH5hM8oY=;
  b=CZxgaFssOyLSy5DPrghlsAJuykCrbkUREOWrAA/JURjFLfPeioMR4+Ju
   I8ZhV33PMI/sNQDjS8UskgDbOb2miWpqBtLM6ySYEUFw6hjsRbCVx96xm
   QJAwW1QeXiAbMUsDFeYmWnx+nFoxmqaR3OIx8cLjX9Am3nrR/KLvxesCM
   U0SQhPfnBsiiFwl7O0y4dNdW/vKqQy82SATBJsbb9gaQNYCnxYy2P3UC6
   WCwkwVN7PPAgK1Avtp4MhQ9+8B8kyMs15tf3RZsShJVScDXWfnQ4vOiOM
   VRQt90Rh1s7Wv4Hdy7SEPJz6vQNhW0JiCLOj6L1v3SEFi7+HOG/7PvYt1
   g==;
IronPort-SDR: hHWqOaE5lD+0K/6vRGiltGosKVWXhGeBbGfK5oYFbVCKKtwLbZEs/l41yKcVtqIkDRItOO1Ibq
 Sh0wMfirnN4QOFYBSaNgq6dSyTdR6sbDwTLMK3xUUai4lLwbvfZXa7HShlPIsqJkkdM/A/LqOU
 TU5bMgbmq+gNH9HLkeM5oSHbCEZMUQ/KEZCgkt+WDm3ybuW3b7thCD5ehPJcqXU9JMCK8edTyw
 6f/lfDHYUTdr1+6YZakpzGfIMl/vAu6QN4YeFldTtHWkX5YmK0bysVhfNjf27Bp5fa3D3fzkKt
 HKE=
X-IronPort-AV: E=Sophos;i="5.73,420,1583164800"; 
   d="scan'208";a="247299869"
Received: from mail-sn1nam02lp2051.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.51])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2020 15:27:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euUth7sAYLx+oGc+lxbGNBpXZscrzniGpo/quYaQ9pLP72CrezXICt0bvnukvorLpZGNkI0aYbzL67U04CMXg1zuXV5tjLGQ/ZpAbzYK4kxMzp76zTGnpAdG8vHBLs3lNpuYzarasuPZPdFi3U+mYqYcV9c557p3zVCIDM0dejHdlQasoKWc274RxRB0pEtL9RfWG/yXzsnv4jJJWJh89zmBKKjYLjw+zijDxedVPp/w0YPmDnOWh51mPpvYrkEwqXMfXWquvZ0SduaRj2p7YZgXNEUXn4F3/iQ/Q62TeJXdM4f74+/vAxBrLvOu99gIc4gjoH/vrIYnp+Ljpq7yVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85BRR3/fS1C7dymZmf7ur7Al7SQRgvcVt8Q+kpuLlvY=;
 b=cs5yYHXMlxyvU2IWFMKICbxyF2T37yWv9lSuf7Zztw7Hrcs+c0LU0TW6mbEWEPoSN6YzUatdyorRKwXGK2GDUJ6U5XUzgzNVUUbW+0dHgXsbJj0Vp2Mv7uASZPbBJifEzpZiF/YbJ6hlpwrSxSBiB/BeDGJOsGmkAP/x8WNmQbn+/LA+2/jDZiwcHaE5Ecqdntt3Rvt/UbJdwbdDkYYbzNenMTIEaR5D2k/aSEsUX5yvLC6LP8tB23/KAcB2SR23Dwv5Xv+pcSi/goDYzEj1RKFeOQRFaNaxL8CCIEiFuW5ncLAiuvqnRaGkfiPRmJIDNCKHUGdrCaQ+6Amzm3VY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85BRR3/fS1C7dymZmf7ur7Al7SQRgvcVt8Q+kpuLlvY=;
 b=cHuc9crZZ4diERByfUXs6AWr4ABHlwPo5QKRGaapSZZyVAMB/amDnTuyl5dJmBL8Qo/gpxG2PGRv3MuxM+xC8vQcxt49KAwGqktLvIOy9fA/5OXg/2z4/GUdblpu2hM4I/idwNVbUNSmBmf+DiuQB/vZZFucy0Hwad0o5xCQPUQ=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6865.namprd04.prod.outlook.com (2603:10b6:a03:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Fri, 22 May
 2020 07:27:11 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%5]) with mapi id 15.20.3021.020; Fri, 22 May 2020
 07:27:11 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH] block: Improve io_opt limit stacking
Thread-Topic: [PATCH] block: Improve io_opt limit stacking
Thread-Index: AQHWKb0cTYJPThBKS0yTBVeZnYkcfA==
Date:   Fri, 22 May 2020 07:27:11 +0000
Message-ID: <BY5PR04MB6900144BD2729172EBF5DF2EE7B40@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200514065819.1113949-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b6d7e630-d5b5-4137-4e67-08d7fe218ae8
x-ms-traffictypediagnostic: BY5PR04MB6865:
x-microsoft-antispam-prvs: <BY5PR04MB6865B6D56CCA5329035529DDE7B40@BY5PR04MB6865.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HzSumQlc6BzUnQ6A66lCJ7CtOUOW1oKdWS1f1zSAC9c6icGAmtIwFWrIY5z18ok+RpKzlXhttC2pWtunrB+O+6tnAWtRtok6uiUr43oZTH9kBwPt5GinCg9TYu7TAkjwEU9jtuZ2CjCaLDhwu3b58giAzonrcMKst9jyJN4x2N02+XKHVA4d+a6sRn+4dMbPPB+LnIWfP/JpqjONKYMSryHu7h2kqYyuT07DeUhsOf6D9EfUXzJdwdzGZHJnuG7/XCbreXHY+t4U5hFFoTewE8meI25FwdpD//lTlFdZp6nktZOQ5qf+wuWz5h3x+dzb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(66446008)(86362001)(52536014)(66556008)(64756008)(66946007)(316002)(5660300002)(26005)(186003)(2906002)(53546011)(110136005)(6506007)(7696005)(76116006)(9686003)(55016002)(8936002)(66476007)(33656002)(71200400001)(478600001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KSnFUNw3PEjJiCH0yZESQrVcHC/q/Y8TTgfmSzrPY22PeQTmtnV8jJceHFDA4t09mLTdKeBqs/4XPUh9W4W86tKheGxaPuVqcdqriy4bf3Y14zea2Gqq0uUT5X+nfJPF8suRcilfOTgzPbs0vUtdiU2sB4NuSQiX6VlRTtS38Kdy2bhk9BlysdQHRTgqhvxneoFJgYaAKKBPdssNwVDEhrEy8IKiFlOxKhah5RCtny3mpSWrv72I5rr5F/3+V1MOZ/Y5vTvqHPqYkPd+TvutUp1IQk/1mv7W7a8SAWOSAWytqr8LYjeKI0iJq67MUllHPjwGniq1I4iTj8srvrzPJzAr3V1sixDOIesv9qLuAOArakaN0ixRNOSfoeo9nTiqAE+o07UuQGwow6L9krJA+6fZHXumHfFUnhhgIGy6akIfFi+tMoYEkd7vneKX7sYFPc/ErqfdDS4g4oogWxqmwdJpLoz+vXRlvOwqj2zWv7swsZu88+zqNvvrwzHYMAwO
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d7e630-d5b5-4137-4e67-08d7fe218ae8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 07:27:11.3104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0scW0Z8ceVyCUpSOecQzTtCpy+fmkR/i6VJ9sAKQttAF0cVSmDCobGwF0gkjCdgZ1NfU2UJ2qcPk3od8rkHIcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6865
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/05/14 15:58, Damien Le Moal wrote:=0A=
> When devices with different physical sector sizes are stacked, the=0A=
> largest value is used as the stacked device physical sector size. For=0A=
> the optimal IO size, the lowest common multiple (lcm) of the underlying=
=0A=
> devices is used for the stacked device. In this scenario, if only one of=
=0A=
> the underlying device reports an optimal IO size, that value is used as=
=0A=
> is for the stacked device but that value may not be a multiple of the=0A=
> stacked device physical sector size. In this case, blk_stack_limits()=0A=
> returns an error resulting in warnings being printed on device mapper=0A=
> startup (observed with dm-zoned dual drive setup combining a 512B=0A=
> sector SSD with a 4K sector HDD).=0A=
> =0A=
> To fix this, rather than returning an error, the optimal IO size limit=0A=
> for the stacked device can be adjusted to the lowest common multiple=0A=
> (lcm) of the stacked physical sector size and optimal IO size, resulting=
=0A=
> in a value that is a multiple of the physical sector size while still=0A=
> being an optimal size for the underlying devices.=0A=
> =0A=
> This patch is complementary to the patch "nvme: Fix io_opt limit=0A=
> setting" which prevents the nvme driver from reporting an optimal IO=0A=
> size equal to a namespace sector size for a device that does not report=
=0A=
> an optimal IO size.=0A=
> =0A=
> Suggested-by: Keith Busch <kbusch@kernel.org>=0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> ---=0A=
>  block/blk-settings.c | 7 ++-----=0A=
>  1 file changed, 2 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-settings.c b/block/blk-settings.c=0A=
> index 9a2c23cd9700..9a2b017ff681 100644=0A=
> --- a/block/blk-settings.c=0A=
> +++ b/block/blk-settings.c=0A=
> @@ -561,11 +561,8 @@ int blk_stack_limits(struct queue_limits *t, struct =
queue_limits *b,=0A=
>  	}=0A=
>  =0A=
>  	/* Optimal I/O a multiple of the physical block size? */=0A=
> -	if (t->io_opt & (t->physical_block_size - 1)) {=0A=
> -		t->io_opt =3D 0;=0A=
> -		t->misaligned =3D 1;=0A=
> -		ret =3D -1;=0A=
> -	}=0A=
> +	if (t->io_opt & (t->physical_block_size - 1))=0A=
> +		t->io_opt =3D lcm(t->io_opt, t->physical_block_size);=0A=
>  =0A=
>  	t->raid_partial_stripes_expensive =3D=0A=
>  		max(t->raid_partial_stripes_expensive,=0A=
> =0A=
=0A=
Jens,=0A=
=0A=
Any comment on this patch ?=0A=
Note: the patch the patch "nvme: Fix io_opt limit setting" is already queue=
d for=0A=
5.8.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
