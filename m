Return-Path: <hch@lst.de>
Date: Wed, 11 Jul 2018 19:10:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] blk-mq: introduce blk_mq_support_runtime_pm()
Message-ID: <20180711171054.GA3500@lst.de>
References: <20180711162906.14271-1-ming.lei@redhat.com> <20180711162906.14271-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180711162906.14271-2-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jul 12, 2018 at 12:29:03AM +0800, Ming Lei wrote:
> A bit cost has to be added in fast IO path for supporting runtime PM, and
> introduce this helper so that drivers incapable of runtime PM may not be
> affected by this feature.

I don't think this is useful on it's own and should go with the
patch that uses it.
