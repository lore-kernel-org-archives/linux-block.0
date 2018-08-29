Return-Path: <BATV+de2227753eccc57eb1b5+5484+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 29 Aug 2018 18:51:14 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 4.19
Message-ID: <20180829165114.GA15464@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

The following changes since commit db193954ed9e35701b6e489fa4cc97b08589341b:

  block: bsg: move atomic_t ref_count variable to refcount API (2018-08-27 19:17:02 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.19

for you to fetch changes up to 04db0e5ec58167364a80fd33ddb4f3b67434eb85:

  nvmet: free workqueue object if module init fails (2018-08-28 08:40:44 +0200)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvmet: free workqueue object if module init fails

James Smart (1):
      nvme-fcloop: Fix dropped LS's to removed target port

Michal Wnukowski (1):
      nvme-pci: add a memory barrier to nvme_dbbuf_update_and_check_event

 drivers/nvme/host/pci.c      | 8 ++++++++
 drivers/nvme/target/core.c   | 4 +++-
 drivers/nvme/target/fcloop.c | 3 ++-
 3 files changed, 13 insertions(+), 2 deletions(-)
