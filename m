Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA8FC433E0
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 11:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 160646524C
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 11:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCILGy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 06:06:54 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:1313 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhCILGt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Mar 2021 06:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615288009; x=1646824009;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ZlPXU9Useqj+ELF8RG7xlQ2Le9/YtUrZ0l9DxKaBVb4=;
  b=LRDBAzmlrSzAa+OW7+QZansQX8/Ym7fzRywbF1hkOCwhLVPTiY6G460R
   e0GmxM+IQtW9VabC6l0EJ977CO77kRG4JjpDwSNIBqJ8fyd3uAKjLakCG
   Eky/mrNszwoqbGHEDIVu8MvMoAaS1jYu9vBihqhpb758mvQ8YU8GE5Oaq
   icdWDVgq7GFksgTkkynthVGfn4ddqPLQLHkcPLJafaCqDh0cWVRyRrCxX
   F4kLdmpAn5qPT/peACBiRcgk5q5Ol5EcZNlvzWTGtWn5Hr8GxzugwFIzo
   Psy2g9Quj/jPX6Oq8g+NpwZ8uJCBBiVo5VrWv+S/2y/B5s7aCr77hknw3
   Q==;
IronPort-SDR: y0Nhkgmhv8mqmOJc74yAEDCOJedJFd9kzlGDTwBRcjxeLKE0+ppwgcN1NxqssamKWBGCYC5QjT
 i+iE1E5n8rmunzBNVQ1cDAEbBwJAfhUuuF7DeRit3R2gsSk47neDKO4x2ykJ1Fqjz28cYNRuYA
 juf3RLGr3nCmQgSQU5/EKKP6vDwB1io7iR5Pv8HG3jN+ICAye4WGXHl+mqVAF+qPJZGh7ygIl/
 iBXjgNnuN9L1NzmZ/TND3zZptzt/j1Uqr9xS4NEG0yueY1vCb6MJACCqhNzOflt1D6IOVjqR1/
 ae4=
X-IronPort-AV: E=Sophos;i="5.81,234,1610380800"; 
   d="scan'208";a="166207334"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2021 19:06:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHBMKfL7cAO46karEggQIttW3Rr2BIb245eUHnQ1Td6lYZRVIA6CXJM83QCyg79KLHTrZnV8iwWfhh/i3mmsCdVS8D8xmN9ULulSEv0fpc3d92XP+3gWEmPUwwTNlsuqkVnbXw46vhg0fkjYrJFUlIvsrzSW6TkUXyQXr6h4kXVHyg3dIfF+Hy4tOREz2kJJx/Pees8JIG8mbmpZyTXLn/8jdiSJvLYAhTOQQmveLFamyLGbzCVn9rU2P65lSUz2iJt1UpUhZFR93oqsIMbd99Z8/27bxETFNt7rXhWL3UQV4kuqSbVLEdA+fgMF2e6H6U2FVh15MQ7cf/SS02OeaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIVq53agOmK0pzyHkA59SLiNtzJFWZcQAjzHSMXgvyc=;
 b=ZfwaZGqQiRe+CKBJ6kY/Fh7XD4EzQDKHaoEZV7XglZyYMxriK1Jcz4dM47V5o0kVVXzOfK3Tnxh1XBFHu0tMT4hfd77Uls50P7KxuQReyMVfhdVrQYh6+6HbqNKrJR+eMj05+M3zVP5rZyYq04K+p/EyrLsaTA68yirrM9I55/pZqfchrE/Ubzr+Qict3ojj/B8reheP5K+kG7fQpBirr7gsTnVLbrPdhssa5d6BFuIwIsKqczc290AYtZyYyG9J0lPjBhdR0QJ75Xmd9l5SJx73Uc1W9rWBAwwv2MolZP5MehBdUIMQ0odW3qkr075Y1gjC5mj7PqNBQijisxPfCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIVq53agOmK0pzyHkA59SLiNtzJFWZcQAjzHSMXgvyc=;
 b=VxABIO11VUKignJhDbEHTmVJsjixeOatagoTWu7EEJ/Ad880fTZ0wUCB6DzRQlnM1WNkl8rrTxSlEL3t27OOqAxfeUOCDV7p9kqnH+K3mabgjPomjWX+9QhFPVXh263LK+C7Deznag39gmNN26ZEv2fiAU92rg9TVYkUdlCVtE0=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4611.namprd04.prod.outlook.com (2603:10b6:208:4f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Tue, 9 Mar
 2021 11:06:47 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3912.026; Tue, 9 Mar 2021
 11:06:47 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Kanchan Joshi <joshiiitr@gmail.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] block: Discard page cache of zone reset target range
Thread-Topic: [PATCH] block: Discard page cache of zone reset target range
Thread-Index: AQHXE8uxli1x9EljZkeik2Tn6fiJcQ==
Date:   Tue, 9 Mar 2021 11:06:47 +0000
Message-ID: <BL0PR04MB65140D3B886F8076A9A2DAAEE7929@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210308033232.448200-1-shinichiro.kawasaki@wdc.com>
 <CA+1E3rJjpeX6UVk5HZhGPzeaTo0-VNsmEaPAWkH4-EmSGD9BGg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:b5c2:5e8e:bd4a:dfce]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be0d4066-a290-4438-a6f1-08d8e2eb6eef
