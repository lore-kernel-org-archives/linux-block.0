Return-Path: <schmitzmic@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXgYyQxuBru_oFeBdYaCMSg9fpYaXDpUrNy08Qps5HM-w@mail.gmail.com>
References: <20180627012421.80B8F24E094@nmr-admin> <1530509350-25410-1-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdXgYyQxuBru_oFeBdYaCMSg9fpYaXDpUrNy08Qps5HM-w@mail.gmail.com>
From: Michael Schmitz <schmitzmic@gmail.com>
Date: Tue, 3 Jul 2018 11:58:01 +1200
Message-ID: <CAOmrzkK5M9Gjpd9K5Hccu-bYK758UVxei5FtO2veY2FVy1kO_A@mail.gmail.com>
Subject: Re: [PATCH] block: fix Amiga partition support for disks >= 1 TB
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-block@vger.kernel.org, "Linux/m68k" <linux-m68k@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, jdow <jdow@earthlink.net>,
	Martin Steigerwald <martin@lichtvoll.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Geert,

thanks for your comments!

On Mon, Jul 2, 2018 at 8:29 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
>> +               /* CylBlocks is total number of blocks per cylinder */
>> +               cylblk = be32_to_cpu(pb->pb_Environment[3]) *
>> +                        be32_to_cpu(pb->pb_Environment[5]);
>
> Does the above really do a 32 * 32 = 64 bit multiplication?
> be32 is unsigned int, and multiplying it will be done in 32-bit arithmetic:
>
>     unsigned int a = 100000;
>     unsigned int b = 100000;
>     unsigned long long c = a * b;
>     unsigned long long d = (unsigned long long)a * b;
>     printf("c = %llu\n", c);
>     printf("d = %llu\n", d);
>
> prints:
>
>     c = 1410065408
>     d = 10000000000
>
> If it does work for you, what am I missing?

Not sure - I had begun to tease apart the assembly to answer that, but
got sidetracked. You may well be right that I'm still doing 32 bit
muls. The old parser used signed int which is why it overflowed above
1 TB. Haven't had the time to gin up an RDB exceeding 2 TB yet.

>
>> +
>> +               /* check for consistency with RDB defined CylBlocks */
>> +               if (cylblk > be32_to_cpu(rdb->rdb_CylBlocks)) {
>> +                       pr_err("Dev %s: cylblk 0x%lx > rdb_CylBlocks 0x%x!\n",
>> +                               bdevname(state->bdev, b),
>> +                               (unsigned long) cylblk,
>
> Why the cast? This will truncate the value on 32-bit platforms.
> Just use %llu (IMHO decimal is better suited here).

Will do that.

>> +                               be32_to_cpu(rdb->rdb_CylBlocks));
>> +               }
>> +
>> +               /* check for potential overflows - we are going to multiply
>> +                * three 32 bit numbers to one 64 bit result later!
>> +                * Condition 1: nr_heads * sects_per_track must fit u32!
>> +                * NB: This is a HARD limit for AmigaDOS. We don't care much.
>
> So, is condition 1 really needed?

Just an optimization for my overflow calculations ...

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
>
> No need to reinvent the wheel, #include <linux/overflow.h>, and use
> check_mul_overflow(), like array3_size() does.

Thanks, I knew I was missing something there.


>> +               }
>> +
>>                 /* Tell Kernel about it */
>>
>>                 nr_sects = (be32_to_cpu(pb->pb_Environment[10]) + 1 -
>> @@ -111,6 +187,27 @@ int amiga_partition(struct parsed_partitions *state)
>>                              be32_to_cpu(pb->pb_Environment[3]) *
>>                              be32_to_cpu(pb->pb_Environment[5]) *
>>                              blksize;
>
> I'm still not convinced the above is done in 64-bit arithmetic...

I hear you ...

>> +
>> +               /* Warn user if start_sect or nr_sects overflow u32 */
>> +               if ((nr_sects > UINT_MAX || start_sect > UINT_MAX ||
>> +                   (start_sect + nr_sects) > UINT_MAX) && !did_warn) {
>
> I guess "start_sect + nr_sects > UINT_MAX" is sufficient?

No, we need to catch any partition address overflowing. nr_sects >
UINT_MAX may be redundant though.

> I would remove the did_warn check, as multiple partitions may be affected.

Any partition overflowing means danger lurks (in AmigaDOS of
sufficient vintage, that is)

> Also, RDB doesn't enforce partition ordering, IIRC, so e.g. partitions 1
> and 3 could be outside the 2 TiB area, while 2 could be within.

The first partition (partly) outside 2 TB will warn. But the point
about partition ordering later is well taken.
>
>> +                       pr_err("Dev %s: partition 32 bit overflow! ",
>
> pr_warn()

OK.

>
>> +                               bdevname(state->bdev, b));
>> +                       pr_cont("start_sect 0x%llX, nr_sects 0x%llx\n",
>> +                                start_sect, nr_sects);
>
> No need for pr_cont(), just merge the two statements.

Checkpatch catch-22 (thou shalt not exceed 80 cols, thou shalt not
split string consts over multiple lines, and thou shalt not use
pr_cont() without good cause). I'll ignore the 80 cols error then.

>
>> +                       pr_err("Dev %s: partition may  need 64 bit ",
>
> pr_warn()
>
> Drop the "may"?

s/may/will/ ...

>
>> +                               bdevname(state->bdev, b));
>
> I would print the partition index, too.
>
>> +                       pr_cont("device support on native AmigaOS!\n");
>
> Just merge the two statements.
>
> I think it can also be just one line printed instead of 2?

Can do, yes.

>
>     pr_warn("Dev %s: partition %u (%llu-%llu) needs 64-bit device
> support\n", ...
>
>> +                       /* Without LBD support, better bail out */
>> +                       if (!IS_ENABLED(CONFIG_LBDAF)) {
>> +                               pr_err("Dev %s: no LBD support, aborting!",
>
>     pr_err("Dev %s: no LBD support, skipping partition %u\n", ...)?
>
>> +                                       bdevname(state->bdev, b));
>> +                               res = -1;
>> +                               goto rdb_done;
>
> Aborting here renders any later partitions within the 2 TiB area unaccessible.
> So please continue.

Right. I wasn't aware of the funky ordering feature (only seen it on
MacOS before, and I have always held that's as weird as it gets).

I'll try to get a new version out before tomorrow.

Cheers,


>
>> +                       }
>> +                       did_warn++;
>> +               }
>> +
>>                 put_partition(state,slot++,start_sect,nr_sects);
>>                 {
>>                         /* Be even more informative to aid mounting */
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
