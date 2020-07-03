Return-Path: <SRS0=jyL6=AO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620CAC433E0
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 05:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3234D20723
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 05:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BGhZ8gFl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="e/l3eLTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgGCFKc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jul 2020 01:10:32 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:20164 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGCFKc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jul 2020 01:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593753031; x=1625289031;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QxhVPUhlqQ7AlhlPd2t29f1vOwW0gc/CZN+SFi/FAjE=;
  b=BGhZ8gFlds1H6vBkD4s3xa81Liqk+jpphdpSNkYuLgymnaTnIGQIagIs
   Tap9ijJs6IU5O6jo7iA8RrvDAPfVQg6dQpukwqZFLHKVaOoFL3GGwSrZ+
   BfxizATZOIV8wtuacy4cA/k5bBYS42MgimacW49vHdkboGricEWLxa63K
   1/SUkN7bkvNTVjZSl3bTz+Xu9io44loj1JX//g5EBKjoDfBcvEnRGpcvy
   xXlu8bbWAR5Fxm0r+DBNZ/HmlStWEpZjUs0SFI2z76zfpSWVdBbz8iBfK
   HR1vDY3Ey0tI939LkUSHXpI8jBOkTN4DwXcNs3DqBMTlEd64O2x2ZAgxh
   A==;
IronPort-SDR: fU9ZCue/YNfhSVqKHA2rGVswXqKtRF7aJAvIsNZjI2MIrhpoID7zHakEQvEKrOK7X/lheqv1IG
 10zchlaaQvF6bX+rUF0JTYSB4cNWAClPjVrgPtGpLS2Ai4cfuGtEq4KWJRRJs5Zid9ByfrxWNu
 NGkGLalTMshnHNhxrxEgQcxgXemlvaRoM6Tmu8UDwRmbThkcApijz8CmJ/84byIsCCSC3OrOfC
 L/3hLNpTZaCCkGOLADChp31i0v9Y0bEjftc9O2OFUOCdBufdPLgMJhevziwokGCWhObnr1nsnI
 anY=
X-IronPort-AV: E=Sophos;i="5.75,307,1589212800"; 
   d="scan'208";a="250784383"
Received: from mail-cys01nam02lp2059.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.59])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 13:10:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0E1IlfaPb/AHpkqhQRoK/EFOIjH8PaBzQVJr3+IEhbSfVKkcgmRIw7C+lmyV4o7+qX2EkR0gDo9TdCP7VcZjoBbakHMQcK2Ikvy3GCWHJmREZY1edzu9qF3b3kipHuQ9LiEgmn3cW7zmWTew4bWc25cvG4wPJTgUq4wQVMQAqfXSOU20mKgoj8J1KrLQXq3DP+ZM4i2PkT/3oZ85nomodxKmZvdgdj+/KGuU0RnqoDewf7k8jOtmYvzBqAT/B49FvjHq3cqGYMc8/6JA+hsm+aMyhBXiRQDkICyHAdapRiOatzJnPetphifLv/D7+LdwvmVHQIH7zn0maZNKgZnZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAGb08m0ZXqJ05brHahscd5ZcizwiP/xKqYcd0ZliuI=;
 b=c3Fa2Q4d84rs2vwVzDTcQ6bRB/EfLlscDJcANZG9Oxz5ZRCOUniMMuSt9ZGkCumXo82hgMjKmxpe0Z1kibpKZKITc9A0GrmDYtqc073cBf7HpeepvyPnYr73zIw8U3Ua/jnZTkZ3O6zaDNpjWp+3wCohVdzIfppTixBwEHElG5IbEgnHFxmHAvyNFQSgh1AwooCyDVOdhLGLNIYGAq1AYVOG0Yt2fxw7agcYTegPeiMzqDuQw9zoGGtvBqRTeS4Vt3cLd6dM35XRLW9qMS3GrRfIhVy5EdZtjOjSpgWYbwIAzydM/vIaWBr0zh6E6CnekjhOuzkvwlPwlD9ZvCjN6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAGb08m0ZXqJ05brHahscd5ZcizwiP/xKqYcd0ZliuI=;
 b=e/l3eLTd/lAcAmTTv9ilmgWn+cIaFibWzdXvBLAvWQGBxW1T49vLszmf+0OiCZuV2M5+PY7l36H7dcS9VY0M48EMvKWHC6Z8dJBxe87O/WU7D6y2EgM+kELfURiRfFSQ+fuDwhiCIIpNomzNfsBCYPK2bmerSp5zKmMOba9naBg=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1256.namprd04.prod.outlook.com (2603:10b6:910:52::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 05:10:30 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Fri, 3 Jul 2020
 05:10:29 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH V2] null_blk: add helper for deleting the nullb_list
