Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE05E4C8C
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 02:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320933; cv=fail; b=BxHYa210kCL62aFHhzQMPgSb4/a7I+fSzL53vQig3PooiJE21bVuGvQRoJmSb67M9F7OXY+GB74DCBpR+W88jIQCp856JKJD4q7EDuZnEzCc2Kuya1YKEYr88mi44EJXLK7PUXgSQsJyvPhUOHrKvZxs20sb2dDI2UeKUo1amnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320933; c=relaxed/simple;
	bh=gxL1pPp1zx75U21JbwrQMFKbN7yY9L3hWYolws6/20k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ocycu3r5hFn9NIJW+ydpKYCv/vxJoN4BweRl7pW7n13hsGLREN8+Na4nbpQH7iL8b/1TU/UMXm6dWKTS09tMpSEsltjHvzABxEmqFi5PJjVDBf6/zE+dRAkxOZmB9v+kUrZIYamQKDHhBaHPPKMR8NwGMvfih2jO1BDX5IcN6W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VQz13RhF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nEpEOB7B; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VQz13RhF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nEpEOB7B"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713320931; x=1744856931;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gxL1pPp1zx75U21JbwrQMFKbN7yY9L3hWYolws6/20k=;
  b=VQz13RhF1n6cA2Nr+R6vtJZRCW0g01iIa03JP1V0K1HKXLFAKPZ+SAqa
   mMEd3L7HJjnsfYrPvkNUW+oNKkt7KJ3SYDy+ddz6d5KW2Zt9r5H4/sv4T
   vHB3JKa5Ck12KmOJIhJMX+fzxDeaMx4fupPNEef4raZLpwmU7cUeT7tbi
   QDqRoZezzG1tLB5O1q/PzTIRttwumKfTrThwiu/mlVBFWHJDWMwM4rmIe
   QgE3DeSrLvHTgi4aPru2OEDdICxPiGGSoGpGEVa1KSeXkxZr5yN8SQ6X4
   BNnyl4VwxHWRwtfu8QOB60WY/uwf4IyRzEDAQgleRiHYRpy8Mn7ZI338i
   A==;
