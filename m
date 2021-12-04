Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7AEC433EF
	for <linux-block@archiver.kernel.org>; Sat,  4 Dec 2021 01:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383984AbhLDBhu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 20:37:50 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:37065 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237601AbhLDBhu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 20:37:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638581665; x=1670117665;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=odcyRRKSa3pZ2XY+o6QRSax37Nz0Ec4Md6r2XTitAhg=;
  b=OV8lv2aDiJBhys3d0QSON9NVUwfKMIQFQRC4PEjZEm/o2ODLtskLikCd
   07Z8Rca6azQ4xSCm8rYKBjqioe3XesU8SsvBBBUO+9k4uY5CnFHfE+Xsf
   xjDt2ZnewiovuJ80PxCv459sIPsTEbUHDHZSZesHVAythQUNB6c7L2xs2
   uz0fIcDDXhgpEJmqyahWWYtEHFf15WxLUEYdAG2tUsBwl2vDbwSZc3cWf
   CnXIb4Jc/NXGKEScEaq56q/bOvN5NnufKKvZxqd2shdenMzU5Cm6oMMCL
   VypT02y3ido5d3o4jvg94BkN6xbENzWJdnHdx9Ib41VdCUNfnENkqvKwa
   w==;
X-IronPort-AV: E=Sophos;i="5.87,286,1631548800"; 
   d="scan'208";a="299272419"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2021 09:34:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzERp7eFu3arpkot9mK1sHmvcSrE9Sj3eLKgPWvpDiLWQq7MdQnxbe7CIoaSxeQoNU/er2moWl8zguh1WP3G6rI0lh2yPqTqbqWZwjRkGtLchGdwbDc16b4K7EN1+3hvg861Q8DHhxxoZEKYiNEtFJIsxC3LGoOiv7ulfkRoq59HIb+cHIxDyO14RsjM/8PfKqFDe6zwRJVwxRvlGBTU9raacHCgxHwgcZs+i9gLVG3GxFiFw1i6HCvQxjlUdM/E6dk/lDJZd7r/eMVIrXgk6d+XXp1JWAdq7uVbzPB6g5XPLwYhMKUpj+qX/yHDZk7LinU8rG0V10GyKYKvf3Vj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTwRkLScQec3DZHMma8C/nXSlajEPvEe8gGYgBgy8/Q=;
 b=Hnq1W/xyqamLoS9ekwQ5L6QYoNMPvbBXzpWsnz1F7N9wbBeqWhP+2siL1E6KXpqBv1bzL/+01D9c115Kke9czSt1Ft3M/g4PsnS1nSXgECQ5E1T0t4rwjOBM0X7irpTHd5LNuT1903IGow/oB7FX+Sa4B3WXJ+DXvGES5yW9N7sbuFENJ01hwooE6os2bAlT/3u76VPDt3JPMGwuzleGfWeeDpnHsnKdqkKVsZcIv+DaNrjh70sncu/Pykj3gzSCbEMOWml1ywwIAKfREbhnTp8mKcG9uYLfwQGLGg/WTa33ak6QRF8TOtO7SpdTRqImE5ID1VG1dqdMwCXPMPEm9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTwRkLScQec3DZHMma8C/nXSlajEPvEe8gGYgBgy8/Q=;
 b=ZbjN71BECjAajkJ4MZ0AyTjKBYR89qN5DJb29dcWeYTFtcntUuTgoOuo7sRGdzLrOCBG/J2WT2pItE58CCkX86wfQH6096OcoovYArIfQPfhB5/zVtCRAHBTdd81KzVPEo+hPUooR2zfi2yf8GgQD+hgrJjfiKPNxFL+JtpUrOA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB8184.namprd04.prod.outlook.com (2603:10b6:8::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Sat, 4 Dec 2021 01:34:16 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::28ae:301e:551e:a62e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::28ae:301e:551e:a62e%5]) with mapi id 15.20.4734.028; Sat, 4 Dec 2021
 01:34:16 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: allow zero poll queues
Thread-Topic: [PATCH] null_blk: allow zero poll queues
Thread-Index: AQHX5+8R3HrF+EUnsUq/7/xCqs+zYqwgiaKAgAAjEQCAAOGGgA==
Date:   Sat, 4 Dec 2021 01:34:16 +0000
Message-ID: <20211204013415.kofojnrzjwt6bseu@shindev>
References: <20211203023935.3424042-1-ming.lei@redhat.com>
 <20211203100133.gdut65jrb6z6eodr@shindev> <YaoIaAMSut0UGhy1@T590>
