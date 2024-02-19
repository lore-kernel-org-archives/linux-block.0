Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B9F28DA7;
	Mon, 19 Feb 2024 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339181; cv=fail; b=bcwGkJMT74RCAh3VG19evytd6ar6/ZqMGAKCoAtm3NKXJcOsCDfRVedL9zzRxlFHJYIumi4LmWSrDE7FPa91lQ6qSXAwjqM/4SIhj33emezR/5bZMVt4bt2mm1++cetkIZ+LrkazwVvc3UhCYT05ZkmrrWiIzTOrT0bI3EGsSFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339181; c=relaxed/simple;
	bh=sYw3ur/AyattY4Gdny74Kapo5wSeVUf7OnRBlXhZJno=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=shRVhLtccmpSsxlh1KtiZhPJEBvSy3f4g8iQMgcZcLhQLzjDkmfYlcJ6B1KSmK2WvB4593O2ZcWJ9sGwWYhufgFhkhAGI5DMofooqJHxvA6q3dLMmc96ZZByJvYQjOCaEMN7b7L1vLKZPlrkufVJms4h7Y2QkUtJ45eqeDe7X7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JtKuPj6v; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JtKuPj6v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMpo58RUN0Li6P4OzQWkdWCKjf+z7IY3ulYlbezVipjTuHWYy7vPaWzLhS9MX7zCzz0atu7SJIQ9jjP/+aWRuP5gCZursSy7Yh0uvHhX3T9RWUI9Z+zwSJN4ku1dKQqG/5V05U16bMZgGGo3mJJYaH7qqtnJLUboY++gYa6MjiOKj1r1J8K9iAy8knrUESYCpoa6RPzp1HfTA/pmH7LK5S67ClsR49737I4Ago6uKE9Nmp4DJDh5bfD7nFmLJUUKNTcBV3JqmV5by9OAJnsfPRVgB4jBIiTcKHLu4wOEYFGR+Ms/KrNKoO3KWj6VtSskQZy/MyUk1gPA74U6MK+SXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbVWgZaBkobR3zPeL2oESBZ8eAaoGvK9lRwUTf5UzXA=;
 b=jBAa16FXXKxsogRH0GO0scsWiK4fhhA6/lltyXoUoiLmNFwDhScII9/X1RCVQEuE1Fm9aE91tKV3ZKevZ2xXybDF9OvGlG6Ut01UqyTS7cm0kK2UBeJoUIdJADd1n2Wb0r3kXx+8O752HvoiCJHVnEwaVyBSnkI/S0osyTqipsddi8ovcPbtOFEEX7R39f3utN/JsKXTWAIOw+H2R4bt8MsKNCAqFyYTSKQQAizaulFlxrL1rgAoYuGvus9gRbhbadGi0Z8N2UGhpe4S0zoW5XdoZXQablnNyMmscEPOGK/oZ7RysMHa0sCopur3naXyjTWLrpRjjp4dHaGkXMmj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbVWgZaBkobR3zPeL2oESBZ8eAaoGvK9lRwUTf5UzXA=;
 b=JtKuPj6vmsCAefnuQWmBCkLi4yx85p3nS+xWLLg9GIeproCnG5pm+YM3te3bpvNtwkGHgeS2Hwx6ErH2qUgNiZePNr4uu1NdPs3WDG7+yvsPm6mwiib9xEVj3CeJx4+53rW+stpFy68cQE+W+F7/wungfiKE0mw1mPOgQ+7X7dm/BJ7AJXvUpaxl2Zqayz0/R1/7IJQwK6Ouqt0GCli65uLNnvcvwHimTtSJtHQGAXktSc/R2XIUOkppQ858twZP1ki9c8v34tIjzuub6/BmqxS6MTYvkCLbOKTohHtpQH8A6Zhblqm81D3oa6uWmuDwofVU4or9Ho1yehZ4SBfIwg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 10:39:36 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5b85:d575:fac1:71c0]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5b85:d575:fac1:71c0%4]) with mapi id 15.20.7316.016; Mon, 19 Feb 2024
 10:39:36 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Ming Lei <ming.lei@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "NBU-Contact-Li Rongqing (EXTERNAL)"
	<lirongqing@baidu.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: RE: [PATCH] virtio_blk: Fix device surprise removal
