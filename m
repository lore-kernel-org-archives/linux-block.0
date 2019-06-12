Return-Path: <SRS0=leUH=UL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E55AC31E46
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 17:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4E6217F5
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 17:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560361995;
	bh=HWvduH1TnXwBd5UFqBXJTkz6Oam1BkoX/KTDyqRAPI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jw5Q17Y0OzEC7EthsJlQQRByJW1PwATjPt5bPFVWcS+fmYUxFh9rfkQwjzvULm5nb
	 n4JFdcHawCRoZOCTZvBwq4pubRo5k3Bu6adfRgJW6D2SywMn0MLrciyhv5yevAeH7m
	 g6slcy/syfymIrHJTDVfl6k/S3jdORr5VwtEtafM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388707AbfFLRxN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:53:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388532AbfFLRxN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jun 2019 13:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Pqdf0/0XS7WCGA89rj7UaHgrduIuFR1xK+sObvyikZM=; b=YV39z6J0/72+L2vvRP+TXx1iKi
        w8gW/8E5+nEkcc6tEiIuuMtzGVx8ctEuomrS3NaCKCTwQRr3FxMUo795PUaH37nWWD8+382bVT77A
        6llXzq9ZGXK0vYEN+pRWBc4g/HU6gg8oYTcCemu/e5T1Ic6h7/HgdJ7cYedvZJ+A9aK9i2FMhW5fn
        +IiAD5h66YbgEMlPkWDFzSAdenYgc8igHluwRI1LiY5if4qsrwzOwP7hkgcIwuHkl1P3tDp6lzVNY
        C/FjIiFW5Jzhv3cVh6Qhulwbs/2PeFkaS96oRq69xH1B2VqVKrYEqo8VqBm2znFTz7iDT1uztQcIu
        gdpD2QtA==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb7Qt-0002DW-1w; Wed, 12 Jun 2019 17:53:11 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb7Qq-0001fs-1X; Wed, 12 Jun 2019 14:53:08 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jens Axboe <axboe@kernel.dk>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH v4 04/28] docs: cdrom: convert docs to ReST and rename to *.rst
Date:   Wed, 12 Jun 2019 14:52:40 -0300
Message-Id: <af70e8c245924f2cb5a637776790fb0fe5848614.1560361364.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560361364.git.mchehab+samsung@kernel.org>
References: <cover.1560361364.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The stuff there is almost already at ReST format. A
conversion for them is trivial: just add a missing titles
and fix some scape codes for them to match ReST syntax.

While here, rename the cdrom-standard.txt, with was converted
from LaTeX to ReST on the previous patch, and add it to the
index file.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 ...{cdrom-standard.txt => cdrom-standard.rst} |   0
 Documentation/cdrom/{ide-cd => ide-cd.rst}    | 178 +++++++++---------
 Documentation/cdrom/index.rst                 |  19 ++
 ...{packet-writing.txt => packet-writing.rst} |  27 ++-
 MAINTAINERS                                   |   2 +-
 drivers/block/Kconfig                         |   2 +-
 drivers/cdrom/cdrom.c                         |   2 +-
 drivers/ide/ide-cd.c                          |   2 +-
 8 files changed, 131 insertions(+), 101 deletions(-)
 rename Documentation/cdrom/{cdrom-standard.txt => cdrom-standard.rst} (100%)
 rename Documentation/cdrom/{ide-cd => ide-cd.rst} (84%)
 create mode 100644 Documentation/cdrom/index.rst
 rename Documentation/cdrom/{packet-writing.txt => packet-writing.rst} (91%)

diff --git a/Documentation/cdrom/cdrom-standard.txt b/Documentation/cdrom/cdrom-standard.rst
similarity index 100%
rename from Documentation/cdrom/cdrom-standard.txt
rename to Documentation/cdrom/cdrom-standard.rst
diff --git a/Documentation/cdrom/ide-cd b/Documentation/cdrom/ide-cd.rst
similarity index 84%
rename from Documentation/cdrom/ide-cd
rename to Documentation/cdrom/ide-cd.rst
index a5f2a7f1ff46..dadc94ef6b6c 100644
--- a/Documentation/cdrom/ide-cd
+++ b/Documentation/cdrom/ide-cd.rst
@@ -1,18 +1,20 @@
 IDE-CD driver documentation
