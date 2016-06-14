Return-Path: <sean.hefty@intel.com>
From: "Hefty, Sean" <sean.hefty@intel.com>
To: Steve Wise <swise@opengridcomputing.com>, 'Sagi Grimberg'
	<sagi@lightbits.io>, 'Christoph Hellwig' <hch@lst.de>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "Busch, Keith" <keith.busch@intel.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Baloyan,
 ArmenX" <armenx.baloyan@intel.com>, "Freyensee, James P"
	<james.p.freyensee@intel.com>, 'Ming Lin' <ming.l@ssi.samsung.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 4/5] nvmet-rdma: add a NVMe over Fabrics RDMA target
 driver
Date: Tue, 14 Jun 2016 16:47:00 +0000
Message-ID: <1828884A29C6694DAF28B7E6B8A82373AB061E1B@ORSMSX109.amr.corp.intel.com>
References: <1465248215-18186-1-git-send-email-hch@lst.de>
 <1465248215-18186-5-git-send-email-hch@lst.de>
 <5756B75C.9000409@lightbits.io>
 <057a01d1c2a3$3082eec0$9188cc40$@opengridcomputing.com>
 <00f501d1c657$483a74e0$d8af5ea0$@opengridcomputing.com>
In-Reply-To: <00f501d1c657$483a74e0$d8af5ea0$@opengridcomputing.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Return-Path: sean.hefty@intel.com
List-ID: <linux-block@vger.kernel.org>

> Am I correct here?  IE: Is it ok for the rdma application to
> rdma_reject()

yes

> rmda_destroy_id() the CONNECT_REQUEST cm_id _inside_ its event handler

no

> as long
> as it returns 0?

The user can return a non-zero value from the cm handler to destroy the id.

- Sean
