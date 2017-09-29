Return-Path: <Steve.Schremmer@netapp.com>
From: "Schremmer, Steven" <Steve.Schremmer@netapp.com>
To: Martin Wilck <mwilck@suse.com>, Jens Axboe <axboe@kernel.dk>, "Christoph
 Hellwig" <hch@lst.de>, Johannes Thumshirn <jthumshirn@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Martin Wilck
	<mwilck@suse.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Hannes Reinecke <hare@suse.de>
Subject: RE: [PATCH 2/2] nvme: use device_add_disk_with_groups()
Date: Fri, 29 Sep 2017 19:27:57 +0000
Message-ID: <BN6PR06MB2481721314222F0625734DB48C7E0@BN6PR06MB2481.namprd06.prod.outlook.com>
References: <20170928193637.24707-1-mwilck@suse.com>
 <20170928193637.24707-2-mwilck@suse.com>
In-Reply-To: <20170928193637.24707-2-mwilck@suse.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Return-Path: Steve.Schremmer@netapp.com
List-ID: <linux-block@vger.kernel.org>

> From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behal=
f Of Martin Wilck
> Sent: Thursday, September 28, 2017 2:37 PM
> To: Jens Axboe <axboe@kernel.dk>; Christoph Hellwig <hch@lst.de>; Johanne=
s Thumshirn <jthumshirn@suse.de>
> Cc: linux-block@vger.kernel.org; Martin Wilck <mwilck@suse.de>; linux-ker=
nel@vger.kernel.org; linux-nvme@lists.infradead.org;
> Hannes Reinecke <hare@suse.de>
> Subject: [PATCH 2/2] nvme: use device_add_disk_with_groups()
>=20

Tested-by: Steve Schremmer <steve.schremmer@netapp.com>
