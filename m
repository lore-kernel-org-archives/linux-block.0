Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBF0C4646C
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 03:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB39206DD
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 03:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QMyzfoqX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OkqjWn6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfFYDYc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 23:24:32 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53318 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfFYDYc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 23:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561433071; x=1592969071;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=K5bXV0aYCMFXSpeWcC5UhvVrw4hiPYcdPTByQTYNIdI=;
  b=QMyzfoqXWKW4lNcnsctjdQdswf3u+DIf5eAanuHJcXHW/l5x3oWy0ysY
   JHNy/2ggSmlmfJXOKXMv2zNXc/Uj23jovMV+MPF3KhCl4b4QLm+JZS8R5
   2485LXIEe2hndFNrqVA91qeIgR5jvE5maBHlKV7Y7LjCjyeBoXC7LjBxm
   AayqEGAQ9/av5aG38O2rk7TLHmFIT1ozs880Jvr6NBNrSBbz2TFqb6fNP
   BHMufXK7tzGsMTd7uGcMR6+aM4hhS0LthYWgAiWUEg5pMvV/TGrWRS/rs
   1y5sIY0qb1E2yM5m4kjsbJH/D7bq/+uhX3MWIBme6P1wz0g5DpX5rXQ4w
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,413,1557158400"; 
   d="scan'208";a="111437200"
Received: from mail-co1nam05lp2052.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.52])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 11:24:30 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFfeB2rsTqSXZPpUK7DMv6CRWeMQn+/DK0M+zTvmUKg=;
 b=OkqjWn6aQWl3qYiFNE6HIIRe5yaHX6fTU1w5yO3uK7LEyFBXCGfBiU33rnxO5/J8coOBck8WxTqmKPpaUYsn+3xywl3ozEmE9kugMQguac68xHlRNUzj0eq5QDIjfG17bhirNA2KIIFKs8u1VY2yfTR4Ivc2OkkJuaZ/+smkYfU=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4006.namprd04.prod.outlook.com (52.135.215.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Tue, 25 Jun 2019 03:24:27 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 03:24:27 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 1/3] block: Allow mapping of vmalloc-ed buffers
Thread-Topic: [PATCH 1/3] block: Allow mapping of vmalloc-ed buffers
Thread-Index: AQHVKwA0CgkpItjWVEOnwU70Lez80g==
Date:   Tue, 25 Jun 2019 03:24:26 +0000
Message-ID: <BYAPR04MB5749C9178CB54B4A488408A986E30@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190625024625.23976-1-damien.lemoal@wdc.com>
 <20190625024625.23976-2-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51ca4612-3e48-47e2-ba62-08d6f91ca0d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4006;
x-ms-traffictypediagnostic: BYAPR04MB4006:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4006A4E5D5F3B76207900E8C86E30@BYAPR04MB4006.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(39860400002)(396003)(346002)(199004)(189003)(229853002)(316002)(6436002)(54906003)(66066001)(110136005)(53936002)(55016002)(33656002)(9686003)(6246003)(53546011)(6506007)(102836004)(73956011)(66946007)(66476007)(64756008)(66556008)(66446008)(186003)(26005)(25786009)(99286004)(76176011)(7696005)(52536014)(476003)(72206003)(446003)(4326008)(68736007)(7736002)(305945005)(478600001)(74316002)(76116006)(8676002)(81156014)(81166006)(3846002)(6116002)(8936002)(71190400001)(71200400001)(86362001)(256004)(14444005)(2906002)(14454004)(2501003)(5660300002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4006;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ndK5klYOD2CjCLCAjLPed8co1scXT3ob4MU+IjLggwwuIr5taIKHv7+qal77ytViucC8Cy7trbeEN/QR9yLBYDW5r1h7c9Um6d6YsuXhp3gebmBbeX3EuiBKhm8fzA6xlSwI24sJFZzbtHMoolVVqjUrLGa987Yb6iKTCywSfGOf/QbHdIDExRdc7TVimOFnVImsSEyPoTwvpb0X/DK1k865U56zjRxSsA3E5F+M1imv8l6G0trlphRbOVjhBM3lktjNEbBQf5ZsqIa93NFSYiCCOIZJKYIYoPGsZLbeddQsUwllICFAltLZJeAhbFx2TEEZb090n2/JhAAu6cLND9f7MN0ii0Pdb9YW7BnLhkZMncKJWRVbSEwXcfhFPI01B/e11riAgAkEgVBiBHyPir1U/A8L/rv1TEz7O4ElGM8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ca4612-3e48-47e2-ba62-08d6f91ca0d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 03:24:26.2685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4006
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good with one nit, can be done at the time of applying patch.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 6/24/19 7:46 PM, Damien Le Moal wrote:=0A=
> To allow the SCSI subsystem scsi_execute_req() function to issue=0A=
> requests using large buffers that are better allocated with vmalloc()=0A=
> rather than kmalloc(), modify bio_map_kern() to allow passing a buffer=0A=
> allocated with the vmalloc() function. To do so, simply test the buffer=
=0A=
> address using is_vmalloc_addr() and use vmalloc_to_page() instead of=0A=
> virt_to_page() to obtain the pages of vmalloc-ed buffers.=0A=
> =0A=
> Fixes: 515ce6061312 ("scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allo=
cation")=0A=
> Fixes: e76239a3748c ("block: add a report_zones method")=0A=
> Cc: stable@vger.kernel.org=0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> ---=0A=
>   block/bio.c | 8 +++++++-=0A=
>   1 file changed, 7 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index ce797d73bb43..05afcaf655f3 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -1501,6 +1501,8 @@ struct bio *bio_map_kern(struct request_queue *q, v=
oid *data, unsigned int len,=0A=
>   	unsigned long end =3D (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;=0A=
>   	unsigned long start =3D kaddr >> PAGE_SHIFT;=0A=
>   	const int nr_pages =3D end - start;=0A=
> +	bool is_vmalloc =3D is_vmalloc_addr(data); > +	struct page *page;=0A=
>   	int offset, i;=0A=
>   	struct bio *bio;=0A=
>   =0A=
> @@ -1518,7 +1520,11 @@ struct bio *bio_map_kern(struct request_queue *q, =
void *data, unsigned int len,=0A=
>   		if (bytes > len)=0A=
>   			bytes =3D len;=0A=
>   =0A=
> -		if (bio_add_pc_page(q, bio, virt_to_page(data), bytes,=0A=
> +		if (is_vmalloc)=0A=
nit:- Can we use is_vmalloc_addr() call directly so that=0A=
"if (is_vmalloc)" ->  "if (is_vmalloc_addr(data))" and remove is_vmalloc =
=0A=
variable.=0A=
> +			page =3D vmalloc_to_page(data);=0A=
> +		else=0A=
> +			page =3D virt_to_page(data);=0A=
> +		if (bio_add_pc_page(q, bio, page, bytes,=0A=
>   				    offset) < bytes) {=0A=
>   			/* we don't support partial mappings */=0A=
>   			bio_put(bio);=0A=
> =0A=
=0A=
