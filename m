Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2CA35958;
	Thu, 22 May 2025 02:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747882653; cv=fail; b=ZNOwc0IpiQs6WX9evCStEpjnrmbQBWGp9l8vvG9m2NXiO3AJ+9GZdpBr8PKmZqc9bqNr5DRYGDu2QGzDycYg1QH6IvyqZx88zkjcTAhyXaAOFIVFpHGGQfp98YaoRK4bIwzCTNUI5aO3tVBXFXl5SS228zIbqE6AO0KP9+ggujw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747882653; c=relaxed/simple;
	bh=NpLRHhex9e6+GiqhHbZsQdiWf+jPi8YlxKikQ7bnnvw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sOvzz/anW8B2Uce9v6p97UHQc3e2Qe0eypZuhZuN3bXCnX/JGRBz4lGQcft3LzzvZI1TgJGr/Ew/u2W8Qpi52gwkJiqW3cyKrHytKEXG24GBa28my1Q4/rd/TpLpILKlODUqMbRXqjDlEkixR85iAeMxkeXfygssA/5su3+A0G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CQTzml9M; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CQTzml9M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JttOK465wfknficvx4i/EXKC1MRxP9MiKOhUD01Hp0TG7KEj52RIJgh07QYUad4vyUsJNOdQebExMgFy4XSuB1nL8ZI81qqRQtYYc6ESoc0xycg28vmMfrWKS5Nkr9EouyRuzFGmpv0jCif38Ji9V8dWrFwln73HMx8OrEgCOrTjc8zqBcgmUqAzhBCPj6/Lmong1NFdKnhN4omX1JVFePftH8s6BSTDrLLbYLgCK8vlAl4dOCWLvb9FM8ZUozqOkEJrW2B5G27u4JNqfEyCTEkhSrFm5AnVjq0OWsFo8LhHjgegGe7q/FFT8wP9CWRuIFJM7CP9hYhck4kEtBCqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIfOOAD2rjI7lN6u5iZF/T9Bo2nz0ZFJaSiL/lySpzM=;
 b=xYuaiSQvb212dcYax2UIMXI4IuUAR5KWiwZkrOwwYQUoEP9AmS78NoVijGOmOigKUnF4nnabyMcIQXpxbIxBiJPfmgLnn2oT4zT9midvYtyTQbGTPUQugubbXs+9Pn7Ewl+xPdfGN4abxzmafKdkllP6b6u8z5dl3QwuZPkzt6H/JMNpRHywUjJXAa+qH+7EvVomMSdefP42owga/L8p9z2lf0eLho/mQud+J+6koZY7qfRwrZ8DMe9NTxAW3w2bwOWUlXfxlor4x9JA2sPV+BcQTQRLJVF9vY87wTxI9vct1rinKMAj/uF0RSu+Z2TVoknHEPJwrC4u7O2emTQ6hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIfOOAD2rjI7lN6u5iZF/T9Bo2nz0ZFJaSiL/lySpzM=;
 b=CQTzml9MWXiucxBlmcRNjvFgZcJjSw5KAfDrTd4qbY3f/dnqdW9IVIORoXRbWBJjSUenTgkqs2o58Cpycwasd6i4Ee4MX21kTt5IY3I9//46sXiQz3P7v8ivjoAhmiOqbH/KHruPk3qgBNxQGSALkDSdDvJm4z93NGhZBoz8q2UpAxuJgRAKRibJ+khsYA79Jj7gu7LFRW4r42OEVlyHDaH7ImjI/HQfOwad1lItaghdY0sDYrhiCUpL5QOJtTDQtUBHu0G0p5Pm9pAY8sbgpkox6wqijiK1BWoMPDzDzd4OD12B6LedR+6k/owCRp1TYdfmjyKamL/4F5SWF37tRw==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 22 May
 2025 02:57:26 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%5]) with mapi id 15.20.8699.026; Thu, 22 May 2025
 02:57:26 +0000
From: Parav Pandit <parav@nvidia.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "NBU-Contact-Li Rongqing
 (EXTERNAL)" <lirongqing@baidu.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>, Israel Rukshin <israelr@nvidia.com>
Subject: RE: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Topic: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Index: AQHbyhrdL96Oqawka0G+Ryv5JzR6PLPdLOKAgADGdwA=
Date: Thu, 22 May 2025 02:57:25 +0000
Message-ID:
 <CY8PR12MB7195DE1F8F11675CD2584D22DC99A@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250521062744.1361774-1-parav@nvidia.com>
 <20250521145635.GA120766@fedora>
