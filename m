Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680C3C48BD9
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 17:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240C5205F4
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 17:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G9tpnLBt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eMEIpYZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfF0RJj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:09:39 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:62127 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfF0RJi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 13:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561655401; x=1593191401;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=S3JKWQKeWYe9Zzffcb4rkNQRgx+PrrubUtmmyd3xgqw=;
  b=G9tpnLBttkC9ga8OL+t5rQxwREyj2ZgWtOpEATqHUBNuGmtWhwu4AC5e
   n62rFsZ435TeEyItfE8MdvOG+MM0PJN7IBJuD7RQ5fHO3gZ9qft99Bs8a
   3/l/rzaN+zJ/APzl1t2dwIPAPKOUOV/jwEhzhDiYpkIZ/RN7+JeevydAr
   cBH3yLUOogrlIJdHQvHi823NVQEmrj8jf7dw2LM5BxrIVgAGADKRHDnjk
   KO/VvP50nx9BCDCSeuSLgBKbXCdQ0L2fp74NQdPk+K4hOCRfOPoDIMK2J
   LTTB84+9yl52hB3hzJJlpFNrTCAlwD7NPHS9gKEM0OcdTPY0UOMsJ/l6B
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,424,1557158400"; 
   d="scan'208";a="211523052"
Received: from mail-bn3nam04lp2058.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.58])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2019 01:09:40 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTPJUY4laAOE9SiyaCebdizShlrfA5zz34h0X+fr8QE=;
 b=eMEIpYZpZWi9uH63jExpkAlXBPMgBv8YaIA43p5VjrXP+9VTGYGJFxeOC/vAOPRbT+d0HNh0djX9mnV+Fmo9ekEe3hSk7MdFBIQCt+DXLYlBNv7ZMhRNrS3LvJij73v8PN+z4UTk2loQdzHtORnbvQG+XZO2GFSEjlQ8QrlZy2U=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5334.namprd04.prod.outlook.com (20.178.50.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 17:09:22 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.2008.018; Thu, 27 Jun 2019
 17:09:22 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V5 1/3] block: Allow mapping of vmalloc-ed buffers
Thread-Topic: [PATCH V5 1/3] block: Allow mapping of vmalloc-ed buffers
Thread-Index: AQHVLMrhvg+8kC7H5UilK/koJrxCMg==
Date:   Thu, 27 Jun 2019 17:09:21 +0000
Message-ID: <BYAPR04MB5749877E75247AA01BE7DAFE86FD0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190627092944.20957-1-damien.lemoal@wdc.com>
 <20190627092944.20957-2-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3704fb46-af79-4fc1-6d0b-08d6fb2232ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5334;
