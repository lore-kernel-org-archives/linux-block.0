Return-Path: <SRS0=O1WO=4F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E52C3B1BF
	for <linux-block@archiver.kernel.org>; Mon, 17 Feb 2020 00:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4366220675
	for <linux-block@archiver.kernel.org>; Mon, 17 Feb 2020 00:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IWAreKk/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AjgQUBq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgBQAys (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Feb 2020 19:54:48 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:10811 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgBQAys (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Feb 2020 19:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581900887; x=1613436887;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=omY7ZHJ0RmP3gME9E4JStBFgwANaf7fjTUENl/IpwvM=;
  b=IWAreKk/oqRVCRpbBjj6C/o7EqFljW3Jj9ru+Iiv65IdyYWn5FSCPKxl
   aqInDUkuExHwLhHLpMr8DtHM1fYMkGYkJKGZAg0RnQHmRTDLOT8HdJf+o
   FvGygiWhqobD6ftNAs/tdMFLmiuMDmsrMv8ynTIRLQhhKyKurcEcSrF4w
   KRkjdfbdCL/xtHz2DBYds/PBcxQ0O9bM+i8ncKGS7NQDdP1AaU8FKW/TZ
   ZkOBfDKAylEP+2uIN8QBHNcq/B48soKgcKxW8xacHRSX+0zlgtmtIHXnq
   1xJtBBaQ72da0Dmt3C1qtvI/0LcEJpfC8e6yrePqAD9Hqy/6V662F+L0P
   g==;
IronPort-SDR: iaDwewiY44R5ohmHGXth1Q33fY6amPKK1fJsdgMoUbWEWouk9g5L1+W9hasq/GuhuzbyD/ulN/
 vlvWrr24MDAAIFtIK90Q7xtVYLlsDog5FkJSUr8ITSv5+lNq6gxeZBVia8il5WdAUOXCc2W7sr
 FbyJysKaCaOu59IA4WwQlCMkiPIwqJulCCLw8KPQfxCUKo49T1i4yMyY9o0/diaDPtmMWhfRdf
 wVQHW1NjoHoGbYmt1vfuW7vtSRQnymlthnnCXWlDAVkaQNs9AekLK+axMswS7IqYAwtwfZWFFL
 QL0=
X-IronPort-AV: E=Sophos;i="5.70,450,1574092800"; 
   d="scan'208";a="130503648"
Received: from mail-cys01nam02lp2053.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.53])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2020 08:54:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEIzi228Lf+KbdHeIIvhUd5qRJAFN6QnEMZ/9ul4Rd5zlshJF4N1SDoNQUNSW+PFxSHfOoOr78brIAj65d4TThYElq7hkWHcr9CvSprPGRR0hondhR+0bdujW3JsmEJNJILljbNjVFhOMOe2Ls3ntiSW4XtT57RfVH5ZQzwgFHg4ms6yGrpIO6qNFLCWoZMRSVvhVtOF5hTmJnuBkQVrWjrVjAADhhYyZtceG49P6/vL0jfoqbYLGfQHvSU9wY15n7aV5qjqeatc1Lk2pHUoWt1+iY9qcfeYIOQusW5L+ntTVX49F9La0gK7HY9aScrLGc2ME+V2evAycxcDIIo8MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lE93IH7ZiiwTZ1NlsjbCFLexXUEDiZ9WW24PNmDqrOw=;
 b=BBqAWxo3wOLI7Yz0TSzYDM6RvD7Cv6Yfh0qboZ4AFaD3LNHOMwH1KdDDI0pgyLchG8o4v5sf5b57n/NzGdSWvprStNLpsYXENmcUWbpYMJ0RW7aX3En8w3Hy9Hzac4ByfOr2ofievZW4VVg0nyCrxaQq656iOIGXbT/BJE1r7QsdTdRQV9CxLyVuGw5475G7eN7ctYz2UxDHg6tLc65HPrimOD0jpg0DnDA+usUQNlmussmc54ZzOvhJEua6FZrj2n1trg2IcPsVXF78ErmDaJvYQuC37d6CH2Jkx9aMcXUZDq5focYvsqb33vxU9tc3RTYCrLTrk4EfTZomAQHZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lE93IH7ZiiwTZ1NlsjbCFLexXUEDiZ9WW24PNmDqrOw=;
 b=AjgQUBq1vOiVvtJj3jNxya1mYNy04OKfhuYEQJ2zk0brlE9PxaAenA2vQwu/x/CZMmfm8umKVNuP45To1OIuhgNOAOB3BCetO0+UZlUHLaXzRRZILnu3Jcs9aOB8ers76/pxcnufiSwE6fIJXKvzvGI4TTy9Qh6SdUfiPdahjLk=
