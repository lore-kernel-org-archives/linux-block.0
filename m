Return-Path: <SRS0=th+H=AC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC627C433E0
	for <linux-block@archiver.kernel.org>; Sun, 21 Jun 2020 23:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68BE3252FF
	for <linux-block@archiver.kernel.org>; Sun, 21 Jun 2020 23:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iQSDyBqI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="M+uMBk4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbgFUX5j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Jun 2020 19:57:39 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:6560 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730916AbgFUX5j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Jun 2020 19:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592783858; x=1624319858;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5qYh26ZrfRHqA8wvXQodVDyBaHnh7g3E2bE48AZJQ8c=;
  b=iQSDyBqIh0E+umghCUr/S5e/W2edGzLalu3sGRiPYUg03E+FxIpH6X6j
   bKgvn7rPGqir68uGGee610Umzs4Dea+UJMId3+4BSw4sjAbm9czk+cChx
   X/d8/NIStJbG4R0ANZmDkhXVP5PKYLDUlGQ8ZLNrSbECuX5woUVIKqsPG
   C5tN6XkNuqhOzdhBv8V6jU2MzvuhzLxaSBUOPslGX4cbw5TwS9dQWqeY0
   bVIUtY8ehMcecxmcy6F4e9ICCM7geUN5jh4MRyii1GDNT73fC0aJBbeoF
   I+YaiXHY07mbXTINVq+DTY6r/wN3YI4BFJ1X6O1/EmLxsv4jBFwoyJ21o
   Q==;
IronPort-SDR: 8uazL+vcbTQoshxz3QgrIt+7tQ7m0LuX/gmpJawTURoDHjJRJdISiEaTVEZHGzdmovwa1lIB3F
 Wjny3oAU5/vEyC24Vi/ENC11T4m2Ut5gj7L+1Vo5zTRdiy0tltyhTcSU9+KWKSrjy+JfmfkiSW
 gIKQxy4NcIl8XlOr1DnGnd8Y2dPp/GD5XnWTzZHuKq9vfqctOKkmHCVxxLXd095TvD3i2CTK28
 gwmMZJbG0FfoFmlD/A78loERAqSXqteN8uvCozXZGMoKtbCnbIzEUq8ArW2N7isvuyHg49eOn9
 EAc=
X-IronPort-AV: E=Sophos;i="5.75,264,1589212800"; 
   d="scan'208";a="249764422"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2020 07:57:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=he0670n4hzZWgK5whbO2LJ9aJ8Ljw9SHqSD2APM6gurW0gxHMZKgvY0QOyBrdWmPaXFf7YNEj77+roPyxQEjMrSZ3qTGsoQPQlJVT0elmSDCvxii8Ha+SSEQwv4RckG10+7IZ3iqcZnJMiqp4Nq81qM46JWF52r4V1/27llZwOqkJo3MIpSv9mtpiLJacLehdIOnwE7KPDXbQStiZ9bpmDlvdZBIwIAc36tpXu90XUmGCbZ9xpr503eP3yncmfjq5YWSF5gibdzdN8LQF3o2FYrPFon7fW9KUSRnB0wy49ZrTUyFiUH6HJmCdMj9PYhUUVmh7twa01Fho8wdb0fudg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZpW/EPxm9nMOBOvxXzGnmvGG2XQLuYH83aAfT/adFY=;
 b=QaSyjCHAJQXjzCYcVgGiXvHyajqtd4z0bXQuCBImvy2mNhWn2Tnc1DJiCqcXcRyr1Wil+bfqgh3qdQjVEZSw+h0XEqwuC9JkyCnsr4v6zMODJXHPKzF/ZdY+xY4K+5swVg5jyPRpob2o1JeMkVHwK2CnAoRgXrSpA/E4YLZKHz6NuakoKqsgSLfPpnrpNN+1vnibNuZksb9jtFqx5qZ8Je65FEczklDcNTzVkFTo6kjFObgtjtgJB9ePNw4VjcYX2XAxWinRINbM9QkIriTw8cPT9nbAzXxPOsdEkJ6nQz0iklK/ZRaeH+UII3yCZYoMhc5i2znt/aeQ9nVGGjVenw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZpW/EPxm9nMOBOvxXzGnmvGG2XQLuYH83aAfT/adFY=;
 b=M+uMBk4iOxx5kKC7gZY+4o01PuLgI+VuX65USm7f6WJeSixuG/vXBOfgzINnvz4/EIjgEX3SqPZbzSjmb7ATqmgmTWSoRKhPbRtz/qtFn0CY7mXnPIflx9SJl+MpVW94UdDAEbIqjguNJ2LKcTHnqpEHMBr+ZrUbDTqRVmPMxa8=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY1PR04MB2219.namprd04.prod.outlook.com (2a01:111:e400:c611::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Sun, 21 Jun
 2020 23:57:36 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3109.023; Sun, 21 Jun 2020
 23:57:36 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] null_blk: Move the null_blk source files into a
 subdirectory
Thread-Topic: [PATCH] null_blk: Move the null_blk source files into a
 subdirectory