In-Reply-To: <20250521145635.GA120766@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|MW4PR12MB5668:EE_
x-ms-office365-filtering-correlation-id: 4982daf5-6541-46ca-06f6-08dd98dc61fc
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1t9nVrrvtwM2Q4mdaniCXrYZ4hARJfMoa2tyAd5NfPPa+r0MNCzKCMfVuF0w?=
 =?us-ascii?Q?JeN3ynCxM/kgq7FAV7tRNM/AaJF8rRVjbWv0pBWtsrHEbrJnvRVoK52srHEc?=
 =?us-ascii?Q?R0OvnJ7JG7uy/ctI9f2KlqRcqMpGhQ5H0FYdHeHhBUnJiwYYLMyM0p+dGYo2?=
 =?us-ascii?Q?W06/d53EtgUfyEUKmYAFgfJkM6BXAHlTqvcU0BZrn8UBiwp3lGx9pw+48OTR?=
 =?us-ascii?Q?CLlfs+nwqNnkUfHesIH44g72d7VUStYDX7aV8On73/gywDCNyTQ+NcJ0GNeE?=
 =?us-ascii?Q?1LeoauD68xwjHujymYQqn0Y+gdZSzAfxS/xiMx/QJbr2vpDjzhNVGL9huj6p?=
 =?us-ascii?Q?ZPpkTxBN9Dy8bLDu5ja4t67ivgBYoL7+TZXxupm5hSEWAoe1bJ84qJoPewFy?=
 =?us-ascii?Q?FHKygDZ1/+our0ntqrbyfKcxGse7Ka4oC7CUhOjji2lXw1NiYDTa2AUusEJ5?=
 =?us-ascii?Q?fB03XnJ/jf7Pm2ObwskXu8PvLmjEs3X2+wEHdLV8IMLspl+kADHeTQfrjlQ9?=
 =?us-ascii?Q?LSXNu1H4tMkrmnSmd6r3MgeZQMCb4OacuoxO7ruX3FrZPziHiqkO1Nhhr8Bt?=
 =?us-ascii?Q?MkiKlN3ynrlrNsp1JLcidWx/64k07I2kxKJtbd30neGgc8LQ+qGZNpBjK3UL?=
 =?us-ascii?Q?3QSWrPo7/Mqx34Oct+69WvmpMKlnP5B/jLGPbNa7BlVCFxjOYTsGJvAWqZtJ?=
 =?us-ascii?Q?ZsY6f5GLQ2E2dg83I0U+kGSiXjdve7mEDggQqzIQOcwf0moA3OMHHgIVCI+t?=
 =?us-ascii?Q?azSfn0dUxTBxqbTAdkKe2stkMERj4BkMWzfELGmDI3G1RjhKWDtYg04esItt?=
 =?us-ascii?Q?+IwcrmhAqjfb3FGXozhgt4h91LRfG4N+0fvTtNXbpP5Zvs8disHt59zPfRpd?=
 =?us-ascii?Q?v1Vd9zaj8eYFFSKVQ3IUY3zkJ+INKNi+BgAO/9byp7snyJIDHUQe5kRMn/lD?=
 =?us-ascii?Q?yuD+aaq1bv0in1uChTaiExfniebmlttEgn5elpkAS5mCSagRm+D7zVqecu+O?=
 =?us-ascii?Q?rvwWmxdTGiii7c6P6okCUAm1wjbHX7EZopgxtNmKaJoa3Ze7mHhvJHkn4DKd?=
 =?us-ascii?Q?MGkJi3Q02B7Hb0fAFGvVjUedqmegOImnU3Wx0HgzmYT4BY8aHrQk1+Ce45c8?=
 =?us-ascii?Q?JLgvW6KdQIlaLiFthEr1BuFEXYgkFa4c7kpyhVJgArCeuhvJfG6Ow0GmeafH?=
 =?us-ascii?Q?6tveOjNSEcO+mbM5k2kz+8pC7mBiybRWLcoF5outsDqpQRTWGQ1I3MMnTSZG?=
 =?us-ascii?Q?S9Akm9Df07ozT5aUOtrISAjc61vKHKmbs8vZ0NlXmIXkzRMce3go/Tk0Wl6k?=
 =?us-ascii?Q?hzbfYt8xfeWXfnsBESCz3pA+1RDdnexn8vfV6D+YVcs+tI1O3CgeYhnifM3j?=
 =?us-ascii?Q?CnG5JQQFYv25nFN1d4++kvFzC9lmvV9KRgC7d4J9Nw79urKZlJQxvXpd+FDI?=
 =?us-ascii?Q?91/PTRDbX0GzPBhiZLn7oz6/J8fyfJ4we74kA1QWHk5Hn0Jtyh/ym/k6v4PK?=
 =?us-ascii?Q?L783SHmeryNxf54=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YHJcOQdhEJ97F3QnqJwRdhwJ+yFZKW6/wWYftU78crqiKco2vL9LkcJLvKRi?=
 =?us-ascii?Q?YObxdarrFpz68l+xoCDHkSbIkv6dyxFYlENHxUmFmy9XqqokDBXqutT1khnf?=
 =?us-ascii?Q?S6YeA6XDsKPu94FQw/2+WOWuEgyx4GWJHyy0cP0QdCCR7fndMKNGSDzVdfT2?=
 =?us-ascii?Q?8+z/eSOSALpGaG9uGVq2uPmcUIj7sTYZbXp4MCDgw4psV4jPgY9idL0NL5k2?=
 =?us-ascii?Q?cvgzs/FswOZ6bL6DTc4SQge6hbQA91r+nYV+qhz5U2fmgQMnQbeFzCXjf6gS?=
 =?us-ascii?Q?GU7fMi+JkriwvkkMqOoLNwsL/3wG4z3YL77lYEQQ5kpSvQR7f0S1RJExslzj?=
 =?us-ascii?Q?RiBIPjgTuTKbMLYlcYmr5fsPjmhUXYm2qwD1ptj9bzld5l3/KhC+aT/Zydkx?=
 =?us-ascii?Q?Dh5ASNiVMqc7zGcnU8245aZ/Bctc5sx2WzT112ZabNFX1uxXFkmpnhMPx9k6?=
 =?us-ascii?Q?FgNzeu6oZ0TPPknc6n+vhq69LBT/TFaFlv3TPX6CH0IbQBzvcTUAp06OGef/?=
 =?us-ascii?Q?o3cwbiZwi8lVz4hsPkWWowuNdNdXyFlFkMGuSwZf3zjgBJyHBvK39Ryn+oWm?=
 =?us-ascii?Q?ub4IAXdBcVCZ5CojR2j5OFEbT1ZhUblKKQn18GkakOTh3q9W47vA201vBeDB?=
 =?us-ascii?Q?gP3wRFhiDKsGJwzlkewuEIDM5/BJ8+2tBP5Kewh+bgSvaMhNXFsMzxjR5SX3?=
 =?us-ascii?Q?+gnF6E9YdGUNoUUwGlea6SNx+1wP9BZpK2qJYfNm43xjQVRZfj0qf0kxFA3M?=
 =?us-ascii?Q?7t3gviAnIhtDDazlZHlk/bLEcBqzKEEGHOZE0dxGIooyXftoD+2ck+pO6YN+?=
 =?us-ascii?Q?ea+lXo2JgnWGJCnr2B0Nc26hHLaOwPJ1hO4un4a9UXYckT03XnT5DAfNdKHM?=
 =?us-ascii?Q?MbtaSC032LxF1WVX0/TOzzybr0yMFbth4YVXMYe3d4vQgC2AqL1byD7//Hq4?=
 =?us-ascii?Q?eaAStYNO2Uwr3VvpCMXiXlVBYg8eHGElHHImLQgjZrkBF/ORxSWNP8IhGouj?=
 =?us-ascii?Q?qvMX6BrRI019o6vIXqttTzEByj4Nr37JmRk+2kLBZqIbUQ4ha5u295qKP+Dv?=
 =?us-ascii?Q?eKNC3QerF7kSIhcKZbodk7mRsLf9JgLLKTIEvQha2oAPHRMZnp0N1V5cFrll?=
 =?us-ascii?Q?ryE4MTkmrXlDJT05ipxNplOyNXYGUzdb60wzP/bdPB2Kdd7LTZnpZYpE/QHo?=
 =?us-ascii?Q?QNL+eX0fixPvdm2/0Jsvv54iHXE5wX8GD+1iJgFJWQwW7eIGt+2Xy5jwlPAd?=
 =?us-ascii?Q?bTaW2Mql3GOtJlmVN1sxXabh7D2sHxWs7fPEzHFKjpcE2wqjtmf9tPvpRzBK?=
 =?us-ascii?Q?WIdDcoDOcRjxqNCBS6+JHUss83lNk/IZ8RMYqe3YOpXA9H/8y50deWJMxKIM?=
 =?us-ascii?Q?qKZItdsgO+iTmgOI4p+3jkSitBHAT4mjRMMUKiuVoKi9l4A/VbBfjFVMFqkL?=
 =?us-ascii?Q?TAFgpJsT0UEMz4WTKeiUDrkOhojyCBmcNdwNh/Buc1z6HebWbLTbLKWhAjcs?=
 =?us-ascii?Q?m9+tMESHg2yiMMIxrwORHX2/vQOALAm2NjhaGLrp0ohtLWcvLyFXu9Pu9rMC?=
 =?us-ascii?Q?jcDfsUO2ZMbrfnSZVgY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4982daf5-6541-46ca-06f6-08dd98dc61fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 02:57:26.0280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +aUZNEYGy6IZkzTY6mk9YDNkraJd6raIhCvUcLZHZsLYsNzyfp5dyc4ak/XOn6OeTrYYIqQ9ZGbCQardXhHowQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5668