x-ms-traffictypediagnostic: BL0PR04MB4611:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4611A2E5550961279E29924EE7929@BL0PR04MB4611.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z9K4FLqLHKzSZwrRzPcf4N1E9lpAFijBiL/QPFeFxjS1JD45pTPekPAUQgZ/2+MxyhofZjEwFixsURc8AkAnPXGgoZgUt+V/G2T/ednGlgfUuFRHSUZWcCi/2SQ5Qvmf0daB1UNlIMyXNQkusl1gsnxyRDYWpJlqO1wyKVafCOesKPjVl2KM2aGCixh+OY87qtQxMSJ1v8O3XEpdlVOrfd/i8C6q8M6jvh4J80mpYh8Z4XoojfdE4iLPFG9i2cF3QgpdJe7/iNdSPQDvlmOP3+yip7MBcS3aIhLCBj/FE27kJU14KxQZweJVpLif/klvJSVfvpRpk7HlP9H3npw+CediXWPgYnQ3/dvLj/uhXTh5xSaBABT1694j/1IauYZ1/X7SiklOEMTrM6j2f+ZiDpIa54lFTh0mj8qmxpFqMzIjdjgTXZ91p0SlQNekbD9dSXO/0zprKFCxvArbzHXYefwUdqGFUWLEc7wOgBfRE4uuEjPPEgRi8pk8PlMQn8u1Emh3QPoHP0i5yw7rbIB+Cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(2906002)(5660300002)(86362001)(66446008)(91956017)(478600001)(66476007)(52536014)(4326008)(6636002)(66556008)(64756008)(8676002)(66946007)(76116006)(7696005)(54906003)(186003)(316002)(110136005)(8936002)(33656002)(53546011)(83380400001)(6506007)(9686003)(71200400001)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WVK57qKnBjsUeFjWtgPcgpCqPIUpQnsnwWB2Gy0fUTI+h6GZkdSQtH1Sh20+?=
 =?us-ascii?Q?3jJnSavwMy9qV90cTR9rpaMmoPMrjXWyYgNTkZv0QBhtOKGOQ/k68Hc+1vbY?=
 =?us-ascii?Q?KnNXG3Cywxv34DMRKIpVmDbIimyE8etAs6NWm9EaPQqWGkLhMqPm0SLwDaNK?=
 =?us-ascii?Q?HSN26Kl6IXU4Y4Hib47+uQkTovlJmIP1GCxoQdLHPyEWNGTUkT5Y1G138oPs?=
 =?us-ascii?Q?DMELzxL1FJJW0mniIWXasPdqS4O40ff0IjpVZpicEe8Iqfl8MnWF6p9maWhy?=
 =?us-ascii?Q?v8r1uVSzXBsR/TBU3mbMrDKwExVaSXFQDWANXP9D6t0KzEUtVu6aFwNDr0as?=
 =?us-ascii?Q?sLIcLFy6PbALYTldod7V4RWfMEPmUqyDX3kPLdglKBgngFZIss4Lhu9sI5pz?=
 =?us-ascii?Q?vwSZOz9NY58zofSRVejegfJp3q3xENyyjDpZmFdlxyR0qHkK2ybT2Vqi7WE7?=
 =?us-ascii?Q?atZwebMfKJujSFjWA/q144/mT6lR0P7m27FgMkZKv1jrWARPc1COKEu6LER+?=
 =?us-ascii?Q?7UrkC01ONiqAcMiDSOwpRcqKcRYwgLds9h9MArXXUXd7AWaRr/QMMcyfDAJb?=
 =?us-ascii?Q?lFBBaErzIHUF1OKbsZY6FH4uMnrrHYtT8O3uUs6yqxei825zaVAajj0NBSJE?=
 =?us-ascii?Q?3cjStRoTTZgCEkUpDKfTEoCW/Z0mLV3IL8lg+WuTcUu3uZAgGmGVzgd+14LJ?=
 =?us-ascii?Q?DowA7T0FK/DOE5fgp/1OIeCsf0XQTALiS2g0ZiZgZsg6AM+FpQC8k6OHsw1z?=
 =?us-ascii?Q?IzJuegPlA6ih18YXiWcWmU+Xo4yjKWgZGcSmha+GiBrne2bIJDoNGSOdpXQx?=
 =?us-ascii?Q?df0b6rhBfFAsggXeE6BxJb443sp4ywXSM5xqYTRL0c09JCSTy1pPeohY96rd?=
 =?us-ascii?Q?se+ASGx139PGVMYoWK3ln2hfhfvqTeD9lB0SobFn3ww3aUR7BC2X6e/FydvF?=
 =?us-ascii?Q?CnPJfCZdn9J0OJHBVc8bUWhrrdlB0tFbYsd5zU4s8ybshUU1miqPlSBe38a5?=
 =?us-ascii?Q?8uAuE/eBY8WCN+QlEIRVWIzNQPc/u6hlw+HCYRfJBrUF84OHi5aLW4cDSTM9?=
 =?us-ascii?Q?ZGw3vJnyseRmfwouQcxV5BlG46fLnpx/Q4ecPQUN2O4Ko+VcFh20ITpa4jh0?=
 =?us-ascii?Q?hT0W++h2OFpFTtwoXMQv8OINzB4ZbKGAL/OI9Epr5BNOa6HOKD8jqjq0EAoS?=
 =?us-ascii?Q?5GQ353ZkKr0oKP6JqfOGDPYtQIglioT5Oa2G0SE5QqaNP+S3lL9FO6QUNAxo?=
 =?us-ascii?Q?I9t7ueVVYmBbOqiyOVs8V1XTqakPnlNC4TFrs/7OwYLTh/yySiyGXjTkIB7d?=
 =?us-ascii?Q?zwQ7+TkvSbWGhgAmk0sRNbRjgShGx8Jb00/lW79Wh7+6yIVh7vFj5nHnWHc3?=
 =?us-ascii?Q?i4qsrPidame54KkSSJ2/1dEAWPotv2WvR6KvKgkbN1yz1CJDcQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0d4066-a290-4438-a6f1-08d8e2eb6eef
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 11:06:47.8460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05XzFBIyFo9OUBJJaFRXAwhf+DVf9ascc27w5WF9F/ZsaRWl3i4pI22J0SGGWrmJHw97JLHecf0gZQyZA5O1yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4611
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/03/09 14:49, Kanchan Joshi wrote:=0A=
> On Mon, Mar 8, 2021 at 2:11 PM Shin'ichiro Kawasaki=0A=
> <shinichiro.kawasaki@wdc.com> wrote:=0A=
>>=0A=
>> When zone reset ioctl and data read race for a same zone on zoned block=
=0A=
>> devices, the data read leaves stale page cache even though the zone=0A=
>> reset ioctl zero clears all the zone data on the device. To avoid=0A=
>> non-zero data read from the stale page cache after zone reset, discard=
=0A=
>> page cache of reset target zones. In same manner as fallocate, call the=
=0A=
>> function truncate_bdev_range() in blkdev_zone_mgmt_ioctl() before and=0A=
>> after zone reset to ensure the page cache discarded.=0A=
>>=0A=
>> This patch can be applied back to the stable kernel version v5.10.y.=0A=
>> Rework is needed for older stable kernels.=0A=
>>=0A=
>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=0A=
>> Fixes: 3ed05a987e0f ("blk-zoned: implement ioctls")=0A=
>> Cc: <stable@vger.kernel.org> # 5.10+=0A=
>> ---=0A=
>>  block/blk-zoned.c | 30 ++++++++++++++++++++++++++++--=0A=
>>  1 file changed, 28 insertions(+), 2 deletions(-)=0A=
>>=0A=
>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
>> index 833978c02e60..990a36be2927 100644=0A=
>> --- a/block/blk-zoned.c=0A=
>> +++ b/block/blk-zoned.c=0A=
>> @@ -329,6 +329,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev=
, fmode_t mode,=0A=
>>         struct request_queue *q;=0A=
>>         struct blk_zone_range zrange;=0A=
>>         enum req_opf op;=0A=
>> +       sector_t capacity;=0A=
>> +       loff_t start, end;=0A=
>> +       int ret;=0A=
>>=0A=
>>         if (!argp)=0A=
>>                 return -EINVAL;=0A=
>> @@ -349,9 +352,22 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bde=
v, fmode_t mode,=0A=
>>         if (copy_from_user(&zrange, argp, sizeof(struct blk_zone_range))=
)=0A=
>>                 return -EFAULT;=0A=
>>=0A=
>> +       capacity =3D get_capacity(bdev->bd_disk);=0A=
>> +       if (zrange.sector + zrange.nr_sectors <=3D zrange.sector ||=0A=
>> +           zrange.sector + zrange.nr_sectors > capacity)=0A=
>> +               /* Out of range */=0A=
>> +               return -EINVAL;=0A=
>> +=0A=
>> +       start =3D zrange.sector << SECTOR_SHIFT;=0A=
>> +       end =3D ((zrange.sector + zrange.nr_sectors) << SECTOR_SHIFT) - =
1;=0A=
> =0A=
> How about doing all this calculation only when it is applicable i.e.=0A=
> only for reset-zone case, and not for other cases (open/close/finish=0A=
> zone).=0A=
> =0A=
> Also apart from "out of range" (which is covered here), there are few=0A=
> more cases when blkdev_zone_mgmt() may fail it (not covered here).=0A=
> Perhaps the whole pre and post truncate part can fit better inside=0A=
> blkdev_zone_mgmt itself.=0A=
=0A=
No, I do not think so. That would add overhead for in-kernel users of zone =
reset=0A=
for no good reason since these would typically take care of cached pages=0A=
themselves (e.g. FS) and would not trigger page caching using the bdev inod=
e anyway.=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
