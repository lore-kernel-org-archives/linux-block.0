Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46969 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753100AbdKIOoH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Nov 2017 09:44:07 -0500
Date: Thu, 9 Nov 2017 06:44:02 -0800 (PST)
From: Richard Narron <comet.berkeley@gmail.com>
To: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        YLT <yannick.leteigner@gmail.com>
Subject: [PATCH 1/1] partitions/msdos: Unable to mount UFS 44bsd partitions
Message-ID: <alpine.LNX.2.21.1711090629440.7303@joy.test>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

UFS partitions from newer versions of FreeBSD 10 and 11 use relative addressing
for their subpartitions. But older versions of FreeBSD still use absolute
addressing just like OpenBSD and NetBSD.

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
