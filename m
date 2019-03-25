Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76414C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E2420685
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S3vGuAPN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Yw0jJzRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfCYF3R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:29:17 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:1067 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfCYF3R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 01:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553491757; x=1585027757;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bwGO38E9H1rB/lwUw66ttYCox2hDRHNaQNFVLfGOFLg=;
  b=S3vGuAPNEb79XoOn1fkcxZssk1AqHedniyU1oatbBUlRQ2bWvn0xp8SI
   CLCTH5bPlG4GABuMQJF7xiRvDDxE3s1iMjOmf6HFYU0qyiGVXvM7EwEfK
   tttUV3K+/XRypmnsPgEP5/JkCZ/g89vV/7KZ04GE+HD6i25ifCZvpo+qY
   7U/hjHbIrXQQPq9qAj3GwPvz+VvvTC9fqvGPDvLqHhRH05BkycXiW6T0Q
   8SowENDveNrdPd0unJ67cMbxAhVGMs/6zP0hFNdLIMh/JQsw/issHpUAq
   silVpvV+oGrRiEdz46Wm6h8d0wGexyOcCix625xaSoOdaYVdmsI2Iusre
   A==;
X-IronPort-AV: E=Sophos;i="5.60,256,1549900800"; 
   d="scan'208";a="104128691"
Received: from mail-bn3nam01lp2055.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.55])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2019 13:29:16 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bd7R/wZKyEe6AZG1+HzSePDztevce6U9tvA4kWZgxXs=;
 b=Yw0jJzRWtFgdJEeAHkQCKH1bAWp+jZUGNfJBAtHFPxgz4gPR9WCgt/TnUJPJeyWNJzHt1CTvSVjPozQE1b0ZsxeoRj4OMEo1ej8CqJHp7Ry6Z9/4GjSNue2TWiM7b65S8wttO28RoxQFbSe3eY2SxjjvtvmYo1ruPeqb9ndFnPg=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4014.namprd04.prod.outlook.com (52.135.82.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Mon, 25 Mar 2019 05:29:14 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%2]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 05:29:14 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 11/15] nvme-pci: split metadata handling from
 nvme_map_data / nvme_unmap_data
Thread-Topic: [PATCH 11/15] nvme-pci: split metadata handling from
 nvme_map_data / nvme_unmap_data
