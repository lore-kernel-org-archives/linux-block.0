Return-Path: <prvs=7571f9cb6=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"ed.cashin@acm.org" <ed.cashin@acm.org>, "hare@suse.com" <hare@suse.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"keith.busch@intel.com" <keith.busch@intel.com>
Subject: Re: [PATCH 3/5] aoe: use device_add_disk_with_groups()
Date: Tue, 14 Aug 2018 15:21:21 +0000
Message-ID: <047cdc676b8068aa8599f9646cf52bc578facade.camel@wdc.com>
References: <20180814073305.87255-1-hare@suse.de>
	 <20180814073305.87255-4-hare@suse.de>
In-Reply-To: <20180814073305.87255-4-hare@suse.de>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-08-14 at 09:33 +-0200, Hannes Reinecke wrote:
+AD4- Use device+AF8-add+AF8-disk+AF8-with+AF8-groups() to avoid a race con=
dition with
+AD4- udev during startup.
+AD4-=20
+AD4- Signed-off-by: Hannes Reinecke +ADw-hare+AEA-suse.com+AD4-
+AD4- Reviewed-by: Christoph Hellwig +ADw-hch+AEA-lst.de+AD4-
+AD4- Cc: Ed L. Cachin +ADw-ed.cashin+AEA-acm.org+AD4-

Reviewed-by: Bart Van Assche +ADw-bart.vanassche+AEA-wdc.com+AD4-
