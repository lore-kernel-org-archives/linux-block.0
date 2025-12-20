Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5FE1B81CA
	for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766235521; cv=none; b=eLtjUVO/EVfE4hcv+Kr9ouLNKpHh4JY8NZKFrouBD07qx0DVHbcor0YNX0COKx5AH9RZ8WsIrSZLkJIdFFEi3v4BdhqG1RxNVaUjoGMdXaxf+/0CX2p8XVmgM86LDZDq+A0IvK7a3iHktElFii1B1Ljl1nqokGtlNLKasM72iAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766235521; c=relaxed/simple;
	bh=ZDmvwxOZ9NTwwoG5I8yKdSIby6h1tQLz60sBzwtFS4I=;
	h=Date:Message-Id:To:Cc:Subject:From:Mime-Version:Content-Type; b=H3fMPOJDL5aCrueg0goqPzG1ophJtyKNPUqbX4S/bIKbFy0h1CKm7NwipnJf4cMfjva1qodMEMGoiAyhpCkp5+CnPr1BXTF2OToAPpnSwqSxhjdm8INozboahMai69stbpFdARsoTPT1DRrUNIPJfAij5QnWEGZILCRUB987myw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=nuXbbARs; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="nuXbbARs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:Cc:To
	:Message-Id:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=bIk7+Oeov4iE49MSABnClqVr3hXCaOM4JLVr8/OtUKg=; b=n
	uXbbARs7+OzEqb/SX/d7JYixx44tQue1PfiJJQfM0Ibf8xntcNgzRuDlN5DHUgpaSrRTyhJKPBg/p
	5m2kHFMfvNqpgaT2/SlMApm0miM04utkzLuffw3Cy3BMcZM8asxxVvxZlhI6/eH+DllUeylEARjyZ
	JlbUepXnnYAKLrzuuXY7BJvawrn72mzLNPVtjbUkRoeVVsdaHQWPdrU6UoQJ1fXUFjLy/YH7qNdOh
	DSRr/87W++NuMXsbIY0IefwePu8WTtGc9fOQG0Liz34dzGqBzi8wvkUGVx7/gMsH5AMvq2elEhs6O
	6FSCkXv+vESFGSzw6yvMaK2o0HHEX06qQ==;
Date: Sat, 20 Dec 2025 13:58:41 +0100 (CET)
Message-Id: <20251220.135841.1580468505634251616.rene@exactco.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] partitions: mac: fix exposing free space as partitions
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

The mac partitions code creates partitions for unallocated, free
space, and even the partition map itself. Fix by checking the VALID
and ALLOCATED bits. Fix checkpatch trailing whitespace error while at
it.

t2:/# parted /dev/sda print free
Disk /dev/sda: 34.4GB
Sector size (logical/physical): 512B/512B
Partition Table: mac
Disk Flags:
Number  Start   End     Size    File system  Name   Flags
 1      512B    32.8kB  32.3kB               Apple
        32.8kB  99.6MB  99.6MB  Free Space
 2      99.6MB  1000MB  901MB                linux
        1000MB  34.4GB  33.4GB  Free Space

before:
[   67.108282]  sda: [mac] sda1 sda2 sda3 sda4

patched:
[   67.108110]  sda: [mac] sda2

Signed-off-by: René Rebe <rene@exactco.de>
---
 block/partitions/mac.c | 9 ++++++---
 block/partitions/mac.h | 2 ++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/partitions/mac.c b/block/partitions/mac.c
index b02530d98629..fc0ba1c8ec6e 100644
--- a/block/partitions/mac.c
+++ b/block/partitions/mac.c
@@ -96,9 +96,12 @@ int mac_partition(struct parsed_partitions *state)
 		part = (struct mac_partition *) (data + pos%512);
 		if (be16_to_cpu(part->signature) != MAC_PARTITION_MAGIC)
 			break;
+		if ((be32_to_cpu(part->status) & (MAC_STATUS_VALID | MAC_STATUS_ALLOCATED)) !=
+		    (MAC_STATUS_VALID | MAC_STATUS_ALLOCATED))
+			continue;
 		put_partition(state, slot,
-			be32_to_cpu(part->start_block) * (secsize/512),
-			be32_to_cpu(part->block_count) * (secsize/512));
+				be32_to_cpu(part->start_block) * (secsize/512),
+				be32_to_cpu(part->block_count) * (secsize/512));
 
 		if (!strncasecmp(part->type, "Linux_RAID", 10))
 			state->parts[slot].flags = ADDPART_FLAG_RAID;
@@ -112,7 +115,7 @@ int mac_partition(struct parsed_partitions *state)
 
 			mac_fix_string(part->processor, 16);
 			mac_fix_string(part->name, 32);
-			mac_fix_string(part->type, 32);					
+			mac_fix_string(part->type, 32);
 		    
 			if ((be32_to_cpu(part->status) & MAC_STATUS_BOOTABLE)
 			    && strcasecmp(part->processor, "powerpc") == 0)
diff --git a/block/partitions/mac.h b/block/partitions/mac.h
index 0e41c9da7532..10828c5d53d2 100644
--- a/block/partitions/mac.h
+++ b/block/partitions/mac.h
@@ -30,6 +30,8 @@ struct mac_partition {
 	/* there is more stuff after this that we don't need */
 };
 
+#define MAC_STATUS_VALID	1	/* partition is valid */
+#define MAC_STATUS_ALLOCATED	2	/* partition is allocated */
 #define MAC_STATUS_BOOTABLE	8	/* partition is bootable */
 
 #define MAC_DRIVER_MAGIC	0x4552
-- 
2.52.0


-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe
