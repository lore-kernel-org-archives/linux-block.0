Return-Path: <jikos@kernel.org>
Date: Thu, 16 Jun 2016 09:53:58 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Wim Osterholt <wim@djo.tudelft.nl>, Jens Axboe <axboe@kernel.dk>
cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH] floppy: fix open(O_ACCMODE) for ioctl-only open
In-Reply-To: <20160615224722.GA9545@djo.tudelft.nl>
Message-ID: <alpine.LNX.2.00.1606160946000.6874@cbobk.fhfr.pm>
References: <20160610230255.GA27770@djo.tudelft.nl> <alpine.LNX.2.00.1606131414420.6874@cbobk.fhfr.pm> <20160614184308.GA6188@djo.tudelft.nl> <alpine.LNX.2.00.1606150906320.6874@cbobk.fhfr.pm> <20160615132040.GZ14480@ZenIV.linux.org.uk>
 <alpine.LNX.2.00.1606151610420.6874@cbobk.fhfr.pm> <20160615224722.GA9545@djo.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

From: Jiri Kosina <jkosina@suse.cz>

Commit 09954bad4 ("floppy: refactor open() flags handling"), as a 
side-effect, causes open(/dev/fdX, O_ACCMODE) to fail. It turns out that 
this is being used setfdprm userspace for ioctl-only open().

Reintroduce back the original behavior wrt !(FMODE_READ|FMODE_WRITE) 
modes, while still keeping the original O_NDELAY bug fixed.

Cc: stable@vger.kernel.org # v4.5+
Reported-by: Wim Osterholt <wim@djo.tudelft.nl>
Tested-by: Wim Osterholt <wim@djo.tudelft.nl>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

Jens, this should preferably go into 4.7-rcX and to -stable as well.

 drivers/block/floppy.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 84708a5..a1dcf12 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3663,11 +3663,6 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 
 	opened_bdev[drive] = bdev;
 
-	if (!(mode & (FMODE_READ|FMODE_WRITE))) {
-		res = -EINVAL;
-		goto out;
-	}
-
 	res = -ENXIO;
 
 	if (!floppy_track_buffer) {
@@ -3711,13 +3706,15 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 	if (UFDCS->rawcmd == 1)
 		UFDCS->rawcmd = 2;
 
-	UDRS->last_checked = 0;
-	clear_bit(FD_OPEN_SHOULD_FAIL_BIT, &UDRS->flags);
-	check_disk_change(bdev);
-	if (test_bit(FD_DISK_CHANGED_BIT, &UDRS->flags))
-		goto out;
-	if (test_bit(FD_OPEN_SHOULD_FAIL_BIT, &UDRS->flags))
-		goto out;
+	if (mode & (FMODE_READ|FMODE_WRITE)) {
+		UDRS->last_checked = 0;
+		clear_bit(FD_OPEN_SHOULD_FAIL_BIT, &UDRS->flags);
+		check_disk_change(bdev);
+		if (test_bit(FD_DISK_CHANGED_BIT, &UDRS->flags))
+			goto out;
+		if (test_bit(FD_OPEN_SHOULD_FAIL_BIT, &UDRS->flags))
+			goto out;
+	}
 
 	res = -EROFS;
 
-- 
Jiri Kosina
SUSE Labs
