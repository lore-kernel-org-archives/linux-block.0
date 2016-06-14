Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:48021 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbcFNObh (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 14 Jun 2016 10:31:37 -0400
Date: Tue, 14 Jun 2016 07:31:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Steve Wise <swise@opengridcomputing.com>
Cc: 'Sagi Grimberg' <sagi@lightbits.io>,
	'Christoph Hellwig' <hch@lst.de>, axboe@kernel.dk,
	keith.busch@intel.com, 'Ming Lin' <ming.l@ssi.samsung.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	'Jay Freyensee' <james.p.freyensee@intel.com>,
	'Armen Baloyan' <armenx.baloyan@intel.com>
Subject: Re: [PATCH 4/5] nvmet-rdma: add a NVMe over Fabrics RDMA target
 driver
Message-ID: <20160614143132.GA17800@infradead.org>
References: <1465248215-18186-1-git-send-email-hch@lst.de>
 <1465248215-18186-5-git-send-email-hch@lst.de>
 <5756B75C.9000409@lightbits.io>
 <057a01d1c2a3$3082eec0$9188cc40$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <057a01d1c2a3$3082eec0$9188cc40$@opengridcomputing.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 09, 2016 at 06:03:51PM -0500, Steve Wise wrote:
> The above nvmet cm event handler, nvmet_rdma_cm_handler(), calls
> nvmet_rdma_queue_connect() for CONNECT_REQUEST events, which calls
> nvmet_rdma_alloc_queue (), which, if it encounters a failure (like creating
> the qp), calls nvmet_rdma_cm_reject () which calls rdma_reject().  The
> non-zero error, however, gets returned back here and this function returns
> the error to the RDMA_CM which will also reject the connection as well as
> destroy the cm_id.  So there are two rejects happening, I think.  Either
> nvmet should reject and destroy the cm_id, or it should do neither and
> return non-zero to the RDMA_CM to reject/destroy.

Can you just send a patch?
