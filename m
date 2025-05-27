Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB7F1CD0C;
	Tue, 27 May 2025 04:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748321803; cv=fail; b=UaZ/w9bKS5TrL1bkyLAuUA1FWlxEKunhAFNZoJJZt5HXnH0gOps2/3SwZhhDHP5pe/6UuEh5FZv1LbGnL8Adzm2zNxqMD1uFtOSzCYEybfcveukwb30ON7h8EFtVLhAjPa3qrhcXprsS9UeEgiM0wx+ZrHITVt6CRkfqH0JBDJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748321803; c=relaxed/simple;
	bh=TNm+V+jU/1kItFVCRsVutNkpDS60oM1lF5YSna4kIXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WYEcMmaL39wlWMEHnTOg+vGXgonIW5G5k7ASZ3kAeRrVzsymo3ieZUcCsmJOePeeRJ38Tpoh1pnKezuyaFvmvewumKq3W47WfJcuPv9LDNerUQIOcAlQQWzxQs406AROIqtbw3i7ERmyCTHq5jgykXzDoM3LpxZsVboJEM1CQUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YRHS/ZYQ; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YRHS/ZYQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExP0h7Tq4Q8EefcLeUEcBMqPC336w3f3mf7tjp5u2ylbI4Y9o8kxjKk8u9tQhCP3V8V+SRhHLITNQnmLA4CDpUAL3SSxCcrJ/T5o9vjF89hIIpBCjRRyshMZD/pI8mwXp1duyGryitfUo3Ilfq9hHOyxv+77/7sikndOC6LIA778xgaWxtZoMhZXMEC7P30yy5un98PchA4pBu2yd6MUeHQxtZwuw02/LxNGfK1iAKGr2t/uy/O7ufOxKuWZiBcxpNcerAstAk4pCKGY+rNm6xowAo1S93+XpHfml/vqoO7pN0u+P5InvIQaq6JfY/rQPQe2NrFPW5Kg2ZfBEKkyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43Lf7XebSEaB0kbx6xGrBYkSLsslN/YqJz8Dw6fdU4E=;
 b=dLOC07u2p6t0BmkWDWOr3OytQZwy0W+1Lon+4jDiAcuUu1Kwki+JpvauJ/xYnsP+w5uE705wGXpG9kQOoo1YJ0QPBw02tUwPbuOH5uMyS0GHAi0OgPvs/iAx97jXURcLG+8lJn5OUoKMZK4e8WFzpTcjfk0QuHvB0KwaSouzT0O/SbCzuP8HEmJ+XYHBqD5kkjZxbACVIsmlEeN7We9rCWi+jOQoD6HVbvoxJsN9n66qjQN+xGd6P9bjIp+xtXATVILhql1xEAxYVUGUaFaOvg8uqsfzHJWCUXPWJJL/lpCI6lhVllRK4R1GMJdBruFTxKyYsEVxhJ6mXEynH8uyUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43Lf7XebSEaB0kbx6xGrBYkSLsslN/YqJz8Dw6fdU4E=;
 b=YRHS/ZYQAXapLrZ9AG86PvNhkV5Y32bpPStn/+xikV66YY95aLdKkFFh+S2T33X6zwcndMt1AgdtHRoCAWpq7MHr1sNQJt5yzr6jLRUDCtWBSbT7QMN4fE+5WRMo1ng1qfDZO0xuYiUnC+eycbmREH63jCrFAL+DOpq4dejfLPpeJc0RhVdceh+5I1/HB+M70K4zNjryxSNTt4s9JDKcz0vwoIIyR/8DPpu5HXUP2+oz8TXL7nvWcDCK9dFOK6VCWzbQZDx2Ft5hv/0QHV4lISJ16jpoXYTTzxbavHTXLlHwF1+VP8Kk0xR3BZLYkrP/n3szdVoC7x31UF4KRNLcNw==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by BN7PPF48E601ED5.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 27 May
 2025 04:56:37 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%5]) with mapi id 15.20.8769.021; Tue, 27 May 2025
 04:56:37 +0000
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
Subject: RE: [PATCH v2] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Topic: [PATCH v2] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Index: AQHbzkwlOUEmL26euUGJDrp2Zb0iwrPlWS6AgACOEqA=
Date: Tue, 27 May 2025 04:56:36 +0000
Message-ID:
 <CY8PR12MB7195AD3A636B648833EC8EC7DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250526144007.124570-1-parav@nvidia.com>
 <20250526155340-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250526155340-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|BN7PPF48E601ED5:EE_
