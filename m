Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E474C433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 01:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23B92075D
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 01:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TVmjY1j9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TnYczZL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgFZB1e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 21:27:34 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34613 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgFZB1d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 21:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593134853; x=1624670853;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=61qXW3MW7fc7WHU8PvqO73SjJyDF3OnCHW42I+Jsygc=;
  b=TVmjY1j9qsDDFotrfn20u7xhV/YSW2Wnl6O7YTn2zvvnLQh4IZhXVMtP
   6wZLuiyU2miWjEqy+SeUYmDZ/cQzFXTDC7TgCylwhlr7g1bm0JTE/D4Sq
   ff9PS7YxXxOClvXr0x/7Tk8yaxCoMTGLpyqOJ3Xj3lXJHiLNCIbkS6jfF
   z8V3umjw/2667c/ix+uF01pyvYkABRLGJ/CHzfcUYiBf0Je6sf8thZy/S
   DzS0R+yFCdb2UC0NZZthgbuLzXVatseY/Dw1cUJYLoW0x23qiBn2cxMnX
   DBfwLOqbf1CD79ctthOLdsNPiTKvGmfHTvZPnslxne457tzRqQL2BCshm
   w==;
IronPort-SDR: UOTwfKSfeigSSao88vENzyTCZPJE/WKiI1pblmuJkGP6X9RvnwTpWJ61mronicBvZJ0kmUp+Fo
 r2V0ua8GU45jEJZqq0JpVzm4qJK0jqdmjXWuuu4foPB0ScwiQUkb1h4LYb9XYz8wx6EI2YIXNk
 z3JjbyKARTvBg1iTm5OeuBCboRUw42pJcbYcT5389db248wh1/MXcAywtXGgAgvvxl2MhdbH3Z
 SOqdOm6i0IjVeG8ick8ZxzX3DWOpin1vWsC73wqCmrZ5+aP9zj3p6h5pvek7n5xwTYd3gCCAeA
 GO0=
