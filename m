Return-Path: <m@bjorling.me>
Return-Path: <m@bjorling.me>
Subject: Re: [GIT PULL 24/25] lightnvm: pblk: add iostat support
To: Jens Axboe <axboe@kernel.dk>
References: <20180105131621.20808-1-m@bjorling.me>
 <20180105131621.20808-25-m@bjorling.me> <20180105154230.GA13829@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Message-ID: <2491bb34-2098-32f5-3d5b-e3d89fbce4b3@bjorling.me>
Date: Fri, 5 Jan 2018 19:33:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180105154230.GA13829@kernel.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 01/05/2018 04:42 PM, Jens Axboe wrote:
> On Fri, Jan 05 2018, Matias Bj�rling wrote:
>> From: Javier Gonz�lez <javier@cnexlabs.com>
>>
>> Since pblk registers its own block device, the iostat accounting is
>> not automatically done for us. Therefore, add the necessary
>> accounting logic to satisfy the iostat interface.
>
> Ignorant question - why is it a raw block device, not using blk-mq?

The current flow is using the raw block device, together with the blk-mq 
nvme device driver. A bio is sent down to the nvme_nvm_submit_io() path 
in the /drivers/nvme/host/lightnvm.c file. From there it attaches the to 
NVMe blk-mq implementation.

Is there a better way to do it?

>
>> @@ -193,9 +197,9 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
>>  	__pblk_end_io_read(pblk, rqd, true);
>>  }
>>
>> -static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
>> -				      unsigned int bio_init_idx,
>> -				      unsigned long *read_bitmap)
>> +static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
>> +				 unsigned int bio_init_idx,
>> +				 unsigned long *read_bitmap)
>>  {
>>  	struct bio *new_bio, *bio = rqd->bio;
>>  	struct pblk_sec_meta *meta_list = rqd->meta_list;
>> @@ -306,6 +310,8 @@ static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
>>  	return NVM_IO_OK;
>>
>>  err:
>> +	pr_err("pblk: failed to perform partial read\n");
>> +
>>  	/* Free allocated pages in new bio */
>>  	pblk_bio_free_pages(pblk, bio, 0, new_bio->bi_vcnt);
>>  	__pblk_end_io_read(pblk, rqd, false);
>
> This seems to include unrelated changes, like the rename above and the
> addition of the error logging?
>

Grah... I missed it during review. It should have been its own patch or 
part of the early refactor patches. Thanks for picking it up.
