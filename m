Return-Path: <SRS0=bR5W=TJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6923EC04AB1
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 16:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BD821783
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 16:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aRUvNRxe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G1CTAamN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfEIQPG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 May 2019 12:15:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30398 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfEIQPG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 May 2019 12:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557418507; x=1588954507;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Avai2N2HSV70DD22u4XXfC2qb00F0NkaQr+r7L19E7c=;
  b=aRUvNRxer4o8bADAq7NK5wuK6IPuJ5v45TmFGt9GSymrNM/6yaXCf0vK
   ceag1BaQOHN2grlcetMs84qtCkJp1D9zfxCfGe+7J7veLVbFi+r7gfUEi
   pexrv0R3QoDAb9jMnSEknISRGwh2vFKR2Z2H152jeJOD7iQmcuteeFNvA
   HRxgM3DrZ59T9Y0fmYpt/nUU1kgi0d70fMK9YqJb65e37e5516cY7vfGO
   WwZW9f/SSmOfOkY8mire3CjuLm1gG/QsPCL+ZXiaFCnjiWNyclvRG5pvp
   YE+RvtGLwN3SFT323jtuWF+5GLLyNZ7B5U2pIkd0zBxfR9hj9FpX22twJ
   g==;
X-IronPort-AV: E=Sophos;i="5.60,450,1549900800"; 
   d="scan'208";a="112849883"
Received: from mail-sn1nam01lp2051.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.51])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2019 00:15:06 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pwjejvgrhcehh0KN1cee17ynSWC0GYKGO3Z4QeHTUms=;
 b=G1CTAamNredwUC70uqA2uL2He9r5/2VbtFhLPjI5AlZqrvWj4XXqqqwDV4dVvfjaFumW/X8NmwTsxI5Cz3MSk2jvDkQVNIrbPj0RcxppXMD+6yqSQMl+u5VG3dDkVzF8cCRWahmqPm3B0cEqvrtrwdY0cHp7I5wo2VFvaml4NNk=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB3806.namprd04.prod.outlook.com (52.135.81.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Thu, 9 May 2019 16:15:02 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1856.012; Thu, 9 May 2019
 16:15:02 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Evan Green <evgreen@chromium.org>, Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] loop: Better discard support for block devices
Thread-Topic: [PATCH v5 2/2] loop: Better discard support for block devices
Thread-Index: AQHVBDnQte6MG5PpIUSpV+iVZADCQg==
Date:   Thu, 9 May 2019 16:15:02 +0000
Message-ID: <SN6PR04MB45272BA1AE5D477892A08AE486330@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190506182736.21064-1-evgreen@chromium.org>
 <20190506182736.21064-3-evgreen@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5af0fbd-2d72-4d5e-dfdc-08d6d4997df9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB3806;
