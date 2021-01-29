Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8B2C433DB
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 04:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 645CA64DFF
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 04:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhA2EQ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 23:16:58 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:13081 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA2EQ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 23:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611893815; x=1643429815;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tTDa64IL7Y060C+u/oiFDYlH+LsCOo2UusUIZW06nJE=;
  b=Kl/lu5mFKmHo78VtzeY6f5Hg0e6jVV8N2GoIytuGUGcuew5qwys1pDes
   eouYSNJKx6Fo6JNGRfYgREw2C98mWZTOhCewodYHPFgBgMOZz45Nw//yg
   X36SlxYodehLPeG4Tx4Ky+gI7dUa5VxT71pIyoiRFrtf3OIuGHan/C0xc
   ewOnVGsDhcyOu5ZhK3gqG1xsPqIMkaBeLgWpCqMd7YJ6Jh2W66nxvx/eZ
   4l0FiFVGKgodYk6KpBkkUWbAuY74ckGLXMimf0amgJ1x2dte5auTaFEjf
   rJURNCySoSdwmrGosDJimNZEBuaMZeVHspRnPEUFmrmReLNFGY4cjUjQ4
   g==;
IronPort-SDR: 8CGYBrgp8LiXSuypPMxsnNbY3iwoMOB271H9Y/UAfJGrtt6X60FkOt8qMft1Ad/+fKIRhu1t+T
 DM/1IumxYZYk0p554tsos5XnfxZXNciqduWJTKvwkROU+UVh5QwEQIHiCFkqTG0/w8dSB+KiSq
 hTjS2E/FWZ2QE99to5sLvOFL6i9rEEPbaBz8rAaYR75R6RAlNiv8XkrI8drDmo4lYpSZaLn8BR
 igmbyYURvZNFUkvjg8WJVMKnBNMzTDouwaZsk/AVmmfd5SgVozCY8XrTgHf78/H9XoCfbPK4lj
 /j0=
X-IronPort-AV: E=Sophos;i="5.79,384,1602518400"; 
   d="scan'208";a="158604010"
Received: from mail-bn3nam04lp2051.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.51])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2021 12:15:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxJCxl20VDA+eXcah5M0/yyKadltQcEgPlHXNatiIz/9H3h/6nq6iPInJoZOOevhiPAF5wKnfsgVvH4hC0Z7M4crlKaJjssHvUbOii9bWtj8ctUWa6lenjKDsKCxglOcD5ASaEntkk4tuh5A/87aJLgnGTurEvY/1xMDyKTGhjTA4pmxq90cN7OvVm4PB5wc7LXZg9VPmilZQ26piWb8ggziNvu8Ct7wkiPqhqAmGAUZ5hnFWBSliCWDObapgCJQQqQjj0TIzqqEq4ZwbrpbP+a12RO2tObrwSW8EAHfwsPMOie46M4k5ZqgS0RBmHOdFJNnRiwqOEwhFpAIxEGO8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGeFrWJsSp+WOzU5+kLBj00AXn6DozBxu4dWaZ6hAfk=;
 b=HYxM7uOdzotX9CzUVtnMYxEUV4JWq985uq6/Bc7RJY96ThJxcya5+ejF+JYNy2Hdv+NAhIYnAWXyP6SDMaRooMKkDiUh4OduSHR4nFvVm9fTWFQw4StUo0qb1mvx2B97ICQ0DACB4gUoPomDfe5x/O5qcBHd7aihWZnpSzSJPVDp1qFx/Vu0FG2kJavtPa084lRTo4m8C1dcZ4wekqz9/wr04K/cgDnMu7ftuLKPRQYNfL1GE2Y8xBCpGFGB/uCOZgYxTCiEvebittA3o/lHn9ToL/lNqqkdpZjeUe6RMYSOkrxO4C1K8zi5DPGxUsHCqB0oh1SoDOHFWV1YnGy1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGeFrWJsSp+WOzU5+kLBj00AXn6DozBxu4dWaZ6hAfk=;
 b=MEcetulWZjC7HoL9NrGvUmY57Q3UQA8ljoXN5jV/1RtfQkXYY6SkJCS+yNwDWcgr/s+lWkfCz/cSKEmbcJtLngxSXJsG1g/d4Y3nfCBq4tvr99fYb0KAnrj/IclwwWEQ0xWYwVPTaLFYQPh5p2TEBeXyFpP3pN/XCpfwZjrEqac=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6538.namprd04.prod.outlook.com (2603:10b6:610:35::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Fri, 29 Jan
 2021 04:15:48 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::c55b:77e5:fa05:3db0]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::c55b:77e5:fa05:3db0%6]) with mapi id 15.20.3784.019; Fri, 29 Jan 2021
 04:15:48 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [block:block-5.11 35/35] drivers/block/null_blk/zoned.c:86:
 undefined reference to `__udivdi3'
Thread-Topic: [block:block-5.11 35/35] drivers/block/null_blk/zoned.c:86:
 undefined reference to `__udivdi3'
