Return-Path: <swise@opengridcomputing.com>
From: "Steve Wise" <swise@opengridcomputing.com>
To: "'Christoph Hellwig'" <hch@lst.de>,
	<axboe@kernel.dk>,
	<keith.busch@intel.com>
Cc: <linux-block@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>
References: <1467809752-31320-1-git-send-email-hch@lst.de> <1467809752-31320-3-git-send-email-hch@lst.de>
In-Reply-To: <1467809752-31320-3-git-send-email-hch@lst.de>
Subject: RE: [PATCH 2/5] nvme: add new reconnecting controller state
Date: Fri, 8 Jul 2016 08:47:35 -0500
Message-ID: <003601d1d91f$48a34c10$d9e9e430$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

> 
> The nvme fabric (RDMA, FC, etc...) can introduce port, link or node
> failures that may require a reconnect to re-establish the connection.
> 
> Add a new reconnecting state that will initially be used by the RDMA
> driver.
> 
> Reviewed-by: Jay Freyensee <james.p.freyensee@intel.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>

Looks good.

Reviewed-by: Steve Wise <swise@opengridcomputing.com>
