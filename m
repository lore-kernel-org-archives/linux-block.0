Return-Path: <axboe@kernel.dk>
Subject: Re: [blktests PATCHv2] Fix block/011 to not use sysfs for device
 disabling
To: Keith Busch <keith.busch@intel.com>, Omar Sandoval <osandov@osandov.com>,
 linux-block@vger.kernel.org
Cc: Johannes Thumshirn <jthumshirn@suse.de>
References: <20180604225141.8950-1-keith.busch@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <53d14589-3c2d-8627-0a3d-5f91dd6f7ff6@kernel.dk>
Date: Mon, 4 Jun 2018 17:26:36 -0600
MIME-Version: 1.0
In-Reply-To: <20180604225141.8950-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/4/18 4:51 PM, Keith Busch wrote:
> The PCI sysfs interface may not be a dependable method for toggling the
> PCI device state to trigger the timeouts. This patch goes directly to
> the config space to make device failure occur.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe
