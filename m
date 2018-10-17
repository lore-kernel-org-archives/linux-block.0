Return-Path: <BATV+09575c8a9ff34f5a189b+5533+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 17 Oct 2018 08:38:59 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for 4.19
Message-ID: <20181017063859.GA7083@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

The following changes since commit 133424a207774d3d32a38d560c6469ed31c0472f:

  Merge branch 'nvme-4.19' of git://git.infradead.org/nvme into for-linus (2018-09-28 09:41:40 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.19

for you to fetch changes up to 48f78be3326052a7718678ff9a78d6d884a50323:

  nvme: remove ns sibling before clearing path (2018-10-08 11:53:42 +0200)

----------------------------------------------------------------
Keith Busch (1):
      nvme: remove ns sibling before clearing path

 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
