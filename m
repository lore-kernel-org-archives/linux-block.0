Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDACCC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA762075D
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Qv7YEIyu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="D5udSbIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfCYFgX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:36:23 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:53480 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbfCYFgX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 01:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553492183; x=1585028183;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=C4KKPQYwcFVj6TOSrWaHOSd0mw1Ak50mgEodkxfTCJc=;
  b=Qv7YEIyuUAwZLzJrTEWBUb8QAgARsb9+9Op/ToW3E28O2XhKcg7WBSxP
   tqp132R3O0X0VPZAUWpQS6/AjdKhd0XzyKzl6kNv3WU2x3Hfxb2CNhVnQ
   JFbmjW9T9p/3f7MUZxi3uKg0LNE/gih9iB+H3dMHy/I9nd0VZBVFK4xcv
   ROpFbSuvHesH+P3rajMpIGz0D35vkAqu01AgG9/kgur+ZIfiaMGcO6xqh
   +Tf4hA1TOEzbg7Evn29MmFb/aALtccGt9twU2ViuooCqnQhf/tRQsqdN2
   bRALCcEor4ZnuwzCFljC03awvehLJGONDVnYSSWQKgfZyHsi101kRDb5i
   w==;
X-IronPort-AV: E=Sophos;i="5.60,256,1549900800"; 
   d="scan'208";a="109190744"
Received: from mail-co1nam03lp2052.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.52])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2019 13:36:22 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKc6xSoNIbsg11zP7X+VVpJo0j3bpxVMppxwmrUcUmk=;
 b=D5udSbIfCUpklZdXZ7XE5bnSU3Jfr1CqkPUAVfLWXNjQOIYrf1OIJybss0pwKGIG+jFGTI01Tq6RWTDHGgxSFCWkxlFtv/8NI2/ofJsGTpcdLh0v259IfNycMQkIK2cSQFAHCfuPBCIH2MAyjVg7kj7q6EPTzTTXkTxevGaW/yM=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB5120.namprd04.prod.outlook.com (52.135.116.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Mon, 25 Mar 2019 05:36:18 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%2]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 05:36:18 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 13/15] nvme-pci: optimize mapping of small single segment
 requests
Thread-Topic: [PATCH 13/15] nvme-pci: optimize mapping of small single segment
 requests
