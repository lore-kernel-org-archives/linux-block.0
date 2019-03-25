Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BA4C4360F
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E091205C9
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A1mcv1Fd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GiKnR/lE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfCYFOL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:14:11 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42055 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfCYFOK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 01:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553490850; x=1585026850;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rzJFDcgKWkV57ExRALjKSNBhajCDYqplgfa98ZX2HT8=;
  b=A1mcv1Fd/KD23nJtLllCgF6M6lRymrVkrLvN82UD8xqaIhmZtdQ9DKyM
   TnWuATFVW77sG2hoiF3fu32bZjaZAF5lnNolp9c5PI/UcevqZjF3oc1yv
   ozx7gbjHlG/LVKkpkyE5RUuzndqtu3FE8YJjsix1S5+MIZ51qVak/jHlU
   BFidGoXs0DsNWfR4Rs/4mE8D7GRl5MEa8j6clS970/K0VaDUqAml/sUB5
   FKADLqo7uD568Q+Z1wzdJ9B8pzGutL5aSrNC3TjhAxUBLYFw88NNSZ5Em
   2YI5X5BUguVv/mS1s02dIRXjMuKE0w9rNLx4faG3Z/x6XEpz/WfRN4adc
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,256,1549900800"; 
   d="scan'208";a="105868439"
Received: from mail-dm3nam05lp2051.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.51])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2019 13:14:09 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVnU04N/jgHhcLQuyX9HSVo7hiFkz+aynLkS0T6q33o=;
 b=GiKnR/lEcU3aSr+rufEhbChnmYHGKqk4Zr9tx4ahuVN+++i6xnUiOpU586sKEgt6PchYfZ17HSgXBgcHMHhB6BFLiJPbYcFaeDGx9tAy2p+PiMPFjDtqWRx11jFyhUEBUfyLRbpJI+aFqnSoKwNBq6xEVpOP3WJ0htZRyMccD9I=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4685.namprd04.prod.outlook.com (52.135.122.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Mon, 25 Mar 2019 05:14:07 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%2]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 05:14:07 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 05/15] nvme-pci: remove the unused iod->length field
Thread-Topic: [PATCH 05/15] nvme-pci: remove the unused iod->length field
Thread-Index: AQHU4Dtt+u3gG2b2fEyx0Xh+aTvfaQ==
Date:   Mon, 25 Mar 2019 05:14:07 +0000
Message-ID: <SN6PR04MB4527CC0DD3A5963262C31F6A865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ca4ac56-3f77-43b0-58c4-08d6b0e0b53f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4685;
x-ms-traffictypediagnostic: SN6PR04MB4685:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4685237D681D05271E7BBA9D865E0@SN6PR04MB4685.namprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39860400002)(136003)(199004)(189003)(71200400001)(52536014)(4744005)(9686003)(74316002)(478600001)(55016002)(71190400001)(14454004)(25786009)(6116002)(86362001)(3846002)(2906002)(53936002)(4326008)(99286004)(6246003)(72206003)(305945005)(446003)(33656002)(7736002)(486006)(476003)(186003)(6506007)(316002)(53546011)(97736004)(68736007)(66066001)(7696005)(110136005)(54906003)(106356001)(6436002)(102836004)(26005)(256004)(76176011)(81166006)(14444005)(105586002)(229853002)(8936002)(8676002)(81156014)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4685;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 28xsRAYruJj7IvsQx7vVjdtutEJvOiBrUC9L1LSYAZC00ioYmzGA2mp5kCtshto0TXLYTfmnWwaYSxmPgMsFcegbFyKtHlmh/7kV368lxVB4RWcLfiaCgPwVqXGVZaUJxJJ8gIP1h81IZjzslvUeQ9wQNxMpuSQeLyq01sNsdkApTDVZd3w4I939gfSCYp7pHXf11avKm1wjFNJQkE0JTgbKyWryD3Bgtti4ndzQJdROnWHp4lK8BUa32wCejVTJDgLbM3A0DXslFFwsbPdD7kk76XbXPqmFxa5JyS+SBHA0ProFkHVxMEZ5xmx5cU/mO2YiO1YokKQjsjPN+DChgEsCdo9PKL9pfRq6/qoPN7F1B1O5UT0BT3YAliFomVfKqORq7wPyrf+4gBtm/WdgiaaBGxu+CIQ0vMZvfyS2sC0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca4ac56-3f77-43b0-58c4-08d6b0e0b53f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 05:14:07.8833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4685
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/21/19 4:11 PM, Christoph Hellwig wrote:=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   drivers/nvme/host/pci.c | 2 --=0A=
>   1 file changed, 2 deletions(-)=0A=
> =0A=
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c=0A=
> index a90cf5d63aac..bf0d71fe243e 100644=0A=
> --- a/drivers/nvme/host/pci.c=0A=
> +++ b/drivers/nvme/host/pci.c=0A=
> @@ -220,7 +220,6 @@ struct nvme_iod {=0A=
>   	int aborted;=0A=
>   	int npages;		/* In the PRP list. 0 means small pool in use */=0A=
>   	int nents;		/* Used in scatterlist */=0A=
> -	int length;		/* Of data, in bytes */=0A=
>   	dma_addr_t first_dma;=0A=
>   	struct scatterlist meta_sg; /* metadata requires single contiguous buf=
fer */=0A=
>   	struct scatterlist *sg;=0A=
> @@ -603,7 +602,6 @@ static blk_status_t nvme_init_iod(struct request *rq,=
 struct nvme_dev *dev)=0A=
>   	iod->aborted =3D 0;=0A=
>   	iod->npages =3D -1;=0A=
>   	iod->nents =3D 0;=0A=
> -	iod->length =3D size;=0A=
>   =0A=
>   	return BLK_STS_OK;=0A=
>   }=0A=
> =0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
