Return-Path: <schmitzmic@gmail.com>
Return-Path: <schmitzmic@gmail.com>
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-block@vger.kernel.org,
	axboe@kernel.dk
Cc: linux-m68k@vger.kernel.org,
	geert@linux-m68k.org
Subject: [PATCH v7 0/2] Amiga RDB partition support fixes
Date: Mon, 15 Oct 2018 15:32:25 +1300
Message-Id: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com>
List-ID: <linux-block@vger.kernel.org>

(hopefully) final version of the Amiga RDB partition table patch follows.
 
I've split off the part fixing the incorrect use of signed int
for partition start address and size as separate patch. It does fix the
bug that Martin Steigerwald reported six years ago for a 2 TB disk.
I have tested this patch with the identical RDB partition data that
Martin saw the bug with. I have incorporated Andreas' feedback on proper
use of casts to avoid integer overflow in this version.

The simple fix still leaves ample room for overflows in calculating start
address and size of a RDB partition, though such overflows should only be 
seen in rather unusual cases. To address these potential overflows, checks
are added in the second patch of this series. Comments by Geert have been   
addressed in full. 

Both patches now reviewed by Geert - Reviewed-by tags added. 

Cheers,

        Michael
