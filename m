Return-Path: <anish.jhaveri@paviliondata.com>
Date: Mon, 11 Sep 2017 21:20:48 -0700
From: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
To: sagi@grimberg.me, hch@lst.de, keith.busch@intel.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 00/10] nvme multipath support on top of nvme-4.13 branch
Message-ID: <20170912042048.pdbyl6vsoeui6bnp@haynes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: anish.jhaveri@paviliondata.com
List-ID: <linux-block@vger.kernel.org>

Hello everyone,
Please find patchset for supporting Multipathing using nvme namespace 
and nvme controller. 

Basic idea behind the design and implementation is to re-use the same 
logic which is between generic nvme namespace and it's controller. 
One controller to many namespaces. Similarly, this implementation uses
one multipath controller and sibling namespaces.
It creates a head multipath nvme namespace as soon as it find a nvme
namespace during enumeration which has property of being shared. Prior
to creating new head multipath device, nvme namespace check for match-
ing NGUID, if it finds one, this nvme namespace is added as a sibling
to that given namespaces head device. 
Failover is triggered either due to keep-alive timer expiration or RDMA
 timeout. Selection is of device is based on first available standby
device. As of present this implementation support Active-Standby multi-
path model.
On selection of device, a command is sent to target for acknowledgement 
of active device. In meanwhile if any IO are received, they get queued 
under head multipath device congestion queue and processed as soon as
a single path becomes active. In scenario where new active path results
in failure, it will cancel those IOs after multiple retries.

I have gone through the solutiion Christoph Hellwig suggested and this
one follow similar path except for it doesn't require any change from 
kernel and will work prior version of kernel.
It can made standalone module and be used with other block devices as
we open any block device handle.

It has been tested with interface up/down on host and target, target
node crash and disconnect command. Performance has been tested with
multiple multipath devices on single host and there is un-noticeable
 difference in numbers. 

The git tree for above changes is available at 
https://github.com/paviliondata/nvme.git
Branch nvme-4.13

Web interface
https://github.com/paviliondata/nvme/tree/nvme-4.13
 
Please peruse through the patchset and comment. 

Anish M Jhaveri (10):
  Initial multipath implementation.
  RDMA timeout triggers failover.
  Failover timeout and time between failover same ns.
  NVME command to set namespace active.
  Init multipath head controller.
  Init multipath head namespace.
  Selection of active namespace.
  Multipath make request, retry and cancel IO.
  Sysfs entries for multipath head
  Reserved tag for active ns command

 drivers/nvme/host/core.c | 1245 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |   37 +-
 drivers/nvme/host/rdma.c |    5 +-
 3 files changed, 1259 insertions(+), 28 deletions(-)

-- 
2.9.3
