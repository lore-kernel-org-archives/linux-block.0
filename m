Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1012FC34022
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 08:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE772464E
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 08:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IuisDdPB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pfJFyInM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgBSIhN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:37:13 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:49251 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgBSIhM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 03:37:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582101431; x=1613637431;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=uoXD6DNm8ujvdyYpaXlOPKivFHwKYHtISkHyV8uE7DM=;
  b=IuisDdPBHksW8bg6Mzx73EXETYZBBZYZifM1howzVcm8Flo6Z9bgtSDb
   YP7gfNL7RXbHbhiQ+yt9xGAZD49iS+vtCTgjGeVautwGnr1bSI0bRDwcR
   ZGIwJeVNmnxxCqOIvAEsfgu2w7nALcZxirTbsFCghIWZ1YWd5Tl8m8Ws+
   TrXe4ltm/Z0ZXrReoKm+Y5qxjLoVVF1lYvoi0baTQInaeajlby8kZFP6Q
   3jR2OlLZSFJ5ZLBOWEt2n8K6pFHEkFk6oq33fYzykO8MRD9LciuHA+fOe
   CSyA5d8v9sAj0QCEL5p8KSbeaujxAMtXFYU9koynXGa4F47x9YZgPVOSs
   A==;
IronPort-SDR: /t3IutAva+kOK1gqFz6a13VsiGumxKzKyDNf0kZi3g/P0PRuwtfFsBir5AHv8A2QKdZ+dEpMbP
 i9MVyOx8qIRPK1jd9H8WRDD2Oe2q0wPoEQvcST9e2Lqp1Meg8vNVGC0OH1xTzJz+C/9HSNqxbd
 FbgzdEga33YGo71zxNLHFgj9v31jBdWv8VVIOTy3uTnd6fDMqQxEpKHTbTjBtkYG9WIotzbwGD
 YDDbWmA4cPkLUzdwJmFpG8no0tIVrStQuiymj8Qy8PCSkhzPcZs75zMSXy+eyK5c1JhEnmU86D
 Ku0=
X-IronPort-AV: E=Sophos;i="5.70,459,1574092800"; 
   d="scan'208";a="238263972"
Received: from mail-bn3nam04lp2056.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.56])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2020 16:37:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEn8CXOkTD/o7RP5CuSDY+uhmlsSKRwOCXcMPciUtXh51PnDPZ+tjiz9ZnbkuUmA/HVtnWy+5NKsQBKm8JfcVYrbZOUB/4eYV98OPbMhiiBT60YISlIGvclH5MH8PQ2yf77/BvS+aVDrmxhkCQ7Nhr33uPSEolblb0+uka6mlEYyubXiWqVSbIEwnv8Hnl1x0+n2lchvorXS9Opqn978vQai1osttaN6eGZV1oDVoEf7f9u4Z5tqOFKHP2VE1FrSTV7IlDpOxE5f6Ppysk4i9oEPFJ5oj3AfH5yJhbs5OoN6zokr/MZ37WFw8e7P9VcRRW6VLDTPbu9TplVyOHBz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zGSSTJIyMTDwpoaK2nWocY/czNeoB9dH+4dqozfcx0=;
 b=EODxrbyzHK2IRS86OeaWzU9sSBQN/55b5K9500523X8D65iptUNLBNGtQNATXspt1VgVqBpotZElAB9WovMwjy7z3IwbhCJNtOxljCUJYzBbu0x1Ppmbc9hEdTzaOVJVHFpwr4dZrqk9G9A1HLCIWGQzK8pWJ7Yl8fJOtCtYIrAy3GXRsuNRBpIEz5zZKY6BL7FVbEErWBXEbLyrBjHFYeTERwLfRA5jj8R7TVStUuHul0nHcoU6gJKxRkPtrUJVKHa2Kdk2GHxnEFJbk5Ay5Y/3YN/vB7gA8Wsgj56yDy0K9aIQjPikHU4N68g+9SQsCy618Fpi+OrCZaP/lkf/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zGSSTJIyMTDwpoaK2nWocY/czNeoB9dH+4dqozfcx0=;
 b=pfJFyInMrMMy6j6Pfaz9Lqv0HBkX1s7/+uqrhqwgQgS1pG9zbAQ6xcAItM8/sJc7Zc7C8ashHvJuarakep8oOoEMP67Q5nuMR1hLVlUAVNtvQq/iNsUFQSZgjAoxAVV4vjkGr7m2G1GxXzqIO5o+uW5dY864iUzNfMTtdzmZsZo=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB3894.namprd04.prod.outlook.com (52.135.218.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Wed, 19 Feb 2020 08:37:09 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2%6]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 08:37:09 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: Fix partition support for host aware zoned block
 devices
