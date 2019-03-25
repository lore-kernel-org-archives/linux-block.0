Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18720C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2B420850
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ILe4b6F9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bdN6UE/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfCYFWd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:22:33 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52633 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfCYFWd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 01:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553491352; x=1585027352;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=XBzJxGW+VLHjAit/sh0ZQSD2vhioVKNsjujyd3SvQrM=;
  b=ILe4b6F9N/vxAKna694fA01/oqG3NOlqhlUr45GUpUqYSa8UivVXHkkv
   lDfDODjBpBhjyHFHsldB5RJnoPEhBZTzg6McHkAGnY5SaeTuhWclvWHmn
   AAoIp96lqVl5AamdwtqQXlP9UdyYCgEOESQYP0mytWDp05fDbIxZ7eqEz
   0xblL1OZNKHRtI/LUgOcniOGpQ4wohQjXc5OTMVZUfL9fjRKWbq3iVbGf
   1qHlyQatfhv0tQHBdaITuCgyWq546SNEbii8AhtH11eTpZcEL2cSSNXS1
   4ALjaEleagPPXq6zlixmAl5Tai9ODTgOa+RpcaFjywY79It65yt0qOUEh
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,256,1549900800"; 
   d="scan'208";a="109189933"
Received: from mail-bl2nam02lp2051.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.51])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2019 13:22:31 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8yRoi5gvEiOYjUx4OWaKFWxYT7im04ywCoCEDRmSTY=;
 b=bdN6UE/TnoLqrCu6c/ZGkqE7sMph0jyMbNBUsM32vPodoifx9x3XxTrEFCO13NGZt9kpRkpzzWgrZ3CpKqlXuXHs5bMhHdwooTn4NZUKUWcJsnp7lP6ZELV6ficuTDfWPNq/NBBrbvOHwuXCeA9ZIk2OxePU/PMqW2TvBg29SIo=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4398.namprd04.prod.outlook.com (52.135.72.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 05:22:27 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%2]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 05:22:27 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 08/15] nvme-pci: merge nvme_free_iod into nvme_unmap_data
