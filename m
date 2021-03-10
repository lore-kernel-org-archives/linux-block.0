Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C64C433E0
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 05:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9728D64FF4
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 05:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhCJFf2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Mar 2021 00:35:28 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10310 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhCJFf1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Mar 2021 00:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615354527; x=1646890527;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Fx3hph0NESPMls8Ae9omjvIFeUOrdsshM97e8MHgcXo=;
  b=pF5iRpuBUf35RFQk/+XjR2zkidPUCDwx2V+gXlfkfz+JGFAchTr3Vt9G
   DgCYlXs0oPL3LbOh02hX52IsnzYVhG8RrCzUQPCMsILDiYFI+yQbqEQur
   RGUzqg8ABbAx9NWfRuoGda4r+J9soQHrzqmHfQoaEdXKUfgYFXRHFQ903
   7ivf3bVPgMyIVzj8vv726eh32kSB4MwqHcAJtozYAOcv8hG+hwq22M1rp
   rOWpyvzQEET3EHEn8Ifi2L6U3LS1wI87jbIhnPsEXPc8x1S7xzAvm67EV
   URgmFWVmGMWC4v2BYyf/887jEFpZ7gIojUPiMCEkjncliBIaIpIVrfl2I
   w==;
IronPort-SDR: r2GW5ztGw54yVQCyNN55DbH2eWiZSYqHJibZgBlEDm7kgCo+Zq2GTp3/3W4Vi1KMOntleTxhkb
 GpvqHR10LlED/RhgMnDqVnb+7xdbOBnI8NgI0dZNNkbTnt/9cUiXHz8IN9AQp3y3g9wWC2gbJz
 iZ2r+96RshLQwk5S3+UZBnspSWaoJ+pAXP9BFBCrbFWzEZn4ChIh67vgYD//2n15HiL5L1Cfji
 jUrv9ZIMBHaO140SSZZoGmi8R5b2kiyx1+WckXgOmwf8SgULQ8OtUx1tRhensZZbdWvWzodIEn
 O24=
X-IronPort-AV: E=Sophos;i="5.81,236,1610380800"; 
   d="scan'208";a="272468315"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2021 13:35:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzw7R8MjzSYIrKoBLy7mZxfuWXP6A4Udn+Hlx5GZuWMHpi1SEOhLJrOzKQEWmXCz3Yf/UvqRQwwCZWtEt6ClNMHbVOCFPT5awMMS3MyYdaH0InVhpj2JxpOft5LXbisQXM5gwWBTwICJaflxeWEv3egqEneDzufch1mL4OnA4doloeeq2m9B/GvDeyZ9EMrN/1f7WvOgoVIciyPJSDwFRM/MxzQ2ht7Hti1Vu1bFOYapu/lwTNbIOnEqxunkbH7H7c7Uvgqqrw6tXhKWTdJO5PqwCvGBdWtVzcBJfwoAdZQU0S/MAtPFFNpEvxuxpIQejJz6G20skY1oiszxojCK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfKpGlTlQfJai/2B4yyJlCU9hPJJkAeoUW7UBQr4x/8=;
 b=NeGH6CG+6s6OpAw3QWIJhoRoTgDkhsKju3b2/mmdjoZMRnUroSbqWW40/qcALumlqlS23wTxt5X9XRXbqF0MztQWNp2Hfmq4gJBS2W/fjuqpf3HPvo2g6ZClYicDAjImmi5o99Yw0/jjFG9aPnmiXTgeQ50Xs/bDXcQsX1beE5ff1Gagp+XUWBT89sAK1n1y9UON0Z1RijnYrBTmM+UjFeswudnp8pr4xwVglvt5BO7MLv8gkuJuOgmRPwgcET82JEKXoTTdfSnrrlHbBfhdNLW64qnWcAYcz/AzsPZr8So2Be30PN1REndMtTzAoSNaaTVJ7n6rxzlWGMvNKmFVOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfKpGlTlQfJai/2B4yyJlCU9hPJJkAeoUW7UBQr4x/8=;
 b=fuNP4qTAzd5McijNohoa5r/6rdJF/OTXiBD7DBADigeQrckl7wSYC61x4Qr6lKxDNIq54UrMIOyTJf3hD4odkCUZw6X3pGvbYr0Y56yqdW3ysBBOfvjirP/80S1Lwroxsc71TZhe9hYTWBd0CNUdzwxhDMXanLK9dJ4QoaeXP20=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BYAPR04MB6054.namprd04.prod.outlook.com (2603:10b6:a03:e8::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 05:35:25 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::61ad:9cbe:7867:6972]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::61ad:9cbe:7867:6972%7]) with mapi id 15.20.3890.038; Wed, 10 Mar 2021
 05:35:25 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Kanchan Joshi <joshiiitr@gmail.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] block: Discard page cache of zone reset target range
