Return-Path: <schmitzmic@gmail.com>
Return-Path: <schmitzmic@gmail.com>
Subject: Re: [PATCH v5 1/2] block: fix signed int overflow in Amiga partition
 support
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <1539304018-11786-1-git-send-email-schmitzmic@gmail.com>
 <1539304018-11786-2-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdX1vTFipRSvic7cYr-RvzvSaR5zPghbDYW_Tbd2uUmbNQ@mail.gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Linux/m68k <linux-m68k@vger.kernel.org>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <57de8343-2b9e-79b5-d419-6fc105b8df77@gmail.com>
Date: Sat, 13 Oct 2018 15:46:31 +1300
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX1vTFipRSvic7cYr-RvzvSaR5zPghbDYW_Tbd2uUmbNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi Geert,

Am 12.10.2018 um 21:59 schrieb Geert Uytterhoeven:

>> Changes from v4:
>>
>> Andreas Schwab:
>> - correct cast to sector_t in sector address calculations
>
> Which you only did for the first case...
>
>> --- a/block/partitions/amiga.c
>> +++ b/block/partitions/amiga.c
>
>> @@ -100,14 +101,14 @@ int amiga_partition(struct parsed_partitions *state)
>>
>>                 /* Tell Kernel about it */
>>
>> -               nr_sects = (be32_to_cpu(pb->pb_Environment[10]) + 1 -
>> -                           be32_to_cpu(pb->pb_Environment[9])) *
>> +               nr_sects = ((sector_t) be32_to_cpu(pb->pb_Environment[10])
>
> ...here ...
>
>> +                          + 1 - be32_to_cpu(pb->pb_Environment[9])) *
>>                            be32_to_cpu(pb->pb_Environment[3]) *
>>                            be32_to_cpu(pb->pb_Environment[5]) *
>>                            blksize;
>>                 if (!nr_sects)
>>                         continue;
>> -               start_sect = be32_to_cpu(pb->pb_Environment[9]) *
>> +               start_sect = (sector_t) be32_to_cpu(pb->pb_Environment[9]) *
>
> ... but not here?

I meant to cast the first operand to sector_t here?

Using

int main(int argc, char *argv) {
   unsigned int a, b;
   unsigned long long c, d;

   a = 0xffffffff;
   b = 0xffffffff;

   c = a * b;
   d = (unsigned long long) a * b;

   fprintf(stdout, "%llx %llx\n", c, d);
}

I get this:

1 fffffffe00000001

But I can add brackets if you think the compiler might get this wrong.

Cheers,

	Michael

>
>>                              be32_to_cpu(pb->pb_Environment[3]) *
>>                              be32_to_cpu(pb->pb_Environment[5]) *
>>                              blksize;
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
