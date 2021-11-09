Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7471C433F5
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 10:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D81B61054
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 10:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhKIKtR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 05:49:17 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44777 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhKIKtQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 05:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636454791; x=1667990791;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=duvGpfSrrVx2IY1dEIaTzbjD3lN3BF9yHJdld3fLO7w=;
  b=iwlso9r1qeIm3ex6DqyuYUZFeZ4CK7JhQBGoAN3jKYowhzRF81N4nhQi
   pGgrrHcv3SbSrUrWYzIWws8CC7FPclsmoAgF79kgNN7SVrVCYfnnJYmLO
   K54J9B+s7Z02BjpZ1r5Jz6Xgh6aR4KnOvvXexXRu1CzyxGvIHu4z19+9w
   8cGaPzJlguRUUObZYq+ZZRwLjUDu5/w2W49nDS6tdh54fBwgV3n5ngQ8v
   8aXZYrmsyRHolzf8qIRHc9nYXDFXRkfw3GIeZvjg06AAJ8UPHUTBfBkB6
   Bs7fkn46irBFr38YM8quT0YpIdGDQVwszYOp+PGQ8/X5okvXClSveXi8l
   g==;
X-IronPort-AV: E=Sophos;i="5.87,220,1631548800"; 
   d="scan'208";a="184119666"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2021 18:46:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbV7KA6HQEyHaFi5qkGygEeUY9GmLbm0ivy0ob8sSt4WfluEOZyudDwbR7Ucm+ALwxLI6VY2nD26/0tc70OTvgJfd2Z3GTlPcsZa1rfchUSOqc0l0l4A9cnegHlQ3lqvhc/bppcEhzLm8l5vHQxhoouD+dYNM0p0/Qv+JIumwNiFy0aVGfeO5sS6TqwHHJBZ/O63gaF/gfsTyjYakIZsDVvd+5JvV2sPax8Pd0wDkOg7uVxnjIS1BOS3BD3UB/TuUFmzNa0gO52T+cDuZfmnNm3b4uAN9KJltjjmU5VSHF0LchBFyA7xj56gGzxTldTPTmkyE0YlFgMePWvwSOLPKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duvGpfSrrVx2IY1dEIaTzbjD3lN3BF9yHJdld3fLO7w=;
 b=EiGT3ml0Cx5xExfoOIkLWHZsK/AFD3ofVHpDszshhj5F9Xl81TSEh7PvjJR4mlHF4qd6lQmDcDmIyL5ms82QoZ6czJQsofrAzDOXfqV+Rt4mUvmXnEK5Wmb/RNVmdqhhmrK+Nneih6cPOKA9VGiHgiFFeUy25LxGfxvDQX3+jSryadSzDJbTCwSp/T2Qxb3CL5x7dmouqLx52wdDwXiljbcW7bRu6CxSMYVsuDA1svbNcugLE+wLngx/qZa3XC/4x7Qi6DtPrG7fCxyTw1iPL0PpQGSnMDmyDEnJw0eTH6R3Q6oi7dunecVmS5LWkuXb9w7+JHCQT/DUNOO5y7IqlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duvGpfSrrVx2IY1dEIaTzbjD3lN3BF9yHJdld3fLO7w=;
 b=gWvgFdcUAupjkVFexgbqNBNSvxGgvPhOoKnFPV+3FIh6sfZkAX42pIRRRqnds7N1ZEZYOhigstynAiwFLISj1AoZQ0OwYXux8b78z9L12HftEBdcUx+RNsyBFW9D931gWbpXl+/j/YktEU59R18vDt0tTjTfTUt3f9HRbeLw9g8=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BYAPR04MB4823.namprd04.prod.outlook.com (2603:10b6:a03:11::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 9 Nov
 2021 10:46:29 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61%3]) with mapi id 15.20.4690.015; Tue, 9 Nov 2021
 10:46:29 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V2] block: hold ->invalidate_lock in blkdev_fallocate
