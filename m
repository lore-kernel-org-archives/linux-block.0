Return-Path: <mfo@canonical.com>
From: Mauricio Faria de Oliveira <mfo@canonical.com>
To: axboe@kernel.dk
Cc: phdm@macqel.be,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.axtens@canonical.com
Subject: [PATCH 0/2] partitions/aix: fix problems due to disk corruption
Date: Wed, 25 Jul 2018 22:46:27 -0300
Message-Id: <20180726014629.30411-1-mfo@canonical.com>
List-ID: <linux-block@vger.kernel.org>

We've recently received a disk image from an AIX LUN that when
attached on Linux displayed errors on console, then eventually
hung the system.

Apparently the LUN was originally installed with AIX and later
exercised with some I/O stress/overwrites which caused certain
bits to be wrong in just the right way for Linux to get a NULL
pointer and invalid data.

This is the test-case used ('--partscan' is the important bit).
  $ sudo losetup --show --find --partscan aix-lun.img

Patch 1 resolves the particular problem the disk image has.
Patch 2 improves the code a bit further (tested synthetically).

Mauricio Faria de Oliveira (2):
  partitions/aix: fix usage of uninitialized lv_info and lvname
    structures
  partitions/aix: append null character to print data from disk

 block/partitions/aix.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.17.1
