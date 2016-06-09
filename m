Return-Path: <konrad.wilk@oracle.com>
Date: Thu, 9 Jun 2016 09:34:17 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xensource.com
Cc: bob.liu@oracle.com
Subject: [GIT PULL] (stable/for-jens-4.7) Xen block fixes for v4.7
Message-ID: <20160609133417.GA15953@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hey Jens,

Please git pull in your 'for-4.7/drivers' the following
branch (based of your 'for-4.7/drivers):

 git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git stable/for-jens-4.7

which has two fixes for a guest migrating from host that
has multi-queue to one without it (and vice-versa).

Thanks!

 drivers/block/xen-blkfront.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

Bob Liu (2):
      xen-blkfront: don't call talk_to_blkback when already connected to blkback
      xen-blkfront: fix resume issues after a migration
