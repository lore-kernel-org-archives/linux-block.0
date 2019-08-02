Return-Path: <SRS0=5K92=V6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3A8C19759
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 01:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EA42064A
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 01:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gseIqKaP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MT+2395J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390613AbfHBBGg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 21:06:36 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:43284 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388659AbfHBBGg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 21:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564707996; x=1596243996;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=YXF6tX3q8htDVatn1nDYrf/GJmiyiTLq+kGpLmARRUQ=;
  b=gseIqKaPC3RJHi6f8w1ncUbPRoiQw9Rjl2p1HHs3dDOCItF5yhmDJOxX
   GWDQq6IwR9EJFw/XBhqNhHjsfWLXm7qZHEWcSGss18j394qwmHbQUNocK
   GGCqr/WfSySDGYEv/fXhvt9sqIZLvhQ6R0JG86R/VZmg3VM2kz5+UJV7b
   LjRVjAxrQ9FlVoCaZRI675IGlqFJ1rXPxizLVqXZPBjli9BTrEJ3hNcpj
   1REoZ1Ux0bpBm8sIWdDQ5eKHiUBepWLln8mH9PvpALvArk3Bxz9AKNlEA
   jD44+8RobeFv2nEIoqqaqR7vQ2QP6BFylzEeZX8DRaZVNxQZLaeRffrwK
   g==;
IronPort-SDR: h1K6YZEuiZaUiBcgykwBTtsAnOkLy5iHSsh0C6o1/JlHC67QcuiPFPjBjXdzogTLC10Dtol/al
 zKtGJ8pxw8otyXL33eKC3+kMPOKYH+sgC00pes6Fd+EhQnAtCKPclB+9HosDx0fSLoC8jaareV
 oyMgM7c7N0xcIn9B2RraiCSTDzIkjbVLrk4WYVDt23mcqzisdxndudq/lQsyyeVjYwM/WmBYt6
 GgiUyz6nD1BNR6ZjFX+6uhkuwSySpJibmOgi+lsXRnvokxbGOz08g3SjUcDz7DIGsQ7+CsflXL
 4EI=
X-IronPort-AV: E=Sophos;i="5.64,336,1559491200"; 
   d="scan'208";a="115755019"
Received: from mail-dm3nam05lp2051.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.51])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2019 09:06:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDpUB+/qKyYrYO6V9ZMnaj5kp9FmhA6s+rQ0ggY3i63p2GUQ0PFJv7177J1gPYMqa9Sd+jNJ409LIuyFduusvtuDmxDYWn22FGKUoftRqN7tnm1YB0iT5hTVaeqWccWUE1YkdSCpB+ktLKGWlzCL5ZNdaikg2qt97qcToyOu5IrP0tVGdIsG3CvXWhaRs2SF1eEmNN7OOEnnAtDeNlIFWnTq9pYgB8HhoxN+2fCJCR9d9HCy3JevJrk22xAzDfcqdCoGFTgqzMaJz23hmf4/jteqJXhr+blGfwYUXikPPpOp9v2K244WOQh8daX6q5qlsDdf3EYSn+xGtsX/dJWw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8XV8awXFPciHcXOCLIfpnYgfkvd7tfRJ/NEKpKob94=;
 b=Re8MAcwLx9N+/wc0H/DRksShz1+bS19TGnW+6C5l/A1WaFcL+MSnd3hkGXY4ZSufxOrcdg3B1T4o+aYz05z+AGFLpmCavjy8GPSpd7RDdFIrHPp3qDDPTCXlM7MIda+ciXSMmxQfxFOd+Z6uAQLQL9VV/EWTAVQZh4K19WQCOR3TKqC8HEJBZxoReTucLpPRorcY35FqSTs/2t12LtoEnAQTZl2E6eg4DfDL8ZNv54AjmOwY9mGYZQiwyEPBAJiacDjySbuRckLjJaousuaVDPgGnZfd3VStaXvsODfIMTwP7pCtTL5NXfgPUEo4vXdRpOhrq3KTNVD93lrjO08dAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8XV8awXFPciHcXOCLIfpnYgfkvd7tfRJ/NEKpKob94=;
 b=MT+2395JDfWlkvtPWjmpt9U2tUrg2/zz4BruDjk06omK3WQsUkwnnB/4Rdql/N/8Xyji7BclOXfutG4AKC6jv5QXArptovLnWK4c6iamAj6sMzFnOKLDIbzRuU2UU+LmDMdvDBuSjFwoVYa9Ay8SGFcdU4F9QdIkTftEoGgSx8w=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4103.namprd04.prod.outlook.com (52.135.216.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Fri, 2 Aug 2019 01:06:31 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 01:06:31 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "dennis@kernel.org" <dennis@kernel.org>,
        "hare@suse.com" <hare@suse.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "dennisszhou@gmail.com" <dennisszhou@gmail.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "osandov@fb.com" <osandov@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH V2 2/4] blk-zoned: implement REQ_OP_ZONE_RESET_ALL
