Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BB4C43334
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 08:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiGOIX2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 04:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGOIX1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 04:23:27 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF007FE58;
        Fri, 15 Jul 2022 01:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657873406; x=1689409406;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=cuBrppXwY+La4Tvam6IWEeu14l3LqtmTXPtZQrR0aQw=;
  b=ZPzQYhCHx1hf1iYuS6TOxy6TTvwWEljzxMDLTPeu1uCrICOeyDxUgxJQ
   tO1xiBb8PJqNumn2wSx9hOnEGs52vrzRE8uvHpDhS98pH6hHj8PdP32RR
   hfhLxN79cEN2UPdH0h1OkQPYm2R2uBu6cMJLIBgSb4BICUj48f7uXS1zp
   I52wyWya/NOkOg0zcLIK3yoB+LUP/1R4rv6ow4ilJZewo04wvUL4RwVDP
   hfpa19T5rLzoXeDkR1evORCMjfNS40Q3BC/Tq5ggZ9xCh5EoEfS+rCnQ0
   jmJGj0drNp+n+setXinnnvXOwNyKIQyDxYslOVUlKALmxbXIabT7YCe+P
   w==;
X-IronPort-AV: E=Sophos;i="5.92,273,1650902400"; 
   d="scan'208";a="210777217"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2022 16:23:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDl7QDYMk+FeCFVps9E7U1uqgA69gHNr//zsq59L+f4N215hu17xqMAly9XgxmlhnFJ7LZq2K72hmEFKmkOIVep8Gufs1g5beJHPqy3AFgTgKiN1B0sdZJqBBorNf2MIKpxXHP/JhFB8Vv9CyLMBexdfIrCKA6XXXtIkl+vHAUJqyTxv3hNvGZwt3dh52WHSntWg9E4eKEzi1PMX1S5nUuV44dnerZJwUpimEB/BCxoH4QzJih8J2sa2iCz6KsxMd51QjNuiLD6y1NWFbdR9Nlv//5iR9dcOILNorOA6dS72I2UTFQA3bvZjyqPKtNAi8/S9VtAUrknsczV2prfafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpxQFQiK9AeFjsKPuvoXaSkYPwZuCaZhP5BZyYtycE8=;
 b=XIDvtAX/B6lgkAgbFakjh1zqe34wVb0UOFgqaQ1HBhg1wxaSnajhkZYMj2Ynegy25qj0lGEZpvVFOqrFkzSzu26H5q/lZDijn7K66kGMkyH36uYLF7VtnqzPDdj1T2aj0bOK2A+7ZaFpA1fSsFSOzwerNpb8bhW+JkminWtsOI78GGJ8Nsz6wmCwJBBcNQIMOHasME2v7s3ICOA/8oA5Ryu/I+xK8h8T1N55acJhEWCYfIjrRUyNLTEyfousTYt/OKsEn9d8ic0KIJh32Jt2HIz6apFw/LwtHUkl6V6PLtchJHZj5jpKKn33Cj9udc5K6MoY59jOQznnS//diWAWdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpxQFQiK9AeFjsKPuvoXaSkYPwZuCaZhP5BZyYtycE8=;
 b=vFsL4BqgsyXBKB8vt1QZ/uWXRVQWjk91/s6P7orQ2o94mUhXUKI5NKnw6cv12yQWZdqO39uM0cEQU3MdOzr0tyJl46jta2JbMfPCZeGiX+bA7qP8LffX8GlKb3GwNG6RwdSunOiIo8T/4rjnP4Glp62hNGB+fdHjDBZVJ/rJeBM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5321.namprd04.prod.outlook.com (2603:10b6:5:109::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Fri, 15 Jul
 2022 08:23:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 08:23:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@fb.com>
CC:     Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH 2/2] null_blk: fix ida error handling in null_add_dev()
Thread-Topic: [PATCH 2/2] null_blk: fix ida error handling in null_add_dev()
Thread-Index: AQHYmCKqzXZnfhatbUOogwJhhC22zw==
Date:   Fri, 15 Jul 2022 08:23:24 +0000
Message-ID: <PH0PR04MB7416C95D473D2F35A8A1F5709B8B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <YtEhXsr6vJeoiYhd@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18416580-6380-4541-ffc2-08da663b493e
x-ms-traffictypediagnostic: DM6PR04MB5321:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zg65AdAdg8McvMKOnOGltunGqElgTlOOUCf5DsRaP5wQ/wU5DKQJ1k6cL+Loiv/QaG5nHJrW6qABT76UPT3qukBXZuusBQWldt6nhkWUlM2qNxiSM/7mSC8xaAWnbJF17HA02AsZVRdUQ+vKrAWpvk9DdClxkqbxuGe+Y7gczhazS9VdeCsefU8QkVXFGRbn5+hmPC1kcaIm9JNGj6B5/sLeeWKjsJYUze6p8afStwcY0YS62KdBAdDyGHRr7CYEYfzvNIb2t6GzoL8z2S/ZtfDRM5N/skB9AxQe4pLarD8SrlVLQIWoNJFleK2hoKZ2i+c6jAtGlgNOx9qo0b/MY6Mm+8kmab7Y63jR4dRKrnLddBQ7WcceGT+LtmK/I0Z92SlMbSAWleic9VXvVBkhU08Z/0OLjgdFTPu5hDdwWFQhHtNx71ntV9DqPs4jX5+CvlWtaFV+XbywsRGs1zgKn0umlAHgQw07tbzEhFfTKQHgYOeHYc+aLMGqRdwH1ovoMcSmTAMWn9w9YVH2SiRChJbKsIEaCxKvGKjfU97UZ6pAJuHs2yerWMWPnRg4pY8EC1vkP3aWfR+KpkrIKNxlPMbyoszjti6uKcjriUOM01EyBkJuQVXVKt08+T+cLM1zkpwg106GXRm/xli4RK2PnTHd4HWk+9DYxEDqQYXCM+3b3VnaT2FROCEsmOVIrOAmS5DLh4txGy8MOZqrLGsb1Jynh7PrweBpr0OryaZ/yadVanln+/LaEnK6MtoVzKwJLWaFozt1c8JnPPI0o5fsro9TOkMWsRY13Y6SgB75eipWTxeZK6Cg6MTbbE22kjgt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(54906003)(52536014)(8936002)(66556008)(71200400001)(55016003)(7696005)(82960400001)(33656002)(66946007)(38100700002)(478600001)(186003)(66476007)(38070700005)(4744005)(4326008)(76116006)(26005)(66446008)(86362001)(122000001)(83380400001)(53546011)(6506007)(8676002)(91956017)(110136005)(2906002)(41300700001)(316002)(64756008)(5660300002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r7ilHG/RSlVlDM8+olFN/wEbHBQZ7c8VwVKXZd2td6czIKOBILHa4uAR9F1/?=
 =?us-ascii?Q?omipZA7Gm8RUMb4wvDMN6sbqQC9Dgb6YGOx1SVikKCPYVb+/KD2rHSBnSWC3?=
 =?us-ascii?Q?N3xRjV/0zgw7jKX5NyWne/YFqQgZy6HAtkeuB2IteFHkLRyau6XOCMxQAyxi?=
 =?us-ascii?Q?b+W5geSgTFuidZf5LrxvC6dtalQ+9FN+FWgPxAu6OnZHTLiodbYdEMwlt1z/?=
 =?us-ascii?Q?DN2livlQDLgzRnYOOjjCPBh0PkVAavrPVE8ul21w37oqFbhoIDxzy4ExYsVL?=
 =?us-ascii?Q?D54FmHAqr03RMunCFHB0jbFjmFvL4qkAGkDF3AxJDiWVBN/1/l1WpDGA3jyG?=
 =?us-ascii?Q?PeJH9qH8NoEIydwrB3ok++tsrlubw17qWuDK1m7G/0RkLEvdkOITGlBGPFoY?=
 =?us-ascii?Q?2NGlyx5yXyzHN1Z7ApDdF2Ug8aQSm/6RGqokkINoVbbEfs5ozB1cExVurQls?=
 =?us-ascii?Q?m0A7/ITDm5qZwILPUWYOmQ0pCLRtWyIS1z/7dZ50HUe2nwth1lQUF5uTQ4MR?=
 =?us-ascii?Q?4wlG9vqmcuBqV1ThPlSOxs3UasW2dERsRCIH+mu2mfLYZQn6yjhGryKd7RTH?=
 =?us-ascii?Q?TF9ybZA0LTiurwdkVdgHyER5AY4I6A1i3ZOiY4EG/b7Pr9eBsjLzyBGLQdCH?=
 =?us-ascii?Q?trZbbo0JbEipZV2OrsDL1gCYY/ZOwJU4qEgU3twkm7aFDthjf71SnjywedlC?=
 =?us-ascii?Q?EPrrw7MLzx/ZWbTCLRg9PsgFiS8cGhRm/aal1j9sSIeto+ZHA0V/2gCdALNe?=
 =?us-ascii?Q?1A4faagBuoGMiYvY3QLqBnOY2bTyBXeMVA8OlO0xbRW9YiollrSvB1uAzVXp?=
 =?us-ascii?Q?SwF/+039oMql9eInqFwoZuXHSNLThq9jE6IbNBNrwPKNG446BsL2+2hNW23s?=
 =?us-ascii?Q?Sk3YwA9097k2rhu5nTS+tqm8wPBhaqL9JDcUmJuQGzd6jC68cSDwZ/QtZcEe?=
 =?us-ascii?Q?RA11ZrwgWOfQgkf+wSzyvBr2O0nWvTZIfazZ2qwyx0vH7ApiRonoTy0GE3lH?=
 =?us-ascii?Q?nZ5LuU98xOXzn07UmHvU7bFk3Gun7TEqjA5wujif174wyZAcjqPELyjQn9aF?=
 =?us-ascii?Q?2fuBb/3vMb7fO7IAoBQYPEai+eOUjO5wxgQJ8Q3RjhEX8GlZ6FMZO0GMTZcN?=
 =?us-ascii?Q?OkSrB0r1p3yS15/B7zdpa6BNzns3VKpYSWEByE2WRvvy/ARfcDQoqOHd6d3K?=
 =?us-ascii?Q?4lTXRTAkMWpH5yTbx4dnryEBcNT7tCJDyzSwo8KcR9Vqo+Uysn3lqjVt+gxi?=
 =?us-ascii?Q?EHFE0phdha7OTIqOIT0iVlqmG4slg6HLTPuXhIR8miZj/lC0PNm8pprvD4g4?=
 =?us-ascii?Q?ITQW2cjxWYKk1QS2NiDO+4yBGYEU8qSsph8OJXaufbebXBkiXE3Mk9iTVvpS?=
 =?us-ascii?Q?bbxMBZ6P3AGj2SgrvyGT6fXifKuyv8uoZLpn7P7xtB+Gn4nIoEJ2ox0r3Woi?=
 =?us-ascii?Q?yKJKfmfO9V/6w06HKFxw67aujFoB6uGAuP0WkqglZSFud+bhH3L5V2sFMigK?=
 =?us-ascii?Q?NV10oR+KY9fa9CDhDoEItKyp9GVqQRq0P6QWtxzaKGjMMw7Abih6TBb5Wy+c?=
 =?us-ascii?Q?iQg1IVng/wxgP0TspGQJGqE7qSfCf6S8DsJoNN0oLIQnxORNufNxLVvaHPIg?=
 =?us-ascii?Q?sYScxXlyJAZqo5ezSi4BGNs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18416580-6380-4541-ffc2-08da663b493e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 08:23:24.3690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c7O9zJ6LxvXPsFqZmA2ta6FV+v7fToq5aRnE0nEsv80wEUqxV7QfJbQzd2Zkpoio5ygaNCptJ5f5kD0qAKkJtXrpIjDoXDb6OF0WOMMJ7+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5321
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 15.07.22 10:12, Dan Carpenter wrote:=0A=
> -	nullb->index =3D ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);=0A=
> -	dev->index =3D nullb->index;=0A=
> +	rv =3D ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);=0A=
> +	if (rv < 0) {=0A=
> +		mutex_unlock(&lock);=0A=
> +		goto out_cleanup_zone;=0A=
> +	}=0A=
> +	nullb->index =3D rv;=0A=
> +	dev->index =3D rv;=0A=
=0A=
Isn't ida_simple_get() deprecated? And actually the 'max' argument is 0 her=
e,=0A=
so ida_alloc_range() tries to allocate a number between 0 and 0?=0A=
