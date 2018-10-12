Return-Path: <schmitzmic@gmail.com>
Return-Path: <schmitzmic@gmail.com>
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-block@vger.kernel.org,
	axboe@kernel.dk
Cc: linux-m68k@vger.kernel.org,
	geert@linux-m68k.org
Subject: [PATCH v5 0/2] Amiga RDB partition support fixes
Date: Fri, 12 Oct 2018 13:26:56 +1300
Message-Id: <1539304018-11786-1-git-send-email-schmitzmic@gmail.com>
List-ID: <linux-block@vger.kernel.org>

yet another new version of the Amiga RDB partition table patch. 
I've split off the part fixing the incorrect use of signed int    
for partition start address and size as separate patch. This change
should be incontroversial (I hope). It does fix the bug that Martin   
Steigerwald reported six years ago for a 2 TB disk. I have tested this
patch with the identical RDB partition data that Martin saw the bug with.
I have incorporated Andreas' feedback on proper use of casts to avoid
integer overflow in this version.

The simple fix still leaves ample room for overflows in calculating start
address and size of a RDB partition, though such overflows should only be
seen in rather unusual cases. To address these potential overflows, checks
are added in the second patch of this series.

The use of u64 instead of sector_t in the second patch is required to catch
overflows even in cases where sector_t is 32 bit wide (i.e. no LBD support).

Cheers,

	Michael
