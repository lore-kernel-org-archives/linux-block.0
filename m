Return-Path: <bvanassche@acm.org>
Message-ID: <1536161092.11534.1.camel@acm.org>
Subject: Re: [PATCH 1/5] block: genhd: add 'groups' argument to
 device_add_disk
From: Bart Van Assche <bvanassche@acm.org>
To: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
	Busch <keith.busch@intel.com>, Bart van Assche <bart.vanassche@wdc.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, Martin Wilck
	 <martin.wilck@suse.com>, Hannes Reinecke <hare@suse.com>
Date: Wed, 05 Sep 2018 08:24:52 -0700
In-Reply-To: <20180905070053.26239-2-hare@suse.de>
References: <20180905070053.26239-1-hare@suse.de>
	 <20180905070053.26239-2-hare@suse.de>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-09-05 at 09:00 +-0200, Hannes Reinecke wrote:
+AD4 Update device+AF8-add+AF8-disk() to take an 'groups' argument so that
+AD4 individual drivers can register a device with additional sysfs
+AD4 attributes.
+AD4 This avoids race condition the driver would otherwise have if these
+AD4 groups were to be created with sysfs+AF8-add+AF8-groups().

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
