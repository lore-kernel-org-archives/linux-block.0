Return-Path: <marmarek@invisiblethingslab.com>
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: xen-devel@lists.xenproject.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Juergen Gross <jgross@suse.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	stable@vger.kernel.org
Subject: [PATCH 0/6] Fix XSA-155-like bugs in frontend drivers
Date: Mon, 30 Apr 2018 23:01:44 +0200
Message-Id: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Patches in original Xen Security Advisory 155 cared only about backend drivers
while leaving frontend patches to be "developed and released (publicly) after
the embargo date". This is said series.

Marek Marczykowski-Górecki (6):
  xen: Add RING_COPY_RESPONSE()
  xen-netfront: copy response out of shared buffer before accessing it
  xen-netfront: do not use data already exposed to backend
  xen-netfront: add range check for Tx response id
  xen-blkfront: make local copy of response before using it
  xen-blkfront: prepare request locally, only then put it on the shared ring

 drivers/block/xen-blkfront.c    | 110 ++++++++++++++++++---------------
 drivers/net/xen-netfront.c      |  61 +++++++++---------
 include/xen/interface/io/ring.h |  14 ++++-
 3 files changed, 106 insertions(+), 79 deletions(-)

base-commit: 6d08b06e67cd117f6992c46611dfb4ce267cd71e
-- 
git-series 0.9.1
