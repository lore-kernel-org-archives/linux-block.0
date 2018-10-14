Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <1539492515-1782-1-git-send-email-schmitzmic@gmail.com> <1539492515-1782-3-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1539492515-1782-3-git-send-email-schmitzmic@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 14 Oct 2018 12:42:13 +0200
Message-ID: <CAMuHMdXxrf2rEpKRJbrrei=HtMsyXtxmQqYmhzPuEeNEQnF5qQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] block: add overflow checks for Amiga partition support
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	"Linux/m68k" <linux-m68k@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Michael,

On Sun, Oct 14, 2018 at 6:48 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> The Amiga partition parser module uses signed int for partition sector
> address and count, which will overflow for disks larger than 1 TB.
>
> Use u64 as type for sector address and size to allow using disks up to
> 2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
> format allows to specify disk sizes up to 2^128 bytes (though native
> OS limitations reduce this somewhat, to max 2^68 bytes), so check for
> u64 overflow carefully to protect against overflowing sector_t.
>
> Bail out if sector addresses overflow 32 bits on kernels without LBD
> support.
>
> This bug was reported originally in 2012, and the fix was created by
> the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
> discussed and reviewed on linux-m68k at that time but never officially
> submitted (now resubmitted as separate patch).
> This patch adds additional error checking and warning messages.
>
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>
> ---
>
> Changes from RFC:
>
> - use u64 instead of sector_t, since that may be u32 without LBD support
> - check multiplication overflows each step - 3 u32 values may exceed u64!
> - warn against use on AmigaDOS if partition data overflow u32 sector count.
> - warn if partition CylBlocks larger than what's stored in the RDSK header.
> - bail out if we were to overflow sector_t (32 or 64 bit).
>
> Changes from v1:
>
> Kars de Jong:
> - use defines for magic offsets in DosEnvec struct
>
> Geert Uytterhoeven:
> - use u64 cast for multiplications of u32 numbers
> - use array3_size for overflow checks
> - change pr_err to pr_warn
> - discontinue use of pr_cont
> - reword log messages
> - drop redundant nr_sects overflow test
> - warn against 32 bit overflow for each affected partition
> - skip partitions that overflow sector_t size instead of aborting scan
>
> Changes from v2:
>
> - further trim 32 bit overflow test
> - correct duplicate types.h inclusion introduced in v2
>
> Changes from v3:
>
> - split off sector address type fix for independent review
> - change blksize to unsigned
> - use check_mul_overflow() instead of array3_size()
> - rewrite checks to avoid 64 bit divisions in check_mul_overflow()
>
> Changes from v5:
>
> Geert Uytterhoeven:
> - correct ineffective u64 cast to avoid 32 bit mult. overflow
> - fix mult. overflow in partition block address calculation

Thanks for the updates!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
with one suggestion for improvement below.

> --- a/block/partitions/amiga.c
> +++ b/block/partitions/amiga.c

> @@ -83,12 +94,18 @@ int amiga_partition(struct parsed_partitions *state)
>         blk = be32_to_cpu(rdb->rdb_PartitionList);
>         put_dev_sector(sect);
>         for (part = 1; blk>0 && part<=16; part++, put_dev_sector(sect)) {
> -               blk *= blksize; /* Read in terms partition table understands */
> +               /* Read in terms partition table understands */
> +               if (check_mul_overflow(blk, (sector_t) blksize, &blk)) {
> +                       pr_err("Dev %s: overflow calculating partition block %llu!\n",
> +                               bdevname(state->bdev, b), (u64) blk);
> +                       res = -1;
> +                       goto rdb_done;

I would not fail hard, but try to use the first few partitions that lie
within sector_t size range.

i.e.

                      pr_err("Dev %s: overflow calculating partition
block %llu, skipping partitions %u and later\n",
                              bdevname(state->bdev, b), (u64) blk, part);
                      break;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
