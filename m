Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FBD67C4A;
	Tue, 20 Feb 2024 12:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430600; cv=fail; b=nkjeapoxKvHkoXDmaU+Iv873JplJB/90AWQYIlfzXhiP+wsQrx6X+jJFfv7HkZWq+aMbC7RfFWr9xLd0BWa8bNDZjFY3HdRRnjoZM6+CACQ4cCLeUwPPLDURJ2+0ag4SE2PshxvFB69w3EoB147J8EcpZTMIwZhBdGQrWoDcr/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430600; c=relaxed/simple;
	bh=0DgLcNVHcoMvyEZXQlyVWCvYgbhMt+gLVxxXoJGAIsU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tm7TFYdpPSjwNUje2AhUWSnCee3smJMnmhC/qxF5ZCZWbHGP9/k/Z+n53sMptqCG9oLcAFFlquJZ0+prHofuHLyBnh33ESctwwwpzJqnjnqJ4Ynxvv2+biyEb5r2KYyLceGZr35jbpp/efkteVx2z4xD53AhM9CLG5toxtmCs/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gHGjyTeP; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gHGjyTeP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HisYo2H8YAQjOnf+KV6lXKb0J2HmWP1pQvz7UVbQnREg/rP42SGCAeadzyFUnYCfQA8nGg2aD+pNsIglzEQIox6OB8en9IW8GU600Z8B71EBj2Vihr7tQwHKkOnyGN7qaMf1X/UlJBEFmyDAojRJX2qBBmMqcCbCZZFaPU7PWbE8Imx8dqwVohX8EScmsBmp5r9lGpO9359FRxJUb+QuU6a+V2f+18gDaff+3I73rKVQUJ/5YqGXkrbFbRMAYXcTvmJly/r/voYnDfg4OmV29v2KyVpVTR841p54kf5YmgRqvLLSWxZSZnqlR58NWBBJBiGl9V4mCERl1H3zZjb/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eu56ss5yMivT9ewOWGrGlt71aOBHJ9riqFkujHuST88=;
 b=OD+35PAjNcfK9q9IMhTuWto+1I+Q6LRddzd9u12ygFK1LoC/N6Q9ZeajLwmpRjpEQ+aq+rK0II9FIOx3BVMnj8I9zRxBCInm3loT6LsGYQhyNgt7ejOC29kDy2882AdBe/G4+qSE3pUn1hrl8LF2VNK/4TXtzXtCrXLNsCDffHPDO8CQ1ALW+8h1s4zRuILrGf1AgKZBZsIIZqF4QCmhbDm6O4e3OMWmvrQFPZqS47SAU5NYEBnD7Bj45GidOGYcRConS2BJVLlyX+QQ8rELehFiUZ+Snbu+nC+X9cdMrARpeCwwT0p1rXA3+ozN+9qw0PsvYTJ8qJqYE0Utvf8elw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eu56ss5yMivT9ewOWGrGlt71aOBHJ9riqFkujHuST88=;
 b=gHGjyTePkRexDMs4Ks/nY2yZYprhtMkfJxJMtXrJIJEguXIX7sK24aNC9zyy9cofuGe++NRwte8x+OpAZtcluQatqZZzhwtG5vXl+0f2VPUPUsZwumHI88gNUBeGS1FlEicSz5N82SbyapfxLKe7VbFM636x7o+oSlH5LPb2F4X9HxkNG15KS7c2SnHLZxvc77t/o3yPeG9ptWNj/3jVkyohpssPY1lDwLdCLjNzWMc6y4R3IRAbbDcLqRP78pd3ol1jOEUebLETbbALCj2cqXRNz1+VCSs0w0D0w5OeMEqa9XkSmxY8961TW7GnN96NZuZFyf84d8wM3IvpoAK5tA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 12:03:15 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5b85:d575:fac1:71c0]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5b85:d575:fac1:71c0%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 12:03:15 +0000
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
Thread-Index:
 AQHaYcxqVM2rFvg5t0SfQayLG6csArEQGLcAgADkkjCAAFazAIAAJn9QgAAD6oCAAabewA==
Date: Tue, 20 Feb 2024 12:03:15 +0000
Message-ID:
 <PH0PR12MB5481478D2F3EFEA552959DE1DC502@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240217180848.241068-1-parav@nvidia.com>
 <ZdIFpqa23YHwJACh@fedora>
 <PH0PR12MB5481DCCE8127FB12C24EF74DDC512@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20240219024301-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548151B646CDE618F71DDAFEDC512@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20240219054459-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240219054459-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB7725:EE_
