Return-Path: <schmitzmic@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACz-3rgcLekJq6ou_KCur_KD1Vk7dRGDjXv5oF8C0giMjypFSA@mail.gmail.com>
References: <20180627012421.80B8F24E094@nmr-admin> <1530509350-25410-1-git-send-email-schmitzmic@gmail.com>
 <CACz-3rgcLekJq6ou_KCur_KD1Vk7dRGDjXv5oF8C0giMjypFSA@mail.gmail.com>
From: Michael Schmitz <schmitzmic@gmail.com>
Date: Tue, 3 Jul 2018 10:34:17 +1200
Message-ID: <CAOmrzk+NXwHXS51rXhyKFmpfuCHGrpNbod1BSN2nnkGTrZbP4Q@mail.gmail.com>
Subject: Re: [PATCH] block: fix Amiga partition support for disks >= 1 TB
To: Kars de Jong <jongk@linux-m68k.org>
Cc: linux-block@vger.kernel.org, "Linux/m68k" <linux-m68k@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>, Joanne Dow <jdow@earthlink.net>,
	Martin Steigerwald <martin@lichtvoll.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Kars,

thanks for your comments - will do.

Cheers,

  Michael


On Mon, Jul 2, 2018 at 6:38 PM, Kars de Jong <jongk@linux-m68k.org> wrote:
> Op ma 2 jul. 2018 om 07:29 schreef Michael Schmitz <schmitzmic@gmail.com>:
>> @@ -98,6 +101,79 @@ int amiga_partition(struct parsed_partitions *state)
>>                 if (checksum_block((__be32 *)pb, be32_to_cpu(pb->pb_SummedLongs) & 0x7F) != 0 )
>>                         continue;
>>
>> +               /* RDB gives us more than enough rope to hang ourselves with,
>> +                * many times over (2^128 bytes if all fields max out).
>> +                * Some careful checks are in order.
>> +                */
>> +
>> +               /* CylBlocks is total number of blocks per cylinder */
>> +               cylblk = be32_to_cpu(pb->pb_Environment[3]) *
>> +                        be32_to_cpu(pb->pb_Environment[5]);
>> +
>
> Could you please create #defines for all these magic offsets in pb_Environment?
> Below are a few more.
> This makes the code much more readable.
> Thanks!
>
>> +               /* check for consistency with RDB defined CylBlocks */
>> +               if (cylblk > be32_to_cpu(rdb->rdb_CylBlocks)) {
>> +                       pr_err("Dev %s: cylblk 0x%lx > rdb_CylBlocks 0x%x!\n",
>> +                               bdevname(state->bdev, b),
>> +                               (unsigned long) cylblk,
>> +                               be32_to_cpu(rdb->rdb_CylBlocks));
>> +               }
>> +
>> +               /* check for potential overflows - we are going to multiply
>> +                * three 32 bit numbers to one 64 bit result later!
>> +                * Condition 1: nr_heads * sects_per_track must fit u32!
>> +                * NB: This is a HARD limit for AmigaDOS. We don't care much.
>> +                */
>> +
>> +               if (cylblk > UINT_MAX) {
>> +                       pr_err("Dev %s: hds*sects 0x%lx > UINT_MAX!\n",
>> +                               bdevname(state->bdev, b),
>> +                               (unsigned long) cylblk);
>> +
>> +                       /* lop off low 32 bits */
>> +                       cylblk_res = cylblk >> 32;
>> +
>> +                       /* check for further overflow in end result */
>> +                       if (be32_to_cpu(pb->pb_Environment[9]) *
>> +                               cylblk_res * blksize > UINT_MAX) {
>> +                               pr_err("Dev %s: start_sect overflows u64!\n",
>> +                                       bdevname(state->bdev, b));
>> +                               res = -1;
>> +                               goto rdb_done;
>> +                       }
>> +
>> +                       if (be32_to_cpu(pb->pb_Environment[10]) *
>> +                          cylblk_res * blksize > UINT_MAX) {
>> +                               pr_err("Dev %s: end_sect overflows u64!\n",
>> +                                       bdevname(state->bdev, b));
>> +                               res = -1;
>> +                               goto rdb_done;
>> +                       }
>> +               }
>> +
>> +               /* Condition 2: even if CylBlocks did not overflow, the end
>> +                * result must still fit u64!
>> +                */
>> +
>> +               /* how many bits above 32 in cylblk * blksize ? */
>> +               if (cylblk*blksize > (u64) UINT_MAX)
>> +                       blk_shift = ilog2(cylblk*blksize) - 32;
>> +
>> +               if (be32_to_cpu(pb->pb_Environment[9])
>> +                       > (u64) UINT_MAX>>blk_shift) {
>> +                       pr_err("Dev %s: start_sect overflows u64!\n",
>> +                               bdevname(state->bdev, b));
>> +                       res = -1;
>> +                       goto rdb_done;
>> +               }
>> +
>> +               if (be32_to_cpu(pb->pb_Environment[10])
>> +                       > (u64) UINT_MAX>>blk_shift) {
>> +                       pr_err("Dev %s: end_sect overflows u64!\n",
>> +                               bdevname(state->bdev, b));
>> +                       res = -1;
>> +                       goto rdb_done;
>> +               }
>> +
>>                 /* Tell Kernel about it */
>>
>>                 nr_sects = (be32_to_cpu(pb->pb_Environment[10]) + 1 -
