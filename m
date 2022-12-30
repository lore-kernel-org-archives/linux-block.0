Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A930C46467
	for <linux-block@archiver.kernel.org>; Fri, 30 Dec 2022 14:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbiL3OrO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Dec 2022 09:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbiL3OrL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Dec 2022 09:47:11 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ED6B84D;
        Fri, 30 Dec 2022 06:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672411629; x=1703947629;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RiKLiylsxlH/sIeE51TOULk85mXdeguPXPl44rkRiDg=;
  b=Wo6+CPO311EfPxL0l1R4TJb50ynfZqx/h41oGCQvOZsQX+hXYQ0NpkVm
   COGbfMcp2YhCwDNgkkAA7wCwvp7rnywrKuFYRAZCxUxnq08btYSZo48zJ
   1HKYPLiQ0PUrfpyH2xPyF4iRbVq0PU2p/kz2SViMOOKX15AFT7qJ/odf/
   rq68hbYSmDFaXW1W5oTydYpfAZ0jdlVN2Ak6OAT8LtNjW0HhjwJbhOXVz
   mFFQbjW15cHfnhULZ5fCR85FcqH63mkC+6N7MUWkGFsvVZlCp2ZuA5Zkq
   DxfGIJIfsh3Lra74nf+MH6THXVufZv6vaa/Ku3+ow9gl1QIXuLfLk2ltr
   g==;
X-IronPort-AV: E=Sophos;i="5.96,287,1665417600"; 
   d="scan'208";a="224818448"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2022 22:47:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJqgvXMg/zXifUHjC6Krkxygvuagc2m6trMq/j+8fGDjCl6mtmFJ7A/fQ95i4KJK2n8tlO52HSM7vKky7t6ycud84QSRnWT3Ejc1eb1IuhhJnz0bow2b5nVoVeesuurHHqC5evIGGBju5OE5591RM2nHDdwytZtCz9TgmDOKnyYUCbww9eXeRn8lHkkL188qp9bRL2pu5pkhl44HAQnoLPbiOYfpw462d7VdyEBVUciGNZ/UjGsobIKOcWQ7SvttaqQq0IphppoHWSjJSowk+wXVajnly13/2q83LE5IQPldb0imPxGtnVJMjVs3tpP2NIQQa9UHT4Xkr73u0n773w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RKDUEZ4v2nfTobd5oGgWqkUCiQ/sTRkvNxTNtXSMGo=;
 b=iyV21/p4xR8NrgEzErDnWi1Ntoy0IqH4+gWHgj1Sixszc/iI8l0Wh0eLlZghBJyEnmZEAbRgQS4gYrEYj2N20I/ws2ZXXuz7RGEgMj+60B3RBJ4coam18ELDpwg5g40TwTG8XDc5TQS5GonrxrvDIHp7x5q0iwB5kFp+EdhJJIqO07+cQSAmzDLhzasMqacZ7ZgrN/pqTUK0F8d8GjnJcMZHKTScOGfjrwajNufU5JfRQGTUoWOyqMd34YvWon2AR6Gl8XZHtSZMkUEH5beNOMeAqZoWD0lKx12+bdw1T2Syou2x5FQIgYmqVxOJ6o7c4Havxv9mJnbL9txggnAEbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RKDUEZ4v2nfTobd5oGgWqkUCiQ/sTRkvNxTNtXSMGo=;
 b=DiEyqc/jjCEnZ3uW0a+ukwXf0BPOTAvH/GjxeOZwNqIC0VR00IyK9y4wHw7rK7HiDZ2Ow2lFzMHLX2FgK1rtIZTYpyN0TfpWP1umBrvMi1N2LePwD5bfGNrt+jh6VyyyIp632nYUJhZ5a4zz49Q4cep9hkG+3RsBpsrVj3DDbSY=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BL0PR04MB4516.namprd04.prod.outlook.com (2603:10b6:208:41::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 14:47:05 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5944.016; Fri, 30 Dec 2022
 14:47:05 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 7/7] ata: libata: Enable fua support by default
