Return-Path: <BATV+08196f5b2bd262a84b8d+5113+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: RFC: nvme multipath support
Date: Wed, 23 Aug 2017 19:58:05 +0200
Message-Id: <20170823175815.3646-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi all,

this series adds support for multipathing, that is accessing nvme
namespaces through multiple controllers to the nvme core driver.

It is a very thin and efficient implementation that relies on
close cooperation with other bits of the nvme driver, and few small
and simple block helpers.

Compared to dm-multipath the important differences are how management
of the paths is done, and how the I/O path works.

Management of the paths is fully integrated into the nvme driver,
for each newly found nvme controller we check if there are other
controllers that refer to the same subsystem, and if so we link them
up in the nvme driver.  Then for each namespace found we check if
the namespace id and identifiers match to check if we have multiple
controllers that refer to the same namespaces.  For now path
availability is based entirely on the controller status, which at
least for fabrics will be continuously updated based on the mandatory
keep alive timer.  Once the Asynchronous Namespace Access (ANA)
proposal passes in NVMe we will also get per-namespace states in
addition to that, but for now any details of that remain confidential
to NVMe members.

The I/O path is very different from the existing multipath drivers,
which is enabled by the fact that NVMe (unlike SCSI) does not support
partial completions - a controller will either complete a whole
command or not, but never only complete parts of it.  Because of that
there is no need to clone bios or requests - the I/O path simply
redirects the I/O to a suitable path.  For successful commands
multipath is not in the completion stack at all.  For failed commands
we decide if the error could be a path failure, and if yes remove
the bios from the request structure and requeue them before completing
the request.  All together this means there is no performance
degradation compared to normal nvme operation when using the multipath
device node (at least not until I find a dual ported DRAM backed
device :))

There are a couple questions left in the individual patches, comments
welcome.

Note that this series requires the previous series to remove bi_bdev,
in doubt use the git tree below for testing.

A git tree is available at:

   git://git.infradead.org/users/hch/block.git nvme-mpath

gitweb:

   http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-mpath