Thread-Topic: [PATCH V2] block: hold ->invalidate_lock in blkdev_fallocate
Thread-Index: AQHX1VcN9hWt8PIrlku83NmQGPU6rA==
Date:   Tue, 9 Nov 2021 10:46:29 +0000
Message-ID: <20211109104628.h7fzcmqtbt6gyr7k@shindev>
References: <20210923023751.1441091-1-ming.lei@redhat.com>
In-Reply-To: <20210923023751.1441091-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d1b8652-b6b2-41a4-02ae-08d9a36e2fc6
x-ms-traffictypediagnostic: BYAPR04MB4823:
x-microsoft-antispam-prvs: <BYAPR04MB4823800848C85B44E17F50A0ED929@BYAPR04MB4823.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DIXaBIjgldWcywmq4Q1dGjlRPHI0xfeDjNiWTESdiDAPen5G020aTFM0DexgjHOTURsPaN7pxKDux/+w9ES2xRqpDojddbgBOBRBgwCVYIs/lOa6zeP7YyPnEO9s1AwsXM9iLtEIE/4HQgKSwn3+6Za/w4ON4zVql1cx+jfRn3q+bI/43nCUQWatDGQM0BH4Skc/Vmuv9NqODtfjJj0JiwHP7il0wHW9U79ZtCBf889TD4GRDV53yUH1aovnMvMlFpJX5QganAGZODpHULd5dLOK5X6z9j7rpAc1AgBgnPiJHkrT8dKL8bqRQU9Jfozpzn9xVvYc6RryasCmeAXu09OK9oqdLdE5a88UAc9RhZALhMwZ8ibWJu4bXjyL3Nyp8dVVdzno11+eOJzq1nC9MBP8kZVYbRB7UsXYiW2eTsmohTfoBGmelVBTKe8ZkDnDegvyyGhNMzANW4dAsVMxugqJEGqRfyik8UvZ7Dre8u3pOe45kMJWohNTHH75AqNWLQR9mTqON160y3mVCkjoDRCM+vt5ez8hM02XwwD/LLXdy1oWy//Yb6s/eUk8pky8Ip1qKcU+lYPfryy53yLy+0EqaXer6NsEk4UxJcgcBoF/459Wznp7GOvF8j7RNdkPiaJJEqBcX2AWvbsDetusJeYhTqTAZvI6lMzGrqjtHXv7cBvCLI8LPra+KhFIP5XeBhs0kvtpoKacHasZvstzrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(8676002)(4744005)(9686003)(508600001)(26005)(6512007)(66556008)(66476007)(64756008)(83380400001)(66446008)(6916009)(8936002)(5660300002)(6506007)(186003)(6486002)(4326008)(91956017)(1076003)(76116006)(54906003)(66946007)(86362001)(71200400001)(38070700005)(122000001)(316002)(82960400001)(33716001)(2906002)(38100700002)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BMUjBev6gtxKuVkvV2aXXdmVXGbkuN/FRbUfJogEkqYA4qU/gCJ8ecLlR+Da?=
 =?us-ascii?Q?Hkw2BGNKT+N1Tr6DYXsVONxvtlSbQ/jHTcz6nihcKhODrnKI2QJwKXDkOj8f?=
 =?us-ascii?Q?mu68YT1xCGPOOLM0tnbdXgwNPVyL3UpqPttvlf1SShFe5bAF9HHqGwvNAeEk?=
 =?us-ascii?Q?ZlXdV5USNGsl2qdLoMgCWj+N+Ni2k15h5WYtuZSO4Wu3oIkQuzCCB7RQiM6a?=
 =?us-ascii?Q?tRxV9yQ0UOXhhuaBA8ociYzdDz4kbGakAPEYxckCgbWgMTI68sbTDE4hDIM6?=
 =?us-ascii?Q?Lni/lPoptAi9hFm/L0WNhje083h8OGj09oZ4QqBUK88/c8sFZnPv/7eEJBBD?=
 =?us-ascii?Q?Tz7nwkPpdjuxqi0SBdmSWBnZfrInYoT30KRXcCCphvQpCEbjJoFYku6bXAj+?=
 =?us-ascii?Q?+9ipJ3BMU5rcY3p5vXaSABpZ5RUi9uLB76KoDaCxOD16SGan+bwQlI7EHKqJ?=
 =?us-ascii?Q?Z93VqV0xzKod4/SoKoAVyfjIRycMDuAcaKjlqiFwcNe79vy4svsBd43FRFEX?=
 =?us-ascii?Q?cZ2hmpcmuhFoBWGE1gbB3wZ2vZeQAc4eOFAeTs7UaCurY9i2mEZ1Ufo+kaVV?=
 =?us-ascii?Q?rYFNUBRVbGjBbRy9Z1lCNnOIfB3F4HxXh6Rvp79UFd7pSOguAauU3sDogpXF?=
 =?us-ascii?Q?2rlGgZ97AjOQeCnRM3p6KWi6UVutNjOEEF/y0nfB/JiEolgbtQkjk9vzFOUI?=
 =?us-ascii?Q?bSZmI75PDRA45v1qgrgKYZwd5TFgidx58G0fpkoQkP0ZaVWPEWxFNaZ6qlMd?=
 =?us-ascii?Q?iklxeCJXDk/wAxP3a9c+Xn5mnXTTtn3P2pZ7bRzeT8FoS5bRNdno4R0wWCi7?=
 =?us-ascii?Q?+J7ZKE6xg/AOrwHXQ0Ia+AJF0VkehEMOtwvhhH551hg+hqrI8J8BeT/PO2tz?=
 =?us-ascii?Q?TpBKxwrKpyclTDO1ZsrkqVU4v1ZHZg2Rd6Bi/4UtgaspheipOv7lVHuc/73i?=
 =?us-ascii?Q?GlhV2fp1Y9xMe/htaZ9qD5O12LS0pPicOWXP1QVCu0VHS4gKjpc9okjiyEld?=
 =?us-ascii?Q?tjpixWp6QnD0mN9v9AnKina/33bKlF5bnZ/CDedHLlRDvTpkL1SdXGK1L47L?=
 =?us-ascii?Q?4NUGjNscrwVl/0xDJAF90MnNRkvt7ubyd6YZ52ywx5yU1oofmhlLli++mwHP?=
 =?us-ascii?Q?2uTR0yW2NmOI8G+WK9kztdz66kbBAU701o3iBdkqp86oBsZHLhy37adwSMkX?=
 =?us-ascii?Q?F3frjFKgu385hUlnKXFlbii4WIhuv/wi4a6U2VYjzEt2wB2iskg5RaRjfw40?=
 =?us-ascii?Q?NTGuj01jCzh4eLcbFqvzSDdVZdS2nKHIN/ghhi2Ad6z7bkY4TWD2bjLiCcKe?=
 =?us-ascii?Q?7rbPaxXJiWz5owl9EojJQFmZIKUHNCP1dkCmZdvAcnD1MFcSoTuReIdy+TGZ?=
 =?us-ascii?Q?DpUhO32dhE41A32xb/lpqn1D/DsezqpTvq3uHImZi0yRwP7NjtbJBRQ2dzqk?=
 =?us-ascii?Q?F3+pyThiZdgEccaLOknMHXoQAvCpDMmdRSzb6ndiU7FqFGAH8MSPJQmR78/z?=
 =?us-ascii?Q?ZggFZ163mD9efdsY1/AhTPITeCqr/mu7cpIa0uxA8om41uE33JjU6xu54BPP?=
 =?us-ascii?Q?Lu4misUPmVJ0zkoif6doC+FCP/2tCUW32Z5LMby7rm3R6SHzbCnNtKzH9aF1?=
 =?us-ascii?Q?KOU82CCzH9E+t7gMcTA+fw1VuNPStyxC0ieOU5TrM2IMJ+HB9S93wq7BmI6q?=
 =?us-ascii?Q?K/ZcusdF3w907vuro92BzQRaUcE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4754FEC9AB1E744AA9E47CD4305FC501@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1b8652-b6b2-41a4-02ae-08d9a36e2fc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 10:46:29.1975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iUweskWBnk4z0yXwpSmuvJ+jT+738KTXZXuJX/sqb9tv8UsRLHibUIe63rJRvKMsZcwWT+eZgS1M79g5LityT/Ms1jQslduYIu94gLiLp1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4823
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sep 23, 2021 / 10:37, Ming Lei wrote:
> When running ->fallocate(), blkdev_fallocate() should hold
> mapping->invalidate_lock to prevent page cache from being accessed,
> otherwise stale data may be read in page cache.
>=20
> Without this patch, blktests block/009 fails sometimes. With this patch,
> block/009 can pass always.
>=20
> Also as Jan pointed out, no pages can be created in the discarded area
> while you are holding the invalidate_lock, so remove the 2nd
> truncate_bdev_range().

Hello Ming, Jan, thanks for the fix.

Unfortunately, I still observe block/009 failure on the kernel version 5.15=
.0,
which includes this fix patch. I found that BLKDISCARD ioctl has the same
problem. I modified blk_ioctl_discard() in same manner, and the block/009
failure goes away. I also found that BLKZEROOUT has the same issue. I will
post two patches for these ioctl. Your reviews will be appreciated.

--=20
Best Regards,
Shin'ichiro Kawasaki=
