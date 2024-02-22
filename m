Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B24522F;
	Thu, 22 Feb 2024 04:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708577203; cv=fail; b=qRB4rLtuk0OyR3W9D8FcIKE8IcYDQiC6TKcza8fGnVULOg4A2a/IhWuEqqPlErxddpWVhHPyI+JISX20nPC3hj9Nlyru8y+3pZ2bYXt2hzmPjLn7DwI7aZILoee6pJ0KfUycL5Rfkrk1xci5hmtMrq6rgaSSnCdDuGFnzTRjIcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708577203; c=relaxed/simple;
	bh=4KQFg1U3omtfoGrBhW/HuakxDlrV86AoUMDfYsN12vk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YBI/uTQ3/YOw4SpWRb4RdwMAgf1UfnTEZx7c8CsPJi9hpmlsGFH6463vVSyoMtbI4lR4i6zk24UFNvXrW625oWlExg73be83Vt/lBLTg5qL8FGIfEHDcF/CAjFE/pYOBf7fgFel562KzzDQEiUILgMO+jaxjTh1vETQC8eCbo9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GEn8F1nF; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GEn8F1nF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4LzvXL04ZaCZrcfkMFg1Dtnf5PSARoQ9jSPLc+VmKcItjcYDp0XHxL4xPpNyJ8fR09Kbj8aIKbV2oMv1/n6irphLjh/6NXvKaj3qUkftV9zh4d4H9xIaYYuvNqhAQ+rIUDh4WFTsJE1ZccMlgwaPDOF8YV35IPZjASo0NKPq8UfpDUTuYCXo10wcufkIKDiOzUjC7sktONf9OaQf3obXnPm6jyl+3oetmneUK8atO3zx/HkvkSdwnVRWdnSPkxLTZrKzH/77VbJ4oT95j52RaJRPt7jUUZ9b5g5sOyUHVgaxqCVCmaHwDbKkZIu91cUWI91u7/b0bEpnZ84UXninA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EO4MEldUXUkAONf5spMaiQJCa4i1xQ/UkMncw39JlE=;
 b=hh/ZMCnM7/MXd2COVfwW6I8ATIAj7yXQmL9ecW6W8lLiyztNimOT4K/fwWHt1sLOLHhrrg1lXlt1IRm2dUPn5A2kXSHR2aXuSUYGyXr61WRruN2YPMQXx8pLrVv6QQWkDGzm4yyt5GE6BldJIVAQTfgaAL9pirvCsSbraVOVKWVd4hhFzPT1rhbP1fvsjDgB3T40s5BETuEyj/5Lad8Pk6u5MKiirXy/zanz8nLUcauo9cnBh28fhok85c23ZKlKLQ03lUoI6wgAL73uKro3PgBxwi2aAIenIhmJxuCtBZD1NZRD/rKf8qxJuBiRQekmsxDbDpdxMUNXLFz2ghcv4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EO4MEldUXUkAONf5spMaiQJCa4i1xQ/UkMncw39JlE=;
 b=GEn8F1nFZHqJARZ9LW6ntUBAfdR94nM7VwPBhS2DKRpoCBQxYZyZPPQNV1X0f/JreGqlxTLG6FTSU4ROOwNM+shxq1vNUIoH494/hFYWXbZdzMUbwUHYQFC9R/25Mzt5DyiilZNhA7b/T/ODjVQf3IYsYYoqs2OQKdep+jkdT/ike5IZnAvUob9OMHjUWZv411mNhDc7PL5AQ4I5a1vlRxt0qCLIJY3Sxodn9epav1LiWNJfWh0r5pZa5SrkwNlcOmW4w8SdB1eGfAn7OtBM6Uz3298I1ghVZZZ2a/r3ivze3Cdwi7uMCpvlkCToI/PXRZXVl5C8idg71ohoKM7vaA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 04:46:39 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5b85:d575:fac1:71c0]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5b85:d575:fac1:71c0%4]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 04:46:38 +0000
