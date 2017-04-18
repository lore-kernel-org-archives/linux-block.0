Return-Path: <konrad.wilk@oracle.com>
Date: Tue, 18 Apr 2017 14:31:23 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: linux-block@vger.kernel.org, axboe@kernel.dk,
        xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] (xen) stable/for-jens-4.12
Message-ID: <20170418183123.GA26293@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hey Jens,

Please git pull the following branch:

git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git stable/for-jens-4.12

which is based on your 'for-4.12/block' branch. It has one fix - to emit an
uevent whenever the size of the guest disk image changes.

Please pull!

 drivers/block/xen-blkfront.c | 3 +++
 1 file changed, 3 insertions(+)

Marc Olson (1):
      blkfront: add uevent for size change
