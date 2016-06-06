Return-Path: <BATV+65f7e0ff3112b2479d70+4670+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	keith.busch@intel.com
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: NVMe over Fabrics target implementation
Date: Mon,  6 Jun 2016 23:22:54 +0200
Message-Id: <1465248177-17970-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This patch set adds a generic NVMe over Fabrics target. The
implementation conforms to the NVMe 1.2b specification (which
includes Fabrics) and provides the NVMe over Fabrics access
to Linux block devices.

The target implementation consists of several elements:

- NVMe target core: defines and manages the NVMe entities (subsystems,
  controllers, namespaces, ...) and their allocation, responsible
  for initial commands processing and correct orchestration of
  the stack setup and tear down.

- NVMe admin command implementation: responsible for parsing and
  servicing admin commands such as controller identify, set features,
  keep-alive, log page, ...).

- NVMe I/O command implementation: responsible for performing the actual
  I/O (Read, Write, Flush, Deallocate (aka Discard).  It is a very thin
  layer on top of the block layer and implements no logic of it's own.
  To support exporting file systems please use the loopback block driver
  in direct I/O mode, which gives very good performance.

- NVMe over Fabrics support: responsible for servicing Fabrics commands
  (connect, property get/set).

- NVMe over Fabrics discovery service: responsible to serve the Discovery
  log page through a special cut down Discovery controller.

The target is configured using configfs, and configurable entities are:

 - NVMe subsystems and namespaces
 - NVMe over Fabrics ports and referrals
 - Host ACLs for primitive access control - NVMe over Fabrics access
   control is still work in progress at the specification level and
   will be implemented once that work has finished.

To configure the target use the nvmetcli tool from
http://git.infradead.org/users/hch/nvmetcli.git, which includes detailed
setup documentation.

In addition to the Fabrics target implementation we provide a loopback
driver which also conforms the NVMe over Fabrics specification and allows
evaluation of the target stack with local access without requiring a real
fabric.

Various test cases are provided for this implementation: nvmetcli
contains a python testsuite that mostly stresses the configfs interface
of the target, and we have various integration tests prepared for the
kernel host and target which are available at:

	git://git.infradead.org/nvme-fabrics.git nvmf-selftests

Gitweb:

	http://git.infradead.org/nvme-fabrics.git/shortlog/refs/heads/nvmf-selftests

This repository also contains patches from all the series posted today
in case you prefer using a git repository over collecting patches.
