Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9176C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 07:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE11619F5
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 07:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbhCXHNM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 03:13:12 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:5636 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhCXHMj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 03:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616569959; x=1648105959;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=szgudqrgLKQmbQtctyFJ+njM0MguinoCEe5q4NfRfo0=;
  b=nHoLdRbsiUDwowR0o/2Pmv+uAAFKJD+VywC4r2+dYlWVxrmdiWghjw1h
   Up/pCpZF5E2j0EJnWkFUqhyaMbpJvJy1Ne0fCGNDzHPzxKeK8ySkqjSu7
   KgSyGOTgXDlk5c9JhGuUBagzAPglXUSDGGI7KpNoLMAfHI6YhFWgen22U
   v4owjZLCw+cf712c90YSgY5AF3xFTG04EokyjHJmzdc0Nsjy2wYRKdPV/
   XZRb7JwIWlzVxvxtCJJy+5rgC5KDw90dVJ7Oyxk0GYs2PmZLOtZVBN7TT
   II+XCxKlXNxR+P/tmtmCKSwGsoekDtFjc8H+aLBU8jF5dipAdE73/RoAP
   w==;
IronPort-SDR: ndTIou3SQaI81zmF9JOP0FqoR/3zU6WOR6vWg7NygWc3RhbWvwdDKrtur0bZ+mvGGcgSd1I2u/
 Yk7kmaEh6RGRdwNQXPozw7EfY25ikrpfRK0dTpFrwaPT27vj/BgQrEVOQCgX8gFvCnFzf9v+ZS
 MtOm4E4wjzhjiHuOEpa32j4VkUMzIH4jwlgEY5QDuQC5mydYmP18sozXO9eS0mYTUSJklraCdU
 JqBpkPckUJPGtSjBXw1KH/wyjmQX4IbXVJ3ECwkgPZ9F70Xf4frhHKFvd2QdxaTKNt+QAoDnTa
 VRE=
X-IronPort-AV: E=Sophos;i="5.81,274,1610380800"; 
   d="scan'208";a="163988959"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2021 15:12:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOVjbT9U1ZO1IUdwuLR7RraxCwmm0awD+WNESMeEAFDtglZ3+QiblhUPzCkRMcsWSe+LB0rIkRaKL5761S0Aspqqk7Wkc4+L3sCAP78i7fyDUZADItZHicBwOkSyX91XPK3hxElfTO8o0vYDuVSWzF24lUQF1xEVYryWfsfT6HZJVyuFsSL3C9TyOUCjquQ8+Xs5Szb3Mq7Udq5jiRV9iLoAgr++zgPM60W9QGhmwRSQOUBtFwlFyA5NeGW+FpEJW4TMYWTZgfqFNiJmOllhrhCMGN01BK4jDGkILxLqnWO/k1DePTW7M19Scw52rExTKvxHfgGilyi7ZmnHfskk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYq5m/pyuxCkfI287r/EZgT2Lmg07WWhzSSFcxw5xow=;
 b=OD8BYPuY1waLO9UwcR2dttKfxXgHe8ISriVh2gphFuFe5ZxmuyRO5Dt7DxVYxn3pZz2EHPNOu1b3IqlGeWLtoHAkXDnWEVmlFTExdNxd9PBO95yTqFcbzZtAgVE7EMQK/+9vXVCpVnOpsrZU1AIob5eYlrU6rmdFatzZ8dLKRoZ8yRkZ7FpMeK8Lu7rfaHrMby6XdWgP77COCIVWuCr0u4CX9cqM431BCkWAiM+pFjXmrKsMIojyxcSBk2IvEe9agAcFFhXOLsf2piq+LP400L4tbH7cx4OoQfmd1R7mJpg/Ut1XeN0Z4FQjjvL6wOmT13LSyOAuvEqepl9btrfY0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYq5m/pyuxCkfI287r/EZgT2Lmg07WWhzSSFcxw5xow=;
 b=XC2UsjWWcf3JZ0vH9uS97JY7mx24k4OSQ4kvidtQ1V41qT8mPbezmaNmSq1HyLgo3Mb5n7dKJfvN8JfD39NmyBWZhPk71AmjmELN7rJKD49vwcCttGGiBkuHM59/6SmPLeg8/xzD32FyjmYlY7qw4VGu1KjjIZq971SdCXwwe6M=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7223.namprd04.prod.outlook.com (2603:10b6:510:1f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 07:12:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 07:12:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] block: support zone append bvecs
