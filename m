Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E732C4707F
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 06:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F1D61408
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 06:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhEYGgm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 02:36:42 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:54928 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhEYGgi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 02:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621924509; x=1653460509;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0CsXVlvMhGL0660VgLMsbY/Cxe1If1U78TMIBuWUeCg=;
  b=L7oVBinRwal8Y+CtuVqoHqYHfRK432PWhHp6VHncQ47y6cFAcYDIAVBV
   FShNiHmCLH8BAVvVVswETkaUDqaSPpDxsTNTiZLt3Gniuc0zSEoeiuPjT
   YsiZ9DomMYMUA0RfCDQsn2lxX94wrHAdNhw2ilxOOPQjp6NxQT/D1GMQ/
   vPGj3jX05gpnCXldS2tduxtkj5CccVB12Q78sti1StAECdCtTnjAJypjS
   1P7HqfMULxWc3kADuCRt0IPl4tGE7zq3GazMKcZSAunkujqpXbY5eOjSn
   wLb+sNGLzZC6yXFJGRZCvLLw3BE93FT3H1ZtxC2bDzAMjsDYg44vRQ+4G
   g==;
IronPort-SDR: bKs8OJ40rEAcLCjw07xCNfjKop04F5sY1ECR9PtenFH9eGH/lpVlr4Kk6H3VrWpWOcjVjaUl+g
 EQ42zgVwppGQY9gl9nu2mu+ZMVLZBemOOCNRGkobA5DNFFIifpf5AIOpNt46Y+MxWL78NnJkXm
 G4CwBPkASJ+sb1a/Eg51cm97u0VHm3v2nlrRRpoM5DdqWA50tTCD0Bq1ekYg7YhiQ798SX/95G
 wWPU5kL/EOkg2DzOsOWCX28A7mAUu5zlcgmICg2/St2JztjhnC/f5G+nb3uRlewOLvWUb/y1a5
 cXE=
X-IronPort-AV: E=Sophos;i="5.82,327,1613404800"; 
   d="scan'208";a="280623360"
Received: from mail-bn8nam08lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2021 14:35:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlBuMqxu4hEGQe4KVuG0a+Fw2+GVKtM7rdwWZwr96VIN7+HO5FglCRZlH8wuCm+qMjpdSSra27oD9stCPRW+5C/MmGyi0v+2iXcMkYFxjgIoghinKoUPI8btL2p+MyuXprW+hqHMRZET0AujAJT8ENRhBDHvdc/Az50XpqJ9SO/O4OJD4+rj1ogBVHBBzLMxj++Fe6h0Q1L+wMqrf7CEsos+cfdjc8hCncgGeFjnbqNGJ3L5p93cfQa+Yz4Mat7GBb8yZJmH5UcpPltH1wbMATECn0OBikFlnIR3M3Lnf7t8R/MgJT2wVIddzVfz5QThkZucCkF2YGznQXdXnFXUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CsXVlvMhGL0660VgLMsbY/Cxe1If1U78TMIBuWUeCg=;
 b=UJiY+zGKbbE3gLG++6u1DxVsN+aAE820LxmyofqAvn8OSwbV2Q3BoS6wyEI5Vf8HkRlNEi/NIs/S5CGH9+1zOTIE/EbqXqpgMzfpYNGolI5Yw0eJ0N/iQreTT1jj+9c960PPZqneL0X6m8U7Ei8Hi3dQ7GPEphbNTBCNgFiE9Z2wm1URb1ocNxgVwYgf0ZVaIAIZ7fCxSGh0G4zcsflClBVhnI+TxewdJ1mKjwsLVRY6BKF7kGTeLoZgsKivEfWdxtJbBJ474qM8DKWJKv9SrrEybITcl3bjAHNhbdudE4wyosXabotXvG6dIbomr9EyaGE2kLCWaAH2sqEaqvLXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CsXVlvMhGL0660VgLMsbY/Cxe1If1U78TMIBuWUeCg=;
 b=jTqygh9OsJEAPf4fg4G1bXgQB+neKh1z80RTVgl2sUpm8HBFymHktfzlFxyja0x46tYib21shuimh+43ZAQF6J4TqnHnwYnq8slatTLl5thDv5SxO0OuF3pbEZ2kSEx8Y1kZjErVoRsY/dcPxI3TvlPUVINcjU9SZc4/kYXkkUk=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4539.namprd04.prod.outlook.com (2603:10b6:5:2c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 06:35:06 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 06:35:06 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 01/11] block: improve handling of all zones reset
 operation
Thread-Topic: [PATCH v4 01/11] block: improve handling of all zones reset
 operation
