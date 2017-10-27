Return-Path: <BATV+9dd047209a03c81ba081+5178+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 27 Oct 2017 09:23:19 +0300
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] one nvme fix for 4.14
Message-ID: <20171027062319.gvxuxxffwcfh2v4q@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

The following changes since commit f04b9cc87b5fc466b1b7231ba7b078e885956c5b:

  nvme-rdma: Fix error status return in tagset allocation failure (2017-10-19 17:13:51 +0200)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.14

for you to fetch changes up to 7db814465395f3196ee98c8bd40d214d63e4f708:

  nvme-rdma: fix possible hang when issuing commands during ctrl removal (2017-10-23 16:27:44 +0200)

----------------------------------------------------------------
Sagi Grimberg (1):
      nvme-rdma: fix possible hang when issuing commands during ctrl removal

 drivers/nvme/host/rdma.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)
