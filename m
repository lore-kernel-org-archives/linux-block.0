Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6CBC32751
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 00:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6045206A2
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 00:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gdlvEpc7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="K3gf6vTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfHAAz1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 20:55:27 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26094 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfHAAz1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 20:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564620925; x=1596156925;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WtH1co7fmneIl5/4Uwb1R2GP3zsi6X3uUcdekwPfDHE=;
  b=gdlvEpc7N3+ApLwcdpcXcLiHz0aXfu9dJSK4d2zknIX8YS4oCLe9Be05
   VslG1kYo/sq3gtB/j6Jly4OezvuSMM2fROmoOZEKz2mA83hK6IIthf/FS
   1xCk+nFhhbHTZTZRavdpU+tdrqh39YGehqcNW34vQWlDhyc9qULyRmQr3
   3X9WWOKwLBwvcIjIl9YC8ld8wPHecwTG5koY9TaUEaMLfyvU95OUiKBMn
   XoVYP0DAZZLAkh7awQ1vedp8RXDRBXeugt+VzDVfJyVRYzkoice9INXeY
   uHgJKtN44Dvu6zpqQkKSJjJjPovVohpeO/M0rGNuhIt+EaF9K/VIvLSCa
   w==;
IronPort-SDR: qkjElzHLDIN0AwJYPX/cNLM6Z86Z4NZHwQIjBHMqqQji3FzTOj0awwRBRmiyznlSBzjbaNLelA
 eHe0dq6NMO3yL7KK9kFGkk65PrgwJksXyKJXosECZW52OaZRYvjPvJCENdRAMoflASUQqL9scz
 EYi5nq0pJyaMufVjeaCbu+N2HpUG58IkU1pb18unxAuo24NEPPsXLDC+ni1DzZIstjTjn1QCSd
 qvBEQU9zoPN6WijkA4eQSYhyOaPS1hgkhq9pQFbmkNxtFNm4y5Diqw72F3WP1crnSmccjknLBg
 Fio=
X-IronPort-AV: E=Sophos;i="5.64,332,1559491200"; 
   d="scan'208";a="114650154"