x-ms-traffictypediagnostic: BYAPR04MB5334:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB533446C81AF76C8C51D176C286FD0@BYAPR04MB5334.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(396003)(366004)(136003)(346002)(189003)(199004)(4326008)(71200400001)(33656002)(3846002)(2906002)(6246003)(66946007)(25786009)(6116002)(476003)(66066001)(53546011)(14444005)(446003)(71190400001)(186003)(102836004)(26005)(76176011)(6506007)(256004)(99286004)(7696005)(2501003)(486006)(66476007)(66556008)(54906003)(110136005)(316002)(72206003)(9686003)(8676002)(478600001)(14454004)(73956011)(86362001)(66446008)(6436002)(55016002)(305945005)(229853002)(64756008)(52536014)(76116006)(74316002)(5660300002)(68736007)(7736002)(81166006)(53936002)(8936002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5334;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MBdMhVomQPgKylvNgEpUPmoyn5BV7LIvmPRXpZP4d/pXYsaj2sHUHT87m/1VuQAp5lCYG6VVlECBn18Jegygf4gHR6ZmwzQu70lPj2SG6LFyBf4+KnSRKYMf5vhN6KArW1QQ4bXD9felMOquQaB/K3Kt2VnkU+e306xT6lIzmrTmAF8lj5GMnKFPsEA3dyi44zsay7RtiLZ/Cy9ELWHtETjAIQllzkpCCqK57R34Zra1TjCgfP+n+KaKzVozQm7QFILHXSL06CRQdHffhnA4axxHwfqcw/C49NX58gmNPkq2uJw8o4bVdby1qBEHQcTLsFFSu69G149nXwVsGvufbZgyMbKTBKDjyDgCkj1huq5cNvPGeZR6eenz9796vrZSyal8cbBROFWuU2dPCySVlwG/DzCEMiV470+Jxh5EHbk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3704fb46-af79-4fc1-6d0b-08d6fb2232ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 17:09:21.9509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5334
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 6/27/19 2:29 AM, Damien Le Moal wrote:=0A=
> To allow the SCSI subsystem scsi_execute_req() function to issue=0A=
> requests using large buffers that are better allocated with vmalloc()=0A=
> rather than kmalloc(), modify bio_map_kern() to allow passing a buffer=0A=
> allocated with vmalloc().=0A=
> =0A=
> To do so, detect vmalloc-ed buffers using is_vmalloc_addr(). For=0A=
> vmalloc-ed buffers, flush the buffer using flush_kernel_vmap_range(),=0A=
> use vmalloc_to_page() instead of virt_to_page() to obtain the pages of=0A=
> the buffer, and invalidate the buffer addresses with=0A=
> invalidate_kernel_vmap_range() on completion of read BIOs. This last=0A=
> point is executed using the function bio_invalidate_vmalloc_pages()=0A=
> which is defined only if the architecture defines=0A=
> ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE, that is, if the architecture=0A=
> actually needs the invalidation done.=0A=
> =0A=
> Fixes: 515ce6061312 ("scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allo=
cation")=0A=
> Fixes: e76239a3748c ("block: add a report_zones method")=0A=
> Cc: stable@vger.kernel.org=0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> ---=0A=
>   block/bio.c | 29 ++++++++++++++++++++++++++++-=0A=
>   1 file changed, 28 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index ce797d73bb43..bbba5f08b2ef 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -16,6 +16,7 @@=0A=
>   #include <linux/workqueue.h>=0A=
>   #include <linux/cgroup.h>=0A=
>   #include <linux/blk-cgroup.h>=0A=
> +#include <linux/highmem.h>=0A=
>   =0A=
>   #include <trace/events/block.h>=0A=
>   #include "blk.h"=0A=
> @@ -1479,8 +1480,22 @@ void bio_unmap_user(struct bio *bio)=0A=
>   	bio_put(bio);=0A=
>   }=0A=
>   =0A=
> +static void bio_invalidate_vmalloc_pages(struct bio *bio)=0A=
> +{=0A=
> +#ifdef ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE=0A=
> +	if (bio->bi_private && !op_is_write(bio_op(bio))) {=0A=
> +		unsigned long i, len =3D 0;=0A=
> +=0A=
> +		for (i =3D 0; i < bio->bi_vcnt; i++)=0A=
> +			len +=3D bio->bi_io_vec[i].bv_len;=0A=
> +		invalidate_kernel_vmap_range(bio->bi_private, len);=0A=
> +	}=0A=
> +#endif=0A=
> +}=0A=
> +=0A=
>   static void bio_map_kern_endio(struct bio *bio)=0A=
>   {=0A=
> +	bio_invalidate_vmalloc_pages(bio);=0A=
>   	bio_put(bio);=0A=
>   }=0A=
>   =0A=
> @@ -1501,6 +1516,8 @@ struct bio *bio_map_kern(struct request_queue *q, v=
oid *data, unsigned int len,=0A=
>   	unsigned long end =3D (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;=0A=
>   	unsigned long start =3D kaddr >> PAGE_SHIFT;=0A=
>   	const int nr_pages =3D end - start;=0A=
> +	bool is_vmalloc =3D is_vmalloc_addr(data);=0A=
> +	struct page *page;=0A=
>   	int offset, i;=0A=
>   	struct bio *bio;=0A=
>   =0A=
> @@ -1508,6 +1525,11 @@ struct bio *bio_map_kern(struct request_queue *q, =
void *data, unsigned int len,=0A=
>   	if (!bio)=0A=
>   		return ERR_PTR(-ENOMEM);=0A=
>   =0A=
> +	if (is_vmalloc) {=0A=
> +		flush_kernel_vmap_range(data, len);=0A=
> +		bio->bi_private =3D data;=0A=
> +	}=0A=
> +=0A=
>   	offset =3D offset_in_page(kaddr);=0A=
>   	for (i =3D 0; i < nr_pages; i++) {=0A=
>   		unsigned int bytes =3D PAGE_SIZE - offset;=0A=
> @@ -1518,7 +1540,11 @@ struct bio *bio_map_kern(struct request_queue *q, =
void *data, unsigned int len,=0A=
>   		if (bytes > len)=0A=
>   			bytes =3D len;=0A=
>   =0A=
> -		if (bio_add_pc_page(q, bio, virt_to_page(data), bytes,=0A=
> +		if (!is_vmalloc)=0A=
> +			page =3D virt_to_page(data);=0A=
> +		else=0A=
> +			page =3D vmalloc_to_page(data);=0A=
> +		if (bio_add_pc_page(q, bio, page, bytes,=0A=
>   				    offset) < bytes) {=0A=
>   			/* we don't support partial mappings */=0A=
>   			bio_put(bio);=0A=
> @@ -1531,6 +1557,7 @@ struct bio *bio_map_kern(struct request_queue *q, v=
oid *data, unsigned int len,=0A=
>   	}=0A=
>   =0A=
>   	bio->bi_end_io =3D bio_map_kern_endio;=0A=
> +=0A=
>   	return bio;=0A=
>   }=0A=
>   EXPORT_SYMBOL(bio_map_kern);=0A=
> =0A=
=0A=
