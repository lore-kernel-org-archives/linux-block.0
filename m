Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9180FC433E0
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 15:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D28A2074F
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 15:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cQcGYOV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389467AbgF3PhL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:37:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52622 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389320AbgF3PhK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 11:37:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UFRH79011561;
        Tue, 30 Jun 2020 15:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=WFrx2Ivk6GmRcmtEBd0GAKfNJC3MPi3NAx49ZLQn9kc=;
 b=cQcGYOV754m3QcdOVjp5z7XkyLgHdJ+bDGb/PP76Ves4+R4ZuU7Dki4PXpWdxckjefzH
 /CNhRfitGQHY5MajPx8cOjK0v2Vh9O6r4PJu3soSON5dDOLIlzEucvQpnxePfhfVWf1I
 pxjFO3BdS/hISDWTg9fApvxhG7VwcPB3RGqJgPqNAu42e8+kaoGCync843e03ujZhtWU
 B2zN8V+QGkD8DUoAqLhko0VpRxgqG0XTr3lbVl5wf1HFWZMhRHlcooADaAUZJkOYccT4
 VXcACvU+U3sjV/gng8NegQtvHVQR1azu2LoxnnWUqQDj3G4cWjd7/GOB7ntQbTEQGsEJ mQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31xx1dt50d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jun 2020 15:36:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UFNkw7051090;
        Tue, 30 Jun 2020 15:34:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31xg1wxurh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 15:34:50 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05UFYlab013120;
        Tue, 30 Jun 2020 15:34:48 GMT