Thread-Topic: [PATCH] block: Fix partition support for host aware zoned block
 devices
Thread-Index: AQHV5tzHe/9t1i30tEOuzMev/cMQAQ==
Date:   Wed, 19 Feb 2020 08:37:09 +0000
Message-ID: <BYAPR04MB58161F1B162EF316148133B5E7100@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200219042632.819101-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 349a9e94-aeeb-4de5-4e3e-08d7b516e8c9
x-ms-traffictypediagnostic: BYAPR04MB3894:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB389464DC837D9AC8A112B10DE7100@BYAPR04MB3894.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(199004)(189003)(6506007)(53546011)(5660300002)(86362001)(110136005)(66476007)(316002)(76116006)(2906002)(66556008)(66946007)(64756008)(66446008)(91956017)(478600001)(33656002)(71200400001)(81166006)(81156014)(186003)(8676002)(7696005)(26005)(52536014)(8936002)(55016002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3894;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pulejClzFq5xdkDidtlJnVClvdSmxpoJiFxzeEZ6ibjrXHKRX5TUozrixhFwoyd25QTc/AjmjR6vCXNlfxcVfq7REWv1aZt72R9tv83jnEt7zkqJmsxpRKwpNhnmn4WKIgDGzpjMQQ9SWrUSbVuFETS7NLuPH6XYV82XtJ3BTHAxHACbQBhrS4eiGhkyEMf/f92lYvHS3uW6VIMxnV2ehl6R0KMPPAv3kLiSq/+NzIUNZINrtRDpbfNOznO0cs7hFvanPC13CeKuShBCPvuLJ/K1wzo/f2+IECbrZQTJn731I3okHy3UlBi3Hrw3Cvm91JZrU6KtAw6GdRv+JdxtX+kcSGwdk4E3yr1+hw0AiVG31lMfNt4lPZdbxz9yPlgY6i4QyLJWqpB0AjGkPcZblkSj0k4NNw5HWXKSswXYL2J/oyCXlFKl3RjkRFO9trbt
x-ms-exchange-antispam-messagedata: m13djewdOqVa4X4cLZnJB9ghvhcqvoVhBKqsjl7yXwsgbswrl7ZCl3+gUr2DfYxvpVWRs2Plhpux9A0cG2+dzrerpem+ZzsQ0613P1hSUVHaAsOvCwKkiuHaX44eJODKYkWYLoHqYejcjD6MXigdsg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349a9e94-aeeb-4de5-4e3e-08d7b516e8c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 08:37:09.4030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jOux8q8z69YJ6CJOIA8QTcYRXAyZGJzkngOkc8vzS5B3SG2f3GRzpL732wTXX1DXdSy9rhNX2tiZNFogPLQqvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3894
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/02/19 13:26, Shin'ichiro Kawasaki wrote:=0A=
> Commit b72053072c0b ("block: allow partitions on host aware zone=0A=
> devices") introduced the helper function disk_has_partitions() to check=
=0A=
> if a given disk has valid partitions. However, since this function result=
=0A=
> directly depends on the disk partition table length rather than the=0A=
> actual existence of valid partitions in the table, it returns true even=
=0A=
> after all partitions are removed from the disk. For host aware zoned=0A=
> block devices, this results in zone management support to be kept=0A=
> disabled even after removing all partitions.=0A=
> =0A=
> Fix this by changing disk_has_partitions() to walk through the partition=
=0A=
> table entries and return true if and only if a valid non-zero size=0A=
> partition is found.=0A=
> =0A=
> Fixes: b72053072c0b ("block: allow partitions on host aware zone devices"=
)=0A=
> Cc: stable@vger.kernel.org # 5.5=0A=
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
> ---=0A=
>  block/genhd.c         | 36 ++++++++++++++++++++++++++++++++++++=0A=
>  include/linux/genhd.h | 13 +------------=0A=
>  2 files changed, 37 insertions(+), 12 deletions(-)=0A=
> =0A=
> diff --git a/block/genhd.c b/block/genhd.c=0A=
> index ff6268970ddc..ed8cdebc2cf0 100644=0A=
> --- a/block/genhd.c=0A=
> +++ b/block/genhd.c=0A=
> @@ -301,6 +301,42 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk=
 *disk, sector_t sector)=0A=
>  }=0A=
>  EXPORT_SYMBOL_GPL(disk_map_sector_rcu);=0A=
>  =0A=
> +/**=0A=
> + * disk_has_partitions=0A=
> + * @disk: gendisk of interest=0A=
> + *=0A=
> + * Walk through the partition table and check if valid partition exists.=
=0A=
> + *=0A=
> + * CONTEXT:=0A=
> + * Don't care.=0A=
> + *=0A=
> + * RETURNS:=0A=
> + * True if the gendisk has at least one valid non-zero size partition.=
=0A=
> + * Otherwise false.=0A=
> + */=0A=
> +bool disk_has_partitions(struct gendisk *disk)=0A=
> +{=0A=
> +	struct disk_part_tbl *ptbl;=0A=
> +	int i;=0A=
> +	bool ret =3D false;=0A=
> +=0A=
> +	rcu_read_lock();=0A=
> +	ptbl =3D rcu_dereference(disk->part_tbl);=0A=
> +=0A=
> +	/* Iterate partitions skipping the holder device at index 0 */=0A=
> +	for (i =3D 1; i < ptbl->len; i++) {=0A=
> +		if (rcu_dereference(ptbl->part[i])) {=0A=
> +			ret =3D true;=0A=
> +			break;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	rcu_read_unlock();=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(disk_has_partitions);=0A=
> +=0A=
>  /*=0A=
>   * Can be deleted altogether. Later.=0A=
>   *=0A=
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h=0A=
> index 6fbe58538ad6..f1b5c86b096a 100644=0A=
> --- a/include/linux/genhd.h=0A=
> +++ b/include/linux/genhd.h=0A=
> @@ -245,18 +245,6 @@ static inline bool disk_part_scan_enabled(struct gen=
disk *disk)=0A=
>  		!(disk->flags & GENHD_FL_NO_PART_SCAN);=0A=
>  }=0A=
>  =0A=
> -static inline bool disk_has_partitions(struct gendisk *disk)=0A=
> -{=0A=
> -	bool ret =3D false;=0A=
> -=0A=
> -	rcu_read_lock();=0A=
> -	if (rcu_dereference(disk->part_tbl)->len > 1)=0A=
> -		ret =3D true;=0A=
> -	rcu_read_unlock();=0A=
> -=0A=
> -	return ret;=0A=
> -}=0A=
> -=0A=
>  static inline dev_t disk_devt(struct gendisk *disk)=0A=
>  {=0A=
>  	return MKDEV(disk->major, disk->first_minor);=0A=
> @@ -298,6 +286,7 @@ extern void disk_part_iter_exit(struct disk_part_iter=
 *piter);=0A=
>  =0A=
>  extern struct hd_struct *disk_map_sector_rcu(struct gendisk *disk,=0A=
>  					     sector_t sector);=0A=
> +extern bool disk_has_partitions(struct gendisk *disk);=0A=
>  =0A=
>  /*=0A=
>   * Macros to operate on percpu disk statistics:=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
