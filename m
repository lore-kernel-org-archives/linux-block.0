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
Subject: Re: [PATCH 12/23] dm mpath: don't check for req->errors
Date: Thu, 20 Apr 2017 15:25:54 +0000
Message-ID: <1492701953.2642.3.camel@sandisk.com>
References: <20170420140316.6546-1-hch@lst.de>
	 <20170420140316.6546-13-hch@lst.de>
In-Reply-To: <20170420140316.6546-13-hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-04-20 at 16:03 +0200, Christoph Hellwig wrote:
> We'll get all proper errors reported through ->end_io and ->errors will
> go away soon.

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>=
