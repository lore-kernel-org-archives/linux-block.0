Return-Path: <schmitzmic@gmail.com>
Return-Path: <schmitzmic@gmail.com>
Subject: Re: [PATCH v4 1/2] block: fix signed int overflow in Amiga partition
 support
To: Andreas Schwab <schwab@linux-m68k.org>
References: <1538265378-20544-1-git-send-email-schmitzmic@gmail.com>
 <1538265378-20544-2-git-send-email-schmitzmic@gmail.com>
 <m2pnwvmrvp.fsf@linux-m68k.org>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, linux-m68k@vger.kernel.org,
 geert@linux-m68k.org
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <33091043-aa03-0d82-2997-b0974eaa6837@gmail.com>
Date: Mon, 1 Oct 2018 17:27:07 +1300
MIME-Version: 1.0
In-Reply-To: <m2pnwvmrvp.fsf@linux-m68k.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
List-ID: <linux-block@vger.kernel.org>

Thanks Andreas,

it appears I already made the same error in v2 of this series. My bad.

I'll wait for a few more comments before respinning.

Cheers,

	Michael


Am 30.09.2018 um 19:16 schrieb Andreas Schwab:
> On Sep 30 2018, Michael Schmitz <schmitzmic@gmail.com> wrote:
>
>> @@ -100,17 +101,17 @@ int amiga_partition(struct parsed_partitions *state)
>>
>>  		/* Tell Kernel about it */
>>
>> -		nr_sects = (be32_to_cpu(pb->pb_Environment[10]) + 1 -
>> -			    be32_to_cpu(pb->pb_Environment[9])) *
>> +		nr_sects = (sector_t) ((be32_to_cpu(pb->pb_Environment[10])
>> +			   + 1 - be32_to_cpu(pb->pb_Environment[9])) *
>>  			   be32_to_cpu(pb->pb_Environment[3]) *
>>  			   be32_to_cpu(pb->pb_Environment[5]) *
>> -			   blksize;
>> +			   blksize);
>
> That doesn't fix any signed int overflow.  If you want to do calculation
> in sector_t you need to cast at least one operand to sector_t.  In this
> form the cast is useless.
>
> Andreas.
>
