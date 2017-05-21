Return-Path: <comet.berkeley@gmail.com>
Return-Path: <comet.berkeley@gmail.com>
Date: Sun, 21 May 2017 12:47:01 -0700 (PDT)
From: Richard Narron <comet.berkeley@gmail.com>
To: linux-block@vger.kernel.org
cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
    Andries Brouwer <aeb@cwi.nl>
Subject: [PATCH v2 1/1] partitions/msdos: FreeBSD UFS2 file systems are not
 recognized
Message-ID: <alpine.LNX.2.21.1705211245010.2353@joy.test>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

The code in block/partitions/msdos.c recognizes FreeBSD, OpenBSD
and NetBSD partitions and does a reasonable job picking out OpenBSD
and NetBSD UFS subpartitions.

But for FreeBSD the subpartitions are always "bad".

     Kernel: <bsd:bad subpartition - ignored

Though all 3 of these BSD systems use UFS as a file system, only
FreeBSD uses relative start addresses in the subpartition
declarations.

The following patch fixes this for FreeBSD partitions and leaves
the code for OpenBSD and NetBSD intact:

Signed-off-by: Richard Narron <comet.berkeley@gmail.com>
---
Changelog v1->v2:
- Improve style, use += 
---
  block/partitions/msdos.c | 2 ++
  1 file changed, 2 insertions(+)

--- a/block/partitions/msdos.c	2015-12-27 18:17:37.000000000 -0800
+++ b/block/partitions/msdos.c	2015-12-29 10:44:25.813773357 -0800
@@ -300,6 +300,8 @@ static void parse_bsd(struct parsed_part
  			continue;
  		bsd_start = le32_to_cpu(p->p_offset);
  		bsd_size = le32_to_cpu(p->p_size);
+		if (memcmp(flavour, "bsd\0", 4) == 0)
+			bsd_start += offset;
  		if (offset == bsd_start && size == bsd_size)
  			/* full parent partition, we have it already */
  			continue;
