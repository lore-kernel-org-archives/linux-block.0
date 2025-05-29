Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECE72192F5;
	Thu, 29 May 2025 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748512677; cv=fail; b=SGRCU9gVmX8neNziPXc2t4B/PeyjEVEoyJxNWqIcWmNLGiWI5Ayi88+Xe6Xh9cvwwYbP5XZFTvc/U19172PfC3Ai25l1L3mObYp2EvxWLHiwNsi5NTWBN/24Eu9iOP8fF7Pcx9rDq9FmOwtXglJbzRWa5ct3M/1qVWXli79Ui2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748512677; c=relaxed/simple;
	bh=uak9UNw57kJ2kLbfwajfEeq8uVn7zARllf5JFDU9A/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gtiAHRjBlo70JsS6VOD9GF4FViVHrAMRjRz9McRtXQAMG2kecxt34isFHBfTsP5f4JwT7zJs8cqiEJGFwEM8i5JaOL8q0pA+Hsib21tEJ8y1J/jvSmcmOlu6i5gMphhj8t726Z6rhQM+9V0LWf187UUiwMdLT0CcGFVWTXn5smU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bJ8nl7tU; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bJ8nl7tU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPV5me6RgjwxJqBCSUm9r1fPEEQj5uzH2OYax/iT/QoH9UlFYjLcizyRaO7poX6YSZnRelB3g7EHICKQtzFh99nzuf6lfBqYvJFMCIfaOmlycm6ZJ2J/Avh8lHcmDm/aejznO5LycbYIssP3plYLUe0VXoIkm3C9W3LjlOlJ1sekB7wZeNoLwDFZM9eDZMag9ohI+1or7xnjlbuB7Gu5u5e5vqLq8xaVwRustJ1HezWKDyJqFGto0x4Z+O/Nb49tInhMq2VdQ+YWL+jMPcCdF9apD0AtNH5FC6M9uOiYFkKA+QBTOiLTSWzFnhqtA3iWPUqsRk91zoPWefBe0pJ73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VP3MB2+dJv/4R68YlbPNRTeOUphnhxqKA0hGuEcM3U=;
 b=GQNhseQF1Xi3xhnx952dW+7yE79YHWkLZqQgqDRJhc9KPuI0+hGtVKWU94ZQWZxbozZ4AM0zfQ30Osw/XyiFNMubcEbDPq+Wyzasjl8YRSJyotkoz3/PunsgNSHUo6um2KW0aP6vUjkLQBsGuNY7PiGBBf6s17E56QB9ZWP/qT5gGpXSw6wsPixNDnDhlbcxkKVQutyuXPyBHPg4MyPzDVaKeWaA8VbZEnLZy4h+uDEpmSa9NUP397Yx3uiT9FrKOiZltfBEf/xVxHZZ7wkQMFo+D/5lwhiId6X0TajR0uX5qqEuAEi5IHznoLmMU0GPzKYR+7VlScucoiLv9UBFog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VP3MB2+dJv/4R68YlbPNRTeOUphnhxqKA0hGuEcM3U=;
 b=bJ8nl7tUMctTJu6mgrblyPNzvv2O4G9b9oJ5qqOwD90oGUeM/eNarWzIuxTDLdMqXTfossXc8JYLNVHmyxFlLrvQ5m+UZIuaOnsNDXNMr/13EzRJIawD5qD++dzN7QAlOjclo9ESkfFxAdoaW5vOHUbN3N6s9DSlnRStHZFDm2Pde51xRlTZnLRs1s32VlxkEcl/6i+D6kd8uHtH1yDybcAwZ5MwH3832awLd/5Xr56yK1vh5HMwDyPEWJIZTQaBO0TDtNIrbtLc+lQOTbw532AZBuEMoJv6IB9XkuVbYE0iZ9HRFE6ha683RTGU7TaRo/mOxSX4zUnh6vEpm0Duqg==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 09:57:51 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%5]) with mapi id 15.20.8769.021; Thu, 29 May 2025
 09:57:51 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "stefanha@redhat.com" <stefanha@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "NBU-Contact-Li Rongqing (EXTERNAL)"
	<lirongqing@baidu.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Israel Rukshin
	<israelr@nvidia.com>
