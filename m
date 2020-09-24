Return-Path: <SRS0=VsgY=DB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA74DC4346E
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 08:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55BFB2376F
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 08:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Wsc/BLaX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="E8XocONY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgIXIls (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Sep 2020 04:41:48 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:64429 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgIXIls (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 04:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600936908; x=1632472908;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=TsYuoRILjGadxMqfT4sMuLYRGz9jAXEVyV8iYjmzjfI=;
  b=Wsc/BLaXLhj668lWdhG4WHdYvket5totlxZq2dEJ4pX31NSI2bqbKsyc
   diT+Vf+wqrCLFIWxZt4Eyg6K3v++LfnwrPIPAxPh23/gnD98KxLjJeMA0
   i8aAjJpTVHVXBz//FtUoRtUvSAuigpoCCEu35EeigKYKa2AzgHz+dV9yx
   2eeuxNROfLALoUIbQrUrMjrvCenvA6i/RVu4TxzDKosqLxsZP5wHRRqed
   hW9BU6oj1ERul9jjprB69wVuPVOwcUX117RRNdjxosttx/XnWZtzSgTbx
   mZqQE7ZnZmLqSXBFDgmZAVNXOxbV5CDvvgYMxsJuUORLhbcx08+/nN9S5
   Q==;
IronPort-SDR: v7PpwDdvN9ug1i5VpcjzgD0BIzCwbtcfhYwSoT+u2se/UTjytornt7pJ3rE3LFl90HTQ0FzMny
 JMCa+tTGxmiJ31Hj/8AudMbhNcg/4okN4ehvmKGL+mm0XDOcBAUKGWCbKV8f2inm8tqqOoj332
 Mn08CxM5JF6WrHjxn24fMk3GY+jLU3EQoiQipUatfjsLmcrM+p/1+B00756N/HWLTGhqBqwi1b
 oWRh+oPwzC7FZxJ/oxXcMt621UVupNv/GhoZ1Sf0uDdnVMeiCY1bgmE/1tyBs/0RtvtzOx8SJl
 vBU=
X-IronPort-AV: E=Sophos;i="5.77,296,1596470400"; 
   d="scan'208";a="152537297"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2020 16:41:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sg2MCS2zkxYcb7swIO1UCuecZZcb8CBjSPddXP8036rn7anGuBjB7ZKAAzc6y16vxT/5W4zGO3X8NBoN28e3wtUTW6uqGLoOkhmCOIQ0bEdfSqvMdsDoSxxHRpX6P/qFB+i6bENG0LTc68WZkDX/m8/vnfnBXinun0gK+ox6QgqlnK8DHEO0RArWCbMby3ngwoJOzswWxpshpnHzG40maloqzKtNcE0u7qnzdY5wfVO97DiB679eiLF8tUEkmOJj3toEN1exLEROZW4vCHsm7KCsKmWsvzuG7vxSuhcIvLL18/QekVuteb5C2ZytQAlEJQTM1Js7/RV8wC9HhKcaNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sc8Audq5oToJnztUuAKFWb4esj4lN1jPo20lAlkds+4=;
 b=R3dsLvqqB/8yPnNL2WOlCG+QdXqbFa4z+ViXqE8rrYBaWJUrHFpiwjJb66Ob6gOxBt+VoQV6iy9Izd+IVAPt5cVM+B/xbNjnDsvjeNjDZltkKJ2jrcnh6exlWxcegGEpc2CYMlMFy+IpzvIiP6OXhW9FmedeVL0wMZCI06Rw0R3ZUCRXB4mqI9WlChikZBTGlkFUNBlykZ6aofcHN+S4ocTfrT4aHVazQLyLhHGsp4DE5jA8JY3EBBSd9a8tOapLQvRRhpFYcKA0ApfNFh5DecRXxxwxLDmPDxxC8MgPpj+gFJ4O2EBmlvjBraO17ArXnXxpMkD9qARiMMurKAXKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sc8Audq5oToJnztUuAKFWb4esj4lN1jPo20lAlkds+4=;
 b=E8XocONYv1zJ0je2SgTecfUnOo2dimWtUIfAmjxKaNvp69YHlTg4pWibkC//zEiDUMaxbrsLhz4KX4R/ZQqjK4AytLKv+l40L93HwkpbGUriKHE8PTy3KVkqlVPmn8JROvafgdkG4AMjWVpB6n6XumUIIJHbSW1ArAKzmF2jMCY=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY1PR04MB2218.namprd04.prod.outlook.com (2a01:111:e400:c617::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Thu, 24 Sep
 2020 08:41:46 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3391.024; Thu, 24 Sep 2020
 08:41:45 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Kanchan Joshi <joshi.k@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "selvakuma.s1@samsung.com" <selvakuma.s1@samsung.com>,
        "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>
