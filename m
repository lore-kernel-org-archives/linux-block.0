Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AA6C64E90
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 02:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0524820809
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 02:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R3h0ygRm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ITCont+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgLACUv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 21:20:51 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:24223 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgLACUu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 21:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606789250; x=1638325250;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8u22uwBocfrm6tbVxO2ERMqv5yLKxOb/4Rhm4lfXyrM=;
  b=R3h0ygRm1KUVW1G3xb5+PF2x5NVtq9PW8mxd0fZj5N4bgcntF1+SBzWV
   8zSj+4jxRA48u5hHzoBhw5jcQc5ftNPgU/VTo50kARGEqaEgHxHnjuqoQ
   0vLbWtWyu2BbQEz1JvX8bWcbcfOrFEhbgNpAblUKcRl5DKoEy6gUkVaDA
   LLotzgGIa7WEgdPM6R4KJAj4bLQsZKk+qXRzoibUkZck9qzT1Q+fjJgxx
   DEbLLaUJmLPVQ90F5iii75H4J2PWdeIZ/rZxe6ykyhbUpl8Ve0s7bZliq
   yJIBu+esKskRjwQkHkK5q1BLMFXb2q9LgoFw20cf35+7aCmlw1JoZTnOA
   g==;
IronPort-SDR: srHWuvpSDHjsZT+D2qHuJLWd7Hv1WY+0ojUz/+i7HQJqhNAp4r4jpxTl/JTJO09FwkzxJWcpVj
 tRP+1q1ksOD7kIbBpGfG6VRXuNiSVn59U1V4m1fbF/M+VSqP/YiBUotB0S/njyUOmL1mHcCnw4
 z1jMpf976R1dhKj8vlhmuyCI4VoIRvuMlXSCjq9Akft2yteJZvu3UHzPTZs7I38IzY7GXTI+L9
 NsPnkjOFO/Usyk6B+hzOiTgIfEe51ObNydMCBXyJ0dyJVTwmubKf8wENPkbfFHj+OVqEE9UTJI
 vwQ=
X-IronPort-AV: E=Sophos;i="5.78,382,1599494400"; 
   d="scan'208";a="158338584"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 10:19:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbXxk8QhGPRasaQKsV8p1kKlmBDVL6mH64LUj6DVZ66zENzJiFgZiFtHZZAXG5awGNCOC8llsN4wyaVHBmVvsZExj7YHxQw2fXqopyr1yzYwTmGb0X4UDkP7Cc6xLoHQrY4t983kvYJ1gT6KzpxTw/OL7oHbU8bDhwc9f0rQ0rbsz6RlVY4+vY9UwbOHJtKCz2POZCsR83jLTPOhHnjqp3dvsl1dIWFFXQjay65Bg0ZOTTfBbojcYidVfK/9IjwcJiBJLjTBO5h444QsW51gYUmRgANPjKAEdAKth9hQl0Cp5ug7NYioMovGn1xKISPfFslXuyfqZJKZ6kZrC10RfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXGYOCDs8yjdLawA+FGV/xkn7i2x2FgzR3ZMQgrHoL0=;
 b=mQ7cQtHaInzZ533JHGNxyXg8yHO8lbH/AnVl1Ag3x1/DxT1M/vtnH0IBz2CD9QZc2A3qjalo8uFrAk9BcobgQUewSWxM1kYju20BaPrnR5KwoL+Q/W88EbuxRMxmfm9PHtDsOUqXcCEpoNRGBLkvKCuwg8UWKwrscxNdB1LQsBGAsJ6QdjzdRRs2tjxEKmi2USlXFWGUfmZ+HAYA2ekIOL1bYAVUybY8M0UDw1Xke8L9ToCXrXhRUo6Huc+ZfQv7dJo0WGKHj9Cm1GigtplfLH2fTRTfTxyedvA39o3bOEuDuG6189w0jfImcklG9yJ0qdE6swgWYC/QU0oEMaA/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXGYOCDs8yjdLawA+FGV/xkn7i2x2FgzR3ZMQgrHoL0=;
 b=ITCont+pTBc0DbtMPImvmwE5QE9yU3EZZtWIb7WKYvVzKwBcJVFfOgbNqEjMAlD+pX7DZFMIbqDNP8FgcIdfDWj1cPKBzdauHmU4902LofI62qskhr9ThC6PhrZkh2zVwPGVFCDBL4gxW3Ao+fjWKMN+sUA0mEpl2joKe8qKo8s=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7015.namprd04.prod.outlook.com (2603:10b6:610:95::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Tue, 1 Dec
 2020 02:19:42 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Tue, 1 Dec 2020
 02:19:42 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 0/9] null_blk fixes, improvements and cleanup
