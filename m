Return-Path: <axboe@kernel.dk>
Date: Fri, 1 Jun 2018 07:45:29 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	javier@cnexlabs.com, igor.j.konopko@intel.com,
	marcin.dziegielewski@intel.com
Subject: Re: [GIT PULL v2 00/18] lightnvm updates for 4.18
Message-ID: <20180601134527.GA21226@kernel.dk>
References: <20180601130432.30866-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180601130432.30866-1-mb@lightnvm.io>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 01 2018, Matias Bj�rling wrote:
> Hi Jens,
> 
> Please pick up the following patches.
> 
>  - Hans reworked the write error recovery path in pblk.
>  - Igor added extra error handling for lines, and fixed a bug in the
>    pblk ringbuffer during GC.
>  - Javier refactored the pblk code a bit, added extra error
>    handling, and added checks to verify that data returned from drive
>    is appropriate.
>  - Marcin added some extra logic to manage the write buffer. Now
>    MW_CUNITS can be zero and the size of write buffer can be changed
>    at module load time.

I applied 1-11, 12 fails:

checking file drivers/lightnvm/pblk-init.c
checking file drivers/lightnvm/pblk-rb.c
checking file drivers/lightnvm/pblk-recovery.c
Reversed (or previously applied) patch detected!  Assume -R? [n] ^C

I will push out what I have, please resend the rest of the series
against for-4.18/block.

BTW, you had several "lightnvn" typos in the subject line, I've fixed
those up. Didn't check the remainder.

-- 
Jens Axboe
