Return-Path: <konrad.wilk@oracle.com>
Date: Wed, 29 Jun 2016 12:39:49 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: axboe@kernel.dk, linux-kernel@vger.kernel.org,
        xen-devel@lists.xensource.com, linux-block@vger.kernel.org
Cc: bob.liu@oracle.com
Subject: [GIT PULL] (Xen) stable/for-jens-4.7 for v4.7-rc5
Message-ID: <20160629163949.GA5631@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hey Jens,

Please git pull the 'stable/for-jens-4.7' branch which is based on your
'for-4.7/drivers' branch. It will nicely merge in your 'for-linus' branch:

git pull git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git stable/for-jens-4.7

which has one fix for migration of guest. We found that if we migrate the
guest from a host that has multi-queue to an older (or vice-versa) we would
lose outstanding I/Os as we did not recreate all the queues properly and lost
the I/Os.

Please pull!

P.S.
I've also also put stable@vger.kernel.org on the patch.

 drivers/block/xen-blkfront.c | 91 +++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 51 deletions(-)

Bob Liu (1):
      xen-blkfront: save uncompleted reqs in blkfront_resume()
