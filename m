Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104CFC433DB
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 15:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFC0064E02
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 15:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbhBDPCk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 10:02:40 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:20752 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbhBDO6X (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 09:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612450703; x=1643986703;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Vcr54MFDb7vVTVmViZ46S6yTXVvyaN/TSUg+MAyFpb0=;
  b=S+F7lNPmClk21dk/AxfjbKGgaodZJ9ce4LX5fkPZrhJ4gScrOam4bJ1N
   0YVZ9E0l1DRXKMeavQepkRtHLRHkgn2t2eayelAUcomIa8GZehKakWKmN
   cEK/U1n84tn/etxXcRwNhyMVugewmbaawRWLXC1s3OtMSjCTU9vQkCfin
   qGcEz+yqum+jvbRmRONay4zZkxjVdnmTyXA4iVDcLz7tHnTayYmXkUoxR
   sMfUtMybukAhzMy9iwvy8368Gz4SXrF/Oa2nVUKq/NU6Kl2GkcSM0dwHM
   AKgnhLCf4gcbK7LN1unD46+8gkJu+urNzwINIEeZFh5tgol17pPCMKVgF
   g==;
IronPort-SDR: Tj3yeQqKUNZL5tKy2r8EO3occ+7VIMfuhr9hOz1yaOoAvdj6a40ePtjTFVCqSBMVFFTR8wuhcb
 aZH59opVzRXa2MZDFHoTcO7XZhsZG+e8YteYQEjnRggFuhvTb7UOL5PU4n7Ehq4VGw7CR3ZhtJ
 uabrmcyKhHxqYG/Mw6vR4tOSgkOvcO4ixR1goj8h5fXmaOtWIjUBXZ18g1GHOLXNUs3m1TKOmL
 ZyN9NrIFoclQvEZ/SGIgDikN7osgnvXY2d4/5Js2U3a4h2EEZiItFsiNNVWA3qnbWFN8sg7ld8
 NcI=
X-IronPort-AV: E=Sophos;i="5.79,401,1602518400"; 
   d="scan'208";a="269557849"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 22:57:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoAx28XWg5EXcThuRcrBCSB40swwJ3k7k8lD2pCxsrzr8HOo5O3tNdWyrOJdo8jr1ZwKjHywrN0fTnFgxxBzKrcWNcrjzU/J5NgP1otC5R1fV+GMdNJQoNKRFCecxkTKgCEXsvJtdt4sdclDHEp6sPJlRHjcVgwo5PGP1p1pFEzsDenVDFuhkf9j+aNSOLjONZip3y3iHG/QIf3X/kVRrDsa2Wxecq+8bmi6IGky1QwDb81csIYwhgXMPD3DhyJS5X0AfSdp7rCqEYsv3wO2HUsv35i4AL9ZGig9ZV+nsH5gOuR9T/mA2EGTGu/3qsFsDzrCbCso6BWgh+awRNvWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vcr54MFDb7vVTVmViZ46S6yTXVvyaN/TSUg+MAyFpb0=;
 b=WVOsJGvesIATJa5KLFjjLfDP8xtfFSzKaJul3WfxevRviXqzWm/zRfRrnAyjOlFcZchpJtSRcivWnkIYB25N6OzoijZ6tCyZGccmVH6sOORLM31ka5ejj0X2yahnIwGQtNwyvcma6l+wwsoiIULm8vANku9b5/SdJ3xl4xuefVAJuxTrznzYQR1MGgnZvxBFRnCOOXgiGgI1dvAoBngv4Yol+rfQrzwwwfb2hZuBU1Mc0axLUNe93XiDdRTb1HgDzmv9m1m3Q1qsltARtSf7mruhMhV68T9TyP1KG6x0W9lZrKGeor+vZmq2qlWEH/8HEE3YfP4gkBljPeJSWE5KjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vcr54MFDb7vVTVmViZ46S6yTXVvyaN/TSUg+MAyFpb0=;
 b=cbl6WRVtmGHVYgtCzUMwdbMv6sb3F0X9bmqtvlKt2Rlb45uoP9E45YeyPEyuqe9dIm38ERdlJ5FtG2iMkj+GRjSaearurWv62kYA+gFtPUl23mVawA5R4zEYbR1bIR4qwHOq4cqVH0d7Dy7NDmev2DcELKgtlUbquP/2oeeBQtI=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6413.namprd04.prod.outlook.com (2603:10b6:208:1a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 4 Feb
 2021 14:57:10 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 14:57:10 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 0/2] block: Remove skd driver
Thread-Topic: [RFC PATCH 0/2] block: Remove skd driver
Thread-Index: AQHW+tIP657CBmgMn0mo5aToTM0MiQ==
Date:   Thu, 4 Feb 2021 14:57:10 +0000
Message-ID: <BL0PR04MB65144ADAEF7E22DA3A158BEDE7B39@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210204084343.207847-1-damien.lemoal@wdc.com>
 <3cb4ca54-b916-5793-0632-bd12ff9d0006@kernel.dk>
 <BL0PR04MB651463DB539857107251E174E7B39@BL0PR04MB6514.namprd04.prod.outlook.com>
 <2332133d-9cf7-3692-f27b-83eae602c7cb@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:50f7:ee01:712b:bf92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d03716d8-d0bf-4c9a-0003-08d8c91d2627
x-ms-traffictypediagnostic: MN2PR04MB6413:
x-microsoft-antispam-prvs: <MN2PR04MB641317FAC0537CF62132FBE1E7B39@MN2PR04MB6413.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qHgGGNlURjV0UkCS8lJCn1wM/iosgYFq8IGJh9TVqsevETcwQh6T9HPZ31OMySv3UIDwI6SYIp0yj5889XKpdN4fjxkcobIPaK0TKql3rvNRChO96j6Gota6tEjbLxpuIXab9rfa5+DWdiAgAiQiP4fa+l2r1uIKxOS7ObmdOnoc0blPfg1mZhB8ZSJJc5TveF2tK5tvGgWeYA4uw0nvVmcgN5E+C5DWUo0Yw2kRzvV0hZNMhFndUIfCEcJQAODwIPJEodR474tIXUigPqKmcD2kOECgbNsM7SeISreNBemKRX+OpSQJ1NT5+UXao2rN6MWaYdETExf403EukMgE6z6gExAvpfX5S5gtvoG1MXULlXjALmy8Cyvja7b13lDdlS2cIAUz0AQZqfPg+5KXOtmcwTv5blxdc+YE8T8OqYjL1QSv+63Dg9M0qxvnCbGgcaldWcRTgSc1f5bebNGd4pzjuJzoMrfNK0Ux/6B8cISNjxYlk8Rd5MW6czuXXembOiNloHg0AilX0anPf4EzCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(2906002)(71200400001)(8676002)(9686003)(33656002)(86362001)(55016002)(6506007)(53546011)(186003)(7696005)(83380400001)(110136005)(316002)(5660300002)(52536014)(478600001)(4326008)(8936002)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DH1nwFQ0Wd7VvoPlZYVpVrufgq5Sv1pDGW4wbJBVdt4o6mT9F+4nRo8jcQwh?=
 =?us-ascii?Q?H8c7bKrzsC3yN2Nhshj7sJKVDOCVELVe3LGn7qXon3RSR/q1O7tkDq2uwdpE?=
 =?us-ascii?Q?kOq+3O+7qKblfGcouRa9lpjtNMqcz7/FOTPVQeIsZnh68TemrEt0anwkbSbP?=
 =?us-ascii?Q?rVe1D1vLGeg7lVCJ2ji6Mw20NcvlfQWqJndzo80XKGSJuNKj7X1vRrfov4K6?=
 =?us-ascii?Q?kxouN/mZOLcC+T8jOl1coCRJKMpDbQjJQr++zM8OfC3ag/wrta9PmE07AQGf?=
 =?us-ascii?Q?1xFcoC+X1C1gz1yZv2zDFy+VQ8hkavHB7gzHdE+aeYCrDdPn65jpwq1S0YkW?=
 =?us-ascii?Q?mvY+q/mUiEAQiF7WL3V6edi18RLY1xD6KZvMh/6hOpqXlPJquaXnmXQiJiIC?=
 =?us-ascii?Q?MvFsJgsX6YzKJY0QClGBtq75va5AbgHSH6aIiF2duwClAyUA3EFYf3ZdPUGM?=
 =?us-ascii?Q?ZXqLfpQaMfLkkAi9y7steamYTAvSzb4rhca1+m8Ue6HBOE8/3heEbty37CBa?=
 =?us-ascii?Q?NoKpid5Klpf6TaKKUXilVPht8tgG+siEWQ9kmAP8AyBgI/MT0FpxmeTXeEDJ?=
 =?us-ascii?Q?0f7kj/+SA/F2BFXVWOcBTcgFZ9vyi9ggnvlW0pNs2HVZwMNn4nVA7vzZszbX?=
 =?us-ascii?Q?EelGVbu79osuwkZo7johv7cJQ/T7XIGrpsXXJMTZVxBazs4AndkPhfwaD0h5?=
 =?us-ascii?Q?wyFDR3UduSsW/URiWUw/sfgaWK8mz+AYAs8jtOAW+R7agMDvO3BiR5bKajcI?=
 =?us-ascii?Q?y5xDhvyd8sGWct/vkSFIlr+OvZqzvD4+BPhDzZ+gUVX/oCP/CGgVx4dbXxS1?=
 =?us-ascii?Q?GO4U9zA+jEBktssfrMhKUc8Tz9aNbeRVxG827gi16IW8pZ9DBVs8Tsm97tiE?=
 =?us-ascii?Q?JyuXU6yKksqWiPoEo49u0+TxqQd3edg5qljcOYLHPgX9+NbhrhVYeRGYzLk+?=
 =?us-ascii?Q?sELf1iR9ANbpVv4mVjGfekHjwMYb5dZkFTHJL6/7ZtBMycgC2EAxXtrrk1LX?=
 =?us-ascii?Q?Z+48bSUtbl85VvY0EATDSAwpGboXqPMCFuPc4uUmlKGjl4FLtnZpR4xc77Qk?=
 =?us-ascii?Q?zsZuBZPUwEvur1QSBG46Vko4VOu4shPz7T3y6Juq7rl9wRwVMW4WNlg5efEb?=
 =?us-ascii?Q?OKlbdAjKd5TjW5Jf4JdAXfp1tKeHhYJbKMHs8QDiABnTHB/euvy8MU1PbNsr?=
 =?us-ascii?Q?959//YU9PoseZI4yTAIOFq2iRoCoYIpbav6CEcVyBqlq58LdsFgHVescOH8b?=
 =?us-ascii?Q?y+un0prCvpbgsYKEKpxbAMfQteifOvUurP3S2vGJNjJrahJpwHkseD7puurL?=
 =?us-ascii?Q?q8VqRMdBwF4CNuYoQfSgHgDMGaVGZAgAW/WejqkeZbltlEN5ksBbKHrEao7m?=
 =?us-ascii?Q?tytqeaOOGxDvFWKirnBWvX4ctNiDS3tITI4RaXxWZg1VCBDg/g=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03716d8-d0bf-4c9a-0003-08d8c91d2627
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 14:57:10.2995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5spS4aUnGUHnwnkvAk4NaecqOjFy4TnMIQsZ8JiAaFRDkq8iUMYOserZGIHycqXowWhTg5x0wEXBDsnrP/NHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6413
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/02/04 23:55, Jens Axboe wrote:=0A=
> On 2/4/21 7:52 AM, Damien Le Moal wrote:=0A=
>> On 2021/02/04 23:46, Jens Axboe wrote:=0A=
>>> On 2/4/21 1:43 AM, Damien Le Moal wrote:=0A=
>>>> Hi Jens,=0A=
>>>>=0A=
>>>> Instead of spending time fixing the skd driver to (at the very least)=
=0A=
>>>> fix the call to set_capacity() with IRQ disabled, I am proposing to=0A=
>>>> simply remove this driver. The STEC S1220 cards are EOL since 2014 and=
=0A=
>>>> not supported by the vendor since several years ago. Given that these=
=0A=
>>>> SSDs are very slow by today's NVMe standard, I do not think it is=0A=
>>>> worthwhile to maintain this driver with newer kernel versions. I will=
=0A=
>>>> keep addressing any problem that shows up with LTS versions.=0A=
>>>>=0A=
>>>> The first patch removes the skd driver and the second patch reverts=0A=
>>>> commit 0fe37724f8e7 ("block: fix bd_size_lock use") as the skd driver=
=0A=
>>>> was the one driver that needed this (not so nice) fix.=0A=
>>>>=0A=
>>>> Please let me know what you think about this.=0A=
>>>=0A=
>>> I'm fine with removing it. The 5.12 branch doesn't have the later=0A=
>>> fix for the bd_size_lock issue, so could you just resend that once=0A=
>>> the merge window opens and the block bits have gone in? In case I=0A=
>>> forget...=0A=
>>=0A=
>> OK. Will do.=0A=
>>=0A=
>> Could you confirm if you received patch #1 ? It looks like the list serv=
er is=0A=
>> dropping it likely because it is too big.=0A=
> =0A=
> The list is a huge mess these days, including lore. So not sure what is=
=0A=
> going on. I did receive it, but it wasn't on lore, hence probably only=0A=
> because I was CC'ed on it.=0A=
=0A=
Thanks for the confirmation. I will make sure to keep you in cc.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
