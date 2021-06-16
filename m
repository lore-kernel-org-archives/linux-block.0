Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670CBC48BE8
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 13:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505CC61241
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 13:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhFPNpt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 09:45:49 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:37158 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhFPNpt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 09:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623851023; x=1655387023;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AreVRW+qMpriUaKyd1Incm8IgT3mIczfo0GzQzChLcA=;
  b=QxzEM8qTzErvMELhgpw1zVRUzbCHMqfLcPta1e/2GV9eUe1RUYHOG9ZF
   DswA6ndEsjOTO1r/B7Bu+1uO2mKfpLaoy3D5IgWeuHkABbDfbK48sCTrr
   AbPf4vFqrppt35B4Yb40BjYy3Jf/b7LD2ZRJwzUYQZeuDuKdAMqyQsZtF
   HtliBJ2YFsGwl0f30Xm8pBSDSjr42G0xPMg0LFPGGzTT/xa18Zxd88A1u
   kiBbUehkqRONqGHYUkaeET8OHY8e9IjfdiYcqf3EPE9s4qhk6FCkPlYPY
   AR3JU11ivScJXcKh5nCW0kbzxPSNq5VUZITjlW4LzhIoElueXmizQmB89
   Q==;
IronPort-SDR: h9ntA3AlpPQPPSUpTuCkks20OTtpOVNyaJtpOWNccpnzsNhxr/nbPauds325mtZSaD5zubDnd3
 NXyt5C+dypX4euM+57YGVQQq5rrbmbhuLPRdidofr2s16ibLSnIBddmGKlPprT3cPIa9pG1EgF
 HVkM0XX35VEtOle/zm2ecsE5p5r89ZP1yWUWW/JX3eDwaS3hhaZ3UuoB5vSyeBXRDoSaOi0/9s
 pn364uPTT4OvF4CbUzJubR02S/eFj1XiwknjjTKKd2C/SgV3ToFSI9VvGNYBL3d0Ep7COFhXUd
 QRE=
X-IronPort-AV: E=Sophos;i="5.83,278,1616428800"; 
   d="scan'208";a="172662561"
Received: from mail-bn1nam07lp2041.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.41])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2021 21:43:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdVan+bjGz1KtwAn7VWldPod+QlY1rITtAkQW7SJv+5hEMpWTAEr1TVMPvylITWFN7r2JtVwcgi9BQumrDnabUToTipqqqjEodhNB7P96Pi9JFXbPnz9LSFNey2BOGQOAvhSgsFnf06XDxYtSXLt4JGeKvU/+CHHUPv1FeVQ+K4kAvlqKqS+me6KxrbT3ZsHgv5tRWoq+Nt10aYb74UjSk+QCNCVKPQgnYARm+fn9iDWQK/N0PcJcKO/tOwlnwswDKKUBQyneW//7btwjkqXOo3szMrh3/7XLUq8d6A9Vlju2DyK4DWfbYIktQY8ZNyKGWAtjYnn50PP7cBbfKB4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqVHqAngkwmZiF4xnHqDiQvyGTPyJ5xzTz9lRxUtscY=;
 b=iaF8ff3epPqELuoq/Uw4NDpVqGsBbY63abI0HNUuUO14U6WjtqMg54EyqkUDZXoLZTtCJ7XYSd3FJ+L5WkFCs4Ytc8Gmz4/zYS9tY3Os5Kj0bF1yw7UemNHLHtscUaeE/ny/f+w+PSphgFDxnA1aC0fpffrmnnlYyPqBXx5JACkZUpqHwCJJn/TCVT8byU6ezJjJ1UZayQd7nhQc9VfeUxE3VdIbA9N2iFA4qrKbGpISxdtlv0gnY0qy2o7nacg+cK4kIzqKp+hX2OUiW+mpv5R0JThXxy51mORil28am2NheRNkKkrS7j3OucgooJd4xcjTqcHbwGS6CF02F45JdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqVHqAngkwmZiF4xnHqDiQvyGTPyJ5xzTz9lRxUtscY=;
 b=QsCXNdVK4uFb+kttqdVTpWa4ZRj5dQuOai64UrR405h4Wu6M568l1hhGMZznnDuhocUpEI68rXguYzhSHgzk789n3ST0arUjSaXQi7yNX68zCKMMdRH5Z0sqHxCAnWVt8iIQ9efs1wDROl24+xKI66Wic503W8rezCFgmG1nsxk=
