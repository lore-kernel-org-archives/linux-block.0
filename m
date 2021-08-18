Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7742C4320A
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 09:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9168D60C3E
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 09:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhHRJyx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 05:54:53 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58151 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhHRJyv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 05:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629280456; x=1660816456;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bUwtLI1Xaq4JziVGVsN30CMu2iOwEmTgtEYz/d0jFlE=;
  b=DYsHhr4rTd3L3uVwAwKoVsRclJ2zGT1ZlL4luk/BGJ8c3lyWYa5ckrCY
   73Sg6YoOrdVpdxIkf67bFpIFen17+Hdib0FU0ju1IHl2qSSam0Iz2czyw
   1TjAJp0WUP/2hTT9OXWTlzBfuFAy6/vWxIAkSV6lIqkIK6Jw25c/kOSzd
   xt2ozDLsOEA4d/nV04y0/WR07s3rgW0GDc1vqL1sadhSPIL6gj2aHOXZd
   z4//1GG2lYb50TTCtdujHOkxgaJn0m8fZuMuw1p2D6AV5S5blk+3cZ8FK
   IH0oF6oUHPp7fZlQleQL10JATLc6iFqvFemCmKO15ZydCAwuCiuNqSfVb
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,330,1620662400"; 
   d="scan'208";a="177628268"
Received: from mail-mw2nam08lp2175.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.175])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2021 17:54:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdcEUBvKliP5iwnrA063nFv9H/SLLf61/V/OFx6j7yRDPQCb+8vLi2lDlLCcjrDuijUJl2bR70caM3uYGk2b10CjezBBPiusHhOYgIMRJ9RdUPNiRp5CLnEdXLFsvtCsF64Pp1t9Wt8UQsZyGtUQZJUSelmkhcuNPGZSvSLV6jEs0hf5kiTYj0+tfqbQeRwHflOOwPWPEZcMWdLT5rCVN/erW/YXIU1vAv6TC+8Ao8aXou7pnTTNAzlO+IrOKG5VAyDteiUURP5W6GFNoq/HC80mxev3R2sQT3U4pRfOiXh0y8zGLuWDuO6lcETkqJi3+L6iPreE9g8iQ1nfIv51VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pEYpZhqKDWdeFAhsISlL6M80uZHMf4gIIo05+abxXc=;
 b=bxPHzADu0zO7dL6MLmjVX3nR09dYxQiIIvlCCh4pYIoUgKppfSLwvIZVkxcFDyThCpaD6TOCMhuN9xdmvk5vmUb2xAzJrYrrEUNRNDDF1kK6gTwxQPEr0FOSWaf0JwlfJ7HBm0nA5Kaxh62zbTJsXjKdGGUe8khyfvEvt2042P+qveV79nWU0+UxnmGIBBHVrL+1KQ152rxuA6k3xQR593HYRf5KReHI57UOHBYF0wXVjcqzVawNi+76Tu8WrRuFMXQXpfxyh1w7W9eaE+Q6q7+7nFSXPRr9N/dX8grcK05R0iTG+OkrOLbhnSnnDg5IDtRxAjLb/M3/qTGgbOsV/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pEYpZhqKDWdeFAhsISlL6M80uZHMf4gIIo05+abxXc=;
 b=zKXa6eUkm4YtDwaeA83o9hxOr/5jar3Gg4tC+inmBupP0StvovUO0qFIrZbM6vf9WeVaC7w66PM1oelWQJjHU04KZv9zTlxPrFNszZJZK8etp2HlD1c7ZTXV8Aw9wUhanwoYYxcFDbeOxRUcKOKswONuyidogtvYDn1mCc7uDbo=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4826.namprd04.prod.outlook.com (2603:10b6:5:29::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Wed, 18 Aug
 2021 09:54:15 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c%9]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 09:54:15 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v7 00/11] libata cleanups and improvements
