Return-Path: <BATV+8aad1729951f8ca32667+5211+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 29 Nov 2017 08:16:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 4.15
Message-ID: <20171129161621.ijlhfxjde6ke4r6p@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

a few more nvme updates for 4.15.  A single small PCIe fix, and a number
of patches for RDMA that are a little larger than what I'd like to see
for -rc2, but they fix important issues seen in the wild.

The following changes since commit 6c4ca1e36cdc1a0a7a84797804b87920ccbebf51:

  bcache: check return value of register_shrinker (2017-11-24 16:23:01 -0700)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.15

for you to fetch changes up to 7e5dd57ef3081ff6c03908d786ed5087f6fbb7ae:

  nvme-pci: fix NULL pointer dereference in nvme_free_host_mem() (2017-11-28 08:49:26 -0800)

----------------------------------------------------------------
Israel Rukshin (1):
      nvme-rdma: Use mr pool

Max Gurtovoy (1):
      nvme-rdma: fix memory leak during queue allocation

Minwoo Im (1):
      nvme-pci: fix NULL pointer dereference in nvme_free_host_mem()

Sagi Grimberg (4):
      nvme-rdma: don't suppress send completions
      nvme-rdma: don't complete requests before a send work request has completed
      nvme-rdma: wait for local invalidation before completing a request
      nvme-rdma: Check remotely invalidated rkey matches our expected rkey

 drivers/nvme/host/pci.c  |   1 +
 drivers/nvme/host/rdma.c | 234 ++++++++++++++++++++++++-----------------------
 2 files changed, 119 insertions(+), 116 deletions(-)
