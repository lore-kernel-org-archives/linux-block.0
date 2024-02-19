Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A222103;
	Mon, 19 Feb 2024 03:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708312500; cv=fail; b=QvbZ+rcup7XFSbXWGv9CmqqB7h4T7o/GYOiv5pV/Qv+sXwEeDin3Ewy+A43ULdaun3sI5f3duYNKx3DHLUfzZPJqerlpPyC7WnaXGgVvSxfIMtWbnaV6+whOGnWAzKysrkkw9OLz2I3EYc00JmAzPwPmNHmrmdzn7HiRLwU1Ml0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708312500; c=relaxed/simple;
	bh=EL13OiB+NYNU1ruf0QI+AGo34/fMOufoZxjalAWs7Ok=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RkJPLCTtcdkhIiowBWQgMddDVFtYkh7+ehrGD8AyPV/y+SjcdsIjn8BpsMfAt4SJtfiYTaKyO923UnLVVIf3QcyIyMqIvxRMHH90zITl9ZAAoa6r+Z5dlkqWpyWFV5ARwR5lxoikydYGLgwH5pYSliqcsa8X9KZuDQOAo995I10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L43vAIZq; arc=fail smtp.client-ip=40.107.100.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L43vAIZq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5rMQWr0iL7/8opKbx4ZRhxwwiWCybRRIPBg9G37kIS3TZRa5k7ZpdX1JJXlIjEyeCqPlU+PXF0iXIOHx288IM8H3hdDbCv+JYCm2SxCy5S+rw5Fbw2v/FkmsxvDRWRvIJArEXjVwdemiF81NQno5kROxIcS1jPDgZU9djUa6B5ezFfNoWPZCrJih8y+b2F67UJTbO/T1MH7A7KDpFv83bdGy6tMLn4VxBALyrOFLtvLDhnVk/g9+BxcNpdam6EcPgxbPE3uNZnH01xsLPzeO+Rk5pOlkexs+x/rpMXtX6lKD1Nv6U0YV/sOzTv/QiOD5Lj34cvyeoFEZf8nmbu7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8H/CHWgq2Ah0vxvrBC/etkmeh63YuvGW3dh7CcHN7A=;
 b=NvR4M32k9ivCI9RfAsBodLFgua3zkGPeEk5Z7oCOG8YTM7PvL1K2xHoLFh3jIdUhoNjmEPWGLk8n9j+ZO1Q3tipPrPDQZwRl1UwkU3QZdgKmz3W5a3Zd7DtSLtN1Jh/XUGSCQAX9UivELWZQxjRfkLVMhWSZZIt5/1PgBwrrlwf+fEyt50VDrYi4xtxvTcYl4wqLsCZbp+0qSgHoX11/k8yCciBCIM4jNHumFAg1+D1zc1rOhH1VCXuU5S0d2UXWgDdy7eJU5sU3qA4AvSpGNVHItJ/vZUEPjOu1BObCa+I0JwkJNYQWAn4gy+p8C5+7SnvB4E3Az2EgFlhOy7Z/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8H/CHWgq2Ah0vxvrBC/etkmeh63YuvGW3dh7CcHN7A=;
 b=L43vAIZqX8871c/JdWReX9WlyyMDrYdcjwoYLDpRSnM9ZIm7z7xVgKYsiqBHzahbVt2Pi7vr3VpPeaEKzxC4yDcolWW5eEC7iH1RByo708UmnOVOLh1Mi6iDUZhBK/W6J1ughwwF3xz4iq7W+389iH+HgX0FlIdaYaexQFbPtrddDATffCZ4FCj6Hm/8iIaUF+tGhrCfVvQ50HlILkID/ZpjJljMA1mLkfVZB6xxQuM5Tq7qZebffxXzu84uxj4abvtTHmvXkLsicgK2o/0reaPsXQrMGdN96d88eCdZBwbnVEp3X0t1PNa309WUNyXx1YkuCtVdsgcTyLwA6gWtsw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SA1PR12MB8161.namprd12.prod.outlook.com (2603:10b6:806:330::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 03:14:54 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5b85:d575:fac1:71c0]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5b85:d575:fac1:71c0%4]) with mapi id 15.20.7316.016; Mon, 19 Feb 2024
 03:14:54 +0000
