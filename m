Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E9FC433E6
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 05:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC8822CB2
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 05:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732714AbhALFl3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 00:41:29 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43307 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbhALFl3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 00:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610430088; x=1641966088;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/bSctMMrw1cebHRg5RYOgLQFcbD2UIcLE6a590nMGQE=;
  b=EP9aB/u3HFcIsH6Kv3Tt5CroKRK0Pw/pDZEdnYrwhEkanQPfr6ukSkBN
   3wd3HGJatyhpd2jp2liG5e4RuRozuU8RhufZXhkwbXWyXm1YTpUi9PCuG
   b33zEom+a+ORmvDYhTRoMFoUdNpYdC705vVlhg9wq7zYXYTo08jWs9Y35
   MXfV+xGmcG0nmsgTt3T+IrJeYo9A4b9d4NPoYD1oy4dwM8b9MSzkdzxbB
   4p9qt8mvZ269Y9EaJYCQvpfCVm0GtVtepYg6HAMxA//m1L2DKbemex+H8
   6UQNB7w4B4LrhchcX/KFEXWsUvFUlrc+p0RWJNQCayV+06WLKhRg4j1SW
   A==;
IronPort-SDR: XCsYByATMlBg1cxho4q7jl2Ooq33b3dNCtMoxoa9Ns0L4l0A+WCZ0YzdFQYbG7+q92DxWid9oc
 zQn6PPS6HK/b/Wvkn9ZP0Nw6ZJ7xxeLUJlkeJPrFZdlkIKj/xytlcktYiR9lIaG3QGIGu4f0l9
 MWdB17ABRy5PudlUORFM3ylt+M3pcrOggTDAfn12dSw55KHxeo1T9IokMOC7gXm224Nk+yE9OK
 xGnx5trZTSQdg0CsiTPvX9IL+l2nOF+Wk9j16hFJ2HldASlfKXsmnifOHbQWEljznVFmJ6yHdW
 r1I=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="158384824"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 13:40:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auehVxJtH2JLbe+ir5OBTozxsj4ye9DT35/4zlhMNh/JVaOQIOScwOOOuACpReqQlAUnY8HxDyV8bqKdev2ZghPxdtZ2EC9UIYduYcF8q+tauKntQVpEZtagO4gpo07UCPANfm2Ky5SlkcA+uHPogn0dfRbiKpFYIbvBAJgr+bPm4AdDQHK2vaUnhx6vPPEyJCpNOkBOMwVn+6epcOXSSbY/FggkfZ8tYVZ7GtSUlWVqBnpkgDmEgltVSncmO+9ihQ7Y6dzY2/sykVFpxpsy+m0YMHz34IaXSbiRD1/dHXxqFjAXMOlc2arzU/QXKQ/tHpMkInC5LGp95A92sAC0rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3WIh/yndaZLyUbXqTenEuzKMMQ5IOVKZPY664TkAAs=;
 b=fdcKWBAYvcXa1fiQQQdzcBP4UIAU1u9lLVvEHuiSJOK7mb0bHO0AamPJqMWJZuivra7y0UiO1+1+XsrRnCG+nsvP6v+WvXg3rz0vouSqrPx/66QsoDyboNfFNZJ7RlC0igrRsiwiEabwGMq9yJ8Lm7XpA5ylSpBH7/5n3a5QWYRFwd2EKYkpyjN9FPPNSRy4DQlRzExg4biqok+q70MR0iP7gxhD5Zx/kT+oVj84vwaE4H4QDE26f9Hi7C68NU6oS/m1QZxJiXpMIOcg8Msk25xU0JVUwmJ3O8pP3uafw8FPeVr3NIXW3Ejs5PDzq513TyFtS7jOkfCV3Q4hdD8ODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3WIh/yndaZLyUbXqTenEuzKMMQ5IOVKZPY664TkAAs=;
 b=qT+3/8UJG6SoNJRJjiRdVcKx/D2LGokWfPxzGUtvrQaBXwH1/Spl2zB6N/tME+Od1gA06Wow9KcZ0AiofbRMhggHXw9l7kEe5SJQm6TB8odkCyrw4XiOaH45K1wjkuKXbV7j18nvUaTSTVoaFQt5m05Qujk1OKNHawPfNXUNLbE=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6446.namprd04.prod.outlook.com (2603:10b6:208:1aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 05:40:21 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0%9]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 05:40:21 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V9 1/9] block: export bio_add_hw_pages()