Thread-Index: AQHWSAyS356ZHKRE80yyQ/amV6VjiA==
Date:   Sun, 21 Jun 2020 23:57:36 +0000
Message-ID: <CY4PR04MB3751D048F64CFC8DA2D8FF99E7960@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200621204257.16006-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cee4e4a9-1e8d-440b-2337-08d8163edf8f
x-ms-traffictypediagnostic: CY1PR04MB2219:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR04MB2219EE4147C7061004D364BFE7960@CY1PR04MB2219.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 04410E544A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PCXotlHH1sHS3XuKX6BBbt1jv2pKEubo/sCqgfce27yN50sZ+rwF1u1Ykv3dyUba6qOmJAbahVvo72Mj0uhLwyn2p/PG/BxxRbe1OgJ0vPZfq6h+0ftzvrWrBhXX8amF3p0yH4kbQ0fd9iTKyD5RJ7yiOUh/HScLVnvl+iYKSB8BgjYon71TrlmxSdPXdeUA44cHB227gqA+RjW6yAlAL2EPjghKX23zYyR70NFkGsqhuuKfM7+Z35lVTcZ2QHrCDIhFVYz+PUZhxP5Y1kuGmTEekATzKcA2B7Tp0cTklM1ts1uVKgZ/W002PTfrq5Pv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(110136005)(33656002)(71200400001)(316002)(4326008)(6506007)(52536014)(9686003)(26005)(53546011)(5660300002)(7696005)(54906003)(55016002)(86362001)(2906002)(186003)(478600001)(8936002)(64756008)(76116006)(66946007)(8676002)(83380400001)(66446008)(91956017)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: JzWiwneAcGNJRA8p7HjSs5197VoShYKjQ3MI6VqdLQbY8+wlO2YRDZ+rjZQDBXGlxCzb4kZGAzeV4eHxLgh4vRq6hYDxwORD+zdr13QYWFIPcbZ9W0jAOmhHqf98DxV3iqAZcxUmGQwkMMnuKxgLMfSG2xt9/xGM/D6LOcEg7TiKX6XFi3S84+PnHT5KBkUo2r5YJE5QbG6kXldLH41Pc5+aUh671NIjtxYx/bvp9zZxlYT3swag1Uzakt+YU3Sz4PzFacIQ6tCqlvMfZSI4drdGCZ2kgc8qAO6VNXwiak01s7VZgR1Uhk/+SSMaxUdgjFh3Gsbp5lZ4XvK0hJdHGTYSZkbTGqL0IjDUfKVppGtBQLlgY2GE4pThFr2R4WFL+gHOP3NXSprKf147TgUNvMQm/RAf5Xx7b0njE+/UE/59LWlTwrCvMX+49aGM7xQKpDIu41nagqAZL/cPaVLhAGqtjMUAVvGRImlpcaDUHJLq5HxsqbhDHoYyXo9+FfgN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee4e4a9-1e8d-440b-2337-08d8163edf8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2020 23:57:36.6209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CsWRcKohgLjWnDu3rwlRi3YQVfsq2W0d+xFgdx1yW/0uQbbDxPLEIQMJryROkaIAcpdUP7pT/5PgoWBaxwKzBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2219
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/22 5:43, Bart Van Assche wrote:=0A=
> Since the number of source files of the null_blk driver keeps growing,=0A=
> move these source files into a new subdirectory.=0A=
=0A=
Makes sense.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
> =0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Daniel Wagner <dwagner@suse.de>=0A=
> Cc: Dongli Zhang <dongli.zhang@oracle.com>=0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  drivers/block/Kconfig                         | 8 +-------=0A=
>  drivers/block/Makefile                        | 7 +------=0A=
>  drivers/block/null_blk/Kconfig                | 9 +++++++++=0A=
>  drivers/block/null_blk/Makefile               | 8 ++++++++=0A=
>  drivers/block/{ =3D> null_blk}/null_blk.h       | 0=0A=
>  drivers/block/{ =3D> null_blk}/null_blk_main.c  | 0=0A=
>  drivers/block/{ =3D> null_blk}/null_blk_trace.c | 0=0A=
>  drivers/block/{ =3D> null_blk}/null_blk_trace.h | 0=0A=
>  drivers/block/{ =3D> null_blk}/null_blk_zoned.c | 0=0A=
>  9 files changed, 19 insertions(+), 13 deletions(-)=0A=
>  create mode 100644 drivers/block/null_blk/Kconfig=0A=
>  create mode 100644 drivers/block/null_blk/Makefile=0A=
>  rename drivers/block/{ =3D> null_blk}/null_blk.h (100%)=0A=
>  rename drivers/block/{ =3D> null_blk}/null_blk_main.c (100%)=0A=
>  rename drivers/block/{ =3D> null_blk}/null_blk_trace.c (100%)=0A=
>  rename drivers/block/{ =3D> null_blk}/null_blk_trace.h (100%)=0A=
>  rename drivers/block/{ =3D> null_blk}/null_blk_zoned.c (100%)=0A=
> =0A=
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig=0A=
> index ecceaaa1a66f..262326973ee0 100644=0A=
> --- a/drivers/block/Kconfig=0A=
> +++ b/drivers/block/Kconfig=0A=
> @@ -16,13 +16,7 @@ menuconfig BLK_DEV=0A=
>  =0A=
>  if BLK_DEV=0A=
>  =0A=
> -config BLK_DEV_NULL_BLK=0A=
> -	tristate "Null test block driver"=0A=
> -	select CONFIGFS_FS=0A=
> -=0A=
> -config BLK_DEV_NULL_BLK_FAULT_INJECTION=0A=
> -	bool "Support fault injection for Null test block driver"=0A=
> -	depends on BLK_DEV_NULL_BLK && FAULT_INJECTION=0A=
> +source "drivers/block/null_blk/Kconfig"=0A=
>  =0A=
>  config BLK_DEV_FD=0A=
>  	tristate "Normal floppy disk support"=0A=
> diff --git a/drivers/block/Makefile b/drivers/block/Makefile=0A=
> index e1f63117ee94..31bc2cfa342f 100644=0A=
> --- a/drivers/block/Makefile=0A=
> +++ b/drivers/block/Makefile=0A=
> @@ -41,12 +41,7 @@ obj-$(CONFIG_BLK_DEV_RSXX) +=3D rsxx/=0A=
>  obj-$(CONFIG_ZRAM) +=3D zram/=0A=
>  obj-$(CONFIG_BLK_DEV_RNBD)	+=3D rnbd/=0A=
>  =0A=
> -obj-$(CONFIG_BLK_DEV_NULL_BLK)	+=3D null_blk.o=0A=
> -null_blk-objs	:=3D null_blk_main.o=0A=
> -ifeq ($(CONFIG_BLK_DEV_ZONED), y)=0A=
> -null_blk-$(CONFIG_TRACING) +=3D null_blk_trace.o=0A=
> -endif=0A=
> -null_blk-$(CONFIG_BLK_DEV_ZONED) +=3D null_blk_zoned.o=0A=
> +obj-$(CONFIG_BLK_DEV)		+=3D null_blk/=0A=
>  =0A=
>  skd-y		:=3D skd_main.o=0A=
>  swim_mod-y	:=3D swim.o swim_asm.o=0A=
> diff --git a/drivers/block/null_blk/Kconfig b/drivers/block/null_blk/Kcon=
fig=0A=
> new file mode 100644=0A=
> index 000000000000..1ce02a3572bd=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/null_blk/Kconfig=0A=
> @@ -0,0 +1,9 @@=0A=
> +# SPDX-License-Identifier: GPL-2.0=0A=
> +=0A=
> +config BLK_DEV_NULL_BLK=0A=
> +	tristate "Null test block driver"=0A=
> +	select CONFIGFS_FS=0A=
> +=0A=
> +config BLK_DEV_NULL_BLK_FAULT_INJECTION=0A=
> +	bool "Support fault injection for Null test block driver"=0A=
> +	depends on BLK_DEV_NULL_BLK && FAULT_INJECTION=0A=
> diff --git a/drivers/block/null_blk/Makefile b/drivers/block/null_blk/Mak=
efile=0A=
> new file mode 100644=0A=
> index 000000000000..a93a16d5ba23=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/null_blk/Makefile=0A=
> @@ -0,0 +1,8 @@=0A=
> +# SPDX-License-Identifier: GPL-2.0=0A=
> +=0A=
> +obj-$(CONFIG_BLK_DEV_NULL_BLK)	+=3D null_blk.o=0A=
> +null_blk-objs			:=3D null_blk_main.o=0A=
> +ifeq ($(CONFIG_BLK_DEV_ZONED), y)=0A=
> +null_blk-$(CONFIG_TRACING)	+=3D null_blk_trace.o=0A=
> +endif=0A=
> +null_blk-$(CONFIG_BLK_DEV_ZONED) +=3D null_blk_zoned.o=0A=
> diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk/null_blk.h=
=0A=
> similarity index 100%=0A=
> rename from drivers/block/null_blk.h=0A=
> rename to drivers/block/null_blk/null_blk.h=0A=
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk/null_=
blk_main.c=0A=
> similarity index 100%=0A=
> rename from drivers/block/null_blk_main.c=0A=
> rename to drivers/block/null_blk/null_blk_main.c=0A=
> diff --git a/drivers/block/null_blk_trace.c b/drivers/block/null_blk/null=
_blk_trace.c=0A=
> similarity index 100%=0A=
> rename from drivers/block/null_blk_trace.c=0A=
> rename to drivers/block/null_blk/null_blk_trace.c=0A=
> diff --git a/drivers/block/null_blk_trace.h b/drivers/block/null_blk/null=
_blk_trace.h=0A=
> similarity index 100%=0A=
> rename from drivers/block/null_blk_trace.h=0A=
> rename to drivers/block/null_blk/null_blk_trace.h=0A=
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk/null=
_blk_zoned.c=0A=
> similarity index 100%=0A=
> rename from drivers/block/null_blk_zoned.c=0A=
> rename to drivers/block/null_blk/null_blk_zoned.c=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
