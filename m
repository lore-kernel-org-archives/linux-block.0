Return-Path: <swise@opengridcomputing.com>
From: "Steve Wise" <swise@opengridcomputing.com>
To: "'Sagi Grimberg'" <sagi@lightbits.io>,
	"'Christoph Hellwig'" <hch@lst.de>,
	<axboe@kernel.dk>,
	<keith.busch@intel.com>,
	<sean.hefty@intel.com>
Cc: <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	"'Armen Baloyan'" <armenx.baloyan@intel.com>,
	"'Jay Freyensee'" <james.p.freyensee@intel.com>,
	"'Ming Lin'" <ming.l@ssi.samsung.com>,
	<linux-rdma@vger.kernel.org>
References: <1465248215-18186-1-git-send-email-hch@lst.de> <1465248215-18186-5-git-send-email-hch@lst.de> <5756B75C.9000409@lightbits.io> <057a01d1c2a3$3082eec0$9188cc40$@opengridcomputing.com>
In-Reply-To: <057a01d1c2a3$3082eec0$9188cc40$@opengridcomputing.com>
Subject: RE: [PATCH 4/5] nvmet-rdma: add a NVMe over Fabrics RDMA target driver
Date: Tue, 14 Jun 2016 11:10:34 -0500
Message-ID: <00f501d1c657$483a74e0$d8af5ea0$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

> 
> The above nvmet cm event handler, nvmet_rdma_cm_handler(), calls
> nvmet_rdma_queue_connect() for CONNECT_REQUEST events, which calls
> nvmet_rdma_alloc_queue (), which, if it encounters a failure (like creating
> the qp), calls nvmet_rdma_cm_reject () which calls rdma_reject().  The
> non-zero error, however, gets returned back here and this function returns
> the error to the RDMA_CM which will also reject the connection as well as
> destroy the cm_id.  So there are two rejects happening, I think.  Either
> nvmet should reject and destroy the cm_id, or it should do neither and
> return non-zero to the RDMA_CM to reject/destroy.
> 
> Steve.
> 

Hey Sean, 

Am I correct here?  IE: Is it ok for the rdma application to rdma_reject() and
rmda_destroy_id() the CONNECT_REQUEST cm_id _inside_ its event handler as long
as it returns 0? 

Thanks,

Steve.