Thread-Topic: [PATCH V9 1/9] block: export bio_add_hw_pages()
Thread-Index: AQHW6Jsh1gHE/mYsHEGEzXQRV1WfYA==
Date:   Tue, 12 Jan 2021 05:40:21 +0000
Message-ID: <BL0PR04MB6514D012AC158AB3F873C387E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-2-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5cb8:2b48:5f8c:2c03]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 535dab38-c260-489f-e27e-08d8b6bc8d3a
x-ms-traffictypediagnostic: MN2PR04MB6446:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6446F401E065C03818B0F8EBE7AA0@MN2PR04MB6446.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KCY7FNjqKE4wB/ahQ37XmCeelWyiHT/BOW/ZFDAzI+ZzmMTihQBym4qZYEHxT9iubWuNkVxenLDQbsrUV8OR5dPCW3/CG0cY0cVwoOimiqqLYd0AyW3ottsfgOvTX2h3fG+uyOtGTyfBNvOCNjKfG9mOnYRYTSOoiD0E9XKFYkg0cb6obeHctUmuEhXygz9AplWgW76mmv3TN8b4AB2/5hOs5ApLJSDpg4j3u1Z881zCmQMjyhcbP9otY7C4EDoqjwaBT8bfbG/jH4rb+Dv5RR1NrB9mbiw9Fh9xxbgU0Ex9gJezSTnJRR14VGSo9BWvQt8X5wl5tvREPdBTCH/vXV34EDCZtdubLnzIqx5f74oynbBg/K9ykCt6IhIfviQot/GvHIJbGgq9BgEREdtzhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(71200400001)(6506007)(4326008)(9686003)(7696005)(316002)(53546011)(5660300002)(2906002)(186003)(33656002)(66446008)(478600001)(54906003)(83380400001)(110136005)(8676002)(91956017)(66476007)(76116006)(8936002)(66556008)(64756008)(52536014)(86362001)(66946007)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?oP/S9Kcz0v3gkCuuifngnwdnS6nljfFB0IiDgibNJbF32Wnzy0jxgsYZIyZF?=
 =?us-ascii?Q?lTGyLMLN9fw4gdln8ZboOiHvlgKKLEwucBqV70rGUYQ4Bm1F9eAlehYCe1Yz?=
 =?us-ascii?Q?5Z3YnaXaBJ3RwYf4w/g7wn14ct7TFKY81No/TgBfnNY+slnRDIDl2ow/nXx/?=
 =?us-ascii?Q?hUWvrl8Ze2z0lnK4Y9IbBfRrA/HFyjDB61OF+Hq9cNZ9EVfBSHK/MR3xglsw?=
 =?us-ascii?Q?ro/G/9Amwpqh75YJDay5rizlLJ3qrVRkplr8RG/CulPrBTs3KL1OIl9pL5JF?=
 =?us-ascii?Q?b0YiXpTL3jAn+KBZ35p3MtOWQnRCdKSdASeshitZHn3DktTCscvPdd1KXSmW?=
 =?us-ascii?Q?vBQP/1mxIwmA+BosudrUrNc4w4NS0JbfHEB+HAE6MbO96umDtz87/ZUmGLpn?=
 =?us-ascii?Q?JubF1+0sNP1/8tKiAdyB4mn1NiC85Qc0Fs+lyOZ++EYrrmVL+RVCVW3HLzSZ?=
 =?us-ascii?Q?5xWVbN3FASjGgd9urwFp9kPUiEUgBd2gWBKz6CLZuNRkp11tJdwrzIsVDT1I?=
 =?us-ascii?Q?Z4suZIi5MZbJNE7vWfgPzAq2Q6rZoVWk2nlG9/CUBCu0RYPd0cXnOkBYt4xd?=
 =?us-ascii?Q?41CnxsTd4BkIo5TI8OFwpQkvlGHUmPmqZJNn/c6d8Zh4zHQFp0xjZHa9Vs2l?=
 =?us-ascii?Q?0OrpjzWLu7d/NzV+jqivNfHA+XXSsvhFfURz1NeMFB3t4XJLjcWpYtFk+N1Y?=
 =?us-ascii?Q?15CGwB+TYxBFhHYPfgVWAKeF4CpzdUcSMDw4KDO/vpr0oRvBdi/q80QyfDik?=
 =?us-ascii?Q?4Anz5lFHLF+sVcLz+hL8A6IrVo9wE40e0vfGK+4JlNIVlg1wDj5oz6O86qGa?=
 =?us-ascii?Q?EL+48KRuB6F6OomOmHyomtvmCWFaUdhlgn91NOhdh0etZnnQP7ltfWP2njaZ?=
 =?us-ascii?Q?OcEs3AlinkW/ZXwoXAqCoixHJS8mOk3G3Zj1Jy7+3KXYsScB2ryuXwQrj36b?=
 =?us-ascii?Q?bPp1ACfX8MurGOZIbXVNI6vvavIh0nVbyFycLU+SCForfe4nfTHqEdM/wF3b?=
 =?us-ascii?Q?wS2PuTEAn34lZyW51Lg3ZAKDkOLVO4Miw1dYBO1zLvvrGA6is6uhfGIfxbkM?=
 =?us-ascii?Q?rd32+hW6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535dab38-c260-489f-e27e-08d8b6bc8d3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 05:40:21.1801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q5s9wXD3g/vlrgpts3hLOu7A03AQzQE30k7um+Djg/b14zNSfJF7vOgDOdr1jjPB0yx5hxi6FGpCrL/on49UWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6446
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/12 13:26, Chaitanya Kulkarni wrote:=0A=
> To implement the NVMe Zone Append command on the NVMeOF target side for=
=0A=
> generic Zoned Block Devices with NVMe Zoned Namespaces interface, we=0A=
> need to build the bios with hardware limitations, i.e. we use=0A=
> bio_add_hw_page() with queue_max_zone_append_sectors() instead of=0A=
> bio_add_page().=0A=
> =0A=
> Without this API being exported NVMeOF target will require to use=0A=
> bio_add_hw_page() caller bio_iov_iter_get_pages(). That results in=0A=
> extra work which is inefficient.=0A=
> =0A=
> Export the API so that NVMeOF ZBD over ZNS backend can use it to build=0A=
> Zone Append bios.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  block/bio.c            | 1 +=0A=
>  block/blk.h            | 4 ----=0A=
>  include/linux/blkdev.h | 4 ++++=0A=
>  3 files changed, 5 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index 1f2cc1fbe283..5cbd56b54f98 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -826,6 +826,7 @@ int bio_add_hw_page(struct request_queue *q, struct b=
io *bio,=0A=
>  	bio->bi_iter.bi_size +=3D len;=0A=
>  	return len;=0A=
>  }=0A=
> +EXPORT_SYMBOL(bio_add_hw_page);=0A=
>  =0A=
>  /**=0A=
>   * bio_add_pc_page	- attempt to add page to passthrough bio=0A=
> diff --git a/block/blk.h b/block/blk.h=0A=
> index 7550364c326c..200030b2d74f 100644=0A=
> --- a/block/blk.h=0A=
> +++ b/block/blk.h=0A=
> @@ -351,8 +351,4 @@ int bdev_resize_partition(struct block_device *bdev, =
int partno,=0A=
>  		sector_t start, sector_t length);=0A=
>  int disk_expand_part_tbl(struct gendisk *disk, int target);=0A=
>  =0A=
> -int bio_add_hw_page(struct request_queue *q, struct bio *bio,=0A=
> -		struct page *page, unsigned int len, unsigned int offset,=0A=
> -		unsigned int max_sectors, bool *same_page);=0A=
> -=0A=
>  #endif /* BLK_INTERNAL_H */=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 070de09425ad..028ccc9bdf8d 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -2005,6 +2005,10 @@ struct block_device *I_BDEV(struct inode *inode);=
=0A=
>  struct block_device *bdgrab(struct block_device *bdev);=0A=
>  void bdput(struct block_device *);=0A=
>  =0A=
> +int bio_add_hw_page(struct request_queue *q, struct bio *bio,=0A=
> +		struct page *page, unsigned int len, unsigned int offset,=0A=
> +		unsigned int max_sectors, bool *same_page);=0A=
> +=0A=
>  #ifdef CONFIG_BLOCK=0A=
>  void invalidate_bdev(struct block_device *bdev);=0A=
>  int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t =
lstart,=0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