> From: Stefan Hajnoczi <stefanha@redhat.com>
> Sent: Wednesday, May 21, 2025 8:27 PM
>=20
> On Wed, May 21, 2025 at 06:37:41AM +0000, Parav Pandit wrote:
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
> > Reported-by: lirongqing@baidu.com
> > Closes:
> > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b474
> > 1@baidu.com/
> > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> > changelog:
> > v0->v1:
> > - Fixed comments from Stefan to rename a cleanup function
> > - Improved logic for handling any outstanding requests
> >   in bio layer
> > - improved cancel callback to sync with ongoing done()
> >
> > ---
> >  drivers/block/virtio_blk.c | 95
> > ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 95 insertions(+)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 7cffea01d868..5212afdbd3c7 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -435,6 +435,13 @@ static blk_status_t virtio_queue_rq(struct
> blk_mq_hw_ctx *hctx,
> >  	blk_status_t status;
> >  	int err;
> >
> > +	/* Immediately fail all incoming requests if the vq is broken.
> > +	 * Once the queue is unquiesced, upper block layer flushes any
> pending
> > +	 * queued requests; fail them right away.
> > +	 */
> > +	if (unlikely(virtqueue_is_broken(vblk->vqs[qid].vq)))
> > +		return BLK_STS_IOERR;
> > +
> >  	status =3D virtblk_prep_rq(hctx, vblk, req, vbr);
> >  	if (unlikely(status))
> >  		return status;
> > @@ -508,6 +515,11 @@ static void virtio_queue_rqs(struct rq_list *rqlis=
t)
> >  	while ((req =3D rq_list_pop(rqlist))) {
> >  		struct virtio_blk_vq *this_vq =3D get_virtio_blk_vq(req-
> >mq_hctx);
> >
> > +		if (unlikely(virtqueue_is_broken(this_vq->vq))) {
> > +			rq_list_add_tail(&requeue_list, req);
> > +			continue;
> > +		}
> > +
> >  		if (vq && vq !=3D this_vq)
> >  			virtblk_add_req_batch(vq, &submit_list);
> >  		vq =3D this_vq;
> > @@ -1554,6 +1566,87 @@ static int virtblk_probe(struct virtio_device
> *vdev)
> >  	return err;
> >  }
> >
> > +static bool virtblk_request_cancel(struct request *rq, void *data) {
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
> > +static void virtblk_broken_device_cleanup(struct virtio_blk *vblk) {
> > +	struct request_queue *q =3D vblk->disk->queue;
> > +
> > +	if (!virtqueue_is_broken(vblk->vqs[0].vq))
> > +		return;
>=20
> Can a subset of virtqueues be broken? If so, then this code doesn't handl=
e it.
On device removal all the VQs are broken. This check only uses a VQ to deci=
de on.
In future may be more elaborate API to have virtio_dev_broken() can be adde=
d.
Prefer to keep this patch without extending many APIs given it has Fixes ta=
g.

>=20
> > +
> > +	/* Start freezing the queue, so that new requests keeps waitng at
> > +the
>=20
> s/waitng/waiting/
>=20
Ack.

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
> > +vblk);
>=20
> Although virtio_synchronize_cbs() was called, a broken/malicious device c=
an
> still raise IRQs. Would that lead to use-after-free or similar undefined
> behavior for requests that have been submitted to the device?
>
It shouldn't because vring_interrupt() also checks for the broken VQ before=
 invoking the _done().
Once the VQ is broken and even if _done() is invoked, it wont progress furt=
her on get_buf().
And VQs are freed later in del_vq() after the device is reset as you sugges=
ted.
=20
> It seems safer to reset the device before marking the requests as failed.
>=20
Such addition should be avoided because when the device is surprise removed=
, even reset will not complete.

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
> >  	struct virtio_blk *vblk =3D vdev->priv; @@ -1561,6 +1654,8 @@ static
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
> >
