Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D949C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5221020863
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C72WoPc1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cXI+C/Ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfCYF1U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:27:20 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:65462 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfCYF1U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 01:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553491640; x=1585027640;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=LuF4mQ2MfUV9vwghzCCEJ2vkXeG5JnVBA9MPPbxHTl4=;
  b=C72WoPc16M1GtP99ZsLGnYDP+mJ51RxyASSxAST44GAZlxVgQzz8QE1o
   DPVZ4cI9de9T0r86/wTVUwsJViiuqftSItmZI8TSeSuFipD5mUa133L1N
   6T9SbktctEd6G9Ju3cHFYVnGlxplkqgqtVnKq+m0y9LO/o9rjQz8TImgh
   gD2P+SjhN+HAn5UIoc8VFVg/s80WMbryJ7fLnJcCHXQO8jRGILzx1iqzZ
   QZftj1Xl6Xz0zBqP+daH3+1tpkZoWqq2tNJVfiLuPLqrL8Lnpzoe21Row
   8w3aOqBU57DJz7qDzmp8Y6PWz7SyL1i7RUCw4yl6byFx6jF5xGeZyw5H6
   A==;
X-IronPort-AV: E=Sophos;i="5.60,256,1549900800"; 
   d="scan'208";a="104128620"
Received: from mail-bn3nam04lp2056.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.56])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2019 13:27:20 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJSCfjwdCm/gFxtkNFdO5QrlPtCN9VxL4vAdAuPDnzA=;
 b=cXI+C/Ugfbo+6KfOdT0h5m4269o/bgxrBzFR6b2+1TtapWlhPPE7rJn0k5FEucko7TIeqOHx6Eu6TPyyZn0bQUkeeToioGNpNN4m9TC0yPhpwfezu0V+BAdkQV/HzO2Rd9k/LZrwrYnROIzCpsL/v28iIMicgV386SS6Hxocja8=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4398.namprd04.prod.outlook.com (52.135.72.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 05:27:17 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%2]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 05:27:17 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 10/15] nvme-pci: do not build a scatterlist to map
 metadata
Thread-Topic: [PATCH 10/15] nvme-pci: do not build a scatterlist to map
 metadata
