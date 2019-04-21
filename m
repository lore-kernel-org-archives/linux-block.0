Return-Path: <SRS0=4R18=SX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1EFC10F14
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 17:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72F520833
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 17:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lzkaoXrX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jdJsQdfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfDURmb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:42:31 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5981 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfDURmb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Apr 2019 13:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555868551; x=1587404551;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ng72ot6QHPqrp6c/k4N0f43LNSYPuRxKioFeZZZiCJI=;
  b=lzkaoXrX22mU2eqd7Rd6Br9SLVqIjn65WkuJtlrM/8W4JNN6uTSVkn7/
   J5+p4WdpZs8sZu2OA9Wq4qvoLiWewK8ov0u6NjubpqYj8fd8tswV2X9Bc
   5nbypE5W1Y4y/222pyEBqW/0Pg7K+aM7BfhjbcyFxQBsvVtbtOwR7vI55
   oRF+LABDb7n/wLWThqEFgcfCYC+wvD8xWNfg8L/ir+SizbRHXuphmqS94
   cYse56aThw8WogOMgXBP9eeRo+PRiIqSHfLH+1QfOr+r97OAwtPKfXUhu
   k8VB5UDO0eYLKksIcL/qlL84oQ+A1034FbF45H1qKDqu151BA8BG5pF6D
   A==;
X-IronPort-AV: E=Sophos;i="5.60,378,1549900800"; 
   d="scan'208";a="111410948"
