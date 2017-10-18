Return-Path: <BATV+33c0a560d8cf4f6c9bdc+5169+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: nvme multipath support V4
Date: Wed, 18 Oct 2017 18:52:41 +0200
Message-Id: <20171018165258.23212-1-hch@lst.de>
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

A git tree is available at:

   git://git.infradead.org/users/hch/block.git nvme-mpath

gitweb:

   http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-mpath

Changes since V3:
  - new block layer support for hidden gendisks
  - a couple new patches to refactor device handling before the
    actual multipath support
  - don't expose per-controller block device nodes
  - use /dev/nvmeXnZ as the device nodes for the whole subsystem.
  - expose subsystems in sysfs (Hannes Reinecke)
  - fix a subsystem leak when duplicate NQNs are found
  - fix up some names
  - don't clear current_path if freeing a different namespace

Changes since V2:
  - don't create duplicate subsystems on reset (Keith Bush)
  - free requests properly when failing over in I/O completion (Keith Bush)
  - new devices names: /dev/nvm-sub%dn%d
  - expose the namespace identification sysfs files for the mpath nodes

Changes since V1:
  - introduce new nvme_ns_ids structure to clean up identifier handling
  - generic_make_request_fast is now named direct_make_request and calls
    generic_make_request_checks
  - reset bi_disk on resubmission
  - create sysfs links between the existing nvme namespace block devices and
    the new share mpath device
  - temporarily added the timeout patches from James, this should go into
    nvme-4.14, though
