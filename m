Return-Path: <prvs=7571f9cb6=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"martin.wilck@suse.com" <martin.wilck@suse.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>, "hare@suse.com"
	<hare@suse.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "keith.busch@intel.com"
	<keith.busch@intel.com>
Subject: Re: [PATCH 1/5] block: genhd: add 'groups' argument to
 device_add_disk
Date: Tue, 14 Aug 2018 15:17:11 +0000
Message-ID: <712eaa404a1a76193b1a304443dcbae339e53ab5.camel@wdc.com>
References: <20180814073305.87255-1-hare@suse.de>
	 <20180814073305.87255-2-hare@suse.de>
In-Reply-To: <20180814073305.87255-2-hare@suse.de>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-08-14 at 09:33 +-0200, Hannes Reinecke wrote:
+AD4- Update device+AF8-add+AF8-disk() to take an 'groups' argument so that
+AD4- individual drivers can register a device with additional sysfs
+AD4- attributes.
+AD4- This avoids race condition the driver would otherwise have if these
             +AF4- +ACI-a+ACI- is missing?
+AD4- groups were to be created with sysfs+AF8-add+AF8-groups().

Anyway:

Reviewed-by: Bart Van Assche +ADw-bart.vanassche+AEA-wdc.com+AD4-