Thread-Index: AQHU4DuGa4+KfKJ9r0SBkCXoWPupfA==
Date:   Mon, 25 Mar 2019 05:36:18 +0000
Message-ID: <SN6PR04MB45278E0897CCD5C2069E745B865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-14-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f66b2b95-bc75-4712-bd52-08d6b0e3ce83
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB5120;
x-ms-traffictypediagnostic: SN6PR04MB5120:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB5120CA3A2B14F5B62D1FA906865E0@SN6PR04MB5120.namprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(305945005)(74316002)(53936002)(7736002)(7696005)(6436002)(5660300002)(256004)(14444005)(25786009)(486006)(106356001)(105586002)(54906003)(72206003)(110136005)(14454004)(316002)(66066001)(99286004)(6506007)(33656002)(53546011)(97736004)(68736007)(102836004)(76176011)(81156014)(8676002)(476003)(186003)(26005)(229853002)(8936002)(81166006)(52536014)(478600001)(446003)(6116002)(4326008)(71190400001)(71200400001)(9686003)(3846002)(55016002)(86362001)(6246003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5120;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vm7E+EbVq92Pr/AKHjErgmApupPqKVjrRP5Af5/C429j5GDkPleTagSaxHS2Hw6Xg4IuNA1wdsjwzy6Q5e2Kd/YaRp/GQxdioDV7/ae3/qzxVs6BPobpoBDAla+GZrN8LwFBI5MBFtOEu2kl6UDeAg06bRNDCYdF61SrRmTCE8UPVQquxlW8XqhcTbWGccVf/wrysz0laiBKku7g3Lo04y+CiZvkRfFxpjRS26A89fKO/Y64LCWORksZ78V1ItKpIn383DYryNFAWSSRZsvnhU8axndU0YiBe4fwtS1MgNkRkCG6ytJZ+81yZ5IKcqpWaZf+7qfcMrXE5YTCU+JKrql9E1zJtMa7OlNcHMhsuCSHopHK3tpTYCa6H27fbhvhcYoARKUYbISfDXy8nQ3bt1MP40T5hfZcjcjPv80eJW4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66b2b95-bc75-4712-bd52-08d6b0e3ce83
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 05:36:18.7228
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
> If a request is single segment and fits into one or two PRP entries we=0A=
> do not have to create a scatterlist for it, but can just map the bio_vec=
=0A=
> directly.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   drivers/nvme/host/pci.c | 45 ++++++++++++++++++++++++++++++++++++-----=
=0A=
>   1 file changed, 40 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c=0A=
> index c6047935e825..47fc4d653961 100644=0A=
> --- a/drivers/nvme/host/pci.c=0A=
> +++ b/drivers/nvme/host/pci.c=0A=
> @@ -221,6 +221,7 @@ struct nvme_iod {=0A=
>   	int npages;		/* In the PRP list. 0 means small pool in use */=0A=
>   	int nents;		/* Used in scatterlist */=0A=
>   	dma_addr_t first_dma;=0A=
> +	unsigned int dma_len;	/* length of single DMA segment mapping */=0A=
>   	dma_addr_t meta_dma;=0A=
>   	struct scatterlist *sg;=0A=
>   };=0A=
> @@ -576,13 +577,18 @@ static void nvme_unmap_data(struct nvme_dev *dev, s=
truct request *req)=0A=
>   	dma_addr_t dma_addr =3D iod->first_dma, next_dma_addr;=0A=
>   	int i;=0A=
>   =0A=
> -	if (iod->nents) {=0A=
> -		/* P2PDMA requests do not need to be unmapped */=0A=
> -		if (!is_pci_p2pdma_page(sg_page(iod->sg)))=0A=
> -			dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);=0A=
> -=0A=
> +	if (iod->dma_len) {=0A=
> +		dma_unmap_page(dev->dev, dma_addr, iod->dma_len, dma_dir);=0A=
> +		return;=0A=
>   	}=0A=
>   =0A=
> +	WARN_ON_ONCE(!iod->nents);=0A=
> +=0A=
> +	/* P2PDMA requests do not need to be unmapped */=0A=
> +	if (!is_pci_p2pdma_page(sg_page(iod->sg)))=0A=
> +		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));=0A=
> +=0A=
> +=0A=
>   	if (iod->npages =3D=3D 0)=0A=
>   		dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],=0A=
>   			dma_addr);=0A=
> @@ -795,6 +801,24 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_=
dev *dev,=0A=
>   	return BLK_STS_OK;=0A=
>   }=0A=
>   =0A=
> +static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,=0A=
> +		struct request *req, struct nvme_rw_command *cmnd,=0A=
> +		struct bio_vec *bv)=0A=
> +{=0A=
> +	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);=0A=
> +	unsigned int first_prp_len =3D dev->ctrl.page_size - bv->bv_offset;=0A=
> +=0A=
> +	iod->first_dma =3D dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);=0A=
> +	if (dma_mapping_error(dev->dev, iod->first_dma))=0A=
> +		return BLK_STS_RESOURCE;=0A=
> +	iod->dma_len =3D bv->bv_len;=0A=
> +=0A=
> +	cmnd->dptr.prp1 =3D cpu_to_le64(iod->first_dma);=0A=
> +	if (bv->bv_len > first_prp_len)=0A=
> +		cmnd->dptr.prp2 =3D cpu_to_le64(iod->first_dma + first_prp_len);=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
>   static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request =
*req,=0A=
>   		struct nvme_command *cmnd)=0A=
>   {=0A=
> @@ -805,6 +829,17 @@ static blk_status_t nvme_map_data(struct nvme_dev *d=
ev, struct request *req,=0A=
>   	blk_status_t ret =3D BLK_STS_IOERR;=0A=
>   	int nr_mapped;=0A=
>   =0A=
> +	if (blk_rq_nr_phys_segments(req) =3D=3D 1) {=0A=
> +		struct bio_vec bv =3D req_bvec(req);=0A=
> +=0A=
> +		if (!is_pci_p2pdma_page(bv.bv_page)) {=0A=
> +			if (bv.bv_offset + bv.bv_len <=3D dev->ctrl.page_size * 2)=0A=
> +				return nvme_setup_prp_simple(dev, req,=0A=
> +							     &cmnd->rw, &bv);=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	iod->dma_len =3D 0;=0A=
>   	iod->sg =3D mempool_alloc(dev->iod_mempool, GFP_ATOMIC);=0A=
>   	if (!iod->sg)=0A=
>   		return BLK_STS_RESOURCE;=0A=
> =0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
