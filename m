Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A5BC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 12:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F1B2081C
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 12:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="fY6JFo2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F1B2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeK2XSu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:18:50 -0500
Received: from mail-eopbgr690085.outbound.protection.outlook.com ([40.107.69.85]:55424
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726958AbeK2XSu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 18:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnVLf2UUr2E8vEvXhSns+IzS+CsdebnDGc1xVVIzhfg=;
 b=fY6JFo2jhMkkTXSgO7VmHOj8fffOsPM4bUsIwFvvyoYCqXr/lWJ1nh/iVIrDKHskcyDPmkmMVcvAE7i2GwhxsMr766dBBtqgP1VQn+sY6XP98cmR9jzpzXNRN803P1KrUWVsxkPJzY3GV/YhVrOCmbUO+1Qc7NDEfL2shjtbGHs=
Received: from DM6PR06MB5178.namprd06.prod.outlook.com (20.178.25.19) by
 DM6PR06MB4220.namprd06.prod.outlook.com (20.176.105.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Thu, 29 Nov 2018 12:12:58 +0000
Received: from DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c450:96ae:b322:78c7]) by DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c450:96ae:b322:78c7%4]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 12:12:58 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
CC:     =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH v4 0/5] lightnvm: Flexible metadata
Thread-Topic: [PATCH v4 0/5] lightnvm: Flexible metadata
Thread-Index: AQHUh7Qn0Sds2qThUEunIH67m0XBN6Vmqk+A
Date:   Thu, 29 Nov 2018 12:12:58 +0000
Message-ID: <CD519802-E510-49F9-9C56-91B853E11C10@cnexlabs.com>
References: <20181129071606.56942-1-igor.j.konopko@intel.com>
In-Reply-To: <20181129071606.56942-1-igor.j.konopko@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR06MB4220;6:5BjK7YUy0l0SA5X2cgfGBGcixglwk1MAtwXP2Ia5Y0PFoiY0G9caKIwyUflS6IWqad8Xft5d0D6SO0mJlo3M+vTI4PkDs618sRhh1RxC+n39aHrNzjgtWWNs6wNtPhdghXSDJY+Yl2a1STdLv3Pfcdl4550S1x7ZbBzEh+i5T/DmtoiudkmPWnLqchXJL1+QjZZeFQU/KXwAHmVzvTIXSOfAxPM9hxAGyA1wEMrzJp30TNn6hQib3wVyxG0SX3E4QQF2wywnvgZWzGlnvnqhIBMG8nR9HA1XAtQoFm8WiI+ljsRgSfUb6N1MyD/yqgu04WJb5V3rWvvLKw9ZQcTD7lCCnK1KWp2W9Ie1r+gm8Y0FjwI4boFridmr4QhiQlki/K+VyQqVCK2eBY32dj5vGWcXOzvZb59F3nP9ZLoWFZN1OVbATm/DriRoJReCODyOV4o8+0djm0aeX/qiAYEJ+w==;5:Uxjs+6vNsuWha4jckSSIi/F1Hf81GkdBWNy95jd+nj+yxHuW33Z9eyFiMkzJ4ebTmH7kghf6IeyEyEbw74A6SoDk9vTwIb6VDAi4TmVnQt3XA7+UWn61vZEftw1+vnShsMJSJjOSoFRWcLpJUUsGPvt49QZbx40JlOZfuUhBdYc=;7:aOYN0URagC8Va3Wb3c6cXf7NSL1Qu5VuKmCbqYrfJMyVZsXTWYXrFu7h5Ckgxfk7azOiVO9V3GRVT9F3XvK7C/4jAliqe4EEoxst3pRn6cceeRLRpaYi4Ki3Sj9VL3D380TE3KIq6dQ8BTThO09LhA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(136003)(39840400004)(199004)(189003)(105586002)(81166006)(106356001)(8676002)(107886003)(97736004)(53936002)(82746002)(6436002)(6486002)(14444005)(76176011)(6506007)(99286004)(14454004)(6512007)(2616005)(446003)(486006)(68736007)(11346002)(476003)(8936002)(256004)(6116002)(3846002)(99936001)(71200400001)(71190400001)(2906002)(83716004)(66066001)(81156014)(6246003)(5660300001)(25786009)(478600001)(186003)(316002)(36756003)(229853002)(26005)(33656002)(102836004)(7736002)(54906003)(305945005)(4326008)(6916009)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR06MB4220;H:DM6PR06MB5178.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: a3f6a994-f942-4955-34d4-08d655f4004a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(49563074)(7193020);SRVR:DM6PR06MB4220;
x-ms-traffictypediagnostic: DM6PR06MB4220:
x-microsoft-antispam-prvs: <DM6PR06MB42201F926599DE9AFDEC0733BAD20@DM6PR06MB4220.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(3231453)(999002)(944501410)(4983020)(52105112)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM6PR06MB4220;BCL:0;PCL:0;RULEID:;SRVR:DM6PR06MB4220;
x-forefront-prvs: 0871917CDA
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HePp31czEGQQ4bvAG/l/sX77kky6Nr5FVSqv4ZaiWDhY1rzxxBQcx7oFT+1ocVmqiQ+XFKECZmaHJdhk3z6FCXb27T5fhIz+gfW3OUOArsDqhgkBEh7lHrxeCYNdTWFwVLiJjVJA3DbCXwmwTdUHm+yNvbjvfh97nAf1IWcFdYoMeDEWRyMxyh2f/5QqHACPJ5nd1u6cD/MmoDzXbpCxLC+kpaavYzxdarL+zRVB6IQ4T3h3dGfxMGYMcRZuyK6iJZIvM4wg09ifvbumLgZDUbbOc2Q3zwC0onYpfvLM90nEhNsBW8ifGqMwhN4kRbn7Z+17GoX9Z2nL6FyCP9Toi8wTAjM3rhtGAG+Ld+Q9Nbo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_993CD4DE-521E-43BE-AF8A-A1FEC5E11030";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f6a994-f942-4955-34d4-08d655f4004a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 12:12:58.3327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4220
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--Apple-Mail=_993CD4DE-521E-43BE-AF8A-A1FEC5E11030
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 29 Nov 2018, at 08.16, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> This series of patches extends the way how pblk can
> store L2P sector metadata. After this set of changes
> any size of NVMe metadata is supported in pblk.
> Also there is an support for case without NVMe metadata.
>=20
> Changes v3 --> v4:
> -rename nvm_alloc_dma_pool() to nvm_create_dma_pool()
> -split pblk_get_meta() calls and lba setting into
> two operations for better core readability
> -fixing compilation with CONFIG_NVM disabled
> -getting rid of unnecessary memcpy for packed metadata
> on write path
> -support for drives with oob size >0 and <16B in packed
> metadata mode
> -minor commit message updates
>=20
> Changes v2 --> v3:
> -Rebase on top of ocssd/for-4.21/core
> -get/set_meta_lba helpers were removed
> -dma reallocation was replaced with single allocation
> -oob metadata size was added to pblk structure
> -proper checks on pblk creation were added
>=20
> Changes v1 --> v2:
> -Revert sector meta size back to 16b for pblk
> -Dma pool for larger oob meta are handled in core instead of pblk
> -Pblk oob meta helpers uses __le64 as input outpu instead of u64
> -Other minor fixes based on v1 patch review
>=20
> Igor Konopko (5):
>  lightnvm: pblk: Move lba list to partial read context
>  lightnvm: pblk: Helpers for OOB metadata
>  lightnvm: Flexible DMA pool entry size
>  lightnvm: Disable interleaved metadata
>  lightnvm: pblk: Support for packed metadata
>=20
> drivers/lightnvm/core.c          | 30 ++++++++++++------
> drivers/lightnvm/pblk-core.c     | 61 =
+++++++++++++++++++++++++++++++------
> drivers/lightnvm/pblk-init.c     | 44 +++++++++++++++++++++++++--
> drivers/lightnvm/pblk-map.c      | 20 +++++++-----
> drivers/lightnvm/pblk-rb.c       |  3 ++
> drivers/lightnvm/pblk-read.c     | 66 =
+++++++++++++++++++++++-----------------
> drivers/lightnvm/pblk-recovery.c | 25 +++++++++------
> drivers/lightnvm/pblk-sysfs.c    |  7 +++++
> drivers/lightnvm/pblk-write.c    |  9 +++---
> drivers/lightnvm/pblk.h          | 24 +++++++++++++--
> drivers/nvme/host/lightnvm.c     | 16 ++++++----
> include/linux/lightnvm.h         |  8 ++++-
> 12 files changed, 233 insertions(+), 80 deletions(-)
>=20
> --
> 2.14.5


