Return-Path: <BATV+da9bc55dc8984c6037d5+5514+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 28 Sep 2018 08:40:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 4.19
Message-ID: <20180928154003.GA3163@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

The following changes since commit b228ba1cb95afbaeeb86cf06cd9fd6f6369c3b14:

  null_blk: fix zoned support for non-rq based operation (2018-09-12 18:21:11 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.19

for you to fetch changes up to bb830add192e9d8338082c0fc2c209e23b43d865:

  nvme: properly propagate errors in nvme_mpath_init (2018-09-25 16:21:40 -0700)

----------------------------------------------------------------
Hannes Reinecke (1):
      nvme: count all ANA groups for ANA Log page

Susobhan Dey (1):
      nvme: properly propagate errors in nvme_mpath_init

 drivers/nvme/host/multipath.c   | 6 ++++--
 drivers/nvme/target/admin-cmd.c | 4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)
