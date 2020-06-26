Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA68FC433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E3E42076E
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QrKmivB9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jzX0O7ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgFZGhh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:37:37 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17496 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgFZGhg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 02:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593153456; x=1624689456;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=as3440I8sQn7O0a3MUuRQmjClzRoGiojyqYdUuawvQw=;
  b=QrKmivB9mbhjqtCHRQJVA/McuKBqhHRoem0SxamXglukW+BntPYUe4Bx
   3Msm6dHsA+lRGuksPFS32kRcPAj9FEcXjyG4mtZeEi68bupXsl3Dqb8DX
   MyluEtimrme8SCS4DK7/R5qKHXQAi3LTmmeuSUhxjlvK77euIRGqyMa1L
   bWFFhFAaI987CimF5OiOT6PwQGE3IM0mY675VDarYTrGaG0hZ5aum0pE3
   1+FJE/IeGC60FRgmIbJsb4sBluESe0NH/G1WWTJhXysQDww+qib+tH6uW
   jVR6Ww2KIRsPUxS1ueWhlZADxD4WK0z7WEfMySCJz1K0oR0biLnXzHmzZ
   A==;
IronPort-SDR: UMEmyMTJZjc9Q3/qybNxD/bVMhAICiubZb+4HLOa4rRAE1LzS8KN3IxU5usk1OaASlvOpmfmID
 NYRyopBiGtL+8mgESrH2Bzd4ORGL51tJAkQZfkBlB6cREarG1Et3eq2Rgg4KgHAGhiR6iBSbMG
 E3m2NLFFDBTsahWfJezxKl59P7hGWWGwdO/3qkPF8AY5G/UNftM8f+NY55827lPZLvwI0hr6hp
 ZzhgvUnCB1idyS9lZiqeS2gWSqp/yks6DO4XWb1SukFAtVPde5f84tro+EqONPi7h4zok8iAYK
 jq8=
X-IronPort-AV: E=Sophos;i="5.75,282,1589212800"; 
   d="scan'208";a="145304787"
