Return-Path: <BATV+0880c9c3d9be8b33d28f+5496+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 10 Sep 2018 08:02:30 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for 4.19
Message-ID: <20180910060230.GA27071@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

The following changes since commit bc811f05d77f47059c197a98b6ad242eb03999cb:

  nbd: don't allow invalid blocksize settings (2018-09-04 11:54:58 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.19

for you to fetch changes up to 8407879c4e0d7731f6e7e905893cecf61a7762c7:

  nvmet-rdma: fix possible bogus dereference under heavy load (2018-09-05 12:18:01 -0700)

----------------------------------------------------------------
Sagi Grimberg (1):
      nvmet-rdma: fix possible bogus dereference under heavy load

 drivers/nvme/target/rdma.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)