Received: from dhcp-10-154-182-99.vpn.oracle.com (/10.154.182.99)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jun 2020 15:34:47 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCHv4 2/5] null_blk: introduce zone capacity for zoned device
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20200629190641.1986462-3-kbusch@kernel.org>
Date:   Tue, 30 Jun 2020 10:34:46 -0500
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Aravind Ramesh <aravind.ramesh@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        Daniel Wagner <dwagner@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B5094B73-43A2-491E-9DE9-931EFA3854B3@oracle.com>
References: <20200629190641.1986462-1-kbusch@kernel.org>
 <20200629190641.1986462-3-kbusch@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011 adultscore=0
 suspectscore=3 mlxlogscore=999 cotscore=-2147483648 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006300112
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Jun 29, 2020, at 2:06 PM, Keith Busch <kbusch@kernel.org> wrote:
>=20
> From: Aravind Ramesh <aravind.ramesh@wdc.com>
>=20
> Allow emulation of a zoned device with a per zone capacity smaller =
than
> the zone size as as defined in the Zoned Namespace (ZNS) Command Set
> specification. The zone capacity defaults to the zone size if not
> specified and must be smaller than the zone size otherwise.
>=20
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Reviewed-by: Matias Bj=C3=B8rling <matias.bjorling@wdc.com>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> ---
> drivers/block/null_blk.h       |  1 +
> drivers/block/null_blk_main.c  | 10 +++++++++-
> drivers/block/null_blk_zoned.c | 16 ++++++++++++++--
> 3 files changed, 24 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
> index 81b311c9d781..daed4a9c3436 100644
> --- a/drivers/block/null_blk.h
> +++ b/drivers/block/null_blk.h
> @@ -49,6 +49,7 @@ struct nullb_device {
> 	unsigned long completion_nsec; /* time in ns to complete a =
request */
> 	unsigned long cache_size; /* disk cache size in MB */
> 	unsigned long zone_size; /* zone size in MB if device is zoned =
*/
> +	unsigned long zone_capacity; /* zone capacity in MB if device is =
zoned */
> 	unsigned int zone_nr_conv; /* number of conventional zones */
> 	unsigned int submit_queues; /* number of submission queues */
> 	unsigned int home_node; /* home node for the device */
> diff --git a/drivers/block/null_blk_main.c =
b/drivers/block/null_blk_main.c
> index 82259242b9b5..96d1adf6b818 100644
> --- a/drivers/block/null_blk_main.c
> +++ b/drivers/block/null_blk_main.c
> @@ -200,6 +200,10 @@ static unsigned long g_zone_size =3D 256;
> module_param_named(zone_size, g_zone_size, ulong, S_IRUGO);
> MODULE_PARM_DESC(zone_size, "Zone size in MB when block device is =
zoned. Must be power-of-two: Default: 256");
>=20
> +static unsigned long g_zone_capacity;
> +module_param_named(zone_capacity, g_zone_capacity, ulong, 0444);
> +MODULE_PARM_DESC(zone_capacity, "Zone capacity in MB when block =
device is zoned. Can be less than or equal to zone size. Default: Zone =
size");
> +
> static unsigned int g_zone_nr_conv;
> module_param_named(zone_nr_conv, g_zone_nr_conv, uint, 0444);
> MODULE_PARM_DESC(zone_nr_conv, "Number of conventional zones when =
block device is zoned. Default: 0");
> @@ -341,6 +345,7 @@ NULLB_DEVICE_ATTR(mbps, uint, NULL);
> NULLB_DEVICE_ATTR(cache_size, ulong, NULL);
> NULLB_DEVICE_ATTR(zoned, bool, NULL);
> NULLB_DEVICE_ATTR(zone_size, ulong, NULL);
> +NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);
> NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);
>=20
> static ssize_t nullb_device_power_show(struct config_item *item, char =
*page)
> @@ -457,6 +462,7 @@ static struct configfs_attribute =
*nullb_device_attrs[] =3D {
> 	&nullb_device_attr_badblocks,
> 	&nullb_device_attr_zoned,
> 	&nullb_device_attr_zone_size,
> +	&nullb_device_attr_zone_capacity,
> 	&nullb_device_attr_zone_nr_conv,
> 	NULL,
> };
> @@ -510,7 +516,8 @@ nullb_group_drop_item(struct config_group *group, =
struct config_item *item)
>=20
> static ssize_t memb_group_features_show(struct config_item *item, char =
*page)
> {
> -	return snprintf(page, PAGE_SIZE, =
"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_nr_c=
onv\n");
> +	return snprintf(page, PAGE_SIZE,
> +			=
"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_capa=
city,zone_nr_conv\n");
> }
>=20
> CONFIGFS_ATTR_RO(memb_group_, features);
> @@ -571,6 +578,7 @@ static struct nullb_device *null_alloc_dev(void)
> 	dev->use_per_node_hctx =3D g_use_per_node_hctx;
> 	dev->zoned =3D g_zoned;
> 	dev->zone_size =3D g_zone_size;
> +	dev->zone_capacity =3D g_zone_capacity;
> 	dev->zone_nr_conv =3D g_zone_nr_conv;
> 	return dev;
> }
> diff --git a/drivers/block/null_blk_zoned.c =
b/drivers/block/null_blk_zoned.c
> index 624aac09b005..3d25c9ad2383 100644
> --- a/drivers/block/null_blk_zoned.c
> +++ b/drivers/block/null_blk_zoned.c
> @@ -28,6 +28,15 @@ int null_init_zoned_dev(struct nullb_device *dev, =
struct request_queue *q)
> 		return -EINVAL;
> 	}
>=20
> +	if (!dev->zone_capacity)
> +		dev->zone_capacity =3D dev->zone_size;
> +
> +	if (dev->zone_capacity > dev->zone_size) {
> +		pr_err("null_blk: zone capacity (%lu MB) larger than =
zone size (%lu MB)\n",
> +					dev->zone_capacity, =
dev->zone_size);
> +		return -EINVAL;
> +	}
> +
> 	dev->zone_size_sects =3D dev->zone_size << ZONE_SIZE_SHIFT;
> 	dev->nr_zones =3D dev_size >>
> 				(SECTOR_SHIFT + =
ilog2(dev->zone_size_sects));
> @@ -60,7 +69,7 @@ int null_init_zoned_dev(struct nullb_device *dev, =
struct request_queue *q)
>=20
> 		zone->start =3D zone->wp =3D sector;
> 		zone->len =3D dev->zone_size_sects;
> -		zone->capacity =3D zone->len;
> +		zone->capacity =3D dev->zone_capacity << =
ZONE_SIZE_SHIFT;
> 		zone->type =3D BLK_ZONE_TYPE_SEQWRITE_REQ;
> 		zone->cond =3D BLK_ZONE_COND_EMPTY;
>=20
> @@ -187,6 +196,9 @@ static blk_status_t null_zone_write(struct =
nullb_cmd *cmd, sector_t sector,
> 			return BLK_STS_IOERR;
> 		}
>=20
> +		if (zone->wp + nr_sectors > zone->start + =
zone->capacity)
> +			return BLK_STS_IOERR;
> +
> 		if (zone->cond !=3D BLK_ZONE_COND_EXP_OPEN)
> 			zone->cond =3D BLK_ZONE_COND_IMP_OPEN;
>=20
> @@ -195,7 +207,7 @@ static blk_status_t null_zone_write(struct =
nullb_cmd *cmd, sector_t sector,
> 			return ret;
>=20
> 		zone->wp +=3D nr_sectors;
> -		if (zone->wp =3D=3D zone->start + zone->len)
> +		if (zone->wp =3D=3D zone->start + zone->capacity)
> 			zone->cond =3D BLK_ZONE_COND_FULL;
> 		return BLK_STS_OK;
> 	default:
> =E2=80=94
> 2.24.1
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	Oracle Linux Engineering