From: Parav Pandit <parav@nvidia.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "NBU-Contact-Li Rongqing (EXTERNAL)"
	<lirongqing@baidu.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: RE: [PATCH] virtio_blk: Fix device surprise removal
Thread-Topic: [PATCH] virtio_blk: Fix device surprise removal
Thread-Index: AQHaYcxqVM2rFvg5t0SfQayLG6csArETzhqAgAIBqsA=
Date: Thu, 22 Feb 2024 04:46:38 +0000
Message-ID:
 <PH0PR12MB54812D3772181FEAA46054BEDC562@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240217180848.241068-1-parav@nvidia.com>
 <20240220220501.GA1515311@fedora>
In-Reply-To: <20240220220501.GA1515311@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CO6PR12MB5443:EE_
x-ms-office365-filtering-correlation-id: 71a76432-5ccd-43d7-d144-08dc3361419e
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 u9kKUrHmTmnYO/pAi+XqpUWCWZvWI+1wriXn0rwpDacpIhLk3NWr4t7mLQFeVKbHd0luCTLscgmPkWZNhOhHFA1GrlrS5ElhlW86TlNogEpoCIWQuIEaFnnVzwsWB8rq1kmqgUqax7tF/FXQFFJhiUls0GAtpAobv7Mg9+Q1PP5xBaNR7vJY8g53BSzZ6it2lOTHO77g6DqQ/Hpx5K+GVTGcWbZ6mB/in1Kf1WLxb75Ksi1tJE/b+zpzhRHHLqyXlAbjHZXvGGTYoAVzHOLg2U4aJHTmIC/Xm5hNo1/2ikDZix8FxA/ibVbei+OLPkULSebDh955LfR3BaN2v1wymQzKCgZfsZ5UHpBmJp4Sb0+T9nvhRgHFsVNQPlB07/pCVs5+PuNRwv75eVLuJsiM7LZCpA4YRr8Ce1jCaCkQkSxNy8JqLtV2h35jV43QYKE72t6cKn9ZnBt5pC6uhvveFuq+mQYjir+JBtTzdZrq1oRHZ7OTug49WPEDKobteXuutSghB3Exs3wFN4A1sFkkci31V6PVo57W+2foZAqyZHCVNAI4b01BPSHhrBsHz+kcWUP8cPCSUyqU4Dqbstn/w+WNQ+XODJKrZiriYj6UASj9ZWybX2JfLhV3XxLh5dy9t7AGS8+ygOqQuIX8xbUxkhdZrt4qRbdGMIw0ZBAioCY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6x1TA0/xLFrL3VTmw6WEV+wGeaXGNYvUFZPPNqTi1e/RtYAAM7kZJ8uG27is?=
 =?us-ascii?Q?lTzCiWDymRfA9PfusyeM1VWyLO5hSV5OHioUL6a4ioHAvP5gc0Bt///haLix?=
 =?us-ascii?Q?HFiWRbGFAlBL+P1KwCG9jXlPD7QMpgLkgTvlMOHye3k7WPwZa0GGJJw64gyN?=
 =?us-ascii?Q?z+uJ8yU0oF38We4rG0jrxa1UZ30ciR4KFt+x3CzPvEvx8oPQSX8ip127YNhF?=
 =?us-ascii?Q?FBnrnANG2AQJk4YAOzqfRr6FSEDWWS0hcYOipOj/uot8jB8UhdR64pZ9EzoL?=
 =?us-ascii?Q?eomaFdRtMWYfuSw9jN2l/IepwlSFpjJVbrANcp6zrAfr0inshj2QzGbbvFgb?=
 =?us-ascii?Q?NPweCkd5LbcpfGJf/iXf29W+gbvubc288J/Lapok7sxcFt1Z+MI76nDnVf3h?=
 =?us-ascii?Q?o1f+fak3C1sWjhR5Fh1KLTED728pwLX9xgWi8evR4ppb06jY9wQ1limGMDQD?=
 =?us-ascii?Q?jLBkkHCc+tmG/jEXPANc8Q8ZZpEswZhMfhohMX0xTMPbEdZmpaDhLiQ5G3UF?=
 =?us-ascii?Q?8aNeSIuJSb2PCdUze1l8DqbO0gA79MQRQ2N1ivxXRB8mOkOs+Hhv8XktnT9S?=
 =?us-ascii?Q?a2/YSFCxCtsIWZs98whvZoXeY3cgRM2hLYvQEBdWrL7rXtxs5RnTIvSZw4uP?=
 =?us-ascii?Q?QL8ryyjT1ep1uRYPZzxKAquWV+h601Ci/Rl5GQ5asysf2hWdlsV7/fgirqpx?=
 =?us-ascii?Q?NhyOiu1TW3Tj8Ms+scI7wcCrLqlVOMSEKlkBr2yAWgeCqfoMG+hf0JNGx43l?=
 =?us-ascii?Q?IrqTacS55aE2sWwpnz5QVNWi7lAUKzsBTE1qC8XBkkx3nDlTMdCozU2OeHlm?=
 =?us-ascii?Q?00cUsWo3dxaZn5azk5Yy71gPGP2TP5givcy+haABAQ7G08SipGxMe5lygWwT?=
 =?us-ascii?Q?eLdooYwbmymRu/bDRoansozBPSSvg/IzxeNbA6asIArbX6NX6ekJ1KOlwjq2?=
 =?us-ascii?Q?lHFgXOsO541mXZPKOiuMcnJbnPD/A31WAvkJK1+6DtW/o7/07beVHQHXtazh?=
 =?us-ascii?Q?ctOGHNgnut6J0NPh9OW/a8ZdNIjktwm8RRd30SnJ6BG+88x1vuKx01wsFhrc?=
 =?us-ascii?Q?jZUInPy6ZC12E7voUPAx+TKwvKD/0VXsgtwEeUe0GhRwnGNqrGH/0CjAc2ie?=
 =?us-ascii?Q?Nt5RfzHHt5/p7DL+zbwwwurkrEsymCy5kwzFMQRMmmA3G9X8sGsrujE2fIvw?=
 =?us-ascii?Q?41ZlKBHKQsRDZdRYdBieL9CZamPqUV/yDCi3nBeGHHywX+ji6YxZyX6yWNDa?=
 =?us-ascii?Q?IwV37LoIFQ0zl/gY/zXmuY4ZBAAeQLx1zc4rG/lYrg7lZ2oPuV2JU6+5mqnU?=
 =?us-ascii?Q?03pVpaz987Q5ot6KmjjpuPa59ry2svyhYKAGfj/puN80OgJzrZZWIgdIyxSN?=
 =?us-ascii?Q?n1Clc/N8BspJsePvep7N0jG4xELgPOLqSHnSma/7KHLZ2gdDGjqbjMnsr4m0?=
 =?us-ascii?Q?cdVRux9NtcbbAsFcuLJ/w9pYc2YklSPEyFNFQlEeCqBFbbTDBFwz0rsJTtZ8?=
 =?us-ascii?Q?/WZRFdtGNCUUKyJp7LdEcACriyw7VJYxZy3N1kNh2VErIJznIiCN9Yxhb/Lu?=
 =?us-ascii?Q?ATq2R+Das1FTuU8AiJw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a76432-5ccd-43d7-d144-08dc3361419e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 04:46:38.5049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eW6l899WoB0zb1X3jxLwGIbwpGE0y1GoIUCUd34on9MgOPUPNvLVuY/YD4lf/PCLQTrnve6zo5/8AZ50rw1NXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443



