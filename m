Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50F5C10F1B
	for <linux-block@archiver.kernel.org>; Fri, 30 Dec 2022 08:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiL3IBz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Dec 2022 03:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbiL3IBz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Dec 2022 03:01:55 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A1A183B7;
        Fri, 30 Dec 2022 00:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672387312; x=1703923312;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xUXC+iOrDX5jHXTcd1AWhxbmPjysrCOFioia/xIJKOQ=;
  b=cBBsHwStdmIVKxtGhP9l90m/PhJGppLKqiWcSOBpNWhMoeMGmIL7DzTp
   MtEiCHG3q2mvtLZ65+g4RSnTtEB2/wzL9cmtKuQlMLTcnTylH13uWDdWN
   XPbfj2N9qi4AcTKU54pylRcFqDLV+EQ7285a0jGtoICvBzcxr70v8kBZu
   cmWi+jwvn2nOv1s8tldQsA7waT8CKty341Sl+0hOTKMWMiOC8ACpoa+Hx
   ZeUgGPcdyA37we/uJlrHYDaHsB3gSfJpzJGrq3jMdR8ftLnn/DFCgmydh
   HG1X5hvTFDLaV+s/+7GnMDFHvnevF8TIo0AXnjatb2bHeyQWj1MXvP7kk
   w==;
X-IronPort-AV: E=Sophos;i="5.96,286,1665417600"; 
   d="scan'208";a="219864054"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2022 16:01:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxOSVWjrHSVa9VERwOOFfPjFZ2w/3JrW+2cCcSswmrIhvKdc2ndt08uyYlmOPBtcuglbMCDQWv3RLl5vHlZDm++mNkkrX9OncM2qt0zH3N3pe/MGt3I5srYQYnk7MPUMN6CIQFHxEZU3jzYA/FonHGaGSmb+0MY+7IugVTzT35zDkjmRGMHQgEHWl/CT8MgKnTc8Vtx36pRgNOx/7VdrAyYrhyAK+isNh20UL1GRjX6btSDa7pnxmsptZ1ghswAjwhBbfDiTJYVY8SbvNu18jCqmqBCds5FiWUDMTAJo2078yoBoh4v2Tt8b/A2aSRQIOawehMdH//yf023BKtMuuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCbFXGTRsU//DEgIclrUZ/F1V+6QufHjahsTYylc6Yc=;
 b=eeoBXMpLKhiFOgv7zJ8wI5Dc7i0bYxNJqgN7Vv+8wJXWs3eLXSUXpI7NrQTevTKnsojw0A6nknPjbBSCKsustV6/c+C5T/NvRC+6skRSOYtqyFOpk9NQE6+vyy+a1PwVvHNVti0ocu9vu6dL7hnV2vFIqrjFzaZq9j+lmPD33+WVh7DzEOWQTtxk8+p+UwLiO4bIS3h/DRTEuLitUMlhSbgObDn9wNuPVoBJ61xjFgRNqxuxtyl//eDF3poUxc3+7KuEr1yZGJH/SQ6LHg5y+dNHetwzZNCE4hhpZ0X5erl+pbXq6tSq/LQoy3KN/U86hrXeYhYAsUTomCnEX7MfrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCbFXGTRsU//DEgIclrUZ/F1V+6QufHjahsTYylc6Yc=;
 b=LL10JtZh7TejHJU14sFK4o27voKFOCDTC0l1iAijCrLVIUrMAGKXRdoA+9MGbb50HX4jixOixPSsqrEs8XtOApdT7wiN4WZYH9tTjjtUg4v/bhhfq66OoSWVT0UQRfFZjHjE4QIz/SLzA+ztFaKQIpX65G4Qfu16rpgE1jbcxNo=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BYAPR04MB6021.namprd04.prod.outlook.com (2603:10b6:a03:e6::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 08:01:48 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5944.016; Fri, 30 Dec 2022
 08:01:48 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 4/7] ata: libata: cleanup fua support detection
Thread-Topic: [PATCH v6 4/7] ata: libata: cleanup fua support detection
Thread-Index: AQHZHCT3KDSYhsINjkK5fk1wsP2x5A==
Date:   Fri, 30 Dec 2022 08:01:47 +0000
Message-ID: <Y66a6ilkduNuLY2i@x1-carbon>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
 <20221108055544.1481583-5-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221108055544.1481583-5-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BYAPR04MB6021:EE_