-Originally by scott snyder  <snyder@fnald0.fnal.gov> (19 May 1996)
-Carrying on the torch is: Erik Andersen <andersee@debian.org>
-New maintainers (19 Oct 1998): Jens Axboe <axboe@image.dk>
+===========================
+
+:Originally by: scott snyder  <snyder@fnald0.fnal.gov> (19 May 1996)
+:Carrying on the torch is: Erik Andersen <andersee@debian.org>
+:New maintainers (19 Oct 1998): Jens Axboe <axboe@image.dk>
 
 1. Introduction
 ---------------
 
-The ide-cd driver should work with all ATAPI ver 1.2 to ATAPI 2.6 compliant 
+The ide-cd driver should work with all ATAPI ver 1.2 to ATAPI 2.6 compliant
 CDROM drives which attach to an IDE interface.  Note that some CDROM vendors
 (including Mitsumi, Sony, Creative, Aztech, and Goldstar) have made
 both ATAPI-compliant drives and drives which use a proprietary
 interface.  If your drive uses one of those proprietary interfaces,
 this driver will not work with it (but one of the other CDROM drivers
-probably will).  This driver will not work with `ATAPI' drives which
+probably will).  This driver will not work with `ATAPI` drives which
 attach to the parallel port.  In addition, there is at least one drive
 (CyCDROM CR520ie) which attaches to the IDE port but is not ATAPI;
 this driver will not work with drives like that either (but see the
@@ -31,7 +33,7 @@ This driver provides the following features:
    from audio tracks.  The program cdda2wav can be used for this.
    Note, however, that only some drives actually support this.
 
- - There is now support for CDROM changers which comply with the 
+ - There is now support for CDROM changers which comply with the
    ATAPI 2.6 draft standard (such as the NEC CDR-251).  This additional
    functionality includes a function call to query which slot is the
    currently selected slot, a function call to query which slots contain
@@ -49,11 +51,11 @@ This driver provides the following features:
    driver.
 
 1. Make sure that the ide and ide-cd drivers are compiled into the
-   kernel you're using.  When configuring the kernel, in the section 
-   entitled "Floppy, IDE, and other block devices", say either `Y' 
-   (which will compile the support directly into the kernel) or `M'
+   kernel you're using.  When configuring the kernel, in the section
+   entitled "Floppy, IDE, and other block devices", say either `Y`
+   (which will compile the support directly into the kernel) or `M`
    (to compile support as a module which can be loaded and unloaded)
-   to the options: 
+   to the options::
 
       ATA/ATAPI/MFM/RLL support
       Include IDE/ATAPI CDROM support
@@ -72,35 +74,35 @@ This driver provides the following features:
    address and an IRQ number, the standard assignments being
    0x1f0 and 14 for the primary interface and 0x170 and 15 for the
    secondary interface.  Each interface can control up to two devices,
-   where each device can be a hard drive, a CDROM drive, a floppy drive, 
-   or a tape drive.  The two devices on an interface are called `master'
-   and `slave'; this is usually selectable via a jumper on the drive.
+   where each device can be a hard drive, a CDROM drive, a floppy drive,
+   or a tape drive.  The two devices on an interface are called `master`
+   and `slave`; this is usually selectable via a jumper on the drive.
 
    Linux names these devices as follows.  The master and slave devices
-   on the primary IDE interface are called `hda' and `hdb',
+   on the primary IDE interface are called `hda` and `hdb`,
    respectively.  The drives on the secondary interface are called
-   `hdc' and `hdd'.  (Interfaces at other locations get other letters
+   `hdc` and `hdd`.  (Interfaces at other locations get other letters
    in the third position; see Documentation/ide/ide.txt.)
 
    If you want your CDROM drive to be found automatically by the
    driver, you should make sure your IDE interface uses either the
    primary or secondary addresses mentioned above.  In addition, if
    the CDROM drive is the only device on the IDE interface, it should
-   be jumpered as `master'.  (If for some reason you cannot configure
+   be jumpered as `master`.  (If for some reason you cannot configure
    your system in this manner, you can probably still use the driver.
    You may have to pass extra configuration information to the kernel
    when you boot, however.  See Documentation/ide/ide.txt for more
    information.)
 
 4. Boot the system.  If the drive is recognized, you should see a
-   message which looks like
+   message which looks like::
 
      hdb: NEC CD-ROM DRIVE:260, ATAPI CDROM drive
 
    If you do not see this, see section 5 below.
 
 5. You may want to create a symbolic link /dev/cdrom pointing to the
-   actual device.  You can do this with the command
+   actual device.  You can do this with the command::
 
      ln -s  /dev/hdX  /dev/cdrom
 
@@ -108,14 +110,14 @@ This driver provides the following features:
    drive is installed.
 
 6. You should be able to see any error messages from the driver with
-   the `dmesg' command.
+   the `dmesg` command.
 
 
 3. Basic usage
 --------------
 