In-Reply-To: <YaoIaAMSut0UGhy1@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a310f3ea-e070-49e9-ece6-08d9b6c62f90
x-ms-traffictypediagnostic: DM8PR04MB8184:
x-microsoft-antispam-prvs: <DM8PR04MB818472836906CC4388FA0767ED6B9@DM8PR04MB8184.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PWHzHThRB3PF93dRHjw+iFYrtjQl+2pmqLGJ4pSUCWS9+JE8D2HaMk/xGn35oNT8bRM2ZvZpa3C8evpI0KjIAEmLSNUeBvzTUB3KMhiMwMcSIa/bf68Q8kaRHjhCfneXOVve1foV+dYrM9oGgJTAWm/2ukPZIXkj40BPwkbJrMHmc+Gtb2os3G9rRMvj0NkByNOQmymZn7ngSCWFlbp1rnoAroRSeyZ7wXMRDlOBHEWtt0f6n5BnoRTDEd6kd82p/aD1Pwe1HccBB/b0Ci3cLaJSkIiD6OY6hFU035hb4Z1guZgku5Q/E24SC6sPVp9c450TuKQgYBTDH5B/HzvZGG4iR8/RsDNgy95Ag3UKjqXCYmCD4yyM238Rid2VdOIjeJNK1Le9Gn9DEjPqtdY9qJDGgOWfln1UFxN5p2C7vNVU8FJSXyz6zxpOJRKNM6TANP6mm46B7AWCfbIxkn4clPOc+u7uox0Wddrxpol1f22D4YUnrN/cHjC9vrZ/ZpfSOCIYCfc4TYX9P+ZUXan3qNJV4nRnlak3KzsVeL3TFl2VE/Zu/fWRnnV/iSEcqcEXxCoSTYnr6IY5lYFw9Nugc3Zhn+h7hkJIotQGwHbxI39gjmRliPYzkzj0wIOxFv1U4hp7KON1bVwdmVaD9pucUqY4rNhzjYPR+RWvRXIQNZNIb6YxBrq0RLczbJB/k45wVnWA65m9oEHDd8kh2S6uSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(8676002)(86362001)(54906003)(8936002)(82960400001)(71200400001)(66476007)(38100700002)(5660300002)(2906002)(6506007)(44832011)(64756008)(33716001)(4326008)(6916009)(508600001)(316002)(76116006)(91956017)(83380400001)(38070700005)(6512007)(66946007)(9686003)(186003)(26005)(66446008)(66556008)(122000001)(6486002)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aTCrIr/1a4yaw5FlbZwdoABzFoY79Xz1zOAkZI9R82AsaXOcKUMDpcAX+GJb?=
 =?us-ascii?Q?LokAfPNYDHvcldgBbwFSjDLwfv6GMAkzDt259Tq40PfIBaRcwx5VJGTYXAQt?=
 =?us-ascii?Q?BmmTQifWwa2B7ox5+U67vOPwtmKx5JUr9T7xeoi1vcv7FcsIItIgYQHrSTAA?=
 =?us-ascii?Q?b7fv7NhE0DYSl5Cn1jjDB5tWtaTqTQFEVxISdFkLLTIBtzljfFs+lTK+hD/+?=
 =?us-ascii?Q?VeTiFAYx4FtIyv77yMbR5/YDNvq2E4DHiZH4LHlkLoj2/gtWNi1SYD9lj74X?=
 =?us-ascii?Q?nYhTIzFM6C40Igm6tkmB8a2ts8Dkg6xi8KbP+Het7jzy9sU7KXNXgfGL7Z9s?=
 =?us-ascii?Q?TAh0D7YkPiLU/8UfeSVxVNMLC0C8I6vpJ3SYNKzCZpZTpvCNPT1STO4jPxX1?=
 =?us-ascii?Q?qzA2saiDZchcxGGU/PJn8rmNzdDl6HvFp8iDQvlxqmwY7TKNiEE0u1wknPs6?=
 =?us-ascii?Q?KRxyrRsd9dYOVLU9+OAC/gWIeLzJjjyOC348E9U78rzNv9fW9O9ll7ZFIY8S?=
 =?us-ascii?Q?8tybhgxhq1Micmsl+w4k6DzDLUR+9uefdAueVULbU2yRmuP1NXAooQUOvViK?=
 =?us-ascii?Q?cL1Rju60WTA6+WWDy285jlPE7A0PhaYVJCnqr09JSR6H+ZzGEtOTvYYVccE8?=
 =?us-ascii?Q?awf5DDj6jh0AFusRL5vsWqLIi91208Xn/rl4FLmEmfgaTb84ngW+0E18C1ai?=
 =?us-ascii?Q?E/FAHmipxA3yTIj7F7Lo+bnbpHmJUBWxEQLVIPco+222NWjNtYR1QNSsdb5l?=
 =?us-ascii?Q?2kWjrLe471WxJBV+rKFwjll0BPn5AkA957mz67viSuhbTBMnH7eAgGvqo64E?=
 =?us-ascii?Q?3hVXXd5VvkvhH8pDPfdqOgDmkcSO1gvtTUfqdtgRsQQZPyjIJMvdIDkL+1bR?=
 =?us-ascii?Q?mFmExGKyjQIaGYmlSwPiU4xNu9K/Qti7VJjEJjCGUar9HwAgZ0AzrwVIW+Pn?=
 =?us-ascii?Q?0xfJOVX5EECYc8D/DOkj+3HjzJaM8rbSLfr8fscJ5V9pzhdwueSRk0nzIWtg?=
 =?us-ascii?Q?A/eHbPWqxUqCwrKdM9G/qf0zcwTev6zM2YKKOzEkiGzBOtr5E3uEcA0IlXqB?=
 =?us-ascii?Q?rcknVMorn19aRawD/C6chbZPa1caksrsS835PDBE20jow6a6jyxHadGuL+c8?=
 =?us-ascii?Q?ON2YgCr8q0gqRC6i9Q3YrCNFQu7reu1h7RLEJJOvpp08qSKh8pjJyKygViZZ?=
 =?us-ascii?Q?QNCUDm0fc8gevESzmHkPbcyVzCq1UM0x1Yp67DF+hBzujJgUBF/RPgJFPBzn?=
 =?us-ascii?Q?n02Qg9qXc9z2oFvUwQnTpZrmEpICvfjzMvs+WV5xy0BmbOtbbniIbondWGo5?=
 =?us-ascii?Q?88L52yp4NAv2hsHYPuqJcXCK8ErR6D/6W4+sj6kl/FSDY7Mu7BF8UMCrm8ns?=
 =?us-ascii?Q?Bs1aT1IIm4MqmQnF6ow+ovDniQ9dzJGJasIBtmR1nSbjqi2mKR9ZOQFWVFT6?=
 =?us-ascii?Q?iv0Xx1FVLjq/Iy7IWNP6xqpiSbk4ct9119uB75TmcAafoFLKxOABiFaCapR7?=
 =?us-ascii?Q?Cj5SmFGaV291HVJWng5X0xBzuMnOfskyXxNUUfqRg8acnGAegeLCWVBLiRDG?=
 =?us-ascii?Q?IXtdkItIrYHqxWNX3yi73ABkM8N+bvJUzHUpXpi96etCnUdVpzzizMM1q2q1?=
 =?us-ascii?Q?c0NuP/eTNanEdOAehrzL54pQoQC6J1buOnhBarFYXtM6wlQ0q2zvbT7qMZQl?=
 =?us-ascii?Q?xtmSawnB4yPdoCKhP7jgKn2uwWk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9651221030AF0C4F86F0E7A5E2B89FD8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a310f3ea-e070-49e9-ece6-08d9b6c62f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2021 01:34:16.6098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X9TcjkwBenrTWXYWYtP6uCAO8gCyQ89RjLDnZycmYUuFVMvxVhq0bGh+FCOLJH6Az6Izah9gJc/Jkz/KEq6nPJ5J3CF9KGy7oYmgb5L7+NY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8184
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Dec 03, 2021 / 20:07, Ming Lei wrote:
> Hi Shinichiro,
>=20
> On Fri, Dec 03, 2021 at 10:01:33AM +0000, Shinichiro Kawasaki wrote:
> > On Dec 03, 2021 / 10:39, Ming Lei wrote:
> > > There isn't any reason to not allow zero poll queues from user
> > > viewpoint.
> > >=20
> > > Also sometimes we need to compare io poll between poll mode and irq
> > > mode, so not allowing poll queues is bad.
> > >=20
> > > Fixes: 15dfc662ef31 ("null_blk: Fix handling of submit_queues and pol=
l_queues attributes")
> > > Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >=20
> > Hi Ming,
> >=20
> > It is good to know that the zero poll queues is useful. Having said tha=
t, I
> > observe zero division error [1] with your patch and the commands below.=
 Don' we
> > need some more code changes to avoid the error?
> >=20
> > # modprobe null_blk
> > # cd /sys/kernel/config/nullb
> > # mkdir test
> > # echo 0 > test/poll_queues
> > # echo 1 > test/power
> > Segmentation fault
>=20
> I guess the following change may fix the error:
>=20
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
> index 20534a2daf17..96c55d06401d 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1892,7 +1892,7 @@ static int null_init_tag_set(struct nullb *nullb, s=
truct blk_mq_tag_set *set)
>  	if (g_shared_tag_bitmap)
>  		set->flags |=3D BLK_MQ_F_TAG_HCTX_SHARED;
>  	set->driver_data =3D nullb;
> -	if (g_poll_queues)
> +	if (poll_queues)
>  		set->nr_maps =3D 3;
>  	else
>  		set->nr_maps =3D 1;
>=20

Yes, I confirmed that this change avoids the error. Thank you!

--=20
Best Regards,
Shin'ichiro Kawasaki=
