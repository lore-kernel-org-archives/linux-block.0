Return-Path: <hch@lst.de>
Date: Fri, 17 Aug 2018 08:53:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <keith.busch@intel.com>,
	Bart van Assche <bart.vanassche@wdc.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Hannes Reinecke <hare@suse.com>,
	"Ed L . Cachin" <ed.cashin@acm.org>
Subject: Re: [PATCH 3/5] aoe: use device_add_disk_with_groups()
Message-ID: <20180817065326.GB11170@lst.de>
References: <20180814073305.87255-1-hare@suse.de> <20180814073305.87255-4-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180814073305.87255-4-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 14, 2018 at 09:33:03AM +0200, Hannes Reinecke wrote:
> Use device_add_disk_with_groups() to avoid a race condition with
> udev during startup.

The desxription and the subject line need an update now that
device_add_disk_with_groups is no more.