x-ms-traffictypediagnostic: SN6PR04MB3806:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB3806BD7B7E2B1EC3881A495D86330@SN6PR04MB3806.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:138;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(81156014)(99286004)(8676002)(86362001)(81166006)(476003)(8936002)(486006)(6506007)(73956011)(66946007)(76116006)(6246003)(54906003)(91956017)(110136005)(66446008)(4326008)(66556008)(66476007)(71200400001)(71190400001)(64756008)(102836004)(53546011)(186003)(305945005)(74316002)(76176011)(446003)(66066001)(26005)(7696005)(229853002)(316002)(9686003)(55016002)(52536014)(3846002)(6116002)(14454004)(6436002)(25786009)(68736007)(33656002)(7736002)(53936002)(5660300002)(72206003)(478600001)(14444005)(256004)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3806;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MuIT2s0eyB27sr+2OCbhXzS8wjgW962Tw0KhCmNTW9idW+XsD9k66+1h6akVDIkikPS6u0j2WfUIvOjKPYdf3IdH3GQkb4cqp1Y9KCu2jTkcvrmrHMwROh2GFEjtgvsdlWvhVuZMDzKWERmhuZjDsOuo8+cXv/Q7iL4yyt66CVIhJIdjc2adgWUy0mhuicaSwel1fFB3KszCNmDcuxjW7mJvedB37UwbjKnL5TATxcy2vN7n0zVDgYx4E/kOr5PIqb/EgeNf77zuJMYHCcdO46a1XnDUd/+MLGFecqduI3R4659nTjfVocjz5wZDoD7sL3+ift/m9C0eJ6gelS5NltgQSZ8DmDqXe9tpcHcKVJyNKb6W3mwS6TZvGoDER+JmGRamzV69nbZc2/PQq1E0t4i3+acIk8KrmkClH3AERRs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5af0fbd-2d72-4d5e-dfdc-08d6d4997df9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 16:15:02.7095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3806
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 05/06/2019 11:30 AM, Evan Green wrote:=0A=
> If the backing device for a loop device is a block device,=0A=
> then mirror the "write zeroes" capabilities of the underlying=0A=
> block device into the loop device. Copy this capability into both=0A=
> max_write_zeroes_sectors and max_discard_sectors of the loop device.=0A=
>=0A=
> The reason for this is that REQ_OP_DISCARD on a loop device translates=0A=
> into blkdev_issue_zeroout(), rather than blkdev_issue_discard(). This=0A=
> presents a consistent interface for loop devices (that discarded data=0A=
> is zeroed), regardless of the backing device type of the loop device.=0A=
> There should be no behavior change for loop devices backed by regular=0A=
> files.=0A=
>=0A=
> While in there, differentiate between REQ_OP_DISCARD and=0A=
> REQ_OP_WRITE_ZEROES, which are different for block devices,=0A=
> but which the loop device had just been lumping together, since=0A=
> they're largely the same for files.=0A=
>=0A=
> This change fixes blktest block/003, and removes an extraneous=0A=
> error print in block/013 when testing on a loop device backed=0A=
> by a block device that does not support discard.=0A=
>=0A=
> Signed-off-by: Evan Green <evgreen@chromium.org>=0A=
> ---=0A=
>=0A=
> Changes in v5:=0A=
> - Don't mirror discard if lo_encrypt_key_size is non-zero (Gwendal)=0A=
>=0A=
> Changes in v4:=0A=
> - Mirror blkdev's write_zeroes into loopdev's discard_sectors.=0A=
>=0A=
> Changes in v3:=0A=
> - Updated commit description=0A=
>=0A=
> Changes in v2: None=0A=
>=0A=
>   drivers/block/loop.c | 57 ++++++++++++++++++++++++++++----------------=
=0A=
>   1 file changed, 37 insertions(+), 20 deletions(-)=0A=
>=0A=
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c=0A=
> index bbf21ebeccd3..a147210ed009 100644=0A=
> --- a/drivers/block/loop.c=0A=
> +++ b/drivers/block/loop.c=0A=
> @@ -417,19 +417,14 @@ static int lo_read_transfer(struct loop_device *lo,=
 struct request *rq,=0A=
>   	return ret;=0A=
>   }=0A=
>=0A=
> -static int lo_discard(struct loop_device *lo, struct request *rq, loff_t=
 pos)=0A=
