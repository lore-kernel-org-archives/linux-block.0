Return-Path: <jgross@suse.com>
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org
Cc: konrad.wilk@oracle.com,
	roger.pau@citrix.com,
	axboe@kernel.dk,
	boris.ostrovsky@oracle.com,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH 0/4] xen/blk: persistent grant rework
Date: Mon,  6 Aug 2018 13:33:58 +0200
Message-Id: <20180806113403.24728-1-jgross@suse.com>
List-ID: <linux-block@vger.kernel.org>

Persistent grants are used in the Xen's blkfront/blkback drivers to
avoid mapping/unmapping of I/O buffers in the backend for each I/O.

While this speeds up processing quite a bit there are problems related
to persistent grants in some configurations: domains with multiple
block devices making use of persistent grants might suffer from a lack
of grants if each of the block devices experienced a high I/O load at
some time. This is due to the number of persistent grants per device
only to be limited by a rather high maximum value, but never being
released even in case of longer times without any I/O.

This series modifies xen-blkback to unmap any domU page mapped via a
persistent grant after a timeout (default: 60 seconds). The timeout
is set to its default value again when a persistent grant has been
used for an I/O.

xen-blkfront is modified to scan every 10 seconds for persistent grants
not in use by blkback any more and to remove such grants.

The last 2 patches are small cleanups of blkfront and blkback drivers.

Juergen Gross (4):
  xen/blkback: don't keep persistent grants too long
  xen/blkfront: cleanup stale persistent grants
  xen/blkfront: reorder tests in xlblk_init()
  xen/blkback: remove unused pers_gnts_lock from struct xen_blkif_ring

 drivers/block/xen-blkback/blkback.c |  77 +++++++++++++++---------
 drivers/block/xen-blkback/common.h  |   2 +-
 drivers/block/xen-blkfront.c        | 115 ++++++++++++++++++++++++++++++++----
 3 files changed, 153 insertions(+), 41 deletions(-)

-- 
2.13.7
