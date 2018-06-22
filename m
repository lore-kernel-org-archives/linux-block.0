Return-Path: <axboe@kernel.dk>
Subject: Re: [RESEND PATCH] lightnvm: pblk: add asynchronous partial read
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>, hlitz@ucsc.edu,
 linux-block@vger.kernel.org
Cc: javier@cnexlabs.com, marcin.dziegielewski@intel.com,
 igor.j.konopko@intel.com
References: <1529344568-2794-1-git-send-email-hlitz@ucsc.edu>
 <25ed47dd-033a-7181-01c5-09ee359ee962@lightnvm.io>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <37c8a6bc-374c-b55f-ba18-ddf3dbf46854@kernel.dk>
Date: Fri, 22 Jun 2018 12:21:07 -0600
MIME-Version: 1.0
In-Reply-To: <25ed47dd-033a-7181-01c5-09ee359ee962@lightnvm.io>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/22/18 12:17 PM, Matias Bjørling wrote:
>> +	/* Re-use allocated memory for intermediate lbas */
>> +	lba_list_mem = (((void *)rqd->ppa_list) + pblk_dma_ppa_size);
>> +
>> +	new_bio = bio_alloc(GFP_KERNEL, nr_holes);
> 
> 
> new_bio can return NULL.

It can't, not if __GFP_WAIT is set like it is for GFP_KERNEL.

-- 
Jens Axboe
