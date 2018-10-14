Return-Path: <schmitzmic@gmail.com>
Return-Path: <schmitzmic@gmail.com>
Subject: [PATCH v6 0/2] Amiga RDB partition support fixes
To: linux-block@vger.kernel.org, axboe@kernel.dk
References: <1539492515-1782-1-git-send-email-schmitzmic@gmail.com>
Cc: linux-m68k@vger.kernel.org, geert@linux-m68k.org
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <aa67b36b-4c98-dc16-54f5-109080792396@gmail.com>
Date: Sun, 14 Oct 2018 17:51:01 +1300
MIME-Version: 1.0
In-Reply-To: <1539492515-1782-1-git-send-email-schmitzmic@gmail.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
List-ID: <linux-block@vger.kernel.org>

(resend - managed to lose $subject, sorry)

Am 14.10.2018 um 17:48 schrieb Michael Schmitz:
> and yet another new version of the Amiga RDB partition table patch.
>
> I've split off the part fixing the incorrect use of signed int
> for partition start address and size as separate patch. It does fix the
> bug that Martin Steigerwald reported six years ago for a 2 TB disk.
> I have tested this patch with the identical RDB partition data that
> Martin saw the bug with. I have incorporated Andreas' feedback on proper
> use of casts to avoid integer overflow in this version.
>
> The simple fix still leaves ample room for overflows in calculating start
> address and size of a RDB partition, though such overflows should only be
> seen in rather unusual cases. To address these potential overflows, checks
> are added in the second patch of this series. Again, misuse of casts have
> been corrected, and yet another (highly unlikely) potential 32 bit
> multiplication overflow caused by use of signed int instead of sector
> (spotted by Geert Uytterhoeven) has been fixed and a check has been added
> in this version.
>
> I've added Geert's Reviewed-by tag to patch 1,as there were no further
> changes to that patch.
>
> Cheers,
>
>         Michael
>
>