Received: from BYAPR04MB4056.namprd04.prod.outlook.com (2603:10b6:a02:b4::22)
 by BYAPR04MB6133.namprd04.prod.outlook.com (2603:10b6:a03:e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Wed, 16 Jun
 2021 13:43:40 +0000
Received: from BYAPR04MB4056.namprd04.prod.outlook.com
 ([fe80::fc71:bcb6:e18d:6973]) by BYAPR04MB4056.namprd04.prod.outlook.com
 ([fe80::fc71:bcb6:e18d:6973%5]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 13:43:40 +0000
From:   Aravind Ramesh <Aravind.Ramesh@wdc.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shaun Tancheff <shaun@tancheff.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] blk-zoned: allow BLKREPORTZONE without
 CAP_SYS_ADMIN
Thread-Topic: [PATCH v3 2/2] blk-zoned: allow BLKREPORTZONE without
 CAP_SYS_ADMIN
Thread-Index: AQHXYRgoQPSf84k1AUaPPMUo9Yx7E6sWqOwg
Date:   Wed, 16 Jun 2021 13:43:39 +0000
Message-ID: <BYAPR04MB40565D2E221DDAA74288577A8C0F9@BYAPR04MB4056.namprd04.prod.outlook.com>
References: <20210614122303.154378-1-Niklas.Cassel@wdc.com>
 <20210614122303.154378-3-Niklas.Cassel@wdc.com>
In-Reply-To: <20210614122303.154378-3-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [87.116.37.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60133fa9-ff83-4642-734d-08d930ccbfeb
x-ms-traffictypediagnostic: BYAPR04MB6133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB6133D6577FA7C5929F4E0D8E8C0F9@BYAPR04MB6133.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MlfngmFkWVCggkhY+aNRZzNSIE6y5TB2uKrmhML933UWO8TTY+ZfTf/aajBOn9EdBzw8Dn2Z9IXXxB5R9l/d0fDiaMf+5LUUmVBx9IjtUsKQxk8HOSOAFNTYdG3ukr2RShsHeOLzTFjhzUPtTI/qqYUq0feuMZ54MW3hvFepcntwFAXpGpo0yDz9rHeWtDOuLYp6Lmg7p54AebY6zhsHC9FWDN9WOwwiZQXEuOY/2s44rgdN6IEW+TqY6lqpOODkcBSwZvEONp/PfkV1xe759S6LWNwtUK5DL1L/AKkUhoKSiMOrAKLfnm2XsZ/3wqh2+lwoftHVw4lF9Zy3kr4pO2InzSFZ68xt1lgEHjggVDNNjtYAixHES84YF/iwomkTV1zy10kFN7imx8/MtxHvYCyQrk9wBTPNabIz4vBLRywvFoR3rbyBo4QLMTiFFMn61+oFSSTSeSO6eq1+bncypcDhWHH8uyCgix2elyiJFekyEiMRo7BKfDer1CVPhXF4kNL6d5i9uzX0jAnadaV1BAmvQUViEd1A+hpcX9AF3X/aOBjOF0hGilbD/2zSCsX3CI9yuT5kx3ZJQKxbRuG6In27g8qYFMYHr6ARGUwXycs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4056.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(316002)(76116006)(71200400001)(110136005)(54906003)(5660300002)(52536014)(26005)(186003)(8936002)(8676002)(66946007)(6506007)(53546011)(66476007)(66556008)(66446008)(64756008)(38100700002)(2906002)(86362001)(478600001)(83380400001)(33656002)(122000001)(55016002)(7696005)(9686003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ymO+UAwUPS5v4dcpBFMh4Jw4k3aYi6+5LgOQ7u6pUXfGMElVwDSyOwQMAzJe?=
 =?us-ascii?Q?DHjKcttEOCXoAsKLqWwWdnQaZstGAXq1CuDYlZM3N6DU1InZYQC/bOMgWaV3?=
 =?us-ascii?Q?RaSGKjN1XrjSdJ9HFqBvhdsrPzPeRVwVfGtVa5PZT8O4XTqRGWQzNQkPg5LV?=
 =?us-ascii?Q?QScS4GMLJcVzv/gVyTgFQfJl0Ob3y9me4RVtce0QAAhbVH2Bo9lbYXSA30qo?=
 =?us-ascii?Q?OEqFrMBB8Kgm0n7P15KgLa7AzK4Sb93Azo+MALszA9Ds3QDnZz46Oy+0gG5c?=
 =?us-ascii?Q?fsSAjNn6xB53JaxqBsuzKLmYXeptizzXHK8KoisEi9187TdhJMu4NzfkqRoU?=
 =?us-ascii?Q?0byfdsuS9EJSEZtjbbqDZ1yxIpnsQdVQW1cPfVuV4d9dcQm0dsmAOhrPGHgj?=
 =?us-ascii?Q?i9R86x/qv37GOVOfSeSfNnDleakf9k7qLHsGIgu8jzwhqzkqO27OvELNJG1Q?=
 =?us-ascii?Q?cIiq7S9P7KQtyy5Tz3NS5aILfAIK1NGtTqx4WrImDb7i4PSDM30FsKt19525?=
 =?us-ascii?Q?DUFP8XkGNdrJ+Xe9C1afoTEUIS6OSa0eEGAvmdSz/Sh3JNIeQHzgvydZrmrR?=
 =?us-ascii?Q?Z3tGmCQOvw+YTKlgl5rS6jJCmkJsxGfCd+UbScDw9MFJf89lCyYvXQvNOx/g?=
 =?us-ascii?Q?GEDKlyxUoy7fmC4Crxe+U0AZz9JqjYtFc7QV93Z0vF/1SWT3EEYkuEnnSqYJ?=
 =?us-ascii?Q?/LXCwmV3wrLR2F3Bnrxjdq3WnyyarWxW9Md42oQqFggwdSrKBiWbCGfnMaHZ?=
 =?us-ascii?Q?LsPwUgjpCueBeayYGXRrUIyzkpXXsCDKIia05/+D5GOF1D5Aa548RHce8HvY?=
 =?us-ascii?Q?WBKNmoVHsEvjuAEIleDoANCxZDsUAzvWzHHUdp7CusY8gmzDxC5jbIdD1x3c?=
 =?us-ascii?Q?AvBREOmN19yIDbmov4cGJEoly8buU1pfW/ntvUdRFZFJen8t2mxosy/4o9FA?=
 =?us-ascii?Q?c4+ondh6x1oO+a0KmIKwq2z8Ec6/h4TjqK94sXJDW9CYKL+j7MX1ZS4602CJ?=
 =?us-ascii?Q?UXYp7spXQHPl1fdSW13SiSd5oaIvc4JL8Sd2PMqLJmfV7TX89EJjk/Oox1/9?=
 =?us-ascii?Q?a7DocvBaUwzFqtxvMyyrw7Tmvbs26vswn7psGxKASL88O3jMhxHVEJKmt9J2?=
 =?us-ascii?Q?rsG42UIZtSbyAWh57aYLoT0hoHa43qx2TPrno3/+RHlLz2iMJuLXM/oJbiHR?=
 =?us-ascii?Q?xqFf3lCyP4iAzDH9x6Bm/cSnZFjyX4iwHRRsJJiAERBkroylxft3zlIZfxjM?=
 =?us-ascii?Q?1WPgXIvk1Bt44YvkuGB4jls52h9gTwqzj4Hhdp6fuUh1By6lpQPYLprFEdmm?=
 =?us-ascii?Q?TUM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4056.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60133fa9-ff83-4642-734d-08d930ccbfeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 13:43:40.0066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vKHns7yR1HZFSlAUxAaJeS41IpxTYLT+Iy8K99egIc8iYhpl4b/g+h2TTyl+ZHW9V0aGtzC62LKa7VWjjktkGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6133
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> -----Original Message-----
> From: Niklas Cassel <Niklas.Cassel@wdc.com>
> Sent: Monday, June 14, 2021 5:53 PM
> To: Jens Axboe <axboe@kernel.dk>; Hannes Reinecke <hare@suse.com>; Martin=
 K.
> Petersen <martin.petersen@oracle.com>; Damien Le Moal
> <Damien.LeMoal@wdc.com>; Shaun Tancheff <shaun@tancheff.com>
> Cc: Damien Le Moal <Damien.LeMoal@wdc.com>; Niklas Cassel
> <Niklas.Cassel@wdc.com>; stable@vger.kernel.org; Jens Axboe <axboe@fb.com=
>;
> linux-block@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v3 2/2] blk-zoned: allow BLKREPORTZONE without
> CAP_SYS_ADMIN
>=20
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> A user space process should not need the CAP_SYS_ADMIN capability set in =
order to
> perform a BLKREPORTZONE ioctl.
>=20
> Getting the zone report is required in order to get the write pointer.
> Neither read() nor write() requires CAP_SYS_ADMIN, so it is reasonable th=
at a user
> space process that can read/write from/to the device, also can get the wr=
ite pointer.
> (Since e.g. writes have to be at the write
> pointer.)
>=20
> Fixes: 3ed05a987e0f ("blk-zoned: implement ioctls")
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Cc: stable@vger.kernel.org # v4.10+
> ---
> Changes since v2:
> -Drop the FMODE_READ check. Right now it is possible to open() the device=
 with
> O_WRONLY and get the zone report from that fd. Therefore adding a FMODE_R=
EAD
> check on BLKREPORTZONE would break existing applications. Instead, just r=
emove
> the existing CAP_SYS_ADMIN check.
>=20
>  block/blk-zoned.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c index
> 0789e6e9f7db..457eceabed2e 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -288,9 +288,6 @@ int blkdev_report_zones_ioctl(struct block_device *bd=
ev,
> fmode_t mode,
>  	if (!blk_queue_is_zoned(q))
>  		return -ENOTTY;
>=20
> -	if (!capable(CAP_SYS_ADMIN))
> -		return -EACCES;
> -
>  	if (copy_from_user(&rep, argp, sizeof(struct blk_zone_report)))
>  		return -EFAULT;
>=20
> --
> 2.31.1

Looks good,

Reviewed-by: Aravind Ramesh <aravind.ramesh@wdc.com>
