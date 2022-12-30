Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED9DC3DA7C
	for <linux-block@archiver.kernel.org>; Fri, 30 Dec 2022 08:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiL3I5e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Dec 2022 03:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiL3I5d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Dec 2022 03:57:33 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45623FD19;
        Fri, 30 Dec 2022 00:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672390652; x=1703926652;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JK+s3t7fk5vphMB+GaneudH/8MHU+Z8qcJK5xz0419k=;
  b=bYiyzpT0sm4wRnEvmuZVuptXEzXIAy3uI5JRUWiajlyt6NYGC3vSMZTT
   SyyttK4cnz/aJMKjrHQQ/UQIM62y185fwmep080deLTmttPuTOAuebcR2
   DzFAKwHenBa83qcRpQLqRscgwKzZ1cz9+kd4FmP1IJzEWgfL86y6R+q6A
   pvvgNNbvRpPVEPKaEE8PNjAq3Rny6LEglhNlJKKoEo/ThT2W5R65XK/ve
   +nf4LejUyhnwwM9F/2Lzz39wUZwxGgThOYKs8RwAJBwOleaDq495iCFHo
   evFYS8Q/8NOTG4iuSGFyb9PV5yDbxW0bfGkjQGI0BE1rkk2aZHMpwZviA
   g==;
X-IronPort-AV: E=Sophos;i="5.96,286,1665417600"; 
   d="scan'208";a="324026742"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2022 16:57:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoNTRnLS4FA6u22vXm17g0m1O3jnFsAw2OYniM7OwWp6vfEaCe58f0F9oSfvcF/oQoorAHi3iwh6Ap/q6vfFml4C4n/812Z+EQw1tK28XrKnkqJvD+2MTTnaGMZqikeSUd+hl390STECenYPJtdEum/1cf/JIAdDNUt++wdxVz6h4sOrSUg0Ye4K2LyyYoTV04ktcde/Xn/SfYN/f6z7r1FwWyv+KHrMq2s/kpStiDQ0nEM6a6fZ92DWgEylw0cLDSS1uYJC6ynXwDSiEz8qQt3iuQSgxvzymWE2a2mgtxtLfZMcmH4qbkx3PO5V6nr2hX995ZQyuuklpYsG6Caa7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypM3/i54vh3EzHvfeyEcPbNTo1yv6aI0RH15nTXLjW4=;
 b=ekKbAC7/RYYZdNyFJG5GmcB+zpWrP0+NJ+AT5MUcZF2RA7XlQSlo85Xr3rTKwBYz7I0giP/36eVLn3TweiKlhiWV3+dOA5TD+5uHxXFeyyQkCThfspDQD8xC+oCHuUluztUJyH/Ggi9OFfydhDTRp0bDcb4Flh4QwlSCYnCbXg/nyngZ8ZETWnH3riyTKH5n87s5IFSULLRDcniAObRjiF9EaMtLnnSP0DJyt9Omx/V9XqNXhxKhzQqocfM7mLH1BFxh7WVlNK/+n5SCxqdu5K0rnTGTyNje24D7U8BoIdCH7/ztL5dL8Axeujg3ZdLJv4PxeKfhBIdL1isaIz7O4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypM3/i54vh3EzHvfeyEcPbNTo1yv6aI0RH15nTXLjW4=;
 b=RlcpGnWSV44LlR2I+egsuFOdAXibl1Bf7EMlYjXCqROU/8EXc4yJ+gxBR7U7bXF8muCTt6b3XyqOhw6ZT0rgX0YoSk/Vocoipo/PXd8c/1VdXgIFIlt5rBjERyeM2gIpi7SaJAeafCEqry3tEsZZQHhv10cI5k35ViLRt9tvjKk=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SN2PR04MB2384.namprd04.prod.outlook.com (2603:10b6:804:12::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 08:57:26 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5944.016; Fri, 30 Dec 2022
 08:57:26 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 5/7] ata: libata: Fix FUA handling in ata_build_rw_tf()
Thread-Topic: [PATCH v6 5/7] ata: libata: Fix FUA handling in
 ata_build_rw_tf()
Thread-Index: AQHZHCy8QR9VZTv/vkSR9n4PVAMMBA==
Date:   Fri, 30 Dec 2022 08:57:25 +0000
Message-ID: <Y66n9BrSTd8IwnBA@x1-carbon>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
 <20221108055544.1481583-6-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221108055544.1481583-6-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SN2PR04MB2384:EE_
