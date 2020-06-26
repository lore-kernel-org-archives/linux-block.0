Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFD9C433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 00:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B302081A
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 00:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FtdiPkGJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="E8f5zi//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgFZA5t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 20:57:49 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:59336 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgFZA5s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 20:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593133076; x=1624669076;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Lzh+xF3ZKt96MNjMa9V+soRfoQVvQOOXw8iGWLc5ej4=;
  b=FtdiPkGJlGxYHu8NKaiLdUp85Arq3bzNSGx9p+YpNQ5YwlV9OzEz1+Ck
   3dLOrryx78FgoZs97qXC4jTrYLs6DwXXw9goe6tKaiKm6xTm1uadVL7uO
   iY6u3E7pB+GPokN+LRFmCsUCgQHA3ek1cyFDZ2mRUDefiGpp3Uv09a79k
   UBvCwkD/U4ClcuZW90nGx+G9jbIAigf/jrAtkXR5B1o1k2Gmjk6ZXCgtm
   kYMc4fPql7M5XRli7ydicZHIBkoUjPjKJT7KQDQRuyYS2yMddcJaRhDcc
   rGqpub/loa7o3NVW67MsECqqLjV3XKHFTaWsWZSL4wFYtRDOwGQ1IhUtI
   g==;
IronPort-SDR: 8LMsIgC3EK3xv0pPQd6fAeItxTUGIDcqVZzSxNUwldolgjKCrr85eV9Cnf5ZA9yP0kAOU5ru53
 GrekbNsRrsa83UDfcQE94kErDpfeQlaORnpwOaptz3PZeaz/Tv5jzNWI9jn9SnR9T0wnHSnpTx
 1O0ODGPzJemV+Va6LkznQwKovNnuDCOEbiPrLDw39mZ8lsNwAck8Tm+/9KUifteURwyN/Py6WO
 F7rljvIadOl6neOUXpdgwTkIk3abBgNc4uSPEVVVV80JY2QLcxhiAEMwQ+4l8tZT9D1Gto6i47
 3O4=
X-IronPort-AV: E=Sophos;i="5.75,281,1589212800"; 
   d="scan'208";a="243972068"
Received: from mail-sn1nam02lp2057.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.57])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 08:57:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeYyZ/X2turcSrRrU08eNLR0do5WEy6pYQXsSaBL4qXJo/DFKnn4L/SqV8PHTid6LH/HwoFlmzYIVu33d6L62JffQ7wrQySJOuuec6lccWyM15K3JxLbGVN1tilk2gk5dVIKXko307nc36/Q4xV538dkRLRqJ0QNGwbsM6atPvalTBjiAOMRtLv+GQSDISV9xqcXSnOXqEHnb/1jtHTPO+Buh6mDLQtrTNlIC+7OdiKB7n/eCVTn3NL3zF0DaXwi7P+cW79tEEKFi2oZ6NkPQo2wP4ZtNt0ZnOVOSSILdrgQ/25N+ox5SCy8Ks5AsEvuJdk1RmzpcSYS5GINsY+w5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7N53Y6KWBEUFLdteooV3bksCCcT/CmW7S5LRrWz3wbA=;
 b=Z9WNFBYkWyyFmrqkVxrkHclmSboOkmehcBvl3bVRhQX82UUYVFAgqwUt9flh7HhsBsveDdBal6iemGaeEolKTWrUhgxuYIDQj7y2m4SdnZIr7xA0bg8xFj4/hWcOJLtSpt1jIW+QViGsFtkwBU3k7whnhN9QI5hvt05CbdPkN+EpKBpqBzUcWarVcmPWt43Mr22YkJS3FkOdBTwM5gCjB+2WvKa6JtzdaRGNwWD9R77muXPMVl78U/V3JcMLqj/hqUw7lagpVPrZnkTVyxW7R5bsvPz9VsZ0/f1ttjFDI8zQYHZ4QMx9b1mRg07av07xZixS81rVdnDJ5/O8PPGAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7N53Y6KWBEUFLdteooV3bksCCcT/CmW7S5LRrWz3wbA=;
 b=E8f5zi//VJDMf9hJtVS1I4qI7rY//AA1AThvitKdsuNVuXytWNU+Lh2M0CAoAvEjBPT2ceN/e2xLLGHgXglopiQIjWtNHLl+T7zLlc+GQsHrUDBtwKQPrXSSAaKhA7sACaDIuNudZvIRCziGmsCWvv8iURx0Bq6qUsBsed6xPcs=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1257.namprd04.prod.outlook.com (2603:10b6:910:53::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.25; Fri, 26 Jun
 2020 00:57:45 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 00:57:44 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 4/6] block: introduce IOCTL to report dev properties