X-CSE-ConnectionGUID: 0z2B/W/bRlirqJAaYaOwFA==
X-CSE-MsgGUID: UGg5uzcSSx+2B+mSBLpo/Q==
X-IronPort-AV: E=Sophos;i="6.07,207,1708358400"; 
   d="scan'208";a="14174274"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 10:28:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4mO4+/o/WFCaLuVr4UuWR0S8IB7DH6IRrdzLDKmtRg4efQ4Koxw+Piz9VAXXhcqXDTrbnYYt7GuiU1NG8zf25cgiprk4EGiZPFpeUx9EHSUIkb1uP1KOHJk+ShSgyPhS8qADPuxo8u4l0Ov0xNm4+/41HwCtbyNv9rKLwzMh4xAfOOKjevLBZ8LZgVkaX8AX3kpm+N7E23TNMDPqwcNvsfTdLticIk6UrVeYQfrIKDRAWUGLClHxb4aa3NnwW0yRUrARcB07RoG+zd+eUzdsAevJHiirqywn939094v/r3XBYePbUxOIInH1m9mPokrwX9X9Ak8uG1y6aHwTdgo+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUMH+lptq7NnBs6SSyXGcv10IOFbkf4WmmVpHb9nNXE=;
 b=bxlMPPi/xo5UTVXElYxtPpvAC4dad0kQB6HyQQOQ4CIQlLsZSO/+onTLxC6i1+SJkIGCPAyO8DtaF4rH6tRsvLQOktsd+awPRYzKUlEhIhcFLYNFjjfFCZcrP6DCfu55RU4q42qNpAuRcgjMNcEVsqWQhAMNio8RC3b2bzW/sl74SrlR2uVZuvSghHOh1AQGQe97PjEyIglEVw5ui3pMqtvOI1PtR9aQCwVl2PZj/sJkLpdtOWb3i8SQPDBfTu054Q+RAmKrG5Zqn/hTgBW0tvJWUJzfJl3ERem7XH0vQ4Q23fItSM6FHO02irCSAou/PlQQpcuyIY6H9RU+iPQFyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUMH+lptq7NnBs6SSyXGcv10IOFbkf4WmmVpHb9nNXE=;
 b=nEpEOB7B1y7w70PJ7Dz1jD087VF5IXj0vqZFAEI9o2kM4pkV2r3f687QeN/4Olf7PITuftYGTEsgoimgfmnzOBizlkFuyKTBKsOMvISyywBbT5Y7abjRJMn2nHv8hQXkRp/bf4+9iGPgowHIxedwPeb0KCKKfU0+6YaHoxqxJ20=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB7831.namprd04.prod.outlook.com (2603:10b6:8:24::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Wed, 17 Apr 2024 02:28:42 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 02:28:41 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Saranya Muruganandam <saranyamohan@google.com>
Subject: Re: [PATCH] block: propagate partition scanning errors to the
 BLKRRPART ioctl
Thread-Topic: [PATCH] block: propagate partition scanning errors to the
 BLKRRPART ioctl
Thread-Index: AQHakG72XXkgObybfUiTD57h8u74CA==
Date: Wed, 17 Apr 2024 02:28:41 +0000
Message-ID: <skiehuzf3folczi2vlixxvikmxyl4buuo6zd4nwkpg5fnbpaxh@ftgk6ipkynp5>
References: <20240402160103.758141-1-hch@lst.de>
In-Reply-To: <20240402160103.758141-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM8PR04MB7831:EE_
x-ms-office365-filtering-correlation-id: 6048956c-f7db-46bf-396b-08dc5e861916
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QTleKlJTv+P/4oYqBrUVFRo5/1LY0BLQtpJkWYrxdHkSm06Sy60fJoZrUE0ok4sPwlQCowhnWh9MWq+npyUSeS6i6+/vO9pXDS6l9mgcSgXOuTueZ1ts2NfndaIazEFHmefYujWBfG0XxsjOg2gxm/5YoMo3+miuS7E3qS28xOLgg56GTGKPfYl2ZfMHaJ2kjXRo9o+N5RfEuQpdNcrEw+2wlYCHUTmRi3QRlZEejiwMJG2BSHEu8mPuTavCglPNYHpZ0+G/qgLUoeK6blWVVS+KmjRl8Yy91lLnQ/ysEOUUVCuxwXP+BWiFIVUCq4FnMpxu9EpL2RjnamX9FCy4M9QsulOXlz9Mb9r4Uw6ZMx00MAlTm9fTGU5GN5q6+eF9kQ4wdn6wiS8BYQW/MuN7htVIWST76mvIZUhGtJo7gIAT9rIfLMNaLsP8iv1RtY8HEu/HJohF47Z0Z2B5lQiOSKOFFOEKYha+5KGhantQJ/cQhD0Q5JVeftd3G2/Dn2FPXeWrYKoPV+E+f25s2m/ED77KqFi26oDF8E+2LFy7HOsJlxteFLRKqc5pAwqAN4H8RkAMqkWHRp6dAizlfDQ0j0+gJza51+OseGVoVmuwTjMj8F7yzJ3OH62miOKknCjeNjX/wb7IDgjHS5IN6i9WWtmEursfddsgskJkeUzUOwDI1FIHYSlujeJf+TD0vz9xddgvTOHIKbQXEi+vouTfNg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?d7aQq7diAVaQLUyYpZvk+I35yCd3GdXGPk7LPgPiwmkO4sShKFfYK3V+nUHj?=
 =?us-ascii?Q?WvwBtmsDL4b+pYZk20+zRkiHAEYcS6lVvvesAO7Rl6OmVkNTYofKoU/FTE/E?=
 =?us-ascii?Q?F/AJVcU29im32G2DjtvObS08+JBbt9NBJC+gKFlGnxBg3KIpy0QjBRPKrf32?=
 =?us-ascii?Q?1Zx3wMTcGy84wjTr1T6AnhzKSa4qKds0DOgOU0W7vA1e1kcKfnYfZ9RaStsP?=
 =?us-ascii?Q?xfArQ2VYRRDLhkMmPKW98tZkYaaRV/dRs4lJhiVfszZIcR1x8FdxoGbeODhj?=
 =?us-ascii?Q?p4WsKtBJojCK1NQQSyiIDdlv4RwOB7p7tR2ylHgBwyGng3C/gRb7OqvaIRR7?=
 =?us-ascii?Q?+UiVhZSgWYRgepur8WgtsKkIZQyDqtPK7SUDBfeSUMz6Lt3BBGMa1bkGBI7M?=
 =?us-ascii?Q?8McPUj0DGyjNq3MWYNkuS63YWHxu+4eSWCfSj3VElLW7lu0C5kGPop5BfJ4Q?=
 =?us-ascii?Q?tTUnQLa32Mh5uN1Pm0QCxGFmy2PJPVuOMJMP1C2ykZHeXYATKJ/cIUTpx/jX?=
 =?us-ascii?Q?e5Uat/L5OYEiUp8uO2zKg0T0it2GitIjCs0N//6mQpVcQjyaa27IDhbFAFZ0?=
 =?us-ascii?Q?HgEFb6qnxvpOCJrjSslgb4WEx/1LGVjTwYJmgt6SvmusrmvaH8y1YAsQ+LCT?=
 =?us-ascii?Q?KyIKy2uZ0sjOekq8IQCZix78+HxuZlx5zvqsKVsbb+UJifWiaxyWnyhUVkAn?=
 =?us-ascii?Q?d/eRbKBIOHoCS4W4qtGOjCz5Uqwx85fNM3ID1FhyVk7cirTIq/Lq4cfcadVQ?=
 =?us-ascii?Q?HBJJNNhBDuInbFZAzzj51UPGFyBEsQUxq17YitVLYwNMTgJ+q0hv00DZB+++?=
 =?us-ascii?Q?aLjUbPI1es+nosIn56QCVAViIopG5GbnN2GTA22GJyggoNHmxMbeWQtKFQJ1?=
 =?us-ascii?Q?n3AEkeZWWBdOdqVDoQX25qn6Fi1zlg60E+a5wp9QQiR7QsmJs9JmqcPQ4oBi?=
 =?us-ascii?Q?oKcbcYHHbAnPPYycQFTvS3b+yUScb4RUSzp+FbkucFgekijpz/opFPp4vZYS?=
 =?us-ascii?Q?uSN7LkJ7tLFksEmo910kGrX2F/eLJtrdjr1WHIrP8ssrWfTjw9d3wgIEiSbU?=
 =?us-ascii?Q?fL9Q5I+6OCpaCIqfS3zBRWaor13WjS+SfLNG5Jlq4WYtcSZD0YfiLZqkLIPV?=
 =?us-ascii?Q?anuxqYBSGOjCnfdCr8KovYMJ0d25RtxyEcfLYWXUDwzg5N8PvwaznoutKB9T?=
 =?us-ascii?Q?OWKC/RBYGItOcWhNjt6WL0gdiFik4LFG7dCPOrrrae8StCVgI+hPBeznTlYS?=
 =?us-ascii?Q?sbbmmRuDUV6oWfmc/DBVi45Mm0sEcqL48uCA4FB6ELtPxt8KhhGeqhHctUCL?=
 =?us-ascii?Q?Rx/4YCqC8O/H3r0a8L2P6FVi2JZbrAUepQWLcFSLlT4jkQIlCeEwqOS5ayvg?=
 =?us-ascii?Q?A4w8uOp5eSbvhhNQpLP6y+lL5lfbe5G4A4SX4aFXjkWv0q/sWIv4vWauG5Uo?=
 =?us-ascii?Q?iPSx1hbSCT6ohkIFFd6CrHciG5RqQm7flq/2cYDMsT5dMCFz6eo3kl7RsssI?=
 =?us-ascii?Q?3MV5+FYs84UOg/75htn+JmFJpbAM7jG4LquktOIFWiDuE0SvC//ECfFvr0G5?=
 =?us-ascii?Q?nHzQKmKiPAhiKa7YxJkolP1G1BeolB9Rh1qOazp/KTaXcB91z7gL238ZHEMY?=
 =?us-ascii?Q?5c4Q6ImRClfCSeDNyIKtUmM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0189F510991655478D81A8B106DB1CD4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xAeqWAHthPJqpPmnRJtHx2vtP7w+Bc/Tka2IMKVh0/nFCEijkiRU3i/Z+jNEWa5Qhw56hfZ+EGDRnlzhUZzqjjVwgV+kG06cT2bkTqbPjUhlzJOV8rf4SfRsP3Dn4ItgjlbEUCrOSInhja71jhtX62y8uOIjAia4Ppjh05yEtKq+D3Mlx7THaxZeOZF5yEMnqpug4t6o+BcDZEL8UuS1Bks4OOklEzN6vo3OwKzuVkJ+XLEgUCBfolR1Xks8rDiupQYSFFgp1LgeJEPSs8rIaKBbrMWSYVGW18axviql4uKjFrCHUjTUhwqsWSmANvK1nJe5a+HoMW9FrR43AfJIy5j6L6iUptIO4c1NHiwXOn6SrjCRd6kWzI56yiPS59M0TfKceFFiRy8qB/dkeIuxf0JZwcjBfyxYymreQ4XRKKkU1+SO7HWXlYhkVlXhL4Xtg234fmSSg8EDOusazqVtJbE7Ro3YpUzp0lVliVmf9qR9JP8KTuaVBZE0q6YizVAH5ZYK3r8hSGQRSPms3/goOfqtkZIfgOahiy1tbIFrqgcJpveBmWxBfzWxWxnMeR+8Ygn/upHzlGUJwhnycIXA5Jf6WhF0Kw4j97i1rg6JPug+RDKx5oFtrdG9dRWYDFm1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6048956c-f7db-46bf-396b-08dc5e861916
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 02:28:41.9248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AawDEsDmiNbhDhinwpxzYlskLFGoRjfrYjK8vhAOTtBzSnOAxzvrpmDLGVw0vwjyUjz+/a6bnSxfXRSWGuoiSpRxJkBR5Rpg7w6hgHnkUB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7831

On Apr 02, 2024 / 18:01, Christoph Hellwig wrote:
> Commit 4601b4b130de ("block: reopen the device in blkdev_reread_part")
> lost the propagation of I/O errors from the low-level read of the
> partition table to the user space caller of the BLKRRPART.
>=20
> Apparently some user space relies on, so restore the propagation.  This
> isn't exactly pretty as other block device open calls explicitly do not
> are about these errors, so add a new BLK_OPEN_STRICT_SCAN to opt into
> the error propagation.
>=20
> Fixes: 4601b4b130de ("block: reopen the device in blkdev_reread_part")
> Reported-by: Saranya Muruganandam <saranyamohan@google.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I should have commented on this patch with the correct authorship instead o=
f the
patch that Saranya posted. With this patch I observe unexpected EINVAL. Ple=
ase
find a couple of comments in line.

> ---
>  block/bdev.c           | 29 +++++++++++++++++++----------
>  block/ioctl.c          |  3 ++-
>  include/linux/blkdev.h |  2 ++
>  3 files changed, 23 insertions(+), 11 deletions(-)
>=20
> diff --git a/block/bdev.c b/block/bdev.c
> index 7a5f611c3d2e3e..42940bced33bb4 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -652,6 +652,14 @@ static void blkdev_flush_mapping(struct block_device=
 *bdev)
>  	bdev_write_inode(bdev);
>  }
> =20
> +static void blkdev_put_whole(struct block_device *bdev)
> +{
> +	if (atomic_dec_and_test(&bdev->bd_openers))
> +		blkdev_flush_mapping(bdev);
> +	if (bdev->bd_disk->fops->release)
> +		bdev->bd_disk->fops->release(bdev->bd_disk);
> +}
> +
>  static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
>  {
>  	struct gendisk *disk =3D bdev->bd_disk;
> @@ -670,20 +678,21 @@ static int blkdev_get_whole(struct block_device *bd=
ev, blk_mode_t mode)
> =20
>  	if (!atomic_read(&bdev->bd_openers))
>  		set_init_blocksize(bdev);
> -	if (test_bit(GD_NEED_PART_SCAN, &disk->state))
> -		bdev_disk_changed(disk, false);
>  	atomic_inc(&bdev->bd_openers);
> +	if (test_bit(GD_NEED_PART_SCAN, &disk->state)) {
> +		/*
> +		 * Only return scanning errors if we are called from conexts

Nit: s/conexts/contexts/

> +		 * that explicitly want them, e.g. the BLKRRPART ioctl.
> +		 */
> +		ret =3D bdev_disk_changed(disk, false);
> +		if (ret && (mode & BLK_OPEN_STRICT_SCAN)) {
> +			blkdev_put_whole(bdev);
> +			return ret;
> +		}
> +	}
>  	return 0;
>  }
> =20
> -static void blkdev_put_whole(struct block_device *bdev)
> -{
> -	if (atomic_dec_and_test(&bdev->bd_openers))
> -		blkdev_flush_mapping(bdev);
> -	if (bdev->bd_disk->fops->release)
> -		bdev->bd_disk->fops->release(bdev->bd_disk);
> -}
> -
>  static int blkdev_get_part(struct block_device *part, blk_mode_t mode)
>  {
>  	struct gendisk *disk =3D part->bd_disk;
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 0c76137adcaaa5..128f503828cee7 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -562,7 +562,8 @@ static int blkdev_common_ioctl(struct block_device *b=
dev, blk_mode_t mode,
>  			return -EACCES;
>  		if (bdev_is_partition(bdev))
>  			return -EINVAL;
> -		return disk_scan_partitions(bdev->bd_disk, mode);
> +		return disk_scan_partitions(bdev->bd_disk,
> +				mode | BLK_OPEN_STRICT_SCAN);
>  	case BLKTRACESTART:
>  	case BLKTRACESTOP:
>  	case BLKTRACETEARDOWN:
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 79ed07bd652ac4..0b39df4864ef19 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -129,6 +129,8 @@ typedef unsigned int __bitwise blk_mode_t;
>  #define BLK_OPEN_WRITE_IOCTL	((__force blk_mode_t)(1 << 4))
>  /* open is exclusive wrt all other BLK_OPEN_WRITE opens to the device */
>  #define BLK_OPEN_RESTRICT_WRITES	((__force blk_mode_t)(1 << 5))
> +/* return partition scanning errors */
> +#define BLK_OPEN_STRICT_SCAN	((__force blk_mode_t)(1 << 5))

The line above assigns the same number for BLK_OPEN_STRICT_SCAN and
BLK_OPEN_RESTRICT_WRITES, then blockdev --rereadpt fails with EINVAL,
not EIO. I modified it to "1 << 6", then it looks working good.

> =20
>  struct gendisk {
>  	/*
> --=20
> 2.39.2
> =
