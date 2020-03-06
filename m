Return-Path: <SRS0=yWSg=4X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97996C3F2D5
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 06:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55ED92072D
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 06:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CJesJtT0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZgFBt6Yw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgCFGrV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Mar 2020 01:47:21 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54327 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgCFGrV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Mar 2020 01:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583477261; x=1615013261;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UH2yDQQLb2TfgfE+ER40BlIlp5GptLOpYHFXjNRaEsQ=;
  b=CJesJtT02DKYuh/t0AXuO6wyj8pjLUVk91zIj1Qououo/jYscbA+/qcW
   NinMUMfaAzYiQqzBV3g9CZll9aKjCrqOUsDrNaH6Qn8RE4CYd6l1Stcea
   YD5NLzfm96L7YfheM0ROXoQeJpg757ti1shpaUjdcPw6jFoE5HxWwL7gn
   7YeolGtDLr4LfiCgWgMFjMeul91i4819ioF5ChQqNh/RIfpvZii7Fe+yR
   sUGJ+/NJm50IW5VMqUC6/7XEm2q3eBzC5cwL/sXAXNgHg/qsS7WRuq43U
   X63PbuX+PzYTjfqBKku0ncl9jrGXj+25Id7gC/JXsJDz1sf5J9O5GyEdX
   A==;
IronPort-SDR: 4ncOa6Z49pXlyvlCfTb7jLP4aTufgw2AyTlC/u+6wAiYvGY+Nkm5fWopOSCGQZP2wbkAK1EZwR
 4Vr8528DfhQnvynhcuTM8iVz93NT2mNFPHhxXR57xCOVRumZA8LMCtNkI6/l1GPb3qlwi4M9Bz
 VBxQXwj04x1XQTWNaY26XYe4iZ87vi5X+HH+y9zn0FRKBWkpsxWd1u+n5AW37yTvNwYm2N4LY/
 jGRtR6vPT3Yf5zUF61JBEGf/c2yXPSrfoV0Z1FJQfjiyu7wYoIDDl4RFkSIc6gDIAaXdVoRSfm
 z30=
X-IronPort-AV: E=Sophos;i="5.70,521,1574092800"; 
   d="scan'208";a="233685733"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2020 14:47:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNuu90dGdp4UYlxLqSKkBG99/PKB6NTqtQBJ347eyVef7X/cZi0d1LBcmCMYkgGrMjqxwRrwnbnoqEzkHAAqIO8pGaIJC1de2agDZvOboey6DxOOGmq4F9SdmIlKi92k5DWya5786jE2JE/cXN9KZOEqjF1sNvrLIRxHC6HIcjzxYU1OcAiU3WYJ3oKHs3Y610PvHVE+QEf10OYSdgLMHtE8hUmdHrOP9t0m1uMb8gApzcwNqVJoasTpGnqmAwA/Y6rGk9M8NfYSKzEShdis9fXZZk+gJQ49LjCKzRgjzATihZXlN+klDFLeCzDdzhLKd2nGdHfvKlofr4weGfhm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtCNn37N7rVJGirjEpLrzQx933BGnPVh4JdmGt045rI=;
 b=JtxSI4wrVQwMkbK/qP4XgxwKhdIky0Fs9Z0WA5fiV+kROB9oPdL3AR0jiDRuqDXOWRYvMQPiUfsJUnYlyjoAr/cE3ye/cZ+j0Vcz0mseFcuJ/7Pnm7xKgwTf2p9U1jgLc1mdQ/Kt7BK1Nv1BUrGaSxGcCj4xF5rKPSEUGw73SMnJWSWHFgHsOoDcC7qViytUw9Aywrpy7f+JtZ+1kj5AzAUfB/TBM1LdI8jEeqwhrre0lLEDxTLoNcr0KAxeLjMq5g+hQjA25De/f6JbqJpgXvugkskLfvD3Qk0KAAXDTd89ykQ+kCm6Fl9d+BRgwv84/1GwNxi2WDXKf9S/XjK73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtCNn37N7rVJGirjEpLrzQx933BGnPVh4JdmGt045rI=;
 b=ZgFBt6Yw9en/POduJkEk7QsIerw7IZpXWIjkJJ9zqbvYOLyKuSfhQkp0pmUDlup8dMN0YwRJfJHTxqAzUjFcnN1mgmeHSM6mj4O1wTSbiDzV8s6dglJgs7pLQs2B/hMFGXoIfnLrGF/OwCwAWwubYgHXBwbCDAN80xmq1Ytftvk=