Thread-Index: AQHW9fTP5pBg03TMw0aknvzJmE/CUw==
Date:   Fri, 29 Jan 2021 04:15:48 +0000
Message-ID: <CH2PR04MB6522B166877867367823ACFEE7B99@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <202101291240.6hHkZJGD-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:ac6f:3863:44b0:5059]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bed638d3-a8de-47e6-ad6b-08d8c40c8ebb
x-ms-traffictypediagnostic: CH2PR04MB6538:
x-microsoft-antispam-prvs: <CH2PR04MB6538ECD3725F7C7ABE97D9F0E7B99@CH2PR04MB6538.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:126;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uZnheHFmaQ+FCcIYP+e/WeB5Wf6OrF30rc/KYdj/VlxURE9Dmab1urjBQENl6RbeQJmne2dyH9ShxToota1wCGx1sXZJvjK9jwBg0PcyjEXG2px2huUk01pehKFf7hNiBPUsuqVPZLx3ALGwntydNCp9I9Of5+VZaHZA3eyfP14E6yp5/sQQAVJcqBmez4n818zUfsYrtO4PhiiulVk3x7YpPi0NUtD6m8buf6qd/Ig70TUiGtr5p8ATTVkZmBtHIjbI9NmXx6Ukdg2IVZpA/duo9QdF0NQtDjTmsqZ7ZOCw+O3v8+/DMwno+JQA0mUhPlAuL+fnJht/Lc2lRwGQJam6UDA+kXa+rfR2+BygyAppdUUtU3U9orb715SQxJbNWduPN2xs95UaIkJtudtk9dFz2We0nM5jHTXb6ITOEfM/5A2aXn4BI00rVyY7V/7EGBn3kZY0VRUQJ2NXZ5LnipYm+gEsh3gl1dKp+xv50lIt7JUWTJfazuhQFO931Na800Q4lrZSD22zEIqYNZOXzmaiv7SUZGJ55c1PyHxnug1xcBG4DNz0haHCK83S3bxs2PgJhOUmhBzeywE3hu7NRP5Tj0Wy3yFS6AdBaS8TPi4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(83380400001)(33656002)(76116006)(66446008)(86362001)(64756008)(66476007)(66556008)(66946007)(52536014)(7696005)(8936002)(9686003)(110136005)(55016002)(2906002)(6506007)(478600001)(71200400001)(5660300002)(966005)(8676002)(316002)(186003)(91956017)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tpaodTJCfFgzOkhIKT1P48Z3CKuZfP5GfWGoncivDpWFY9X9rQob18yHEisg?=
 =?us-ascii?Q?Wusfr6DcRZNBJLFbAh3+v+y+0l/4O/DyV5+ujBfexqSPB9VJODFOj2VGHuHb?=
 =?us-ascii?Q?W4G1hnq0Mn508uhlpmuT81M30gJ0blx7WBK2wFIv5gKe/b8mHFFaI7yMyRP6?=
 =?us-ascii?Q?AXyc630UEDHO15aGsmeoHq+YSdWOgU4KpRzZf1ycsFwZ1uluGW9gK+q7RGN1?=
 =?us-ascii?Q?RZDnmwA5LNzrMelVeJw75LsagkoEc4EHiJyU217tsKEmW28XEV/O6tPioA0c?=
 =?us-ascii?Q?GdHY4dVn5QCi0CILezC0xc1C6SvE8FC14hAv03nqfzi0yc/LKjzvFFhHFdQS?=
 =?us-ascii?Q?K0sIumUZNbVNDncLeUY3VZrjsjdR8M3c86RemCH7NGftWMfBnf1TbFGoElQN?=
 =?us-ascii?Q?BuxRSTtd18jZNVYUtAY4yRAlP2FdLz/eA9rWNUsMt9eJXJUCzTX7au5soTy+?=
 =?us-ascii?Q?Pie7HTbEwBMFplRB+azRn8YhMk4/rZagsxsG9XsZTkSUNkoXWJE4wr8RGEGu?=
 =?us-ascii?Q?R1CQlvKe2m74QNtmUnooUxag511HsS8Ddqiy0ESoxZB9g5Zd959SuETTLpkn?=
 =?us-ascii?Q?Ul2R3nwU0msxYXCYdCJ4FNXU+KEV6kDdZLfWEgc4BdlHr33PtK1WKDmPcHnw?=
 =?us-ascii?Q?jUFSlDNA/H2Qb+ykGZ1xVzokpJv2o9Jtt0CWBOoLqW2XyxiR+aYRAZ2DpnA1?=
 =?us-ascii?Q?GqBrbA+diATRjtVFb3P/4g7THjwSiQXcQjHV5QH311TCB8yup4KJEv1M4RBR?=
 =?us-ascii?Q?uKUmLJjRIERVJTuzn5YbhlMX+20VYc1/PniO5svt8rO5WS5yfHpIukdocaCZ?=
 =?us-ascii?Q?hhQijANWmUEeVgYAcH5Gtv4mZiwQdvWIIlOMzudLXafm9x+NRrijCuc/0jJZ?=
 =?us-ascii?Q?Le6nCB0cUbNjooynRI2IU60v6ZsWYTipc/nhYJgTTZXvmUtU2SA4W19U+/Vl?=
 =?us-ascii?Q?CuBekZp77YwP22dU7tbdsIbl9QdE/XMq6IchJxOB/ni1w4tLDGNNm+SyuJZ6?=
 =?us-ascii?Q?gW4FX77HA9bormcu4sAqAmQwADeMX8xuAh818IM7Bxk/l2RD0YXiUxGE4fwm?=
 =?us-ascii?Q?0mZUx0DwJ95gRLs5WW6Rd4lLn5ERXOlS5oSGVDEhT9YJBZk/XtLWY3TvGdiQ?=
 =?us-ascii?Q?6BVrMx/Lk01mf/tDfprUCc4rjUzL2gZhOg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed638d3-a8de-47e6-ad6b-08d8c40c8ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 04:15:48.5016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jr7gf0lRDGO87IklsMCqQJ8M+GdugX7elkjFZLo5Q1sPaDodWJ/mBFWRf4CcI3OT+In5L+ZwGdZNcnOQsVKAyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6538
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/29 13:11, kernel test robot wrote:=0A=
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block=
.git block-5.11=0A=
> head:   e1aa139c97ef1fa60cbdd2b6e1d40e4fe182068d=0A=
> commit: e1aa139c97ef1fa60cbdd2b6e1d40e4fe182068d [35/35] null_blk: cleanu=
p zoned mode initialization=0A=
> config: i386-randconfig-r004-20210128 (attached as .config)=0A=
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0=0A=
> reproduce (this is a W=3D1 build):=0A=
>         # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-blo=
ck.git/commit/?id=3De1aa139c97ef1fa60cbdd2b6e1d40e4fe182068d=0A=
>         git remote add block https://git.kernel.org/pub/scm/linux/kernel/=
git/axboe/linux-block.git=0A=
>         git fetch --no-tags block block-5.11=0A=
>         git checkout e1aa139c97ef1fa60cbdd2b6e1d40e4fe182068d=0A=
>         # save the attached .config to linux build tree=0A=
>         make W=3D1 ARCH=3Di386 =0A=
> =0A=
> If you fix the issue, kindly add following tag as appropriate=0A=
> Reported-by: kernel test robot <lkp@intel.com>=0A=
> =0A=
> All errors (new ones prefixed by >>):=0A=
> =0A=
>    ld: drivers/block/null_blk/zoned.o: in function `null_init_zoned_dev':=
=0A=
>>> drivers/block/null_blk/zoned.c:86: undefined reference to `__udivdi3'=
=0A=
=0A=
Jens,=0A=
=0A=
Arg. 64-bit div on 32-bit arch... Forgot about that one.=0A=
I can send a fixed v2 or an incremental fix patch. Which do you prefer ?=0A=
=0A=
> =0A=
> =0A=
> vim +86 drivers/block/null_blk/zoned.c=0A=
> =0A=
>     57	=0A=
>     58	int null_init_zoned_dev(struct nullb_device *dev, struct request_q=
ueue *q)=0A=
>     59	{=0A=
>     60		sector_t dev_capacity_sects, zone_capacity_sects;=0A=
>     61		struct nullb_zone *zone;=0A=
>     62		sector_t sector =3D 0;=0A=
>     63		unsigned int i;=0A=
>     64	=0A=
>     65		if (!is_power_of_2(dev->zone_size)) {=0A=
>     66			pr_err("zone_size must be power-of-two\n");=0A=
>     67			return -EINVAL;=0A=
>     68		}=0A=
>     69		if (dev->zone_size > dev->size) {=0A=
>     70			pr_err("Zone size larger than device capacity\n");=0A=
>     71			return -EINVAL;=0A=
>     72		}=0A=
>     73	=0A=
>     74		if (!dev->zone_capacity)=0A=
>     75			dev->zone_capacity =3D dev->zone_size;=0A=
>     76	=0A=
>     77		if (dev->zone_capacity > dev->zone_size) {=0A=
>     78			pr_err("null_blk: zone capacity (%lu MB) larger than zone size (=
%lu MB)\n",=0A=
>     79						dev->zone_capacity, dev->zone_size);=0A=
>     80			return -EINVAL;=0A=
>     81		}=0A=
>     82	=0A=
>     83		zone_capacity_sects =3D mb_to_sects(dev->zone_capacity);=0A=
>     84		dev_capacity_sects =3D mb_to_sects(dev->size);=0A=
>     85		dev->zone_size_sects =3D mb_to_sects(dev->zone_size);=0A=
>   > 86		dev->nr_zones =3D DIV_ROUND_UP(dev_capacity_sects, dev->zone_size=
_sects);=0A=
>     87	=0A=
>     88		dev->zones =3D kvmalloc_array(dev->nr_zones, sizeof(struct nullb_=
zone),=0A=
>     89					    GFP_KERNEL | __GFP_ZERO);=0A=
>     90		if (!dev->zones)=0A=
>     91			return -ENOMEM;=0A=
>     92	=0A=
>     93		spin_lock_init(&dev->zone_res_lock);=0A=
>     94	=0A=
>     95		if (dev->zone_nr_conv >=3D dev->nr_zones) {=0A=
>     96			dev->zone_nr_conv =3D dev->nr_zones - 1;=0A=
>     97			pr_info("changed the number of conventional zones to %u",=0A=
>     98				dev->zone_nr_conv);=0A=
>     99		}=0A=
>    100	=0A=
>    101		/* Max active zones has to be < nbr of seq zones in order to be e=
nforceable */=0A=
>    102		if (dev->zone_max_active >=3D dev->nr_zones - dev->zone_nr_conv) =
{=0A=
>    103			dev->zone_max_active =3D 0;=0A=
>    104			pr_info("zone_max_active limit disabled, limit >=3D zone count\n=
");=0A=
>    105		}=0A=
>    106	=0A=
>    107		/* Max open zones has to be <=3D max active zones */=0A=
>    108		if (dev->zone_max_active && dev->zone_max_open > dev->zone_max_ac=
tive) {=0A=
>    109			dev->zone_max_open =3D dev->zone_max_active;=0A=
>    110			pr_info("changed the maximum number of open zones to %u\n",=0A=
>    111				dev->nr_zones);=0A=
>    112		} else if (dev->zone_max_open >=3D dev->nr_zones - dev->zone_nr_c=
onv) {=0A=
>    113			dev->zone_max_open =3D 0;=0A=
>    114			pr_info("zone_max_open limit disabled, limit >=3D zone count\n")=
;=0A=
>    115		}=0A=
>    116		dev->need_zone_res_mgmt =3D dev->zone_max_active || dev->zone_max=
_open;=0A=
>    117		dev->imp_close_zone_no =3D dev->zone_nr_conv;=0A=
>    118	=0A=
>    119		for (i =3D 0; i <  dev->zone_nr_conv; i++) {=0A=
>    120			zone =3D &dev->zones[i];=0A=
>    121	=0A=
>    122			null_init_zone_lock(dev, zone);=0A=
>    123			zone->start =3D sector;=0A=
>    124			zone->len =3D dev->zone_size_sects;=0A=
>    125			zone->capacity =3D zone->len;=0A=
>    126			zone->wp =3D zone->start + zone->len;=0A=
>    127			zone->type =3D BLK_ZONE_TYPE_CONVENTIONAL;=0A=
>    128			zone->cond =3D BLK_ZONE_COND_NOT_WP;=0A=
>    129	=0A=
>    130			sector +=3D dev->zone_size_sects;=0A=
>    131		}=0A=
>    132	=0A=
>    133		for (i =3D dev->zone_nr_conv; i < dev->nr_zones; i++) {=0A=
>    134			zone =3D &dev->zones[i];=0A=
>    135	=0A=
>    136			null_init_zone_lock(dev, zone);=0A=
>    137			zone->start =3D zone->wp =3D sector;=0A=
>    138			if (zone->start + dev->zone_size_sects > dev_capacity_sects)=0A=
>    139				zone->len =3D dev_capacity_sects - zone->start;=0A=
>    140			else=0A=
>    141				zone->len =3D dev->zone_size_sects;=0A=
>    142			zone->capacity =3D=0A=
>    143				min_t(sector_t, zone->len, zone_capacity_sects);=0A=
>    144			zone->type =3D BLK_ZONE_TYPE_SEQWRITE_REQ;=0A=
>    145			zone->cond =3D BLK_ZONE_COND_EMPTY;=0A=
>    146	=0A=
>    147			sector +=3D dev->zone_size_sects;=0A=
>    148		}=0A=
>    149	=0A=
>    150		q->limits.zoned =3D BLK_ZONED_HM;=0A=
>    151		blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);=0A=
>    152		blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE)=
;=0A=
>    153	=0A=
>    154		return 0;=0A=
>    155	}=0A=
>    156	=0A=
> =0A=
> ---=0A=
> 0-DAY CI Kernel Test Service, Intel Corporation=0A=
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
