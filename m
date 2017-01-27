Return-Path: <konrad.wilk@oracle.com>
Date: Fri, 27 Jan 2017 13:47:43 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org,
        xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org
Cc: jbeulich@suse.com
Subject: [GIT PULL] (xen-blkfront) stable/for-jens-4.10 for your 'linux-next'
 branch.
Message-ID: <20170127184743.GB31429@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hey Jens,

Please pull in your 'for-linus' branch two little fixes for Xen
block front:

git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git stable/for-jens-4.10

One fix is for handling the XEN_PAGE_SIZE != PAGE_SIZE (4KB vs 64KB
on ARM for example) mishandling while the other is fixing
the accounting for the configuration changes.

Thank you!

drivers/block/xen-blkfront.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

Jan Beulich (2):
      xen-blkfront: feature flags handling adjustments
      xen-blkfront: correct maximum segment accounting
