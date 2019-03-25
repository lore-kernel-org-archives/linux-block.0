Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC956C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E562075E
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SQBHWXRa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Jyh1eRTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfCYFjj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:39:39 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:27723 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbfCYFjj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 01:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553492379; x=1585028379;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=uYs4MXX0Ucd77Vvpoxh0OsaSlciUWPIdqJlUQ4Mh2+o=;
  b=SQBHWXRaZCalAmqtNBqKbw8rKsDU6vivVmklVF6EDcesAAFrmtfioEhp
   +SgymSCdbYzZn4yAcCRWQgm9AT13X1Xn9VFxJqtB/JPYrPY1BNA7VuNsx
   gLT+ME8l4EPfp9IDCqhi/BDtPTiT+eD8DfxNeWAPnFpdbX7qsrC1orCFm
   31rUCI1BvDzTpDznvK0ThQtvDRuk7J1ZWIAMjaN7twgTXpfWKKloBrS+l
   fWSKiuSoinovG4/fKjCGrInn8cJAgAcMPDkmzox0ggy9Gz3ekdBWjojSZ
   2wJm0mjjROsCMD3n8koJ2Lj9G4LXN4dI8qHNBekl3qCHQUj41LDw30Beo
   A==;
X-IronPort-AV: E=Sophos;i="5.60,256,1549900800"; 
   d="scan'208";a="105870362"
Received: from mail-co1nam03lp2054.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.54])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2019 13:39:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czFr92I0VcvKx3AtZA9ubsZIpr7YkBYaEWkQNdqEMDs=;
 b=Jyh1eRTCeix7RmJRON6cE17qqpKxTmNODDyf4h5zE/Gb3qwbi09FG1Hrh+iloCUHBYgMI+oxSnb87FhPEBHgg6lhcFBhgrvuA1kQqqMDSlvUi89gMzfk2RZkPB84/AA9buCRVDnZPKjrB4WWB/TYIMX1xi2FSxIqAyIcv6H/kdE=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB5120.namprd04.prod.outlook.com (52.135.116.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Mon, 25 Mar 2019 05:39:35 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%2]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 05:39:35 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 14/15] nvme-pci: optimize mapping single segment requests
 using SGLs
Thread-Topic: [PATCH 14/15] nvme-pci: optimize mapping single segment requests
 using SGLs
Thread-Index: AQHU4DuH7Ij4CR7BSk2mUq9S0PKdkg==
Date:   Mon, 25 Mar 2019 05:39:35 +0000
Message-ID: <SN6PR04MB45274160A60B0803B41190A3865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-15-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [65.123.219.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b420e417-cce9-4fde-aa8e-08d6b0e443f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB5120;
x-ms-traffictypediagnostic: SN6PR04MB5120:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB5120E05345BFB94FF37C00CD865E0@SN6PR04MB5120.namprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(229853002)(26005)(81166006)(52536014)(8936002)(81156014)(186003)(8676002)(476003)(478600001)(446003)(99286004)(33656002)(53546011)(6506007)(316002)(66066001)(97736004)(68736007)(76176011)(102836004)(6246003)(2906002)(4326008)(6116002)(71200400001)(71190400001)(55016002)(3846002)(86362001)(9686003)(256004)(14444005)(5660300002)(25786009)(486006)(7696005)(305945005)(74316002)(7736002)(53936002)(6436002)(72206003)(110136005)(14454004)(105586002)(106356001)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5120;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4EQ1eAzL7rNz+TulxBeSPkppuIddnILnJfVtKCHltxnfDZnANOPMcF9Jq3JVq5lKuwdy9swaFTfcr0I9kE4cCcbcHMkkZvHQ35y720e5ctOsT+egRjdFzIPM19iiAflDhiVjPN2KMp8OFSAb8ryRKUI9TdBE5DfHWQl/y3DhSTEtQl3MjaiU4x53j9PzEJhZnUb/jAqm/NEov82TgdzFz/mltjkFPcb72/AE/usYvpGN5T8lY4kCaVidh+gZyvKPhbkx+aGXgNeW0VuDQe4qAsdnDqUOpOiRLSGQrXC2GcA2fc6lzeJtnX5Le8dUUXFeWiv9jJW+kRkZE0y/NVjJduTKpTxjXK3aQY63kXlvhCT+PDgr6bKDoJp5VPduKrloCGubi1SfJaEzF9B9yTP0IhvJyZdVAbQzdKqixWh9lMU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b420e417-cce9-4fde-aa8e-08d6b0e443f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 05:39:35.7031
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
> If the controller supports SGLs we can take another short cut for single=
=0A=
> segment request, given that we can always map those without another=0A=
> indirection structure, and thus don't need to create a scatterlist=0A=
> structure.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   drivers/nvme/host/pci.c | 22 ++++++++++++++++++++++=0A=
>   1 file changed, 22 insertions(+)=0A=
> =0A=
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c=0A=
> index 47fc4d653961..38869f59c296 100644=0A=
> --- a/drivers/nvme/host/pci.c=0A=
> +++ b/drivers/nvme/host/pci.c=0A=
> @@ -819,6 +819,23 @@ static blk_status_t nvme_setup_prp_simple(struct nvm=
e_dev *dev,=0A=
>   	return 0;=0A=
>   }=0A=
>   =0A=
> +static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,=0A=
> +		struct request *req, struct nvme_rw_command *cmnd,=0A=
> +		struct bio_vec *bv)=0A=
> +{=0A=
> +	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);=0A=
> +=0A=
> +	iod->first_dma =3D dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);=0A=
> +	if (dma_mapping_error(dev->dev, iod->first_dma))=0A=
> +		return BLK_STS_RESOURCE;=0A=
> +	iod->dma_len =3D bv->bv_len;=0A=
> +=0A=
> +	cmnd->dptr.sgl.addr =3D cpu_to_le64(iod->first_dma);=0A=
> +	cmnd->dptr.sgl.length =3D cpu_to_le32(iod->dma_len);=0A=
> +	cmnd->dptr.sgl.type =3D NVME_SGL_FMT_DATA_DESC << 4;=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
>   static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request =
*req,=0A=
>   		struct nvme_command *cmnd)=0A=
>   {=0A=
> @@ -836,6 +853,11 @@ static blk_status_t nvme_map_data(struct nvme_dev *d=
ev, struct request *req,=0A=
>   			if (bv.bv_offset + bv.bv_len <=3D dev->ctrl.page_size * 2)=0A=
>   				return nvme_setup_prp_simple(dev, req,=0A=
>   							     &cmnd->rw, &bv);=0A=
> +=0A=
> +			if (iod->nvmeq->qid &&=0A=
> +			    dev->ctrl.sgls & ((1 << 0) | (1 << 1)))=0A=
> +				return nvme_setup_sgl_simple(dev, req,=0A=
> +							     &cmnd->rw, &bv);=0A=
>   		}=0A=
>   	}=0A=
>   =0A=
> =0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