-An ISO 9660 CDROM can be mounted by putting the disc in the drive and 
-typing (as root)
+An ISO 9660 CDROM can be mounted by putting the disc in the drive and
+typing (as root)::
 
   mount -t iso9660 /dev/cdrom /mnt/cdrom
 
@@ -123,7 +125,7 @@ where it is assumed that /dev/cdrom is a link pointing to the actual
 device (as described in step 5 of the last section) and /mnt/cdrom is
 an empty directory.  You should now be able to see the contents of the
 CDROM under the /mnt/cdrom directory.  If you want to eject the CDROM,
-you must first dismount it with a command like
+you must first dismount it with a command like::
 
   umount /mnt/cdrom
 
@@ -148,7 +150,7 @@ such as cdda2wav.  The only types of drive which I've heard support
 this are Sony and Toshiba drives.  You will get errors if you try to
 use this function on a drive which does not support it.
 
-For supported changers, you can use the `cdchange' program (appended to
+For supported changers, you can use the `cdchange` program (appended to
 the end of this file) to switch between changer slots.  Note that the
 drive should be unmounted before attempting this.  The program takes
 two arguments:  the CDROM device, and the slot number to which you wish
@@ -165,7 +167,7 @@ Documentation/ide/ide.txt for current information about the underlying
 IDE support code.  Some of these items apply only to earlier versions
 of the driver, but are mentioned here for completeness.
 
-In most cases, you should probably check with `dmesg' for any errors
+In most cases, you should probably check with `dmesg` for any errors
 from the driver.
 
 a. Drive is not detected during booting.
@@ -184,9 +186,9 @@ a. Drive is not detected during booting.
 
    - If the autoprobing is not finding your drive, you can tell the
      driver to assume that one exists by using a lilo option of the
-     form `hdX=cdrom', where X is the drive letter corresponding to
-     where your drive is installed.  Note that if you do this and you 
-     see a boot message like
+     form `hdX=cdrom`, where X is the drive letter corresponding to
+     where your drive is installed.  Note that if you do this and you
+     see a boot message like::
 
        hdX: ATAPI cdrom (?)
 
@@ -220,7 +222,7 @@ b. Timeout/IRQ errors.
     probably not making it to the host.
 
   - IRQ problems may also be indicated by the message
-    `IRQ probe failed (<n>)' while booting.  If <n> is zero, that
+    `IRQ probe failed (<n>)` while booting.  If <n> is zero, that
     means that the system did not see an interrupt from the drive when
     it was expecting one (on any feasible IRQ).  If <n> is negative,
     that means the system saw interrupts on multiple IRQ lines, when
@@ -240,27 +242,27 @@ b. Timeout/IRQ errors.
     there are hardware problems with the interrupt setup; they
     apparently don't use interrupts.
 
-  - If you own a Pioneer DR-A24X, you _will_ get nasty error messages 
+  - If you own a Pioneer DR-A24X, you _will_ get nasty error messages
     on boot such as "irq timeout: status=0x50 { DriveReady SeekComplete }"
     The Pioneer DR-A24X CDROM drives are fairly popular these days.
     Unfortunately, these drives seem to become very confused when we perform
     the standard Linux ATA disk drive probe. If you own one of these drives,
-    you can bypass the ATA probing which confuses these CDROM drives, by 
-    adding `append="hdX=noprobe hdX=cdrom"' to your lilo.conf file and running 
-    lilo (again where X is the drive letter corresponding to where your drive 
+    you can bypass the ATA probing which confuses these CDROM drives, by
+    adding `append="hdX=noprobe hdX=cdrom"` to your lilo.conf file and running
+    lilo (again where X is the drive letter corresponding to where your drive
     is installed.)
-    
+
 c. System hangups.
 
   - If the system locks up when you try to access the CDROM, the most
     likely cause is that you have a buggy IDE adapter which doesn't
     properly handle simultaneous transactions on multiple interfaces.
     The most notorious of these is the CMD640B chip.  This problem can
-    be worked around by specifying the `serialize' option when
+    be worked around by specifying the `serialize` option when
     booting.  Recent kernels should be able to detect the need for
     this automatically in most cases, but the detection is not
     foolproof.  See Documentation/ide/ide.txt for more information