Thread-Topic: [PATCH 08/15] nvme-pci: merge nvme_free_iod into nvme_unmap_data
Thread-Index: AQHU4Dt1TfdOnkhmjkWWjQhiUiqwTw==
Date:   Mon, 25 Mar 2019 05:22:27 +0000
Message-ID: <SN6PR04MB452734A9E74001D4684E2675865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80150137-2024-451f-cdbd-08d6b0e1df2f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4398;
x-ms-traffictypediagnostic: SN6PR04MB4398:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB43983F8AB0662450A42E90F6865E0@SN6PR04MB4398.namprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(136003)(366004)(199004)(189003)(7736002)(68736007)(86362001)(478600001)(97736004)(446003)(72206003)(4326008)(25786009)(476003)(486006)(14454004)(229853002)(7696005)(8936002)(76176011)(6436002)(5660300002)(305945005)(26005)(52536014)(102836004)(81156014)(81166006)(8676002)(53546011)(6506007)(66066001)(6246003)(53936002)(316002)(110136005)(99286004)(55016002)(54906003)(74316002)(9686003)(71200400001)(256004)(33656002)(106356001)(6116002)(14444005)(3846002)(71190400001)(2906002)(105586002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4398;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZwLn3+fcXkeEnf/Ak0E63b8THuq2qj7ZnCByjNLvtQkWvWthVYmk3FNtFdSMkdTwgu7zGjg/LeW5ZWouc/YdyHIJF9ic/EcKZ3CqnW2+i7g0onA+vJfR4t/tbRSHBUMriuZfI7s2Bxfw8Cblzu094WktuVVpfuYoSk0JpK0H1rDDbRp81voqWTIZnsDs505XZuCmOwGCq+BvH3cirCbhAWvWQRISDwoZFSGMMtWBMvB54RLOkkQJwWkihvTnFOHDyoxah1LF/48KX1/faXXOSa1JXwGtWYNQM2ShomBn4nq1kfxJ0ohBNHKGTSeB6YpTnUIFxGG76zUlk9nAHGGTAF5oX4q4tE8MJZdQ9XJOXq242OlJcNxAjj9LlVOKOw+thtKqo4v7O//wL0NSQJogwl1X3uzcBNQs28xjsNi8NTI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80150137-2024-451f-cdbd-08d6b0e1df2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 05:22:27.7245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4398
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/21/19 4:11 PM, Christoph Hellwig wrote:=0A=
> This means we now have a function that undoes everything nvme_map_data=0A=
> does and we can simplify the error handling a bit.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   drivers/nvme/host/pci.c | 44 ++++++++++++++++-------------------------=
=0A=
>   1 file changed, 17 insertions(+), 27 deletions(-)=0A=
> =0A=
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c=0A=
> index 2fb35d44010a..ce8bdc15ec3c 100644=0A=
> --- a/drivers/nvme/host/pci.c=0A=
> +++ b/drivers/nvme/host/pci.c=0A=
> @@ -583,14 +583,24 @@ static inline bool nvme_pci_use_sgls(struct nvme_de=
v *dev, struct request *req)=0A=
>   	return true;=0A=
>   }=0A=
>   =0A=
> -static void nvme_free_iod(struct nvme_dev *dev, struct request *req)=0A=
> +static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)=
=0A=
>   {=0A=
>   	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);=0A=
> +	enum dma_data_direction dma_dir =3D rq_data_dir(req) ?=0A=
> +			DMA_TO_DEVICE : DMA_FROM_DEVICE;=0A=
>   	const int last_prp =3D dev->ctrl.page_size / sizeof(__le64) - 1;=0A=
>   	dma_addr_t dma_addr =3D iod->first_dma, next_dma_addr;=0A=
> -=0A=
>   	int i;=0A=
>   =0A=
> +	if (iod->nents) {=0A=
> +		/* P2PDMA requests do not need to be unmapped */=0A=
> +		if (!is_pci_p2pdma_page(sg_page(iod->sg)))=0A=
> +			dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);=0A=
> +=0A=
> +		if (blk_integrity_rq(req))=0A=
> +			dma_unmap_sg(dev->dev, &iod->meta_sg, 1, dma_dir);=0A=
> +	}=0A=
> +=0A=
>   	if (iod->npages =3D=3D 0)=0A=
>   		dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],=0A=
>   			dma_addr);=0A=
> @@ -847,50 +857,30 @@ static blk_status_t nvme_map_data(struct nvme_dev *=
dev, struct request *req,=0A=
>   		ret =3D nvme_pci_setup_prps(dev, req, &cmnd->rw);=0A=
>   =0A=
>   	if (ret !=3D BLK_STS_OK)=0A=
> -		goto out_unmap;=0A=
> +		goto out;=0A=
>   =0A=
>   	ret =3D BLK_STS_IOERR;=0A=
>   	if (blk_integrity_rq(req)) {=0A=
>   		if (blk_rq_count_integrity_sg(q, req->bio) !=3D 1)=0A=
> -			goto out_unmap;=0A=
> +			goto out;=0A=
>   =0A=
>   		sg_init_table(&iod->meta_sg, 1);=0A=
>   		if (blk_rq_map_integrity_sg(q, req->bio, &iod->meta_sg) !=3D 1)=0A=
> -			goto out_unmap;=0A=
> +			goto out;=0A=
>   =0A=
>   		if (!dma_map_sg(dev->dev, &iod->meta_sg, 1, dma_dir))=0A=
> -			goto out_unmap;=0A=
> +			goto out;=0A=
>   =0A=
>   		cmnd->rw.metadata =3D cpu_to_le64(sg_dma_address(&iod->meta_sg));=0A=
>   	}=0A=
>   =0A=
>   	return BLK_STS_OK;=0A=
>   =0A=
> -out_unmap:=0A=
> -	dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);=0A=
>   out:=0A=
> -	nvme_free_iod(dev, req);=0A=
> +	nvme_unmap_data(dev, req);=0A=
>   	return ret;=0A=
>   }=0A=
>   =0A=
> -static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)=
=0A=
> -{=0A=
> -	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);=0A=
> -	enum dma_data_direction dma_dir =3D rq_data_dir(req) ?=0A=
> -			DMA_TO_DEVICE : DMA_FROM_DEVICE;=0A=
> -=0A=
> -	if (iod->nents) {=0A=
> -		/* P2PDMA requests do not need to be unmapped */=0A=
> -		if (!is_pci_p2pdma_page(sg_page(iod->sg)))=0A=
> -			dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);=0A=
> -=0A=
> -		if (blk_integrity_rq(req))=0A=
> -			dma_unmap_sg(dev->dev, &iod->meta_sg, 1, dma_dir);=0A=
> -	}=0A=
> -=0A=
> -	nvme_free_iod(dev, req);=0A=
> -}=0A=
> -=0A=
>   /*=0A=
>    * NOTE: ns is NULL when called on the admin queue.=0A=
>    */=0A=
> =0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
