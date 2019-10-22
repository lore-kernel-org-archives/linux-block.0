Return-Path: <SRS0=K2Ob=YP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F515CA9EB9
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 07:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BA820B7C
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 07:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mZWoOpua";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yGAnafai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388006AbfJVH6L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Oct 2019 03:58:11 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7614 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387999AbfJVH6L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Oct 2019 03:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571731097; x=1603267097;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Ku19nJhm2LPLBE61o2bac5Topa4QK0nW5SUSlMZUrEw=;
  b=mZWoOpualvMKEboIXAo4XvyDPRhmmToQGU+2gwzVlvqtgC3OsE/G83Xg
   DgXTWeIDuszxQc+ymy0tdIXWj1L6Gtbr4Fvl98iGBIP0QAUZwxMv6K499
   wlewj5o7E3BeX24bLUOKldfSeb7ap0kiHm8EGmqT2g2RzUVwJSIvEHWGk
   6IzjNvCiFDrAhCfRLKlS2BexpgmqknhkaRC4+/HvtjPd1rMPw5Gr56JjY
   N3jiScP26NTZw0pJikv8M84nkY2DMwNGWJdn1XXewmeRNJq3bj77fS65z
   nZ2czOPevhtw61I4LOA6Iggur53Ow4JtKtT+NfjhVZ56wielcSC7rVWdZ
   A==;
IronPort-SDR: /dpEhOvqvFqls1ms/nvU/M4xMURGa3AoMvQjlJDuVZJ8j70c774/t6ucWWt3R1ozb2Q5KQebRr
 Sc9mPkGM2mfSQhMUmYLGTXFGszz+ZhR4POm+BdNABSYzRfnoYWbkYdaqy/ZbXCtNWrQelPnX/d
 +AK3+QFLMO6jfzwmn8tjOtqYd7IXtjZoCPXVe/4a38zXcgBL2Ygfz8QuphpKVNTrTglKPqp1NV
 Zct9EOL/Fnvw35M3BCxL59UBOY9Oy6Jg1IipoC16xJGAGri1nm37u/LuXVLwBBHVow8uPFA1N1
 WcY=
X-IronPort-AV: E=Sophos;i="5.67,326,1566835200"; 
   d="scan'208";a="222146776"
Received: from mail-dm3nam03lp2052.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.52])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2019 15:58:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhc8oGIFuDBn3Bp38mhjekd3rpI8H+uXvJsEbsGoygYgfg7+oWHK5ZSgVHew0lEKGFIbZHgI0rnSNhj4Pv44fEAtTAsMGxpfFHXLGRP0aSXYYZ1Iq48eOBxY30wHnGVMCCLs7kc3rkbsGPX2mAB8CbL5+ngCoHYLwjk+aWGFum3unyGLTYBTKUXEuylfDGoe/b5hxnmiO1IQeRakYF9z0fQ98hRPPkC7QnVmkfjKbBUEuIvnJt0n2yMCIwO1cPow19uGNBzm4ZUQzK6IDckoNwmfjfU/HXyEszT9wDNAqaO12oYr+IoZd8aucEmBLCR7dT7jQYOowj2am/zl8yNu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPhQY2/hBZwwBeZR1WTi+Mjn2fB7wpKkh/UmdWx4/VY=;
 b=fFZihFQCypoRVtw2wNZgja7xxB2FhxAMyroSbnWy1Kp21o9ksaFogvp4YDndJLi0cgirw2Ky/JCSVS9FtCNqSpwR3hV1fv5+MTEV92vqTc++s56Q/OMEMgOzVxeNWSfAyvoL/URAViHYdN/bseE+LFMWXJFZbD4VtVnHockxm3jFICuCoWRiUnA+HnopvM5J6FVNBBUvc5UnUfFBF3oebZPK3jMRljSoXnazd0K1sksQIN1l5ruIHg4aaTQnAY17K1TRLUIhULfCVs//LXetYzmN+xZnHpn70g/iM37wpRfRo5jIx7yRSpF0kbSdDgRl0meoP0iYl1zPu+RBkTHBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPhQY2/hBZwwBeZR1WTi+Mjn2fB7wpKkh/UmdWx4/VY=;
 b=yGAnafaixCLSe+PsftsYvQm5YeH8Zp63smXCgzZ7CzVzdV0BMUd42ig9EkmU303qzRCchruqPlzVer3aNs0FvywWLg4nCWIMBDy82ZVT+YgdQnU7azs6E5KQEuNkat54w9cL68TtSNf2iFW/jz3tUr+VNjp+FQzV/YkZ8ToRWBQ=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4149.namprd04.prod.outlook.com (20.176.250.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 07:58:08 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::f07b:aaec:410d:bcf3]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::f07b:aaec:410d:bcf3%4]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 07:58:08 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] bdev: Factor out bdev revalidation into a common
 helper
