Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88E9C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40872083D
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OLK3D0ba";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YYmEE+Z5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfCYFTl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:19:41 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24159 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfCYFTk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 01:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553491179; x=1585027179;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=R4GP79c0sEmtvIKOQ/CI6S6BOpfJcRZ0yoaRT9G/TBM=;
  b=OLK3D0baXPamUkDSz2jigzZT2I/N7qU3OWIrqUqtDK5gbT7t+uTLQD+t
   e6GEW2JgZpokYw8R0bItjGYcbR6aABpIXTEPndttst/stjriAvgPhyPfa
   PWRWxJHdDwZyYfrkiIEVHq1xMIFIU/D5Eb4DUX24lTzBFRm3IDU3Do0pI
   OqB+cxVXJJlcc6HDPm/VrtFSEbai3pn8tHPOlfkJB6+STvIqSywuhxr4o
   gBQwyQyC4w4OBFyMXKk3PrYnFCZJHEQSpClCXxHBqg+y3FgjSG8IWrSmn
   SWnFBy5YATVSVdfFCRCvpaIbYLM2Ag5q86AEQ+9EkcwEbZCEursBSRPlJ
   A==;
X-IronPort-AV: E=Sophos;i="5.60,256,1549900800"; 
   d="scan'208";a="105868928"
Received: from mail-co1nam05lp2051.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.51])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2019 13:19:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcVCtLDYD0M1uYlNuWl0MR43qOMTH1Y865rT1rEhZCM=;
 b=YYmEE+Z5z9VelTeIpHzjM8cZo2rmdsxxneRbYWc07Dcr1GseFvB8kloCmdoz0w5DsNP5oqRnSslXeWyVRZfjE/pzJTUXx8f89PKJMat+EyWT5q7KzyPkiogfJuvUJT2LUrUmTR1BE+p3PkdC3pw6E4kpHamP5KKDQ87LXUtqe+A=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4398.namprd04.prod.outlook.com (52.135.72.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 05:19:34 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%2]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 05:19:34 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 06/15] nvme-pci: remove nvme_init_iod