Received: from mail-bn3nam04lp2053.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.53])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 14:37:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTAjvD3SMyA3eFVUTNe1zfs93HNhAHU8tiALhW+v87APVYG7JKdBWRA0hA4iyFZ8/X1TPxOKUK7BKjwhPXC7ZPqiDqc39pP2Wtr5i3D7M2YeKWIf3dX4YJMACT4hAgVwIC0KVqGZp4NlloBst7j3LMPEGLRw9UiNYybpVUyu9rmm4Vi6LxNs1O6XaHnxojYuHDad9CY6DbyP/ZxqxziNDRf1Fry2HQwIZ9cfQ1/j3SfmIHXa0gz0wpy0oZGzBIforFay786XI94RmdlHlOnwn5XgIFFejhPvHMXN7CgKwaFTeMUodltFCPGLJEv23jOG7LYfWjF0rpGEFkqhAz207Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj7gS4hS0eiNiG/9xfiOiW8s/AQKHxVrlyQyH/lgNIY=;
 b=K9pUdxojhMk+5zbaFdkzYrm8KGXWtSo1Oby9kA/8ImjS/6ohS6we+axk6Ak2Cfi9b2FTMLWCQxr3X1zATk24ogh/iEHJXlZ4CcQz+6ydlzA5noo1m1cv9YI80ikcEioww0yFYc2eAy5S2dXkHvQqU+4Jra8twCZ2fwqBeThQTzlSqn6Xo/Ir1S1dA+YO4VsdOqQtnFHcibhDc2UrkYEehSYomwerrSY7iHffznTdBInzNl0TaONDCi9/7iF+AhFhvPb6gpyehBngoBenTSOD5O2xsBI8k7Jv1XXVCzvbJGdsCFESDJmG2xhOcDGlihcjfOms8Iy0Q+fidW6WJlL1/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj7gS4hS0eiNiG/9xfiOiW8s/AQKHxVrlyQyH/lgNIY=;
 b=jzX0O7keze6bdUsTda9cwPlJKovO6qG63bH8t9/plGh0+36SueXfMLkjShgoyn1zLinQuPrz3mx4Hae7aFawTMe6sdAKZx2ysrouPN75Rk5uCL+3KynRzwE/HpQPj+TiBfO/GAbIjiA9WaJbIsmEuUtNssY0LDKhW0qeRntunPM=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY1PR04MB2316.namprd04.prod.outlook.com (2a01:111:e400:c618::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 26 Jun
 2020 06:37:33 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 06:37:33 +0000
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
Date:   Fri, 26 Jun 2020 06:37:33 +0000
Message-ID: <CY4PR04MB37514A1058726B8681AE2501E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-2-javier@javigon.com>
 <CY4PR04MB3751608EA9351354A614A0BFE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626060150.42yfebbyhh6ojf5u@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 252aa010-14c9-4dfe-a493-08d8199b684e
x-ms-traffictypediagnostic: CY1PR04MB2316:
x-microsoft-antispam-prvs: <CY1PR04MB2316C4A2A304D51091F01599E7930@CY1PR04MB2316.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TyFd2izqft+zLaabiFZ4kgEC/St3DYdKbGK7+y5FB6eq0QHGONJ8WUGK+RS94hMpT24sZQYcLu6KxoIrtb/hpe4RhM5Cukn5TOejb06es1BhpW7/DY/g2fzhJxWJwuYzkZ+aRijAsQk4C+tBuEh8T01UxC7nvxtKp4rwru8bXfmUJzu+6LL7NPZlPyQbjrmYCewnSizV5Tsdom0uNCy5jreiApDR6MUv4S2tfVTdh2sUrWiIpkGBTDfDC6qETkSFviufRB8GHnnMBiWlvinOaXXUubLQhtqxUhOKjCHkQgGtOMqUzgxZ7VWVPA0i8RiAfuz6SU9p88YVhvHeKwld5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(6916009)(53546011)(8676002)(86362001)(66556008)(71200400001)(66446008)(316002)(64756008)(66946007)(66476007)(66574015)(4326008)(6506007)(2906002)(83380400001)(7696005)(26005)(8936002)(186003)(33656002)(7416002)(54906003)(478600001)(9686003)(76116006)(5660300002)(55016002)(91956017)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Esgazi9NDde4y9+EHp0R7rqEsqOxTlQLjFg707B3Afzxz3od6tt3fNcpTuJ6uq9vnNOOXnUpCI0+vAkoAfNUq00tClUP8+fvWxjO7VvOJtm2LGuFlUlQUn/g/4x6m+iBfZkQmTOIfZjo0N8Mg0Z7hUD5Wd8UDzJbgRxgJP6yWzS55QjEIGNiWBE9H872m0CV68iDHFVNW7iVxUiSEf6nelrCHmmiTI87lk/h4KyndSwVSCg1Z0hF1vhQmUdIGIOBqY/00e30r7G74W10Jn4snVquBd6l1H6psZysJylp8jQm3nymbWbvyscrIjK3YfsKXJzg0ElqvlIVhfEuLRQC9t5+15XN97EGJsB8G8oWo+SblvxTAD+Pskbft/mT9WZVf0F7wEz60NzySzaw3B1VWDqOkOxny/9hFoZvNEYMhrZqcJSZn0DpFUOi4FB+dB1YziWCVbunGeyS6Nz+GUiPrN9rGgwnMwyaaVnlIeyHxIj9suu7+9w5OQ6lM2fg7n10
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252aa010-14c9-4dfe-a493-08d8199b684e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 06:37:33.2605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RlzXGXUaUDVOlXbe9gksVRoz0vIzWTIHH5PKQ5CYjcQ9Gp0PKwnfh0RZw8UYE0ywpxGvUjR4UNOFZ07+PZ8BCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2316
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/26 15:01, Javier Gonz=E1lez wrote:=0A=
> On 26.06.2020 01:17, Damien Le Moal wrote:=0A=
>> On 2020/06/25 21:22, Javier Gonz=E1lez wrote:=0A=
>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>>=0A=
>>> The current IOCTL interface for zone management is limited by struct=0A=
>>> blk_zone_range, which is unfortunately not extensible. Specially, the=
=0A=
>>> lack of flags is problematic for ZNS zoned devices.=0A=
>>>=0A=
>>> This new IOCTL is designed to be a superset of the current one, with=0A=
>>> support for flags and bits for extensibility.=0A=
>>>=0A=
>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>=0A=
>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
>>> ---=0A=
>>>  block/blk-zoned.c             | 56 ++++++++++++++++++++++++++++++++++-=
=0A=
>>>  block/ioctl.c                 |  2 ++=0A=
>>>  include/linux/blkdev.h        |  9 ++++++=0A=
>>>  include/uapi/linux/blkzoned.h | 33 +++++++++++++++++++++=0A=
>>>  4 files changed, 99 insertions(+), 1 deletion(-)=0A=
>>>=0A=
>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
>>> index 81152a260354..e87c60004dc5 100644=0A=
>>> --- a/block/blk-zoned.c=0A=
>>> +++ b/block/blk-zoned.c=0A=
>>> @@ -322,7 +322,7 @@ int blkdev_report_zones_ioctl(struct block_device *=
bdev, fmode_t mode,=0A=
>>>   * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE ioctl pro=
cessing.=0A=
>>>   * Called from blkdev_ioctl.=0A=
>>>   */=0A=
>>> -int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,=0A=
>>> +int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,=0A=
>>>  			   unsigned int cmd, unsigned long arg)=0A=
>>>  {=0A=
>>>  	void __user *argp =3D (void __user *)arg;=0A=
>>> @@ -370,6 +370,60 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bd=
ev, fmode_t mode,=0A=
>>>  				GFP_KERNEL);=0A=
>>>  }=0A=
>>>=0A=
>>> +/*=0A=
>>> + * Zone management ioctl processing. Extension of blkdev_zone_ops_ioct=
l(), with=0A=
>>> + * blk_zone_mgmt structure.=0A=
>>> + *=0A=
>>> + * Called from blkdev_ioctl.=0A=
>>> + */=0A=
>>> +int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,=0A=
>>> +			   unsigned int cmd, unsigned long arg)=0A=
>>> +{=0A=
>>> +	void __user *argp =3D (void __user *)arg;=0A=
>>> +	struct request_queue *q;=0A=
>>> +	struct blk_zone_mgmt zmgmt;=0A=
>>> +	enum req_opf op;=0A=
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
>>> +	if (copy_from_user(&zmgmt, argp, sizeof(struct blk_zone_mgmt)))=0A=
>>> +		return -EFAULT;=0A=
>>> +=0A=
>>> +	switch (zmgmt.action) {=0A=
>>> +	case BLK_ZONE_MGMT_CLOSE:=0A=
>>> +		op =3D REQ_OP_ZONE_CLOSE;=0A=
>>> +		break;=0A=
>>> +	case BLK_ZONE_MGMT_FINISH:=0A=
>>> +		op =3D REQ_OP_ZONE_FINISH;=0A=
>>> +		break;=0A=
>>> +	case BLK_ZONE_MGMT_OPEN:=0A=
>>> +		op =3D REQ_OP_ZONE_OPEN;=0A=
>>> +		break;=0A=
>>> +	case BLK_ZONE_MGMT_RESET:=0A=
>>> +		op =3D REQ_OP_ZONE_RESET;=0A=
>>> +		break;=0A=
>>> +	default:=0A=
>>> +		return -ENOTTY;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	return blkdev_zone_mgmt(bdev, op, zmgmt.sector, zmgmt.nr_sectors,=0A=
>>> +				GFP_KERNEL);=0A=
>>> +}=0A=
>>> +=0A=
>>>  static inline unsigned long *blk_alloc_zone_bitmap(int node,=0A=
>>>  						   unsigned int nr_zones)=0A=
>>>  {=0A=
>>> diff --git a/block/ioctl.c b/block/ioctl.c=0A=
>>> index bdb3bbb253d9..0ea29754e7dd 100644=0A=
>>> --- a/block/ioctl.c=0A=
>>> +++ b/block/ioctl.c=0A=
>>> @@ -514,6 +514,8 @@ static int blkdev_common_ioctl(struct block_device =
*bdev, fmode_t mode,=0A=
>>>  	case BLKOPENZONE:=0A=
>>>  	case BLKCLOSEZONE:=0A=
>>>  	case BLKFINISHZONE:=0A=
>>> +		return blkdev_zone_ops_ioctl(bdev, mode, cmd, arg);=0A=
>>> +	case BLKMGMTZONE:=0A=
>>>  		return blkdev_zone_mgmt_ioctl(bdev, mode, cmd, arg);=0A=
>>>  	case BLKGETZONESZ:=0A=
>>>  		return put_uint(argp, bdev_zone_sectors(bdev));=0A=
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
>>> index 8fd900998b4e..bd8521f94dc4 100644=0A=
>>> --- a/include/linux/blkdev.h=0A=
>>> +++ b/include/linux/blkdev.h=0A=
>>> @@ -368,6 +368,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk,=
=0A=
>>>=0A=
>>>  extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_=
t mode,=0A=
>>>  				     unsigned int cmd, unsigned long arg);=0A=
>>> +extern int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mo=
de,=0A=
>>> +				  unsigned int cmd, unsigned long arg);=0A=
>>>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t m=
ode,=0A=
>>>  				  unsigned int cmd, unsigned long arg);=0A=
>>>=0A=
>>> @@ -385,6 +387,13 @@ static inline int blkdev_report_zones_ioctl(struct=
 block_device *bdev,=0A=
>>>  	return -ENOTTY;=0A=
>>>  }=0A=
>>>=0A=
>>> +=0A=
>>> +static inline int blkdev_zone_ops_ioctl(struct block_device *bdev, fmo=
de_t mode,=0A=
>>> +					unsigned int cmd, unsigned long arg)=0A=
>>> +{=0A=
>>> +	return -ENOTTY;=0A=
>>> +}=0A=
>>> +=0A=
>>>  static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,=0A=
>>>  					 fmode_t mode, unsigned int cmd,=0A=
>>>  					 unsigned long arg)=0A=
>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzone=
d.h=0A=
>>> index 42c3366cc25f..07b5fde21d9f 100644=0A=
>>> --- a/include/uapi/linux/blkzoned.h=0A=
>>> +++ b/include/uapi/linux/blkzoned.h=0A=
>>> @@ -142,6 +142,38 @@ struct blk_zone_range {=0A=
>>>  	__u64		nr_sectors;=0A=
>>>  };=0A=
>>>=0A=
>>> +/**=0A=
>>> + * enum blk_zone_action - Zone state transitions managed from user-spa=
ce=0A=
>>> + *=0A=
>>> + * @BLK_ZONE_MGMT_CLOSE: Transition to Closed state=0A=
>>> + * @BLK_ZONE_MGMT_FINISH: Transition to Finish state=0A=
>>> + * @BLK_ZONE_MGMT_OPEN: Transition to Open state=0A=
>>> + * @BLK_ZONE_MGMT_RESET: Transition to Reset state=0A=
>>> + */=0A=
>>> +enum blk_zone_action {=0A=
>>> +	BLK_ZONE_MGMT_CLOSE	=3D 0x1,=0A=
>>> +	BLK_ZONE_MGMT_FINISH	=3D 0x2,=0A=
>>> +	BLK_ZONE_MGMT_OPEN	=3D 0x3,=0A=
>>> +	BLK_ZONE_MGMT_RESET	=3D 0x4,=0A=
>>> +};=0A=
>>> +=0A=
>>> +/**=0A=
>>> + * struct blk_zone_mgmt - Extended zoned management=0A=
>>> + *=0A=
>>> + * @action: Zone action as in described in enum blk_zone_action=0A=
>>> + * @flags: Flags for the action=0A=
>>> + * @sector: Starting sector of the first zone to operate on=0A=
>>> + * @nr_sectors: Total number of sectors of all zones to operate on=0A=
>>> + */=0A=
>>> +struct blk_zone_mgmt {=0A=
>>> +	__u8		action;=0A=
>>> +	__u8		resv3[3];=0A=
>>> +	__u32		flags;=0A=
>>> +	__u64		sector;=0A=
>>> +	__u64		nr_sectors;=0A=
>>> +	__u64		resv31;=0A=
>>> +};=0A=
>>> +=0A=
>>>  /**=0A=
>>>   * Zoned block device ioctl's:=0A=
>>>   *=0A=
>>> @@ -166,5 +198,6 @@ struct blk_zone_range {=0A=
>>>  #define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)=0A=
>>>  #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)=0A=
>>>  #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)=0A=
>>> +#define BLKMGMTZONE	_IOR(0x12, 137, struct blk_zone_mgmt)=0A=
>>>=0A=
>>>  #endif /* _UAPI_BLKZONED_H */=0A=
>>>=0A=
>>=0A=
>> Without defining what the flags can be, it is hard to judge what will ch=
ange=0A=
>>from the current distinct ioctls.=0A=
>>=0A=
> =0A=
> The first flag is the one to select all. Down the line we have other=0A=
> modifiers that make sense, but it is true that it is public yet.=0A=
=0A=
You mean *not* public ?=0A=
=0A=
> =0A=
> Would you like to wait until then or is it an option to revise the IOCTL=
=0A=
> now?=0A=
=0A=
Yes. Wait until it is actually needed. Adding code that has no users makes =
it=0A=
impossible to test so not acceptable. As for the "all zones" flag, I alread=
y=0A=
commented about it.=0A=
=0A=
> =0A=
> Javier=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