Subject: Re: [PATCH] null_blk: synchronization fix for zoned device
Thread-Topic: [PATCH] null_blk: synchronization fix for zoned device
Thread-Index: AQHWkjuiiNiNFsjI00+vzUMlqX8Gyg==
Date:   Thu, 24 Sep 2020 08:41:45 +0000
Message-ID: <CY4PR04MB375112089B44648B524EC7E6E7390@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <CGME20200924062620epcas5p2f0468a1f41d4177ce15727c519bfbad5@epcas5p2.samsung.com>
 <20200924062136.47019-1-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:e81b:3ad8:22d2:24f8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 414cc192-cc53-49bf-b065-08d86065ab84
x-ms-traffictypediagnostic: CY1PR04MB2218:
x-microsoft-antispam-prvs: <CY1PR04MB2218E5475CE92690FDEFE433E7390@CY1PR04MB2218.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L+U00bK5pcT1o75TYLyAA5eOznxCcPr1veRdlHo0WpUu0+CCYyqsBYsLbc4okDq/rwMiEYurBDzXU/cq4ycJojPOnT0dnciFmLtFjJ9gXodgkIT6rBTDlB1MSGL7AZlkkJ3+9Szh24nHCBXBf6fKDLW3CQKrNwM0lF6Hunu4m2ebLZatrNMTAEUJNLIQsfojeH9YfA1wq4ui44CiY4UmslaDQr0j4UnqXn7YizY+/cQ7P5AZwUFIjxbzvyZ1DlUO5pqu4CRGHcDaPlZXBvDwY4bLpncbZ04TpGLcaxF0OrwVd3z77Yu7RZY7kCUxJY2NPRGieCYTi/yqWd2FuhCZYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(4326008)(478600001)(9686003)(71200400001)(8936002)(316002)(33656002)(52536014)(8676002)(110136005)(7696005)(91956017)(54906003)(66946007)(83380400001)(53546011)(76116006)(6506007)(186003)(5660300002)(66556008)(66446008)(64756008)(66476007)(86362001)(55016002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GDyvkjWc3gHLWegw7ZRIG1cmmOlZrrq2ZWYOHweEgnijtssrE3Q/JGDPQahCYaRdwUdl3gLebDMwWbZjqRVwsp3rn3Zo305KpU6TilAIhyZnrbSH5RE3hianJA5GO8KvxfLzcyYV3lhcH63WvWwdHNYZalszsVq6wGrwF4gttnqxh28NpVf//I5zfn13BYpp7/j64uPmk95dD25XRyQZwwO0tzJDic/oE+epc5bn0K6NYhHcLOzLYbArHEfYb/OVYYfRqKqFZycrX0F3dMQ7+9hZ9jqKVX0dDBc7cejNj6kq9Gs0SwXpoqcaBdXXX4iH8nxeXdoKcVrzS3buNBo3Qc2xQiVreGcwVzGzXNdecVLggO4FswH93gyuRuJDNlDWI9hklqRFXCy2F4K8InmGXDy3yhIvdvZzoK2fWounR8fjGiNVeNP7UE0Z5jSOTDEnJRaHXTc97A8qmcycYDYHXkRbgdLA8Du44XxhTkDvQjeeId1MV/ujFXfJTx3RnlDX6Icu8PgGv33+s+uIZXAZvNYSA5jqepc2wFzWnh6Ht+K5Q1MzYEPfH0P2/36j5NKG+j2gCcfMFWfQbtkmkxRbVWLGzo2jrVgVMBW3+QpTmvkIznIAAnMs76sgUUpKlcMwQ5oxbW7Tppe0TAZIGRCGa4AQvOBSQ2f47q1cTY9xnGOGnYDrXDZmbJwEUYY7+6Jbiy6qQE2zHK0KoUnmEZuvTA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414cc192-cc53-49bf-b065-08d86065ab84
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 08:41:45.5789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vKVvn3VRYI+dqfDjFa+CHadTh7tFsTtw5mBhiEg7l0KFOlplf7C7d/enXjpHAZ9yFJuG6rUuMVglOrATwvAR7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2218
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/09/24 15:26, Kanchan Joshi wrote:=0A=
> Parallel write,read,zone-mgmt operations accessing/altering zone state=0A=
> and write-pointer may get into race. Avoid the situation by using a new=
=0A=
> spinlock for zoned device.=0A=
> Concurrent zone-appends (on a zone) returning same write-pointer issue=0A=
> is also avoided using this lock.=0A=
> =0A=
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
> ---=0A=
>  drivers/block/null_blk.h       |  1 +=0A=
>  drivers/block/null_blk_zoned.c | 84 +++++++++++++++++++++++-----------=
=0A=
>  2 files changed, 58 insertions(+), 27 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h=0A=
> index daed4a9c3436..b3f4d62e7c38 100644=0A=
> --- a/drivers/block/null_blk.h=0A=
> +++ b/drivers/block/null_blk.h=0A=
> @@ -44,6 +44,7 @@ struct nullb_device {=0A=
>  	unsigned int nr_zones;=0A=
>  	struct blk_zone *zones;=0A=
>  	sector_t zone_size_sects;=0A=
> +	spinlock_t zlock;=0A=
=0A=
Could you change that to "zone_lock" to be consistent with the other zone=
=0A=
related field names which all spell out "zone" ?=0A=
=0A=
>  =0A=
>  	unsigned long size; /* device size in MB */=0A=
>  	unsigned long completion_nsec; /* time in ns to complete a request */=
=0A=
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zone=
d.c=0A=
> index 3d25c9ad2383..04fbf267703a 100644=0A=
> --- a/drivers/block/null_blk_zoned.c=0A=
> +++ b/drivers/block/null_blk_zoned.c=0A=
> @@ -45,6 +45,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struc=
t request_queue *q)=0A=
>  	if (!dev->zones)=0A=
>  		return -ENOMEM;=0A=
>  =0A=
> +	spin_lock_init(&dev->zlock);=0A=
>  	if (dev->zone_nr_conv >=3D dev->nr_zones) {=0A=
>  		dev->zone_nr_conv =3D dev->nr_zones - 1;=0A=
>  		pr_info("changed the number of conventional zones to %u",=0A=
> @@ -124,6 +125,7 @@ int null_report_zones(struct gendisk *disk, sector_t =
sector,=0A=
>  	nr_zones =3D min(nr_zones, dev->nr_zones - first_zone);=0A=
>  	trace_nullb_report_zones(nullb, nr_zones);=0A=
>  =0A=
> +	spin_lock_irq(&dev->zlock);=0A=
>  	for (i =3D 0; i < nr_zones; i++) {=0A=
>  		/*=0A=
>  		 * Stacked DM target drivers will remap the zone information by=0A=
> @@ -134,10 +136,13 @@ int null_report_zones(struct gendisk *disk, sector_=
t sector,=0A=
>  		memcpy(&zone, &dev->zones[first_zone + i],=0A=
>  		       sizeof(struct blk_zone));=0A=
>  		error =3D cb(&zone, i, data);=0A=
=0A=
The cb() here may sleep etc. So you cannot have the zone lock around it. Ta=
king=0A=
the lock around the memcpy only is enough.=0A=
=0A=
> -		if (error)=0A=
> +		if (error) {=0A=
> +			spin_unlock_irq(&dev->zlock);=0A=
>  			return error;=0A=
> +		}=0A=
>  	}=0A=
>  =0A=
> +	spin_unlock_irq(&dev->zlock);=0A=
>  	return nr_zones;=0A=
>  }=0A=
>  =0A=
> @@ -147,16 +152,24 @@ size_t null_zone_valid_read_len(struct nullb *nullb=
,=0A=
>  	struct nullb_device *dev =3D nullb->dev;=0A=
>  	struct blk_zone *zone =3D &dev->zones[null_zone_no(dev, sector)];=0A=
>  	unsigned int nr_sectors =3D len >> SECTOR_SHIFT;=0A=
> +	size_t ret =3D 0;=0A=
=0A=
Please call that valid_len or something more representative of the value.=
=0A=
=0A=
>  =0A=
> +	spin_lock_irq(&dev->zlock);=0A=
>  	/* Read must be below the write pointer position */=0A=
>  	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL ||=0A=
> -	    sector + nr_sectors <=3D zone->wp)=0A=
> -		return len;=0A=
> +	    sector + nr_sectors <=3D zone->wp) {=0A=
> +		ret =3D len;=0A=
> +		goto out_unlock;=0A=
> +	}=0A=
>  =0A=
>  	if (sector > zone->wp)=0A=
> -		return 0;=0A=
> +		goto out_unlock;=0A=
> +=0A=
> +	ret =3D (zone->wp - sector) << SECTOR_SHIFT;=0A=
>  =0A=
> -	return (zone->wp - sector) << SECTOR_SHIFT;=0A=
> +out_unlock:=0A=
> +	spin_unlock_irq(&dev->zlock);=0A=
> +	return ret;=0A=
>  }=0A=
>  =0A=
>  static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sect=
or,=0A=
> @@ -165,17 +178,19 @@ static blk_status_t null_zone_write(struct nullb_cm=
d *cmd, sector_t sector,=0A=
>  	struct nullb_device *dev =3D cmd->nq->dev;=0A=
>  	unsigned int zno =3D null_zone_no(dev, sector);=0A=
>  	struct blk_zone *zone =3D &dev->zones[zno];=0A=
> -	blk_status_t ret;=0A=
> +	blk_status_t ret =3D BLK_STS_OK;=0A=
>  =0A=
>  	trace_nullb_zone_op(cmd, zno, zone->cond);=0A=
>  =0A=
>  	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
>  		return null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);=0A=
>  =0A=
> +	spin_lock_irq(&dev->zlock);=0A=
>  	switch (zone->cond) {=0A=
>  	case BLK_ZONE_COND_FULL:=0A=
>  		/* Cannot write to a full zone */=0A=
> -		return BLK_STS_IOERR;=0A=
> +		ret =3D BLK_STS_IOERR;=0A=
> +		break;=0A=
>  	case BLK_ZONE_COND_EMPTY:=0A=
>  	case BLK_ZONE_COND_IMP_OPEN:=0A=
>  	case BLK_ZONE_COND_EXP_OPEN:=0A=
> @@ -193,27 +208,33 @@ static blk_status_t null_zone_write(struct nullb_cm=
d *cmd, sector_t sector,=0A=
>  			else=0A=
>  				cmd->rq->__sector =3D sector;=0A=
>  		} else if (sector !=3D zone->wp) {=0A=
> -			return BLK_STS_IOERR;=0A=
> +			ret =3D BLK_STS_IOERR;=0A=
> +			break;=0A=
>  		}=0A=
>  =0A=
> -		if (zone->wp + nr_sectors > zone->start + zone->capacity)=0A=
> -			return BLK_STS_IOERR;=0A=
> +		if (zone->wp + nr_sectors > zone->start + zone->capacity) {=0A=
> +			ret =3D BLK_STS_IOERR;=0A=
> +			break;=0A=
> +		}=0A=
>  =0A=
>  		if (zone->cond !=3D BLK_ZONE_COND_EXP_OPEN)=0A=
>  			zone->cond =3D BLK_ZONE_COND_IMP_OPEN;=0A=
>  =0A=
>  		ret =3D null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);=0A=
>  		if (ret !=3D BLK_STS_OK)=0A=
> -			return ret;=0A=
> +			break;=0A=
>  =0A=
>  		zone->wp +=3D nr_sectors;=0A=
>  		if (zone->wp =3D=3D zone->start + zone->capacity)=0A=
>  			zone->cond =3D BLK_ZONE_COND_FULL;=0A=
> -		return BLK_STS_OK;=0A=
> +		break;=0A=
>  	default:=0A=
>  		/* Invalid zone condition */=0A=
> -		return BLK_STS_IOERR;=0A=
> +		ret =3D BLK_STS_IOERR;=0A=
>  	}=0A=
> +=0A=
> +	spin_unlock_irq(&dev->zlock);=0A=
> +	return ret;=0A=
>  }=0A=
>  =0A=
>  static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf o=
p,=0A=
> @@ -223,7 +244,9 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *=
cmd, enum req_opf op,=0A=
>  	unsigned int zone_no =3D null_zone_no(dev, sector);=0A=
>  	struct blk_zone *zone =3D &dev->zones[zone_no];=0A=
>  	size_t i;=0A=
> +	blk_status_t ret =3D BLK_STS_OK;=0A=
>  =0A=
> +	spin_lock_irq(&dev->zlock);=0A=
>  	switch (op) {=0A=
>  	case REQ_OP_ZONE_RESET_ALL:=0A=
>  		for (i =3D 0; i < dev->nr_zones; i++) {=0A=
> @@ -234,25 +257,29 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd=
 *cmd, enum req_opf op,=0A=
>  		}=0A=
>  		break;=0A=
>  	case REQ_OP_ZONE_RESET:=0A=
> -		if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> -			return BLK_STS_IOERR;=0A=
> +		if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL) {=0A=
> +			ret =3D BLK_STS_IOERR;=0A=
> +			break;=0A=
> +		}=0A=
>  =0A=
>  		zone->cond =3D BLK_ZONE_COND_EMPTY;=0A=
>  		zone->wp =3D zone->start;=0A=
>  		break;=0A=
>  	case REQ_OP_ZONE_OPEN:=0A=
> -		if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> -			return BLK_STS_IOERR;=0A=
> -		if (zone->cond =3D=3D BLK_ZONE_COND_FULL)=0A=
> -			return BLK_STS_IOERR;=0A=
> +		if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL ||=0A=
> +				zone->cond =3D=3D BLK_ZONE_COND_FULL) {=0A=
> +			ret =3D BLK_STS_IOERR;=0A=
> +			break;=0A=
> +		}=0A=
>  =0A=
>  		zone->cond =3D BLK_ZONE_COND_EXP_OPEN;=0A=
>  		break;=0A=
>  	case REQ_OP_ZONE_CLOSE:=0A=
> -		if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> -			return BLK_STS_IOERR;=0A=
> -		if (zone->cond =3D=3D BLK_ZONE_COND_FULL)=0A=
> -			return BLK_STS_IOERR;=0A=
> +		if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL ||=0A=
> +				zone->cond =3D=3D BLK_ZONE_COND_FULL) {=0A=
> +			ret =3D BLK_STS_IOERR;=0A=
> +			break;=0A=
> +		}=0A=
>  =0A=
>  		if (zone->wp =3D=3D zone->start)=0A=
>  			zone->cond =3D BLK_ZONE_COND_EMPTY;=0A=
> @@ -260,18 +287,21 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd=
 *cmd, enum req_opf op,=0A=
