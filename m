Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054BDC48BD7
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 17:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16A3214AF
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 17:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EpQJHSKG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UN/JTlKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfF0RIW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:08:22 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:4537 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfF0RIW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 13:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561655302; x=1593191302;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=F3ZGFzMXbARCHPKw9QGGoC/rwyKqQMX7U1R0qGpSfm0=;
  b=EpQJHSKGEYbvNl18h4iWlhcjPi9TY7uPUZWs/fDGZ0G2bGGUyo035lKA
   V8hlPwMfOZFX1VEBBxhbx3EyrvlpZH3cc1+8KXWO3KbeQ/pijj+bsQ9k2
   DcDGy4WD71+b2Ra8C3QFDzUCcwB/OGr2w9mxUVM3sUshmGg8PMJODk2ZU
   oNim/m+4Y7Jy0EOpdYZuCkJxvcrAfK9MySBoadTzfqs1cKH+d1OrIBM0Q
   LbLR4Zji4tizjrmdJZIh/3t338rWBuCYl4p/uYI6HimQ6BgSVC2CEuAua
   N9h+JlzK6yph1j4LaxhSELzvCSGJ0KHy5vaP7UO2kp2PM7TLUNB6nXASy
   g==;
X-IronPort-AV: E=Sophos;i="5.63,424,1557158400"; 
   d="scan'208";a="116576344"
Received: from mail-bn3nam04lp2055.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.55])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2019 01:08:20 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qOuJ0N7LEi10iXSgtMwVGc3ocDoXYl5whRSdgNzzLM=;
 b=UN/JTlKkeQZLGnO03WLVvlv9gPgSplWnAfnU1Q55+FK6mSiZVgjZGDxPDt+Cayx3xjNvVrMQDah0MO0bo8sqzXmZMtXOjp5h7EPAju7Pg0BfukEdHj/RHJhAJ+UcPiZN2PfuGlhImXHASrn3WW8sqO+1GWGXgGf69rIENvk0dlQ=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5334.namprd04.prod.outlook.com (20.178.50.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 17:08:18 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.2008.018; Thu, 27 Jun 2019
 17:08:18 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V5 3/3] block: Limit zone array allocation size
Thread-Topic: [PATCH V5 3/3] block: Limit zone array allocation size
Thread-Index: AQHVLMrjgUlXqB+CwEWZM7i8ct7Pgw==
Date:   Thu, 27 Jun 2019 17:08:17 +0000
Message-ID: <BYAPR04MB57492E955AE6E64240E8E3E086FD0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190627092944.20957-1-damien.lemoal@wdc.com>
 <20190627092944.20957-4-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b24d0872-6a40-4632-1209-08d6fb220cb7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5334;