Thread-Topic: [PATCH] block: support zone append bvecs
Thread-Index: AQHXH9Svt3fpY4sr0kWipTtEnnUH/A==
Date:   Wed, 24 Mar 2021 07:12:35 +0000
Message-ID: <PH0PR04MB7416B0F00700A4C9D951AD5C9B639@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <739a96e185f008c238fcf06cb22068016149ad4a.1616497531.git.johannes.thumshirn@wdc.com>
 <20210323123002.GA30758@lst.de>
 <PH0PR04MB7416CEB0FE5E8E56370A0A1D9B639@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210324071119.GA647@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:49ae:1f03:f20b:3ca]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a46813ec-e8ea-4994-fdde-08d8ee943351
x-ms-traffictypediagnostic: PH0PR04MB7223:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7223434D17C86115D7D16D9D9B639@PH0PR04MB7223.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PQQ4/u5eoimPUh7I2do6JohYgIIfa3UVYRViDyIdHxr5NFAEE9mzMfoEsjObTbhtyHlbkjYYqHvARLyYpxEdAo1Lqefta1XFiOyojcXV4iRhX48GzziUeloxZbxvgwNwMmW6YmNBA5HJ69rrIQyUBJdxwQYzYMD48K6jfBwjVI/Wsz7dNqnCyfqTU6HSbHnrqwSBk6iWagfqfyBaV+avpDK1m9XzdtXOo7vHUFfRzqkMp1qljohwUmRpJWns8fmEXKfg+TFJjbhPfBRS6un/BUIpxhHLIg06kWvrMWEHyHU0ZNUfFy53YL3JDxAQUTeeRI8FbQDG93N9MasFyKps/R7hJAGFOxddhUPO8aytUCN7hYCDzsQk6voFDUKVsMyaJ1xScGL1Kdc8lmfBZMfeoMl1bxxb8HxaGW3R/ZiQCPxiOKYC2wGGZRC0ci4sIPfCKuITWKan97SAuV8jk1edpFGTWPCAkBFRNORnZRZwmAw26vJIhvLl2V1xPc2QO60nw+CygR2DJwkfEpjIOkirxn4OizHmKsPcgxTBOodr9mNyeux6Mc+wZcLpIL4vel1pSbFJRIb0n8UXurHm6o1MO4JQ01xQpxB7rHnM9P0ynIA2Said4Q0nXWFxFEnFn+bc87cK/bBAdHyc2xBNGceT6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(53546011)(6506007)(6916009)(7696005)(86362001)(66946007)(52536014)(91956017)(64756008)(76116006)(71200400001)(9686003)(2906002)(66446008)(38100700001)(66476007)(54906003)(66556008)(5660300002)(8676002)(8936002)(83380400001)(33656002)(186003)(316002)(55016002)(478600001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?p0OHkaMFMcgjQ4wSS3/b3WKYHg/aNDiJvQiaErvezKqWYJn0SLLdKG+EaKu5?=
 =?us-ascii?Q?XheH9Uob6ozxophigSbgZGgZLMbo+f1vWQ7PZ+96OWjox38vQjBCPD6eDf0u?=
 =?us-ascii?Q?xZn0IQHdTlY8b1mrlPgOAppabrSAj5BkJ46Ib8wBiz7oyg1kBaSbmk4w/7xZ?=
 =?us-ascii?Q?M6bxg0Ei2jBaUSBeclyaB2rkTUXPnMeJwtrL1G8jKjq3XWrNyVFIQNsrIy5Q?=
 =?us-ascii?Q?nWVOk8befaT7Ix456ujxLsfpR0Mrs09x3WB86wtNHznFGSZmZUns3O6DTrfR?=
 =?us-ascii?Q?bPqdkShm2TUYdRCB5vdWxF4FCs9mHuUPDOZkmUmWhTN++ZqwFyoLX5f9W1Al?=
 =?us-ascii?Q?tzDre3A/T8/aD/BKk9LlxjHV5G2om1Bw0VPf+dC8p/sbUs/gfWz7iwBYxOnD?=
 =?us-ascii?Q?Tnrc9l4/bIGzPVk9dirgds9f4giunRabEf+WKapFbq510qoV7GIgBPynuZTC?=
 =?us-ascii?Q?oM5cQkh98Knx519Jm8nzCnGDD/9nrGpzKMiDkBNCJ+mRZM/3TSTPOaypvSBZ?=
 =?us-ascii?Q?o6TMlTXUA8HfSO2HyFY2v3DEykH7sW9vep34Qp8i/wyGDKiwtLlAD7cofUv5?=
 =?us-ascii?Q?QZz8yeEC9sXzd3lECTFlbS/vCYwP4O12KLzri3nBsk1BG8zHDydlBAU8Up/x?=
 =?us-ascii?Q?nw6esnX6eA/YpAiQZTPhPxLlMOvHbprtSJAMwlJyULci3eKPfymlqUdIAbqi?=
 =?us-ascii?Q?cU8s9YZhiQ2HhxpwwHqSi00wUKYmvtr/KQmIrF2etfwfo63X30jJoqTVTFLO?=
 =?us-ascii?Q?MnjS7Pj15ipsQkIR4GPZhYDa4/j57WhWaNVtexZ91sLykAcBN/yjpIUpaw4d?=
 =?us-ascii?Q?sLARoDfUeecL+ZLTc1p3LBvgarhmb6kXjhGKVUBvI2HKq4HVZpEz1a16EudU?=
 =?us-ascii?Q?qst7aum8aZgR9galEujQWq2Vt7yZ83IhszP8mwWszjiZM/QCcYQYj6ep+7Ls?=
 =?us-ascii?Q?TF9xSoBcIxB4JqV4dtJjKiDr8dble8Dmak1Q4SfW4sUG3e8VIZdp6mYQfWzP?=
 =?us-ascii?Q?hc1NZPqfTU4HV6aMLK1UcwMe0MYRuJod3a6iSZt+PAVsY/xmdFVob1m4KFB2?=
 =?us-ascii?Q?DqMrkmAXXNTrm/d5PW2Lw+xw3EtxpBNK5LFZ2eEvdDoOwfoLzZKr6S1p3Dr9?=
 =?us-ascii?Q?rG0BnBz9kIuegKbRC81AIv8iOWk+IZXnWs8LuFpe3wZZSYhwwb/SQ5aG4T4w?=
 =?us-ascii?Q?piyBfTgKWW6a6T8iCUaa8wmEnXTrKMwJE4+kNX2CmP5fiDCUtGUz6zSqm0/s?=
 =?us-ascii?Q?qKj6aR3SZBZoAX5z1I93hAKJfsea40vRg+xhbSWrZ0A5W3YPVyR0PijGmwDc?=
 =?us-ascii?Q?Z/nTuw+0aH5k96p/fXAQbsKx4FT/NMv/7I9G4AnddtlI1Fps8L/2eC8lP+ou?=
 =?us-ascii?Q?j7FLFpv69WYlcG9npRYYBufTFd94?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46813ec-e8ea-4994-fdde-08d8ee943351
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 07:12:35.4943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6nfcDpRpYJWyaC7tAKuCtXmJ0o1mfhR2paG/kmn71yZ5t8c1p1sQ9qE2Sn0NBOTVIxkbgKs+4NC/temn7NrXsGWODEEJLqtYvRyt/1AR6sU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7223
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 24/03/2021 08:11, Christoph Hellwig wrote:=0A=
> On Wed, Mar 24, 2021 at 07:07:27AM +0000, Johannes Thumshirn wrote:=0A=
>>>>  	if (iov_iter_is_bvec(iter)) {=0A=
>>>> -		if (WARN_ON_ONCE(bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND))=0A=
>>>> -			return -EINVAL;=0A=
>>>> +		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {=0A=
>>>> +			struct request_queue *q =3D bio->bi_bdev->bd_disk->queue;=0A=
>>>> +			unsigned int max_append =3D=0A=
>>>> +				queue_max_zone_append_sectors(q) << 9;=0A=
>>>> +=0A=
>>>> +			if (WARN_ON_ONCE(iter->count > max_append))=0A=
>>>> +				return -EINVAL;=0A=
>>>> +		}=0A=
>>>=0A=
>>> That is not correct.  bio_iov_iter_get_pages just fills the bio as far=
=0A=
>>> as we can, and then returns 0 for the next call to continue.  Basically=
=0A=
>>> what you want here is a partial version of bio_iov_bvec_set.=0A=
>>>=0A=
>>=0A=
>> Isn't that what I did? The above is checking if we have REQ_OP_ZONE_APPE=
ND and=0A=
>> then returns EINVAL if iter->count is bigger than queue_max_zone_append_=
sectors().=0A=
>> If the check doesn't fail, its going to call bio_iov_bvec_set().=0A=
> =0A=
> And that is the problem.  It should not fail, the payload is decoupled=0A=
> from the max_append size.=0A=
> =0A=
> Doing the proper thing is not too hard as described above - make sure=0A=
> the bi_iter points to only the chunk of iter passed in that fits, and=0A=
> only advance the passed in iter by that amount.=0A=
> =0A=
=0A=
Ah got it now,=0A=
thanks=0A=