Thread-Topic: [PATCH 06/15] nvme-pci: remove nvme_init_iod
Thread-Index: AQHU4DtvZBnebV6ua0ex+A8GwzuN2A==
Date:   Mon, 25 Mar 2019 05:19:34 +0000
Message-ID: <SN6PR04MB45279F1612542CB815A5E3DA865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3883fceb-81d9-4734-c27f-08d6b0e177bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4398;
x-ms-traffictypediagnostic: SN6PR04MB4398:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB43985D5BD451A2AF13BD2C5D865E0@SN6PR04MB4398.namprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(136003)(366004)(199004)(189003)(7736002)(68736007)(86362001)(478600001)(97736004)(446003)(72206003)(4326008)(25786009)(476003)(486006)(14454004)(229853002)(7696005)(8936002)(76176011)(6436002)(5660300002)(305945005)(26005)(52536014)(102836004)(81156014)(81166006)(8676002)(53546011)(6506007)(66066001)(6246003)(53936002)(316002)(110136005)(99286004)(55016002)(54906003)(74316002)(9686003)(71200400001)(256004)(33656002)(106356001)(6116002)(14444005)(3846002)(71190400001)(2906002)(105586002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4398;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rwzpRphMd/HPHeJbsFEASAGCdRciX6vTxsU2HJU6qiftYFQw1zaWlu6e4rB0TyqYkVNdm7OWXOu1+Ncc7PTRmqOjCONjVpY+SYZDkbQNfBI4ZaoxyQ+rksulranhGKFuGIU+GleiUH+19kzOeWZc+RBbFDr0KnjVpwjRbT/IBO+aXFOqQx8vCsdRExEdDPm5erEnghNZjxAaL64mEItaY+Rw4/gtLMWGtUlimHUe8BjAjGoxw++HrLVldKx3kevJIouBxRVOtrWfQnJoj4m6fVidicMJpjU4UnVHau3qWeAwbb96VX9YWj91N9tZFo3BRG8Amql9xFovB1wyJc1ahTI1w9bzOB0b9fj/DxZC+v/5uxHJ0e/xOqrcv7rIKG+zGyOuaq6Bsu004HJteZ3+sTJTG8GNizzpZJeMwWth4+Y=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3883fceb-81d9-4734-c27f-08d6b0e177bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 05:19:34.1389
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
> nvme_init_iod should really be split into two parts: initialize a few=0A=
> general iod fields, which can easily be done at the beginning of=0A=
> nvme_queue_rq, and allocating the scatterlist if needed, which logically=
=0A=
> belongs into nvme_map_data with the code making use of it.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   drivers/nvme/host/pci.c | 56 ++++++++++++++++-------------------------=
=0A=
>   1 file changed, 22 insertions(+), 34 deletions(-)=0A=
> =0A=
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c=0A=
> index bf0d71fe243e..3f06e942fb47 100644=0A=
> --- a/drivers/nvme/host/pci.c=0A=
> +++ b/drivers/nvme/host/pci.c=0A=
> @@ -208,10 +208,10 @@ struct nvme_queue {=0A=
>   };=0A=
>   =0A=
>   /*=0A=
> - * The nvme_iod describes the data in an I/O, including the list of PRP=
=0A=
> - * entries.  You can't see it in this data structure because C doesn't l=
et=0A=
> - * me express that.  Use nvme_init_iod to ensure there's enough space=0A=
> - * allocated to store the PRP list.=0A=
> + * The nvme_iod describes the data in an I/O.=0A=
> + *=0A=
> + * The sg pointer contains the list of PRP/SGL chunk allocations in addi=
tion=0A=
> + * to the actual struct scatterlist.=0A=
>    */=0A=
>   struct nvme_iod {=0A=
>   	struct nvme_request req;=0A=
> @@ -583,29 +583,6 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev=
 *dev, struct request *req)=0A=
>   	return true;=0A=
>   }=0A=
>   =0A=
> -static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *d=
ev)=0A=
> -{=0A=
> -	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(rq);=0A=
> -	int nseg =3D blk_rq_nr_phys_segments(rq);=0A=
> -	unsigned int size =3D blk_rq_payload_bytes(rq);=0A=
> -=0A=
> -	iod->use_sgl =3D nvme_pci_use_sgls(dev, rq);=0A=
> -=0A=
> -	if (nseg > NVME_INT_PAGES || size > NVME_INT_BYTES(dev)) {=0A=
> -		iod->sg =3D mempool_alloc(dev->iod_mempool, GFP_ATOMIC);=0A=
> -		if (!iod->sg)=0A=
> -			return BLK_STS_RESOURCE;=0A=
> -	} else {=0A=
> -		iod->sg =3D iod->inline_sg;=0A=
> -	}=0A=
> -=0A=
> -	iod->aborted =3D 0;=0A=
> -	iod->npages =3D -1;=0A=
> -	iod->nents =3D 0;=0A=
> -=0A=
> -	return BLK_STS_OK;=0A=
> -}=0A=
> -=0A=
>   static void nvme_free_iod(struct nvme_dev *dev, struct request *req)=0A=
>   {=0A=
>   	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);=0A=
> @@ -837,6 +814,17 @@ static blk_status_t nvme_map_data(struct nvme_dev *d=
ev, struct request *req,=0A=
>   	blk_status_t ret =3D BLK_STS_IOERR;=0A=
>   	int nr_mapped;=0A=
>   =0A=
> +	if (blk_rq_payload_bytes(req) > NVME_INT_BYTES(dev) ||=0A=
> +	    blk_rq_nr_phys_segments(req) > NVME_INT_PAGES) {=0A=
> +		iod->sg =3D mempool_alloc(dev->iod_mempool, GFP_ATOMIC);=0A=
> +		if (!iod->sg)=0A=
> +			return BLK_STS_RESOURCE;=0A=
> +	} else {=0A=
> +		iod->sg =3D iod->inline_sg;=0A=
> +	}=0A=
> +=0A=
> +	iod->use_sgl =3D nvme_pci_use_sgls(dev, req);=0A=
> +=0A=
>   	sg_init_table(iod->sg, blk_rq_nr_phys_segments(req));=0A=
>   	iod->nents =3D blk_rq_map_sg(q, req, iod->sg);=0A=
>   	if (!iod->nents)=0A=
> @@ -881,6 +869,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *de=
v, struct request *req,=0A=
>   out_unmap:=0A=
>   	dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);=0A=
>   out:=0A=
> +	nvme_free_iod(dev, req);=0A=
>   	return ret;=0A=
>   }=0A=
>   =0A=
> @@ -913,9 +902,14 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_c=
tx *hctx,=0A=
>   	struct nvme_queue *nvmeq =3D hctx->driver_data;=0A=
>   	struct nvme_dev *dev =3D nvmeq->dev;=0A=
>   	struct request *req =3D bd->rq;=0A=
> +	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);=0A=
>   	struct nvme_command cmnd;=0A=
>   	blk_status_t ret;=0A=
>   =0A=
> +	iod->aborted =3D 0;=0A=
> +	iod->npages =3D -1;=0A=
> +	iod->nents =3D 0;=0A=
> +=0A=
Maybe add an inline helper for above default IOD initialization ?=0A=
>   	/*=0A=
>   	 * We should not need to do this, but we're still using this to=0A=
>   	 * ensure we can drain requests on a dying queue.=0A=
> @@ -927,21 +921,15 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_=
ctx *hctx,=0A=
>   	if (ret)=0A=
>   		return ret;=0A=
>   =0A=
> -	ret =3D nvme_init_iod(req, dev);=0A=
> -	if (ret)=0A=
> -		goto out_free_cmd;=0A=
> -=0A=
>   	if (blk_rq_nr_phys_segments(req)) {=0A=
>   		ret =3D nvme_map_data(dev, req, &cmnd);=0A=
>   		if (ret)=0A=
> -			goto out_cleanup_iod;=0A=
> +			goto out_free_cmd;=0A=
>   	}=0A=
>   =0A=
>   	blk_mq_start_request(req);=0A=
>   	nvme_submit_cmd(nvmeq, &cmnd, bd->last);=0A=
>   	return BLK_STS_OK;=0A=
> -out_cleanup_iod:=0A=
> -	nvme_free_iod(dev, req);=0A=
>   out_free_cmd:=0A=
>   	nvme_cleanup_cmd(req);=0A=
>   	return ret;=0A=
> =0A=
=0A=
Otherwise, looks good.=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
