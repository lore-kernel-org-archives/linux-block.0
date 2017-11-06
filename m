Return-Path: <comet.berkeley@gmail.com>
Return-Path: <comet.berkeley@gmail.com>
Date: Mon, 6 Nov 2017 15:25:32 -0800 (PST)
From: Richard Narron <comet.berkeley@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
cc: linux-block@vger.kernel.org
Subject: [Patch 1/1] partitions/msdos: Unable to mount UFS 44bsd partitions
Message-ID: <alpine.LNX.2.21.1711061520030.2849@joy.test>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

UFS partitions from newer versions of FreeBSD 10 and 11 use 
relative addressing for their subpartitions. 
But older versions of FreeBSD still use absolute addressing just like 
OpenBSD and NetBSD.

Instead of simply testing for a FreeBSD partition, the code needs to also
test if the starting offset of the C subpartition is zero.

https://bugzilla.kernel.org/show_bug.cgi?id=197733

Signed-off-by: Richard Narron <comet.berkeley@gmail.com>
---

--- a/block/partitions/msdos.c.orig	2017-11-05 13:05:14.000000000 -0800
+++ b/block/partitions/msdos.c	2017-11-06 09:46:00.148228242 -0800
@@ -301,7 +301,9 @@ static void parse_bsd(struct parsed_part
  			continue;
  		bsd_start = le32_to_cpu(p->p_offset);
  		bsd_size = le32_to_cpu(p->p_size);
-		if (memcmp(flavour, "bsd\0", 4) == 0)
+		/* FreeBSD has relative offset if C partition offset is zero */
+		if (memcmp(flavour, "bsd\0", 4) == 0 &&
+		    le32_to_cpu(l->d_partitions[2].p_offset) == 0)
  			bsd_start += offset;
  		if (offset == bsd_start && size == bsd_size)
  			/* full parent partition, we have it already */