X-IronPort-AV: E=Sophos;i="5.75,281,1589212800"; 
   d="scan'208";a="141196798"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 09:27:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loSWqV/iQzpOjeziEbpcVhbBFlonz7c4ZHNjfcvyotDpL9h/ZncZUhHMlULlLviIpJdlBHB+MsAT7T+C6/J3VltDVnSk1m8UynH5G3NjvPEH29FKE6+tpshBXhXiMG4Mc74Wb6IAg/hmd7s+1c6Af0ipXujq3/TmXuOZJqZTUc8BuWpp+hfzca3Z45BY+w15IDbPVR7Z5DTosmavjOUtcINtq7WDpI3LACnp1mA4K4glvVu21dcUq8pLXqkGRK2LPfXSyT/NcxHGTQLMlvwAQxYKP3AFP7rthGzyB/Ci2UcSQEKAqLfW6JYlp7VgvcLqZoG1B4USWUrsKzQYAxHR2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdUeuxhZluUYIJT/I1Xe+quLPXw1QoOiJn0n4XeaAIE=;
 b=oF3MjX8uzHyzrz2BwIBWgNpgn4GkhvkWtxEI+PruExsNbIPJCB63z3ns3uGtsifwMMpAhEsLEtgEV9zppXITQICvvo5TkH9p0pmzyllvRBzOzgV/eahHfollXG43po01fYqbUl2p2HLICEinm7gK3Ec0uAkiG9aSnvrD51DJ6Lc+W5zGC803eW07rK3TsBRnh2f3QzK5HZvlaHUME7b+AOBIMOU395VzFYdD/Jec98ZmDx2l/wgVVGuW1x4ofmh0aRX7vVSHkhr1HO7aG2nBElZBwfi4olYDnne96keLqCL2WxDScWzG6c3KaP0PtiskHR5sobAT9fSnml4G7ptjyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdUeuxhZluUYIJT/I1Xe+quLPXw1QoOiJn0n4XeaAIE=;
 b=TnYczZL8/UTFzMNRNR6u2AKRsKamaDpkSTpAQQ1bT1P3C9mEBu5e8/Tarmh3f9FGBB4NTocmIqpF2dsw9+wdmiRQKlt8SwvxRr5dj8YPaxDT7VAmTfBLu4+5ub0F5WA/iRvDI8M3Gj0ZlUSbxT5vBDrD2G7Wz2pVj6aT9wuEabc=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0968.namprd04.prod.outlook.com (2603:10b6:910:51::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.26; Fri, 26 Jun
 2020 01:27:29 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 01:27:29 +0000
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
Subject: Re: [PATCH 2/6] block: add support for selecting all zones
Thread-Topic: [PATCH 2/6] block: add support for selecting all zones
Thread-Index: AQHWSutRrDHAt43U1UKTuwgck7oDsA==
Date:   Fri, 26 Jun 2020 01:27:29 +0000
Message-ID: <CY4PR04MB375143652B4BA25F1680A91EE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-3-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d722004-39ce-4397-e77d-08d81970177c
x-ms-traffictypediagnostic: CY4PR04MB0968:
x-microsoft-antispam-prvs: <CY4PR04MB09682EDF97BFCEF8F861619BE7930@CY4PR04MB0968.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ULyZtP3WFxpq/EqEHSjbR/Cx8zZUtyAoKzbH8cy0X1e2ZgsbAhXC1xgUHXbM6BdLyY83LQC4Z/hfXECJuEUdHiKCEps3qbNmnlzb4gtpiqfNdixh+zGAnrYf4SWwGIYfQMNYrD9Kbc5q8I4qbzvkP7P0a98dXpwIzips1QRGdjD23W1GRF7xO6M3P4lUejozg1wj6APTBrO3HKiTegb4KD/tTyPHcGkGb1wuggdnHbMhxXNUFnzBsPUHTKyITBQ7tD0ZUqayihaVUrI87PEJdtORZlOaJ30FqxNb3CZ3xYW4m1nqegmKFpBIBJe0/J3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(53546011)(91956017)(6506007)(5660300002)(7696005)(9686003)(52536014)(76116006)(55016002)(8936002)(8676002)(186003)(33656002)(86362001)(71200400001)(83380400001)(110136005)(7416002)(4326008)(54906003)(478600001)(26005)(64756008)(66476007)(66446008)(2906002)(316002)(66556008)(66946007)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +SdhQRBf1eB8PFLj/QkSjNe+5V2G2IqqLSjJKOaLSjbRxuG8J1V+AeJ3U7hJHKPiLum9Myae9pPzfXdVhgzL3hvf1mKJ8pBlGwPutV5NTaNbQtd7NZO9WZjfZqg1xL9dJqapFJ2IUCz/2ONWxahNfW446sng/W+qnzxvkQniZ5eNKE77LBWTRbgVfxStzJY1hJGryvTa5I566/xDyelzwfGtBe/oyPL0Iku8qDA5lwXO+RLcWuLQ0mPs2TpGM0HEuzK+x8CwctTYGvlFHVa4mHCYDAkPJ/1nmY8Z1jr0o91nKy/9R7yEQqOu1Ud9KuSI3uPiLzTJLDAS33bpIsN6m2Lbo964iVhtd2fV2Dq+SmNO12D+56t7LwE53CHrofFuhkeDkPxK41E4ax/eHvsPcVZiuXLS+fsLtJZBeGyiR1bFnAdTxvtaCWUN7/vrXfitYNp3IrMjawaWjsRR8Z5TXvQPSlZ9rFEfgh39F7jaZky4fN5TWWO9KXBcgXYbkiKc
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d722004-39ce-4397-e77d-08d81970177c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 01:27:29.2439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5gSaH7UyqBW3sRCZhWJyipVAXXnGCqD/iAqG1/RKL8NI4uhnJ6yDgyHCz2lsOfKE00q92oX5Q4xtH3aE9GIwaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0968
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/25 21:22, Javier Gonz=E1lez wrote:=0A=
> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
> =0A=
> Add flag to allow selecting all zones on a single zone management=0A=
> operation=0A=
> =0A=
> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>=0A=
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
> ---=0A=
>  block/blk-zoned.c             | 3 +++=0A=
>  include/linux/blk_types.h     | 3 ++-=0A=
>  include/uapi/linux/blkzoned.h | 9 +++++++++=0A=
>  3 files changed, 14 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index e87c60004dc5..29194388a1bb 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -420,6 +420,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev,=
 fmode_t mode,=0A=
>  		return -ENOTTY;=0A=
>  	}=0A=
>  =0A=
> +	if (zmgmt.flags & BLK_ZONE_SELECT_ALL)=0A=
> +		op |=3D REQ_ZONE_ALL;=0A=
> +=0A=
>  	return blkdev_zone_mgmt(bdev, op, zmgmt.sector, zmgmt.nr_sectors,=0A=
>  				GFP_KERNEL);=0A=
>  }=0A=
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h=0A=
> index ccb895f911b1..16b57fb2b99c 100644=0A=
> --- a/include/linux/blk_types.h=0A=
> +++ b/include/linux/blk_types.h=0A=
> @@ -351,6 +351,7 @@ enum req_flag_bits {=0A=
>  	 * work item to avoid such priority inversions.=0A=
>  	 */=0A=
>  	__REQ_CGROUP_PUNT,=0A=
> +	__REQ_ZONE_ALL,		/* apply zone operation to all zones */=0A=
>  =0A=
>  	/* command specific flags for REQ_OP_WRITE_ZEROES: */=0A=
>  	__REQ_NOUNMAP,		/* do not free blocks when zeroing */=0A=
> @@ -378,7 +379,7 @@ enum req_flag_bits {=0A=
>  #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)=0A=
>  #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)=0A=
>  #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)=0A=
> -=0A=
> +#define REQ_ZONE_ALL		(1ULL << __REQ_ZONE_ALL)=0A=
>  #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)=0A=
>  #define REQ_HIPRI		(1ULL << __REQ_HIPRI)=0A=
>  =0A=
> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.=
h=0A=
> index 07b5fde21d9f..a8c89fe58f97 100644=0A=
> --- a/include/uapi/linux/blkzoned.h=0A=
> +++ b/include/uapi/linux/blkzoned.h=0A=
> @@ -157,6 +157,15 @@ enum blk_zone_action {=0A=
>  	BLK_ZONE_MGMT_RESET	=3D 0x4,=0A=
>  };=0A=
>  =0A=
> +/**=0A=
> + * enum blk_zone_mgmt_flags - Flags for blk_zone_mgmt=0A=
> + *=0A=
> + * BLK_ZONE_SELECT_ALL: Select all zones for current zone action=0A=
> + */=0A=
> +enum blk_zone_mgmt_flags {=0A=
> +	BLK_ZONE_SELECT_ALL	=3D 1 << 0,=0A=
> +};=0A=
> +=0A=
>  /**=0A=
>   * struct blk_zone_mgmt - Extended zoned management=0A=
>   *=0A=
> =0A=
=0A=
NACK.=0A=
=0A=
Details:=0A=
1) REQ_OP_ZONE_RESET together with REQ_ZONE_ALL is the same as=0A=
REQ_OP_ZONE_RESET_ALL, isn't it ? You are duplicating a functionality that=
=0A=
already exists.=0A=
2) The patch introduces REQ_ZONE_ALL at the block layer only without defini=
ng=0A=
how it ties into SCSI and NVMe driver use of it. Is REQ_ZONE_ALL indicating=
 that=0A=
the zone management commands are to be executed with the ALL bit set ? If y=
es,=0A=
that will break device-mapper. See the special code for handling=0A=
REQ_OP_ZONE_RESET_ALL. That code is in place for a reason: the target block=
=0A=
device may not be an entire physical device. In that case, applying a zone=
=0A=
management command to all zones of the physical drive is wrong.=0A=
3) REQ_ZONE_ALL seems completely equivalent to specifying a sector range of=
 [0=0A=
.. drive capacity]. So what is the point ? The current interface handles th=
at.=0A=
That is how we chose between REQ_OP_ZONE_RESET and REQ_OP_ZONE_RESET_ALL ri=
ght now.=0A=
4) Without any in-kernel user, I do not see the point. And for applications=
, I=0A=
do not see any good use case for doing open all, close all, offline all or=
=0A=
finish all. If you have any such good use case, please elaborate.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
