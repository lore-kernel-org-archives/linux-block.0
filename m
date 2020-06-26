Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC4AC433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 07:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C498207E8
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 07:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NDXexbq4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uKEmlmNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgFZHDX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:03:23 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:28646 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgFZHDW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 03:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593155001; x=1624691001;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8jAHWqrlQyNTj53ezyKk9zXuKUwWiQ5Exz3avj8hpW4=;
  b=NDXexbq44kXs3NreXujQMeWr3zZPAJdePThe+njN/gkfn5Y6VGYDLNzZ
   abhPgHmc9qCDT5AmK6S5tENRQ7/3rpbP22vO9MksA5HKplvHNylbuSSIT
   7brsI4GJpp/FaPJ4xaNu8oM/rKnr+UO9SFqUNZ1zSkF/Jp7JlnJ9wgc+V
   /IVLcArIs7yG4Rlz0MqByrzfSo4qDAbbQm9vDkDSiUi4KBShsIO3sAxTE
   b60nbMIP85oSet7QMrAliwlmizqLrQvrDLDfcYLgQHLbupVpkFkXck38u
   3yF6g9i8WuaemIIx5PFGvT7b6eY4Hn1xaSTVc/NGyRXkwhmyBpW+wF1Ca
   w==;
IronPort-SDR: d5oZ774jrqu/ILF6iH5j/6shUdeB2nIDg7Dw6fLAM485cqfVHT9bZ7bbg9LhFn2PeMFzR2wndr
 +UaRLTDMjmWR8BK8Mkyn5RT26N9Rs+NqKIYQZltobh6dbDwv96jTCfKZFXW3iPhAm94bUooyBC
 OBndaCxhr9vjnAbFxDbOkL0msOnFenw1M/ZT0NaCaDDv4USDB/tWZyZQ9pGtehpn6yJbTbRaNj
 eFe+Dgbx+L9ifYGHGlkNV5GJPXaNRiSfUhSB0u503XubIqXC2iawDKkpMt3HhtsmDyCwd9GeJu
 RRM=
X-IronPort-AV: E=Sophos;i="5.75,282,1589212800"; 
   d="scan'208";a="250205316"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 15:03:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htJR4yzezUoUfSiE661gfoeKgybi+VVshFyiy+GkyZe3xvEBrfrJdMtzwF/6l6mNLXmgQ/Vu8A4UcdRUO1pZbBV+shERqFYKv0KbuoPChB2EcafiJGNvkVSGyWZ6Lec/3OXDQlV+Ro4YVXm5f8JRuaydBH6L8VTyHwJBBs5aWh4X4I0jrnaY6RScWlKTR0mLpFTXC8h5+GSOfiV1Cbniy2uandAIFJUcp5bzUeponlz68l5zaC0sF3J4BsAJ8em3kKn+NEUglrK0kgt/xmx/1SPRaPO0AqXWb1wQI7BbUMastaPMOEQABfFKainDjy9aAQtzYaqQ4S3qAVAGR73wZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmKQAvWXr7UzjXdHq2nd6MFuBEVBcflkprpPUTVOWgs=;
 b=H0OirPGhwRcIYbFC0rXiZ0QkbfIvcX07rf4AnbbAWKa04/SOQdIoqlaSwpBb9++R960GLcLK06TzOAkkeqzwXb//WA2nZzbiTvUM1NQX+GnByTn/xN1Z5+Gz3tU3t4AyJAtt5vq8twj+ihEU3jAVLnx0Bv5IGWcxwmovs0Qk/OV9WjIHDhSUvhvLG2Xdc1Xkh+5O9QSk9Uvo+OtlgfGO4aqTK4CP7aJ57snFX3MyVqNv2+fOgOF8ugHTtoyNPr97fJsa/GUwJNRCaYt4xzmoGM+DT+/uaMBl7TZi7Vm/3Mxrdi0tKX9L2G16jsRje0nl4kKmFGf1bls4XT+kkeq03A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmKQAvWXr7UzjXdHq2nd6MFuBEVBcflkprpPUTVOWgs=;
 b=uKEmlmNtlreVfmet8OcgTtKb/p+bBXKYBzul1eWnLSpqIhWwjd3Gz4Puui4It0N3Dn5IS7TzFgUYtkZsnd+W5/NY3z3V/mvjsNiB4H223XczadfAVm44YpRZxw6ouLcPsCBuiCUGi/hCzYyddCcglORBKeAmAfzr16nxNrfpPg0=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0727.namprd04.prod.outlook.com (2603:10b6:903:e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Fri, 26 Jun
 2020 07:03:20 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 07:03:19 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 1/6] block: introduce IOCTL for zone mgmt
