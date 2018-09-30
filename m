Return-Path: <whitebox@nefkom.net>
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: linux-block@vger.kernel.org,  axboe@kernel.dk,  linux-m68k@vger.kernel.org,  geert@linux-m68k.org
Subject: Re: [PATCH v4 1/2] block: fix signed int overflow in Amiga partition support
References: <1538265378-20544-1-git-send-email-schmitzmic@gmail.com>
	<1538265378-20544-2-git-send-email-schmitzmic@gmail.com>
Date: Sun, 30 Sep 2018 08:16:58 +0200
In-Reply-To: <1538265378-20544-2-git-send-email-schmitzmic@gmail.com> (Michael
	Schmitz's message of "Sun, 30 Sep 2018 12:56:17 +1300")
Message-ID: <m2pnwvmrvp.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

On Sep 30 2018, Michael Schmitz <schmitzmic@gmail.com> wrote:

> @@ -100,17 +101,17 @@ int amiga_partition(struct parsed_partitions *state)
>  
>  		/* Tell Kernel about it */
>  
> -		nr_sects = (be32_to_cpu(pb->pb_Environment[10]) + 1 -
> -			    be32_to_cpu(pb->pb_Environment[9])) *
> +		nr_sects = (sector_t) ((be32_to_cpu(pb->pb_Environment[10])
> +			   + 1 - be32_to_cpu(pb->pb_Environment[9])) *
>  			   be32_to_cpu(pb->pb_Environment[3]) *
>  			   be32_to_cpu(pb->pb_Environment[5]) *
> -			   blksize;
> +			   blksize);

That doesn't fix any signed int overflow.  If you want to do calculation
in sector_t you need to cast at least one operand to sector_t.  In this
form the cast is useless.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
