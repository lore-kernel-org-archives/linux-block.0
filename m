Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:26689 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936307AbdIYQSy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Sep 2017 12:18:54 -0400
Date: Mon, 25 Sep 2017 10:18:10 -0600
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 8/9] nvme: implement multipath access to nvme subsystems
Message-ID: <20170925161810.GD8463@localhost.localdomain>
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170925134031.10548-9-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Sep 25, 2017 at 03:40:30PM +0200, Christoph Hellwig wrote:
> This patch adds initial multipath support to the nvme driver.  For each
> namespace we create a new block device node, which can be used to access
> that namespace through any of the controllers that refer to it.
> 
> Currently we will always send I/O to the first available path, this will
> be changed once the NVMe Asynchronous Namespace Access (ANA) TP is
> ratified and implemented, at which point we will look at the ANA state
> for each namespace.  Another possibility that was prototyped is to
> use the path that is closes to the submitting NUMA code, which will be
> mostly interesting for PCI, but might also be useful for RDMA or FC
> transports in the future.  There is not plan to implement round robin
> or I/O service time path selectors, as those are not scalable with
> the performance rates provided by NVMe.
> 
> The multipath device will go away once all paths to it disappear,
> any delay to keep it alive needs to be implemented at the controller
> level.
> 
> The new block devices nodes for multipath access will show up as
> 
> 	/dev/nvm-subXnZ
> 
> where X is the local instance number of the subsystems, and Z is the index
> for the namespace.
> 
> To get persistent devices names the following lines can be added to
> /lib/udev/rules.d/60-persistent-storage.rules:
> 
> ---------------------------------- snip ----------------------------------
> KERNEL=="nvm-sub*[0-9]n*[0-9]", ATTR{wwid}=="?*", SYMLINK+="disk/by-id/nvme-sub-$attr{wwid}"
> KERNEL=="nvm-sub*[0-9]n*[0-9]p*[0-9]", ENV{DEVTYPE}=="partition", ATTRS{wwid}=="?*", SYMLINK+="disk/by-id/nvme-sub-$attr{wwid}-part%n"
> KERNEL=="nvm-sub*[0-9]n*[0-9]", ENV{DEVTYPE}=="disk", ATTRS{wwid}=="?*", ENV{ID_WWN}="$attr{wwid}"
> ---------------------------------- snip ----------------------------------
> 
> Note that these create the new persistent names.  Overriding the existing
> nvme ones would be nicer, but while that works for the first path, the
> normal rule will override it again for each subsequent path.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch@intel.com>
