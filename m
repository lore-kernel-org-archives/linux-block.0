Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33110C4708E
	for <linux-block@archiver.kernel.org>; Fri, 30 Dec 2022 10:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiL3Kyn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Dec 2022 05:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiL3Kym (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Dec 2022 05:54:42 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A401A390;
        Fri, 30 Dec 2022 02:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672397680; x=1703933680;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LqjZTqEarypCyTq4LzqJwnKhCTuSnoqr/5pTFaeJ4ak=;
  b=K3/lpHmPxJP1PM9E9nBmni0X6qnA6ZO0kWMttYoQYA+XBv29sandu+dX
   xShJAYlKypERN1h9YQ1qHGuttPnTcptndRmqwZM0uYpaDdV5LDXgmOPoG
   EiVTc8VaWQO0aUMobnDy8b7Hw16gxTwdvGZT2mVHN1rEoqvjsGVCWFUi9
   AWv8dG2eEK4u61Q3Z+JNBGP8d2zbjZ/mNIxNvj7gV7GPR52y4Xqz/R4k9
   nu1KzBroRH30soAOdqL0hjuI5/J80I+7eEBA+28JYo3ZcIAGEHUDHqXkO
   ZGXt+c31UAHZLgvG3m3EfdK0fyjpjZwTdC2jt+RZVNGikxtZ0XppfdAVo
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,287,1665417600"; 
   d="scan'208";a="219639741"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2022 18:54:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUgPlhQ5yGF2f4yytc9KT7JnVBFRZjBuZ0VrSO3HT0HxwZEVKx6y/DVJl7QW9P0imj5djGUtu8vuG/B+zuS0F26YXYXAc5Q6+hhG0QFoSUJlxFOLtb2JaWn7w+c+eZkOoV/gtIPBofDo+s89gpaiMJNvxswlrRGsN9oBMywjP6hq4H9ylnhKUtAL/2EQNlFukNNWOQSyujTD/2ja4snsC6+a1zOO9fRWWJe68O7FPkA0nnOF/tBCRgpDk4aarOcB6BLzcwBqcvzgSb+Ye89f3oPJCEKQTLdlqYFxyzGKBGCreaownzuh2MlzELZo8idqEulV8BMyai5D2TPeDPfDKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPhjbF87HYuhSx+udQ6dwYdRMAdzI2izxAoy1a8hQxE=;
 b=kBuvKZdzDKWb6RQgWfrdt7v0nw4DlHv7D0yqbzeeJJ9N7iLv6pLYBdJHicLP+XzqY8kGXqzea/m66FRFkW15eJXGqvQEG3IJmPLLcMpfnMT2KP3pvzRbkHOlthS2Gh7WUwFsv4AXmKzI72EKbKbM3QkaObvnd9V0VJoIzlFwFTHN0qlEK72uisGi5XD1FgEmR4qNBR1a/foLLTUH4gYcrupIlWhJK2OTrjWMj5c6ezIia9RpI2MAKoFssZ1tWORWEAhKy2j9nHaZu3PH1uVakz56ktp7B5wfj+JkV6FgCKICkO5IIg5al4rZ79uMWlXR0wrMnko67/dTVDbwoke/sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPhjbF87HYuhSx+udQ6dwYdRMAdzI2izxAoy1a8hQxE=;
 b=y7dBG3JN08GpdwZzGFJOSj09bfgIAU7KiKwB6MfaBKHToLKZD3eXjB/rDvdt+tvFEaD/FU38NBSSzYHIYjiXOb/KgDu8psH0CKItIC2OG1nODgLtm8eLehrT712nZNqq9XzJpVTn8wfrFMKL+ck2QfiEZ249/zP0RECX466MqAM=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by MWHPR0401MB3657.namprd04.prod.outlook.com (2603:10b6:301:80::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 10:54:35 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5944.016; Fri, 30 Dec 2022
 10:54:34 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 7/7] ata: libata: Enable fua support by default
Thread-Topic: [PATCH v6 7/7] ata: libata: Enable fua support by default
Thread-Index: AQHZHD0aq7+4wKWoQkiyzEvhMhy44g==
Date:   Fri, 30 Dec 2022 10:54:34 +0000
Message-ID: <Y67DaUBSFBU9xoIU@x1-carbon>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
 <20221108055544.1481583-8-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221108055544.1481583-8-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|MWHPR0401MB3657:EE_
x-ms-office365-filtering-correlation-id: 00e89711-512b-44a7-dc45-08daea543cbe
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KYXvl7WSS19gFbejcnGe0F9VORaa13rEZr0SNYJYsjjwUxT9/MsEYtQzMtXXmd9gKNsFikpvpaYVCC+78hDL81VWPKGHAoD9UMJap5Wh8ehBW21W2MYFDfiu7zCu0s3pQZcZ+JOHTsI7zyTBHPg5ouqO63CJ31Hzvu7mL6Gc98Goy4luBFkGDvDhYgZfPrrA/4E9m1xoQXvphSSXPDLOsJUHGUnkUTtnaKfhfA/OZ7IBY3QCRd1VbbVkpUMigJTsaK/TgIGy4rZ6ZrDjn1Ob0GbVh/GNzOecH4IE8t2skCR2AozLYuuk0qijeVYH8Q0+2g+WYeHbRsSGx0MdpdoOO974RhXwOEaVJCztjnIdUVJN0qQPjDxRSAvWlJPQ2f5SUG3evkLWdgTQeYa/gCSnrdgXO0fFy+mDgPbR5Corlw61wSGGQ6m9U69fitt0w2UheEdFLF2h3E5s25x9sIN4qAChg9EdVOH/YDkQfho2RoRVcQ8WLAO/n8UOfASxkrAWbZCblzo2DuQRPgsybyOJqUIG+bdqzh+7nimoOUXXbmC58TohaStCRETGTJqUth/yabHmD8uYH8sRyOLJtLPXqUfLg1Ex07ICkXVyqrFj4iDoSFUnI144RBioz0GgmZwO2+9JF7bc3hD6d7Hf5iv465SjjXzqp2dkSG5selBtF4Uj9lDgK4vn26jmXP9TghCqA7ZIg2YSEk+howefWzb+lw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199015)(33716001)(122000001)(41300700001)(8676002)(8936002)(66946007)(6862004)(5660300002)(4326008)(66556008)(64756008)(66446008)(76116006)(86362001)(66476007)(2906002)(91956017)(54906003)(6506007)(82960400001)(71200400001)(316002)(38100700002)(38070700005)(478600001)(6486002)(83380400001)(186003)(6512007)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XF3CP7yMPEMFKBfLiIBFeX2q1coKj8DuXrT4NODG2OGFvu5wuB+eYx614XZ+?=
 =?us-ascii?Q?WqeX2csD4bibQMAnCyAh/UpobCEcKiqyzONbNVYu3UB9e10vGX7DywSGuoGR?=
 =?us-ascii?Q?3TXnldqmg3gRP2Tv8D4Pi3oXn2ML1az0LBAVE9MhNMmUjJnJwEEBe6lM3Gu5?=
 =?us-ascii?Q?wN6XUYvUn+Jjy8/t+6ts4cpFCO2gI/GJHkjJEVM3hAmezR4eLJPLVem3/WXl?=
 =?us-ascii?Q?kQ+Mp2EoKsSDtimtZZtppsP4b1HlB552DIMPRzZLKUxoZ+u80vREyzF3u0fh?=
 =?us-ascii?Q?O91/CRnxkj0qUfbll3bKlKaai9iju/cpLR8FsoIPO4L+g8EN2eKqpDsrJUtz?=
 =?us-ascii?Q?Ypxq2FselbukDBWkAtEQW1wkVvubuQzj3G7bPXVmGlEVUHhpTkgoU0/Oo8tJ?=
 =?us-ascii?Q?KYEaB0AgBYxKVXRxCU7PtrJ8ZPByqI8ibPdni/qNUgkDBlVE0VotlLX5uVZc?=
 =?us-ascii?Q?hu17xsVoC7kVntrHjuC4Fu9SM8oPf3cyRSYRkGIhS3WyaYweoj82wiuZiXuH?=
 =?us-ascii?Q?O3FxARl5iBfztqcGBUaklna1FFMi3daw0caH+pDUZLGeNCfVi+F/vASjdJHN?=
 =?us-ascii?Q?GwHfS9saAOfIl3aRlHOSdSfc7WuyLP0wK/ZwC1EDPJ5zd2zsBSPxgwj4g9KL?=
 =?us-ascii?Q?DuNA1mHT0U7bV1oKWLhGjXj/2vPr5Lbixy1rxRA4Si4DtjQNc7iGqhPmFtYH?=
 =?us-ascii?Q?Hyb4NKDE9Mtxt0UPm0Zx3sU3cDA4j3YMoL+fRM5KB7Ae2brEbZvGyp/hkbs2?=
 =?us-ascii?Q?tyQS4WJHxTYrJ8O7CL7TKxEF3MlaGtP1d9AkbSu0OJk1toFTz/1BWon2uQ0r?=
 =?us-ascii?Q?HSQYB6cYp/YKoV+aLpXWL1FEC4fgIoF13p+CR2WySa2ZyeQGerExdw8ANJ9O?=
 =?us-ascii?Q?z11OgIArrHLSfTgNu0K6MnbCb6I7//mY818+b9bPy34b1RT2TEu7/AjFG1B9?=
 =?us-ascii?Q?Stucb2tvq40qA7Rb0wQ4kkIteldxRjJqoJmYaEZHt3Hpex13hSCCgDzB1aoV?=
 =?us-ascii?Q?dodS2gI8MarHSEhC7X0lVJsZPFs8OrAmPA7uNcypAyuD9hcS0xTEtwOpAbW6?=
 =?us-ascii?Q?J1TPn3q6wDl2UDJZ4TPvj2uxtQ4zyS4EeeoOiPptYnKAQNp48a6f6+GrH6P/?=
 =?us-ascii?Q?sN2Mxu3I/cQrTKw3yuh58HKj3lpXMRBK29u2OA52CGcQ0lSy2QYUsKClc2Pg?=
 =?us-ascii?Q?dDg6cx8eW53D8l0YdGswxUSoYqaTp2jukNpp4q2uKtzuRZvoo2cVKgxoBzgm?=
 =?us-ascii?Q?NZAT0EdwU9UbdODKtYX+jghD/Ph8scOBLIA+FsNl1L/kEznfGCOGe0OxMC6D?=
 =?us-ascii?Q?SLkBN4Db2dIiLUgVhwtMcmxI0SpTben0qN4XEIphF8W61h1kPkNCSoCClNY4?=
 =?us-ascii?Q?gIqCkL7tGdo6V/aw33V8ERPGv9qk7NbFK02jEjOCNhddWaTUjSAq+F8K9zXU?=
 =?us-ascii?Q?XPQ1qoIgwFa1g0J9TdGn3YoWFChHqU5HIr8tXoHouJ+EtICbOxwtIN17Y0ne?=
 =?us-ascii?Q?OOIayrc9kLt5VygeZO5UXKYzSiy7enNq5R0V+1W4mB8ANk4aDuh5xlBrE+Eq?=
 =?us-ascii?Q?NKSF67D09gwel5fByfe7Mt3wO7kkJOiKxZcQhJlSSy9GRmBPokxCtzRr2axK?=
 =?us-ascii?Q?KA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <90699B94ED40DA418F5E47A216F9772F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e89711-512b-44a7-dc45-08daea543cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2022 10:54:34.3483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T86sCVzjFoj+B6WyHcT8Y/w35uG5n9TCa3q7STeEXlM0nGM5lWA4P731AAj7FWJJTSrKa/yv5bRKeTjF3uhDdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0401MB3657
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 08, 2022 at 02:55:44PM +0900, Damien Le Moal wrote:
> Change the default value of the fua module parameter to 1 to enable fua
> support by default for all devices supporting it.
>=20
> FUA support can be disabled for individual drives using the
> force=3D[ID]nofua libata module argument.
>=20
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/ata/libata-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 97ade977b830..2967671131d2 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -127,9 +127,9 @@ int atapi_passthru16 =3D 1;
>  module_param(atapi_passthru16, int, 0444);
>  MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI dev=
ices (0=3Doff, 1=3Don [default])");
> =20
> -int libata_fua =3D 0;
> +int libata_fua =3D 1;
>  module_param_named(fua, libata_fua, int, 0444);
> -MODULE_PARM_DESC(fua, "FUA support (0=3Doff [default], 1=3Don)");
> +MODULE_PARM_DESC(fua, "FUA support (0=3Doff, 1=3Don [default])");
> =20
>  static int ata_ignore_hpa;
>  module_param_named(ignore_hpa, ata_ignore_hpa, int, 0644);
> --=20
> 2.38.1
>=20

