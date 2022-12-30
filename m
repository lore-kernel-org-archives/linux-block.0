Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBEFC4332F
	for <linux-block@archiver.kernel.org>; Fri, 30 Dec 2022 07:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiL3Hnd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Dec 2022 02:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbiL3Hmj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Dec 2022 02:42:39 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ED82E8;
        Thu, 29 Dec 2022 23:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672386138; x=1703922138;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K/4wAVrSprwB/NyomInuuVKalm96QVRJ6vIqajrbLGo=;
  b=Cq4rFmTe2ndToSmDTdKT1UfkWTtL9p0ODYtYRFRNb/mu/W9N4xa6yrKb
   bdw89nGZz4lHc5wBBXaV9iIPXXJOrZZsIbHInLjupZLl1P8woBhzBHEYj
   2Ox8m41KQjeWittUsZ46rtVzxTHW5oF2mR/VGEZx94F+MF/QssvTHD6ei
   UPEqMMj5tZJjuBTuF04MoHdkkn4Cxn/liE2LfmcYzJZGwCklfJrJAxlbw
   3EfnSfiKUleOX5aM95r5DKBXJL0V5GcvRP/uRjC7P05np60aupoGqOj0T
   K1ncGfkuPoDCo+IkqA8WI8c3w8Qnwx2NyhavtnHFE1xZwF/nm1wSlbWgy
   w==;
X-IronPort-AV: E=Sophos;i="5.96,286,1665417600"; 
   d="scan'208";a="219863041"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2022 15:42:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/5D0Xpf+xkUTxjK7JAtods7IO3xpy5AyGjEFIU/N9ii2qjMhkXoM3r2EnW9A8DzBTZMcsl6c+BhY40fhT445zSvZdPD0Y2VRaM/309JD06IofbQCcvP0gM//bQutIaxurHmg5VL7qA8ONl4+PmnlL8hodzOWNYiPZ8b33NMG1EK3JtLrEzD0FNY7znnbjWnMq/bqwK+8N1i8X0+eDklguzidMsQqigvv1QcruYVzrTiz72IbzbI9uYesFYY6cW63C8t0mDH+okglez4AUp5Ap1eBiWW+Iw48NWhUFjyQfo3i2egAGnTKquNrbuwgaEhYTjvnfd3bYKzWGZOPSnpSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FhmEHaenlj2nFWZrPrGvG0WM7azbrk+IE66pz67adA=;
 b=aqDAXGOEnz53AYa0AkWx9a9Uu/jBm4rDzwsJCiPRriScwwAVMN3yvUY+sSfgaZbTWcsz9u6m7R1LNrbZAR+CDap3kWhx8dkWFQO3sW9SztqkLzyl8wj7HHwXbLy73Amkw7bNUg4cB6lvjPzeJuPpy+l1gU6+5QGRe1ZAaKxviIKlcz5uHkBiQzAROAgPEZfUbx8SYcBFVeoIBVTnzDmjOo2uEPorniUb8ka+FYjEenj+SYc5/bAhe8/+Z42M7mAFWiB4LRcOw6Cn8RTDwf2zlKthfm7X8pw9eI3nRHwac6pDpJaBtFVI4ifGXNO94PtCpNHITAakWyUJh1JQJHx6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FhmEHaenlj2nFWZrPrGvG0WM7azbrk+IE66pz67adA=;
 b=ndBtoI8OvcksgH4hcKr4UUUWwYkdt/SvV0S1B7OGBeFlSL30cqA37X9ZHUzhegE2TUrLVKiREbEwGmgZwDyMkliQk+3My6bzWMsWvb6LlZcGYreTs2NhDoEe8MktMhM7NfP1or5b9Gi56HfJ89DNgD82lgW3vSJj2ohEU4suX2E=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM5PR04MB1053.namprd04.prod.outlook.com (2603:10b6:4:43::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13; Fri, 30 Dec
 2022 07:42:15 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5944.016; Fri, 30 Dec 2022
 07:42:15 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 3/7] ata: libata: Rename and cleanup
 ata_rwcmd_protocol()
Thread-Topic: [PATCH v6 3/7] ata: libata: Rename and cleanup
 ata_rwcmd_protocol()
Thread-Index: AQHZHCI8e4zhaLtCkUajwtUlDlUxTg==
Date:   Fri, 30 Dec 2022 07:42:15 +0000
Message-ID: <Y66WVpFvCn2cXx9e@x1-carbon>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
 <20221108055544.1481583-4-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221108055544.1481583-4-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM5PR04MB1053:EE_
