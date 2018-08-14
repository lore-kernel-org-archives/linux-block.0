Return-Path: <prvs=7571f9cb6=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "keith.busch@intel.com"
	<keith.busch@intel.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hare@suse.com" <hare@suse.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 5/5] virtio-blk: modernize sysfs attribute creation
Date: Tue, 14 Aug 2018 15:24:34 +0000
Message-ID: <0e99ae23c2bea89e597dd3e8b20489054f461ff5.camel@wdc.com>
References: <20180814073305.87255-1-hare@suse.de>
	 <20180814073305.87255-6-hare@suse.de>
In-Reply-To: <20180814073305.87255-6-hare@suse.de>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-08-14 at 09:33 +-0200, Hannes Reinecke wrote:
+AD4- Use new-style DEVICE+AF8-ATTR+AF8-RO/DEVICE+AF8-ATTR+AF8-RW to create=
 the sysfs attributes
+AD4- and register the disk with default sysfs attribute groups.

Reviewed-by: Bart Van Assche +ADw-bart.vanassche+AEA-wdc.com+AD4-