-    about the `serialize' option and the CMD640B.
+    about the `serialize` option and the CMD640B.
 
   - Note that many MS-DOS CDROM drivers will work with such buggy
     hardware, apparently because they never attempt to overlap CDROM
@@ -269,14 +271,14 @@ c. System hangups.
 
 d. Can't mount a CDROM.
 
-  - If you get errors from mount, it may help to check `dmesg' to see
+  - If you get errors from mount, it may help to check `dmesg` to see
     if there are any more specific errors from the driver or from the
     filesystem.
 
   - Make sure there's a CDROM loaded in the drive, and that's it's an
     ISO 9660 disc.  You can't mount an audio CD.
 
-  - With the CDROM in the drive and unmounted, try something like
+  - With the CDROM in the drive and unmounted, try something like::
 
       cat /dev/cdrom | od | more
 
@@ -284,9 +286,9 @@ d. Can't mount a CDROM.
     OK, and the problem is at the filesystem level (i.e., the CDROM is
     not ISO 9660 or has errors in the filesystem structure).
 
-  - If you see `not a block device' errors, check that the definitions
+  - If you see `not a block device` errors, check that the definitions
     of the device special files are correct.  They should be as
-    follows:
+    follows::
 
       brw-rw----   1 root     disk       3,   0 Nov 11 18:48 /dev/hda
       brw-rw----   1 root     disk       3,  64 Nov 11 18:48 /dev/hdb
@@ -301,7 +303,7 @@ d. Can't mount a CDROM.
     If you have a /dev/cdrom symbolic link, check that it is pointing
     to the correct device file.
 
-    If you hear people talking of the devices `hd1a' and `hd1b', these
+    If you hear people talking of the devices `hd1a` and `hd1b`, these
     were old names for what are now called hdc and hdd.  Those names
     should be considered obsolete.
 
@@ -311,8 +313,8 @@ d. Can't mount a CDROM.
     always give meaningful error messages.
 
 
-e. Directory listings are unpredictably truncated, and `dmesg' shows
-   `buffer botch' error messages from the driver.
+e. Directory listings are unpredictably truncated, and `dmesg` shows
+   `buffer botch` error messages from the driver.
 
   - There was a bug in the version of the driver in 1.2.x kernels
     which could cause this.  It was fixed in 1.3.0.  If you can't
@@ -335,34 +337,36 @@ f. Data corruption.
 5. cdchange.c
 -------------
 
-/*
- * cdchange.c  [-v]  <device>  [<slot>]
- *
- * This loads a CDROM from a specified slot in a changer, and displays 
- * information about the changer status.  The drive should be unmounted before 
- * using this program.
- *
- * Changer information is displayed if either the -v flag is specified
- * or no slot was specified.
- *
- * Based on code originally from Gerhard Zuber <zuber@berlin.snafu.de>.
- * Changer status information, and rewrite for the new Uniform CDROM driver
- * interface by Erik Andersen <andersee@debian.org>.
- */
+::
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <string.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/ioctl.h>
-#include <linux/cdrom.h>
+  /*
+   * cdchange.c  [-v]  <device>  [<slot>]
+   *
+   * This loads a CDROM from a specified slot in a changer, and displays
+   * information about the changer status.  The drive should be unmounted before
+   * using this program.
+   *
+   * Changer information is displayed if either the -v flag is specified
+   * or no slot was specified.
+   *
+   * Based on code originally from Gerhard Zuber <zuber@berlin.snafu.de>.
+   * Changer status information, and rewrite for the new Uniform CDROM driver
+   * interface by Erik Andersen <andersee@debian.org>.
+   */
 
+  #include <stdio.h>
+  #include <stdlib.h>
+  #include <errno.h>
+  #include <string.h>
+  #include <unistd.h>
+  #include <fcntl.h>
+  #include <sys/ioctl.h>
+  #include <linux/cdrom.h>
 