Thread-Topic: [PATCH v7 00/11] libata cleanups and improvements
Thread-Index: AQHXkkBXWeg42l5KDEqQ7BjXTcXjqQ==
Date:   Wed, 18 Aug 2021 09:54:15 +0000
Message-ID: <DM6PR04MB7081B8F072CF016FE63017A1E7FF9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210816014456.2191776-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 539084a7-dcf7-4163-d481-08d9622e23b8
x-ms-traffictypediagnostic: DM6PR04MB4826:
x-microsoft-antispam-prvs: <DM6PR04MB48260B63F637A9C3A6BD42CFE7FF9@DM6PR04MB4826.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:626;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WCZ1tNdKecsY0JDMDQOQgQtbgrPc9GLIGvKk6NxT/iDf4cfjf8xE1rq/6CG/kZXRkcVI13lyRsmUIwognPFk6xJ4zdM1h/L1IAfliLbgZX3FICpfbgx9nO+/KRO5u2n9bp3r/Lt29/8VYeLbDnZG3naXqy6hHedE5oHUByJSZ8GjXSUsc7PBooT15SqlZngO2RGMpcx494+FovuBNrhNdf2AiNtjiD6612p/Njl64+UigGnIJRarX9Ju9wr/bbXrVB9LZjINsloGATpHlbGkiwnBcCFBEpFQNo/SsaWKiDLjbAJ5WTvlcz1mKzp4cCcWHj0SQ8L5o2EN7DkZT8EykaQ1obLqyvbvOSZ6iwcjhr/g1GE62k+8LitdAIT0/MVFbGvdCg3elV0n+ALPYBnwCn4cnaZmdHBWJS40Ia9NjqvOBoEuGDrLDJgJGwZieXY5lweW9M492gF/CkVotDqQi5piTAUquc3KfMPOIeyykT2H51ZXv5Dw28yzUJgnu3Meh73lNgOriQocD0nuyIU3cPhXYFyG3wMlWgeE9OP1PYolZ60JxnO3h7rrohmCdAFwmHj5Fj39P+ASZahkiQfT+bU0SKOPTriKwJYR56imojP3ssA2TPNZLqkcae4jzYodWSCa3sRdF6NAgKsTXs5FcPqsluRwxQj+1NtLG30iPpRBzFT96x4BCPzaahpL+y5KdUmX5ndkga5FLooTwc1PXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(8676002)(4326008)(86362001)(186003)(33656002)(26005)(83380400001)(8936002)(38100700002)(110136005)(55016002)(9686003)(316002)(38070700005)(7696005)(122000001)(2906002)(66446008)(76116006)(91956017)(66476007)(64756008)(66556008)(5660300002)(478600001)(71200400001)(53546011)(6506007)(66946007)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3cfvg1U1N6H99BhPtdtpPDrdt0ykhElPlb+zT4x68HIVeG0kHGaGdbnhV/NY?=
 =?us-ascii?Q?uKMW8UGrWVIU4Pngcz8pF3JvyfVMRWSXaht5Li9YvVk4RMMwfSG0QsS2aITP?=
 =?us-ascii?Q?wiw4t7mzTfzEmEw0bS4liMwHFwD9U9U7ekNppH6Tfg8SbM0fZAKm8A3qoqAn?=
 =?us-ascii?Q?r5YJQLrDSZYTBXiINwX5h6QnprG7+5HCvJHkfHgtRIDG11ICRNnFo/WpHKbk?=
 =?us-ascii?Q?A9umKwW07UaSW4KB0v9RZDGE83vDoMvyxQtTBj6ior2zv7raBUiMWQW2EMCi?=
 =?us-ascii?Q?qql2NtCwqPdkFCuUFSFce9JbcI3GEHAWMztJVCAF7UXi80klbZcmfCn/DVPX?=
 =?us-ascii?Q?m+l+6M/PhsrwBFEf8vgw2hy2gUmoQNftI9XAbFjbc4ak6dqYlA06zlxOHGRh?=
 =?us-ascii?Q?K0AYEUWnTmRZsiWzsXqa2Dq2pfKTZaUXqg8rX18izmaG4FUDn2ibB70hZACQ?=
 =?us-ascii?Q?hgH4JpbgXFOGCtUkBmkRJnFFCGbTgGzJoBfdtetaEOB33n7NJDUQMPq1Y6TT?=
 =?us-ascii?Q?zLDXB+nMjBN9QVgxT2BxvvI1ULDY80S6dgwxKaq87nUJttDtRZkAk3fjPum3?=
 =?us-ascii?Q?mzAModyO10dBZDlB5dpOFFq0Sz7AfAmh1jP8XyL+0989P0RZuXSNiaMil7d6?=
 =?us-ascii?Q?kEYTkqkEjHk1/hdDv0tyoT+aOIbNz1U5L9noTj7eUoLwM+E/xN5S11J5Zg9Z?=
 =?us-ascii?Q?zs4jdrOs/Wfzsvxr6F9ozpzheGaLVfd9I2BTuTf3xEfV/yL2HLnLZwxEo6z3?=
 =?us-ascii?Q?bK2Dq8vQk+0cX0YGV6XskfXuoAgmjB6+ZBM0vvk1SGSA/hBW/WU2/bvU93fI?=
 =?us-ascii?Q?San7seUq6n9nXzKOybfRzhHSrTrobOHY8WjMa/XXbOS426X8V5PgzEAp7meo?=
 =?us-ascii?Q?fCClF89+666fIO8dROrbK7bSM5It72PDliamQS2web4njXXabC36dbka7n3U?=
 =?us-ascii?Q?c4mAWkm49znqxS8MUhAjghY2QMIrbEXUp0ZKHn3IlayU7D+sCkga0ot4kMTi?=
 =?us-ascii?Q?e9IlZCyBnE3RwXZWp4y6VxEfGMQN7X5I+rgLPAHm4DunhOLVEM6D3IDokQ58?=
 =?us-ascii?Q?mrFDnkz/XxzsLw/tz+RnJGEskebvKZqjoYrWy1wSmgRYQtVAVJaRxSZ9Q0g4?=
 =?us-ascii?Q?Psw7PdRb18A13eiyUgODkH1jdKRF5nEipxRFS8J/ioC/5519+lVafrVFWIR+?=
 =?us-ascii?Q?YBGPNUXbM+A2kmre9wGCzNsCH+ZnhbnIxglFSAcyTkfpwPxUufiS4mo32vJB?=
 =?us-ascii?Q?tfGlEW64zpAsWXbZusqpOf5aC+86TZL+fy5NBjQO+O3jyUJ3vG+4GpaTi4Gz?=
 =?us-ascii?Q?be9XUWMH2pRuBi9GegVzCpQ68J6706XgxGZzJloonYUxnA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 539084a7-dcf7-4163-d481-08d9622e23b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 09:54:15.5386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jw9nK5Ixy5tjrX4xRC8BQpWe21MP2qRwTq7/EaKiCQNOjXglnh+m6Kls+k+qol5+GtfUCQwme1fN7RSg94b8hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4826
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/16 10:45, Damien Le Moal wrote:=0A=
> The first three patches of this series fix sparse and kernel bot=0A=
> warnings (potential NULL pointer dereference and locking imbalance).=0A=
> =0A=
> The following three patches cleanup libata-core code in the area of=0A=
> device configuration (ata_dev_configure() function).=0A=
> =0A=
> Patch 7 improves ata_read_log_page() to avoid unnecessary warning=0A=
> messages and patch 8 adds an informational message on device scan to=0A=
> advertize the features supported by a device.=0A=
> =0A=
> Path 9 adds the new sysfs ahci device attribute ncq_prio_supported to=0A=
> indicate that a disk supports NCQ priority.=0A=
> =0A=
> Patch 10 and 11 update the ABI user documentation files.=0A=
=0A=
Hi Jens,=0A=
=0A=
Can you queue this minus patch 1 please ? I can resend v8 without patch 1 t=
oo if=0A=
needed. Thanks !=0A=
=0A=
> =0A=
> Changes from v6:=0A=
> * Added patch 10 and 11=0A=
> =0A=
> Changes from v5:=0A=
> * Updated patch 9 to include adding the new ncq_prio_supported sysfs=0A=
>   attribute for SATA adapters other than AHCI. Changed the patch title=0A=
>   and commit message accordingly.=0A=
> =0A=
> Changes from v4:=0A=
> * Fixed patch 1 to avoid an out-of-bounds array access=0A=
> * Changed title of patch 3 to describe the change (as opposed to only=0A=
>   mentioning the tool that found the problem)=0A=
> * Removed patch 10 from this series as Martin took it through the scsi=0A=
>   tree=0A=
> * Added reviewed-by tags=0A=
> =0A=
> Changes from v3:=0A=
> * Reworked patch 1=0A=
> * Added patch 3 to fix a sparse warning discovered while checking=0A=
>   patch 1 & 2=0A=
> * Added reviewed-by tags=0A=
> =0A=
> Changes from v2:=0A=
> * Reworked patch 4 to avoid the need for an additional on-stack string=0A=
>   for device information messages=0A=
> * Added reviewed-by tags=0A=
> =0A=
> Changes from v1:=0A=
> * Added patch 1 and 2 to fix problems reported by the kernel test robot=
=0A=
> * Use strscpy() instead of strcpy in patch 4=0A=
> * Use sysfs_emit in patch 8 and 9 as suggested by Bart=0A=
> * Fix typos in comments of the new sas_ncq_prio_supported attribute in=0A=
>   patch 9=0A=
> =0A=
> Damien Le Moal (10):=0A=
>   libata: fix ata_host_alloc_pinfo()=0A=
>   libata: fix ata_host_start()=0A=
>   libata: simplify ata_scsi_rbuf_fill()=0A=
>   libata: cleanup device sleep capability detection=0A=
>   libata: cleanup ata_dev_configure()=0A=
>   libata: cleanup NCQ priority handling=0A=
>   libata: fix ata_read_log_page() warning=0A=
>   libata: print feature list on device scan=0A=
>   libata: Introduce ncq_prio_supported sysfs sttribute=0A=
>   docs: sysfs-block-device: document ncq_prio_supported=0A=
> =0A=
> Niklas Cassel (1):=0A=
>   docs: sysfs-block-device: improve ncq_prio_enable documentation=0A=
> =0A=
>  Documentation/ABI/testing/sysfs-block-device |  43 ++-=0A=
>  drivers/ata/libahci.c                        |   1 +=0A=
>  drivers/ata/libata-core.c                    | 290 ++++++++++---------=
=0A=
>  drivers/ata/libata-sata.c                    |  62 ++--=0A=
>  drivers/ata/libata-scsi.c                    |  60 +---=0A=
>  include/linux/libata.h                       |   5 +=0A=
>  6 files changed, 252 insertions(+), 209 deletions(-)=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