Thread-Topic: [PATCH 1/2] bdev: Factor out bdev revalidation into a common
 helper
Thread-Index: AQHVh+riG4Lptu8Z2UerJEi1BxoETg==
Date:   Tue, 22 Oct 2019 07:58:08 +0000
Message-ID: <BYAPR04MB5816C126635CB91E06A6FF48E7680@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191021083132.5351-1-jack@suse.cz>
 <20191021083808.19335-1-jack@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b990e977-5fe9-4ffc-881c-08d756c593a8
x-ms-traffictypediagnostic: BYAPR04MB4149:
x-microsoft-antispam-prvs: <BYAPR04MB41498AE4B49622E910551284E7680@BYAPR04MB4149.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(189003)(199004)(305945005)(7736002)(110136005)(4326008)(229853002)(6436002)(6246003)(316002)(102836004)(7696005)(478600001)(76176011)(6506007)(53546011)(74316002)(66066001)(26005)(14454004)(186003)(71190400001)(8676002)(52536014)(3846002)(256004)(14444005)(446003)(71200400001)(8936002)(81166006)(86362001)(486006)(81156014)(25786009)(476003)(76116006)(5660300002)(99286004)(55016002)(9686003)(66446008)(64756008)(66556008)(6116002)(66476007)(2906002)(33656002)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4149;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +p07xoUfr1TEjzojjEJczaU47ydsNpzUlKmVT/bKbLBPXiEvNy0+M2n+PxY5HBGAcoBGg9K/svhEFgqoAp+IINJIY49Qt7VIaQHXSU7jKN4NdGmb2Sy0B6oUW71+UaaegKe9WUC/KKWBCFgVMqsB2cDY5yE53jGrXwcBIzuWP+gQHv6nhCVXjTO03ZauF21HuM+VHlj5cH+7pjg4tQfxvhm9flyKSn/kq04sXeOAcIKrjeamWZM/5Q1MUmmZZR8OuVBG2Cs+ZP1B98pg0/g1R2cb77UaNnfl9rbu3TwRQxo7aufkWq9nuADNQGfDBNOviO7KRikq/hmO18hMyKNQmxDep3gEuHTnR4n2bomnWY4eRDLEGcIX8opOc4L3VZQb/eta1LG3MPbwqJeUFXf0D0WHKyz5OSBdAZdrDDmwjxSeS7VXrV6ntza0Ncf/RprY
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b990e977-5fe9-4ffc-881c-08d756c593a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 07:58:08.0996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l3ZkVMEouyeZtgvqTjZ+l7vmeMFUZ7EeyoGZrSRFhAKVnxVIeKjOCJhZvmtEZ2NjRByTaaKEZtRUrXCvF9EKUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4149
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/10/21 17:38, Jan Kara wrote:=0A=
> Factor out code handling revalidation of bdev on disk change into a=0A=
> common helper.=0A=
> =0A=
> Signed-off-by: Jan Kara <jack@suse.cz>=0A=
> ---=0A=
>  fs/block_dev.c | 26 ++++++++++++++------------=0A=
>  1 file changed, 14 insertions(+), 12 deletions(-)=0A=
> =0A=
> diff --git a/fs/block_dev.c b/fs/block_dev.c=0A=
> index 9c073dbdc1b0..88c6d35ec71d 100644=0A=
> --- a/fs/block_dev.c=0A=
> +++ b/fs/block_dev.c=0A=
> @@ -1512,6 +1512,14 @@ EXPORT_SYMBOL(bd_set_size);=0A=
>  =0A=
>  static void __blkdev_put(struct block_device *bdev, fmode_t mode, int fo=
r_part);=0A=
>  =0A=
> +static void bdev_disk_changed(struct block_device *bdev, bool invalidate=
)=0A=
> +{=0A=
> +	if (invalidate)=0A=
> +		invalidate_partitions(bdev->bd_disk, bdev);=0A=
> +	else=0A=
> +		rescan_partitions(bdev->bd_disk, bdev);=0A=
> +}=0A=
> +=0A=
>  /*=0A=
>   * bd_mutex locking:=0A=
>   *=0A=
> @@ -1594,12 +1602,9 @@ static int __blkdev_get(struct block_device *bdev,=
 fmode_t mode, int for_part)=0A=
>  			 * The latter is necessary to prevent ghost=0A=
>  			 * partitions on a removed medium.=0A=
>  			 */=0A=
> -			if (bdev->bd_invalidated) {=0A=
> -				if (!ret)=0A=
> -					rescan_partitions(disk, bdev);=0A=
> -				else if (ret =3D=3D -ENOMEDIUM)=0A=
> -					invalidate_partitions(disk, bdev);=0A=
> -			}=0A=
> +			if (bdev->bd_invalidated &&=0A=
> +			    (!ret || ret =3D=3D -ENOMEDIUM))=0A=
> +				bdev_disk_changed(bdev, ret =3D=3D -ENOMEDIUM);=0A=
=0A=
This is a little confusing since from its name, bdev_disk_changed() seem=0A=
to imply that a new disk is present but this is called only if bdev is=0A=
invalidated... What about calling this simply bdev_revalidate_disk(),=0A=
since rescan_partitions() will call the disk revalidate method.=0A=
=0A=
Also, it seems to me that this function could be used without the=0A=
complex "if ()" condition by slightly modifying it:=0A=
=0A=
static void bdev_revalidate_disk(struct block_device *bdev,=0A=
			         bool invalidate)=0A=
{=0A=
	if (bdev->bd_invalidated && invalidate)=0A=
		invalidate_partitions(bdev->bd_disk, bdev);=0A=
	else=0A=
		rescan_partitions(bdev->bd_disk, bdev);=0A=
}=0A=
=0A=
Otherwise, this all looks fine to me.=0A=
=0A=
>  =0A=
>  			if (ret)=0A=
>  				goto out_clear;=0A=
> @@ -1632,12 +1637,9 @@ static int __blkdev_get(struct block_device *bdev,=
 fmode_t mode, int for_part)=0A=
>  			if (bdev->bd_disk->fops->open)=0A=
>  				ret =3D bdev->bd_disk->fops->open(bdev, mode);=0A=
>  			/* the same as first opener case, read comment there */=0A=
> -			if (bdev->bd_invalidated) {=0A=
> -				if (!ret)=0A=
> -					rescan_partitions(bdev->bd_disk, bdev);=0A=
> -				else if (ret =3D=3D -ENOMEDIUM)=0A=
> -					invalidate_partitions(bdev->bd_disk, bdev);=0A=
> -			}=0A=
> +			if (bdev->bd_invalidated &&=0A=
> +			    (!ret || ret =3D=3D -ENOMEDIUM))=0A=
> +				bdev_disk_changed(bdev, ret =3D=3D -ENOMEDIUM);=0A=
>  			if (ret)=0A=
>  				goto out_unlock_bdev;=0A=
>  		}=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