Thread-Topic: [PATCH 1/6] block: introduce IOCTL for zone mgmt
Thread-Index: AQHWSutOpOYox0Fba0KpyHzgytYs/A==
Date:   Fri, 26 Jun 2020 07:03:19 +0000
Message-ID: <CY4PR04MB3751C477970B556483800A1BE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-2-javier@javigon.com>
 <CY4PR04MB3751608EA9351354A614A0BFE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626060150.42yfebbyhh6ojf5u@mpHalley.localdomain>
 <CY4PR04MB37514A1058726B8681AE2501E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626065128.6x2csy5mjunjbr3t@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d49963bc-8d63-4a56-53a3-08d8199f0229
x-ms-traffictypediagnostic: CY4PR04MB0727:
x-microsoft-antispam-prvs: <CY4PR04MB0727AE7D60DDCC4EBCB4CBC3E7930@CY4PR04MB0727.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C7MLbknb0bVq4/1MfGgSY2oDmhK9o2F/8WvxtAE/aqJwMygezpusiq323/+rDDSYNPn0+8J6M6u2n1I5prEZ4NZKPAbmpZwRr5k4MfwT7hkXlp3oHj0DKKByJBBFwPlXi/DIOI3+6PENgBFjsxmaYWf2qVYIuzwMMdBYL/rN+Uvkb7qQNiljIYWUsJ1qjMJtaQgl5IGK0miDYXg2fyWxnE1lJ/lZCLFJ6nT9nBnvyNxSH+n13YsOiShDo+hUHgTnOWbHJaA7YEMjAiW4NIYhYuNrULkRlZ7o0/MjZ8kQ1Zu1SPMkfYU0Z7reZ6lWVmN4hXoVK1cF7QvwKuc9+IapDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(7696005)(54906003)(66946007)(91956017)(76116006)(2906002)(66446008)(64756008)(66556008)(66476007)(53546011)(6506007)(71200400001)(26005)(86362001)(6916009)(478600001)(4326008)(66574015)(83380400001)(9686003)(7416002)(8936002)(52536014)(8676002)(316002)(5660300002)(33656002)(55016002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nFqYZ3ytaGjjwpZJ0xyLH7I4sOMXGmIXa0d0mOeb4detqbAdY0zBCRzglMn9HLsTIKhPNoTRItH9LHgq0nPjXuK9EZDNK0h0uO5yPVqxrZmqs8lVmN3iT9+6JDOrNmky7hxS4pMBmwr4GYxGbUZMsMph9UXT9n5RspTkeJJ7AOcqlN0c7XhvBxHl2CP/lwhcMHy567jh9SX11Fr0gtALYdk8Zr8mRRJg8ykFnuzNg21tdFsrjWM6ycB63D0O+uO0hNyE6JuzDR2AEgh+xjt5C+TOyyDjX0YwrPC5P0fUUf4duUuAbyFBZIHn1Kt4KDr5D1B2s3AcMRPNnrfy/NpOFsuB2/PpUwUqc6phkyhwS5CYIipU8VUTS5V8SIwzRNl/xWm7qSqys/Y/tpG8+97BcSLGgwNQxPmvc7BOXWRGWrVVpUraKDUFQvGH1WRUS1PBXjiLOLi0ovfpPKDvLkoOizl2h8K4gSzYzcadFGItwmIKO6y5MK3RdrVSzPFL2eWV
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d49963bc-8d63-4a56-53a3-08d8199f0229
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 07:03:19.7963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NtmeCOpSdEvbJQwCosjRNzuwhPC8MLqhz8rQpYOm9eDNROFgTOSTieq7pirZRs6bKB7LhVJCVYxh1Vww92pZOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0727
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/26 15:51, Javier Gonz=E1lez wrote:=0A=
> On 26.06.2020 06:37, Damien Le Moal wrote:=0A=
>> On 2020/06/26 15:01, Javier Gonz=E1lez wrote:=0A=
>>> On 26.06.2020 01:17, Damien Le Moal wrote:=0A=
>>>> On 2020/06/25 21:22, Javier Gonz=E1lez wrote:=0A=
>>>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>>>>=0A=
>>>>> The current IOCTL interface for zone management is limited by struct=
=0A=
>>>>> blk_zone_range, which is unfortunately not extensible. Specially, the=
=0A=
>>>>> lack of flags is problematic for ZNS zoned devices.=0A=
>>>>>=0A=
>>>>> This new IOCTL is designed to be a superset of the current one, with=
=0A=
>>>>> support for flags and bits for extensibility.=0A=
>>>>>=0A=
>>>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>=0A=
>>>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
>>>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
>>>>> ---=0A=
>>>>>  block/blk-zoned.c             | 56 +++++++++++++++++++++++++++++++++=
+-=0A=
>>>>>  block/ioctl.c                 |  2 ++=0A=
>>>>>  include/linux/blkdev.h        |  9 ++++++=0A=
>>>>>  include/uapi/linux/blkzoned.h | 33 +++++++++++++++++++++=0A=
>>>>>  4 files changed, 99 insertions(+), 1 deletion(-)=0A=
>>>>>=0A=
>>>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
>>>>> index 81152a260354..e87c60004dc5 100644=0A=
>>>>> --- a/block/blk-zoned.c=0A=
>>>>> +++ b/block/blk-zoned.c=0A=
>>>>> @@ -322,7 +322,7 @@ int blkdev_report_zones_ioctl(struct block_device=
 *bdev, fmode_t mode,=0A=
>>>>>   * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE ioctl p=
rocessing.=0A=
>>>>>   * Called from blkdev_ioctl.=0A=
>>>>>   */=0A=
>>>>> -int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,=
=0A=
>>>>> +int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,=
=0A=
>>>>>  			   unsigned int cmd, unsigned long arg)=0A=
>>>>>  {=0A=
>>>>>  	void __user *argp =3D (void __user *)arg;=0A=
>>>>> @@ -370,6 +370,60 @@ int blkdev_zone_mgmt_ioctl(struct block_device *=
bdev, fmode_t mode,=0A=
>>>>>  				GFP_KERNEL);=0A=
>>>>>  }=0A=
>>>>>=0A=
>>>>> +/*=0A=
>>>>> + * Zone management ioctl processing. Extension of blkdev_zone_ops_io=
ctl(), with=0A=
>>>>> + * blk_zone_mgmt structure.=0A=
>>>>> + *=0A=
>>>>> + * Called from blkdev_ioctl.=0A=
>>>>> + */=0A=
>>>>> +int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,=
=0A=
>>>>> +			   unsigned int cmd, unsigned long arg)=0A=
>>>>> +{=0A=
>>>>> +	void __user *argp =3D (void __user *)arg;=0A=
>>>>> +	struct request_queue *q;=0A=
>>>>> +	struct blk_zone_mgmt zmgmt;=0A=
>>>>> +	enum req_opf op;=0A=
>>>>> +=0A=
>>>>> +	if (!argp)=0A=
>>>>> +		return -EINVAL;=0A=
>>>>> +=0A=
>>>>> +	q =3D bdev_get_queue(bdev);=0A=
>>>>> +	if (!q)=0A=
>>>>> +		return -ENXIO;=0A=
>>>>> +=0A=
>>>>> +	if (!blk_queue_is_zoned(q))=0A=
>>>>> +		return -ENOTTY;=0A=
>>>>> +=0A=
>>>>> +	if (!capable(CAP_SYS_ADMIN))=0A=
>>>>> +		return -EACCES;=0A=
>>>>> +=0A=
>>>>> +	if (!(mode & FMODE_WRITE))=0A=
>>>>> +		return -EBADF;=0A=
>>>>> +=0A=
>>>>> +	if (copy_from_user(&zmgmt, argp, sizeof(struct blk_zone_mgmt)))=0A=
>>>>> +		return -EFAULT;=0A=
>>>>> +=0A=
>>>>> +	switch (zmgmt.action) {=0A=
>>>>> +	case BLK_ZONE_MGMT_CLOSE:=0A=
>>>>> +		op =3D REQ_OP_ZONE_CLOSE;=0A=
>>>>> +		break;=0A=
>>>>> +	case BLK_ZONE_MGMT_FINISH:=0A=
>>>>> +		op =3D REQ_OP_ZONE_FINISH;=0A=
>>>>> +		break;=0A=
>>>>> +	case BLK_ZONE_MGMT_OPEN:=0A=
>>>>> +		op =3D REQ_OP_ZONE_OPEN;=0A=
>>>>> +		break;=0A=
>>>>> +	case BLK_ZONE_MGMT_RESET:=0A=
>>>>> +		op =3D REQ_OP_ZONE_RESET;=0A=
>>>>> +		break;=0A=
>>>>> +	default:=0A=
>>>>> +		return -ENOTTY;=0A=
>>>>> +	}=0A=
>>>>> +=0A=
>>>>> +	return blkdev_zone_mgmt(bdev, op, zmgmt.sector, zmgmt.nr_sectors,=
=0A=
>>>>> +				GFP_KERNEL);=0A=
>>>>> +}=0A=
>>>>> +=0A=
>>>>>  static inline unsigned long *blk_alloc_zone_bitmap(int node,=0A=
>>>>>  						   unsigned int nr_zones)=0A=
>>>>>  {=0A=
>>>>> diff --git a/block/ioctl.c b/block/ioctl.c=0A=
>>>>> index bdb3bbb253d9..0ea29754e7dd 100644=0A=
>>>>> --- a/block/ioctl.c=0A=
>>>>> +++ b/block/ioctl.c=0A=
>>>>> @@ -514,6 +514,8 @@ static int blkdev_common_ioctl(struct block_devic=
e *bdev, fmode_t mode,=0A=
>>>>>  	case BLKOPENZONE:=0A=
>>>>>  	case BLKCLOSEZONE:=0A=
>>>>>  	case BLKFINISHZONE:=0A=
>>>>> +		return blkdev_zone_ops_ioctl(bdev, mode, cmd, arg);=0A=
>>>>> +	case BLKMGMTZONE:=0A=
>>>>>  		return blkdev_zone_mgmt_ioctl(bdev, mode, cmd, arg);=0A=
>>>>>  	case BLKGETZONESZ:=0A=
>>>>>  		return put_uint(argp, bdev_zone_sectors(bdev));=0A=
>>>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
>>>>> index 8fd900998b4e..bd8521f94dc4 100644=0A=
>>>>> --- a/include/linux/blkdev.h=0A=
>>>>> +++ b/include/linux/blkdev.h=0A=
>>>>> @@ -368,6 +368,8 @@ int blk_revalidate_disk_zones(struct gendisk *dis=
k,=0A=
>>>>>=0A=
>>>>>  extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmod=
e_t mode,=0A=
>>>>>  				     unsigned int cmd, unsigned long arg);=0A=
>>>>> +extern int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t =
mode,=0A=
>>>>> +				  unsigned int cmd, unsigned long arg);=0A=
>>>>>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t=
 mode,=0A=
>>>>>  				  unsigned int cmd, unsigned long arg);=0A=
>>>>>=0A=
>>>>> @@ -385,6 +387,13 @@ static inline int blkdev_report_zones_ioctl(stru=
ct block_device *bdev,=0A=
>>>>>  	return -ENOTTY;=0A=
>>>>>  }=0A=
>>>>>=0A=
>>>>> +=0A=
>>>>> +static inline int blkdev_zone_ops_ioctl(struct block_device *bdev, f=
mode_t mode,=0A=
>>>>> +					unsigned int cmd, unsigned long arg)=0A=
>>>>> +{=0A=
>>>>> +	return -ENOTTY;=0A=
>>>>> +}=0A=
>>>>> +=0A=
>>>>>  static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,=
=0A=
>>>>>  					 fmode_t mode, unsigned int cmd,=0A=
>>>>>  					 unsigned long arg)=0A=
>>>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzo=
ned.h=0A=
>>>>> index 42c3366cc25f..07b5fde21d9f 100644=0A=
>>>>> --- a/include/uapi/linux/blkzoned.h=0A=
>>>>> +++ b/include/uapi/linux/blkzoned.h=0A=
>>>>> @@ -142,6 +142,38 @@ struct blk_zone_range {=0A=
>>>>>  	__u64		nr_sectors;=0A=
>>>>>  };=0A=
>>>>>=0A=
>>>>> +/**=0A=
>>>>> + * enum blk_zone_action - Zone state transitions managed from user-s=
pace=0A=
>>>>> + *=0A=
>>>>> + * @BLK_ZONE_MGMT_CLOSE: Transition to Closed state=0A=
>>>>> + * @BLK_ZONE_MGMT_FINISH: Transition to Finish state=0A=
>>>>> + * @BLK_ZONE_MGMT_OPEN: Transition to Open state=0A=
>>>>> + * @BLK_ZONE_MGMT_RESET: Transition to Reset state=0A=
>>>>> + */=0A=
>>>>> +enum blk_zone_action {=0A=
>>>>> +	BLK_ZONE_MGMT_CLOSE	=3D 0x1,=0A=
>>>>> +	BLK_ZONE_MGMT_FINISH	=3D 0x2,=0A=
>>>>> +	BLK_ZONE_MGMT_OPEN	=3D 0x3,=0A=
>>>>> +	BLK_ZONE_MGMT_RESET	=3D 0x4,=0A=
>>>>> +};=0A=
>>>>> +=0A=
>>>>> +/**=0A=
>>>>> + * struct blk_zone_mgmt - Extended zoned management=0A=
>>>>> + *=0A=
>>>>> + * @action: Zone action as in described in enum blk_zone_action=0A=
>>>>> + * @flags: Flags for the action=0A=
>>>>> + * @sector: Starting sector of the first zone to operate on=0A=
>>>>> + * @nr_sectors: Total number of sectors of all zones to operate on=
=0A=
>>>>> + */=0A=
>>>>> +struct blk_zone_mgmt {=0A=
>>>>> +	__u8		action;=0A=
>>>>> +	__u8		resv3[3];=0A=
>>>>> +	__u32		flags;=0A=
>>>>> +	__u64		sector;=0A=
>>>>> +	__u64		nr_sectors;=0A=
>>>>> +	__u64		resv31;=0A=
>>>>> +};=0A=
>>>>> +=0A=
>>>>>  /**=0A=
>>>>>   * Zoned block device ioctl's:=0A=
>>>>>   *=0A=
>>>>> @@ -166,5 +198,6 @@ struct blk_zone_range {=0A=
>>>>>  #define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)=0A=
>>>>>  #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)=0A=
>>>>>  #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)=0A=
>>>>> +#define BLKMGMTZONE	_IOR(0x12, 137, struct blk_zone_mgmt)=0A=
>>>>>=0A=
>>>>>  #endif /* _UAPI_BLKZONED_H */=0A=
>>>>>=0A=
>>>>=0A=
>>>> Without defining what the flags can be, it is hard to judge what will =
change=0A=
>>> >from the current distinct ioctls.=0A=
>>>>=0A=
>>>=0A=
>>> The first flag is the one to select all. Down the line we have other=0A=
>>> modifiers that make sense, but it is true that it is public yet.=0A=
>>=0A=
>> You mean *not* public ?=0A=
> =0A=
> Yes...=0A=
> =0A=
>>=0A=
>>>=0A=
>>> Would you like to wait until then or is it an option to revise the IOCT=
L=0A=
>>> now?=0A=
>>=0A=
>> Yes. Wait until it is actually needed. Adding code that has no users mak=
es it=0A=
>> impossible to test so not acceptable. As for the "all zones" flag, I alr=
eady=0A=
>> commented about it.=0A=
> =0A=
> Ok. We will have this in the backlog then.=0A=
> =0A=
> It would be great if you and Matias would like to comment on it if you=0A=
> have some ideas on how to improve it. Happy to set a branch somewhere to=
=0A=
> keep a patchset with this functionality somewhere.=0A=
=0A=
I sent a much simpler version of this using a REQ_ZONE_ALL flag too, but dr=
iven=0A=
by the specified sector range. That allowed to do reset, open, close, finis=
h all=0A=
zones using a single command much more simply than your patch. But as Chris=
toph=0A=
commented, the only real use case interesting for this is reset all (e.g. f=
or FS=0A=
format). open, close and finish all zones have no user...=0A=
=0A=
Let's see first what kind of flags may be needed in the future, if at all. =
We=0A=
can then cook something if needed.=0A=
=0A=
> =0A=
> Javier=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