x-ms-office365-filtering-correlation-id: 692a0cfb-cb8a-46e8-2035-08daea395ee9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dEyE0+AYn0+RN+vOMFxa4jdoRb3Cgkcs0VvFxfwmb3HD3TMwlchqT5AAU54RyO8rNKKDVU/nk0M6nYrQF3Mc0hKmdl1o2+ocyPHVRAGM4GyKDDvaf8ot9oUpjaxmwuI+iPRvtnrr6mKZaHGCGjdNgeAH/4aSxM7xD02SjVmEYsk0xKpnVLoZlAaxrA6lOxu8+3/lzIPr8Zwmh6iB/lQYedlIWVI4zJ3xGwkK2nXX+1WZ9v3XtlBPVvS5nL57mzWcZ12dhDTpyaROxZ37isuKHYHRh9AZbo/24qnI0rLhhVF+AzwJzjRYwu77IDzzpQD4XLkDt1mg6ylU4xl+bnPyb4riK5UPAcWXwGymUK+elHfN9NrKlC3e9tcM2uMSN+CBPodi17D4En+8ktylzF1QOCnZ4GbCp4MICVtWduDnk4R4bKN53j1B+WAVejX/ctif5qM0tr91ROdOGmlLB10pRhAzy9p1ReSe332hgO4fRA5+Vya+hgnmnDs50ClgCDAhN8E0UV6b/5x342OGneC0bychPAgVNXSxvMKBpb5KYrhgT2qLkKEvierdR3lgBkAj6lHUbF1Lb5ROorPI85+/V6cUy+KtxjTeAMLv+3oP1kCqvAgcBNYnvg2e+2R1N+jCygJBG4JA9XrS8M3c8AaYFDouYLgOnQTJD+QqFi4pGFTAaa7OOXT4IKgxfkM37WUD3+X/u75VVR+Lwtgr6wZgGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(6506007)(9686003)(6512007)(186003)(26005)(6486002)(122000001)(71200400001)(33716001)(82960400001)(38100700002)(86362001)(54906003)(83380400001)(38070700005)(5660300002)(8936002)(6862004)(2906002)(66476007)(478600001)(4326008)(64756008)(91956017)(66946007)(66556008)(76116006)(316002)(8676002)(66446008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Rtly6mVHjwng+1tkmaTfG5W0NeH4sw8BqsUzeLUAdmRfcquRGgQlZ4hFls0?=
 =?us-ascii?Q?/keRG9vPGDJix16fHpDPEhPzHiVGxA/4IDPYzSo7KROZKIo94JYCxa5UEXCY?=
 =?us-ascii?Q?cnvpBp8G8F0mANVAwQxmIySsC+nSJq2Tni1eRcOtEpR4SDY6n9LFxnQiJAJL?=
 =?us-ascii?Q?Zh/ZA2U73fSojaPC7kD4oEhRBX1IEKrZP5G2rxCybOyJPtgX99Knfr/wuQnv?=
 =?us-ascii?Q?CzXt/U5PdHpZTiMNW7h7rdxAQeIwQvz0+MrPIpxiClhdFGJW3ewWVB0OgjJh?=
 =?us-ascii?Q?Q6Bcafu0fKfzPEhBqBnCFpgqLyMPhKFWqwwxyldC5imOZWDD5CNJjkv4CQ3l?=
 =?us-ascii?Q?z0zJ0Jx6WmIwMRmIOQlXQbDV7acuST7HJtR416znN6/KnuAmnU7/qfQa8sox?=
 =?us-ascii?Q?K3ma9S1RGJhN2+bSJqK4z6Tu1N9XzU9jfL1d0yZGZVAD9kLwqE4HS7wOYJXQ?=
 =?us-ascii?Q?0cxxBmI+JRJpLkvfvi7iYz72yB3gnfONN0byrNppdyKOAK9p3vxclkX/nSLz?=
 =?us-ascii?Q?Hx7Us37j3g4Ayw9YU9RCPXdRSnJUZWs0plLsofPhY1EcEz27txq08zKlQZyI?=
 =?us-ascii?Q?WLeXR+y/AZqGiJR1jOKMNKNh8ase6p8qAfFFITBLvsHz3q87MtjbqBRmIMOz?=
 =?us-ascii?Q?ELBe80MtxUg6pCHVdKBaXly/g2p/hvzy8KqcfjG8N6+AnJCvxonEf24cHi2b?=
 =?us-ascii?Q?1195pHs7FKMQnr9kKAHeAwyqu3Cr+pyCbFlAYg6BziE/zsAKdUqcPnNtZsHw?=
 =?us-ascii?Q?6Lmaehcaqb1BnVp32R0I6bXd0Z95KwRLw/OZwEFhJ/PDtnKCEtivC/mc5ajV?=
 =?us-ascii?Q?alkphm8lJikpk+VEMcSQ1JLCHxHSRtm3IIVxRcKFZoVktB+/yuWP4kpYGbAQ?=
 =?us-ascii?Q?vVKl5ebVyCmaNsMSGbMxt+ALyo6y3liPsvxJa0vM/8rt/i6bCckO3qg963fv?=
 =?us-ascii?Q?BvTKIpRfoCvrRkcOexr7VWYJflhVYFYUo60Zxc1+RhvtGvIGGJ3HQU4KKKCA?=
 =?us-ascii?Q?Aa2Axd/S3tSkIyZuB6o7BhLtEFbeJ2Nv5u9Tc/iHCxpqKbmLYfSCIT2mqqjK?=
 =?us-ascii?Q?XsReG51L0tp38dAtvK/Qzkzw7To/tNrWeMrsRmYglQuveFcYKTQKDbx0HPY5?=
 =?us-ascii?Q?/6rwX+ECckJOeSDjVoR2RG6MlX/+Q2jUsD58kzdbUkWb8Y5q35JYuI7VipkB?=
 =?us-ascii?Q?sdx587ZU8SvKP16H/pLPV38YhLTJcBOkp/uRqcGj4X6IbVeG7OdH0lX24jLU?=
 =?us-ascii?Q?7NHFnEvBwJU73wTyWSsEiYDc/qJ3x5veFYGlBpYc68/c5Y+UxUfK/ceMBgx3?=
 =?us-ascii?Q?6KPg11x1NyrhJG0GkBM0QqAY9zY0yGkxZQmhq+w2JkgroyIz5kEisOw2O4mb?=
 =?us-ascii?Q?IqdqL3McRIhqhXZL9AL/l/271fTqsbEzNvKoQdvPRPYtrdm6XDGpbCIP0qt5?=
 =?us-ascii?Q?FWORnMEe/HNSeqjf5km9g2EnpIcxTsIw4ETC/udYc9tbjmnfJkECaTn/Vc4K?=
 =?us-ascii?Q?3hqIArHSUzoevhRaIU8sukGvg9ikV4QBSxiSy/m1CwV8MvpZkcfT7eysoYfY?=
 =?us-ascii?Q?qGX2zFq7WNFZGew+zn1JrAossjDJJOGFL+pRfqijL8sk/8S7c72LFq40Wrs8?=
 =?us-ascii?Q?/g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F475CF7D5581084EA5787DB1E918D479@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692a0cfb-cb8a-46e8-2035-08daea395ee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2022 07:42:15.2093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: orp+v39zq/EZ0uoyN0sdCHrK8N6HFJDwrhErlS24G3gd+x2EQufgvoItSUzb5sSa8tEKCOuXh7vc1kRB6Qks0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1053
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 08, 2022 at 02:55:40PM +0900, Damien Le Moal wrote:
> Rename ata_rwcmd_protocol() to ata_set_rwcmd_protocol() to better
> reflect the fact that this function sets a task file command and
> protocol. The arguments order is also reversed and the function return
> type changed to a bool to indicate if the command and protocol were set
> corretly (instead of returning a completely arbitrary "-1" value.

correctly

>=20
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/ata/libata-core.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 884ae73b11ea..6ee1cbac3ab0 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -574,17 +574,18 @@ static const u8 ata_rw_cmds[] =3D {
>  };
> =20
>  /**
> - *	ata_rwcmd_protocol - set taskfile r/w commands and protocol
> - *	@tf: command to examine and configure
> - *	@dev: device tf belongs to
> + *	ata_set_rwcmd_protocol - set taskfile r/w command and protocol
> + *	@dev: target device for the taskfile
> + *	@tf: taskfile to examine and configure
>   *
> - *	Examine the device configuration and tf->flags to calculate
> - *	the proper read/write commands and protocol to use.
> + *	Examine the device configuration and tf->flags to determine
> + *	the proper read/write command and protocol to use for @tf.
>   *
>   *	LOCKING:
>   *	caller.
>   */
> -static int ata_rwcmd_protocol(struct ata_taskfile *tf, struct ata_device=
 *dev)
> +static bool ata_set_rwcmd_protocol(struct ata_device *dev,
> +				   struct ata_taskfile *tf)
>  {
>  	u8 cmd;
> =20
> @@ -607,11 +608,12 @@ static int ata_rwcmd_protocol(struct ata_taskfile *=
tf, struct ata_device *dev)
>  	}
> =20
>  	cmd =3D ata_rw_cmds[index + fua + lba48 + write];
> -	if (cmd) {
> -		tf->command =3D cmd;
> -		return 0;
> -	}
> -	return -1;
> +	if (!cmd)
> +		return false;
> +
> +	tf->command =3D cmd;
> +
> +	return true;
>  }
> =20
>  /**
> @@ -744,7 +746,7 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 bl=
ock, u32 n_block,
>  			/* request too large even for LBA48 */
>  			return -ERANGE;
> =20
> -		if (unlikely(ata_rwcmd_protocol(tf, dev) < 0))
> +		if (unlikely(!ata_set_rwcmd_protocol(dev, tf)))
>  			return -EINVAL;
> =20
>  		tf->nsect =3D n_block & 0xff;
> @@ -762,7 +764,7 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 bl=
ock, u32 n_block,
>  		if (!lba_28_ok(block, n_block))
>  			return -ERANGE;
> =20
> -		if (unlikely(ata_rwcmd_protocol(tf, dev) < 0))
> +		if (unlikely(!ata_set_rwcmd_protocol(dev, tf)))
>  			return -EINVAL;
> =20
>  		/* Convert LBA to CHS */
> --=20
> 2.38.1
>=20

With or without small typo fixed:
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