Thread-Index: AQHU4DuAKxw60t7MTkm/n6JAmy/vJQ==
Date:   Mon, 25 Mar 2019 05:29:14 +0000
Message-ID: <SN6PR04MB4527681E200935EE2481A32A865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.255.45.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ebbe114-f21e-4cbb-4f1a-08d6b0e2d16d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4014;
x-ms-traffictypediagnostic: SN6PR04MB4014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB40142D5D3811449C77410333865E0@SN6PR04MB4014.namprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(346002)(39860400002)(396003)(189003)(199004)(14444005)(256004)(478600001)(72206003)(2906002)(446003)(81166006)(316002)(105586002)(8676002)(9686003)(81156014)(54906003)(53936002)(14454004)(110136005)(55016002)(68736007)(106356001)(6116002)(3846002)(25786009)(4326008)(97736004)(74316002)(6246003)(5660300002)(66066001)(33656002)(71200400001)(71190400001)(6436002)(86362001)(99286004)(53546011)(6506007)(76176011)(305945005)(102836004)(52536014)(7696005)(486006)(476003)(8936002)(26005)(7736002)(186003)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4014;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DxiO27ESls04fSvXbjzHK2IRFeDoxpa3ma9+DEEoPEYRme5yTpLaMAyxgDCaF9EhzqAkL9SceVuXAf7G3oYmgFcoPxG6TsrNXzq6kozIbEMdtzbicIt8VJVwjn3AcN/U0j1dAxLiPneCR1lbO3YjPLUqr8NB4uXk4aRHpoYD4O9oTxs1uwI0ycuK1aGFC0qFrgQPGz+4MeDGAfWRBd72Q3gIAp+0VTouZEqvAgJFPyrh6KVmzTbZ7sfDzainaW19bDE68b4FFl4INtAQ413M4Yr1+wTu13pVx5xekHwQ4qJJjdTPjXkxp+2V4fQ/3v97hKyihIm2gpvT17+9lAm78KaiXoCqyDNRgGs42fqv4uf3Yq3194C2yDtZfWp+VbfPeCeJcOYASnlEfXT3tq4BK8MIFqmshx/2AwqMivnSZVA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ebbe114-f21e-4cbb-4f1a-08d6b0e2d16d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 05:29:14.1012
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
> This prepares for some bigger changes to the data mapping helpers.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   drivers/nvme/host/pci.c | 48 +++++++++++++++++++++++------------------=
=0A=
>   1 file changed, 27 insertions(+), 21 deletions(-)=0A=
> =0A=
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c=0A=
> index a7dad24e0406..cf29d079ad5b 100644=0A=
> --- a/drivers/nvme/host/pci.c=0A=
> +++ b/drivers/nvme/host/pci.c=0A=
> @@ -592,11 +592,6 @@ static void nvme_unmap_data(struct nvme_dev *dev, st=
ruct request *req)=0A=
>   	dma_addr_t dma_addr =3D iod->first_dma, next_dma_addr;=0A=
>   	int i;=0A=
>   =0A=
> -	if (blk_integrity_rq(req)) {=0A=
> -		dma_unmap_page(dev->dev, iod->meta_dma,=0A=
> -				rq_integrity_vec(req)->bv_len, dma_dir);=0A=
> -	}=0A=
> -=0A=
>   	if (iod->nents) {=0A=
>   		/* P2PDMA requests do not need to be unmapped */=0A=
>   		if (!is_pci_p2pdma_page(sg_page(iod->sg)))=0A=
> @@ -858,24 +853,23 @@ static blk_status_t nvme_map_data(struct nvme_dev *=
dev, struct request *req,=0A=
>   		ret =3D nvme_pci_setup_sgls(dev, req, &cmnd->rw, nr_mapped);=0A=
>   	else=0A=
>   		ret =3D nvme_pci_setup_prps(dev, req, &cmnd->rw);=0A=
> -=0A=
> +out:=0A=
>   	if (ret !=3D BLK_STS_OK)=0A=
> -		goto out;=0A=
> -=0A=
> -	ret =3D BLK_STS_IOERR;=0A=
> -	if (blk_integrity_rq(req)) {=0A=
> -		iod->meta_dma =3D dma_map_bvec(dev->dev, rq_integrity_vec(req),=0A=
> -				dma_dir, 0);=0A=
> -		if (dma_mapping_error(dev->dev, iod->meta_dma))=0A=
> -			goto out;=0A=
> -		cmnd->rw.metadata =3D cpu_to_le64(iod->meta_dma);=0A=
> -	}=0A=
> +		nvme_unmap_data(dev, req);=0A=
> +	return ret;=0A=
> +}=0A=
>   =0A=
> -	return BLK_STS_OK;=0A=
> +static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct reque=
st *req,=0A=
> +		struct nvme_command *cmnd)=0A=
> +{=0A=
> +	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);=0A=
>   =0A=
> -out:=0A=
> -	nvme_unmap_data(dev, req);=0A=
> -	return ret;=0A=
> +	iod->meta_dma =3D dma_map_bvec(dev->dev, rq_integrity_vec(req),=0A=
> +			rq_dma_dir(req), 0);=0A=
> +	if (dma_mapping_error(dev->dev, iod->meta_dma))=0A=
> +		return BLK_STS_IOERR;=0A=
> +	cmnd->rw.metadata =3D cpu_to_le64(iod->meta_dma);=0A=
> +	return 0;=0A=
>   }=0A=
>   =0A=
>   /*=0A=
> @@ -913,9 +907,17 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_c=
tx *hctx,=0A=
>   			goto out_free_cmd;=0A=
>   	}=0A=
>   =0A=
> +	if (blk_integrity_rq(req)) {=0A=
> +		ret =3D nvme_map_metadata(dev, req, &cmnd);=0A=
> +		if (ret)=0A=
> +			goto out_unmap_data;=0A=
> +	}=0A=
> +=0A=
>   	blk_mq_start_request(req);=0A=
>   	nvme_submit_cmd(nvmeq, &cmnd, bd->last);=0A=
>   	return BLK_STS_OK;=0A=
> +out_unmap_data:=0A=
> +	nvme_unmap_data(dev, req);=0A=
>   out_free_cmd:=0A=
>   	nvme_cleanup_cmd(req);=0A=
>   	return ret;=0A=
> @@ -924,10 +926,14 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_=
ctx *hctx,=0A=
>   static void nvme_pci_complete_rq(struct request *req)=0A=
>   {=0A=
>   	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);=0A=
> +	struct nvme_dev *dev =3D iod->nvmeq->dev;=0A=
>   =0A=
>   	nvme_cleanup_cmd(req);=0A=
> +	if (blk_integrity_rq(req))=0A=
> +		dma_unmap_page(dev->dev, iod->meta_dma,=0A=
> +			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));=0A=
>   	if (blk_rq_nr_phys_segments(req))=0A=
> -		nvme_unmap_data(iod->nvmeq->dev, req);=0A=
> +		nvme_unmap_data(dev, req);=0A=
>   	nvme_complete_rq(req);=0A=
>   }=0A=
>   =0A=
> =0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