Thread-Index: AQHXUQ1EQNMzdteJWECqsLfWuiJWkA==
Date:   Tue, 25 May 2021 06:35:06 +0000
Message-ID: <DM6PR04MB708184EFEBB8AE75C49A39CDE7259@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210525022539.119661-1-damien.lemoal@wdc.com>
 <20210525022539.119661-2-damien.lemoal@wdc.com>
 <BYAPR04MB496571E36CF14B9647FDD21186259@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:9d12:5efd:fc6d:4ecd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8661c5b0-0b2a-42cd-f3ae-08d91f473c6e
x-ms-traffictypediagnostic: DM6PR04MB4539:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB4539F7C838445778CE40BD66E7259@DM6PR04MB4539.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ymaoq9XbALW/Ef4sbfJhKTWPvVs9PTkCrVKJQAab9wB+0OfUMnx+JFwfqiwZBP5tXgBAkI1YGcxUYTyXH9REIgOftJ1MrF73vGelLcBAwqJ7yRaap2CIVXzj9KVtYOP4tgwjvPK8oEsZXS2XKplQsn4ApKHHITbswmG25CzSaoimL+UQz+If5oU54y0oge1hH0giY2ZRCNMP+7ZoiRySmvU++bLyQXOygw9n0pg6RMJUDNANtu/ZeIefBim+3NRBV/2IBNa65GWcmKy5OsYMxs61pIYV7bsICCh1ePoSTN4ldWCD4OSlhHU+RYxPZ6GnUYxAEWRZggnoF3stlrmrQzgzZyVPxo3l1Cv4vN8O+mEcJxz93MrAQJylBdFSYP2gbaM6CU0e++d/Bav/8HAdH7WBodaSW7mdkI7aYONaG47VDpuurtAqUyLfS8uKapYrogECiAXtHVP1YMbkEPdMpbWMdnnmA0SaWpcpvI95IB5AltgiYbx3n0PpUOTEjfjmEq4jYEbeydTMkaB+AyQjoqP0aT7lSGfbEKHmKhSci8krNSK1QBMlJQvKi1uzVFuZ5jXhIdTn0sBJ7EuKwqAETHSjd3BEia/n9E8XKNB7w+E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(83380400001)(76116006)(110136005)(316002)(478600001)(91956017)(38100700002)(2906002)(122000001)(71200400001)(7696005)(6506007)(86362001)(8676002)(52536014)(9686003)(66946007)(66446008)(66556008)(33656002)(66476007)(64756008)(186003)(5660300002)(53546011)(55016002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UCHKxHMuuTYNdv2j13Zs2HGHoiTbu/VYBp3IxL4lXx9kbG7JLSKmWjCNDmQx?=
 =?us-ascii?Q?nNmXx4EQlMcg/vMdO9pTp6BFiHwYkPy/ffTN/fECGLrahqQuzqY45ldLBkIW?=
 =?us-ascii?Q?p9Y4lb7b5pPtFDqWEABmCU1QVgIl/AZLGQBwe7iwwMnmU1juTLrvfoQ/5Bf6?=
 =?us-ascii?Q?nyRPwOKCNF56spEgJ+uAbf0Puvexg+34S8/BxTEtrd7R5OH2luHNgnXqobd/?=
 =?us-ascii?Q?xJn2YZSA1OlsFyZblcRSW0NhZ177tLRJbWBAbjFBjcC08bE+NF2ZuMEHeVak?=
 =?us-ascii?Q?XCihnRnPMvpR5fh244uYDlSqOrg3AVDIBpD+//lliJCtS4aIZrjNd9D3Acm8?=
 =?us-ascii?Q?qAMX9rlsS4WXPOAYgeSjazQEAHj6u6tY1T6bElutPREOXwKb3mf59WDMaYoI?=
 =?us-ascii?Q?zpEN4xMtwWGuG7Zrxu/Dv4DZshC0T8fiEHvBzL5adcw8Pm+tx3Samn+rdiS1?=
 =?us-ascii?Q?1wmryBSrpwjyG/QHNnb5cL7XsLU71Xi9FH1GFPjRLVYtUH1St/SdwCAZOoGJ?=
 =?us-ascii?Q?+mtrIClzujFY6/ojnS4r187+pB4k6FpyJnOI9gnKTL+sjg2XxBqcS3veu1LS?=
 =?us-ascii?Q?BhdCyvKCeGryIPMN9x5ESYTsWyeYif+pwztA4Ypmsy1Sg7BBzThUQOT834++?=
 =?us-ascii?Q?3j+Z2WD/9WzKWDpupnzGR/CqR0YH8KKdAWFJKwq8Z9eQ0WWWSJQ50Fi5SIDW?=
 =?us-ascii?Q?0BNTh2aC5856WR6wZ6DWhlIldD5FIe+Q15G27twV3iWP/pbyyXQ4dzJkG51D?=
 =?us-ascii?Q?Neww4o5PCjU5xEUUN+sAvlvGWBIsr0XRsVqo/ApuCkPM4j4IZ0IkocPEJM0P?=
 =?us-ascii?Q?HGpNV+/6kQq8MpljTAUOjElIMueYqUQCVjZ5Ucny/SbGz556FyPfCf60rMVV?=
 =?us-ascii?Q?Pe90HmBcD+uWEAZ0sBC9yvv7fyRLc65mReYO1KkXN5Si/7zs/6oo1CgZjACr?=
 =?us-ascii?Q?UrEPChOLUzyxcPLzDq+TwQ2NqDU9hSXewrDyXM3YUHH4+Nd3VHjG5ywwvDdq?=
 =?us-ascii?Q?G3SrQh7eTVc8PHT4/adiDVXtc/sUcrkNDHnH3EKMytV6BSPMnW98WwBNeR3W?=
 =?us-ascii?Q?SSdPz1awNmusHfDGgGKJz6US0H794pnulZMuVNe6aBERQMDrVafVChZ4j40A?=
 =?us-ascii?Q?DP3RUUZwreh8VnUDOQw5HEm5EPH/Hvv7IINhQvsz56XJJho/lqhNGnLB667U?=
 =?us-ascii?Q?ypk0Nat6IMRKgpjFG3sftSifhiZKDNI2RlICosH4akEj1c31N9SoLu9oxVR7?=
 =?us-ascii?Q?dYgEc/oirzru0ZrnQzZL1qBHOnGQ98pnBbDJ2RBa1Boe6Gd7DEXu9XwKxEP/?=
 =?us-ascii?Q?ax+pWSIbwikOD648HPS8bN5SuUm0OGTwKlIqnp/hqnNbboDtqVpVDnH6NQnP?=
 =?us-ascii?Q?JZVolR5J65nI3lDFm3TDs+5fOquO+u2iX3sg2EXwrnxZbPEawA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8661c5b0-0b2a-42cd-f3ae-08d91f473c6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 06:35:06.6171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FaC/WGNkXrW96gJZd8nKpcP8Ks3Lo26c3DNMlch4oC7nLic69Djh02F5FS0P7uzczXnjc31pUYua6TB7JOVwfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4539
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/05/25 15:15, Chaitanya Kulkarni wrote:=0A=
> On 5/24/21 7:25 PM, Damien Le Moal wrote:=0A=
>> SCSI, ZNS and null_blk zoned devices support resetting all zones using=
=0A=
>> a single command (REQ_OP_ZONE_RESET_ALL), as indicated using the device=
=0A=
>> request queue flag QUEUE_FLAG_ZONE_RESETALL. This flag is not set for=0A=
>> device mapper targets creating zoned devices. In this case, a user=0A=
>> request for resetting all zones of a device is processed in=0A=
>> blkdev_zone_mgmt() by issuing a REQ_OP_ZONE_RESET operation for each=0A=
>> zone of the device. This leads to different behaviors of the=0A=
>> BLKRESETZONE ioctl() depending on the target device support for the=0A=
>> reset all operation. E.g.=0A=
>>=0A=
>> blkzone reset /dev/sdX=0A=
>>=0A=
>> will reset all zones of a SCSI device using a single command that will=
=0A=
>> ignore conventional, read-only or offline zones.=0A=
>>=0A=
>> But a dm-linear device including conventional, read-only or offline=0A=
>> zones cannot be reset in the same manner as some of the single zone=0A=
>> reset operations issued by blkdev_zone_mgmt() will fail. E.g.:=0A=
>>=0A=
>> blkzone reset /dev/dm-Y=0A=
>> blkzone: /dev/dm-0: BLKRESETZONE ioctl failed: Remote I/O error=0A=
>>=0A=
>> To simplify applications and tools development, unify the behavior of=0A=
>> the all-zone reset operation by modifying blkdev_zone_mgmt() to not=0A=
>> issue a zone reset operation for conventional, read-only and offline=0A=
>> zones, thus mimicking what an actual reset-all device command does on a=
=0A=
>> device supporting REQ_OP_ZONE_RESET_ALL. This emulation is done using=0A=
>> the new function blkdev_zone_reset_all_emulated(). The zones needing a=
=0A=
>> reset are identified using a bitmap that is initialized using a zone=0A=
>> report. Since empty zones do not need a reset, also ignore these zones.=
=0A=
>> The function blkdev_zone_reset_all() is introduced for block devices=0A=
>> natively supporting reset all operations. blkdev_zone_mgmt() is modified=
=0A=
>> to call either function to execute an all zone reset request.=0A=
>>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> [hch: split into multiple functions]=0A=
>> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> =0A=
> Apart from nit mentioned earlier, looks good.=0A=
> =0A=
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
Thanks. Will send v5 with a correction of the extra space.=0A=
=0A=
> =0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