x-ms-office365-filtering-correlation-id: 6317846b-6352-455a-5016-08dd9cdadc53
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vFDpHlBRwKnRkZ2zoTbSgUFMiaaUSNZzgeDBZYEQZ/2RkAvkLaUQC2iANuqZ?=
 =?us-ascii?Q?bSx4U0xjdqwXJI2VE40nfJqVRh+3cH/C/Hfgkr0p7uapcoYl0hYyCEOfXJJ6?=
 =?us-ascii?Q?Ts9kDgFFS5f+MlmhF4OT9S4KPkYjAak+rcrSunqB/EnM/kaLobGcstabR2F7?=
 =?us-ascii?Q?cwlKGMndc6KR1ze6vxV2k84GRxlnJrJnVJdsawjO/yuVf78bhUYCYcZuG3Ds?=
 =?us-ascii?Q?fgSim+q7wkFVkGcsDv0e7o7Xr9e3U8PfnguRZLQvFTxHumf04717xPpUyzNQ?=
 =?us-ascii?Q?Cjc1myJxkXRaXFsu1naVA7lM5ar+9MLqPo37M49pFXHYqjmHQ7yKSC23NZAx?=
 =?us-ascii?Q?fWsvsyd01KFkad3m9BQIouBDIlEiIUatS3ZfCVtcblclqzJePebdLABc8BfC?=
 =?us-ascii?Q?I0mumi0YR/1btzzgpPGukTsnC6SzXNqimRu0P3Mo5LxFzlac6aY4QU+bezc1?=
 =?us-ascii?Q?9PxK0a2JXw97ThRLgswCtQJg9RZfoKJudNOuJRuMu0C37rp82+tarEIOvccX?=
 =?us-ascii?Q?hPWy6hdWtzrbos2uYYSvBDt6DE31af7EitLVaNPAEcF3jDbFmiEY+I/nYtin?=
 =?us-ascii?Q?GrrdrTbngllruOsY9+YJI0biihzzl0PBVHrxAywk8LvH2fUKMNVbtocFeWVW?=
 =?us-ascii?Q?ugrtoy2/mUYwu0FhimwxgYCS7UsnhjDBonbuUXwwyA+8rOa/7747IUu93xTY?=
 =?us-ascii?Q?vSvRXJnsLhjOgtxjfT9fGMIK8tvwxYCtJhKshq4VnB2uBsN+ZCdECIuR96Cp?=
 =?us-ascii?Q?pniXfUx19q3q1I1y7nz8CrzZNHh47oD31zHFhMCzy5v9sPJ4CHC6h4xjtBxH?=
 =?us-ascii?Q?2GyFvAYTxcRLo+xVlJFvydJKuHYEv1RS63Qtp4ooffJyhFFoOo3c+atKKO85?=
 =?us-ascii?Q?SxK2iHSi2tabf38lPnXOjhLtbrjEJAQhe8Ku4OF8RsvG32bSOtttw6hYWbrc?=
 =?us-ascii?Q?C1gaeOiLAHHdMqPLmFmYgoV5NHg8ZaHrg430rhY2OSKNH5vWwvq8vRVUDw9f?=
 =?us-ascii?Q?tU5wXc20t6Vhn2P4cv9z61gq2DMIwsGqpN/NiJ3LYbeuoFfZzK35XjeW5PV2?=
 =?us-ascii?Q?oh3Ol3KsUI9DixC5NPcR2Q/6l5Poj/r5EmcyckYFQ8m54IeN5dDZ42hTMP9x?=
 =?us-ascii?Q?ZY7lyKvAauNx06q9wZggq+W9cZF8jlFwj9jQxmumNX5uACdBZPWw7XMk7yVP?=
 =?us-ascii?Q?FpzpqZjcpq/gL9afgrwSVQYlf7kM7Ho1PeK2lq/QdLHMcEeyWsO8KiPNC+yf?=
 =?us-ascii?Q?Cc7DpExxgkDPXV+I72kIq5gm6TSQOZsMiROd5g3F89x2y+lfDZjIVEY6rqeX?=
 =?us-ascii?Q?es5hn4x1UA3vz92fs9BHC//AA+fMiXrKoGnDzs3eIXzFI/0sNnkI3mDBeN/C?=
 =?us-ascii?Q?OZt7liINg7g3r4al9OUMg6kDdnNcpT92f/soyjeNMKMFSvBRhZxnHg/il82I?=
 =?us-ascii?Q?e5ZYPJj3zWrhRMd62d++P1XfbCieSlpxHiXekL0eYRxJn5WzTtDMv14TNKFT?=
 =?us-ascii?Q?mPwJQbteuC02YKc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AmDSouzxzrohlCa2Z+JjgafnLZ5MdwsuC6HTnFqxpBRvO9tiazFgvucvOjtz?=
 =?us-ascii?Q?0Crg8/QjuKuUhqLMj/QUlF9Nb71AwXKTwFQhHmV73PxOMp9fSZdeWEmy8Z+0?=
 =?us-ascii?Q?7gwJJ3bgR1oJ0eu4HbqIyzmp6SbBGrk4meQxwLa2OKPhKCUalmvuH2eHJ9R7?=
 =?us-ascii?Q?yA/nn6FEiPCRzIHL1dEGlIS6EcPQY+7Vf70/cWKva4bZQFyR6xmDFLKku0KA?=
 =?us-ascii?Q?1kusUrnFLaAarmEWkTfahNgoEH/3ZLXmW7uVwkHqlX/NSPICV9lv7sgfavQS?=
 =?us-ascii?Q?/mAp/htchHt9OL+LLMUojNUazxrtEhMF7+NhbdrwLeSw94Lno9ljDxNz8MG9?=
 =?us-ascii?Q?4a3WMClB9wH6NTHDZg7LbwOLId9byq69tIbqzB3QxUKjpEC5RTqe1l8olm0d?=
 =?us-ascii?Q?z2TXLE2KWx0JwyZoROTGIF6L2ysl0v4L+ceJXe0G+wTFIAQKsNrdjwOrGa+0?=
 =?us-ascii?Q?GzWvD+wueCNSHFaLB+WUW5xRSNHDUPh+QrFhQHFxdPPnSMx1bSMt9q5d+yyZ?=
 =?us-ascii?Q?rspSRpYmmb0RG0FsqMnvi2HlRvMTt+IHPiuE7ZLLeI+iHN84NEvWHgEBGd9I?=
 =?us-ascii?Q?gjJdJ0xXzyySSY4a/HM3cr5u85V322hBic9WBUHpUgMZQdUJo2GoIjVEdMEw?=
 =?us-ascii?Q?jomFMGIqI08MV56vxH39iT2xQXeulLS0Eka+kJvFFKpK9qF4f5k/nsHSkMtO?=
 =?us-ascii?Q?Xddj6+wTLf2F2WFZ1TmWUt+Zq1PeXl4t3EOEn/vGDDwUxrE5c0pN4H5z01uM?=
 =?us-ascii?Q?ytc/OP1hwmXHM0+kQ1jBRLIf4edbBgMbB4cppz5s+aWO8KA9tc+VHb4XKNgK?=
 =?us-ascii?Q?AJWVmPDvDnFXHMIgSAVkoF1mmp5mDuLSjDpuoIOgMrZx/yW5XvphBpS1uO+R?=
 =?us-ascii?Q?vjLeyM0HOtX+vaqy/FQdBNFVAW3g0HWEbzRm9p+D4vSnfGBRyRZFIvEeT/Bq?=
 =?us-ascii?Q?oDsLfN6yte4nEnDM6Zm07s/2PYq9wSnSkOcQaKO6ubVnf1IqqKvgbioG87hI?=
 =?us-ascii?Q?1MMYFDqbGb+XzCZOA/YnuKhgNM4yBdPFuVNYRhA8uUA8KU5p86monP8Iz7RN?=
 =?us-ascii?Q?ft2Wh7tEWIAmeEewRU1tMjXa9UqMOUXIHlLqHkdVdcMO9TNOXnXoNHCuB01/?=
 =?us-ascii?Q?9e9tMyRWL655WSBIam8wfHD0qnNtLh97pJviyWgDixQkwc2WLqxbAvSxhHvt?=
 =?us-ascii?Q?6KHxQmeIF2dgNDMzIvFjQJ/bnhh/n3URhVvtRrqdbfsqU72AywQZs/U9zilV?=
 =?us-ascii?Q?QxW9iydI25q02Ew6xvAyag1avyJKyYCaXtcW7dAdHY+yt6qKVoGkUp7CoYhJ?=
 =?us-ascii?Q?OQFZ3MlQRaqHs9cz5uL+u2yymragyyR2dKpfDWsVmuq+4pXdAU3CyfHxW2+y?=
 =?us-ascii?Q?yKwZswquuF4iZ7kFiF60tBi1ghIqv5ytDDWC/svIzQ50K6jCQGAS8OSVuebr?=
 =?us-ascii?Q?vi2ngEYzAdulUsizzk7iK/vifc1GMLadOT+v1cr9uv79Pl3mzcmVn1EBCwoY?=
 =?us-ascii?Q?hz9VNC2dqAlmJpL+YxGy2hVh0PerWGBeDvzHgBonudz0aBA/uWwnHbm9j/KG?=
 =?us-ascii?Q?9q3qmWuXU6lsuNUoYC8p9Lsg6Pwi4v3yK/oSqN7X?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6317846b-6352-455a-5016-08dd9cdadc53
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 04:56:36.9256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dI0+JcszuBtsWEbvA7HiXsIGThsZypZv3K633RP9c/YmOYioHUc564yPi0hpNcgtdJLAHnAAHAIaA2fzEE/BMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF48E601ED5


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, May 27, 2025 1:45 AM
>=20
> On Mon, May 26, 2025 at 02:40:33PM +0000, Parav Pandit wrote:
> > When the PCI device is surprise-removed, requests may not complete on
> > the device as the VQ is marked as broken. As a result, disk deletion
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
>=20
>=20
> Thanks!
> I like the patch. Yes something to improve:
>=20
> > ---
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
> > ---
> >  drivers/block/virtio_blk.c | 83
> > ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 83 insertions(+)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 7cffea01d868..12f31e6c00cb 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -1554,6 +1554,87 @@ static int virtblk_probe(struct virtio_device
> *vdev)
> >  	return err;
> >  }
> >
> > +static bool virtblk_request_cancel(struct request *rq, void *data)
>=20
>=20
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
>=20
> My undertanding is that this is only safe to call when device is not acce=
ssing
> the vq anymore? Right? otherwise device can overwrite the status?
>
Even if the device is accessing the VQ (such as descriptors) and its memory=
, and if we free and unmap the request, it is a problem.
So the contract is, when the device has reported that the transport is brok=
en, after that it must not touch the VQ.