Thread-Topic: [PATCH v6 7/7] ata: libata: Enable fua support by default
Thread-Index: AQHZHF2Uq7+4wKWoQkiyzEvhMhy44g==
Date:   Fri, 30 Dec 2022 14:47:05 +0000
Message-ID: <Y675506TD2FsrFmu@x1-carbon>
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
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BL0PR04MB4516:EE_
x-ms-office365-filtering-correlation-id: 9a31fc44-e580-4714-e4cd-08daea74b813
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qX0NSGL6FLMeQ+i5p4lYABxqyLgkOgWoPqAAGI08L0DiBRGoV5PQDuAhuicOe+NEVB+YajB3zSqkcCLSCyrp9B8kiAYUMsVJiEdrt7LV3I+v3X8eIqZhfTwQj5UQf8BqM0YVZhzePDSViQOdgiWO+oOO0Hzyf0qpTP85RtrllMOBXh87nV6EbN7kD/8ektzvBSnARll/mq37YPhFHHPeukRtK5vCAd0euKF7PokeKhWJGtC4hXdhPAf5fGyH1sfzCrICMJEwtQbqoK9+fD5mg8ODT4OXi5sUfW+12jubFo2IcYhyvt7Kh3pIx3OSLfl/bwpUJ+wHzMw/sKOwMZ5Z0K3xoLPzlD0yO2EIeE74q2TW3iDxPyILiqGHqpjkRKOvaKP1J9BnlhXqFa4ISZSYWfOvIJ2BKPAzQvu9i5BIMcXfM04ff17d9gf8QZxt3+tMFJzc96Xw/1IaQ73tX0jtClJ6qt9awdFfmFwUqYojCaZqn5B7qTO+YHAH4norpCIPzG8LwcZOqPf6BcarnUQ+VVNRg7SsYcW3Te95lUZETkA9Eybrztd3teBtXZ+FPr0ZP1BPAHCIhT91SKX9S8u+lPl9DyehT5TttNNoTcJoKBVzbzqmvsquxVPBjBidpUYDRy6rrOA8NsI80oPwA8O74TM818EluVo9TfrThPDsdc+nWmOJtqwyCxc+xLX2cwLBH/tQpYjx53tDPCkFnlZ6ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(64756008)(66946007)(5660300002)(66446008)(76116006)(6512007)(4326008)(91956017)(66556008)(66476007)(8676002)(41300700001)(8936002)(9686003)(6862004)(26005)(186003)(2906002)(54906003)(478600001)(6486002)(71200400001)(316002)(86362001)(38070700005)(33716001)(6506007)(122000001)(38100700002)(83380400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?05vkyh3qT3zJekBQBAFa+TdNeayLI30uCu0JEVVljD0IQvwsWPXVJXG8oxKK?=
 =?us-ascii?Q?We5raCgILxuh+vGPlFA6p6N85We/uKvpROHGkUYxF5DhmDL+LB44x0rfsNZw?=
 =?us-ascii?Q?soM8qvfuCJMVioTkmSjw5ZxA2EiDxedyS9xz6Gc43vO6p/VKZ4HlPi/FQ6Re?=
 =?us-ascii?Q?sJERcrMxtOjOmLy+akRxFXrwCs9ortcTBl1/bJEsf3ZaDd6UakRWGozYTr06?=
 =?us-ascii?Q?jPPkks/Dby4rdu+j/S8iXNjXxRcqx3LqMBdyuSy/qMfP7ZNuIntU7sNcS60z?=
 =?us-ascii?Q?w8b8jxIYvbQ3PJ3kbpVH4jQfLr4XHSGOlS/MXNbrpJWtF+pwV+w5bi/4SKNE?=
 =?us-ascii?Q?PUcyn3xmyevMnjHnmtUChSZ3YnaHJlZwDB3Lm2xVlwhvTtvsdnt7W5o1ntEp?=
 =?us-ascii?Q?AFCUw/5jXaAG5b8f4E/niM5+rEGlv6Fc+S26Ldv1Z8toD8S9ciy40t+1bJ8D?=
 =?us-ascii?Q?veYI+sVcFOYFhbZSJ+sdrp2hY6dOVBsGN21E4wfSrQyuqwq58+ahBd7YaN6S?=
 =?us-ascii?Q?i4Iz4IOSX/prL83+EUgNV/O41LKdV32YEaFath8AVbu7N0UIOSrtj8xQ5BQc?=
 =?us-ascii?Q?nrJy50m7kssC6Av4hdKb3xzmj5lDwvJi3TOdal1mkwheRLsU0s6KzIpkYbjm?=
 =?us-ascii?Q?I7ko99XZYHm1yyRz1bA0aqjTRBg141/CGEhjC3rx4+LzIrUW5GiUhPZ8b77V?=
 =?us-ascii?Q?d9EY2Ju3mzsLbOJLhhcPdy/lu4hHRVDudpWwPTQ2kidtHBJi6rvKJK90Subo?=
 =?us-ascii?Q?6CrA/uazaNiFEsDJOBLgL/3Zpaqdz3yKaHoYHhLFMzX4UUfTVSKH/gfRfAQX?=
 =?us-ascii?Q?Mj812/AbAC2ZAmSeoj2oT4Sf5uTIwjtotbFB+yxSAxs1Lzbk1NqDZnSLTWEU?=
 =?us-ascii?Q?5vW3es1NdI1e6Lfu+6lu4e7+0LU1Sbe9me3f8QxFNy+NV6g2f9rI4NRendq6?=
 =?us-ascii?Q?AqHhsyubvrRiQADsyA/WUnJNX3Uz+If65mhfZBT9xwFbiYZRg/6gxzn2kvN+?=
 =?us-ascii?Q?x1ctAHBzkotCjcewhlIUspn/+8FOedYSxe2ZKw1pp8M44rNgdZ/Pvg7zjHhT?=
 =?us-ascii?Q?EQAKjYmmL95k87X5DBnn9fY7r/O68N04TCwTCIRVt3mCOCpF3ILCF7mwaCeD?=
 =?us-ascii?Q?cTs+cvkp/zV8UVFMc2tnloyQxxCBMoiJT2dEZtL+tNRe3gAQ4QD7+c9F7PYz?=
 =?us-ascii?Q?LF1/4FK4lVXBMGUBbgJ17l7qfyT5+ysiRZlJWmKRIHRysiBZDbHbqtnQvbKB?=
 =?us-ascii?Q?6C4Y4w0eMKlZ6yjsQ6hrj6I9Q6I23OdqPMQTAI/0qVrzaLxaApXLQtPHJIEV?=
 =?us-ascii?Q?eg1Y4TaqCTQh3Je6w2To6n735fyIyiem83zmE8H/LAzhKMMuIRodAbsVn37Q?=
 =?us-ascii?Q?FTtUhUP7wDfYKRYwKbcV7it1NBM3Lmz7E/cfcYbscqzjB0tlQ2hp2QRQAGH5?=
 =?us-ascii?Q?L83J3LMy9kv4I8Ax/L2Hqtn7dP0ERnJceXE/T4rcjmVlyP6bxTHNPnsXDjkc?=
 =?us-ascii?Q?4rxlO3qcOsYLXsGzvzO8SNKg7liC9brMRdyi0Sa0cWUnKd3CaOSHj7AZJ2Oz?=
 =?us-ascii?Q?PJ4yxS86gSP9zKIOiQeGtX4eS1nr614Tn3asXdefwYn6dT8Es24k76SyskKE?=
 =?us-ascii?Q?Mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D9DE57962CCAF84C912DE5D9C2C5CB0A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a31fc44-e580-4714-e4cd-08daea74b813
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2022 14:47:05.1451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zc5QdGqBovABtpQ3PSwThCE0TWKOAH/0fwVxX3mWroLvecGUSbu/KVGnzWwDrh7nwTI7rBpr+W7WyOQC8eum3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4516
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 08, 2022 at 02:55:44PM +0900, Damien Le Moal wrote:
> Change the default value of the fua module parameter to 1 to enable fua
> support by default for all devices supporting it.

Perhaps add the following to the commit message:

With this change, ata_dev_config_fua() will now set the flag
ATA_DFLAG_FUA by default for devices that support FUA.

This will cause ata_scsiop_mode_sense() to set the DPOFUA bit in
the DEVICE-SPECIFIC PARAMETER field in the mode parameter header.

The SCSI disk driver performs a MODE SENSE and looks at the
DPOFUA bit, it then calls blk_queue_write_cache() with the
value of the DPOFUA bit, to inform the the block layer if FUA
is supported or not.

The block layer will not issue REQ_FUA requests if it hasn't
been informed that the lower levels actually support FUA.

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

With a less spartan commit message:
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