x-ms-office365-filtering-correlation-id: f21fc94c-d462-4660-1da3-08daea3c19e1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eX/aJxN5fYeKvB0KVOV5R2TB1S+xegux5EEJrEhSM8TVTU1bg87HOM3n1o4bdMgQAy3Zs3A56sqElkPm6bKanCBhYZM/YcxLcr6dMk0eSh3m29jYILl4KncS7nOVLv4qzLwI12G/ZjWc2qL6AaMjLdENPyVUI5x8iFDWykMxkLsm4iQGLn1dywUVXVRNrxbLqo3hopSVptDFVf6ZH9inJ5te1vTIlFdRd9eyNp5nE+XmeTctNr5bGrt3+027TztMnFszqiSiwWoPdk/ySYF3UGcYY55Y8HfXwuHIpT7nuPAc+Yy09sjs07aIzNsZGlb5AhHNJCRvWmI9VG6GTJ6OkDXpE653YkqR/J6Q2koadrgYBucG/wtWlln3tuBULTDRr3SKBYjTO6I5yHrV1zH0/Qc1FQ2noQitxgDmOLGrjN6JTBYVv23ODEuSNDLgcG/qka+QIpvDVKd3MZeMrxTrNWDwVp3xpXGSzLRcy1YS2J7mCBQejzmcTv/ud84ACb3J4wfUB2lm5pXLhK6P/Xi+hSNy+1lDDJZaX8X00HBIj4J0n5v8DGll7W87UdT+U5sv8wYt6BlJ9ooOk4ERxgz7HGFfLo2cyaYNJ8SraerAz/2X0RQYrKJVFYhzjACvY8G9LIuIw4Q2WLWYH2S2Xr3b6S3vJ0ZnvT+mgmf0iXvkcqfU4aXW2fFbWZSaS1AN9W+HlFTyAp7SeSTxwaSrtYoAmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199015)(4326008)(478600001)(6486002)(2906002)(54906003)(316002)(71200400001)(82960400001)(83380400001)(38070700005)(38100700002)(122000001)(26005)(9686003)(6506007)(86362001)(33716001)(6512007)(186003)(8676002)(8936002)(6862004)(66476007)(66446008)(91956017)(66556008)(76116006)(66946007)(5660300002)(41300700001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UlsANSnSus20VXEBDewRQChwoS2qbnld08eS7gzFFoy8g4IfudidnTvSMSFw?=
 =?us-ascii?Q?/lhEDNcfWygWvTQ2HZIpnjxFw5SPZ05fqs4wRcFXI9EiG4ssiNlHIksr/ifN?=
 =?us-ascii?Q?D/pzXR+HNgDZ5+XnLJtfvOiS3VA1tkcI9+cA+6q5SFKLnu4WElttQ1yWALkl?=
 =?us-ascii?Q?fNfSikHSl/h/Jnh26g8ilalOA87wsZOU/nIqnrdkvT6P7d4s+5m/bUecL9wq?=
 =?us-ascii?Q?qUqevilkhOT2ZQ0oZgstPdiiqIBpiTvxN/UnwaXN1iCKbW0B1Dr6fZ5hkQ38?=
 =?us-ascii?Q?QIci311c0VS2Fj2FUb2e5E7Z95iRqYeFjaxQuKw49zq+BnObmdK0jiEB+ns0?=
 =?us-ascii?Q?neYedB2N0aYJJ0m6eKPcKcqUZzPkaNTMkC3eC3clK/OIixNjN22Ee+aWs6SI?=
 =?us-ascii?Q?KMm/QhYssIW+LTkjTMrQZjrhAjTVFSJhHIEK5JZCy02eHzEjPfIMWX2hB1Wy?=
 =?us-ascii?Q?KJNf5eJn7QxkC0u98PWmUhVGFV3Z7V9ySqU59oAOw7a7cYBgYMP7q++ZDii3?=
 =?us-ascii?Q?VYgS/JnxnZGZMw/bHlWlB2HL/nU+qu9aiIPHhj53ptJK02mL7Qz8s5Rw1XnN?=
 =?us-ascii?Q?ofobYtV23wbVN+JCiWptXT8uXgKQRg8MQW+WAickVJr8AjGykj7Ez1bjxqhZ?=
 =?us-ascii?Q?7nKdxNgI5O7H78FAkKbJfP1TWo3D59cMf/Du2u13aD/CNL+O4IBJn16QZAMS?=
 =?us-ascii?Q?rK6aE318lfsuTNaxA3GkPu6fXCqPzMvrHWgMJDbs3/kgELQVEKOdM/w/+JXI?=
 =?us-ascii?Q?1G9T9swfOH34MNrXN+3yw4pC5LGZ3NMSj/SmIl81eBbqB8GYCTu3TjwHu1xS?=
 =?us-ascii?Q?8Y+mBXctRZ29V3b3RoS2EYDlxPi7zwqNewUXyKjqFqySEaqDoteyuy+0eLRJ?=
 =?us-ascii?Q?5UlSdBO5hho02sMv10tFACLx5MP0lODrvW9z4usCDRJxKfwf0vQPEUUXmUi3?=
 =?us-ascii?Q?Go7O+YsJOJRo+POsGsATCB7JATx5w+8WptSE7NTodEt9HgM1o4XQqUI6PFld?=
 =?us-ascii?Q?CoXFmrAtgBCdNIlbFqLnEo8/BgyMbUu5YbrONp6QZu7vR3LeqcacbcP5qXRF?=
 =?us-ascii?Q?u1qNe10ll/uYYQOr7Uc9Xv31JKRHMCtgEQTBaZIJJvAow3txNhkbqriKz+am?=
 =?us-ascii?Q?/J34ht+OOTtdMWhWQzbaIeeFW8uJ9Qiv1qp9c/ASGq/V6ZVCM8HzEUOFqtA6?=
 =?us-ascii?Q?4pcvT1QHFj2COS5Ctwsy3087IS/HVuOKPojAYDZZUjYqZQNejsBwQRlV3T1V?=
 =?us-ascii?Q?GjuQTJKzSyBLtYJMAeFTg/jhRrNaEm0YZVQy62LfBlPP/Mvl0D1nYEhZkLBV?=
 =?us-ascii?Q?frr+d7377Nl46gpEWOGmbdrJoPrnXoswOv9bn8A7SO6I4xqaJhCGjncFe7dD?=
 =?us-ascii?Q?vqes+mTueMLI+zrUPCdyUdVn0sPixOuwC63OLtXKb2jsCS3ZS41gdJ6KQYbu?=
 =?us-ascii?Q?oWxiCHJt3OBrgCM9J/m62gcjokxFLSa86vg/yFgcHGKQ96CcNvJXVsXuALHP?=
 =?us-ascii?Q?F4hOzZLoupMOyxwPJ0m6j+lQBY4+s7tleUIKrqCfiGZATEO+XQo0YIbEHAFD?=
 =?us-ascii?Q?SsANgq5wYSkTwZZdYqAkXarlvUyvvksmqdOcyRcSwjTn+DxC5uTuP4ejHN9C?=
 =?us-ascii?Q?8w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B7CA9E7BD899714BA4FDED13197B4D7E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21fc94c-d462-4660-1da3-08daea3c19e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2022 08:01:47.8998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TslB82TvMqxH1VBZMVgIDCX5J1NB6qeGx7dKkd60A8a3j/pFCp7+TfIxbMbG6TdDUbtLZWv3T/Y55AysLw3rXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6021
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 08, 2022 at 02:55:41PM +0900, Damien Le Moal wrote:
> Move the detection of a device FUA support from
> ata_scsiop_mode_sense()/ata_dev_supports_fua() to device scan time in
> ata_dev_configure().
>=20
> The function ata_dev_config_fua() is introduced to detect if a device
> supports FUA and this support is indicated using the new device flag
> ATA_DFLAG_FUA.
>=20
> In order to blacklist known buggy devices, the horkage flag
> ATA_HORKAGE_NO_FUA is introduced. Similarly to other horkage flags, the
> libata.force=3D arguments "fua" and "nofua" are also introduced to allow
> a user to control this horkage flag through the "force" libata
> module parameter.
>=20
> The ATA_DFLAG_FUA device flag is set only and only if all the following
> conditions are met:
> * libata.fua module parameter is set to 1
> * The device supports the WRITE DMA FUA EXT command,
> * The device is not marked with the ATA_HORKAGE_NO_FUA flag, either from
>   the blacklist or set by the user with libata.force=3Dnofua
> * The device supports NCQ (while this is not mandated by the standards,
>   this restriction is introduced to avoid problems with older non-NCQ
>   devices).
>=20
> Enabling or diabling libata FUA support for all devices can now also be
> done using the "force=3D[no]fua" module parameter when libata.fua is set
> to 1.
>=20
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  .../admin-guide/kernel-parameters.txt         |  3 ++
>  drivers/ata/libata-core.c                     | 30 ++++++++++++++++++-
>  drivers/ata/libata-scsi.c                     | 30 ++-----------------
>  include/linux/libata.h                        |  8 +++--
>  4 files changed, 39 insertions(+), 32 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index a465d5242774..f9724642c703 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2786,6 +2786,9 @@
>  			* [no]setxfer: Indicate if transfer speed mode setting
>  			  should be skipped.
> =20
> +			* [no]fua: Disable or enable FUA (Force Unit Access)
> +			  support for devices supporting this feature.
> +
>  			* dump_id: Dump IDENTIFY data.
> =20
>  			* disable: Disable this device.
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 6ee1cbac3ab0..30adae16efff 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2422,6 +2422,28 @@ static void ata_dev_config_chs(struct ata_device *=
dev)
>  			     dev->heads, dev->sectors);
>  }
> =20
> +static void ata_dev_config_fua(struct ata_device *dev)
> +{
> +	/* Ignore FUA support if its use is disabled globally */
> +	if (!libata_fua)
> +		goto nofua;
> +
> +	/* Ignore devices without support for WRITE DMA FUA EXT */
> +	if (!(dev->flags & ATA_DFLAG_LBA48) || !ata_id_has_fua(dev->id))
> +		goto nofua;
> +
> +	/* Ignore known bad devices and devices that lack NCQ support */
> +	if (!ata_ncq_supported(dev) || (dev->horkage & ATA_HORKAGE_NO_FUA))
> +		goto nofua;
> +
> +	dev->flags |=3D ATA_DFLAG_FUA;
> +
> +	return;
> +
> +nofua:
> +	dev->flags &=3D ~ATA_DFLAG_FUA;
> +}
> +
>  static void ata_dev_config_devslp(struct ata_device *dev)
>  {
>  	u8 *sata_setting =3D dev->link->ap->sector_buf;
> @@ -2510,7 +2532,8 @@ static void ata_dev_print_features(struct ata_devic=
e *dev)
>  		return;
> =20
>  	ata_dev_info(dev,
> -		     "Features:%s%s%s%s%s%s\n",
> +		     "Features:%s%s%s%s%s%s%s\n",
> +		     dev->flags & ATA_DFLAG_FUA ? " FUA" : "",
>  		     dev->flags & ATA_DFLAG_TRUSTED ? " Trust" : "",
>  		     dev->flags & ATA_DFLAG_DA ? " Dev-Attention" : "",
>  		     dev->flags & ATA_DFLAG_DEVSLP ? " Dev-Sleep" : "",
> @@ -2671,6 +2694,7 @@ int ata_dev_configure(struct ata_device *dev)
>  			ata_dev_config_chs(dev);
>  		}
> =20
> +		ata_dev_config_fua(dev);
>  		ata_dev_config_devslp(dev);
>  		ata_dev_config_sense_reporting(dev);
>  		ata_dev_config_zac(dev);
> @@ -4105,6 +4129,9 @@ static const struct ata_blacklist_entry ata_device_=
blacklist [] =3D {
>  	 */
>  	{ "SATADOM-ML 3ME",		NULL,	ATA_HORKAGE_NO_LOG_DIR },
> =20
> +	/* Buggy FUA */
> +	{ "Maxtor",		"BANC1G10",	ATA_HORKAGE_NO_FUA },
> +
>  	/* End Marker */
>  	{ }
>  };
> @@ -6216,6 +6243,7 @@ static const struct ata_force_param force_tbl[] __i=
nitconst =3D {
>  	force_horkage_onoff(lpm,	ATA_HORKAGE_NOLPM),
>  	force_horkage_onoff(setxfer,	ATA_HORKAGE_NOSETXFER),
>  	force_horkage_on(dump_id,	ATA_HORKAGE_DUMP_ID),
> +	force_horkage_onoff(fua,	ATA_HORKAGE_NO_FUA),
> =20
>  	force_horkage_on(disable,	ATA_HORKAGE_DISABLE),
>  };
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 4cb914103382..69948e2a8f6d 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2240,30 +2240,6 @@ static unsigned int ata_msense_rw_recovery(u8 *buf=
, bool changeable)
>  	return sizeof(def_rw_recovery_mpage);
>  }
> =20
> -/*
> - * We can turn this into a real blacklist if it's needed, for now just
> - * blacklist any Maxtor BANC1G10 revision firmware
> - */
> -static int ata_dev_supports_fua(u16 *id)
> -{
> -	unsigned char model[ATA_ID_PROD_LEN + 1], fw[ATA_ID_FW_REV_LEN + 1];
> -
> -	if (!libata_fua)
> -		return 0;
> -	if (!ata_id_has_fua(id))
> -		return 0;
> -
> -	ata_id_c_string(id, model, ATA_ID_PROD, sizeof(model));
> -	ata_id_c_string(id, fw, ATA_ID_FW_REV, sizeof(fw));
> -
> -	if (strcmp(model, "Maxtor"))
> -		return 1;
> -	if (strcmp(fw, "BANC1G10"))
> -		return 1;
> -
> -	return 0; /* blacklisted */
> -}
> -
>  /**
>   *	ata_scsiop_mode_sense - Simulate MODE SENSE 6, 10 commands
>   *	@args: device IDENTIFY data / SCSI command of interest.
> @@ -2287,7 +2263,7 @@ static unsigned int ata_scsiop_mode_sense(struct at=
a_scsi_args *args, u8 *rbuf)
>  	};
>  	u8 pg, spg;
>  	unsigned int ebd, page_control, six_byte;
> -	u8 dpofua, bp =3D 0xff;
> +	u8 dpofua =3D 0, bp =3D 0xff;
>  	u16 fp;
> =20
>  	six_byte =3D (scsicmd[0] =3D=3D MODE_SENSE);
> @@ -2350,9 +2326,7 @@ static unsigned int ata_scsiop_mode_sense(struct at=
a_scsi_args *args, u8 *rbuf)
>  		goto invalid_fld;
>  	}
> =20
> -	dpofua =3D 0;
> -	if (ata_dev_supports_fua(args->id) && (dev->flags & ATA_DFLAG_LBA48) &&
> -	    (!(dev->flags & ATA_DFLAG_PIO) || dev->multi_count))
> +	if (dev->flags & ATA_DFLAG_FUA)
>  		dpofua =3D 1 << 4;
> =20
>  	if (six_byte) {
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 58651f565b36..d30c1288504d 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -91,6 +91,7 @@ enum {
>  	ATA_DFLAG_AN		=3D (1 << 7), /* AN configured */
>  	ATA_DFLAG_TRUSTED	=3D (1 << 8), /* device supports trusted send/recv */
>  	ATA_DFLAG_DMADIR	=3D (1 << 10), /* device requires DMADIR */
> +	ATA_DFLAG_FUA		=3D (1 << 11), /* device supports FUA */
>  	ATA_DFLAG_CFG_MASK	=3D (1 << 12) - 1,
> =20
>  	ATA_DFLAG_PIO		=3D (1 << 12), /* device limited to PIO mode */
> @@ -113,9 +114,9 @@ enum {
>  	ATA_DFLAG_D_SENSE	=3D (1 << 29), /* Descriptor sense requested */
>  	ATA_DFLAG_ZAC		=3D (1 << 30), /* ZAC device */
> =20
> -	ATA_DFLAG_FEATURES_MASK	=3D ATA_DFLAG_TRUSTED | ATA_DFLAG_DA | \
> -				  ATA_DFLAG_DEVSLP | ATA_DFLAG_NCQ_SEND_RECV | \
> -				  ATA_DFLAG_NCQ_PRIO,
> +	ATA_DFLAG_FEATURES_MASK	=3D (ATA_DFLAG_TRUSTED | ATA_DFLAG_DA |	\
> +				   ATA_DFLAG_DEVSLP | ATA_DFLAG_NCQ_SEND_RECV | \
> +				   ATA_DFLAG_NCQ_PRIO | ATA_DFLAG_FUA),
> =20
>  	ATA_DEV_UNKNOWN		=3D 0,	/* unknown device */
>  	ATA_DEV_ATA		=3D 1,	/* ATA device */
> @@ -381,6 +382,7 @@ enum {
>  	ATA_HORKAGE_NO_NCQ_ON_ATI =3D (1 << 27),	/* Disable NCQ on ATI chipset =
*/
>  	ATA_HORKAGE_NO_ID_DEV_LOG =3D (1 << 28),	/* Identify device log missing=
 */
>  	ATA_HORKAGE_NO_LOG_DIR	=3D (1 << 29),	/* Do not read log directory */
> +	ATA_HORKAGE_NO_FUA	=3D (1 << 30),	/* Do not use FUA */
> =20
>  	 /* DMA mask for user DMA control: User visible values; DO NOT
>  	    renumber */
> --=20
> 2.38.1
>=20

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