The in_hdr.status is updated either here or in the done() handler.
And both are protected by spin lock, so they don't step on each other.

=20
> But I am not sure I understand what guarantees this.
> Is there an assumption here that if vq is broken and we are on remove pat=
h
> then device is already gone?
True, the assumption is that device must not touch VQ or memory pointed by =
VQ when it has reported that device is broken.

> It seems to hold but
> I'd prefer something that makes this guarantee at the API level.
>=20
Not sure how we can guarantee that from the device.
It's the assumption from the driver in following the pci spec.

>=20
>=20
> > +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> > +		blk_mq_complete_request(rq);
> > +
> > +	spin_unlock_irqrestore(&vq->lock, flags);
> > +	return true;
> > +}
> > +
> > +static void virtblk_broken_device_cleanup(struct virtio_blk *vblk) {
> > +	struct request_queue *q =3D vblk->disk->queue;
> > +
> > +	if (!virtqueue_is_broken(vblk->vqs[0].vq))
> > +		return;
>=20
> can marking vqs broken be in progress such that 0 is already broken but
> another one is not, yet?
> if not pls add a comment explainging why.
>=20
> > +
> > +	/* Start freezing the queue, so that new requests keeps waiting at
> the
> > +	 * door of bio_queue_enter(). We cannot fully freeze the queue
> because
> > +	 * freezed queue is an empty queue and there are pending requests,
> so
> > +	 * only start freezing it.
> > +	 */
> > +	blk_freeze_queue_start(q);
> > +
> > +	/* When quiescing completes, all ongoing dispatches have completed
> > +	 * and no new dispatch will happen towards the driver.
> > +	 * This ensures that later when cancel is attempted, then are not
> > +	 * getting processed by the queue_rq() or queue_rqs() handlers.
> > +	 */
> > +	blk_mq_quiesce_queue(q);
> > +
> > +	/*
> > +	 * Synchronize with any ongoing VQ callbacks, effectively quiescing
> > +	 * the device and preventing it from completing further requests
> > +	 * to the block layer. Any outstanding, incomplete requests will be
> > +	 * completed by virtblk_request_cancel().
>=20
>=20
> I think what you really mean is:
> finish processing in callbacks, that might have started before vqs were
> marked as broken.
>=20
Yes, I will remove the word "effectively quiescing the device", because tha=
t is not done by pure sw code here.
It is quiescing the async interrupt handler side.
How about a below rephrase:

/*
  * Synchronize with any ongoing VQ callbacks which may be started before V=
Qs are marked broken,=20
  * preventing it from completing further requests to the block layer. Any =
outstanding,
  * incomplete requests will be completed by virtblk_request_cancel().
  */

>=20
>=20
> > +	 */
> > +	virtio_synchronize_cbs(vblk->vdev);
>=20
>=20
>=20
>=20
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
> >  	struct virtio_blk *vblk =3D vdev->priv; @@ -1561,6 +1642,8 @@ static
> > void virtblk_remove(struct virtio_device *vdev)
> >  	/* Make sure no work handler is accessing the device. */
> >  	flush_work(&vblk->config_work);
> >
> > +	virtblk_broken_device_cleanup(vblk);
> > +
> >  	del_gendisk(vblk->disk);
> >  	blk_mq_free_tag_set(&vblk->tag_set);
> >
> > --
> > 2.34.1

