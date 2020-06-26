Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B27C433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 01:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A95120767
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 01:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GHx5TEnC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="npn3+0ww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgFZBRQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 21:17:16 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:11385 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgFZBRP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 21:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593134234; x=1624670234;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bJXHvcdUoSzIk7IWH5s7MMz8eci84GOPeS1uz71LpGA=;
  b=GHx5TEnCu+0gpMseUbTYBCu8FY7yvve4tMpt6GNQ2iRnuaJXJTtBPfkN
   uJlGfbbdLTrBtncINmoBns+hZXsnF/VRRieIj7zoBM9x86yxesuvTKMay
   ZYY6MiWm6RP7j+FgmxWNF58d10uIgF8pSeesburShETdKOn+Mc072ieMr
   ipFs/no0fZrpNIs6FhlYZLLmL7rWKd43A/SyNp6BjVGgdyJakkp7A2oMb
   et4RuvmSiVfs8nmTJJ3laee8vhx7LZoXa0RSpTPJEGfida4D13jVIYFtd
   FNboZKoj1SkKLLFMfqKibEsJbvMNpFs0EiJfWKY6k5KunYW8BwZph2JE/
   Q==;
IronPort-SDR: ymNwLH7rrpXBeXwV7yFbP6EMteWuO4KNXNiquAmnFxLOrDNGvRjBx20vozUxA1f0Lf1C4rDp7E
 XXnWzIWA5JbhGxuNs/sGwwrYV6V6CH/ueWbvrg2eDx+8/+VGJO5tOke0GyJiO2ZoOIFpEnLgFt
 RSiVdSzUM0XSk8OgyvWFKP9Fme6jIL8ANGNjHoyZ5sHCJ9TEKfJJ8yP2Qaokt8DXJmTdmQ8DIl
 8iDoVRIWdEKE3U+zCkFZCTS9iFWEWMb1vHqOCShhcefxTMz3lpPQqjcfmGrdtMIPugJppGAYYS
 rNw=
X-IronPort-AV: E=Sophos;i="5.75,281,1589212800"; 
   d="scan'208";a="140960922"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 09:17:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvjPpNPukvZgjeneHgJqLPPPNwA4PDRkKCgKnrFLHttmjCLGpEHdFLSPokx0RY+5jMhrQLFW93YAY7P1eeKhLyUHpRt8/DpaUsHpZZ4CN9w+2JBJceynk30LL6YyWvrfG4SqFfXxJ9HRyi2VTj/D2Qxt+xhtOK/Ks7xaUMS4FFaqMl9pNjkqBGpsHS/985Av984R5JY+viFJbRDiWL/3MD+T7AM1uqu6JpBONAK+65/TPjYFlpzItqF+DfH0VMMnHLWhrrRGsJHdIl7zdwLzDuGWNWOSfT8NpAeAHNObLKPfuG5HJkVnhgolYx0BYB/yJoeqFxO842N5Q593Wp0x4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkStGiqiuhg9Ea+lmXdyQwNA1TwYFIAL5r8wm6OXiSc=;
 b=E2Zbh/tQdgTTefnAJO3Vx+62eUd7DQ5yl6lGWRIiZdsjmsCtiSOOnZ47hLVITvNa5+xTEXm5xe1dftIGLX8tq3N0zge9VGUyLcVhxlhh5l2o4xS1uMXuIgM3wJ7JF3QPCxLLb8T8lyoukilJOYDXRCzD78HY0nDY7iglkS10VS4oLOcTZEFBY14ZF89QSkWDVDaUjyVm58X5onVUXznW1P7Ih+R8OfRDDOJRiBC/53bOmo85d3GuKbbXXhDp7JiOF4tv6Bo/ufMxq5XKyLtOlWMnM014TM1WHekczt63pPjE8Z1vDguzYw8q6ku3EQYTwhviXszkWfO/Mvq27pKbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkStGiqiuhg9Ea+lmXdyQwNA1TwYFIAL5r8wm6OXiSc=;
 b=npn3+0ww23pz3Wn8gkNWD1J6nwYGk5qGodTRbjMKTTwyhZymkKy08QGUZD840TcxoNB7+y80l32OXxsfLA/WNaivXx6ubfTMSJPI96+wKLNeiJu24+/L0U+vtAI1u65alwojOjH1XEPV2mWkwrtk3EvmdWF9m14qTYtJDt1VtKM=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0726.namprd04.prod.outlook.com (2603:10b6:903:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 26 Jun
 2020 01:17:11 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 01:17:11 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 1/6] block: introduce IOCTL for zone mgmt