Thread-Topic: [PATCH 4/6] block: introduce IOCTL to report dev properties
Thread-Index: AQHWSutNlrk/U7ZovU6aHVaoqZz0nw==
Date:   Fri, 26 Jun 2020 00:57:44 +0000
Message-ID: <CY4PR04MB3751C079C5906D9F0D93F961E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-5-javier@javigon.com>
 <6333b2f1-a4f1-166f-5e0d-03f47389458a@lightnvm.io>
 <20200625194248.44rwwestffgz4jks@MacBook-Pro.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc2dc252-1747-4688-d9be-08d8196befed
x-ms-traffictypediagnostic: CY4PR04MB1257:
x-microsoft-antispam-prvs: <CY4PR04MB1257C9C15224F43B6FE9EF85E7930@CY4PR04MB1257.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hp6lhFVJCFgaWLIU6OsKz8nVKehxZGOhRpb7W39zoJrg/7Kp74C6IxqpN2KsVBgzyemDP8UO3Z5lb+O6CbPsidIyuZoX3VQvvDAl5Ho+nr6TOmS6uDPh8nlUiiCwcQlNHhpt8Zdn49grtt3R37jJu4Ch5cplpq7YYvSCC+vFRVTeVEn2U/Pa3dwsHjxx9QoLrXwoiYKqn1YraA44lgBeDgxoX1biB0M5nBrLor+k4ak5++YBI3mXrvp2xpakPqDIsSnMnxumoaTQxN6rMLCZz/de4kd+3Q3jI7kgd6bTa2Lvw/LbKm/Irej4olq0zEduoH0aA4hxznm3kgxB6ri7wQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(8676002)(8936002)(316002)(54906003)(478600001)(66574015)(30864003)(7696005)(83380400001)(7416002)(53546011)(33656002)(55016002)(66446008)(4326008)(76116006)(66476007)(52536014)(91956017)(66946007)(66556008)(64756008)(86362001)(2906002)(9686003)(26005)(71200400001)(110136005)(5660300002)(6506007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: YicK7VhyHv63Mk4OPW5H3Zb8pUoZpHEum/MzEqaW0oTnvt972cZJj71NQW0t93uLgVCBNKpJCXEnDNRUgBaJs9SX2sF5lvRrNsz2CU2qFND1DSMTkySxW+eDlcKqjbp8Jctf6sygAk6ZWQFhbYCVbmDpwiV9YFvuXXqYcVIUgPzZ4EMAaoxjgBx9U5Vjv41rJnak0CQJOkaYPUYtEI1hXk7Ct+aJoRddbRUcL+9jnfliKjOF51IBazmnAYY9gLcreVmAbwPu4/V/BEdyC22qCs9E8QBaC6Z86Nq6rxVZgdSWvMUzri/PwIXbGFFq6yADz1S77VAATMZxcl88yyj6ssio30TrnRjLSRMDCYFNf5l2+/wTvijlHMy+5GgfZDt4LsG10DHqINpMyNQdZ753NkJoqT6EnKrWVri9EFa++FkOdurVnqAFL2pE15/kvehiMNKVdPePLpbbyRXA+O0bKH7DGl8rr7if8WVXYKba7Xl/2+ColaexZR4JHy7sUlHE
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2dc252-1747-4688-d9be-08d8196befed
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 00:57:44.7833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UyMPmPyMh9/RLgTexSg2GGzI5BgAq0gqp1EJP32u7gxqJxh442LXgSLhNum+UftodoasXZmMzVpsoZVxvJyEAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1257
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/26 4:42, Javier Gonz=E1lez wrote:=0A=
> On 25.06.2020 15:10, Matias Bj=F8rling wrote:=0A=
>> On 25/06/2020 14.21, Javier Gonz=E1lez wrote:=0A=
>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>>=0A=
>>> With the addition of ZNS, a new set of properties have been added to th=
e=0A=
>>> zoned block device. This patch introduces a new IOCTL to expose these=
=0A=
>>> rroperties to user space.=0A=
>>>=0A=
>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>=0A=
>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
>>> ---=0A=
>>>  block/blk-zoned.c             | 46 ++++++++++++++++++++++++++=0A=
>>>  block/ioctl.c                 |  2 ++=0A=
>>>  drivers/nvme/host/core.c      |  2 ++=0A=
>>>  drivers/nvme/host/nvme.h      | 11 +++++++=0A=
>>>  drivers/nvme/host/zns.c       | 61 +++++++++++++++++++++++++++++++++++=
=0A=
>>>  include/linux/blkdev.h        |  9 ++++++=0A=
>>>  include/uapi/linux/blkzoned.h | 13 ++++++++=0A=
>>>  7 files changed, 144 insertions(+)=0A=
>>>=0A=
>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
>>> index 704fc15813d1..39ec72af9537 100644=0A=
>>> --- a/block/blk-zoned.c=0A=
>>> +++ b/block/blk-zoned.c=0A=
>>> @@ -169,6 +169,17 @@ int blkdev_report_zones(struct block_device *bdev,=
 sector_t sector,=0A=
>>>  }=0A=
>>>  EXPORT_SYMBOL_GPL(blkdev_report_zones);=0A=
>>> +static int blkdev_report_zonedev_prop(struct block_device *bdev,=0A=
>>> +				      struct blk_zone_dev *zprop)=0A=
>>> +{=0A=
>>> +	struct gendisk *disk =3D bdev->bd_disk;=0A=
>>> +=0A=
>>> +	if (WARN_ON_ONCE(!bdev->bd_disk->fops->report_zone_p))=0A=
>>> +		return -EOPNOTSUPP;=0A=
>>> +=0A=
>>> +	return disk->fops->report_zone_p(disk, zprop);=0A=
>>> +}=0A=
>>> +=0A=
>>>  static inline bool blkdev_allow_reset_all_zones(struct block_device *b=
dev,=0A=
>>>  						sector_t sector,=0A=
>>>  						sector_t nr_sectors)=0A=
>>> @@ -430,6 +441,41 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bd=
ev, fmode_t mode,=0A=
>>>  				GFP_KERNEL);=0A=
>>>  }=0A=
>>> +int blkdev_zonedev_prop(struct block_device *bdev, fmode_t mode,=0A=
>>> +			unsigned int cmd, unsigned long arg)=0A=
>>> +{=0A=
>>> +	void __user *argp =3D (void __user *)arg;=0A=
>>> +	struct request_queue *q;=0A=
>>> +	struct blk_zone_dev zprop;=0A=
>>> +	int ret;=0A=
>>> +=0A=
>>> +	if (!argp)=0A=
>>> +		return -EINVAL;=0A=
>>> +=0A=
>>> +	q =3D bdev_get_queue(bdev);=0A=
>>> +	if (!q)=0A=
>>> +		return -ENXIO;=0A=
>>> +=0A=
>>> +	if (!blk_queue_is_zoned(q))=0A=
>>> +		return -ENOTTY;=0A=
>>> +=0A=
>>> +	if (!capable(CAP_SYS_ADMIN))=0A=
>>> +		return -EACCES;=0A=
>>> +=0A=
>>> +	if (!(mode & FMODE_WRITE))=0A=
>>> +		return -EBADF;=0A=
>>> +=0A=
>>> +	ret =3D blkdev_report_zonedev_prop(bdev, &zprop);=0A=
>>> +	if (ret)=0A=
>>> +		goto out;=0A=
>>> +=0A=
>>> +	if (copy_to_user(argp, &zprop, sizeof(struct blk_zone_dev)))=0A=
>>> +		return -EFAULT;=0A=
>>> +=0A=
>>> +out:=0A=
>>> +	return ret;=0A=
>>> +}=0A=
>>> +=0A=
>>>  static inline unsigned long *blk_alloc_zone_bitmap(int node,=0A=
>>>  						   unsigned int nr_zones)=0A=
>>>  {=0A=
>>> diff --git a/block/ioctl.c b/block/ioctl.c=0A=
>>> index 0ea29754e7dd..f7b4e0f2dd4c 100644=0A=
>>> --- a/block/ioctl.c=0A=
>>> +++ b/block/ioctl.c=0A=
>>> @@ -517,6 +517,8 @@ static int blkdev_common_ioctl(struct block_device =
*bdev, fmode_t mode,=0A=
>>>  		return blkdev_zone_ops_ioctl(bdev, mode, cmd, arg);=0A=
>>>  	case BLKMGMTZONE:=0A=
>>>  		return blkdev_zone_mgmt_ioctl(bdev, mode, cmd, arg);=0A=
>>> +	case BLKZONEDEVPROP:=0A=
>>> +		return blkdev_zonedev_prop(bdev, mode, cmd, arg);=0A=
>>>  	case BLKGETZONESZ:=0A=
>>>  		return put_uint(argp, bdev_zone_sectors(bdev));=0A=
>>>  	case BLKGETNRZONES:=0A=
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
>>> index 5b95c81d2a2d..a32c909a915f 100644=0A=
>>> --- a/drivers/nvme/host/core.c=0A=
>>> +++ b/drivers/nvme/host/core.c=0A=
>>> @@ -2254,6 +2254,7 @@ static const struct block_device_operations nvme_=
fops =3D {=0A=
>>>  	.getgeo		=3D nvme_getgeo,=0A=
>>>  	.revalidate_disk=3D nvme_revalidate_disk,=0A=
>>>  	.report_zones	=3D nvme_report_zones,=0A=
>>> +	.report_zone_p	=3D nvme_report_zone_prop,=0A=
>>>  	.pr_ops		=3D &nvme_pr_ops,=0A=
>>>  };=0A=
>>> @@ -2280,6 +2281,7 @@ const struct block_device_operations nvme_ns_head=
_ops =3D {=0A=
>>>  	.compat_ioctl	=3D nvme_compat_ioctl,=0A=
>>>  	.getgeo		=3D nvme_getgeo,=0A=
>>>  	.report_zones	=3D nvme_report_zones,=0A=
>>> +	.report_zone_p	=3D nvme_report_zone_prop,=0A=
>>>  	.pr_ops		=3D &nvme_pr_ops,=0A=
>>>  };=0A=
>>>  #endif /* CONFIG_NVME_MULTIPATH */=0A=
>>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h=0A=
>>> index ecf443efdf91..172e0531f37f 100644=0A=
>>> --- a/drivers/nvme/host/nvme.h=0A=
>>> +++ b/drivers/nvme/host/nvme.h=0A=
>>> @@ -407,6 +407,14 @@ struct nvme_ns {=0A=
>>>  	u8 pi_type;=0A=
>>>  #ifdef CONFIG_BLK_DEV_ZONED=0A=
>>>  	u64 zsze;=0A=
>>> +=0A=
>>> +	u32 nr_zones;=0A=
>>> +	u32 mar;=0A=
>>> +	u32 mor;=0A=
>>> +	u32 rrl;=0A=
>>> +	u32 frl;=0A=
>>> +	u16 zoc;=0A=
>>> +	u16 ozcs;=0A=
>>>  #endif=0A=
>>>  	unsigned long features;=0A=
>>>  	unsigned long flags;=0A=
>>> @@ -704,11 +712,14 @@ int nvme_update_zone_info(struct gendisk *disk, s=
truct nvme_ns *ns,=0A=
>>>  int nvme_report_zones(struct gendisk *disk, sector_t sector,=0A=
>>>  		      unsigned int nr_zones, report_zones_cb cb, void *data);=0A=
>>> +int nvme_report_zone_prop(struct gendisk *disk, struct blk_zone_dev *z=
prop);=0A=
>>> +=0A=
>>>  blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct requ=
est *req,=0A=
>>>  				       struct nvme_command *cmnd,=0A=
>>>  				       enum nvme_zone_mgmt_action action);=0A=
>>>  #else=0A=
>>>  #define nvme_report_zones NULL=0A=
>>> +#define nvme_report_zone_prop NULL=0A=
>>>  static inline blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *n=
s,=0A=
>>>  		struct request *req, struct nvme_command *cmnd,=0A=
>>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c=0A=
>>> index 2e6512ac6f01..258d03610cc0 100644=0A=
>>> --- a/drivers/nvme/host/zns.c=0A=
>>> +++ b/drivers/nvme/host/zns.c=0A=
>>> @@ -32,6 +32,28 @@ static int nvme_set_max_append(struct nvme_ctrl *ctr=
l)=0A=
>>>  	return 0;=0A=
>>>  }=0A=
>>> +static u64 nvme_zns_nr_zones(struct nvme_ns *ns)=0A=
>>> +{=0A=
>>> +	struct nvme_command c =3D { };=0A=
>>> +	struct nvme_zone_report report;=0A=
>>> +	int buflen =3D sizeof(struct nvme_zone_report);=0A=
>>> +	int ret;=0A=
>>> +=0A=
>>> +	c.zmr.opcode =3D nvme_cmd_zone_mgmt_recv;=0A=
>>> +	c.zmr.nsid =3D cpu_to_le32(ns->head->ns_id);=0A=
>>> +	c.zmr.slba =3D cpu_to_le64(0);=0A=
>>> +	c.zmr.numd =3D cpu_to_le32(nvme_bytes_to_numd(buflen));=0A=
>>> +	c.zmr.zra =3D NVME_ZRA_ZONE_REPORT;=0A=
>>> +	c.zmr.zrasf =3D NVME_ZRASF_ZONE_REPORT_ALL;=0A=
>>> +	c.zmr.pr =3D 0;=0A=
>>> +=0A=
>>> +	ret =3D nvme_submit_sync_cmd(ns->queue, &c, &report, buflen);=0A=
>>> +	if (ret)=0A=
>>> +		return ret;=0A=
>>> +=0A=
>>> +	return le64_to_cpu(report.nr_zones);=0A=
>>> +}=0A=
>>> +=0A=
>>>  int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,=0A=
>>>  			  unsigned lbaf)=0A=
>>>  {=0A=
>>> @@ -87,6 +109,13 @@ int nvme_update_zone_info(struct gendisk *disk, str=
uct nvme_ns *ns,=0A=
>>>  		goto free_data;=0A=
>>>  	}=0A=
>>> +	ns->nr_zones =3D nvme_zns_nr_zones(ns);=0A=
>>> +	ns->mar =3D le32_to_cpu(id->mar);=0A=
>>> +	ns->mor =3D le32_to_cpu(id->mor);=0A=
>>> +	ns->rrl =3D le32_to_cpu(id->rrl);=0A=
>>> +	ns->frl =3D le32_to_cpu(id->frl);=0A=
>>> +	ns->zoc =3D le16_to_cpu(id->zoc);=0A=
>>> +=0A=
>>>  	q->limits.zoned =3D BLK_ZONED_HM;=0A=
>>>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);=0A=
>>>  free_data:=0A=
>>> @@ -230,6 +259,38 @@ int nvme_report_zones(struct gendisk *disk, sector=
_t sector,=0A=
>>>  	return ret;=0A=
>>>  }=0A=
>>> +static int nvme_ns_report_zone_prop(struct nvme_ns *ns, struct blk_zon=
e_dev *zprop)=0A=
>>> +{=0A=
>>> +	zprop->nr_zones =3D ns->nr_zones;=0A=
>>> +	zprop->zoc =3D ns->zoc;=0A=
>>> +	zprop->ozcs =3D ns->ozcs;=0A=
>>> +	zprop->mar =3D ns->mar;=0A=
>>> +	zprop->mor =3D ns->mor;=0A=
>>> +	zprop->rrl =3D ns->rrl;=0A=
>>> +	zprop->frl =3D ns->frl;=0A=
>>> +=0A=
>>> +	return 0;=0A=
>>> +}=0A=
>>> +=0A=
>>> +int nvme_report_zone_prop(struct gendisk *disk, struct blk_zone_dev *z=
prop)=0A=
>>> +{=0A=
>>> +	struct nvme_ns_head *head =3D NULL;=0A=
>>> +	struct nvme_ns *ns;=0A=
>>> +	int srcu_idx, ret;=0A=
>>> +=0A=
>>> +	ns =3D nvme_get_ns_from_disk(disk, &head, &srcu_idx);=0A=
>>> +	if (unlikely(!ns))=0A=
>>> +		return -EWOULDBLOCK;=0A=
>>> +=0A=
>>> +	if (ns->head->ids.csi =3D=3D NVME_CSI_ZNS)=0A=
>>> +		ret =3D nvme_ns_report_zone_prop(ns, zprop);=0A=
>>> +	else=0A=
>>> +		ret =3D -EINVAL;=0A=
>>> +	nvme_put_ns_from_disk(head, srcu_idx);=0A=
>>> +=0A=
>>> +	return ret;=0A=
>>> +}=0A=
>>> +=0A=
>>>  blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct requ=
est *req,=0A=
>>>  		struct nvme_command *c, enum nvme_zone_mgmt_action action)=0A=
>>>  {=0A=
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
>>> index 8308d8a3720b..0c0faa58b7f4 100644=0A=
>>> --- a/include/linux/blkdev.h=0A=
>>> +++ b/include/linux/blkdev.h=0A=
>>> @@ -372,6 +372,8 @@ extern int blkdev_zone_ops_ioctl(struct block_devic=
e *bdev, fmode_t mode,=0A=
>>>  				  unsigned int cmd, unsigned long arg);=0A=
>>>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t m=
ode,=0A=
>>>  				  unsigned int cmd, unsigned long arg);=0A=
>>> +extern int blkdev_zonedev_prop(struct block_device *bdev, fmode_t mode=
,=0A=
>>> +			unsigned int cmd, unsigned long arg);=0A=
>>>  #else /* CONFIG_BLK_DEV_ZONED */=0A=
>>>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)=0A=
>>> @@ -400,6 +402,12 @@ static inline int blkdev_zone_mgmt_ioctl(struct bl=
ock_device *bdev,=0A=
>>>  	return -ENOTTY;=0A=
>>>  }=0A=
>>> +static inline int blkdev_zonedev_prop(struct block_device *bdev, fmode=
_t mode,=0A=
>>> +				      unsigned int cmd, unsigned long arg)=0A=
>>> +{=0A=
>>> +	return -ENOTTY;=0A=
>>> +}=0A=
>>> +=0A=
>>>  #endif /* CONFIG_BLK_DEV_ZONED */=0A=
>>>  struct request_queue {=0A=
>>> @@ -1770,6 +1778,7 @@ struct block_device_operations {=0A=
>>>  	int (*report_zones)(struct gendisk *, sector_t sector,=0A=
>>>  			unsigned int nr_zones, report_zones_cb cb, void *data);=0A=
>>>  	char *(*devnode)(struct gendisk *disk, umode_t *mode);=0A=
>>> +	int (*report_zone_p)(struct gendisk *disk, struct blk_zone_dev *zprop=
);=0A=
>>>  	struct module *owner;=0A=
>>>  	const struct pr_ops *pr_ops;=0A=
>>>  };=0A=
>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzone=
d.h=0A=
>>> index d0978ee10fc7..0c49a4b2ce5d 100644=0A=
>>> --- a/include/uapi/linux/blkzoned.h=0A=
>>> +++ b/include/uapi/linux/blkzoned.h=0A=
>>> @@ -142,6 +142,18 @@ struct blk_zone_range {=0A=
>>>  	__u64		nr_sectors;=0A=
>>>  };=0A=
>>> +struct blk_zone_dev {=0A=
>>> +	__u32	nr_zones;=0A=
>>> +	__u32	mar;=0A=
>>> +	__u32	mor;=0A=
>>> +	__u32	rrl;=0A=
>>> +	__u32	frl;=0A=
>>> +	__u16	zoc;=0A=
>>> +	__u16	ozcs;=0A=
>>> +	__u32	rsv31[2];=0A=
>>> +	__u64	rsv63[4];=0A=
>>> +};=0A=
>>> +=0A=
>>>  /**=0A=
>>>   * enum blk_zone_action - Zone state transitions managed from user-spa=
ce=0A=
>>>   *=0A=
>>> @@ -209,5 +221,6 @@ struct blk_zone_mgmt {=0A=
>>>  #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)=0A=
>>>  #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)=0A=
>>>  #define BLKMGMTZONE	_IOR(0x12, 137, struct blk_zone_mgmt)=0A=
>>> +#define BLKZONEDEVPROP	_IOR(0x12, 138, struct blk_zone_dev)=0A=
>>>  #endif /* _UAPI_BLKZONED_H */=0A=
>>=0A=
>> Nak. These properties can already be retrieved using the nvme ioctl =0A=
>> passthru command and support have also been added to nvme-cli.=0A=
>>=0A=
> =0A=
> These properties are intended to be consumed by an application, so=0A=
> nvme-cli is of not much use. I would also like to avoid sysfs variables.=
=0A=
=0A=
Why not sysfs ? These are device properties, they can be defined as sysfs d=
evice=0A=
attributes. If there is an equivalent for ZBC/ZAC drives, you could even=0A=
consider defining them as queue attributes as long as you also patch sd.c, =
but=0A=
that may be pushing things too far.=0A=
=0A=
In any case, sysfs seems a much better approach to me as that would be limi=
ted=0A=
to the NVMe driver rather than all this additional code in the block layer.=
=0A=
=0A=
> =0A=
> We can use nvme passthru, but this bypasses the zoned block abstraction.=
=0A=
> Why not representing ZNS features in the standard zoned block API? I am=
=0A=
> happy to iterate on the actual implementation if you have feedback.=0A=
> =0A=
> Javier=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
