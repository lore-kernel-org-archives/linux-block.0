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
Subject: Re: [PATCH 01/23] pd: don't check blk_execute_rq return value.
Date: Wed, 19 Apr 2017 21:02:33 +0000
Message-ID: <1492635752.2543.16.camel@sandisk.com>
References: <20170419192708.22098-1-hch@lst.de>
	 <20170419192708.22098-2-hch@lst.de>
In-Reply-To: <20170419192708.22098-2-hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-04-19 at 21:26 +0200, Christoph Hellwig wrote:
> The driver never sets req->errors, so blk_execute_rq will always return 0=
.

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>=
