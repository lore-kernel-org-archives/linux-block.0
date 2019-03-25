Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79424C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A332083D
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kIKNbEJG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JCOFJoMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfCYFVG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:21:06 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24249 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfCYFVG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 01:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553491266; x=1585027266;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xtQAXMzUg5nXoYMVhY9pNOmNLS28Gf0SVkGWD84JRmg=;
  b=kIKNbEJG3awbEPhJuyjdNzJ2DsxjgSTijRB3q1Ak4GlWFBR5DdgUXxB5
   fyMb5e8JeMrxeZTqsEiwG4ULDCaChySnyiH9lF5GCTDzlrCtcTvhb9ov8
   NgP9BtAkEngTW92UnOq1Cs+SoCYhnMlmUsq3lOXehq4uV8rC6HQ0aYivr
   3CBNOB4x/WoU59ZhWZUSIH23YBU36ikHSaaqCQ4mHwXTPMdj8J+RVH1vp
   BNRquYqky9o8BLvVrNncx4Vk36oFpDZNHnvWFQO4LfTE/T5LtglSA/OAV
   zwrb2p1aMLsPKPskOUgaNZxEYf0t2Hy3Ir5Jhn4Nh0/sqsOCnDpq3z+SU
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,256,1549900800"; 
   d="scan'208";a="105869055"
Received: from mail-co1nam05lp2057.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.57])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2019 13:21:05 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgzxdrhfKVYB4mc7N74K8LGEXKAXVnL4VDmPj2I3TkA=;
 b=JCOFJoMAikkKQyEIzcQICDHBb/hDRZZsQyzErQ8PVhKopmjQsRCiaYXIB+C1kHPLnXEaYJPnmYLsLMuBQym7UaL1uUOxTiaHgV5iwlUjWLbqmluh9brytVkDnmXcu8dC6Tu1H7h4OinpUDXiq2x4hzVuIpZT/TdEC+YEltLwSBE=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4398.namprd04.prod.outlook.com (52.135.72.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 05:21:03 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%2]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 05:21:03 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 07/15] nvme-pci: move the call to nvme_cleanup_cmd out of
 nvme_unmap_data
Thread-Topic: [PATCH 07/15] nvme-pci: move the call to nvme_cleanup_cmd out of
 nvme_unmap_data
Thread-Index: AQHU4DtyPKk/mGOhhUed0zoTivxCvg==
Date:   Mon, 25 Mar 2019 05:21:02 +0000
Message-ID: <SN6PR04MB45271823D8B8FAF177224155865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c227e3e-19bc-43c3-7898-08d6b0e1acaa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4398;
x-ms-traffictypediagnostic: SN6PR04MB4398:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4398F3382F1753071F5D863B865E0@SN6PR04MB4398.namprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(136003)(366004)(199004)(189003)(7736002)(68736007)(86362001)(478600001)(97736004)(446003)(72206003)(4326008)(25786009)(476003)(486006)(14454004)(229853002)(7696005)(8936002)(76176011)(6436002)(5660300002)(305945005)(26005)(52536014)(102836004)(81156014)(81166006)(8676002)(53546011)(6506007)(66066001)(6246003)(53936002)(316002)(110136005)(99286004)(55016002)(54906003)(74316002)(9686003)(71200400001)(256004)(33656002)(106356001)(6116002)(14444005)(3846002)(71190400001)(2906002)(105586002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4398;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SJzauzCVOyFQLGpDLY36PzaxIYin4soSTJs45ITdfNvJpK0uJEvh1IQ/FC2KGd7MCeE5nFy/epDUH/FaPDJwxFCS9atqvVXSBg3fCcyJnKLPrLZ6pXmH5XBiVGOF1nsdanzonNy1Wk2/b+R6OlwyAOJD5YEd+IxtveXx8WUdugKB/Ujz943PrIIkyxBS7iG//lcpSL1OXaW4caLOk22rMKhhMQLd/6NbnIgJj4ZNQg8z2pYgVXQlx/H9NXk96/kjwm3gWj4KjMwJXIPv7C0yIEbnmxVkxUp9Kf2xzegzv7c4uHcDbk9fpc2qvOUo7cUXSJRBN3fnUnXEg7cD/8vjmbWUxZGuBxNti/punb5CBFNgV/JHol/OM/KKQnpAb5siORV/PyL6oyp/b+zUDsLGuoOuJBcskg+Xx7Nx1TxFIto=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c227e3e-19bc-43c3-7898-08d6b0e1acaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 05:21:02.9496
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
> Cleaning up the command setup isn't related to unmapping data, and=0A=
> disentangling them will simplify error handling a bit down the road.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   drivers/nvme/host/pci.c | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c=0A=
> index 3f06e942fb47..2fb35d44010a 100644=0A=
> --- a/drivers/nvme/host/pci.c=0A=
> +++ b/drivers/nvme/host/pci.c=0A=
> @@ -888,7 +888,6 @@ static void nvme_unmap_data(struct nvme_dev *dev, str=
uct request *req)=0A=
>   			dma_unmap_sg(dev->dev, &iod->meta_sg, 1, dma_dir);=0A=
>   	}=0A=
>   =0A=
> -	nvme_cleanup_cmd(req);=0A=
>   	nvme_free_iod(dev, req);=0A=
>   }=0A=
>   =0A=
> @@ -939,6 +938,7 @@ static void nvme_pci_complete_rq(struct request *req)=
=0A=
>   {=0A=
>   	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);=0A=
>   =0A=
> +	nvme_cleanup_cmd(req);=0A=
>   	nvme_unmap_data(iod->nvmeq->dev, req);=0A=
>   	nvme_complete_rq(req);=0A=
>   }=0A=
> =0A=
=0A=
Also it is much easier to debug now that it is separated.=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
