Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0449AC4360F
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6482075E
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GUwjHTe8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YkLscDXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfCYFlC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:41:02 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:27803 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729233AbfCYFlC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 01:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553492462; x=1585028462;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=XrZteJQ/4d1YiPh9eoEYWuZr3C5chHqQGnlqDVcAxM8=;
  b=GUwjHTe8QfrWUoPa3V2AJLOpldFFxrNDqRk4cQ2nt5cnkAoZ45/QwN7d
   nXM4V6H3h18a0Bj0JFKQMV4LxsU2nuhzIvxGDuDAIurL12zG/D+WMpm/x
   bfiRlV0YW2vWZl76uSgd1zgqtmgm+1Q79+HgGsE7p1AVaD+mc3Lv1Nknh
   vMUY7oMUD7/fnqRW644MwqOX49w5uR934xfrPZbTjVayQ8KTMUGWlbDQW
   SYx2qx7nxMdtes9NP0ubk7ootjw6L60+RNJkEjBXyWnOu5nOtfXFV7qv3
   ubRvqnPNboEW5ges0aug56dyT8QYxFM/ARa9JqmQMEG2dSy7L5an7Trbh
   g==;
X-IronPort-AV: E=Sophos;i="5.60,256,1549900800"; 
   d="scan'208";a="105870501"
Received: from mail-co1nam03lp2057.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.57])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2019 13:41:01 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWeSPjIAnVtJemfAH1doflIVjVnDm3iIUzevX09eajA=;
 b=YkLscDXLbA2punF1jPqmq12kolRzGlwoSMsFbMkhwWENNdbwpitTP+fwGrTDSlE1bJfdyWKUEnr7b13pRVWxbguomsX8KSEfZiCo4/dSNVLRo5O82TvXheBxzM6FFB+KEzIPst33yucpxbjkmQ2oW8CH1+021n+dq+EJlb8GXMs=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB5120.namprd04.prod.outlook.com (52.135.116.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Mon, 25 Mar 2019 05:40:48 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%2]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 05:40:48 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 15/15] nvme-pci: tidy up nvme_map_data
Thread-Topic: [PATCH 15/15] nvme-pci: tidy up nvme_map_data
Thread-Index: AQHU4DuLKmPxOe6hW0ulqCgz6jpKWQ==
Date:   Mon, 25 Mar 2019 05:40:48 +0000
Message-ID: <SN6PR04MB4527AF84720FCAE7A0478EAB865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-16-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [65.123.219.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80de582b-c419-4119-2692-08d6b0e46f58
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB5120;
x-ms-traffictypediagnostic: SN6PR04MB5120:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB51208CAC7F01757B6A67BA65865E0@SN6PR04MB5120.namprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(229853002)(26005)(81166006)(52536014)(8936002)(81156014)(186003)(8676002)(476003)(478600001)(446003)(99286004)(33656002)(53546011)(6506007)(316002)(66066001)(97736004)(68736007)(76176011)(102836004)(6246003)(2906002)(4326008)(6116002)(71200400001)(71190400001)(55016002)(3846002)(86362001)(9686003)(256004)(14444005)(5660300002)(25786009)(486006)(7696005)(305945005)(74316002)(7736002)(53936002)(6436002)(72206003)(110136005)(14454004)(105586002)(106356001)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5120;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8WafMo/k5oKYhwLjJTWig+bx/B9wdPHAKTslhOyVFAkRICkbrmhRQF9xv8PC2UZzCLuK8Wd/GCHP5cLbuX07Ru2TE1QNGSN8INoH8xzHtJ7cvGZqs/tSpEDkD/RyUvSErgzxt5vqFGyHT6F7FqwUx9HmWlAX6kI3ixE033nfF6IjhTKvmBiuhFA4j9Z+7MLxRsxDDtXRnMtMLH2chchflJSG2oh7Hm4/QBBcB08zAPui3L1ctaZvQcA2JEcTkgKKseo4q3BsrOg7LZ+80mxYl+8TMHqq05ce2pCaZspiPefEOHzRr8N/EkDxnJiIhPiDQOFF/ZJYXVpeMc4D7qjZk9idam2RRllYjrSqelZtQQg6kA+hzzKYUf4EwkUrtxBBtJSXGw8Ypxs5WyQtIkpeONvBKIRJCPXHF+gVl3w7jhY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80de582b-c419-4119-2692-08d6b0e46f58
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 05:40:48.5142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5120
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/21/19 4:12 PM, Christoph Hellwig wrote:=0A=
> Remove two pointless local variables, remove ret assignment that is=0A=
> never used, move the use_sgl initialization closer to where it is used.=
=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   drivers/nvme/host/pci.c | 17 +++++------------=0A=
>   1 file changed, 5 insertions(+), 12 deletions(-)=0A=
> =0A=
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c=0A=
> index 38869f59c296..9ec0704d5f78 100644=0A=
> --- a/drivers/nvme/host/pci.c=0A=
> +++ b/drivers/nvme/host/pci.c=0A=
> @@ -840,10 +840,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *d=
ev, struct request *req,=0A=
>   		struct nvme_command *cmnd)=0A=
>   {=0A=
>   	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);=0A=
> -	struct request_queue *q =3D req->q;=0A=
> -	enum dma_data_direction dma_dir =3D rq_data_dir(req) ?=0A=
> -			DMA_TO_DEVICE : DMA_FROM_DEVICE;=0A=
> -	blk_status_t ret =3D BLK_STS_IOERR;=0A=
> +	blk_status_t ret =3D BLK_STS_RESOURCE;=0A=
>   	int nr_mapped;=0A=
>   =0A=
>   	if (blk_rq_nr_phys_segments(req) =3D=3D 1) {=0A=
> @@ -865,25 +862,21 @@ static blk_status_t nvme_map_data(struct nvme_dev *=
dev, struct request *req,=0A=
>   	iod->sg =3D mempool_alloc(dev->iod_mempool, GFP_ATOMIC);=0A=
>   	if (!iod->sg)=0A=
>   		return BLK_STS_RESOURCE;=0A=
> -=0A=
> -	iod->use_sgl =3D nvme_pci_use_sgls(dev, req);=0A=
> -=0A=
>   	sg_init_table(iod->sg, blk_rq_nr_phys_segments(req));=0A=
> -	iod->nents =3D blk_rq_map_sg(q, req, iod->sg);=0A=
> +	iod->nents =3D blk_rq_map_sg(req->q, req, iod->sg);=0A=
>   	if (!iod->nents)=0A=
>   		goto out;=0A=
>   =0A=
> -	ret =3D BLK_STS_RESOURCE;=0A=
> -=0A=
>   	if (is_pci_p2pdma_page(sg_page(iod->sg)))=0A=
>   		nr_mapped =3D pci_p2pdma_map_sg(dev->dev, iod->sg, iod->nents,=0A=
> -					  dma_dir);=0A=
> +					      rq_dma_dir(req));=0A=
>   	else=0A=
>   		nr_mapped =3D dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,=0A=
> -					     dma_dir,  DMA_ATTR_NO_WARN);=0A=
> +					     rq_dma_dir(req), DMA_ATTR_NO_WARN);=0A=
>   	if (!nr_mapped)=0A=
>   		goto out;=0A=
>   =0A=
> +	iod->use_sgl =3D nvme_pci_use_sgls(dev, req);=0A=
>   	if (iod->use_sgl)=0A=
>   		ret =3D nvme_pci_setup_sgls(dev, req, &cmnd->rw, nr_mapped);=0A=
>   	else=0A=
>=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