Thread-Topic: [PATCH v4 0/9] null_blk fixes, improvements and cleanup
Thread-Index: AQHWvuCE62oitkQP2EGTL15SsbBFhw==
Date:   Tue, 1 Dec 2020 02:19:42 +0000
Message-ID: <CH2PR04MB65222B3A9EC649456A362450E7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201120015519.276820-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 506d089e-c7dc-462b-03d0-08d8959f9081
x-ms-traffictypediagnostic: CH2PR04MB7015:
x-microsoft-antispam-prvs: <CH2PR04MB701587241211F3D8F93A5D45E7F40@CH2PR04MB7015.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:404;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ypBCaqCnXhGA3UHIY3FYrJIbf3ra1i26lcEqRKZgHPpz5r7PXXue8w3wDv6MW1diJF8LpN2zIlG8JoTQkCdP1CLbq0dzwsCENBQJ9jEsJR1+FkI4vGQA50R3rBODoZfFjjMp13x+6YIARPIlmgOhN7+XerOmIGRfw42olI2RYSa1D2aw3v3ROxupV7/AkdMS9N+EvqzWnsLODvYVwjkVGjLJNWIc394UnCecCsDcXw/hdTOMNBjPG0wGNY/Dplwn1vbaS0bkqxvT4/cL+b9M7sopaMOQQDODMNmnKBfQfARryk3SiX6FlF+E5r+av60n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(53546011)(55016002)(316002)(9686003)(8936002)(8676002)(110136005)(26005)(2906002)(6506007)(186003)(66476007)(66556008)(66446008)(83380400001)(64756008)(7696005)(91956017)(71200400001)(33656002)(86362001)(478600001)(5660300002)(76116006)(66946007)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IR2WbnwH9o/pRqmMoM/Y1PvP4gjn5u2R2ghhQ6vebOJLg40kmpSF8ttniYec?=
 =?us-ascii?Q?BhcwO5MKF4xGzb/FNVo9oXsHomXW0dwV4AbAZsZoCyBVPU9/G5Ami+vlH3vn?=
 =?us-ascii?Q?6ZOEOD9j4q9LLzWDHZcnxtQLo/ahDLcCLsoh933PQpN5OyWerfIxfSNVpKEY?=
 =?us-ascii?Q?mUYsMxHf/SNMHzb1e7y7YCy42ugbcOxA2YlTRldPdyLMiG2cNOXBF6ROdneX?=
 =?us-ascii?Q?rc5c5gU428+Tc+1b0GKMLcga79l/k5S9BJWJlcjQ48393F30YS5Qj4GhfMm/?=
 =?us-ascii?Q?z+2cFj7vLfptHGuZRlHtIAmNnptk7SU4pfttABSwHH7xgnPtcvaDUEHq9H/x?=
 =?us-ascii?Q?8LbPUQwU6NswH8qyd+izrUMD63JAlVrGb/D7MMhY6WQDr/srYV6QBx0o628W?=
 =?us-ascii?Q?3O0olqR2cEtgQXH1v7Of7vE7TKAnvFtjAcNlwbmo6iKNFjaCRzjaomAgvTjh?=
 =?us-ascii?Q?+TuFjDOhgu3wBO0X+Dd4YQyNaz/rR8SSCPKpj1ydS042eDFYiDTocjtkPpvl?=
 =?us-ascii?Q?8CyFRGr/6Ne+xEzLATdObK4wBiY+/p/DoEL5QINYcjoiGvMlKpLKrsKvNVCB?=
 =?us-ascii?Q?PlDLyaaeOTHsdbRcH2Z5cyvGLZBHvx5C7MDv2V3AxV5kI077TCjhb0d2ZL/+?=
 =?us-ascii?Q?sb/GTP7XpQbZIS2givFBpwnydEGT5MDCq+Oow3JO3h4+ETVR2w2GUgs2WPr4?=
 =?us-ascii?Q?xMnlLzk+bRsY/eKBsJMsviLwo1VeqcrxIjOn89GKWIvwotLDYO9dATpWLde+?=
 =?us-ascii?Q?OX1GlMHRESteWt3UR7944m2QqQKq3nIMJ/GO4QcUmXbteVLXFGc+8ZqAwP8Z?=
 =?us-ascii?Q?Rf018Fm5fTKEQaMU/L9ENpXqCxYaRHC/r9pad4mcdKhS0+PCCeueUMC6MzXQ?=
 =?us-ascii?Q?G8+E9FXO81qSrK9wwRL2328GwWeFb9kn2iloSS4XRJSHZMnzAmDKW/DNDVQ9?=
 =?us-ascii?Q?VPSksVq1pPKp3OEHEejqUdHxrpzgVRdVZRusklx43hOXf7ZXEb4BeEnnjU9D?=
 =?us-ascii?Q?1KtZ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506d089e-c7dc-462b-03d0-08d8959f9081
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 02:19:42.8274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XRi9Vz+ZTcO5xhzh2eBeMzEiGcz3IUdFpehSwPfgWIBwpmu7t7VhdNhXXLAEj6+YkKDyBDhYQbDONaEt2eX2WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7015
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/20 10:57, Damien Le Moal wrote:=0A=
> Jens,=0A=
> =0A=
> This series provides fixes and improvements for null_blk.=0A=
> =0A=
> The first two patches are bug fixes which likely should go into 5.10.=0A=
> The first patch fixes a problem with zone initialization when the=0A=
> device capacity is not a multiple of the zone size and the second=0A=
> patch fixes zone append handling.=0A=
> =0A=
> The following patches are improvements and cleanups:=0A=
> * Patch 3 makes sure that the device max_sectors limit is aligned to the=
=0A=
>   block size.=0A=
> * Patch 4 improves zone locking overall, and especially the memory=0A=
>   backing disabled case by introducing a spinlock array to implement a=0A=
>   per zone lock in place of a global lock. With this patch, write=0A=
>   performance remains mostly unchanged, but read performance with a=0A=
>   multi-queue setup more than double from 1.3 MIOPS to 3.3 MIOPS (4K=0A=
>   random reads to zones with fio zonemode=3Dzbd).=0A=
> * Patch 5 improves implicit zone close=0A=
> * Patch 6 and 7 cleanup discard handling code and use that code to free=
=0A=
>   the memory backing a zone that is being reset.=0A=
> * Patch 8 adds the max_sectors configuration option to allow changing=0A=
>   the max_sectors/max_hw_sectors of the device.=0A=
> * Finally, patch 9 moves nullblk into its own directory under=0A=
>   drivers/block/null_blk/=0A=
> =0A=
> Comments are as always welcome.=0A=
> =0A=
> Changes from v3:=0A=
> * Use inline function for zone res lock instead of macro as suggested by=
=0A=
>   Christoph.=0A=
> * Added Reviewed-by tags=0A=
> =0A=
> Changes from v2:=0A=
> * Make patch 3 a generic blk-settings fix=0A=
> * Reworked patch 4 zone locking as suggested by Christoph=0A=
> * Small change in patch 6 as suggested by Christoph=0A=
> =0A=
> Changes from v1:=0A=
> * Added patch 2, 3 and 8.=0A=
> * Fix the last patch as suggested by Bart (file names under=0A=
>   driver/block/null_blk/)=0A=
> * Reworded patch 1 commit message to more correctly describe the=0A=
>   problem.=0A=
> =0A=
> Damien Le Moal (9):=0A=
>   null_blk: Fix zone size initialization=0A=
>   null_blk: Fail zone append to conventional zones=0A=
>   block: Align max_hw_sectors to logical blocksize=0A=
>   null_blk: improve zone locking=0A=
>   null_blk: Improve implicit zone close=0A=
>   null_blk: cleanup discard handling=0A=
>   null_blk: discard zones on reset=0A=
>   null_blk: Allow controlling max_hw_sectors limit=0A=
>   null_blk: Move driver into its own directory=0A=
> =0A=
>  block/blk-settings.c                          |  23 +-=0A=
>  drivers/block/Kconfig                         |   8 +-=0A=
>  drivers/block/Makefile                        |   7 +-=0A=
>  drivers/block/null_blk/Kconfig                |  12 +=0A=
>  drivers/block/null_blk/Makefile               |  11 +=0A=
>  .../{null_blk_main.c =3D> null_blk/main.c}      |  63 ++--=0A=
>  drivers/block/{ =3D> null_blk}/null_blk.h       |  32 +-=0A=
>  .../{null_blk_trace.c =3D> null_blk/trace.c}    |   2 +-=0A=
>  .../{null_blk_trace.h =3D> null_blk/trace.h}    |   2 +-=0A=
>  .../{null_blk_zoned.c =3D> null_blk/zoned.c}    | 333 +++++++++++-------=
=0A=
>  10 files changed, 317 insertions(+), 176 deletions(-)=0A=
>  create mode 100644 drivers/block/null_blk/Kconfig=0A=
>  create mode 100644 drivers/block/null_blk/Makefile=0A=
>  rename drivers/block/{null_blk_main.c =3D> null_blk/main.c} (97%)=0A=
>  rename drivers/block/{ =3D> null_blk}/null_blk.h (83%)=0A=
>  rename drivers/block/{null_blk_trace.c =3D> null_blk/trace.c} (93%)=0A=
>  rename drivers/block/{null_blk_trace.h =3D> null_blk/trace.h} (97%)=0A=
>  rename drivers/block/{null_blk_zoned.c =3D> null_blk/zoned.c} (68%)=0A=
> =0A=
=0A=
Jens,=0A=
=0A=
Could you consider this series please ?=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