Subject: RE: [PATCH v3] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Topic: [PATCH v3] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Index: AQHb0GGmDIbmvVh+zEesJaMuZQogyrPpP6sAgAAeETA=
Date: Thu, 29 May 2025 09:57:51 +0000
Message-ID:
 <CY8PR12MB71954B0FEBAC97F368EF1EBCDC66A@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250529061913.28868-1-parav@nvidia.com>
 <20250529035007-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250529035007-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|PH0PR12MB8125:EE_
x-ms-office365-filtering-correlation-id: 84de82e3-282b-478f-66ea-08dd9e974686
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3vQqK0DuIy6ZOlR26VbsgxeDK4u8yLZpRJOk0GR4FK84w+ZkCPuDuOAUnwym?=
 =?us-ascii?Q?dV4Q/XaKKNjZIxAYp4/KgQiaPUSYKnCELUHGiPB4TVggBhRJpb+tyz7Ep5HZ?=
 =?us-ascii?Q?j2Rcp9vwzE/iCcV9XFgTQdQTUzkq17ITWtdtm6FFtuU15Aw9UwW64uLpNZtB?=
 =?us-ascii?Q?2LSDJgJloihHGOkY9jNSP4GcyQYGBFg1fLCv7c+6eydisIeSDVpnwDdui12x?=
 =?us-ascii?Q?6/L6pZjp2iOifqhiezD/JjjWnWXIt/v2rcU+0EzZtz5ktU0QBT5cF1WiMF3Y?=
 =?us-ascii?Q?PeZ5PVEfqc5qiDnXhKu5VevIdQc9lbsyVlHjuj/NJkZEN4UebpcCDGsHhtMn?=
 =?us-ascii?Q?pegTlnDMX4iNMZXwuBzEbosfpuMQr4lR68yYCg454dKuoW55tneDCPh7pAo0?=
 =?us-ascii?Q?E4LCmBwz9sAR+gJosaqLxyHmgcKjecdEjxmGpFCWTQyv2XH+L8nWXyt2wS+v?=
 =?us-ascii?Q?Ek0THHmqBdQUgYwTEtngYXbVTMygMHd3ULUg9p6yv4UY8cZig71DrhWma9HK?=
 =?us-ascii?Q?lgvKVRHZ5X4dx1/XOPWOMRNTqrHbz61TkLk5pQXtinAkWd7fTjll6aF+MxYT?=
 =?us-ascii?Q?Nzkd4xgp5ziAaAKsj5TcCRcMmjJKim8gaUMco9gBiAr9/eMht51GYXdr01xc?=
 =?us-ascii?Q?k7VrZK9HAx2qJnJbUF4ZsiKpnmfKJKfgDhs+xslRS6IhCKuuwp6guDCaZXnX?=
 =?us-ascii?Q?CkWUMsUz2j2PeFWsy7B7klZZeUIivdtJOp5hXNODyGwKd1h1LmMXWNAOA1cp?=
 =?us-ascii?Q?mgU+5pOWxSAtUsc9rrRue5TDKFWF9Sj1FWDSYHJm7snV8EdfJq2kLZgrFtoI?=
 =?us-ascii?Q?CCzyGxvbsEBq7qf8DEJ8ak2+VDPCXIYrl4GU3TvLOrTHkc/rHGhiyFVHQfPB?=
 =?us-ascii?Q?SDMBi/YsrQr6S01BWsQKZBgrHI4sCJEN/7JkFZHcH1Iz7a0CdsJoJpw/qkYP?=
 =?us-ascii?Q?eJus8C+8syJErErh+i7GTKTDra9Ma52oaj57C1Np7VLKL/UZxwhrgLnQsLo3?=
 =?us-ascii?Q?rZc1Pk1MBDI9wbK5YIh0cgAJ4IBWwC4JqtZuTtrsaJTuHOdPsx2eWIMrRRye?=
 =?us-ascii?Q?8P6vV+oC64a2SuQJjp6CXPAYd9DboGHyv+UEPHdXeCmXjnj6cfLZPbMZ1Qz+?=
 =?us-ascii?Q?ndTjKPuFmeZ8umUuJRnHQkrNDUT6jSQyjBCjRTnTeShmsKxqbKMY3kAYPAWt?=
 =?us-ascii?Q?scwwFj/s8mKIPx0phewZNAAdGVutexIiVttJdAbhP1A+f33QwK94jhRGrKMf?=
 =?us-ascii?Q?7lDFRa2DcQFAmDW7Mu44qayYbr3b1vUTkCk3qY1z3bA/doHycI4x4XIb3nYZ?=
 =?us-ascii?Q?gzOOaY6XeaZ1FtX/XNFgRO7E4cDTfdq5WGo08mzSUikGBjAjvLGGFR+NWp6h?=
 =?us-ascii?Q?4fE+fx0mM2323MZ77cVooee9la7XUac7jfoyvSAF+6j4Q1G5DBpbuPULCDkP?=
 =?us-ascii?Q?PBLibH5x37mdSOozZl7FylA4Z6QTUd9nez+cF42PZK/EFv6Ezx5v/ySquMBM?=
 =?us-ascii?Q?QfFAd/p60YGGCDA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PlElFfhUGrn2fwRSRb1WoVaulorObMPDuaMZQDJMcbauphLemzhOiWL8dRNN?=
 =?us-ascii?Q?SWTes9zPMWOEJTGHza3FN7h16qqyQLQMTA4vqbQ2K6+V0MMc/IIf4tngvaiW?=
 =?us-ascii?Q?9AaHKP0WZwjD4mWHuUVwcEFXJPkIylOxbD58N0/ZnPbzP2HXrvCJuDCCD7R/?=
 =?us-ascii?Q?uF/wFY6XanJ4/qsGyvOXUwPI41A+6SN33zDRXEC0aE7RNkRC8vX6+b4JwEX8?=
 =?us-ascii?Q?9GXJmmzbS6/mtMoEgY9JjgkNcl25QFTC1dBDmmVIMh4sMYu9k1Ckdw9RFWqQ?=
 =?us-ascii?Q?3ek1gbjaxm2qDzKhC/hd01zMUHr+V1JFQ8pHFlXtYWGqP7KzqkutWp8Rqrmv?=
 =?us-ascii?Q?RpC3X/bH1/vNC3IW0yMPrk1XNrZiepCfzpgYtzDvIiBFQ3GM8f0QPZG4yOfb?=
 =?us-ascii?Q?73f7GXGnbuQyn8Pbc7b6wNCBobg4Vpxnucc8Zh87MhA0CKqiWb3r5d4Tioh/?=
 =?us-ascii?Q?MhGLa5bj+q6PjHUPemJJmAU9hixr9A0Sv1GolHDEQM5j1HwO8KuxcFjpCNr3?=
 =?us-ascii?Q?ALSVZrQJIH/FYdcrF0wHy+V2w90/ZSHE+xwlC14tv/AT/IufONDcjYHK7eSa?=
 =?us-ascii?Q?vXLrpTN6xvPfDUW3y8hN29ganq32ZAcXA6cv9pqIMeCEyIalfbG/7ZUQad3j?=
 =?us-ascii?Q?v4CQ4UppvF3epc/ff6IaUHYFgclYqv4tDoxtXmx3+73PH+mDYFVfWyg7aMVa?=
 =?us-ascii?Q?LMmIBkUPNeipo/7Z0chtAIXaZn/l9csUMftOmjwc9LDYxUSa2Fy4eKtTNCkh?=
 =?us-ascii?Q?Mhw58vBympkBShRsVngulRkYaw+LBlMRR7V1hTFN/TOAiVQILhx0dlmJNcw+?=
 =?us-ascii?Q?b72C/EoT9LHp5er2SnSSiHP+/WFOkXXN0YsWxNfd7y10cTkV9jxDkP5+6aZ+?=
 =?us-ascii?Q?FZPczAL5Iw3VHy1wJVUSxRO7BmPNzvrjap3LVMBEOEa+mOS+nFVLfIEp3L6P?=
 =?us-ascii?Q?9EetMY4FURl+XeHEfRjaXxzNQGaR3eW4UXnQ/XdTvLciNaR5PLTwtz+5Przb?=
 =?us-ascii?Q?JzYGQuz9FqJ9670A2UVSSIJ4rmaavuVhxhOhyOSjdJ+6IakIoizRKcx+B8j9?=
 =?us-ascii?Q?HxaItJnxAvfVuAwt58VPJC15OJX5qcC1bMxwdetOqKf/E/6xawNxebYrjoXz?=
 =?us-ascii?Q?8qsNtsCxdyY8bN/7OLDDa09bT5uhodG8gQLZu+O60o0IhhWtrzeq56IkknEd?=
 =?us-ascii?Q?tIFqcI1dPnXKr9Eu2f+3/YZDKi2cyFgsvHyJhkEjJuNC7wp6/iNSTisj92+K?=
 =?us-ascii?Q?99fXcZK/xNm9LFPQhbWQhZ7RJCy9xlLR9/eVWT1llZly2OuBfI+ECetdAM24?=
 =?us-ascii?Q?zh+czvHGLb8tqzgZxdY0nqhKgiU/6ytWPzg/pUCqZbgW4vuT5FAxY5iAFYzg?=
 =?us-ascii?Q?SnCaRrdjlR3+XW7JQVxeyonT2CUcBDTtnEWasU43Z4tcXwPPJ6A2I1MZ37QF?=
 =?us-ascii?Q?daGWknaV5fzyAseh9fcZRsD+umRQzXAWsy3+JULNk3n6njqAxc+9i6DUYRLw?=
 =?us-ascii?Q?vM52mj95TdJ2biupdH+iMJYdkUxXDsooeLHw+zUsrl2UqetRglrRAgkzFHeE?=
 =?us-ascii?Q?1vOZr6hzx7sWnflvu7A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84de82e3-282b-478f-66ea-08dd9e974686
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 09:57:51.6875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mLuNpfU2DcrP/Sd7+/XZ3JqWcEwhXiX55xOPBNx0GOV1+j0fNCtdPcgqj5TQftSvB3hOCJgD1zBmoIKCVM5YOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, May 29, 2025 1:34 PM
>=20
> On Thu, May 29, 2025 at 06:19:31AM +0000, Parav Pandit wrote:
> > When the PCI device is surprise removed, requests may not complete the
> > device as the VQ is marked as broken. Due to this, the disk deletion
> > hangs.
> >
> > Fix it by aborting the requests when the VQ is broken.
> >
> > With this fix now fio completes swiftly.
> > An alternative of IO timeout has been considered, however when the
> > driver knows about unresponsive block device, swiftly clearing them
> > enables users and upper layers to react quickly.
> >
> > Verified with multiple device unplug iterations with pending requests
> > in virtio used ring and some pending with the device.
> >
> > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio
> > pci device")
> > Cc: stable@vger.kernel.org
> > Reported-by: Li RongQing <lirongqing@baidu.com>
> > Closes:
> > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b474
> > 1@baidu.com/
> > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> >
> > ---
> > v2->v3:
> > - Addressed comments from Michael
> > - updated comment for synchronizing with callbacks
> >
> > v1->v2:
> > - Addressed comments from Stephan
> > - fixed spelling to 'waiting'
> > - Addressed comments from Michael
> > - Dropped checking broken vq from queue_rq() and queue_rqs()
> >   because it is checked in lower layer routines in virtio core
> >
> > v0->v1:
> > - Fixed comments from Stefan to rename a cleanup function
> > - Improved logic for handling any outstanding requests
> >   in bio layer
> > - improved cancel callback to sync with ongoing done()
>=20
>=20
> Thanks!
> Something else small to improve.
>=20
> > ---
> >  drivers/block/virtio_blk.c | 82
> > ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 7cffea01d868..d37df878f4e9 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -1554,6 +1554,86 @@ static int virtblk_probe(struct virtio_device
> *vdev)
> >  	return err;
> >  }
> >
> > +static bool virtblk_request_cancel(struct request *rq, void *data)
>=20
> it is more
>=20
> virtblk_request_complete_broken_with_ioerr
>=20
> and maybe a comment?
> /*
>  * If the vq is broken, device will not complete requests.
>  * So we do it for the device.
>  */
>=20
Ok. will add.