From: Parav Pandit <parav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
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
Thread-Index: AQHaYcxqVM2rFvg5t0SfQayLG6csArEQGLcAgADkkjA=
Date: Mon, 19 Feb 2024 03:14:54 +0000
Message-ID:
 <PH0PR12MB5481DCCE8127FB12C24EF74DDC512@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240217180848.241068-1-parav@nvidia.com>
 <ZdIFpqa23YHwJACh@fedora>
In-Reply-To: <ZdIFpqa23YHwJACh@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB8161:EE_
x-ms-office365-filtering-correlation-id: 02ee078c-1bba-44c8-125d-08dc30f8f1d3
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 24VyClpD8+bTLb0cYU0/d7ftBEg5xLJTe6cgFvh2GH/X2x6i/Tnh2XChNYLac6NEIeB+bdPILpqQmnGmZxgnyaNmWN8EPQ0i4cKV6XKDsKj12F1FLgW4YbR1Y04BQJ1EadZvijNXkNS16ySPMeTEKU7OzXPm8oWnv1ntfUxoX3TUMFlgkDgRXHPOihJ1jsc7Yc3u4HDVcfYUYakeNSInchrXDZTtI2DIxYSzFpGVmEZGeGMXQVrsn2PmwLkbTu9sB6fzwS9M7uMyRyv9dwYesc/VXTFwpOVarqIaJR0pU4W9clcXBJ5PsdRvuEOCSrtAK0GIvOsirf0r03F1rmor7W+wAR1OBVTuyhWw8uvDUvwB1OXEKCvZBUmBnJNWLG4Qgc/I5253XnA1Klkr3j0w8yASGfpWKm8ariFGCcMiK21YFJ90pHLngHOD/lY8FPqZR4RcDtbN4+Yl1ezeofQKzM/qDaf5CNhe0vElosF+edo1tc55J/zr54hqhxEO/C7z3rFcOgnAcCCP8uUREA5/OWP98505vdigYgR1vczfwgdVBfc+/QXna60VYKg91gYIyEC+LYm4swUHAOrkps45/032grHkeCJ4ecstnJvxezCdzc//a23MvAzJfIsxJaXFMloI4wFwO6XUKZrnKeNaqZigjzSwj/90FnGo8LhWWK4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(346002)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(122000001)(26005)(83380400001)(55016003)(8676002)(7416002)(66946007)(8936002)(76116006)(64756008)(66446008)(66476007)(66556008)(2906002)(4326008)(6916009)(52536014)(6506007)(9686003)(7696005)(316002)(966005)(478600001)(71200400001)(54906003)(33656002)(38070700009)(107886003)(41300700001)(5660300002)(38100700002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?I/zsoDPnPjDmjuY6Jbsxf/UyIzYRmBqQeUz3kBDbwZa/YQL1hgv4hJiLEwSs?=
 =?us-ascii?Q?cyNSFOOtzhtkYH1XnhismxpWCX8ZQXBEx8Td0qw73ZIwQrLV43n23HHfvniV?=
 =?us-ascii?Q?pyyrMjhyGHklaOEty0mRmD/gSAUXiRqSeXbzLYgMeCNKYebzQFa3VBvRQNk7?=
 =?us-ascii?Q?wzALPCBwghVDW40gfDPUNZF9EF24hE+asK2As64ME9JVVuLCU1nyciIBM5hc?=
 =?us-ascii?Q?WjCSXEMCfG3/z2p4spRejUY50S7b4mAhCI2blp5W/uGuUZPJav8St4VaDgkx?=
 =?us-ascii?Q?fKyr6xwviDRFDjVdRTJZeN8NaID4r5nOxtIq0chX5WD2X6Ty54UH3Nv4y0HQ?=
 =?us-ascii?Q?m/ZURAFUWKrhda3uIQIyq8XpXmau5jkKsZuEKoffyLe+YJj83CDdBMwUHSNU?=
 =?us-ascii?Q?G3yEFc8DHJrafm7dNkhhNULSlRAPGJ8nYQU73Yv9LExLCxf0yp7eev0aftvi?=
 =?us-ascii?Q?UoMdglU1Ndl2QOWwbN3RR2bj8wyoACyBiunf4mlRYojJ9YPCtl4aJtp5nkXm?=
 =?us-ascii?Q?ALWzT1UGz36XsdafUfFVFD/ANhgDv6zW6F2kjgGEnnaGmnWASVvbNK189hdF?=
 =?us-ascii?Q?6L+l+QalHQXo2+l56Iy1ENshPzNO0V0Cu7iKsE46Lu1s4l1SzktL79JKL752?=
 =?us-ascii?Q?BNzepzqLlaLuSge/eZ6oO8eKKEaznmJPgeOblgnvqRCtbVTo1alMI6bhKpMd?=
 =?us-ascii?Q?3FHM89McpamVbo4M++hMekTZLcQxUuDWv0mtdKl68vVQTbf/gjnE5HY7PorA?=
 =?us-ascii?Q?ke5Mw2Mt7fDivFN/3TZVNKVUB9BgWDfpzUMuvp/GSSW3/HSs1J1zdwKKm7cm?=
 =?us-ascii?Q?wRemLANkCLo4L4CCnDNc+sCVlE+BSbpIJjrtgy/R3E3GjXrOTkmA50ExPUuP?=
 =?us-ascii?Q?iuaA5gcLVmZdyH8of+2kj6BipmWF1ANRl7u7AMzWzWyav/5nv+s6z4PpRu+b?=
 =?us-ascii?Q?7CdCoSAyCxynkYNg81JWHVYco4JN32VkNpz0x+UFkCpjEWaabY6gDKHU6ar/?=
 =?us-ascii?Q?7QAxHyYveXQZtXU46tRdj4KWEdAlz/n+LspOetxP/tOdF6bYqRStc+ZSE7Jd?=
 =?us-ascii?Q?4Oz5DOGD/RCcwKaccBMWrxu+eEeaS3wOIi8vgqYbGD4QlQ6eZIOy6rglutEK?=
 =?us-ascii?Q?q9jjVpSwnr6rfY/vTJRtbcGAnbj8RD6Q61RY3cHc0clmTPCECCvSnw2oV0Cy?=
 =?us-ascii?Q?kvCiM1jiH454lU2NzcrMu0M4E8eBylR6hvxS5VnO6O7yFN727ijTUwf9IxUN?=
 =?us-ascii?Q?oL7q94IygvySAqnakKM0ZdgUJSCBIesktY+9zq5r9TCmrJmZHwNtbBMvM9PR?=
 =?us-ascii?Q?zmCX/GPrjX4ARFW8NFeWO8XxNt3yXjN5hm/X5bXEop4oZE+1WyAlwcGQefmQ?=
 =?us-ascii?Q?ePnWYSJx/8AR1Z2e74CY0Z4xsYrP2Gyk5HwuNbANXmxkvTGt4fJmCroEaSPe?=
 =?us-ascii?Q?b/IXf1IZ5LdECuhnzUHjN6OnGCY4LWlBPH8uhj5gmNYb/vsDyFAFlTR5sFWj?=
 =?us-ascii?Q?W4it0Iu+GFTeY8QeNP7S9eU3J7GH1fmJDNP+hdBB1Iixw6xJzBQh1kC3xppD?=
 =?us-ascii?Q?fKX098DoY8darP9AYUU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ee078c-1bba-44c8-125d-08dc30f8f1d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 03:14:54.6693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QD1KvY/j0UC6goqSISUHV/obpcVd6m4Qe82IGzdL5AdMvp3xORMjUWEuQoPT4jpkGt/SpUP64aw5d8DL04t4Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8161

Hi Ming,

> From: Ming Lei <ming.lei@redhat.com>
> Sent: Sunday, February 18, 2024 6:57 PM
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
>=20
> What if the surprise happens after the above check?
>=20
>=20
In that small timing window, the race still exists.

I think, blk_mq_quiesce_queue(q); should move up before cleanup_reqs() rega=
rdless of surprise case along with other below changes.

Additionally, for non-surprise case, better to have a graceful timeout to c=
omplete already queued requests.
In absence of timeout scheme for this regression, shall we only complete th=
e requests which the device has already completed (instead of waiting for t=
he grace time)?
There was past work from Chaitanaya, for the graceful timeout.

The sequence for the fix I have in mind is:
1. quiesce the queue
2. complete all requests which has completed, with its status
3. stop the transport (queues)
4. complete remaining pending requests with error status

This should work regardless of surprise case.
An additional/optional graceful timeout on non-surprise case can be helpful=
 for #2.

WDYT?

> Thanks,
> Ming

