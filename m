Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058B2C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6D220685
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KcJqgbE4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WtRc4Gp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfCYFal (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:30:41 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:1146 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfCYFak (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 01:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553491841; x=1585027841;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rqCLpxLJdFJR09czdhu9mCFSb8IP2LEM4QliFRMbwJ0=;
  b=KcJqgbE4aQsoRMWlDezveTEb+streoW5VL02PswnYGrnElUCxJfxoebH
   z6PbFvkmWcpCywDUNfgwDfNRXNSELCUSVK7FKMyK5g79saPmljKm2XL4q
   2SZK9fun7tTsfeNZ+NQNr7TS6YT7xkut3pY2aj3Ptx2FNe0SRcMxZ9imC
   lYRmfNjq1SU3W2Fa8AmQTPESHbHNHXdoE7UHdCN7fNzg9rA9K5jQuMMX3
   hFJbJ/sJ//hR5sHv6pW9bnnlK3DdtYs+fE4w3FDYZBr1xuWwwStI0pXua
   RKrlM7ax8nXGOnJyhudHnIYx88vGPOmwut/O3GnQHnhSuNxUyKl0V3VIK
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,256,1549900800"; 
   d="scan'208";a="104128746"
Received: from mail-bn3nam01lp2051.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.51])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2019 13:30:40 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1CLVGFvVdenWrrLfIeithL8t0Vo17lpoksADRRv5lU=;
 b=WtRc4Gp7nXu3OTFB9ReCmBOUpi2fP84R2x90YZKAR6xKeVyQUm7u5OHtCOk+RpNmRdeNadFsWRBWm/nWn38EKFOStSWCXGKg6d2mqKA7/3qPj82SWnLDWC1x51oTQMeMYBQ4gQtfZpHEwr8NjkbezCcysuuO7q7qYiedK/XsAxA=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4014.namprd04.prod.outlook.com (52.135.82.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Mon, 25 Mar 2019 05:30:38 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%2]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 05:30:38 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 12/15] nvme-pci: remove the inline scatterlist
 optimization
Thread-Topic: [PATCH 12/15] nvme-pci: remove the inline scatterlist
 optimization