> From: Stefan Hajnoczi <stefanha@redhat.com>
> Sent: Wednesday, February 21, 2024 3:35 AM
> To: Parav Pandit <parav@nvidia.com>
>=20
> On Sat, Feb 17, 2024 at 08:08:48PM +0200, Parav Pandit wrote:
> > When the PCI device is surprise removed, requests won't complete from
> > the device. These IOs are never completed and disk deletion hangs
> > indefinitely.
> >
> > Fix it by aborting the IOs which the device will never complete when
> > the VQ is broken.
> >
> > With this fix now fio completes swiftly.
> > An alternative of IO timeout has been considered, however when the
> > driver knows about unresponsive block device, swiftly clearing them
> > enables users and upper layers to react quickly.
> >
> > Verified with multiple device unplug cycles with pending IOs in virtio
> > used ring and some pending with device.
> >
> > In future instead of VQ broken, a more elegant method can be used. At
> > the moment the patch is kept to its minimal changes given its urgency
> > to fix broken kernels.
> >
> > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio
> > pci device")
> > Cc: stable@vger.kernel.org
> > Reported-by: lirongqing@baidu.com
> > Closes:
> > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b474
> > 1@baidu.com/
> > Co-developed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> >  drivers/block/virtio_blk.c | 54
> > ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 2bf14a0e2815..59b49899b229 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -1562,10 +1562,64 @@ static int virtblk_probe(struct virtio_device
> *vdev)
> >  	return err;
> >  }
> >
> > +static bool virtblk_cancel_request(struct request *rq, void *data) {
> > +	struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(rq);
> > +
> > +	vbr->in_hdr.status =3D VIRTIO_BLK_S_IOERR;
> > +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> > +		blk_mq_complete_request(rq);
> > +
> > +	return true;
> > +}
> > +
> > +static void virtblk_cleanup_reqs(struct virtio_blk *vblk) {
> > +	struct virtio_blk_vq *blk_vq;
> > +	struct request_queue *q;
> > +	struct virtqueue *vq;
> > +	unsigned long flags;
> > +	int i;
> > +
> > +	vq =3D vblk->vqs[0].vq;
> > +	if (!virtqueue_is_broken(vq))
> > +		return;
> > +
> > +	q =3D vblk->disk->queue;
> > +	/* Block upper layer to not get any new requests */
> > +	blk_mq_quiesce_queue(q);
> > +
> > +	for (i =3D 0; i < vblk->num_vqs; i++) {
> > +		blk_vq =3D &vblk->vqs[i];
> > +
> > +		/* Synchronize with any ongoing virtblk_poll() which may be
> > +		 * completing the requests to uppper layer which has already
> > +		 * crossed the broken vq check.
> > +		 */
> > +		spin_lock_irqsave(&blk_vq->lock, flags);
> > +		spin_unlock_irqrestore(&blk_vq->lock, flags);
> > +	}
> > +
> > +	blk_sync_queue(q);
> > +
> > +	/* Complete remaining pending requests with error */
> > +	blk_mq_tagset_busy_iter(&vblk->tag_set, virtblk_cancel_request,
> > +vblk);
>=20
> Interrupts can still occur here. What prevents the race between
> virtblk_cancel_request() and virtblk_request_done()?
>
The PCI device which generates the interrupt is already removed so interrup=
t shouldn't arrive when executing cancel_request.
(This is ignoring the race that Ming pointed out. I am preparing the v1 tha=
t eliminates such condition.)

If there was ongoing virtblk_request_done() is synchronized by the for loop=
 above.

=20
> > +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> > +
> > +	/*
> > +	 * Unblock any pending dispatch I/Os before we destroy device. From
> > +	 * del_gendisk() -> __blk_mark_disk_dead(disk) will set GD_DEAD
> flag,
> > +	 * that will make sure any new I/O from bio_queue_enter() to fail.
> > +	 */
> > +	blk_mq_unquiesce_queue(q);
> > +}
> > +
> >  static void virtblk_remove(struct virtio_device *vdev)  {
> >  	struct virtio_blk *vblk =3D vdev->priv;
> >
> > +	virtblk_cleanup_reqs(vblk);
> > +
> >  	/* Make sure no work handler is accessing the device. */
> >  	flush_work(&vblk->config_work);
> >
> > --
> > 2.34.1
> >
