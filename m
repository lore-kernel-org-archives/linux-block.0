Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F904C433E0
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 15:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A39B2074F
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 15:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wypfa8AL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733028AbgF3Pe7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:34:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49738 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731298AbgF3Pe6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 11:34:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UFRIbx109591;
        Tue, 30 Jun 2020 15:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=vd6uNjLFbYhcZn1EIjYn4Jt+bsag5IRWJKCrY9Q25BY=;
 b=Wypfa8ALEiyFM/UodorZWPL6wt2hD9ysfy2PPhHYbp6nfvRCj5qc5BPUD3Fwa4jAEjDF
 NgyMYX7Hh+8CYk63tJ8RmdbgreXYDzedNH+7lHtoSUAYnxV7obYR5GkJL5S5JtxYSdNg
 2nc83Okqs/+ormmAPEAZCe0MJExvB+FP2RnWiOjWt74ENZq8wbUhhkhJcTAny49d+QeJ
 GcvYzfCzjI7c7AdXu/hNKznXfkBp9O5pqRXLW7VBWW5EltzJEU5/dFAgbA0yVAhBQK4A
 p+OGdQqBCqiGp/LpTkfpoVD6KovqODa+JALW6j+PsMpjrjmHPP64I9hHUOtRhYLA18IG XA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31ywrbkgyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jun 2020 15:34:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UFMfZY098421;
        Tue, 30 Jun 2020 15:34:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31xg13pw3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 15:34:25 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05UFYLG6009162;
        Tue, 30 Jun 2020 15:34:21 GMT
Received: from dhcp-10-154-182-99.vpn.oracle.com (/10.154.182.99)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jun 2020 15:34:20 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCHv4 1/5] block: add capacity field to zone descriptors
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20200629190641.1986462-2-kbusch@kernel.org>
Date:   Tue, 30 Jun 2020 10:34:18 -0500
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Daniel Wagner <dwagner@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3598CF55-095F-477C-BEE2-93F11FAF44BD@oracle.com>
References: <20200629190641.1986462-1-kbusch@kernel.org>
 <20200629190641.1986462-2-kbusch@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=3 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006300112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 clxscore=1011 cotscore=-2147483648 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=3 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006300112
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Jun 29, 2020, at 2:06 PM, Keith Busch <kbusch@kernel.org> wrote:
>=20
> From: Matias Bj=C3=B8rling <matias.bjorling@wdc.com>
>=20
> In the zoned storage model, the sectors within a zone are typically =
all
> writeable. With the introduction of the Zoned Namespace (ZNS) Command
> Set in the NVM Express organization, the model was extended to have a
> specific writeable capacity.
>=20
> Extend the zone descriptor data structure with a zone capacity field =
to
> indicate to the user how many sectors in a zone are writeable.
>=20
> Introduce backward compatibility in the zone report ioctl by extending
> the zone report header data structure with a flags field to indicate =
if
> the capacity field is available.
>=20
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Reviewed-by: Javier Gonz=C3=A1lez <javier.gonz@samsung.com>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Matias Bj=C3=B8rling <matias.bjorling@wdc.com>
> ---
> block/blk-zoned.c              |  1 +
> drivers/block/null_blk_zoned.c |  2 ++
> drivers/scsi/sd_zbc.c          |  1 +
> include/uapi/linux/blkzoned.h  | 15 +++++++++++++--
> 4 files changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 23831fa8701d..81152a260354 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -312,6 +312,7 @@ int blkdev_report_zones_ioctl(struct block_device =
*bdev, fmode_t mode,
> 		return ret;
>=20
> 	rep.nr_zones =3D ret;
> +	rep.flags =3D BLK_ZONE_REP_CAPACITY;
> 	if (copy_to_user(argp, &rep, sizeof(struct blk_zone_report)))
> 		return -EFAULT;
> 	return 0;
> diff --git a/drivers/block/null_blk_zoned.c =
b/drivers/block/null_blk_zoned.c
> index cc47606d8ffe..624aac09b005 100644
> --- a/drivers/block/null_blk_zoned.c
> +++ b/drivers/block/null_blk_zoned.c
> @@ -47,6 +47,7 @@ int null_init_zoned_dev(struct nullb_device *dev, =
struct request_queue *q)
>=20
> 		zone->start =3D sector;
> 		zone->len =3D dev->zone_size_sects;
> +		zone->capacity =3D zone->len;
> 		zone->wp =3D zone->start + zone->len;
> 		zone->type =3D BLK_ZONE_TYPE_CONVENTIONAL;
> 		zone->cond =3D BLK_ZONE_COND_NOT_WP;
> @@ -59,6 +60,7 @@ int null_init_zoned_dev(struct nullb_device *dev, =
struct request_queue *q)
>=20
> 		zone->start =3D zone->wp =3D sector;
> 		zone->len =3D dev->zone_size_sects;
> +		zone->capacity =3D zone->len;
> 		zone->type =3D BLK_ZONE_TYPE_SEQWRITE_REQ;
> 		zone->cond =3D BLK_ZONE_COND_EMPTY;
>=20
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
> index 6f7eba66687e..183a20720da9 100644
> --- a/drivers/scsi/sd_zbc.c
> +++ b/drivers/scsi/sd_zbc.c
> @@ -59,6 +59,7 @@ static int sd_zbc_parse_report(struct scsi_disk =
*sdkp, u8 *buf,
> 		zone.non_seq =3D 1;
>=20
> 	zone.len =3D logical_to_sectors(sdp, =
get_unaligned_be64(&buf[8]));
> +	zone.capacity =3D zone.len;
> 	zone.start =3D logical_to_sectors(sdp, =
get_unaligned_be64(&buf[16]));
> 	zone.wp =3D logical_to_sectors(sdp, =
get_unaligned_be64(&buf[24]));
> 	if (zone.type !=3D ZBC_ZONE_TYPE_CONV &&
> diff --git a/include/uapi/linux/blkzoned.h =
b/include/uapi/linux/blkzoned.h
> index 0cdef67135f0..42c3366cc25f 100644
> --- a/include/uapi/linux/blkzoned.h
> +++ b/include/uapi/linux/blkzoned.h
> @@ -73,6 +73,15 @@ enum blk_zone_cond {
> 	BLK_ZONE_COND_OFFLINE	=3D 0xF,
> };
>=20
> +/**
> + * enum blk_zone_report_flags - Feature flags of reported zone =
descriptors.
> + *
> + * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.
> + */
> +enum blk_zone_report_flags {
> +	BLK_ZONE_REP_CAPACITY	=3D (1 << 0),
> +};
> +
> /**
>  * struct blk_zone - Zone descriptor for BLKREPORTZONE ioctl.
>  *
> @@ -99,7 +108,9 @@ struct blk_zone {
> 	__u8	cond;		/* Zone condition */
> 	__u8	non_seq;	/* Non-sequential write resources active =
*/
> 	__u8	reset;		/* Reset write pointer recommended */
> -	__u8	reserved[36];
> +	__u8	resv[4];
> +	__u64	capacity;	/* Zone capacity in number of sectors */
> +	__u8	reserved[24];
> };
>=20
> /**
> @@ -115,7 +126,7 @@ struct blk_zone {
> struct blk_zone_report {
> 	__u64		sector;
> 	__u32		nr_zones;
> -	__u8		reserved[4];
> +	__u32		flags;
> 	struct blk_zone zones[0];
> };
>=20
> --=20
> 2.24.1
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	Oracle Linux Engineering





