Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6960DC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDA12083D
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HqK4ovJR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c/IpECeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfCYFXW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:23:22 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:65197 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfCYFXW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 01:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553491402; x=1585027402;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+r48FSgsGscFH7l1J4NZJP+t34rB9AhutF0LukKBmI8=;
  b=HqK4ovJRQwRzZiUoejwZi2E3g60GMguJGZq53QjWjGSHhSZt7l9xGdh7
   66GsKUDAIV54pfptcPhuNrKBfJ/2CY+pebj+I3frSoIjxg52QWpFZ4NV9
   sc3DyZYP3XHqyFp/+EWRVwxnE4VwtMS6kWF60ivUH7+6w+OncVq2dVQu2
   hiEjk5qdW7vlZ/K8ypC7XX8d3Si3S8FIA0HIjBGPPz7X0D8k1xfC312kN
   lhZdZ3MQ6Ofuxgyu27vSkwncBn/TCFRkabkb9yPFdzcu3QTiwp5Fj4tVH
   2J8laJ4Z8goz+gKgpmwvvk1vWBzHaaJjGhLzBD73ROYsFmTPAtEr03waX
   A==;
X-IronPort-AV: E=Sophos;i="5.60,256,1549900800"; 
   d="scan'208";a="104128332"
Received: from mail-bl2nam02lp2053.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.53])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2019 13:23:21 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUkXTqkwU3kohA1Q/XVkM5MvrSHyhHl4aK+GTB8oZkE=;
 b=c/IpECeTbACIQuioUFG6h3aNr2KTH/i+54sQSa/bapGXNOT1tZiSJrOSf3SZaFTDx8u6ymzxaQIrBDx4RxiEnxmALIvV71MmBAz36MMZh3U41Ec8XD+MkqBpTx02EFpxpqCmEwDTtoBUfm9TZweooO8XKk5TekkXv1VXCczD3Vw=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4398.namprd04.prod.outlook.com (52.135.72.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 05:23:17 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%2]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 05:23:17 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 09/15] nvme-pci: only call nvme_unmap_data for requests
 transferring data
Thread-Topic: [PATCH 09/15] nvme-pci: only call nvme_unmap_data for requests
 transferring data
Thread-Index: AQHU4Dt4f18bx4256UmPe6V+FKGLOA==
Date:   Mon, 25 Mar 2019 05:23:17 +0000
Message-ID: <SN6PR04MB45270446075043E2A7079A76865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ea9eac9-7ba2-467a-a6fa-08d6b0e1fcfa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4398;
x-ms-traffictypediagnostic: SN6PR04MB4398:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4398FA60FBC01F1051EA8EED865E0@SN6PR04MB4398.namprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(136003)(366004)(199004)(189003)(7736002)(68736007)(86362001)(478600001)(97736004)(446003)(72206003)(4326008)(25786009)(476003)(486006)(14454004)(229853002)(7696005)(8936002)(76176011)(6436002)(5660300002)(305945005)(26005)(52536014)(102836004)(81156014)(81166006)(8676002)(53546011)(6506007)(66066001)(6246003)(53936002)(316002)(110136005)(99286004)(55016002)(54906003)(74316002)(9686003)(71200400001)(256004)(33656002)(106356001)(6116002)(4744005)(14444005)(3846002)(71190400001)(2906002)(105586002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4398;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vmOFKjozJLj5dYcFsZLiy4Dj3g9x0F0cCn+Lwk1GQ0TkCN+JQrXjrESUpSnnspg56bvEXPsyp4nR3WCoAxJloK3lTw6CjKPAFfopSh20zhL20qVYRpNgUCD1xRwhHWa7C1qQMISOyy/nlS+6QeY320Y6JJQvUDVYKmvXIi/T6RH4JGCn7ngIyr6mlvAYxPy5kG0orBmG1ANWNbar9lc33uClN9g/x4IwcMbmZTdJFdMuwLlMtjLcHohi5KSnUnT8KbKZzlpQKOQpfbthAm4n99F5hK52Q2aRr2ZpAYBEp66oHsgTQOcbEt/RqgDGeRkYhHrwsqZ0IHxv0yo4qMnV+gabpc2HToIlHLJ/ShaXE1Z+BHBmBv/SHqC3vSqGnzbIIGHWoZzfRy6kLxZPM5IkUhQ316nkd7jUVq48EQv9egs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea9eac9-7ba2-467a-a6fa-08d6b0e1fcfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 05:23:17.6458
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
> This mirrors how nvme_map_pci is called and will allow simplifying some=
=0A=
> checks in nvme_unmap_pci later on.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   drivers/nvme/host/pci.c | 3 ++-=0A=
>   1 file changed, 2 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c=0A=
> index ce8bdc15ec3c..bc4ee869fe82 100644=0A=
> --- a/drivers/nvme/host/pci.c=0A=
> +++ b/drivers/nvme/host/pci.c=0A=
> @@ -929,7 +929,8 @@ static void nvme_pci_complete_rq(struct request *req)=
=0A=
>   	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);=0A=
>   =0A=
>   	nvme_cleanup_cmd(req);=0A=
> -	nvme_unmap_data(iod->nvmeq->dev, req);=0A=
> +	if (blk_rq_nr_phys_segments(req))=0A=
> +		nvme_unmap_data(iod->nvmeq->dev, req);=0A=
>   	nvme_complete_rq(req);=0A=
>   }=0A=
>   =0A=
> =0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