Received: from BN3PR04MB2257.namprd04.prod.outlook.com
 (2a01:111:e400:7bb9::20) by BN3PR04MB2196.namprd04.prod.outlook.com
 (2a01:111:e400:7bb8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Fri, 6 Mar
 2020 06:47:18 +0000
Received: from BN3PR04MB2257.namprd04.prod.outlook.com
 ([fe80::58dc:d030:4975:3ac0]) by BN3PR04MB2257.namprd04.prod.outlook.com
 ([fe80::58dc:d030:4975:3ac0%6]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 06:47:17 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2] block: Fix partition support for host aware zoned
 block devices
Thread-Topic: [PATCH v2] block: Fix partition support for host aware zoned
 block devices
Thread-Index: AQHV6FdzhpxQUL1VTkeN4Rgk4DATw6g7NXYA
Date:   Fri, 6 Mar 2020 06:47:17 +0000
Message-ID: <20200306064716.eabtigswnz54j7er@shindev.dhcp.fujisawa.hgst.com>
References: <20200221013708.911698-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20200221013708.911698-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68e71318-6db2-4c8c-c5ab-08d7c19a3671
x-ms-traffictypediagnostic: BN3PR04MB2196:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN3PR04MB219655D7F715DD4B43FFB8F5EDE30@BN3PR04MB2196.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(189003)(199004)(8676002)(4326008)(44832011)(316002)(54906003)(110136005)(478600001)(6486002)(8936002)(71200400001)(6512007)(9686003)(81166006)(86362001)(64756008)(66446008)(66476007)(66556008)(66946007)(81156014)(76116006)(5660300002)(91956017)(6506007)(2906002)(186003)(26005)(1076003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR04MB2196;H:BN3PR04MB2257.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o50o/AJ/6tELJ3lHJCw9+A24BKwl0lfAJ5wQkdCBxVeEf4duwOCQCFnLwP/YE7x+kf8bSgOAQPYP57AiDJAAx2167qGy6S/ExU8LqKyMkE/VX/tACKj3MwrmSqUFt9paKDgonqnTYqbI5jmanJq+4KYkwKAHc1PdXU7xyy1NFVjezQ2U5sTVz2XLQCZFxT/+uL9O5BL252RrFYG0iFIZqajB8tkdsp/9g9gkvGvM63G80ru1D0rV3at4ED6x3XhohILoVmj/qPHifJG6Vg2Ig5AcHRgjL2c9648AXH+ufVjtPm70frDHcXREGRTO1I7R93p0//cjTP0byoz6Ql1hn3N353/aaFd+llYtFEaekH1jdaqawzcs6pgWIAi/GzdI8eCEusfqzhfMUIfGrN0CQHBnat1RLrRuzU6L7JTf7WoGFZi02wCsKk3KIEVh9j8i
x-ms-exchange-antispam-messagedata: kaqOetWptfEWfUQugYPti2WwAM1EpGd0XTzBxFdVN3vQdRAtUttTuE/9cnxMR6tZJhGIgmYmN08O0jEyRBQPi3j4oL0aJEREJ1k7N4Cu9aP6HbYHPK3R8wefg6cxmuaqUpNRVEcWiyfIyvTJrbUaeg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <137178A89C1A7748862D36C89976E797@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e71318-6db2-4c8c-c5ab-08d7c19a3671
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2020 06:47:17.7715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D3Eyv4O08iD58cpmt8zmHR+3ShOW1uu0WA0DIaDObX3kTjy1oqjtnpgjknjK7GE+Z/7mZtkC0Hmaqek3YbfXx/8SKMo//5m//wIsWSL4/78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2196
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Could you consider this patch for upstream?

--=20
Best Regards,
Shin'ichiro Kawasaki

On Feb 21, 2020 / 10:37, Shin'ichiro Kawasaki wrote:
> Commit b72053072c0b ("block: allow partitions on host aware zone
> devices") introduced the helper function disk_has_partitions() to check
> if a given disk has valid partitions. However, since this function result
> directly depends on the disk partition table length rather than the
> actual existence of valid partitions in the table, it returns true even
> after all partitions are removed from the disk. For host aware zoned
> block devices, this results in zone management support to be kept
> disabled even after removing all partitions.
>=20
> Fix this by changing disk_has_partitions() to walk through the partition
> table entries and return true if and only if a valid non-zero size
> partition is found.
>=20
> Fixes: b72053072c0b ("block: allow partitions on host aware zone devices"=
)
> Cc: stable@vger.kernel.org # 5.5
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> Changes from v1:
> * Addressed comments on the list
>=20
>  block/genhd.c         | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/genhd.h | 13 +------------
>  2 files changed, 37 insertions(+), 12 deletions(-)
>=20
> diff --git a/block/genhd.c b/block/genhd.c
> index ff6268970ddc..9c2e13ce0d19 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -301,6 +301,42 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk=
 *disk, sector_t sector)
>  }
>  EXPORT_SYMBOL_GPL(disk_map_sector_rcu);
> =20
> +/**
> + * disk_has_partitions
> + * @disk: gendisk of interest
> + *
> + * Walk through the partition table and check if valid partition exists.
> + *
> + * CONTEXT:
> + * Don't care.
> + *
> + * RETURNS:
> + * True if the gendisk has at least one valid non-zero size partition.
> + * Otherwise false.
> + */
> +bool disk_has_partitions(struct gendisk *disk)
> +{
> +	struct disk_part_tbl *ptbl;
> +	int i;
> +	bool ret =3D false;
> +
> +	rcu_read_lock();
> +	ptbl =3D rcu_dereference(disk->part_tbl);
> +
> +	/* Iterate partitions skipping the whole device at index 0 */
> +	for (i =3D 1; i < ptbl->len; i++) {
> +		if (rcu_dereference(ptbl->part[i])) {
> +			ret =3D true;
> +			break;
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(disk_has_partitions);
> +
>  /*
>   * Can be deleted altogether. Later.
>   *
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 6fbe58538ad6..07dc91835b98 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -245,18 +245,6 @@ static inline bool disk_part_scan_enabled(struct gen=
disk *disk)
>  		!(disk->flags & GENHD_FL_NO_PART_SCAN);
>  }
> =20
> -static inline bool disk_has_partitions(struct gendisk *disk)
> -{
> -	bool ret =3D false;
> -
> -	rcu_read_lock();
> -	if (rcu_dereference(disk->part_tbl)->len > 1)
> -		ret =3D true;
> -	rcu_read_unlock();
> -
> -	return ret;
> -}
> -
>  static inline dev_t disk_devt(struct gendisk *disk)
>  {
>  	return MKDEV(disk->major, disk->first_minor);
> @@ -298,6 +286,7 @@ extern void disk_part_iter_exit(struct disk_part_iter=
 *piter);
> =20
>  extern struct hd_struct *disk_map_sector_rcu(struct gendisk *disk,
>  					     sector_t sector);
> +bool disk_has_partitions(struct gendisk *disk);
> =20
>  /*
>   * Macros to operate on percpu disk statistics:
> --=20
> 2.24.1
> =