x-ms-office365-filtering-correlation-id: 23fad759-7cbd-471c-d253-08dc320beb69
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7WIjHCYu/5XsHvtqRH5vm48kRFQhq5PA++/bv48MhWiqNIn0/LbQomEXhXueCXiOqwKfz1mDRmO31p8wlvxyPo6HBigF8GpHogP2feSJngECis20gkFPGWB1cArNoUGgVO0D4ZCOtaBLwBbBwxdBYoNyJ7JtNii75Z+jP6ckORy+XeikKP8U+e34fVW9Q4LpMTyNpMUCzX4ZJroXe13VZ13TjlF2bLhpkymHQM/vg2tUca25Vcay1C+bu75lmviHkKAzKazut32AnbiH2cBIGIOYWctMrUjuFmr4oE3X68CmF3zXusLbwyoJL3SjKxA61Ddk+KUy5X/e7RUfr+YLdWvlx7TxIWYLZ4Y34iFXM40Bu/103pFoARs8gJTx6zl4/hh0YqeZWPvWnt3wHNU1Tivx8RzGb1TR4TFsWQpCvr8Dj89y0PMCIQDifGeRe8He60/wt9+EN+q8WP7R+tgUz/NxlBVt8HZ5Zk3mGSmXAtrJfqNt8D8L7fxZ0naecZGoTQ42fsmEdWKAPKbq59lITMSQY1K298if8ilSWBrW5lZ9K0KBdEHkIFkKG3m/RgsJ2wijQ/SaHYdbdmmOYcMGEO7w78o5U4hQiW+mj+iPt7Imx0RSpJ01IsWzr8uQRHSQszi7rVLiZ2mQiYaSMaG7H8554apDHH5xPymdhthxMgU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?233JT3hRXEYNlJZ8z4kajcbFhMh1IMRZBRTagmECnfWdH1w4lc8EmLmpxf3t?=
 =?us-ascii?Q?V+JPllSiqlBwNnMiO5JsWbHp62XirJRgpdlNu2NMXx2bCBP3Z50v+n4j6D9I?=
 =?us-ascii?Q?eBcZkrvG8cEfAgY2fHPJtiiBPhbB5vHLsJC9a04J5QWIlXCMpRebjwKhWA5G?=
 =?us-ascii?Q?OgO5vqBQ+MjqPN7xrrlFcZbDnfTbfmTuQ1TseBXtLoDgrrDxQv2cWLdsY90c?=
 =?us-ascii?Q?UVSytS6IqtpDY8M7ilx9s1P1BUM+WqkXf2zhC4mBZ090376tfyXp0JDQ/HLW?=
 =?us-ascii?Q?tNkJc+FKaCHFWl7tWn5+3WsG/oAra72D2bNDhcTmFlLe/dlFGyFTtofjm0Di?=
 =?us-ascii?Q?X8Z5tlY/sdzT0UR1ByJwQfjlCbW9ba/PJrusntul2fDTKYPlpced0U5w5wk8?=
 =?us-ascii?Q?ZbjyxHlPMF2IaNNwebW+00K6DJmSiS3WYmTGtCQkSrDxEWKJQubshw6XVvdu?=
 =?us-ascii?Q?62b8f2IpHqBN7DIcqA81l4W88Sh98Ea9yKfUCPLKYqRa6Ojz+rQOUHJbFkHp?=
 =?us-ascii?Q?92izVFnyTZKbDuFwZ9jRyHb/FgO8J6wBOlOEiTyCv/kczw15IQ+95GDsXrD1?=
 =?us-ascii?Q?nRbNf9Idpt+P0h2e84qXt9Xr67Q3OQBNnZpa13aItWxs8EtAdgZOeZD+fZgX?=
 =?us-ascii?Q?hh51k5NSYimmDGIc6HiK6LuWd6gUJ300YZCb8EfcrZ/HZl5FH6pIHgL2SLw2?=
 =?us-ascii?Q?yjd+mZj6OffmupzWDFffGGnpctUeLkz12FtH8NIYRAfZyDYFdeGslAoW9fid?=
 =?us-ascii?Q?EVztKFEmVGVn7qFP7bnh0Qho5HMXQonxArHK2AMGSuu6DlcVFQ2T9b8bIKq6?=
 =?us-ascii?Q?KoiaYkXarNQcvRZywnFKk0XxAuXQbB8ohROff23aR/FXVor6OGaFOFqj2Iy6?=
 =?us-ascii?Q?DWawIud6285tA4tb1aAKi7qBdeskYLe3ILwpO2pbJVbGLGcoVTmsful0mrT0?=
 =?us-ascii?Q?LSfpA1VQOOdKQOCvYTzmca4hwwGAPCM+iLPpIB4myv1pIzTQs7FtWCAeXMQi?=
 =?us-ascii?Q?kPbH9CXfcW25T7i8wcaYfUlpjGPdWNxwKwUunUyxDWbkn8GJ5CZSXvLJctEc?=
 =?us-ascii?Q?gNbl0Jn79KzwvVfOw4zJkA+flL4dehEkgb+zqQaSWX/19vUyXrdEkpZ7sa+7?=
 =?us-ascii?Q?ekx70BjoKoyPOwETWG1Qosii/dKRIrFWsJUeZv8XB7KkJwPNIuukfK5XGAgY?=
 =?us-ascii?Q?RM3WW/W13/ntGoVgzwQqvmXXLURI97O4XnIiciNK4u1uFsSqg2iE14e8AAmo?=
 =?us-ascii?Q?5ZPJn95AaYgU7CbGHtL3UBcq6O0LW869aIgLVMF4h0Vf5YeuBADUJeI8fx3H?=
 =?us-ascii?Q?JtSL1lNXwG4NNi3K+1bOnM3c3tIPKVwG76PkK+SvSp9/UP05iM4HpafUgp4w?=
 =?us-ascii?Q?CSr2yFl0u5qweddZn3IGSDgMhOjlf/EGeOC61RV47TmWoso5tuVDD0FYW3F5?=
 =?us-ascii?Q?EY95L3TCvGIDvLiJT0dUkKUG3gIIaCSbQzDA5riDkraWJ0N/YbMglZ37eBBL?=
 =?us-ascii?Q?pXy2EjukDbLpsoq3pxcugMpbTu2zXqam8gvNMvNtAfluHzByHd1tphX8RsGv?=
 =?us-ascii?Q?3OjEVpduWs5EK+s9yoMcjVBpXWAUiZyRjulg1JsajAr65UbvPGI6qIAC0mV+?=
 =?us-ascii?Q?a1NoDGR41bj+g6BPfjQfI+D8dq0Qt1n2KHYcgDkVE5cE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fad759-7cbd-471c-d253-08dc320beb69
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 12:03:15.5108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LUYCcY1vlBgL6dqc67dPWFqwzsD1uC6nSOELqDGPoCBf5iMv1aLAZkTT5Pwhn+hSVBMjyBHTxfNYI5uRSC8zIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, February 19, 2024 4:17 PM
>=20
> On Mon, Feb 19, 2024 at 10:39:36AM +0000, Parav Pandit wrote:
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Monday, February 19, 2024 1:45 PM
> > >
> > > On Mon, Feb 19, 2024 at 03:14:54AM +0000, Parav Pandit wrote:
> > > > Hi Ming,
> > > >
> > > > > From: Ming Lei <ming.lei@redhat.com>
> > > > > Sent: Sunday, February 18, 2024 6:57 PM
> > > > >
> > > > > On Sat, Feb 17, 2024 at 08:08:48PM +0200, Parav Pandit wrote:
> > > > > > When the PCI device is surprise removed, requests won't
> > > > > > complete from the device. These IOs are never completed and
> > > > > > disk deletion hangs indefinitely.
> > > > > >
> > > > > > Fix it by aborting the IOs which the device will never
> > > > > > complete when the VQ is broken.
> > > > > >
> > > > > > With this fix now fio completes swiftly.
> > > > > > An alternative of IO timeout has been considered, however when
> > > > > > the driver knows about unresponsive block device, swiftly
> > > > > > clearing them enables users and upper layers to react quickly.
> > > > > >
> > > > > > Verified with multiple device unplug cycles with pending IOs
> > > > > > in virtio used ring and some pending with device.
> > > > > >
> > > > > > In future instead of VQ broken, a more elegant method can be us=
ed.
> > > > > > At the moment the patch is kept to its minimal changes given
> > > > > > its urgency to fix broken kernels.
> > > > > >
> > > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > > > > > virtio pci device")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Reported-by: lirongqing@baidu.com
> > > > > > Closes:
> > > > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb7
> > > > > > 3ca9
> > > > > > b474
> > > > > > 1@baidu.com/
> > > > > > Co-developed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > > > > Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > > ---
> > > > > >  drivers/block/virtio_blk.c | 54
> > > > > > ++++++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 54 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/block/virtio_blk.c
> > > > > > b/drivers/block/virtio_blk.c index 2bf14a0e2815..59b49899b229
> > > > > > 100644
> > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > @@ -1562,10 +1562,64 @@ static int virtblk_probe(struct
> > > > > > virtio_device
> > > > > *vdev)
> > > > > >  	return err;
> > > > > >  }
> > > > > >
> > > > > > +static bool virtblk_cancel_request(struct request *rq, void *d=
ata) {
> > > > > > +	struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(rq);
> > > > > > +
> > > > > > +	vbr->in_hdr.status =3D VIRTIO_BLK_S_IOERR;
> > > > > > +	if (blk_mq_request_started(rq) &&
> !blk_mq_request_completed(rq))
> > > > > > +		blk_mq_complete_request(rq);
> > > > > > +
> > > > > > +	return true;
> > > > > > +}
> > > > > > +
> > > > > > +static void virtblk_cleanup_reqs(struct virtio_blk *vblk) {
> > > > > > +	struct virtio_blk_vq *blk_vq;
> > > > > > +	struct request_queue *q;
> > > > > > +	struct virtqueue *vq;
> > > > > > +	unsigned long flags;
> > > > > > +	int i;
> > > > > > +
> > > > > > +	vq =3D vblk->vqs[0].vq;
> > > > > > +	if (!virtqueue_is_broken(vq))
> > > > > > +		return;
> > > > > > +
> > > > >
> > > > > What if the surprise happens after the above check?
> > > > >
> > > > >
> > > > In that small timing window, the race still exists.
> > > >
> > > > I think, blk_mq_quiesce_queue(q); should move up before
> > > > cleanup_reqs()
> > > regardless of surprise case along with other below changes.
> > > >
> > > > Additionally, for non-surprise case, better to have a graceful
> > > > timeout to
> > > complete already queued requests.
> > > > In absence of timeout scheme for this regression, shall we only
> > > > complete the
> > > requests which the device has already completed (instead of waiting
> > > for the grace time)?
> > > > There was past work from Chaitanaya, for the graceful timeout.
> > > >
> > > > The sequence for the fix I have in mind is:
> > > > 1. quiesce the queue
> > > > 2. complete all requests which has completed, with its status 3.
> > > > stop the transport (queues) 4. complete remaining pending requests
> > > > with error status
> > > >
> > > > This should work regardless of surprise case.
> > > > An additional/optional graceful timeout on non-surprise case can
> > > > be helpful
> > > for #2.
> > > >
> > > > WDYT?
> > >
> > > All this is unnecessarily hard for drivers... I am thinking maybe
> > > after we set broken we should go ahead and invoke all callbacks.
> >
> > Yes, #2 is about invoking the callbacks.
> >
> > The issue is not with setting the flag broken. As Ming pointed, the iss=
ue is :
> we may miss setting the broken.
>=20
>=20
> So if we did get callbacks, we'd be able to test broken flag in the callb=
ack.
>=20
Yes, getting callbacks is fine.
But when the device is surprise removed, we wont get the callbacks and comp=
letions are missed.

> > Without graceful time out it is straight forward code, just rearrangeme=
nt of
> APIs in this patch with existing code.
> >
> > The question is : it is really if we really care for that grace period =
when the
> device or driver is already on its exit path and VQ is not broken.
> > If we don't wait for the request in progress, is it ok?
> >
>=20
> If we are talking about physical hardware, it seems quite possible that r=
emoval
> triggers then user gets impatient and yanks the card out.
>=20
Yes, regardless of surprise or not, completing the remaining IOs is just go=
od enough.
Device is anyway on its exit path, so completing 10 commands vs 12, does no=
t make a lot of difference with extra complexity of timeout.

So better to not complicate the driver, at least not when adding Fixes tag =
patch.

>=20
> > > interrupt handling core is not making it easy for us - we must
> > > disable real interrupts if we do, and in the past we failed to do it.
> > > See e.g.
> > >
> > >
> > > commit eb4cecb453a19b34d5454b49532e09e9cb0c1529
> > > Author: Jason Wang <jasowang@redhat.com>
> > > Date:   Wed Mar 23 11:15:24 2022 +0800
> > >
> > >     Revert "virtio_pci: harden MSI-X interrupts"
> > >
> > >     This reverts commit 9e35276a5344f74d4a3600fc4100b3dd251d5c56.
> > > Issue
> > >     were reported for the drivers that are using affinity managed IRQ
> > >     where manually toggling IRQ status is not expected. And we forget=
 to
> > >     enable the interrupts in the restore path as well.
> > >
> > >     In the future, we will rework on the interrupt hardening.
> > >
> > >     Fixes: 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")
> > >
> > >
> > >
> > > If someone can figure out a way to make toggling interrupt state
> > > play nice with affinity managed interrupts, that would solve a host o=
f
> issues I feel.
> > >
> > >
> > >
> > > > > Thanks,
> > > > > Ming