Thread-Index: AQHU4Dt9ufpIxIk1Y0akT44+UtELuQ==
Date:   Mon, 25 Mar 2019 05:27:17 +0000
Message-ID: <SN6PR04MB4527703215979281EE3C18A9865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd7ae2b8-0a28-495e-3301-08d6b0e28bfe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4398;
x-ms-traffictypediagnostic: SN6PR04MB4398:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4398BAE1982A383039A598D1865E0@SN6PR04MB4398.namprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(136003)(366004)(199004)(189003)(7736002)(68736007)(86362001)(478600001)(97736004)(446003)(72206003)(4326008)(25786009)(476003)(486006)(14454004)(229853002)(7696005)(8936002)(76176011)(6436002)(5660300002)(305945005)(26005)(52536014)(102836004)(81156014)(81166006)(8676002)(53546011)(6506007)(66066001)(6246003)(53936002)(316002)(110136005)(99286004)(55016002)(54906003)(74316002)(9686003)(71200400001)(256004)(33656002)(106356001)(6116002)(14444005)(3846002)(71190400001)(2906002)(105586002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4398;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dGL38psSfiSrZSVB7Qxne0dGpibQSTFP45nmPI6SaBclB6wvQ5lvAE19norC7dRCffDxTkDf83QepT90bDRWf8MGNjvN0bQEb4jYB93qE67ztBtAzr6HxD4czWU9gkPfx6c9qYJmRS4PIknoBrnGWjc7G0KWLNdRa2YvwEalPZdgkDhmnSd97oVHO8oABr63c7gQtyfPnlYIfgAdmklbnt0da3iSs1VGn1NQuCJeYR0lUfDqy4+yUl/xlgvCc2w3z5gSbGBqr5952NKvV3xxtQasUsGCLl62g2eJMqaflEju2wVPSjSngjhmb6rG5/nuOyc3QRDacQWWDB9KSowwW8BoX44UZEfxdzikfuTJpRISGsW/1JIWpTkIOpIn9JwClouzQNW7LFo2YnAZDf5bgQymmPnoLHvL07lXgWokFLc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7ae2b8-0a28-495e-3301-08d6b0e28bfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 05:27:17.6122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4398
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/21/19 4:12 PM, Christoph Hellwig wrote:=0A=
> We always have exactly one segment, so we can simply call dma_map_bvec.=
=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   drivers/nvme/host/pci.c | 23 ++++++++++-------------=0A=
>   1 file changed, 10 insertions(+), 13 deletions(-)=0A=
> =0A=
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c=0A=
> index bc4ee869fe82..a7dad24e0406 100644=0A=
> --- a/drivers/nvme/host/pci.c=0A=
> +++ b/drivers/nvme/host/pci.c=0A=
> @@ -221,7 +221,7 @@ struct nvme_iod {=0A=
>   	int npages;		/* In the PRP list. 0 means small pool in use */=0A=
>   	int nents;		/* Used in scatterlist */=0A=
>   	dma_addr_t first_dma;=0A=
> -	struct scatterlist meta_sg; /* metadata requires single contiguous buff=
er */=0A=
> +	dma_addr_t meta_dma;=0A=
>   	struct scatterlist *sg;=0A=
>   	struct scatterlist inline_sg[0];=0A=
>   };=0A=
> @@ -592,13 +592,16 @@ static void nvme_unmap_data(struct nvme_dev *dev, s=
truct request *req)=0A=
>   	dma_addr_t dma_addr =3D iod->first_dma, next_dma_addr;=0A=
>   	int i;=0A=
>   =0A=
> +	if (blk_integrity_rq(req)) {=0A=
> +		dma_unmap_page(dev->dev, iod->meta_dma,=0A=
> +				rq_integrity_vec(req)->bv_len, dma_dir);=0A=
> +	}=0A=
> +=0A=
>   	if (iod->nents) {=0A=
>   		/* P2PDMA requests do not need to be unmapped */=0A=
>   		if (!is_pci_p2pdma_page(sg_page(iod->sg)))=0A=
>   			dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);=0A=
>   =0A=
> -		if (blk_integrity_rq(req))=0A=
> -			dma_unmap_sg(dev->dev, &iod->meta_sg, 1, dma_dir);=0A=
>   	}=0A=
>   =0A=
>   	if (iod->npages =3D=3D 0)=0A=
> @@ -861,17 +864,11 @@ static blk_status_t nvme_map_data(struct nvme_dev *=
dev, struct request *req,=0A=
>   =0A=
>   	ret =3D BLK_STS_IOERR;=0A=
>   	if (blk_integrity_rq(req)) {=0A=
> -		if (blk_rq_count_integrity_sg(q, req->bio) !=3D 1)=0A=
> -			goto out;=0A=
> -=0A=
> -		sg_init_table(&iod->meta_sg, 1);=0A=
> -		if (blk_rq_map_integrity_sg(q, req->bio, &iod->meta_sg) !=3D 1)=0A=
> -			goto out;=0A=
> -=0A=
> -		if (!dma_map_sg(dev->dev, &iod->meta_sg, 1, dma_dir))=0A=
> +		iod->meta_dma =3D dma_map_bvec(dev->dev, rq_integrity_vec(req),=0A=
> +				dma_dir, 0);=0A=
> +		if (dma_mapping_error(dev->dev, iod->meta_dma))=0A=
>   			goto out;=0A=
> -=0A=
> -		cmnd->rw.metadata =3D cpu_to_le64(sg_dma_address(&iod->meta_sg));=0A=
> +		cmnd->rw.metadata =3D cpu_to_le64(iod->meta_dma);=0A=
>   	}=0A=
>   =0A=
>   	return BLK_STS_OK;=0A=
>=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