Thread-Topic: [PATCH 1/6] block: introduce IOCTL for zone mgmt
Thread-Index: AQHWSutOpOYox0Fba0KpyHzgytYs/A==
Date:   Fri, 26 Jun 2020 01:17:11 +0000
Message-ID: <CY4PR04MB3751608EA9351354A614A0BFE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-2-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb2419e3-3039-4faf-b243-08d8196ea76a
x-ms-traffictypediagnostic: CY4PR04MB0726:
x-microsoft-antispam-prvs: <CY4PR04MB07260AAEF11D610AD0CECF5BE7930@CY4PR04MB0726.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Zik7oGIYXstq9DDV2/HrtM5foi1GA1jM5SIze2aMjzbkpO2iz1UhjJF7Tyj7uw/RcVwzv838rTpCaiMq2jpsENeDFjdodZGT1XeorfTTd/tmHf6Z4bcQuV+Df/RpzpXchtLij5M7aBRv7VGdyT78rdcKi3l0MCdSGZ31g2VRCxjydEUreKUHlrZGgjHqaJJpkMkdgPmtTOP5kYGQD37/XJWwKu0v4x3b2sfiFXJHTbS8lBfbrLyMM8hYBsYa36VTumwl6ttaSjVmbfZmVkwXOtwFpbEQ2ThPC/3TTE8IrEvcfGYwmOm4D2Au1yGuOI3G9dcDNlMUFgqPfxcLw/B9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(53546011)(52536014)(33656002)(83380400001)(54906003)(110136005)(71200400001)(316002)(478600001)(66446008)(8936002)(66946007)(26005)(86362001)(64756008)(7416002)(66556008)(9686003)(6506007)(5660300002)(8676002)(186003)(66476007)(91956017)(7696005)(66574015)(76116006)(4326008)(2906002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CLQn5dmiul5Yg20uim/cyIylMld0RByBrWTkGHfBWs50zfBNhpZ9ZBONMvFC9BDMrH/KEOoJvwbmoynhZPYM245vwLa9csoyq5PNHAMqCJ20yMcEhtVJNbfOnm662Ssc/n7oKqB2cimuBon/n2ftKtqRMWcLpZfdZ8shzUou1K5oKrfqViUtwQKDZXzUmH8nExmmvaJlMcaD40uU/bh0Sx8CSRneHl3vsVyLHnHt0aaF8NWLCglas0IzIsMxQC1R8apWNHb5af1lxVjZFSlFEud/Dme6OkQGTbqvw9+jOqzCaxHlYcAQ+OiJRyF0lZ7yxsGgkgxAIz9tl5wX7M/7OTn7wlaPamG0Lw6oht3m3uGttx5InADodJ/7ElCCD6F+xKFi7lowJxvO0Cl1Parj1TLGcs2N4sv8lBs3QIHzhpoJBnK00pUxtGC7g78Z9G+53YZLiSz8dyg0aT3jWqM4PuQfJU58YrKEZwYOLGf7qUTZGs7HCulwSY+i+9rapqgU
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2419e3-3039-4faf-b243-08d8196ea76a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 01:17:11.7080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RHXNM04DEQ9XNOcZAl+s8jybye3JMhtApokQGo37TKaxbfqtyai2w4ba/WaWZA2vHFJPx0xs0NBgAF5jGRUiJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0726
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/25 21:22, Javier Gonz=E1lez wrote:=0A=
> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
> =0A=
> The current IOCTL interface for zone management is limited by struct=0A=
> blk_zone_range, which is unfortunately not extensible. Specially, the=0A=
> lack of flags is problematic for ZNS zoned devices.=0A=
> =0A=
> This new IOCTL is designed to be a superset of the current one, with=0A=
> support for flags and bits for extensibility.=0A=
> =0A=
> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>=0A=
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
> ---=0A=
>  block/blk-zoned.c             | 56 ++++++++++++++++++++++++++++++++++-=
=0A=
>  block/ioctl.c                 |  2 ++=0A=
>  include/linux/blkdev.h        |  9 ++++++=0A=
>  include/uapi/linux/blkzoned.h | 33 +++++++++++++++++++++=0A=
>  4 files changed, 99 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index 81152a260354..e87c60004dc5 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -322,7 +322,7 @@ int blkdev_report_zones_ioctl(struct block_device *bd=
ev, fmode_t mode,=0A=
>   * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE ioctl proce=
ssing.=0A=
>   * Called from blkdev_ioctl.=0A=
>   */=0A=
> -int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,=0A=
> +int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,=0A=
>  			   unsigned int cmd, unsigned long arg)=0A=
>  {=0A=
>  	void __user *argp =3D (void __user *)arg;=0A=
> @@ -370,6 +370,60 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev=
, fmode_t mode,=0A=
>  				GFP_KERNEL);=0A=
>  }=0A=
>  =0A=
> +/*=0A=
> + * Zone management ioctl processing. Extension of blkdev_zone_ops_ioctl(=
), with=0A=
> + * blk_zone_mgmt structure.=0A=
> + *=0A=
> + * Called from blkdev_ioctl.=0A=
> + */=0A=
> +int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,=0A=
> +			   unsigned int cmd, unsigned long arg)=0A=
> +{=0A=
> +	void __user *argp =3D (void __user *)arg;=0A=
> +	struct request_queue *q;=0A=
> +	struct blk_zone_mgmt zmgmt;=0A=
> +	enum req_opf op;=0A=
> +=0A=
> +	if (!argp)=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	q =3D bdev_get_queue(bdev);=0A=
> +	if (!q)=0A=
> +		return -ENXIO;=0A=
> +=0A=
> +	if (!blk_queue_is_zoned(q))=0A=
> +		return -ENOTTY;=0A=
> +=0A=
> +	if (!capable(CAP_SYS_ADMIN))=0A=
> +		return -EACCES;=0A=
> +=0A=
> +	if (!(mode & FMODE_WRITE))=0A=
> +		return -EBADF;=0A=
> +=0A=
> +	if (copy_from_user(&zmgmt, argp, sizeof(struct blk_zone_mgmt)))=0A=
> +		return -EFAULT;=0A=
> +=0A=
> +	switch (zmgmt.action) {=0A=
> +	case BLK_ZONE_MGMT_CLOSE:=0A=
> +		op =3D REQ_OP_ZONE_CLOSE;=0A=
> +		break;=0A=
> +	case BLK_ZONE_MGMT_FINISH:=0A=
> +		op =3D REQ_OP_ZONE_FINISH;=0A=
> +		break;=0A=
> +	case BLK_ZONE_MGMT_OPEN:=0A=
> +		op =3D REQ_OP_ZONE_OPEN;=0A=
> +		break;=0A=
> +	case BLK_ZONE_MGMT_RESET:=0A=
> +		op =3D REQ_OP_ZONE_RESET;=0A=
> +		break;=0A=
> +	default:=0A=
> +		return -ENOTTY;=0A=
> +	}=0A=
> +=0A=
> +	return blkdev_zone_mgmt(bdev, op, zmgmt.sector, zmgmt.nr_sectors,=0A=
> +				GFP_KERNEL);=0A=
> +}=0A=
> +=0A=
>  static inline unsigned long *blk_alloc_zone_bitmap(int node,=0A=
>  						   unsigned int nr_zones)=0A=
>  {=0A=
> diff --git a/block/ioctl.c b/block/ioctl.c=0A=
> index bdb3bbb253d9..0ea29754e7dd 100644=0A=
> --- a/block/ioctl.c=0A=
> +++ b/block/ioctl.c=0A=
> @@ -514,6 +514,8 @@ static int blkdev_common_ioctl(struct block_device *b=
dev, fmode_t mode,=0A=
>  	case BLKOPENZONE:=0A=
>  	case BLKCLOSEZONE:=0A=
>  	case BLKFINISHZONE:=0A=
> +		return blkdev_zone_ops_ioctl(bdev, mode, cmd, arg);=0A=
> +	case BLKMGMTZONE:=0A=
>  		return blkdev_zone_mgmt_ioctl(bdev, mode, cmd, arg);=0A=
>  	case BLKGETZONESZ:=0A=
>  		return put_uint(argp, bdev_zone_sectors(bdev));=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 8fd900998b4e..bd8521f94dc4 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -368,6 +368,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk,=
=0A=
>  =0A=
>  extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t =
mode,=0A=
>  				     unsigned int cmd, unsigned long arg);=0A=
> +extern int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode=
,=0A=
> +				  unsigned int cmd, unsigned long arg);=0A=
>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mod=
e,=0A=
>  				  unsigned int cmd, unsigned long arg);=0A=
>  =0A=
> @@ -385,6 +387,13 @@ static inline int blkdev_report_zones_ioctl(struct b=
lock_device *bdev,=0A=
>  	return -ENOTTY;=0A=
>  }=0A=
>  =0A=
> +=0A=
> +static inline int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode=
_t mode,=0A=
> +					unsigned int cmd, unsigned long arg)=0A=
> +{=0A=
> +	return -ENOTTY;=0A=
> +}=0A=
> +=0A=
>  static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,=0A=
>  					 fmode_t mode, unsigned int cmd,=0A=
>  					 unsigned long arg)=0A=
> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.=
h=0A=
> index 42c3366cc25f..07b5fde21d9f 100644=0A=
> --- a/include/uapi/linux/blkzoned.h=0A=
> +++ b/include/uapi/linux/blkzoned.h=0A=
> @@ -142,6 +142,38 @@ struct blk_zone_range {=0A=
>  	__u64		nr_sectors;=0A=
>  };=0A=
>  =0A=
> +/**=0A=
> + * enum blk_zone_action - Zone state transitions managed from user-space=
=0A=
> + *=0A=
> + * @BLK_ZONE_MGMT_CLOSE: Transition to Closed state=0A=
> + * @BLK_ZONE_MGMT_FINISH: Transition to Finish state=0A=
> + * @BLK_ZONE_MGMT_OPEN: Transition to Open state=0A=
> + * @BLK_ZONE_MGMT_RESET: Transition to Reset state=0A=
> + */=0A=
> +enum blk_zone_action {=0A=
> +	BLK_ZONE_MGMT_CLOSE	=3D 0x1,=0A=
> +	BLK_ZONE_MGMT_FINISH	=3D 0x2,=0A=
> +	BLK_ZONE_MGMT_OPEN	=3D 0x3,=0A=
> +	BLK_ZONE_MGMT_RESET	=3D 0x4,=0A=
> +};=0A=
> +=0A=
> +/**=0A=
> + * struct blk_zone_mgmt - Extended zoned management=0A=
> + *=0A=
> + * @action: Zone action as in described in enum blk_zone_action=0A=
> + * @flags: Flags for the action=0A=
> + * @sector: Starting sector of the first zone to operate on=0A=
> + * @nr_sectors: Total number of sectors of all zones to operate on=0A=
> + */=0A=
> +struct blk_zone_mgmt {=0A=
> +	__u8		action;=0A=
> +	__u8		resv3[3];=0A=
> +	__u32		flags;=0A=
> +	__u64		sector;=0A=
> +	__u64		nr_sectors;=0A=
> +	__u64		resv31;=0A=
> +};=0A=
> +=0A=
>  /**=0A=
>   * Zoned block device ioctl's:=0A=
>   *=0A=
> @@ -166,5 +198,6 @@ struct blk_zone_range {=0A=
>  #define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)=0A=
>  #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)=0A=
>  #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)=0A=
> +#define BLKMGMTZONE	_IOR(0x12, 137, struct blk_zone_mgmt)=0A=
>  =0A=
>  #endif /* _UAPI_BLKZONED_H */=0A=
> =0A=
=0A=
Without defining what the flags can be, it is hard to judge what will chang=
e=0A=
from the current distinct ioctls.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