Received: from BN8PR04MB5812.namprd04.prod.outlook.com (20.179.75.75) by
 BN8PR04MB6369.namprd04.prod.outlook.com (10.255.234.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Mon, 17 Feb 2020 00:54:45 +0000
Received: from BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::59a2:b03:15e5:7c02]) by BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::59a2:b03:15e5:7c02%7]) with mapi id 15.20.2729.031; Mon, 17 Feb 2020
 00:54:44 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/3] block: add a zone condition debug helper
Thread-Topic: [PATCH 1/3] block: add a zone condition debug helper
Thread-Index: AQHV45r+clZNzQe3rkadJczGmK5unw==
Date:   Mon, 17 Feb 2020 00:54:44 +0000
Message-ID: <BN8PR04MB58122307EDDECAFBB436A97DE7160@BN8PR04MB5812.namprd04.prod.outlook.com>
References: <20200215005758.3212-1-chaitanya.kulkarni@wdc.com>
 <20200215005758.3212-2-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2374ff26-5ca3-48bc-0e56-08d7b343fad7
x-ms-traffictypediagnostic: BN8PR04MB6369:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR04MB636985090D8D6DDB323C570FE7160@BN8PR04MB6369.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0316567485
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(189003)(199004)(66946007)(186003)(4326008)(91956017)(76116006)(478600001)(7696005)(33656002)(86362001)(66476007)(66556008)(316002)(53546011)(6506007)(52536014)(66446008)(81156014)(81166006)(64756008)(8676002)(5660300002)(8936002)(55016002)(110136005)(54906003)(26005)(2906002)(71200400001)(9686003)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR04MB6369;H:BN8PR04MB5812.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MoHhi15mh8gQzvv6fbrk1nWYo310z53wDMgHC+nCohGKEplzaPvr2puLwjwEjXWLU3Sg/fvrjWPyj2HGJX2B/DHWlqthvDP0ECt7pI/dKCNzjqQbw0vaC2Ioh7XjBTQ2pIoan0GrCeA6jkQ7dvVZJ4yBNMW1KR7YVzqJ+rW8v/0MSD06z49Dg+ZAdvCZxIzOmPQrEi9NjQoERSOwTvMauIguEH3KdfZVC51UZTy24Fb2uFSmGmYt72BGPOc8XAnkssbsnEcw3pDZ4FEN8VnxSgr/f9KbiOQHL4UzRGVRwQw4KHcAdzpgfA1lruNLes8XPpY97lNA+rYQsC4zSWz+hNjChtkIQR4qNGNXm/jOnHlNvm433w3s8kn8QoeEPnGHnZKvsTVDRXR1lJ0SK5YEMdUDCYr41I8ruvIgcQObi4R4+hQiMFN1Uu9SIi+aD9sWL1XjgYjGJ44Es4KFu5C+PuGcGTne4QVqXOLbr3CjAxkDxwzJGXXcAEu4XK6QU/T+
x-ms-exchange-antispam-messagedata: R9bYbioJ3kIaDNBhAS57Fq+F1j3Y7Q8/MINsGNLKq9lUqhUZliHbKszd3dqahDmn1nNqT3OLSi4o1ritf5zH/c481ILIjFwdsjsKxueEj+J1zMBhUxPC7evjECvUzBTdyrRSCDbSBCOz//+ZQ7CWpw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2374ff26-5ca3-48bc-0e56-08d7b343fad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2020 00:54:44.6344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yjAuGaOZyoQD6nbQ23Zwf0xR9XZi4Fi21S5X/zBuGovQZnQePW05OD6kD4rsnOeww3EPaukLT2om46KMUDwltQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6369
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/02/15 9:58, Chaitanya Kulkarni wrote:=0A=
> Add a helper to stringify the zone conditions. We use this helper in the=
=0A=
> next patch to track zone conditions in tracepoints.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  block/blk-zoned.c             | 14 ++++++++++++++=0A=
>  include/linux/blkdev.h        | 26 ++++++++++++++++++++++++++=0A=
>  include/uapi/linux/blkzoned.h |  1 +=0A=
>  3 files changed, 41 insertions(+)=0A=
> =0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index 05741c6f618b..2c4df98b513c 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -20,6 +20,20 @@=0A=
>  =0A=
>  #include "blk.h"=0A=
>  =0A=
> +#define ZONE_COND_NAME(name) [BLK_ZONE_COND_##name] =3D #name=0A=
> +const char *const zone_cond_name[BLK_ZONE_COND_LAST] =3D {=0A=
=0A=
Is the BLK_ZONE_COND_LAST really necessary ?=0A=
=0A=
> +	ZONE_COND_NAME(NOT_WP),=0A=
> +	ZONE_COND_NAME(EMPTY),=0A=
> +	ZONE_COND_NAME(IMP_OPEN),=0A=
> +	ZONE_COND_NAME(EXP_OPEN),=0A=
> +	ZONE_COND_NAME(CLOSED),=0A=
> +	ZONE_COND_NAME(READONLY),=0A=
> +	ZONE_COND_NAME(FULL),=0A=
> +	ZONE_COND_NAME(OFFLINE),=0A=
> +};=0A=
> +EXPORT_SYMBOL_GPL(zone_cond_name);=0A=
=0A=
Instead of exporting this, why not keep it static and export the function=
=0A=
blk_zone_cond_str() ? Any particular reason ? Does blk_zone_cond_str() need=
=0A=
to be inline ?=0A=
=0A=
> +#undef ZONE_COND_NAME=0A=
> +=0A=
>  static inline sector_t blk_zone_start(struct request_queue *q,=0A=
>  				      sector_t sector)=0A=
>  {=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 053ea4b51988..5204eda6e4c1 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -887,6 +887,32 @@ extern void blk_execute_rq_nowait(struct request_que=
ue *, struct gendisk *,=0A=
>  /* Helper to convert REQ_OP_XXX to its string format XXX */=0A=
>  extern const char *blk_op_str(unsigned int op);=0A=
>  =0A=
> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
> +extern const char *const zone_cond_name[BLK_ZONE_COND_LAST];=0A=
> +/**=0A=
> + * blk_zone_cond_str - Return string XXX in BLK_ZONE_COND_XXX.=0A=
> + * @zone_cond: BLK_ZONE_COND_XXX.=0A=
> + *=0A=
> + * Description: Centralize block layer function to convert BLK_ZONE_COND=
_XXX=0A=
> + * into string format. Useful in the debugging and tracing zone conditio=
ns. For=0A=
> + * invalid BLK_ZONE_COND_XXX it returns string "UNKNOWN".=0A=
> + */=0A=
> +static inline const char *blk_zone_cond_str(enum blk_zone_cond zone_cond=
)=0A=
> +{=0A=
> +	const char *zone_cond_str =3D "UNKNOWN";=0A=
=0A=
Shouldn't this be "static const char *..." ?=0A=
=0A=
> +=0A=
> +	if (zone_cond < BLK_ZONE_COND_LAST && zone_cond_name[zone_cond])=0A=
> +		zone_cond_str =3D zone_cond_name[zone_cond];=0A=
> +=0A=
> +	return zone_cond_str;=0A=
> +}=0A=
> +#else=0A=
> +static inline const char *blk_zone_cond_str(unsigned int zone_cond)=0A=
> +{=0A=
> +	return "NOT SUPPORTED";=0A=
> +}=0A=
> +#endif /* CONFIG_BLK_DEV_ZONED */=0A=
> +=0A=
>  int blk_status_to_errno(blk_status_t status);=0A=
>  blk_status_t errno_to_blk_status(int errno);=0A=
>  =0A=
> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.=
h=0A=
> index 0cdef67135f0..28ad29973a45 100644=0A=
> --- a/include/uapi/linux/blkzoned.h=0A=
> +++ b/include/uapi/linux/blkzoned.h=0A=
> @@ -71,6 +71,7 @@ enum blk_zone_cond {=0A=
>  	BLK_ZONE_COND_READONLY	=3D 0xD,=0A=
>  	BLK_ZONE_COND_FULL	=3D 0xE,=0A=
>  	BLK_ZONE_COND_OFFLINE	=3D 0xF,=0A=
> +	BLK_ZONE_COND_LAST,=0A=
=0A=
Is this really necessary ?=0A=
=0A=
>  };=0A=
>  =0A=
>  /**=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
