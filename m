Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "roger.pau@citrix.com"
	<roger.pau@citrix.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "jbacik@fb.com" <jbacik@fb.com>,
	"james.smart@broadcom.com" <james.smart@broadcom.com>, "dm-devel@redhat.com"
	<dm-devel@redhat.com>
Subject: Re: [PATCH 16/23] blk-mq: remove the error argument to
 blk_mq_complete_request
Date: Thu, 20 Apr 2017 15:28:27 +0000
Message-ID: <1492702106.2642.4.camel@sandisk.com>
References: <20170420140316.6546-1-hch@lst.de>
	 <20170420140316.6546-17-hch@lst.de>
In-Reply-To: <20170420140316.6546-17-hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-04-20 at 16:03 +0200, Christoph Hellwig wrote:
> Now that all drivers that call blk_mq_complete_requests have a
> ->complete callback we can remove the direct call to blk_mq_end_request,
> as well as the error argument to blk_mq_complete_request.

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>=
