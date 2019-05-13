Return-Path: <SRS0=TF98=TN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2105C04AA7
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 15:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9446320879
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 15:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yes33S0e";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XaV7gOBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfEMPEn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 May 2019 11:04:43 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:31536 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731098AbfEMPEm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 May 2019 11:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557759883; x=1589295883;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=yUJmHASjNFEjMuwdH4sV4zVSerQR5o+sebaIU4qbFI0=;
  b=Yes33S0ejTEDT5yAgESseGiGVekKBQNo3LnA+6OWpe90/vp28EMaqjs1
   ISHh6tsf6IcT6mnhsgHEOYRO5C2BB9a4VmgS0/BAFFEZaLy/tylPt/YSe
   mF/8iHea5PatiArH2bJRc/vAFvsWj2cbrWv1OIA+YmORRc38KLzHNlPv7
   N9M3+i3DzaBOoMy3978E2dGTKq2rp23C4bEGhxHgqlsGSR+YjWujzigab
   HR6q9mV85DXT6GGWABa7IprTJZcfRJQ2tDG4zEx9v937GuydwTJaTCAQk
   nePa4Jcj5yc8WQawcTCriQj5q5G9dPeeSbQTpP1ELv8YmDWotmt5jNQqE
   g==;
X-IronPort-AV: E=Sophos;i="5.60,465,1549900800"; 
   d="scan'208";a="113091371"
Received: from mail-by2nam05lp2057.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.57])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2019 23:04:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDQ+frtUfkRjiauxvvHuiKVj2kWh1iyUqE+2aPvifYM=;
 b=XaV7gOBYao0WTJlP/abXGiNrqw10RHK6lSjruABQwf4p722VKIFKNHteOvOrQgJBktsA/0WiDeGnpYQ607Fw1wxYlwl29d6QCp6GlrHGg0wB3UDCdJVGpcZm8LAJpfWSQbiobQvK1GpzZMWke+ewedyCofDIkf5uUEjTk3W0Et4=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB5072.namprd04.prod.outlook.com (52.135.116.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Mon, 13 May 2019 15:04:39 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 15:04:39 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>
CC:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        Matias Bjorling <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 05/10] block: initialize the write priority in
 blk_rq_bio_prep
Thread-Topic: [PATCH 05/10] block: initialize the write priority in
 blk_rq_bio_prep
Thread-Index: AQHVCVaL/TOKnE5dEE+Q0PHYRFWLbQ==
Date:   Mon, 13 May 2019 15:04:39 +0000
Message-ID: <SN6PR04MB452790C870AB9343D33A9A4C860F0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190513063754.1520-1-hch@lst.de>
 <20190513063754.1520-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cca50e9-7327-4485-41f5-08d6d7b4527e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB5072;
x-ms-traffictypediagnostic: SN6PR04MB5072:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB5072B8EA93F42DD85E426B33860F0@SN6PR04MB5072.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(396003)(376002)(346002)(199004)(189003)(6506007)(81156014)(446003)(68736007)(14454004)(478600001)(81166006)(53546011)(8936002)(486006)(2906002)(476003)(72206003)(7696005)(6116002)(3846002)(66066001)(7736002)(99286004)(305945005)(8676002)(33656002)(76176011)(256004)(25786009)(14444005)(54906003)(4326008)(110136005)(229853002)(2501003)(66446008)(64756008)(66556008)(66476007)(73956011)(71200400001)(76116006)(91956017)(52536014)(66946007)(71190400001)(53936002)(6246003)(9686003)(316002)(5660300002)(74316002)(55016002)(102836004)(26005)(6436002)(186003)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5072;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uBL0rUZJGiJU+qBDb7JjRuGSOmd7Bw4ZYFQSkWNxQ7m971sNCBwPaLCifWKKvOvmeY25X9pGEEvgbTG8LIDPYeujo9z25RI0jgm6XU+2xSK+Zs3fE8cu35aPBAlwhHW9lvCkFtCZUESaLliMc91S2usO4EA54hYF1wfYj7LTSvEKBBAt95hF3pqPeYwwyjOKoMwf2bM1MEGDihH5WIJmXbYBOMp3ZdASX3vNrV7OWwVeYOxYXnATys0dKF4LIEfTaNy7T/L8Cb4z8oTM9pvkF+B1io2+WeXefOWHO+DNo/VIOD83f2cgCdp/1OHRexoGWFgXuSQqWa6Pq+FGhW2kQ8dDFW6xWgYz9jmkNmW35ssrGlqadwb5KhsbRaqBR39O/euWPv0xhpDHcu7aAnF/mjv+0JcL6wmo1PcpHqJ7NK8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cca50e9-7327-4485-41f5-08d6d7b4527e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 15:04:39.5933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5072
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With 's/fiel/field' can be done at the time of merge, looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 05/12/2019 11:38 PM, Christoph Hellwig wrote:=0A=
> The priority fiel also make sense for passthrough requests, so=0A=
> initialize it in blk_rq_bio_prep.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   block/blk-core.c | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
> index 419d600e6637..7fb394dd3e11 100644=0A=
> --- a/block/blk-core.c=0A=
> +++ b/block/blk-core.c=0A=
> @@ -716,7 +716,6 @@ void blk_init_request_from_bio(struct request *req, s=
truct bio *bio)=0A=
>   		req->cmd_flags |=3D REQ_FAILFAST_MASK;=0A=
>=0A=
>   	req->__sector =3D bio->bi_iter.bi_sector;=0A=
> -	req->ioprio =3D bio_prio(bio);=0A=
>   	req->write_hint =3D bio->bi_write_hint;=0A=
>   	blk_rq_bio_prep(req->q, req, bio);=0A=
>   }=0A=
> @@ -1494,6 +1493,7 @@ void blk_rq_bio_prep(struct request_queue *q, struc=
t request *rq,=0A=
>=0A=
>   	rq->__data_len =3D bio->bi_iter.bi_size;=0A=
>   	rq->bio =3D rq->biotail =3D bio;=0A=
> +	rq->ioprio =3D bio_prio(bio);=0A=
>=0A=
>   	if (bio->bi_disk)=0A=
>   		rq->rq_disk =3D bio->bi_disk;=0A=
>=0A=
=0A=