Thread-Topic: [PATCH] virtio_blk: Fix device surprise removal
Thread-Index: AQHaYcxqVM2rFvg5t0SfQayLG6csArEQGLcAgADkkjCAAFazAIAAJn9Q
Date: Mon, 19 Feb 2024 10:39:36 +0000
Message-ID:
 <PH0PR12MB548151B646CDE618F71DDAFEDC512@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240217180848.241068-1-parav@nvidia.com>
 <ZdIFpqa23YHwJACh@fedora>
 <PH0PR12MB5481DCCE8127FB12C24EF74DDC512@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20240219024301-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240219024301-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5120:EE_
x-ms-office365-filtering-correlation-id: ff2df801-83a0-4610-8281-08dc31371165
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uU/qPSB8vNlFlduQCoxxT0mBUn3GJf8TooA6pOwxKJG7irjFlfRbIcZqL/KOhe9wWRKw8juJy0mP86icvnH4uGZQzgOlaURI9de6fzeh64wZ5st0fl+/k+p8ponX5HYiqb9/fRYdnkXaA2qqGPOfZ9C5YTqufFFwI/O39Cto44hkW+4zN8gCg036LeYPDwehJO1WGS+0K/AbMfa/oXS9UEm333MCwWEL9VcvemXu8h7BMcAjF61rq9cUg0pWJ2em/9LgznYdBFX7AGsbhuzRfey/iQSEvKOyejMiKwrQ5gZgNnxTvFIJZl4DsKfFQL2FZp34f3IAsveRX7XqIqam8DSXDENt93NXx2OtFkFHTTjFXW2VoEJFG+BxC7QFIV3pNrcUXijyuAfxbdxw5uGoTH7UeiSc/M81OlRc66GS4bWPQaD/xBIsHTTrSrFz5qXvEQ+WjvzvppL1zu0ADdEdGDbgFFlvz+5Rz+DSw7A6gT+aegmr0qA+FNXJNDQaJ4fWmEdj2egAcqra/zbjUD+djDeNk51bO0bBKnlzHCm+M3SntxhLBQlJYmOuPuC1UIaOy/fbwBSm5hvynaATIFlhCUHL8IGiS3Anfo60/BolG1o8GUeBTwFMAHIFywkUMMzHE8tLXPJ1g4nzH3oovvp3P+wn1LCoD7c8C+9scE4P29g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Of++sVARsIrRD777+yTzEKVaxn6lY/Yk+4kTYuiu1dt58BHzSiwLOjtEI8g0?=
 =?us-ascii?Q?6ct1riwLF5b0ypv7yeOSq3SzUEOazV/T8CoU0hMX8gwtviB/q9s7krv4DhnN?=
 =?us-ascii?Q?YTTLZ3BfR3buxzPkht3Fa2eRXHtbxneFJ8jvpgT/odFsjR8sjYGfdF54nJPB?=
 =?us-ascii?Q?2LbrLJAGdSti4t2YKOBw8T43KpQ5iNE8koyKVtJKyi+xZVlsqYGqHjjHf2bq?=
 =?us-ascii?Q?wInc5bqFS31J3xYioCg/TY9IJ+ggy7LBDqc98I+YyYZwVXyCZGI1WhgbJOj7?=
 =?us-ascii?Q?pDUYYQ1PS/52/upx3FQTBQQIuQ6W4MHaDoabmdsHeLNeB7psYCNWCDROKSr+?=
 =?us-ascii?Q?7ySmfBaunvihlcSreqQRvy40swfmy3UOLC2aNEH3jIqzi8QVqD2ZM3sEPN7w?=
 =?us-ascii?Q?BRLHYNKnpkmIcXeJcbM+bR6eFDju3wM+PS2707y0kqY8lo9EaY/zNdFB+qds?=
 =?us-ascii?Q?LmnQMGtzIRKyzTGoqGMpBoBHiMzDtXuzGqtxQIZnBgQyerVC2rjTUABzRC4j?=
 =?us-ascii?Q?IuCjOXj6p3l1N4EWvbpv4+KZl4/UIz7XnagNRsAAO47cebmBQhmKbQr6KyEY?=
 =?us-ascii?Q?GpEX+JFzxdAFnApiY85ePpZzLEd3VKZhAwJSK7nanmvqxx6enRuKAkAQQW0D?=
 =?us-ascii?Q?yB0jpNW6LJxlqDFVXTyBCYwuuVx0LwarEd5uE72jjJKJ8kXiKJ3ogIy7nd0H?=
 =?us-ascii?Q?tfqhbu0zXIL4lvWvUDfvjiEsV5nB9QQ61zUYQWYoaUc5qhf50vLXiZseFcfy?=
 =?us-ascii?Q?zVLXIiLOfh7Ug2cD9MF+PdIStolEL5ZZ4xZV4V1SUo1zIQluxj5TNgBG3bTI?=
 =?us-ascii?Q?7kpWh38rx4yH7C+RYMpEt595oZM3dZXKsxllQVwrXh1qe+dZ+pN5cMOq3JAy?=
 =?us-ascii?Q?tw/VerPzlfCs+pQ+5Eakxepz67YPniRtiNiMeKg5Dzwqtr7wI3no/JBKrCN/?=
 =?us-ascii?Q?DM7WH4/mePsXP201UFn3Hks1EatsG7EZ42Pm297batP/HKyNvX3vhHUnPII0?=
 =?us-ascii?Q?7lh2CrqUUT8t72urd/AxOSxu5t+GN6beFE0kmHPO907KNMRLhMhNJ9En5OCc?=
 =?us-ascii?Q?xn2jfNdFmZ9f4fVtuT7YqDxIMd25C1decH+wGtcPTikLMNT0qNOGBgt2ZDtF?=
 =?us-ascii?Q?ZI1r99p5bXr8O6Dx/jBRcSxJQNJY3Nc2EjHZemb19wSN0m7LY9roDLQP9IUW?=
 =?us-ascii?Q?cC8XYvBDUbREs/HE844oV5tK38HrYB20l/PFRo48bQ8xbeNvIbXUfIDFIeLy?=
 =?us-ascii?Q?6A4H3lYV2wSvoAPTSQTpWxalAUCuFe5t3qFh1dgmjaqzjQJGcj2MSAfOqFxd?=
 =?us-ascii?Q?iP0Ox/YLN+VUKMsJuB1YPmzGyBrF9wqgXiUu5GvUUv3ZUmg1aIv8xfro9vDi?=
 =?us-ascii?Q?C7FyEmviLWCbnIj3LYasNDA2SQdxhNCQnqP3CSYeMt8mavk8VM4hbr/PpVYP?=
 =?us-ascii?Q?h28y5+8lDTaD1Y3ef5/GXjylJ/rUW/TCbtrS8nAwiu7jzmXCvd1bJxUCXEf4?=
 =?us-ascii?Q?qJrY/6QjR+Ny2ULASbIBUF7qrWqRB/AeS7lyw02JCfAjaOAjxzqB/u4zFWof?=
 =?us-ascii?Q?ng4NeY64UJpB1Kvxbws=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2df801-83a0-4610-8281-08dc31371165
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 10:39:36.4024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gWFZYux4FO8mcJq4AALJV3oW1pnvqrW1bbVQidgs7i7UH7/8dHyFraI2ZqZDiQQwEUPEzRCfLtEnn1lYWlT4qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, February 19, 2024 1:45 PM
>=20
> On Mon, Feb 19, 2024 at 03:14:54AM +0000, Parav Pandit wrote:
> > Hi Ming,
> >
> > > From: Ming Lei <ming.lei@redhat.com>
> > > Sent: Sunday, February 18, 2024 6:57 PM
> > >
> > > On Sat, Feb 17, 2024 at 08:08:48PM +0200, Parav Pandit wrote:
> > > > When the PCI device is surprise removed, requests won't complete
> > > > from the device. These IOs are never completed and disk deletion
> > > > hangs indefinitely.
> > > >
> > > > Fix it by aborting the IOs which the device will never complete
> > > > when the VQ is broken.
> > > >
> > > > With this fix now fio completes swiftly.
> > > > An alternative of IO timeout has been considered, however when the
> > > > driver knows about unresponsive block device, swiftly clearing
> > > > them enables users and upper layers to react quickly.
> > > >
> > > > Verified with multiple device unplug cycles with pending IOs in
> > > > virtio used ring and some pending with device.
> > > >
> > > > In future instead of VQ broken, a more elegant method can be used.
> > > > At the moment the patch is kept to its minimal changes given its
> > > > urgency to fix broken kernels.
> > > >
> > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > > > virtio pci device")
> > > > Cc: stable@vger.kernel.org
> > > > Reported-by: lirongqing@baidu.com
> > > > Closes:
> > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9
> > > > b474
> > > > 1@baidu.com/
> > > > Co-developed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > > Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > ---
> > > >  drivers/block/virtio_blk.c | 54
> > > > ++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 54 insertions(+)
> > > >
> > > > diff --git a/drivers/block/virtio_blk.c
> > > > b/drivers/block/virtio_blk.c index 2bf14a0e2815..59b49899b229
> > > > 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -1562,10 +1562,64 @@ static int virtblk_probe(struct
> > > > virtio_device
> > > *vdev)
> > > >  	return err;
> > > >  }
> > > >
> > > > +static bool virtblk_cancel_request(struct request *rq, void *data)=
 {
> > > > +	struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(rq);
> > > > +
> > > > +	vbr->in_hdr.status =3D VIRTIO_BLK_S_IOERR;
> > > > +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> > > > +		blk_mq_complete_request(rq);
> > > > +
> > > > +	return true;
> > > > +}
> > > > +
> > > > +static void virtblk_cleanup_reqs(struct virtio_blk *vblk) {
> > > > +	struct virtio_blk_vq *blk_vq;
> > > > +	struct request_queue *q;
> > > > +	struct virtqueue *vq;
> > > > +	unsigned long flags;
> > > > +	int i;
> > > > +
> > > > +	vq =3D vblk->vqs[0].vq;
> > > > +	if (!virtqueue_is_broken(vq))
> > > > +		return;
> > > > +
> > >
> > > What if the surprise happens after the above check?
> > >
> > >
> > In that small timing window, the race still exists.
> >
> > I think, blk_mq_quiesce_queue(q); should move up before cleanup_reqs()
> regardless of surprise case along with other below changes.
> >
> > Additionally, for non-surprise case, better to have a graceful timeout =
to
> complete already queued requests.
> > In absence of timeout scheme for this regression, shall we only complet=
e the
> requests which the device has already completed (instead of waiting for t=
he
> grace time)?
> > There was past work from Chaitanaya, for the graceful timeout.
> >
> > The sequence for the fix I have in mind is:
> > 1. quiesce the queue
> > 2. complete all requests which has completed, with its status 3. stop
> > the transport (queues) 4. complete remaining pending requests with
> > error status
> >
> > This should work regardless of surprise case.
> > An additional/optional graceful timeout on non-surprise case can be hel=
pful
> for #2.
> >
> > WDYT?
>=20
> All this is unnecessarily hard for drivers... I am thinking maybe after w=
e set
> broken we should go ahead and invoke all callbacks.=20

Yes, #2 is about invoking the callbacks.

The issue is not with setting the flag broken. As Ming pointed, the issue i=
s : we may miss setting the broken.

Without graceful time out it is straight forward code, just rearrangement o=
f APIs in this patch with existing code.

The question is : it is really if we really care for that grace period when=
 the device or driver is already on its exit path and VQ is not broken.
If we don't wait for the request in progress, is it ok?


> interrupt handling core is not making it easy for us - we must disable re=
al
> interrupts if we do, and in the past we failed to do it.
> See e.g.
>=20
>=20
> commit eb4cecb453a19b34d5454b49532e09e9cb0c1529
> Author: Jason Wang <jasowang@redhat.com>
> Date:   Wed Mar 23 11:15:24 2022 +0800
>=20
>     Revert "virtio_pci: harden MSI-X interrupts"
>=20
>     This reverts commit 9e35276a5344f74d4a3600fc4100b3dd251d5c56.
> Issue
>     were reported for the drivers that are using affinity managed IRQ
>     where manually toggling IRQ status is not expected. And we forget to
>     enable the interrupts in the restore path as well.
>=20
>     In the future, we will rework on the interrupt hardening.
>=20
>     Fixes: 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")
>=20
>=20
>=20
> If someone can figure out a way to make toggling interrupt state play nic=
e with
> affinity managed interrupts, that would solve a host of issues I feel.
>=20
>=20
>=20
> > > Thanks,
> > > Ming