>  			zone->cond =3D BLK_ZONE_COND_CLOSED;=0A=
>  		break;=0A=
>  	case REQ_OP_ZONE_FINISH:=0A=
> -		if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> -			return BLK_STS_IOERR;=0A=
> +		if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL) {=0A=
> +			ret =3D BLK_STS_IOERR;=0A=
> +			break;=0A=
> +		}=0A=
>  =0A=
>  		zone->cond =3D BLK_ZONE_COND_FULL;=0A=
>  		zone->wp =3D zone->start + zone->len;=0A=
>  		break;=0A=
>  	default:=0A=
> -		return BLK_STS_NOTSUPP;=0A=
> +		ret =3D BLK_STS_NOTSUPP;=0A=
>  	}=0A=
>  =0A=
> +	spin_unlock_irq(&dev->zlock);=0A=
>  	trace_nullb_zone_op(cmd, zone_no, zone->cond);=0A=
> -	return BLK_STS_OK;=0A=
> +	return ret;=0A=
>  }=0A=
=0A=
I think you can avoid all of these changes by taking the lock around the ca=
lls=0A=
to null_zone_mgmt() and null_zone_write() in null_process_zoned_cmd(). That=
 will=0A=
make the patch a lot smaller and simplify maintenance. And even, I think th=
at=0A=
taking the lock on entry to null_process_zoned_cmd() and unlocking on retur=
n=0A=
should even be simpler since that would cover reads too (valid read len). O=
nly=0A=
report zones would need special treatment.=0A=
=0A=
>  =0A=
>  blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_opf =
op,=0A=
> =0A=
=0A=
I think we also need this to have a Cc: stable and a "Fixes" tag too.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
