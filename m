Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, linux-m68k@vger.kernel.org, geert@linux-m68k.org
Subject: Re: [PATCH v5 0/2] Amiga RDB partition support fixes
Date: Fri, 12 Oct 2018 10:17:58 +0200
Message-ID: <1886580.oI6ZJUcLCv@merkaba>
In-Reply-To: <1539304018-11786-1-git-send-email-schmitzmic@gmail.com>
References: <1539304018-11786-1-git-send-email-schmitzmic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

Michael Schmitz - 12.10.18, 02:26:
> yet another new version of the Amiga RDB partition table patch.
> I've split off the part fixing the incorrect use of signed int
> for partition start address and size as separate patch. This change
> should be incontroversial (I hope). It does fix the bug that Martin
> Steigerwald reported six years ago for a 2 TB disk. I have tested this
> patch with the identical RDB partition data that Martin saw the bug
> with. I have incorporated Andreas' feedback on proper use of casts to
> avoid integer overflow in this version.

Just as a note for all the AmigaOS users out there: Hyperion 
Entertainment released AmigaOS 3.1.4 for various Amiga models. This 
should fix all (known) issues with large disks for good directly in the 
Kickstart ROM instead of via SetPatch updating the ROM by replacing 
modules or by using NSDPatch approach. Olaf Barthel was one of the 
developers involved with the update. Digital downloads only so far, 
physical releases with floppy disks and ROM chips are announced.

This would be another reason to support large disks in Linux as well.

Thank you, Michael.

(Omitting link as to not too directly advertise proprietary products 
here, it is easy enough to find.)

Thanks,
-- 
Martin
