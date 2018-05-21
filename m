Return-Path: <keith.busch@linux.intel.com>
Date: Mon, 21 May 2018 08:08:21 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Omar Sandoval <osandov@osandov.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH blktests] Fix block/011 to not use sysfs for device
 disabling
Message-ID: <20180521140821.GB5528@localhost.localdomain>
References: <20180518174247.31098-1-keith.busch@intel.com>
 <1352065975.3088816.1526884676038.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352065975.3088816.1526884676038.JavaMail.zimbra@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 21, 2018 at 02:37:56AM -0400, Yi Zhang wrote:
> Hi Keith
> I tried this patch on my R730 Server, but it lead to system hang after setpci, could you help check it, thanks.
> 
> Console log:
> storageqe-62 login: 
> Kernel 4.17.0-rc5 on an x86_64
> 
> storageqe-62 login: [ 1058.118258] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 3
> [ 1058.118261] {1}[Hardware Error]: event severity: fatal
> [ 1058.118262] {1}[Hardware Error]:  Error 0, type: fatal
> [ 1058.118265] {1}[Hardware Error]:   section_type: PCIe error
> [ 1058.118266] {1}[Hardware Error]:   port_type: 0, PCIe end point
> [ 1058.118267] {1}[Hardware Error]:   version: 1.16
> [ 1058.118269] {1}[Hardware Error]:   command: 0x0400, status: 0x0010
> [ 1058.118270] {1}[Hardware Error]:   device_id: 0000:85:00.0
> [ 1058.118271] {1}[Hardware Error]:   slot: 0
> [ 1058.118271] {1}[Hardware Error]:   secondary_bus: 0x00
> [ 1058.118273] {1}[Hardware Error]:   vendor_id: 0x144d, device_id: 0xa821
> [ 1058.118274] {1}[Hardware Error]:   class_code: 020801
> [ 1058.118275] Kernel panic - not syncing: Fatal hardware error!
> [ 1058.118301] Kernel Offset: 0x14800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Thanks for the notice. The test may be going to far with the config
registers it's touching. Let me see if we just do the BME bit as Ming
suggested fixes this.