x-ms-office365-filtering-correlation-id: a918d63e-39b2-4174-3991-08daea43df7c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tMqCkbUwy4sNkLhTcZcgkymgbOOvnYa2AVO95GvBEF7YMKMexYRDodTiigXJQe356/wBbhfAz3o7qV4fJ4n0APv8Q43Q0fZvVPVcTt0goPNo+TlmqeD0uVwLChaThjRMqOPpQ5x9W0sXZm9vcp395euAiHIpzlBEjTTle5NmoIaSswDZk38QQ2B9EDZBw6r1mpiBX+tdTgaclpGgp0y9CdiBhpeT+X13kM+TfW3wn8FKbkmQ3pgBn+6FFJLpyT+nuDd4pAGQKBszgHJCgL8BLePvRlyap6z+5p8kvQr+NIk/ZiDWTEGoc2Cm+TwG37MVSW4QMt1OoWHDG8LUvyUW1z5EUGWmPcGA88a2mIYv6yaQVr3YYlrqkWIfoDK+VQwH3F4FuREPCzKoUKpokRf+9bommZEENG4cjNdEmnXocQPo4qau2rrd427/ODoPgUPWbu6k+XOSOpSTVshRXxBPUhJ1SzywqQRMWCdDDgrr0POGthc67cHTKq8RWnYcUFfCPpiYFXWjPNEs9Fg9RVjIDTv+wO6zy/FCQdzSpjyErIhAqE1jQAg/EtaRjAyR47XSkcv2KS3dZ+OwNJk9WagawegEqmWT2IXbfqdwYa/5gZs0MtD/CQkVIPc38zmxg50hnYNs0L7qnlppAtB1HefMEyFhd4pydNyfnkFuoz5Cv6xda3uejGfpOUzk2c7Hv19fFvNk/yiHOtxzsayFp3uc/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(86362001)(122000001)(26005)(38070700005)(6486002)(6512007)(9686003)(71200400001)(186003)(478600001)(41300700001)(6506007)(91956017)(66556008)(66946007)(76116006)(64756008)(5660300002)(6862004)(66446008)(2906002)(4326008)(8936002)(8676002)(54906003)(66476007)(316002)(38100700002)(33716001)(82960400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UNwBSdgcpoVTF0H7NPnjG0ljTkEcHo0h2wR8szLdQVEeprObGVaqng15o0Gk?=
 =?us-ascii?Q?7TmjcvhylaOG/eY/cR6d0sfHI9o+bQveumkRTvaXPj0l2V+i0pk5XM51OGYV?=
 =?us-ascii?Q?NwDmaTP66gXgAvVXgZfR17LWHRsuq13o43IhxTgzw6a5JKbExeEpGaM1yk5K?=
 =?us-ascii?Q?LjVJVxWnljYyG50bwIEJgV5PZMfQfBrmZysKEeQs+NRwN8IuPATjnweJdj4+?=
 =?us-ascii?Q?9UM423LriEwpd7vB5AiCGo5kTEjbKKfnIQbrkIQc2TQJY4qVWRNft0XYy9Dx?=
 =?us-ascii?Q?exwMXu+sIhbtdksGBVsOzI3G5FSn0cEF5xPJr8BMnUyIzwPTY3qsgCEGoEkW?=
 =?us-ascii?Q?5I1qyFIQ/sA2/HGCXd3Rd5Yz5yGUnZU84xDMlC3MAUIZf6ual2XbSc2LGO35?=
 =?us-ascii?Q?l+jjfNZOVIQ0O7h8lakiIKVPxO5RyqDjROc37IyLuGCDTg1p+OlA46pOq5IO?=
 =?us-ascii?Q?Lz340f88/ur/BHy8lvaIwBJt8+JchtOKqdwTNKNnva5Qe0vOBSGrIBemtX4l?=
 =?us-ascii?Q?YIyNn0HRYTP1jXPDiIus02U6G7IBfo8F4MhttJLAQmxmJyg4j7rJxMiwmirX?=
 =?us-ascii?Q?Sq2SVdXXyTRfoC0fn1cU36EPA9hhG3Kv2vJaJwBp3qZP7EAgG4vMeen2xM2L?=
 =?us-ascii?Q?0XaD45fM/rxLmQtwuKyv3D9AiDfUhZ7FWy6GHJFQL8VNioac0J3pKfBzeP3S?=
 =?us-ascii?Q?SucI/Ls9K8ATWlmjh0Pgn1eFyzpw3z3IOpKz80ZMYqYF6arTzNNNdr2/vX6k?=
 =?us-ascii?Q?GDUxkGws/IWqbN/pC34Hb25y/+67zvWQZc7huI6kVuCTKQkRi4yssn1noyfw?=
 =?us-ascii?Q?m87Tvn2ZAS2M5opklzf//Clb11uKjZYepOYA89Rokq34WTvWxaBdLhq+YJt5?=
 =?us-ascii?Q?Ll6XPKPQWKwHsNwikfkD03s/MolgQmTNsier34UpzCwSZuxtfP0yxME7LpXT?=
 =?us-ascii?Q?FM6dnNzQ3wzdPKyIdULnjKAeJYz9LhZgZNibBdFnHSa3+fyMSnkTpt/6sqM0?=
 =?us-ascii?Q?v/gWi2tvWFlCyXtxSHdG0VHD5rcSgDv0/4bmTRTN/pyAKkcDW/jmnTv8ptn7?=
 =?us-ascii?Q?QUMyTvrUPiUkrRfPMIPfh4kjOmCLiIgerLPyKqbeMV4juFhjDxE+/6B/1zeA?=
 =?us-ascii?Q?e/Vw0RyCsOPRM1kKtROfGqgPX0xJR6PD1saWCuJymm+40k/CIM6A8uJdjpy6?=
 =?us-ascii?Q?jEToVU6YTz1cXKzyuiOZSX3Lzi1BlAiEHXDBaB/ubUyDan2VCqFVWhjS8Wn4?=
 =?us-ascii?Q?iI68XVGg0CL2SYXAipYgL4qizPzEIZfzRibO3zPmcH0IohjnAUUEV/0Vk+55?=
 =?us-ascii?Q?r+fpHYmJthtLLCHfp7U/Tyat59sW3WU9lMI3NClrzPrbwSFmcF5rJ0yTFpwH?=
 =?us-ascii?Q?EN86DYRirZ2lnVPkIGrRROEszTolG7eVKwMjJfmwee4NgTixPgCsZq8JF3+k?=
 =?us-ascii?Q?MmrHZrowQzBlOC8WmCrXABZEo9cntbl4vNbVhz/pD9LPjhk5yFlUxOY45s/U?=
 =?us-ascii?Q?uuecE9GMTJLVzOLmMK0yDB/2ZMkGPvjHrmhbDll5oGXbKr61xTe+al+O+EgF?=
 =?us-ascii?Q?mq1YtRci25HgkYrd8AayXti1wknIawE9kopE6K9okkC/fQnpmBIOhWZcR6AV?=
 =?us-ascii?Q?Qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B97D678BB095944DB1973AE9F91A6E56@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a918d63e-39b2-4174-3991-08daea43df7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2022 08:57:25.8890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6qqI3ghYB5xRPiZmWbS8SGPxU/R37gLYyH66zKV5g7RSTY4uKNGDNoz8fimiVmy9Y3MffOavkno85GR4crdMFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2384
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 08, 2022 at 02:55:42PM +0900, Damien Le Moal wrote:
> If a user issues a write command with the FUA bit set for a device with
> NCQ support disabled (that is, the device queue depth was set to 1), the
> LBA 48 command WRITE DMA FUA EXT must be used. However,
> ata_build_rw_tf() ignores this and first tests if LBA 28 can be used
> based on the write command sector and number of blocks. That is, for
> small FUA writes at low LBAs, ata_rwcmd_protocol() will cause the write
> to fail.
>=20
> Fix this by preventing the use of LBA 28 for any FUA write request.
>=20
> Given that the WRITE MULTI FUA EXT command is marked as obsolete in the
> ATA specification since ACS-3 (published in 2013), remove the
> ATA_CMD_WRITE_MULTI_FUA_EXT command from the ata_rw_cmds array.
>=20
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/libata-core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 30adae16efff..2b66fe529d81 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -552,7 +552,7 @@ static const u8 ata_rw_cmds[] =3D {
>  	0,
>  	0,
>  	0,
> -	ATA_CMD_WRITE_MULTI_FUA_EXT,
> +	0,
>  	/* pio */
>  	ATA_CMD_PIO_READ,
>  	ATA_CMD_PIO_WRITE,
> @@ -727,7 +727,8 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 bl=
ock, u32 n_block,
>  	} else if (dev->flags & ATA_DFLAG_LBA) {
>  		tf->flags |=3D ATA_TFLAG_LBA;
> =20
> -		if (lba_28_ok(block, n_block)) {
> +		/* We need LBA48 for FUA writes */
> +		if (!(tf->flags & ATA_TFLAG_FUA) && lba_28_ok(block, n_block)) {
>  			/* use LBA28 */
>  			tf->device |=3D (block >> 24) & 0xf;
>  		} else if (lba_48_ok(block, n_block)) {
> @@ -742,9 +743,10 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 b=
lock, u32 n_block,
>  			tf->hob_lbah =3D (block >> 40) & 0xff;
>  			tf->hob_lbam =3D (block >> 32) & 0xff;
>  			tf->hob_lbal =3D (block >> 24) & 0xff;
> -		} else
> +		} else {
>  			/* request too large even for LBA48 */
>  			return -ERANGE;
> +		}
> =20
>  		if (unlikely(!ata_set_rwcmd_protocol(dev, tf)))
>  			return -EINVAL;
> --=20
> 2.38.1
>=20

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
