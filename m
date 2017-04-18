Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@bombadil.infradead.org" <hch@bombadil.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "hch@lst.de"
	<hch@lst.de>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
	"roger.pau@citrix.com" <roger.pau@citrix.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "jbacik@fb.com" <jbacik@fb.com>,
	"james.smart@broadcom.com" <james.smart@broadcom.com>, "dm-devel@redhat.com"
	<dm-devel@redhat.com>
Subject: Re: pd: remove bogus check for req->errors
Date: Tue, 18 Apr 2017 22:59:11 +0000
Message-ID: <1492556350.2689.23.camel@sandisk.com>
References: <20170418155229.5977-1-hch@bombadil.infradead.org>
	 <20170418155229.5977-22-hch@bombadil.infradead.org>
In-Reply-To: <20170418155229.5977-22-hch@bombadil.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2017-04-18 at 08:52 -0700, Christoph Hellwig wrote:
> The driver never sets req->errors

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>=