Before this commit:
-For a SCSI mode sense:
 FUA bit will not get set in the simulated SCSI cmd output buffer,
 since ATA_DFLAG_FUA is not be set, since libata_fua =3D=3D 0.
-For a SCSI WRITE_16 / WRITE_16 command:
 ata_scsi_rw_xlat() sets ATA_TFLAG_FUA, regardless if ATA_DFLAG_FUA
 is set or not. ata_set_rwcmd_protocol() will return a FUA command
 as long as ATA_TFLAG_FUA is set.

After this commit:
-For a SCSI mode sense:
 FUA bit will get set in the simulated SCSI cmd output buffer,
 since ATA_DFLAG_FUA is set, since libata_fua =3D=3D 1.
-For a SCSI WRITE_16 / WRITE_16 command:
 ata_scsi_rw_xlat() sets ATA_TFLAG_FUA, regardless if ATA_DFLAG_FUA
 is set or not. ata_set_rwcmd_protocol() will return a FUA command
 as long as ATA_TFLAG_FUA is set.


Perhaps this commit should more clearly say that this commit only affects
the simulated output for a SCSI mode sense command?

Currently, the commit message is a bit misleading, since it makes the
reader think that a SCSI write command with the FUA bit was not propagated
to the device before this commit, which AFAICT, is not true.

If the intention of this series was to only send a ATA write command to
the device, if the device has the ATA_DFLAG_FUA flag set, then perhaps the
series should include a new commit which either:
-Adds a check to ata_scsi_rw_xlat() so that it only sets ATA_TFLAG_FUA if
ATA_DFLAG_FUA is set;
or
-Adds a check to ata_scsi_rw_xlat() which returns an error if the SCSI
command has the FUA bit set, but ATA_DFLAG_FUA is not set.


Kind regards,
Niklas=
