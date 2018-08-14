Return-Path: <prvs=7571f9cb6=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "ngupta@vflare.org"
	<ngupta@vflare.org>, "hch@lst.de" <hch@lst.de>, "minchan@kernel.org"
	<minchan@kernel.org>, "hare@suse.com" <hare@suse.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"keith.busch@intel.com" <keith.busch@intel.com>
Subject: Re: [PATCH 4/5] zram: register default groups with device_add_disk()
Date: Tue, 14 Aug 2018 15:23:06 +0000
Message-ID: <3f8e9adbb899d40dde900e4b5d57cafe663f808b.camel@wdc.com>
References: <20180814073305.87255-1-hare@suse.de>
	 <20180814073305.87255-5-hare@suse.de>
In-Reply-To: <20180814073305.87255-5-hare@suse.de>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-08-14 at 09:33 +-0200, Hannes Reinecke wrote:
+AD4- Register default sysfs groups during device+AF8-add-disk() to avoid a
                                       +AF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4=
AXgBeAF4AXg-
                                       device+AF8-add+AF8-disk()?
+AD4- race condition with udev during startup.
+AD4-=20
+AD4- Signed-off-by: Hannes Reinecke +ADw-hare+AEA-suse.com+AD4-
+AD4- Cc: Minchan Kim +ADw-minchan+AEA-kernel.org+AD4-
+AD4- Cc: Nitin Gupta +ADw-ngupta+AEA-vflare.org+AD4-
+AD4- Reviewed-by: Christoph Hellwig +ADw-hch+AEA-lst.de+AD4-

Anyway:

Reviewed-by: Bart Van Assche +ADw-bart.vanassche+AEA-wdc.com+AD4-