Received: from mail-by2nam05lp2053.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.53])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2019 08:55:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPg2vt5BOnHLSACaBg7/bTGC4+W2lI2Nk+OiVMU4DSPvMztWFxUOlhabxaUEXo8ujD3SJyaNCMs6oz8cvSrNhqADRg1rt4g/78pv8MbHPoGE2jORxxUUxNlAo50v+nMk+IjyDBOw4+0NVACVPKbKbSFG2plUSb6uWQacBQNog3f8N1lHcJE8qpzeWjujm9v9OQLAWl4e5W9WzIqZcylGtMC1ltkwTcPx7+QFc3eSMijw3/cfXS6ZuNCcP/cYThIovupq+mJR+0riqE4CflPdbMajNuD6adu9mjKfvk9MKNauSrre1wHUyj3Q2CwUqSzaAi21aNmEuHuoFmDE/VoVsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhQcE3noTNbdDQDCEM0l2nN2ilW3sPNX7TY4U4NzJ+0=;
 b=I56VPHJVCs0dyQo8DYhdMX48BShKONYh+5RI5Oq7JdMTRVHbf3w9QgPgpuTA5sTq3tc0wyf5AcUxPnAZNIVkHJQVCvYnDxarOhyt79edfWAGzRVoDBblNegtoT1F6oLzMLAKUlVK6DJy2TUOO31YRbV+xsdDIWxLem7kEUWAK+hseCNfc8b4k5u+OKU4kTX38diX/yMojw22vwVdAbW9oXm99wLBucOw5+b8YqsxLisxncpAcpa5lO9XHZ+FBkrU2n/c3L10y/wgFbFlVFhjNJKTpApzv4O4ZU4bpi6DgVzfcFXglOUqJXBPOuc0Di6DA/I6z94BOEVDI+0QNVi2Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhQcE3noTNbdDQDCEM0l2nN2ilW3sPNX7TY4U4NzJ+0=;
 b=K3gf6vTazj2s/Wpo4MN0X/WDjOBQDC3eNxLux/tJifN7oCiwCu4jRcQF74GBI0l8VRl95/J1mAtp3Z9jFgTBGwFOs7aFxXSzoTWfLCkPPDleubgrK+mVC8JgnTALVfAFRdSiFyUqkrcaKuU0G9KERXab6MBDNCrc23XXwx3Rzp0=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4888.namprd04.prod.outlook.com (52.135.232.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Thu, 1 Aug 2019 00:55:23 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 00:55:23 +0000
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
Subject: Re: [PATCH 2/4] blk-zoned: implement REQ_OP_ZONE_RESET_ALL
Thread-Topic: [PATCH 2/4] blk-zoned: implement REQ_OP_ZONE_RESET_ALL
Thread-Index: AQHVR+MrYDKP+5rFjk+KMFOZIoF+xw==
Date:   Thu, 1 Aug 2019 00:55:23 +0000
Message-ID: <BYAPR04MB581622D19EDA3071AE618634E7DE0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190731210102.3472-1-chaitanya.kulkarni@wdc.com>
 <20190731210102.3472-3-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6388355b-3058-4b37-2810-08d7161aef3a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4888;
x-ms-traffictypediagnostic: BYAPR04MB4888:
x-microsoft-antispam-prvs: <BYAPR04MB488839DA48DEC47E3F34D028E7DE0@BYAPR04MB4888.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(199004)(189003)(14444005)(68736007)(186003)(478600001)(256004)(2201001)(7736002)(66066001)(76116006)(110136005)(66446008)(33656002)(446003)(55016002)(8676002)(2501003)(53936002)(53546011)(305945005)(71200400001)(71190400001)(91956017)(102836004)(9686003)(476003)(64756008)(6506007)(66556008)(66476007)(66946007)(54906003)(486006)(5660300002)(7416002)(3846002)(76176011)(8936002)(86362001)(4326008)(81156014)(81166006)(6116002)(25786009)(229853002)(52536014)(26005)(6436002)(14454004)(7696005)(99286004)(74316002)(6246003)(316002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4888;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wd40bDL+DVfvt7BiHrv3zq25+uI4dAfwpCX2VduxJ0XS3p0Iw+UQTuKG0jhw5dccIF4GYXQB0EYucsZ84Wn33DG2PSDNVLIddhIXel4wT4X4YR0KHHr1Z27y2E4jms6NxUUc65jV2moo41mCIiLG39obux2OyavmIK5C9lUpz4YJmRkkLQ9OabyEza/O/FCBgNSnNludHy4RMug3pfIALqL3hPdSBIQ7lEz0QgbAU2A0zUPU3/8P4LMPHGiAkqYZ+wEzcnHz31r3pdyoIYADk/hFPgIqqVcTr8SF5bNhm5nLe/L+s2FVHX3l40qxjAIdiuXhVP5cMOm2ruusB1F9tMR+4BaMw32ZI52z8LvvDXJMkcj8MizbBbhsrWF6T8rNLHeOh333VUZic6e0Y868VYPcc3GKC4UulH/jZLbCEiE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6388355b-3058-4b37-2810-08d7161aef3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 00:55:23.4131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4888
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/08/01 6:01, Chaitanya Kulkarni wrote:=0A=
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
>  block/blk-zoned.c | 40 ++++++++++++++++++++++++++++++++++++++++=0A=
>  2 files changed, 45 insertions(+)=0A=
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
> index 6c503824ba3f..d1ed728b7464 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -202,6 +202,43 @@ int blkdev_report_zones(struct block_device *bdev, s=
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
> +	struct bio *bio =3D NULL;=0A=
=0A=
There is no need to initialize the bio to NULL here.=0A=
=0A=
> +	int ret;=0A=
> +=0A=
> +	/* across the zones operations, don't need any sectors */=0A=
> +	bio =3D bio_alloc(gfp_mask, 0);=0A=
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
> @@ -235,6 +272,9 @@ int blkdev_reset_zones(struct block_device *bdev,=0A=
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
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
