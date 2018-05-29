Return-Path: <BATV+a01a3e67072ae75c0352+5392+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 29 May 2018 20:51:48 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme one-liner fix for 4.17
Message-ID: <20180529185148.GA30983@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

below is a one-liner fix from Max that unbreaks T10-DIF support, which
got broken in 4.15.

The following changes since commit eedffa28c9b00ca2dcb4d541b5a530f4c917052d:

  loop: clear wb_err in bd_inode when detaching backing file (2018-05-21 12:36:03 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.17

for you to fetch changes up to c97f414c54a255f4f05a50a2625efaeee406e134:

  nvme: fix extended data LBA supported setting (2018-05-29 20:29:16 +0200)

----------------------------------------------------------------
Max Gurtovoy (1):
      nvme: fix extended data LBA supported setting

 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
