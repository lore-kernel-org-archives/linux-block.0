Return-Path: <BATV+b628242e4f103a69f336+5255+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 12 Jan 2018 16:09:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] one nvme fix for Linux 4.15
Message-ID: <20180112150913.yu6cs6xzn5vue3v3@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

The following changes since commit 254beb84faccbe2f4eda0b51924857bdfb679969:

  nvme-fcloop: avoid possible uninitialized variable warning (2017-12-29 10:37:21 +0100)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.15

for you to fetch changes up to 6b018235b4daabae96d855219fae59c3fb8be417:

  nvme-fabrics: initialize default host->id in nvmf_host_default() (2018-01-08 10:52:03 +0100)

----------------------------------------------------------------
Ewan D. Milne (1):
      nvme-fabrics: initialize default host->id in nvmf_host_default()

 drivers/nvme/host/fabrics.c | 1 +
 1 file changed, 1 insertion(+)