> +static int lo_discard(struct loop_device *lo, struct request *rq,=0A=
> +		int mode, loff_t pos)=0A=
>   {=0A=
> -	/*=0A=
> -	 * We use punch hole to reclaim the free space used by the=0A=
> -	 * image a.k.a. discard. However we do not support discard if=0A=
> -	 * encryption is enabled, because it may give an attacker=0A=
> -	 * useful information.=0A=
> -	 */=0A=
>   	struct file *file =3D lo->lo_backing_file;=0A=
> -	int mode =3D FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;=0A=
> +	struct request_queue *q =3D lo->lo_queue;=0A=
>   	int ret;=0A=
>=0A=
> -	if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {=0A=
> +	if (!blk_queue_discard(q)) {=0A=
>   		ret =3D -EOPNOTSUPP;=0A=
>   		goto out;=0A=
>   	}=0A=
> @@ -599,8 +594,13 @@ static int do_req_filebacked(struct loop_device *lo,=
 struct request *rq)=0A=
>   	case REQ_OP_FLUSH:=0A=
>   		return lo_req_flush(lo, rq);=0A=
>   	case REQ_OP_DISCARD:=0A=
> +		return lo_discard(lo, rq,=0A=
> +			FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, pos);=0A=
> +=0A=
>   	case REQ_OP_WRITE_ZEROES:=0A=
> -		return lo_discard(lo, rq, pos);=0A=
> +		return lo_discard(lo, rq,=0A=
> +			FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE, pos);=0A=
> +=0A=
>   	case REQ_OP_WRITE:=0A=
>   		if (lo->transfer)=0A=
>   			return lo_write_transfer(lo, rq, pos);=0A=
> @@ -854,6 +854,21 @@ static void loop_config_discard(struct loop_device *=
lo)=0A=
>   	struct file *file =3D lo->lo_backing_file;=0A=
>   	struct inode *inode =3D file->f_mapping->host;=0A=
>   	struct request_queue *q =3D lo->lo_queue;=0A=
> +	struct request_queue *backingq;=0A=
> +=0A=
> +	/*=0A=
> +	 * If the backing device is a block device, mirror its zeroing=0A=
> +	 * capability. REQ_OP_DISCARD translates to a zero-out even when backed=
=0A=
> +	 * by block devices to keep consistent behavior with file-backed loop=
=0A=
> +	 * devices.=0A=
> +	 */=0A=
> +	if (S_ISBLK(inode->i_mode) && !lo->lo_encrypt_key_size) {=0A=
> +		backingq =3D bdev_get_queue(inode->i_bdev);=0A=
> +		blk_queue_max_discard_sectors(q,=0A=
> +			backingq->limits.max_write_zeroes_sectors);=0A=
> +=0A=
> +		blk_queue_max_write_zeroes_sectors(q,=0A=
> +			backingq->limits.max_write_zeroes_sectors);=0A=
>=0A=
>   	/*=0A=
>   	 * We use punch hole to reclaim the free space used by the=0A=
> @@ -861,22 +876,24 @@ static void loop_config_discard(struct loop_device =
*lo)=0A=
>   	 * encryption is enabled, because it may give an attacker=0A=
>   	 * useful information.=0A=
>   	 */=0A=
> -	if ((!file->f_op->fallocate) ||=0A=
> -	    lo->lo_encrypt_key_size) {=0A=
> +	} else if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {=0A=
>   		q->limits.discard_granularity =3D 0;=0A=
>   		q->limits.discard_alignment =3D 0;=0A=
>   		blk_queue_max_discard_sectors(q, 0);=0A=
>   		blk_queue_max_write_zeroes_sectors(q, 0);=0A=
> -		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);=0A=
> -		return;=0A=
> -	}=0A=
>=0A=
> -	q->limits.discard_granularity =3D inode->i_sb->s_blocksize;=0A=
> -	q->limits.discard_alignment =3D 0;=0A=
> +	} else {=0A=
> +		q->limits.discard_granularity =3D inode->i_sb->s_blocksize;=0A=
> +		q->limits.discard_alignment =3D 0;=0A=
> +=0A=
> +		blk_queue_max_discard_sectors(q, UINT_MAX >> 9);=0A=
> +		blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);=0A=
> +	}=0A=
>=0A=
> -	blk_queue_max_discard_sectors(q, UINT_MAX >> 9);=0A=
> -	blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);=0A=
> -	blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);=0A=
> +	if (q->limits.max_write_zeroes_sectors)=0A=
> +		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);=0A=
> +	else=0A=
> +		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);=0A=
>   }=0A=
>=0A=
>   static void loop_unprepare_queue(struct loop_device *lo)=0A=
>=0A=
=0A=
