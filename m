Return-Path: <SRS0=LczR=4J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D94C11D00
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 02:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C74B20722
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 02:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QhSEuua8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nWEyZL6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgBUCDD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 21:03:03 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:38904 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgBUCDC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 21:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582250581; x=1613786581;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RNGLLi0GJm5/kMyiLEppMW5vsYlpfjnGqzm8VtdAxR0=;
  b=QhSEuua88SrJudqaTkV3IhkTicuhdZokJedYLK4HPOUS6j/zzRJgA/k+
   MRGuOsHLBZ2yl0glN4u7sGxD+oHh+DZGVjEFDC+yWR4dZRWEtHe61E+GS
   rtiSX4ZWCnXikm5oKjEa0qJx6tzXNGVXpsadsd+ny6JNE1C/rep3flQb9
   n/rIduc8XQJnxPfguMxwqotdRplPB9iIUkgBAbIpUa2h87bEXHR9Bz3S+
   utjJZ5FBl5BFph/naToZUTvbFwF9hZlYYee8jyXTtGok6cwivDyepKGU1
   s8jHnxEfbS5oKnEXJCLaxasJkv4bFTTwKUGDRgdxFncVFZ8Z0Gg+OaJ7g
   A==;
IronPort-SDR: Po2IRhIrCawGA+lnj32eA6uBEYRhBnSCJY4PdvHhpE5Qon97fXf3I0122Dbc7hvY7apT8BrIQj
 PjZ9abViNk/Hw1aloeLth22v7syfesfZDwcGh5gsWqzNt7Spuzv3xGGST3+ZBsHCKP3e6Nz9TN
 patYB3pBxRcn3si4CGuWPax9FuHxzMo6ZWlSHK3HYgM/1OZYSjkHzxmuy+EObcwXff9gNizGxr
 c0KiZtOtuKrMbnyD+4rMJ5zjJb8xkQJDBZaCsUbdJs7gv3xW8Y9AZJSsHodBaLOzVdVEjzmqZq
 K5o=
X-IronPort-AV: E=Sophos;i="5.70,466,1574092800"; 
   d="scan'208";a="130325755"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2020 10:03:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NURBhMOzGFkXsgttmzdJMlx2n2AZ8cCJROFhNvRviZkGs7P+M11lAzWvw5iuAYdYHf3GPCjjmZRSPTL7QrIt2t/9MEEyWb71vCSnOhWgObN2zljI45eEaWbYB2nfNCRUCUxzm2XSiPjIkYoWCCCBReqz+BryRlpbi4eP1n3MDJo138wYfLRgvxjn/ugWg2vNdgmhM+vqwFk5ID/FT5ALG5RTpAn/BaOHnV1IvVl140bpb1Fz9e0FUuQRw8Xtykj8x1bY6iapZQrUaGPsCkBJ6rF32/LYu/pPG4fQEwjhSluNAz5N74Jaogu/3DWTBfyFeCgyT/I+eUs9HQAuRwnzpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/SMilK1zuM4Zer7+AfdMtlA6xkUD+D+klpJG4aSKGE=;
 b=epcipsS8yKKw5f1rUJilEALvkgC3tTlH2zD1+fNqQhryrpk2CJ2h1XM9DxblnuRRt8siT360e8CjbA2jSj2rg0AaZiQAfap/EoLBQITEXasNzGuXFq8EdH0rAjTtuR++WgvbxgvoLHuciEPM8S0OXDwoPLH4LTDMBUHQ2pskd+4g/dvTpir0/Ua4bI7/HtApL+sCLK4TDlTANd5u2UzGXaa4B9bpfaSU722NrSU3SyFXUIW5yylzzQ+ikIQmXHMkfu8ly/BQJhrmsjf4/M+gKSmvEvMA0wfy4HLbX+a+8lRGTeCOKdhG3zEE3/zhWPtud/tqHkwZEvJ3gpPBxcpOVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/SMilK1zuM4Zer7+AfdMtlA6xkUD+D+klpJG4aSKGE=;
 b=nWEyZL6ChSuLX0tQm5J6uX13YXrDH2HID7KR8y2PMkYQKDw+vzaIMxSYHwws9j4/9dopWzoCPMtpW4qfT1CTshyDgCxEOKUphvudEg/SSQN5ZmcSKRuOowEk7CUpi/SFZx+r2KJS44Q/w+OQIPhooEfgPweDnSmV9+23iZsFrcY=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5958.namprd04.prod.outlook.com (20.178.232.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Fri, 21 Feb 2020 02:03:00 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 02:02:59 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] block: Fix partition support for host aware zoned
 block devices