Received: from mail-co1nam03lp2055.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.55])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2019 01:42:30 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8u4qweu3FOpbyWnYzDyA+/DkssXpzTFbJGBG/hMEdc4=;
 b=jdJsQdfo/45hQ3+tY5rtt3iXF6RZA+G3XpjdJpZvhBh+tRTg8yx6YWIepItpX+RYphfHZybpPd0kSG5B+p29qcwgnSnFs6tr+wLAMabWtvE26yRdAB9t7WYVoDU/03DnRsjartSoitfCL66HdY6lswChSqwmss3lNjLo+UlbUbk=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4462.namprd04.prod.outlook.com (52.135.119.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Sun, 21 Apr 2019 17:42:28 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1813.017; Sun, 21 Apr 2019
 17:42:28 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ming Lei <ming.lei@redhat.com>, Greg Edwards <gedwards@ddn.com>,
        Hannes Reinecke <hare@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [RFC PATCH 2/2] null_blk: Make use of size_to_sectors helper
Thread-Topic: [RFC PATCH 2/2] null_blk: Make use of size_to_sectors helper
Thread-Index: AQHU9/Xh1+QytUG6QUKoMOUHE1nFqQ==
Date:   Sun, 21 Apr 2019 17:42:27 +0000
Message-ID: <SN6PR04MB4527DAFECD39E2C26DDF4CE586210@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190421035328.19322-1-marcos.souza.org@gmail.com>
 <20190421035328.19322-3-marcos.souza.org@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d52cc22-6c0e-4ab3-971f-08d6c680b8ed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4462;
x-ms-traffictypediagnostic: SN6PR04MB4462:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB44620633582699E94A3854DE86210@SN6PR04MB4462.namprd04.prod.outlook.com>
x-forefront-prvs: 0014E2CF50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(478600001)(6116002)(66066001)(3846002)(71200400001)(71190400001)(6246003)(2501003)(14454004)(4326008)(305945005)(97736004)(6506007)(186003)(102836004)(74316002)(7736002)(72206003)(26005)(53546011)(33656002)(86362001)(2906002)(446003)(25786009)(486006)(476003)(7416002)(5660300002)(110136005)(14444005)(99286004)(316002)(73956011)(66946007)(9686003)(55016002)(52536014)(68736007)(66446008)(6436002)(8936002)(7696005)(91956017)(8676002)(229853002)(76116006)(81156014)(81166006)(66556008)(256004)(76176011)(53936002)(64756008)(54906003)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4462;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yxYeXIuZ4mmmcRUUnN7T493VnNcgrwdad2pEj9R+O/jQ2MHIV//GvbQSebLaYAC3o66dBL/7vgvRkoFX/q3H9o+ssb1CvIwMuSNPf65ZkGmE8Ufndig0NLF4PYMDJTCmM58OUtfP/VdPjx/86t5XRh01v04nkYM3kq3s/7KZ+TBe+l40/BBgiEMLf8SnSG+8qsqSTXKEm5bwBBEobUeBNvEt8eCg6jkAOeZ8A69Mvou4Oy8KcBdVXeLyXMd8Rg/r6pLJEM5TvSiH/DO7f4ri7VZvkoUX6Jo61VB4qOpMdmPx7mP/1C3jYa9JDtyUgwnyHe3Q9iacDXIvbsYlPzNrQJszZtjL5SbUx0awmPbhQPlEj6AmAEM/Xzt00YA6Xa4gmlk9uFo9xv7Kofu+XD9+6wR12J/N39yankiYr95JpTA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d52cc22-6c0e-4ab3-971f-08d6c680b8ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2019 17:42:27.9365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4462
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by : Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 04/20/2019 08:54 PM, Marcos Paulo de Souza wrote:=0A=
> This helper tries to make the code easier to read, and unifies the code=
=0A=
> of returning the number of sectors for a given number of bytes.=0A=
>=0A=
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>=0A=
> ---=0A=
>   drivers/block/null_blk_main.c | 18 +++++++++---------=0A=
>   1 file changed, 9 insertions(+), 9 deletions(-)=0A=
>=0A=
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.=
c=0A=
> index d7ac09c092f2..05f0bef54296 100644=0A=
> --- a/drivers/block/null_blk_main.c=0A=
> +++ b/drivers/block/null_blk_main.c=0A=
> @@ -853,7 +853,7 @@ static int null_flush_cache_page(struct nullb *nullb,=
 struct nullb_page *c_page)=0A=
>   	dst =3D kmap_atomic(t_page->page);=0A=
>=0A=
>   	for (i =3D 0; i < PAGE_SECTORS;=0A=
> -			i +=3D (nullb->dev->blocksize >> SECTOR_SHIFT)) {=0A=
> +			i +=3D (size_to_sectors(nullb->dev->blocksize))) {=0A=
>   		if (test_bit(i, c_page->bitmap)) {=0A=
>   			offset =3D (i << SECTOR_SHIFT);=0A=
>   			memcpy(dst + offset, src + offset,=0A=
> @@ -957,7 +957,7 @@ static int copy_to_nullb(struct nullb *nullb, struct =
page *source,=0A=
>   			null_free_sector(nullb, sector, true);=0A=
>=0A=
>   		count +=3D temp;=0A=
> -		sector +=3D temp >> SECTOR_SHIFT;=0A=
> +		sector +=3D size_to_sectors(temp);=0A=
>   	}=0A=
>   	return 0;=0A=
>   }=0A=
> @@ -989,7 +989,7 @@ static int copy_from_nullb(struct nullb *nullb, struc=
t page *dest,=0A=
>   		kunmap_atomic(dst);=0A=
>=0A=
>   		count +=3D temp;=0A=
> -		sector +=3D temp >> SECTOR_SHIFT;=0A=
> +		sector +=3D size_to_sectors(temp);=0A=
>   	}=0A=
>   	return 0;=0A=
>   }=0A=
> @@ -1004,7 +1004,7 @@ static void null_handle_discard(struct nullb *nullb=
, sector_t sector, size_t n)=0A=
>   		null_free_sector(nullb, sector, false);=0A=
>   		if (null_cache_active(nullb))=0A=
>   			null_free_sector(nullb, sector, true);=0A=
> -		sector +=3D temp >> SECTOR_SHIFT;=0A=
> +		sector +=3D size_to_sectors(temp);=0A=
>   		n -=3D temp;=0A=
>   	}=0A=
>   	spin_unlock_irq(&nullb->lock);=0A=
> @@ -1074,7 +1074,7 @@ static int null_handle_rq(struct nullb_cmd *cmd)=0A=
>   			spin_unlock_irq(&nullb->lock);=0A=
>   			return err;=0A=
>   		}=0A=
> -		sector +=3D len >> SECTOR_SHIFT;=0A=
> +		sector +=3D size_to_sectors(len);=0A=
>   	}=0A=
>   	spin_unlock_irq(&nullb->lock);=0A=
>=0A=
> @@ -1109,7 +1109,7 @@ static int null_handle_bio(struct nullb_cmd *cmd)=
=0A=
>   			spin_unlock_irq(&nullb->lock);=0A=
>   			return err;=0A=
>   		}=0A=
> -		sector +=3D len >> SECTOR_SHIFT;=0A=
> +		sector +=3D size_to_sectors(len);=0A=
>   	}=0A=
>   	spin_unlock_irq(&nullb->lock);=0A=
>   	return 0;=0A=
> @@ -1201,7 +1201,7 @@ static blk_status_t null_handle_cmd(struct nullb_cm=
d *cmd)=0A=
>   		if (dev->queue_mode =3D=3D NULL_Q_BIO) {=0A=
>   			op =3D bio_op(cmd->bio);=0A=
>   			sector =3D cmd->bio->bi_iter.bi_sector;=0A=
> -			nr_sectors =3D cmd->bio->bi_iter.bi_size >> 9;=0A=
> +			nr_sectors =3D size_to_sectors(cmd->bio->bi_iter.bi_size);=0A=
>   		} else {=0A=
>   			op =3D req_op(cmd->rq);=0A=
>   			sector =3D blk_rq_pos(cmd->rq);=0A=
> @@ -1406,7 +1406,7 @@ static void null_config_discard(struct nullb *nullb=
)=0A=
>   		return;=0A=
>   	nullb->q->limits.discard_granularity =3D nullb->dev->blocksize;=0A=
>   	nullb->q->limits.discard_alignment =3D nullb->dev->blocksize;=0A=
> -	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> 9);=0A=
> +	blk_queue_max_discard_sectors(nullb->q, size_to_sectors(UINT_MAX));=0A=
>   	blk_queue_flag_set(QUEUE_FLAG_DISCARD, nullb->q);=0A=
>   }=0A=
>=0A=
> @@ -1520,7 +1520,7 @@ static int null_gendisk_register(struct nullb *null=
b)=0A=
>   	if (!disk)=0A=
>   		return -ENOMEM;=0A=
>   	size =3D (sector_t)nullb->dev->size * 1024 * 1024ULL;=0A=
> -	set_capacity(disk, size >> 9);=0A=
> +	set_capacity(disk, size_to_sectors(size));=0A=
>=0A=
>   	disk->flags |=3D GENHD_FL_EXT_DEVT | GENHD_FL_SUPPRESS_PARTITION_INFO;=
=0A=
>   	disk->major		=3D null_major;=0A=
>=0A=
=0A=