x-ms-traffictypediagnostic: BYAPR04MB5334:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5334E0700ED4E9D69D833ABB86FD0@BYAPR04MB5334.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:525;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(396003)(366004)(136003)(346002)(189003)(199004)(4326008)(71200400001)(33656002)(3846002)(2906002)(6246003)(66946007)(25786009)(6116002)(476003)(66066001)(53546011)(14444005)(446003)(71190400001)(186003)(102836004)(26005)(76176011)(6506007)(256004)(99286004)(7696005)(2501003)(486006)(66476007)(66556008)(54906003)(110136005)(316002)(72206003)(9686003)(8676002)(478600001)(14454004)(73956011)(86362001)(66446008)(6436002)(55016002)(305945005)(229853002)(64756008)(52536014)(76116006)(74316002)(5660300002)(68736007)(7736002)(81166006)(53936002)(8936002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5334;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cxPYBiDQkL2WI+xu2m4Eo7JW1hqsiN1KhfMl2GbtXv1/jJbGcnCz0duWRb0a/+yDk+aZI0hIBAh3umUdi0G7fsyuATLGMJEBYFTgBxyqElCeaYpKQSgMb8zJQcYAowTpsXFGNshg51cG3WvPua2LOpaXPwZKo4EPNlR4roMdv8O88apgA9r+N8N+zBVmssElSZbcgSb3Toe+4058qazWAFA875yD72w+8QYs8pFo6crKOBuvoMviQmFb3YiE+UADhJNskd2wlZc3rZnHMAurVbnqKdm03SLT3UKzNDzWbSIncWyxM+tnaxxsdtNNh6npjJCjDxm4s0lHmbMXGaiT2eA/Q+LqeukOR6fxOk6D9OfwjOjyO9HzID9XsdKsiHwAoEfteL8Hf8VBD3OolNTKxguyWlrV/5Udh93uW9mSJhQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24d0872-6a40-4632-1209-08d6fb220cb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 17:08:17.8648
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
> Limit the size of the struct blk_zone array used in=0A=
> blk_revalidate_disk_zones() to avoid memory allocation failures leading=
=0A=
> to disk revalidation failure. Further reduce the likelyhood of these=0A=
> failures by using kvmalloc() instead of directly allocating contiguous=0A=
> pages.=0A=
> =0A=
> Fixes: 515ce6061312 ("scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allo=
cation")=0A=
> Fixes: e76239a3748c ("block: add a report_zones method")=0A=
> Cc: stable@vger.kernel.org=0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>   block/blk-zoned.c      | 29 +++++++++++++----------------=0A=
>   include/linux/blkdev.h |  5 +++++=0A=
>   2 files changed, 18 insertions(+), 16 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index ae7e91bd0618..26f878b9b5f5 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -373,22 +373,20 @@ static inline unsigned long *blk_alloc_zone_bitmap(=
int node,=0A=
>    * Allocate an array of struct blk_zone to get nr_zones zone informatio=
n.=0A=
>    * The allocated array may be smaller than nr_zones.=0A=
>    */=0A=
> -static struct blk_zone *blk_alloc_zones(int node, unsigned int *nr_zones=
)=0A=
> +static struct blk_zone *blk_alloc_zones(unsigned int *nr_zones)=0A=
>   {=0A=
> -	size_t size =3D *nr_zones * sizeof(struct blk_zone);=0A=
> -	struct page *page;=0A=
> -	int order;=0A=
> -=0A=
> -	for (order =3D get_order(size); order >=3D 0; order--) {=0A=
> -		page =3D alloc_pages_node(node, GFP_NOIO | __GFP_ZERO, order);=0A=
> -		if (page) {=0A=
> -			*nr_zones =3D min_t(unsigned int, *nr_zones,=0A=
> -				(PAGE_SIZE << order) / sizeof(struct blk_zone));=0A=
> -			return page_address(page);=0A=
> -		}=0A=
> +	struct blk_zone *zones;=0A=
> +	size_t nrz =3D min(*nr_zones, BLK_ZONED_REPORT_MAX_ZONES);=0A=
> +=0A=
> +	zones =3D kvcalloc(nrz, sizeof(struct blk_zone), GFP_NOIO);=0A=
> +	if (!zones) {=0A=
> +		*nr_zones =3D 0;=0A=
> +		return NULL;=0A=
>   	}=0A=
>   =0A=
> -	return NULL;=0A=
> +	*nr_zones =3D nrz;=0A=
> +=0A=
> +	return zones;=0A=
>   }=0A=
>   =0A=
>   void blk_queue_free_zone_bitmaps(struct request_queue *q)=0A=
> @@ -443,7 +441,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)=
=0A=
>   =0A=
>   	/* Get zone information and initialize seq_zones_bitmap */=0A=
>   	rep_nr_zones =3D nr_zones;=0A=
> -	zones =3D blk_alloc_zones(q->node, &rep_nr_zones);=0A=
> +	zones =3D blk_alloc_zones(&rep_nr_zones);=0A=
>   	if (!zones)=0A=
>   		goto out;=0A=
>   =0A=
> @@ -480,8 +478,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)=
=0A=
>   	blk_mq_unfreeze_queue(q);=0A=
>   =0A=
>   out:=0A=
> -	free_pages((unsigned long)zones,=0A=
> -		   get_order(rep_nr_zones * sizeof(struct blk_zone)));=0A=
> +	kvfree(zones);=0A=
>   	kfree(seq_zones_wlock);=0A=
>   	kfree(seq_zones_bitmap);=0A=
>   =0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 592669bcc536..f7faac856017 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -344,6 +344,11 @@ struct queue_limits {=0A=
>   =0A=
>   #ifdef CONFIG_BLK_DEV_ZONED=0A=
>   =0A=
> +/*=0A=
> + * Maximum number of zones to report with a single report zones command.=
=0A=
> + */=0A=
> +#define BLK_ZONED_REPORT_MAX_ZONES	8192U=0A=
> +=0A=
>   extern unsigned int blkdev_nr_zones(struct block_device *bdev);=0A=
>   extern int blkdev_report_zones(struct block_device *bdev,=0A=
>   			       sector_t sector, struct blk_zone *zones,=0A=
> =0A=
=0A=