Thread-Topic: [PATCH V2 2/4] blk-zoned: implement REQ_OP_ZONE_RESET_ALL
Thread-Index: AQHVSI5jn3Gq8dei+E6d/oKnr3ufmw==
Date:   Fri, 2 Aug 2019 01:06:31 +0000
Message-ID: <BYAPR04MB58160D995EE254A19EE716EDE7D90@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190801172638.4060-1-chaitanya.kulkarni@wdc.com>
 <20190801172638.4060-3-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fbd621b-18ca-4eeb-7a19-08d716e5a7f3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4103;
x-ms-traffictypediagnostic: BYAPR04MB4103:
x-microsoft-antispam-prvs: <BYAPR04MB4103B13EC1D1C631F9AB4905E7D90@BYAPR04MB4103.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(199004)(189003)(33656002)(476003)(305945005)(74316002)(446003)(2501003)(4326008)(66066001)(316002)(478600001)(186003)(68736007)(14454004)(486006)(3846002)(7696005)(7736002)(110136005)(76176011)(53936002)(71190400001)(53546011)(2906002)(81156014)(8676002)(5660300002)(8936002)(26005)(66946007)(2201001)(66476007)(6246003)(86362001)(55016002)(6506007)(229853002)(102836004)(66556008)(25786009)(64756008)(6436002)(14444005)(81166006)(71200400001)(54906003)(91956017)(76116006)(7416002)(52536014)(6116002)(256004)(66446008)(9686003)(99286004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4103;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V/Wl0oXGTuEDxvjqOS0tRyqyOUBCJHk6w9hxk8oT1rGsmsRTj2+8QV9AHEsaRw5KuYnlvIXcGYH7+K0UjReB6W9QvydMch2hvr3TIjhY/yHSVaWb8R59groqWe1+ua1iRE+uzQ3M5pQarKWxO/eMpp5RBn/aeCNVRIK+19I4N8W1pLRCvTi4FoZ+Nafca2MCYy6qxyjKOBlZky85SQbYsagwPVHO5Q1g+yE0YRV7nX4S5zFQNWon7bCL8kZWonoVMr3wL34ri/gnkcdgcenSZ7RYVlDqDh3gsWoqVstoJ5y35IrgWey/I0yvNAFQY+0/M85dkI1wG/nPNwdFFsWoTUxdeyx/kSkJkBZfYF7q2B7UvYb8K9qiCLDBi25MxYyrMKhKNan3LU9di/J6OfFT5CfRzbciqASRLA9SKmxYuog=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbd621b-18ca-4eeb-7a19-08d716e5a7f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 01:06:31.5758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4103
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/08/02 2:27, Chaitanya Kulkarni wrote:=0A=
> This implements REQ_OP_ZONE_RESET_ALL as a special case of the block=0A=
> device zone reset operations where we just simply issue bio with the=0A=
> newly introduced req op.=0A=
> =0A=
> We issue this req op when the number of sectors is equal to the device's=
=0A=
> partition's number of sectors and device has no partitions.=0A=
> =0A=
> We also add support so that blk_op_str() can print the new reset-all=0A=
> zone operation.=0A=
> =0A=
> This patch also adds a generic make request check for newly=0A=
> introduced REQ_OP_ZONE_RESET_ALL req_opf. We simply return error=0A=
> when queue is zoned and reset-all flag is not set for=0A=
> REQ_OP_ZONE_RESET_ALL.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  block/blk-core.c  |  5 +++++=0A=
>  block/blk-zoned.c | 39 +++++++++++++++++++++++++++++++++++++++=0A=
>  2 files changed, 44 insertions(+)=0A=
> =0A=
> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
> index d0cc6e14d2f0..1b53ab56228b 100644=0A=
> --- a/block/blk-core.c=0A=
> +++ b/block/blk-core.c=0A=
> @@ -129,6 +129,7 @@ static const char *const blk_op_name[] =3D {=0A=
>  	REQ_OP_NAME(DISCARD),=0A=
>  	REQ_OP_NAME(SECURE_ERASE),=0A=
>  	REQ_OP_NAME(ZONE_RESET),=0A=
> +	REQ_OP_NAME(ZONE_RESET_ALL),=0A=
>  	REQ_OP_NAME(WRITE_SAME),=0A=
>  	REQ_OP_NAME(WRITE_ZEROES),=0A=
>  	REQ_OP_NAME(SCSI_IN),=0A=
> @@ -931,6 +932,10 @@ generic_make_request_checks(struct bio *bio)=0A=
>  		if (!blk_queue_is_zoned(q))=0A=
>  			goto not_supported;=0A=
>  		break;=0A=
> +	case REQ_OP_ZONE_RESET_ALL:=0A=
> +		if (!blk_queue_is_zoned(q) || !blk_queue_zone_resetall(q))=0A=
> +			goto not_supported;=0A=
> +		break;=0A=
>  	case REQ_OP_WRITE_ZEROES:=0A=
>  		if (!q->limits.max_write_zeroes_sectors)=0A=
>  			goto not_supported;=0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index 6c503824ba3f..4bc5f260248a 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -202,6 +202,42 @@ int blkdev_report_zones(struct block_device *bdev, s=
ector_t sector,=0A=
>  }=0A=
>  EXPORT_SYMBOL_GPL(blkdev_report_zones);=0A=
>  =0A=
> +/*=0A=
> + * Special case of zone reset operation to reset all zones in one comman=
d,=0A=
> + * useful for applications like mkfs.=0A=
> + */=0A=
> +static int __blkdev_reset_all_zones(struct block_device *bdev, gfp_t gfp=
_mask)=0A=
> +{=0A=
> +	struct bio *bio =3D bio_alloc(gfp_mask, 0);=0A=
> +	int ret;=0A=
> +=0A=
> +	/* across the zones operations, don't need any sectors */=0A=
> +	bio_set_dev(bio, bdev);=0A=
> +	bio_set_op_attrs(bio, REQ_OP_ZONE_RESET_ALL, 0);=0A=
> +=0A=
> +	ret =3D submit_bio_wait(bio);=0A=
> +	bio_put(bio);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +static inline bool blkdev_allow_reset_all_zones(struct block_device *bde=
v,=0A=
> +						sector_t nr_sectors)=0A=
> +{=0A=
> +	if (!blk_queue_zone_resetall(bdev_get_queue(bdev)))=0A=
> +		return false;=0A=
> +=0A=
> +	if (nr_sectors !=3D part_nr_sects_read(bdev->bd_part))=0A=
> +		return false;=0A=
> +	/*=0A=
> +	 * REQ_OP_ZONE_RESET_ALL can be executed only if the block device is=0A=
> +	 * the entire disk, that is, if the blocks device start offset is 0 and=
=0A=
> +	 * its capacity is the same as the entire disk.=0A=
> +	 */=0A=
> +	return get_start_sect(bdev) =3D=3D 0 &&=0A=
> +	       part_nr_sects_read(bdev->bd_part) =3D=3D get_capacity(bdev->bd_d=
isk);=0A=
> +}=0A=
> +=0A=
>  /**=0A=
>   * blkdev_reset_zones - Reset zones write pointer=0A=
>   * @bdev:	Target block device=0A=
> @@ -235,6 +271,9 @@ int blkdev_reset_zones(struct block_device *bdev,=0A=
>  		/* Out of range */=0A=
>  		return -EINVAL;=0A=
>  =0A=
> +	if (blkdev_allow_reset_all_zones(bdev, nr_sectors))=0A=
> +		return  __blkdev_reset_all_zones(bdev, gfp_mask);=0A=
> +=0A=
>  	/* Check alignment (handle eventual smaller last zone) */=0A=
>  	zone_sectors =3D blk_queue_zone_sectors(q);=0A=
>  	if (sector & (zone_sectors - 1))=0A=
> =0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