Thread-Topic: [PATCH v2] block: Fix partition support for host aware zoned
 block devices
Thread-Index: AQHV6FdzdICq5C7sX0WnKCmOrJWqGg==
Date:   Fri, 21 Feb 2020 02:02:59 +0000
Message-ID: <BYAPR04MB5816C6EFF48B6DA8D66EC9D3E7120@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200221013708.911698-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29f3812e-c57b-4322-8728-08d7b6722d50
x-ms-traffictypediagnostic: BYAPR04MB5958:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB59589E0343EB420C5A325F50E7120@BYAPR04MB5958.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(53546011)(6506007)(5660300002)(64756008)(66946007)(66446008)(66556008)(66476007)(8936002)(33656002)(316002)(55016002)(8676002)(71200400001)(110136005)(4326008)(186003)(478600001)(26005)(86362001)(81166006)(52536014)(7696005)(81156014)(9686003)(76116006)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5958;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pzPJ16djpOzjyfJd9UGi5VTKm/FnSZN95RCer9Ih89J+QWI2SqfBReQEWjqVtIOdHFGz3SX2k+f/0nnBq0qluUmbqdF00WKN29D91LDS+maAiBEzaECD7ueiv8J6En7ZOqmPRva3xA+muwjbEmh60wQbt8LQsoqjmZeoSvrkOjDyjmzArmyEJNdZuGAfK6Ym+g7RU9odQwUEICN3WSJH8gPObW2DCKA80ONLtfCX6gFO+kw2Ya2pNqrJD8e6SWAMvss6uAetNkD1rP2f/5kTkitBRhRcL9f7NEMGCo8GCtFGcGZ/QBBqEmiAf0HhSb3nY/9W2O5pfw+WIeA2LqRP3us+PN8EkvgUpe7wTM+KJ6a1KYAzFl8FBtC83hWq3nYDK+lZvLmEfF9aOHZosXECX8jrXalkoskpX4iO36mZLXOeIqTTQOk2KKVexkgFrzzh
x-ms-exchange-antispam-messagedata: TxvT8Vjg856AP1KMguRJUV1fc4quXc2i3CdKALvxkeaOKJVm2yPYWR04QRO42mR3kdsyx0jUh7LKQIixOFPLl5+IqV93fcKZmSumhpLNtHG1UOwQA8F01kSIoOH8JVWu94Zip88+AePc890tk1Muzg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f3812e-c57b-4322-8728-08d7b6722d50
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 02:02:59.7794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Zt1Q+qWw00FosU+/jpMncR0ipcIBJmmWO1ax9bj1hYDa7kp684QQecxIHVpKTt0zJZMj7/s8v7YkF8XjK0Avw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5958
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/02/21 10:37, Shin'ichiro Kawasaki wrote:=0A=
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
> ---=0A=
> Changes from v1:=0A=
> * Addressed comments on the list=0A=
> =0A=
>  block/genhd.c         | 36 ++++++++++++++++++++++++++++++++++++=0A=
>  include/linux/genhd.h | 13 +------------=0A=
>  2 files changed, 37 insertions(+), 12 deletions(-)=0A=
> =0A=
> diff --git a/block/genhd.c b/block/genhd.c=0A=
> index ff6268970ddc..9c2e13ce0d19 100644=0A=
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
> +	/* Iterate partitions skipping the whole device at index 0 */=0A=
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
> index 6fbe58538ad6..07dc91835b98 100644=0A=
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
> +bool disk_has_partitions(struct gendisk *disk);=0A=
>  =0A=
>  /*=0A=
>   * Macros to operate on percpu disk statistics:=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