Thread-Index: AQHU4DuDYiJAwn9z9EmT0sOQfZmEqQ==
Date:   Mon, 25 Mar 2019 05:30:38 +0000
Message-ID: <SN6PR04MB4527EDD559B724430E1CA017865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-13-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.255.45.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3adf1170-4057-43ca-16e1-08d6b0e3036f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4014;
x-ms-traffictypediagnostic: SN6PR04MB4014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB401468FB3DAD4EC9A7507550865E0@SN6PR04MB4014.namprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(346002)(39860400002)(396003)(189003)(199004)(14444005)(256004)(478600001)(72206003)(2906002)(446003)(81166006)(316002)(105586002)(8676002)(9686003)(81156014)(54906003)(53936002)(14454004)(110136005)(55016002)(68736007)(106356001)(6116002)(3846002)(25786009)(4326008)(97736004)(74316002)(6246003)(5660300002)(66066001)(33656002)(71200400001)(71190400001)(6436002)(86362001)(99286004)(53546011)(6506007)(76176011)(305945005)(102836004)(52536014)(7696005)(486006)(476003)(8936002)(26005)(7736002)(186003)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4014;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oU/QDL2oI7WhmVN+2rhbnD7FQXiHep9T9qDsvVtaMmHfh2hwVoVRLywjlVIFonaSWMwhKJwMKjYyH5vmgXEmWh9UPYkDusDkZUI4rhmhgkYeBwE3AmrHpGCIeHRGn9AWAmkReker+hytEzVkERv4Q3swPesd2fAFWcmvHJ7NkBdGzHNPRta94mas3i34vwoJpzuGZxgTTOXpXhJiigGCZchb1hpcf8w3e5WS+9gFM/5TmLW+3YpsJ2WYHeA/oBBxi5bVC1rge4NrE1Qiaz3e3z4pNYllYT55QJi+aEGMFpnIUy1bkpCNQ0naE8s4f1LooacYwKYNnYxwMVHWbL6Y25aIgeSp5AJDFlApCnP6ge/mQRDnB4nKzIZYbTux1OQcV4q6C97QxLS3Nd2j6+i1wAZHiiepWcGHGpNomdZZ9K4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adf1170-4057-43ca-16e1-08d6b0e3036f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 05:30:38.0360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4014
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/21/19 4:12 PM, Christoph Hellwig wrote:=0A=
> We'll have a better way to optimize for small I/O that doesn't=0A=
> require it soon, so remove the existing inline_sg case to make that=0A=
> optimization easier to implement.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   drivers/nvme/host/pci.c | 38 ++++++--------------------------------=0A=
>   1 file changed, 6 insertions(+), 32 deletions(-)=0A=
> =0A=
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c=0A=
> index cf29d079ad5b..c6047935e825 100644=0A=
> --- a/drivers/nvme/host/pci.c=0A=
> +++ b/drivers/nvme/host/pci.c=0A=
> @@ -223,7 +223,6 @@ struct nvme_iod {=0A=
>   	dma_addr_t first_dma;=0A=
>   	dma_addr_t meta_dma;=0A=
>   	struct scatterlist *sg;=0A=
> -	struct scatterlist inline_sg[0];=0A=
>   };=0A=
>   =0A=
>   /*=0A=
> @@ -370,12 +369,6 @@ static bool nvme_dbbuf_update_and_check_event(u16 va=
lue, u32 *dbbuf_db,=0A=
>   	return true;=0A=
>   }=0A=
>   =0A=
> -/*=0A=
> - * Max size of iod being embedded in the request payload=0A=
> - */=0A=
> -#define NVME_INT_PAGES		2=0A=
> -#define NVME_INT_BYTES(dev)	(NVME_INT_PAGES * (dev)->ctrl.page_size)=0A=
> -=0A=
>   /*=0A=
>    * Will slightly overestimate the number of pages needed.  This is OK=
=0A=
>    * as it only leads to a small amount of wasted memory for the lifetime=
 of=0A=
> @@ -410,15 +403,6 @@ static unsigned int nvme_pci_iod_alloc_size(struct n=
vme_dev *dev,=0A=
>   	return alloc_size + sizeof(struct scatterlist) * nseg;=0A=
>   }=0A=
>   =0A=
> -static unsigned int nvme_pci_cmd_size(struct nvme_dev *dev, bool use_sgl=
)=0A=
> -{=0A=
> -	unsigned int alloc_size =3D nvme_pci_iod_alloc_size(dev,=0A=
> -				    NVME_INT_BYTES(dev), NVME_INT_PAGES,=0A=
> -				    use_sgl);=0A=
> -=0A=
> -	return sizeof(struct nvme_iod) + alloc_size;=0A=
> -}=0A=
> -=0A=
>   static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,=
=0A=
>   				unsigned int hctx_idx)=0A=
>   {=0A=
> @@ -621,8 +605,7 @@ static void nvme_unmap_data(struct nvme_dev *dev, str=
uct request *req)=0A=
>   		dma_addr =3D next_dma_addr;=0A=
>   	}=0A=
>   =0A=
> -	if (iod->sg !=3D iod->inline_sg)=0A=
> -		mempool_free(iod->sg, dev->iod_mempool);=0A=
> +	mempool_free(iod->sg, dev->iod_mempool);=0A=
>   }=0A=
>   =0A=
>   static void nvme_print_sgl(struct scatterlist *sgl, int nents)=0A=
> @@ -822,14 +805,9 @@ static blk_status_t nvme_map_data(struct nvme_dev *d=
ev, struct request *req,=0A=
>   	blk_status_t ret =3D BLK_STS_IOERR;=0A=
>   	int nr_mapped;=0A=
>   =0A=
> -	if (blk_rq_payload_bytes(req) > NVME_INT_BYTES(dev) ||=0A=
> -	    blk_rq_nr_phys_segments(req) > NVME_INT_PAGES) {=0A=
> -		iod->sg =3D mempool_alloc(dev->iod_mempool, GFP_ATOMIC);=0A=
> -		if (!iod->sg)=0A=
> -			return BLK_STS_RESOURCE;=0A=
> -	} else {=0A=
> -		iod->sg =3D iod->inline_sg;=0A=
> -	}=0A=
> +	iod->sg =3D mempool_alloc(dev->iod_mempool, GFP_ATOMIC);=0A=
> +	if (!iod->sg)=0A=
> +		return BLK_STS_RESOURCE;=0A=
>   =0A=
>   	iod->use_sgl =3D nvme_pci_use_sgls(dev, req);=0A=
>   =0A=
> @@ -1619,7 +1597,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *d=
ev)=0A=
>   		dev->admin_tagset.queue_depth =3D NVME_AQ_MQ_TAG_DEPTH;=0A=
>   		dev->admin_tagset.timeout =3D ADMIN_TIMEOUT;=0A=
>   		dev->admin_tagset.numa_node =3D dev_to_node(dev->dev);=0A=
> -		dev->admin_tagset.cmd_size =3D nvme_pci_cmd_size(dev, false);=0A=
> +		dev->admin_tagset.cmd_size =3D sizeof(struct nvme_iod);=0A=
>   		dev->admin_tagset.flags =3D BLK_MQ_F_NO_SCHED;=0A=
>   		dev->admin_tagset.driver_data =3D dev;=0A=
>   =0A=
> @@ -2266,11 +2244,7 @@ static int nvme_dev_add(struct nvme_dev *dev)=0A=
>   		dev->tagset.numa_node =3D dev_to_node(dev->dev);=0A=
>   		dev->tagset.queue_depth =3D=0A=
>   				min_t(int, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;=0A=
> -		dev->tagset.cmd_size =3D nvme_pci_cmd_size(dev, false);=0A=
> -		if ((dev->ctrl.sgls & ((1 << 0) | (1 << 1))) && sgl_threshold) {=0A=
> -			dev->tagset.cmd_size =3D max(dev->tagset.cmd_size,=0A=
> -					nvme_pci_cmd_size(dev, true));=0A=
> -		}=0A=
> +		dev->tagset.cmd_size =3D sizeof(struct nvme_iod);=0A=
>   		dev->tagset.flags =3D BLK_MQ_F_SHOULD_MERGE;=0A=
>   		dev->tagset.driver_data =3D dev;=0A=
>   =0A=
>=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