I gave a pass to V4 and it looks good.

We will test the patches suite. If nothing comes up, and Matias does not
have any reservations, it should be good for 4.21.

Javier

--Apple-Mail=_993CD4DE-521E-43BE-AF8A-A1FEC5E11030
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlv/18cACgkQIX4xUKFR
nnQ54BAAoU5izGpUKGpAADQqQowG1Y5b5YA2bVXeIRkquGpIbGSuk08GWD5Q621q
3AK6MkER4SXrOKYFji1O1boH7nqVVzJwyZtc0YYsk/uP72JuDZaBpQcKefXP4ria
M24306sAB8d2Sa+TyV4HwnQpl5FdNN0WWJloJJ1N7Jwia045E/8+eeJ0M4BJhmZi
OLon9K+PJBeofNssyaDEf776KjmSeI8sF9CMQuVryhvQqkqaeNR5gBTnZ9fne9D4
HWrbvOFri4O14BpamUkXG+zFgJhpg52v0fQ2jgNafNOx7FNSnsMJCiobmu7PnpsE
6TDocBsAaSlvxJona0D7MXs3inAbk9wmEinzbkU8bP8Wte+Dz3lkFvWIyc40vcP6
v6fwHihNk999b1UbCt/ey9aTAroq4XWA+GAqbAg77v1ihYWPbnfQaeufKVcHceFA
RtZOAA+pmLPWuTWw0plefy7FzR8gquFjqCkKl9/wBh0zg3K4Rl97XyiURIEm62tl
4ZO5/VceesxEI5bTY+AbdvKXrRisbHtQtQbyNPmMPGDEw+GXENPTcln70c7fLzWK
5g/uHfTFbIcH1C6QaLK4TaSW1BkWmm+sn+is2Ufkqgw6eZSNI7I09WhtiavOEroB
yHoxiAk9SQUkY6UAM8YYTyfbhYM8m+o9MruiT+XLvjy9sKuEFmg=
=legm
-----END PGP SIGNATURE-----

--Apple-Mail=_993CD4DE-521E-43BE-AF8A-A1FEC5E11030--
