Return-Path: <ming.lei@redhat.com>
Date: Fri, 10 Aug 2018 09:20:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v6 02/12] scsi: Alter handling of RQF_DV requests
Message-ID: <20180810012019.GA2816@ming.t460p>
References: <20180809194149.15285-1-bart.vanassche@wdc.com>
 <20180809194149.15285-3-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180809194149.15285-3-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 09, 2018 at 12:41:39PM -0700, Bart Van Assche wrote:
> Process all requests in state SDEV_CREATED instead of only RQF_DV
> requests. This does not change the behavior of the SCSI core because
> the SCSI device state is modified into another state before SCSI
> devices become visible in sysfs and before any device nodes are
> created in /dev. Do not process RQF_DV requests in state SDEV_CANCEL
> because only power management requests should be processed in this
> state.

Could you explain a bit why only PM requests should be processed in
SDEV_CANCEL?

Thanks,
Ming
