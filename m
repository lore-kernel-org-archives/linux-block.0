Return-Path: <schmitzmic@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUOGdF-bm8j59Om8JNV0mFqK0yixGifgLAjxGwOGLoyqQ@mail.gmail.com>
References: <20180627012421.80B8F24E094@nmr-admin> <CAMuHMdUOGdF-bm8j59Om8JNV0mFqK0yixGifgLAjxGwOGLoyqQ@mail.gmail.com>
From: Michael Schmitz <schmitzmic@gmail.com>
Date: Thu, 28 Jun 2018 08:43:05 +1200
Message-ID: <CAOmrzkLn9b3RV8Ad9W6EX=6wsCAfswakfdrudU6Xr5YcOB=-bQ@mail.gmail.com>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>, geert@linux-m68k.org-r, jdow <jdow@earthlink.net>,
	Martin Steigerwald <martin@lichtvoll.de>, linux-m68k <linux-m68k@lists.linux-m68k.org>,
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Geert,

thanks for your feedback!

On Thu, Jun 28, 2018 at 1:30 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Michael,
>
> Thanks for your patch!
>
> On Wed, Jun 27, 2018 at 4:47 AM <schmitzmic@gmail.com> wrote:
>> From 5299e0e64dfb33ac3a1f3137b42178734ce20087 Mon Sep 17 00:00:00 2001
>
> ??

Comes from not using git send-email. Don't ask ...

>> The Amiga RDB partition parser module uses int for partition sector
>> address and count, which will overflow for disks 2 TB and larger.
>>
>> Use sector_t as type for sector address and size (as expected by
>> put_partition) to allow using such disks without danger of data
>> corruption.
>
> Note that sector_t is not guaranteed to be 64-bit:
>
>     #ifdef CONFIG_LBDAF
>     typedef u64 sector_t;
>     typedef u64 blkcnt_t;
>     #else
>     typedef unsigned long sector_t;
>     typedef unsigned long blkcnt_t;
>     #endif

Yes, I had seen that ...

> And it seems CONFIG_LBDAF can still be disabled on 32-bit...

Ouch - missed that bit.

>
>> This bug was reported originally in 2012 by Martin Steigerwald
>> <Martin@lichtvoll.de>, and the fix was created by the RDB author,
>> Joanne Dow <jdow@earthlink.net>. The patch had been discussed and
>> reviewed on linux-m68k at that time but never officially submitted.
>>
>> Following a stern warning by Joanne, a warning is printed if any
>> partition is found to overflow the old 32 bit calculations, on the
>> grounds that such a partition would be misparses on legacy 32 bit
>> systems (other than Linux).
>>
>> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
>> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
>> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>> Tested-by: Martin Steigerwald <Martin@lichtvoll.de>
>> Tested-by: Michael Schmitz <schmitzmic@gmail.com>
>> ---
>>  block/partitions/amiga.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
>> index 5609366..42c3f38 100644
>> --- a/block/partitions/amiga.c
>> +++ b/block/partitions/amiga.c
>> @@ -32,7 +32,8 @@ int amiga_partition(struct parsed_partitions *state)
>>         unsigned char *data;
>>         struct RigidDiskBlock *rdb;
>>         struct PartitionBlock *pb;
>> -       int start_sect, nr_sects, blk, part, res = 0;
>> +       sector_t start_sect, nr_sects;
>
> As sector_t can still be 32-bit, I think you should use an explicit u64 here.

You're spot on there.

>
>> +       int blk, part, res = 0;
>>         int blksize = 1;        /* Multiplier for disk block size */
>>         int slot = 1;
>>         char b[BDEVNAME_SIZE];
>> @@ -111,6 +112,16 @@ int amiga_partition(struct parsed_partitions *state)
>>                              be32_to_cpu(pb->pb_Environment[3]) *
>>                              be32_to_cpu(pb->pb_Environment[5]) *
>>                              blksize;
>
> Without adding any unsigned long long or ULL stuff to the calculations
> for start_sect and nr_sects above, the math will still be done using 32-bit
> arithmetic. Or am I missing something?

It did appear to do 64 bit arithmetic alright. But I better check what
instrunctions are used there.
I also need to look up the rules on default type promotion - additions
and subtractions would certainly still do 32 bit arithmetics but
multiplication may be different.

>
>> +               if (start_sect > INT_MAX || nr_sects > INT_MAX
>> +                       || (start_sect + nr_sects) > INT_MAX) {
>> +                       pr_err("%s: Warning: RDB partition overflow!\n",
>> +                               bdevname(state->bdev, b));
>> +                       pr_err("%s: start 0x%llX size 0x%llX\n",
>> +                               bdevname(state->bdev, b), start_sect,
>> +                               nr_sects);
>> +                       pr_err("%s: partition incompatible with 32 bit OS\n",
>> +                               bdevname(state->bdev, b));
>> +               }
>
> I don't know if the check above is really needed here.

It will be once I add a jump to rdb_done there ... The third test may
only be needed if no LBD support is present, but we absolutely have to
bail if the calculation of the partition end sector later on in the
kernel truncates.  Maybe I should take a page out of Christoph's book
and put a BUG() there to realy get people's attention?

> There's also int vs. unsigned int. But see below.

start_sect and nr_sects were int, not unsigned int before so I have to
compare to INT_MAX to see whether the old code would have overflowed.
What am I missing? Are you concerned the comparison will always be
false due to data type? I think I would have seen a warning. Anyway,
'seemed to work as intended' with Martin's test case.

>
>>                 put_partition(state,slot++,start_sect,nr_sects);
>
> Given sector_t may be 32-bit, values may be truncated when calling
> put_partition(), so you need to check for that.

put_partition() is inlined so I'm not sure a cast would help there,
And all that happens in put_partition() is that the start address and
size get stuffed into the parsed_partitions struct:

                p->parts[n].from = from;
                p->parts[n].size = size;

That struct has u32 types for from and size if compiled without
CONFIG_LBDAF, so whatever we do with 64 bit arithmetics, this will
lead to truncation here. Only safe option is to bail out on these
kernels.

> Interestingly, even partition parsers that do use u64 (efi, ldm) or loff_t
> (ibm) do not have such checks.

I would expect things to go horribly wrong if these are used without
LBD support. But perhaps the same checks need to be added there
indeed.

> Perhaps put_partition() should take u64, and print a warning and ignore the
> partition if conversion to sector_t involves truncation?

That's something for Jens to ponder :-)

I'll work in ann the suggested changes and then submit this to
linux-block for real.

Thanks again,

  Michael


>
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