> > +{
> > +	struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(rq);
> > +	struct virtio_blk *vblk =3D data;
> > +	struct virtio_blk_vq *vq;
> > +	unsigned long flags;
> > +
> > +	vq =3D &vblk->vqs[rq->mq_hctx->queue_num];
> > +
> > +	spin_lock_irqsave(&vq->lock, flags);
> > +
> > +	vbr->in_hdr.status =3D VIRTIO_BLK_S_IOERR;
> > +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> > +		blk_mq_complete_request(rq);
> > +
> > +	spin_unlock_irqrestore(&vq->lock, flags);
> > +	return true;
> > +}
> > +
> > +static void virtblk_broken_device_cleanup(struct virtio_blk *vblk)
>=20
> and one goes okay what does it do exactly? cleanup device in a broken way=
?
> turns out no, it cleans up a broken device.
> And an overview would be good. Maybe, a small comment will help:
>=20
Virtblk_cleanup_broken_device()?

Is that name ok?

> /*
>  * if the device is broken, it will not use any buffers and waiting
>  * for that to happen is pointless. We'll do it in the driver,
>  * completing all requests for the device.
>  */
>
Will add it.
=20
>=20
> > +{
> > +	struct request_queue *q =3D vblk->disk->queue;
> > +
> > +	if (!virtqueue_is_broken(vblk->vqs[0].vq))
> > +		return;
>=20
> so one has to read it, and understand that we did not need to call it in =
the 1st
> place on a non broken device.
> Moving it to the caller would be cleaner.
>=20
Ok. will move.
>=20
> > +
> > +	/* Start freezing the queue, so that new requests keeps waiting at
> > +the
>=20
> wrong style of comment for blk.
>=20
> /* this is
>  * net style
>  */
>=20
> /*
>  * this is
>  * rest of the linux style
>  */
>=20
Ok. will fix it.

> > +	 * door of bio_queue_enter(). We cannot fully freeze the queue
> because
> > +	 * freezed queue is an empty queue and there are pending requests,
> > +so
>=20
> a frozen queue
>=20
Will fix it.

> > +	 * only start freezing it.
> > +	 */
> > +	blk_freeze_queue_start(q);
> > +
> > +	/* When quiescing completes, all ongoing dispatches have completed
> > +	 * and no new dispatch will happen towards the driver.
> > +	 * This ensures that later when cancel is attempted, then are not
>=20
> they are not?
>=20
Will fix this too.

> > +	 * getting processed by the queue_rq() or queue_rqs() handlers.
> > +	 */
> > +	blk_mq_quiesce_queue(q);
> > +
> > +	/*
> > +	 * Synchronize with any ongoing VQ callbacks that may have started
> > +	 * before the VQs were marked as broken. Any outstanding requests
> > +	 * will be completed by virtblk_request_cancel().
> > +	 */
> > +	virtio_synchronize_cbs(vblk->vdev);
> > +
> > +	/* At this point, no new requests can enter the queue_rq() and
> > +	 * completion routine will not complete any new requests either for
> the
> > +	 * broken vq. Hence, it is safe to cancel all requests which are
> > +	 * started.
> > +	 */
> > +	blk_mq_tagset_busy_iter(&vblk->tag_set, virtblk_request_cancel,
> vblk);
> > +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> > +
> > +	/* All pending requests are cleaned up. Time to resume so that disk
> > +	 * deletion can be smooth. Start the HW queues so that when queue
> is
> > +	 * unquiesced requests can again enter the driver.
> > +	 */
> > +	blk_mq_start_stopped_hw_queues(q, true);
> > +
> > +	/* Unquiescing will trigger dispatching any pending requests to the
> > +	 * driver which has crossed bio_queue_enter() to the driver.
> > +	 */
> > +	blk_mq_unquiesce_queue(q);
> > +
> > +	/* Wait for all pending dispatches to terminate which may have been
> > +	 * initiated after unquiescing.
> > +	 */
> > +	blk_mq_freeze_queue_wait(q);
> > +
> > +	/* Mark the disk dead so that once queue unfreeze, the requests
>=20
> ... once we unfreeze the queue
>=20
>=20
Ok.

> > +	 * waiting at the door of bio_queue_enter() can be aborted right
> away.
> > +	 */
> > +	blk_mark_disk_dead(vblk->disk);
> > +
> > +	/* Unfreeze the queue so that any waiting requests will be aborted.
> */
> > +	blk_mq_unfreeze_queue_nomemrestore(q);
> > +}
> > +
> >  static void virtblk_remove(struct virtio_device *vdev)  {
> >  	struct virtio_blk *vblk =3D vdev->priv; @@ -1561,6 +1641,8 @@ static
> > void virtblk_remove(struct virtio_device *vdev)
> >  	/* Make sure no work handler is accessing the device. */
> >  	flush_work(&vblk->config_work);
> >
>=20
> I prefer simply moving the test here:
>=20
> 	if (virtqueue_is_broken(vblk->vqs[0].vq))
> 		virtblk_broken_device_cleanup(vblk);
>=20
> makes it much clearer what is going on, imho.
>=20
No strong preference, some maintainers prefer the current way others the wa=
y you preferred.
So will fix as you proposed here along with above fixes in v4.

Thanks

>=20
> >  	del_gendisk(vblk->disk);
> >  	blk_mq_free_tag_set(&vblk->tag_set);
> >
> > --
> > 2.34.1