Thread-Topic: [PATCH] block: Discard page cache of zone reset target range
Thread-Index: AQHXE8uxdBEpKv5iGkicBn8Yh1nDWKp7j1iAgAEnZgA=
Date:   Wed, 10 Mar 2021 05:35:25 +0000
Message-ID: <20210310053524.ct3tqt57zmm3tndh@shindev.dhcp.fujisawa.hgst.com>
References: <20210308033232.448200-1-shinichiro.kawasaki@wdc.com>
 <CA+1E3rJjpeX6UVk5HZhGPzeaTo0-VNsmEaPAWkH4-EmSGD9BGg@mail.gmail.com>
 <BL0PR04MB65140D3B886F8076A9A2DAAEE7929@BL0PR04MB6514.namprd04.prod.outlook.com>
 <CA+1E3rJOmUaa5RS_FOapPAjbXisoHN+eY6uvJoQ_XjazmRmqYg@mail.gmail.com>
In-Reply-To: <CA+1E3rJOmUaa5RS_FOapPAjbXisoHN+eY6uvJoQ_XjazmRmqYg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d7da39d-2852-459d-504e-08d8e3864ea9
x-ms-traffictypediagnostic: BYAPR04MB6054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB605456253D1B01376DFBB4BEED919@BYAPR04MB6054.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8yf0zqFaaOKqU0cCc0wQeSZgA89cBXkjjyuXDj+GE0pNJOdtOOIK0HYm3yoenVQ7yY7+n5BTGuXsku7pn7+QkYyvUcfQGwFbXQDxhqhT5FX5CqxI0TuEqHWa9P7ibPwNPsey8u94WpCVaQHxRmDTOdE8gaU0750LBShOSUwW/CVsGgb5qfYuvexzd0cKbwNIPGgS/uhCV5JeaAPE38pIl9tPX7S0HBVnEWHQxvCXBbrhqm2jm6digEIZajn0H+TFNMpYJ0WnZhSxiRx6x4ex2jgqEnxVxIC0qW67x5eRiNiZNMLuStAHjsbp0kdDaz04aS68lpVcyCI8XDyMEP4HxETwKHe+yKwUu7hMdlDe/cVm55r9MGXvUIo5di0mE7vifbZep3ujywQu+jrfDhf69P1Fi03wBwD7D/o1sv/jss4N3AU2H2u6BVNFfSu9WOO7AqNpteG64Vw4aSOBDsbyECbMEUX/9Pnv6JN0ls3spJo0KmegFTob4zknmjaGC6+JWrJsMlsHzh1zgRnIMGFw4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(44832011)(6506007)(66556008)(26005)(2906002)(316002)(54906003)(66446008)(6486002)(6916009)(64756008)(66476007)(66946007)(4326008)(76116006)(86362001)(9686003)(1076003)(8936002)(186003)(6512007)(5660300002)(8676002)(71200400001)(478600001)(53546011)(91956017)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FaoptrAVqRdhFhAqKh715LQJ87D3dmcnoUnEnBl545P0LtOOCHyxuQrA7LJK?=
 =?us-ascii?Q?5X7f0gz05kmI2qzQUHhITAeZLBpXd4FIUXYp8vxWa7ybKwZYCdgokhYWi5eN?=
 =?us-ascii?Q?Vfd0L3AWq4o/H6oyfL9aqB9hbcf7bgd1JTZXaoicDzLG0Tq/Myt/9BpOjSu2?=
 =?us-ascii?Q?iunK/QpQ3mbJvzzKle1lZJMC4ydIGFSYcWvKFYMuMYSV4XQXfdq56QNwEgqP?=
 =?us-ascii?Q?45rIqroLJjVdNT7zq4wzf9mTMCn3yiJe4YQuvlBwiiDg3PiAJnj5TMaXDbBT?=
 =?us-ascii?Q?TQ59X0k3LQ9/WGuGhWju2hqYet3Sdhxu+zS6esTTSwt06ehXbEssWgcH4bF8?=
 =?us-ascii?Q?F1/i5rKRm3p/U+tj1+HK205EjkjRSUvrfAcvCqpkl/1WDkoPuPtaepw6NLtD?=
 =?us-ascii?Q?EYAmIWzPwkPutGa5NJZWPtYWmcQc6K7p0OqIMBtIxP4MeGREaVkFIAUuXeP+?=
 =?us-ascii?Q?MqToF0n7m/Zpuh8KZ3gLxPyH3vkU+edCXYT/BK2BvuYzbhpXKZAjv86pKbuv?=
 =?us-ascii?Q?E7g1Xp5lNwqXEIAOEEHWy57AqpCo2eqD5pYwWl4D5wRaDwluMXt7Kwc9vBqL?=
 =?us-ascii?Q?fyUcwnUp/mGSJwrIjwwV6oMLRrH67/15wcVHAe3YZeuze6yv2TN4TcOsofQm?=
 =?us-ascii?Q?2UKYDuiT7/xjoG0z8z12Wh6rQLVkPuSdkWWYrH6Sn254pldOYU3B41YsGcJ3?=
 =?us-ascii?Q?8kUjSDHCNtMqtRDuWCara0DPQ3Ji+bCH0pBuwBY8gttpPT0HmZAHhO3YpW3/?=
 =?us-ascii?Q?kfpTlGxng6z3pEBZR2GeZfbZQdiH209q//bMLX2jBnOMkxEF3A65iKIBlrI7?=
 =?us-ascii?Q?23N+MceqREwlMhVqrj4LqNmKX1na5AdCexpOhFBjudG/47zrKJ81MJOLsrPV?=
 =?us-ascii?Q?fJs6ocmypZlBNe5+b3pqh6TPEVligo0OWxQt+hFn3F20a8Hh3oD0iYTdc+iy?=
 =?us-ascii?Q?VaRSfnBtQe4lWWe2m7X1KBja1e6m5INRtZs0QaIynAG+Q1Zf9SQNJIb/9dqm?=
 =?us-ascii?Q?ruOZwehLJAQ2Ru5sFF5LmTbclQEScIgJx6F0S8TqEuaVqm5pkD5yyRhXaD3+?=
 =?us-ascii?Q?uT32LwVNlwWldPPPOf0K4etqD+Lpe08+QLydRCxDaBUaZsVckQGc7bNqZYrW?=
 =?us-ascii?Q?4tDHHjGVARQmYNCyBniPUxqvnj0eaLWrq8wcGpZAutbDO2Pl11Hu9sKEGyGw?=
 =?us-ascii?Q?2BU0U+womajt4q0gxNrjZfQay4wgJsjDhH35BhJBehd1YpTGJusYgiJngF2i?=
 =?us-ascii?Q?QBg98gOZJHkFqeeQO0XZ2OoE/4Z0cJg9jNXeBZmC4UJhhS+XqPUr71wA+Bfb?=
 =?us-ascii?Q?5IgXmARJitX/GWlpNCN47GECGyHEsWdYkS/NkKbjubbbOA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E76A69D9798AC048AA90A0142AD9EBD8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB3800.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7da39d-2852-459d-504e-08d8e3864ea9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 05:35:25.7027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8xzckXBtUNkYfcwifPbiqCxiUZvZ5M8ToCfw8YBEnGdxG6JQ3tjNFmfXOZrzs6AsdX2IJMabKine+3Iybo1Ft/67+sMZYpeSaUTMVEj7cM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6054
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 09, 2021 / 17:28, Kanchan Joshi wrote:
> On Tue, Mar 9, 2021 at 4:36 PM Damien Le Moal <Damien.LeMoal@wdc.com> wro=
te:
> >
> > On 2021/03/09 14:49, Kanchan Joshi wrote:
> > > On Mon, Mar 8, 2021 at 2:11 PM Shin'ichiro Kawasaki
> > > <shinichiro.kawasaki@wdc.com> wrote:
> > >>
> > >> When zone reset ioctl and data read race for a same zone on zoned bl=
ock
> > >> devices, the data read leaves stale page cache even though the zone
> > >> reset ioctl zero clears all the zone data on the device. To avoid
> > >> non-zero data read from the stale page cache after zone reset, disca=
rd
> > >> page cache of reset target zones. In same manner as fallocate, call =
the
> > >> function truncate_bdev_range() in blkdev_zone_mgmt_ioctl() before an=
d
> > >> after zone reset to ensure the page cache discarded.
> > >>
> > >> This patch can be applied back to the stable kernel version v5.10.y.
> > >> Rework is needed for older stable kernels.
> > >>
> > >> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > >> Fixes: 3ed05a987e0f ("blk-zoned: implement ioctls")
> > >> Cc: <stable@vger.kernel.org> # 5.10+
> > >> ---
> > >>  block/blk-zoned.c | 30 ++++++++++++++++++++++++++++--
> > >>  1 file changed, 28 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> > >> index 833978c02e60..990a36be2927 100644
> > >> --- a/block/blk-zoned.c
> > >> +++ b/block/blk-zoned.c
> > >> @@ -329,6 +329,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *=
bdev, fmode_t mode,
> > >>         struct request_queue *q;
> > >>         struct blk_zone_range zrange;
> > >>         enum req_opf op;
> > >> +       sector_t capacity;
> > >> +       loff_t start, end;
> > >> +       int ret;
> > >>
> > >>         if (!argp)
> > >>                 return -EINVAL;
> > >> @@ -349,9 +352,22 @@ int blkdev_zone_mgmt_ioctl(struct block_device =
*bdev, fmode_t mode,
> > >>         if (copy_from_user(&zrange, argp, sizeof(struct blk_zone_ran=
ge)))
> > >>                 return -EFAULT;
> > >>
> > >> +       capacity =3D get_capacity(bdev->bd_disk);
> > >> +       if (zrange.sector + zrange.nr_sectors <=3D zrange.sector ||
> > >> +           zrange.sector + zrange.nr_sectors > capacity)
> > >> +               /* Out of range */
> > >> +               return -EINVAL;
> > >> +
> > >> +       start =3D zrange.sector << SECTOR_SHIFT;
> > >> +       end =3D ((zrange.sector + zrange.nr_sectors) << SECTOR_SHIFT=
) - 1;
> > >
> > > How about doing all this calculation only when it is applicable i.e.
> > > only for reset-zone case, and not for other cases (open/close/finish
> > > zone).
> > >
> > > Also apart from "out of range" (which is covered here), there are few
> > > more cases when blkdev_zone_mgmt() may fail it (not covered here).
> > > Perhaps the whole pre and post truncate part can fit better inside
> > > blkdev_zone_mgmt itself.
> >
> > No, I do not think so. That would add overhead for in-kernel users of z=
one reset
> > for no good reason since these would typically take care of cached page=
s
> > themselves (e.g. FS) and would not trigger page caching using the bdev =
inode anyway.
>=20
> Agreed. In that case moving the pre-truncate processing from
> common-path to under BLKRESETZONE will suffice.
> With that refactoring in place, it looks good.
>=20
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

Thanks. Will reflect your comment and the other comment by Damien for v2.

--=20
Best Regards,
Shin'ichiro Kawasaki=