Thread-Topic: [PATCH V2] null_blk: add helper for deleting the nullb_list
Thread-Index: AQHWUNmxBD0rpMw5p0mOr2to0lDJvA==
Date:   Fri, 3 Jul 2020 05:10:29 +0000
Message-ID: <CY4PR04MB37517F0B34FBE8C92D589409E76A0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200703013130.18712-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1486a5e3-040d-46e7-47e5-08d81f0f67ce
x-ms-traffictypediagnostic: CY4PR04MB1256:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB1256E5C13914603B66BC2C1DE76A0@CY4PR04MB1256.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dU7zSZomSojpiOBGjV8wz5csEBpNVVSdvB3bGImliA3sxckkud+Jwcn36286OSTVw6CvKj1xkOpSaiHmHtiMvKi5fDwGxkfvgl6JTLiCWtGb1Qo4vWXhPxwYzLnPcr8MJ/ko/zqe4miYMGcBqa8OoitCikXV43qM8AMlVbGlB3xQIrqSDVqfwPwh+eJJaLI9TmiRYjFVqeK7iMLowKA5vPsZTj/xjnG7f6joau/usZRkOYyvz7kiFJyAmkYacAES9a9ROF6tNwsrUJOqT2uaC2vVHdz9/AVUPdTnjCAOvNiFE1fBIOt7dj6O46O7mDaB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(7696005)(6506007)(53546011)(186003)(26005)(478600001)(33656002)(9686003)(316002)(54906003)(110136005)(55016002)(52536014)(71200400001)(4326008)(2906002)(86362001)(83380400001)(5660300002)(91956017)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VWhx9851UpbhtWOQKBMf2/lAy6AoL/Xtc4jIxEk2IR9XZaWkFCpdPKLUL5/fcuVE4sBvFixlng78SYsbejSCtJB4bpjhCfTATqlA1bp9m6Xyg6LgdhezfIiAX8FXetu+hqke2v/GAjM1rbE+pp0EdLTrpHx+jHWnFzhyPAgJ80BpvILOkaXzGh3+JW+cHF9naIXoaZ3X6mZR0CAiFNfickgY6f9Vgm31Y25N5CBb9hCKgCt1zNfSbBThFXDjVWHKmWXPoA66Z3M4XEmhZLd17uN42XiwvCRYC2fJjvvaL1izQlXM8ZrjyJb3AZlsRcJgqgLZEu4vayxbBINyQ0sk99vTvQXP+UJvf3APn1/83U8YSXvoOpfhHr9mrEMHBbyz252aZexp8lOTrWafII0BCo3i1d+f9cvRTZ0wUwEPUErZsxzWm7PFe3VuyZXJdewU/6GcFCFBqc7lO8u1wCWFiLTbE7EUvvj5BpnZbUQKusn2/CyGBo6zBgdJwj65FXzn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1486a5e3-040d-46e7-47e5-08d81f0f67ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 05:10:29.8698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mho3IKfbG1C+BiyGw4c/FK2JUDXuSchd/cb/40lno7kNj4Ep5Z2P9s1ZSY1HHg4RV0AOwTT4QfXkEgWtoIhT3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1256
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/03 10:31, Chaitanya Kulkarni wrote:=0A=
> The nullb_list is destroyed when error occurs in the null_init() and=0A=
> when removing the module in null_exit(). The identical code is repeated=
=0A=
> in those functions which can be a part of helper function. This also=0A=
> removes the extra variable struct nullb *nullb in the both functions.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
> =0A=
> * Changes from V1:-=0A=
> =0A=
> 1. Add reviewed-by and missing signoff.=0A=
> 2. Replace list_entry() with list_first_entry() in nullb_list=0A=
>    deletion sequence.=0A=
> =0A=
> ---=0A=
>  drivers/block/null_blk_main.c | 32 +++++++++++++++-----------------=0A=
>  1 file changed, 15 insertions(+), 17 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.=
c=0A=
> index 907c6858aec0..5095942d9b53 100644=0A=
> --- a/drivers/block/null_blk_main.c=0A=
> +++ b/drivers/block/null_blk_main.c=0A=
> @@ -1868,11 +1868,23 @@ static int null_add_dev(struct nullb_device *dev)=
=0A=
>  	return rv;=0A=
>  }=0A=
>  =0A=
> +static void null_delete_nullb_list(void)=0A=
> +{=0A=
> +	struct nullb_device *dev;=0A=
> +	struct nullb *nullb;=0A=
> +=0A=
> +	while (!list_empty(&nullb_list)) {=0A=
> +		nullb =3D list_first_entry(nullb_list.next, struct nullb, list);=0A=
> +		dev =3D nullb->dev;=0A=
> +		null_del_dev(nullb);=0A=
> +		null_free_dev(dev);=0A=
> +	}=0A=
> +}=0A=
> +=0A=
>  static int __init null_init(void)=0A=
>  {=0A=
>  	int ret =3D 0;=0A=
>  	unsigned int i;=0A=
> -	struct nullb *nullb;=0A=
>  	struct nullb_device *dev;=0A=
>  =0A=
>  	if (g_bs > PAGE_SIZE) {=0A=
> @@ -1939,12 +1951,7 @@ static int __init null_init(void)=0A=
>  	return 0;=0A=
>  =0A=
>  err_dev:=0A=
> -	while (!list_empty(&nullb_list)) {=0A=
> -		nullb =3D list_entry(nullb_list.next, struct nullb, list);=0A=
> -		dev =3D nullb->dev;=0A=
> -		null_del_dev(nullb);=0A=
> -		null_free_dev(dev);=0A=
> -	}=0A=
> +	null_delete_nullb_list();=0A=
>  	unregister_blkdev(null_major, "nullb");=0A=
>  err_conf:=0A=
>  	configfs_unregister_subsystem(&nullb_subsys);=0A=
> @@ -1956,21 +1963,12 @@ static int __init null_init(void)=0A=
>  =0A=
>  static void __exit null_exit(void)=0A=
>  {=0A=
> -	struct nullb *nullb;=0A=
> -=0A=
>  	configfs_unregister_subsystem(&nullb_subsys);=0A=
>  =0A=
>  	unregister_blkdev(null_major, "nullb");=0A=
>  =0A=
>  	mutex_lock(&lock);=0A=
> -	while (!list_empty(&nullb_list)) {=0A=
> -		struct nullb_device *dev;=0A=
> -=0A=
> -		nullb =3D list_entry(nullb_list.next, struct nullb, list);=0A=
> -		dev =3D nullb->dev;=0A=
> -		null_del_dev(nullb);=0A=
> -		null_free_dev(dev);=0A=
> -	}=0A=
> +	null_delete_nullb_list();=0A=
>  	mutex_unlock(&lock);=0A=
>  =0A=
>  	if (g_queue_mode =3D=3D NULL_Q_MQ && shared_tags)=0A=
> =0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