-int
-main (int argc, char **argv)
-{
+
+  int
+  main (int argc, char **argv)
+  {
 	char *program;
 	char *device;
 	int fd;           /* file descriptor for CD-ROM device */
@@ -382,30 +386,30 @@ main (int argc, char **argv)
 		fprintf (stderr, "       Slots are numbered 1 -- n.\n");
 		exit (1);
 	}
- 
+
        if (strcmp (argv[0], "-v") == 0) {
                 verbose = 1;
                 ++argv;
                 --argc;
         }
- 
+
 	device = argv[0];
- 
+
 	if (argc == 2)
 		slot = atoi (argv[1]) - 1;
 
-	/* open device */ 
+	/* open device */
 	fd = open(device, O_RDONLY | O_NONBLOCK);
 	if (fd < 0) {
-		fprintf (stderr, "%s: open failed for `%s': %s\n",
+		fprintf (stderr, "%s: open failed for `%s`: %s\n",
 			 program, device, strerror (errno));
 		exit (1);
 	}
 
-	/* Check CD player status */ 
+	/* Check CD player status */
 	total_slots_available = ioctl (fd, CDROM_CHANGER_NSLOTS);
 	if (total_slots_available <= 1 ) {
-		fprintf (stderr, "%s: Device `%s' is not an ATAPI "
+		fprintf (stderr, "%s: Device `%s` is not an ATAPI "
 			"compliant CD changer.\n", program, device);
 		exit (1);
 	}
@@ -418,7 +422,7 @@ main (int argc, char **argv)
 			exit (1);
 		}
 
-		/* load */ 
+		/* load */
 		slot=ioctl (fd, CDROM_SELECT_DISC, slot);
 		if (slot<0) {
 			fflush(stdout);
@@ -462,14 +466,14 @@ main (int argc, char **argv)
 
 		for (x_slot=0; x_slot<total_slots_available; x_slot++) {
 			printf ("Slot %2d: ", x_slot+1);
-             		status = ioctl (fd, CDROM_DRIVE_STATUS, x_slot);
-             		if (status<0) {
-             		     perror(" CDROM_DRIVE_STATUS");
-             		} else switch(status) {
+			status = ioctl (fd, CDROM_DRIVE_STATUS, x_slot);
+			if (status<0) {
+			     perror(" CDROM_DRIVE_STATUS");
+			} else switch(status) {
 			case CDS_DISC_OK:
 				printf ("Disc present.");
 				break;
-			case CDS_NO_DISC: 
+			case CDS_NO_DISC:
 				printf ("Empty slot.");
 				break;
 			case CDS_TRAY_OPEN:
@@ -507,11 +511,11 @@ main (int argc, char **argv)
 				break;
 			}
 			}
-                  	status = ioctl (fd, CDROM_MEDIA_CHANGED, x_slot);
-                  	if (status<0) {
+			status = ioctl (fd, CDROM_MEDIA_CHANGED, x_slot);
+			if (status<0) {
 				perror(" CDROM_MEDIA_CHANGED");
-                  	}
-		  	switch (status) {
+			}
+			switch (status) {
 			case 1:
 				printf ("Changed.\n");
 				break;
@@ -525,10 +529,10 @@ main (int argc, char **argv)
 	/* close device */
 	status = close (fd);
 	if (status != 0) {
-		fprintf (stderr, "%s: close failed for `%s': %s\n",
+		fprintf (stderr, "%s: close failed for `%s`: %s\n",
 			 program, device, strerror (errno));
 		exit (1);
 	}
- 
+
 	exit (0);
-}
+  }
diff --git a/Documentation/cdrom/index.rst b/Documentation/cdrom/index.rst
new file mode 100644
index 000000000000..efbd5d111825
--- /dev/null
+++ b/Documentation/cdrom/index.rst
@@ -0,0 +1,19 @@
+:orphan:
+
+=====
+cdrom
+=====
+
+.. toctree::
+    :maxdepth: 1
+
+    cdrom-standard
+    ide-cd
+    packet-writing
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/cdrom/packet-writing.txt b/Documentation/cdrom/packet-writing.rst
similarity index 91%
rename from Documentation/cdrom/packet-writing.txt
rename to Documentation/cdrom/packet-writing.rst
index 2834170d821e..c5c957195a5a 100644
--- a/Documentation/cdrom/packet-writing.txt
+++ b/Documentation/cdrom/packet-writing.rst
@@ -1,3 +1,7 @@
+==============
+Packet writing
+==============
+
 Getting started quick
 ---------------------
 
@@ -10,13 +14,16 @@ Getting started quick
   Download from http://sourceforge.net/projects/linux-udf/
 
 - Grab a new CD-RW disc and format it (assuming CD-RW is hdc, substitute
-  as appropriate):
+  as appropriate)::
+
 	# cdrwtool -d /dev/hdc -q
 
-- Setup your writer
+- Setup your writer::
+
 	# pktsetup dev_name /dev/hdc
 
-- Now you can mount /dev/pktcdvd/dev_name and copy files to it. Enjoy!
+- Now you can mount /dev/pktcdvd/dev_name and copy files to it. Enjoy::
+
 	# mount /dev/pktcdvd/dev_name /cdrom -t udf -o rw,noatime
 
 
@@ -25,11 +32,11 @@ Packet writing for DVD-RW media
 
 DVD-RW discs can be written to much like CD-RW discs if they are in
 the so called "restricted overwrite" mode. To put a disc in restricted
-overwrite mode, run:
+overwrite mode, run::
 
 	# dvd+rw-format /dev/hdc
 
-You can then use the disc the same way you would use a CD-RW disc:
+You can then use the disc the same way you would use a CD-RW disc::
 
 	# pktsetup dev_name /dev/hdc
 	# mount /dev/pktcdvd/dev_name /cdrom -t udf -o rw,noatime
@@ -41,7 +48,7 @@ Packet writing for DVD+RW media
 According to the DVD+RW specification, a drive supporting DVD+RW discs
 shall implement "true random writes with 2KB granularity", which means
 that it should be possible to put any filesystem with a block size >=
-2KB on such a disc. For example, it should be possible to do:
+2KB on such a disc. For example, it should be possible to do::
 
 	# dvd+rw-format /dev/hdc   (only needed if the disc has never
 	                            been formatted)
@@ -54,7 +61,7 @@ follow the specification, but suffer bad performance problems if the
 writes are not 32KB aligned.
 
 Both problems can be solved by using the pktcdvd driver, which always
-generates aligned writes.
+generates aligned writes::
 
 	# dvd+rw-format /dev/hdc
 	# pktsetup dev_name /dev/hdc
@@ -83,7 +90,7 @@ Notes
 
 - Since the pktcdvd driver makes the disc appear as a regular block
   device with a 2KB block size, you can put any filesystem you like on
-  the disc. For example, run:
+  the disc. For example, run::
 
 	# /sbin/mke2fs /dev/pktcdvd/dev_name
 
@@ -97,7 +104,7 @@ Since Linux 2.6.20, the pktcdvd module has a sysfs interface
 and can be controlled by it. For example the "pktcdvd" tool uses
 this interface. (see http://tom.ist-im-web.de/download/pktcdvd )
 
-"pktcdvd" works similar to "pktsetup", e.g.:
+"pktcdvd" works similar to "pktsetup", e.g.::
 
 	# pktcdvd -a dev_name /dev/hdc
 	# mkudffs /dev/pktcdvd/dev_name
@@ -115,7 +122,7 @@ For a description of the sysfs interface look into the file:
 Using the pktcdvd debugfs interface
 -----------------------------------
 
-To read pktcdvd device infos in human readable form, do:
+To read pktcdvd device infos in human readable form, do::
 
 	# cat /sys/kernel/debug/pktcdvd/pktcdvd[0-7]/info
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 8bec064bb353..1f73ef8c25f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7644,7 +7644,7 @@ IDE/ATAPI DRIVERS
 M:	Borislav Petkov <bp@alien8.de>
 L:	linux-ide@vger.kernel.org
 S:	Maintained
-F:	Documentation/cdrom/ide-cd
+F:	Documentation/cdrom/ide-cd.rst
 F:	drivers/ide/ide-cd*
 
 IDEAPAD LAPTOP EXTRAS DRIVER
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 20bb4bfa4be6..96ec7e0fc1ea 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -347,7 +347,7 @@ config CDROM_PKTCDVD
 	  is possible.
 	  DVD-RW disks must be in restricted overwrite mode.
 
-	  See the file <file:Documentation/cdrom/packet-writing.txt>
+	  See the file <file:Documentation/cdrom/packet-writing.rst>
 	  for further information on the use of this driver.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 5d1e0a4a7d84..ac42ae4651ce 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -7,7 +7,7 @@
    License.  See linux/COPYING for more information.
 
    Uniform CD-ROM driver for Linux.
-   See Documentation/cdrom/cdrom-standard.txt for usage information.
+   See Documentation/cdrom/cdrom-standard.rst for usage information.
 
    The routines in the file provide a uniform interface between the
    software that uses CD-ROMs and the various low-level drivers that
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 3b15adc6ce98..9d117936bee1 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -9,7 +9,7 @@
  * May be copied or modified under the terms of the GNU General Public
  * License.  See linux/COPYING for more information.
  *
- * See Documentation/cdrom/ide-cd for usage information.
+ * See Documentation/cdrom/ide-cd.rst for usage information.
  *
  * Suggestions are welcome. Patches that work are more welcome though. ;-)
  *
-- 
2.21.0

