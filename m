Return-Path: <mb@lightnvm.io>
Return-Path: <mb@lightnvm.io>
Subject: Re: [PATCH 4/6] block: Add and use op_stat_group() for indexing
 disk_stat fields.
To: Tejun Heo <tj@kernel.org>, axboe@kernel.dk
Cc: michaelcallahan@fb.com, newella@fb.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@fb.com,
 Minchan Kim <minchan@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Joshua Morris <josh.h.morris@us.ibm.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Kent Overstreet <kent.overstreet@gmail.com>, Alasdair Kergon <agk@redhat.com>
References: <20180605180120.2726113-1-tj@kernel.org>
 <20180605180120.2726113-5-tj@kernel.org>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <664313c6-3cb9-e4fd-ba57-e9b7ff5bcb78@lightnvm.io>
Date: Tue, 5 Jun 2018 20:07:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180605180120.2726113-5-tj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/05/2018 08:01 PM, Tejun Heo wrote:
> From: Michael Callahan <michaelcallahan@fb.com>
> 
> Add and use a new op_stat_group() function for indexing partition stat
> fields rather than indexing them by rq_data_dir() or bio_data_dir().
> This function works similarly to op_is_sync() in that it takes the
> request::cmd_flags or bio::bi_opf flags and determines which stats
> should et updated.
> 
> In addition, the second parameter to generic_start_io_acct() and
> generic_end_io_acct() is now a REQ_OP rather than simply a read or
> write bit and it uses op_stat_group() on the parameter to determine
> the stat group.
> 
> Note that the partition in_flight counts are not part of the per-cpu
> statistics and as such are not indexed via this function.  It's now
> indexed by op_is_write().
> 
> tj: Refreshed on top of v4.17.  Updated to pass around REQ_OP.
> 
> Signed-off-by: Michael Callahan <michaelcallahan@fb.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Joshua Morris <josh.h.morris@us.ibm.com>
> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> Cc: Matias Bjorling <mb@lightnvm.io>
> Cc: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: Alasdair Kergon <agk@redhat.com>
> ---
>   block/bio.c                   | 16 +++++++++-------
>   block/blk-core.c              | 12 ++++++------
>   drivers/block/drbd/drbd_req.c |  4 ++--
>   drivers/block/rsxx/dev.c      |  6 +++---
>   drivers/block/zram/zram_drv.c |  5 ++---
>   drivers/lightnvm/pblk-cache.c |  5 +++--
>   drivers/lightnvm/pblk-read.c  |  5 +++--
>   drivers/md/bcache/request.c   | 13 +++++--------
>   drivers/md/dm.c               |  6 ++++--
>   drivers/md/md.c               |  5 +++--
>   drivers/nvdimm/nd.h           |  7 +++----
>   include/linux/bio.h           |  4 ++--
>   include/linux/blk_types.h     |  5 +++++
>   13 files changed, 50 insertions(+), 43 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
....
> diff --git a/drivers/lightnvm/pblk-cache.c b/drivers/lightnvm/pblk-cache.c
> index b1c6d7e..643e276 100644
> --- a/drivers/lightnvm/pblk-cache.c
> +++ b/drivers/lightnvm/pblk-cache.c
> @@ -27,7 +27,8 @@ int pblk_write_to_cache(struct pblk *pblk, struct bio *bio, unsigned long flags)
>   	int nr_entries = pblk_get_secs(bio);
>   	int i, ret;
>   
> -	generic_start_io_acct(q, WRITE, bio_sectors(bio), &pblk->disk->part0);
> +	generic_start_io_acct(q, REQ_OP_WRITE, bio_sectors(bio),
> +			      &pblk->disk->part0);
>   
>   	/* Update the write buffer head (mem) with the entries that we can
>   	 * write. The write in itself cannot fail, so there is no need to
> @@ -75,7 +76,7 @@ int pblk_write_to_cache(struct pblk *pblk, struct bio *bio, unsigned long flags)
>   	pblk_rl_inserted(&pblk->rl, nr_entries);
>   
>   out:
> -	generic_end_io_acct(q, WRITE, &pblk->disk->part0, start_time);
> +	generic_end_io_acct(q, REQ_OP_WRITE, &pblk->disk->part0, start_time);
>   	pblk_write_should_kick(pblk);
>   	return ret;
>   }
> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> index 1869469..cf90cee 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -199,7 +199,7 @@ static void __pblk_end_io_read(struct pblk *pblk, struct nvm_rq *rqd,
>   	struct bio *int_bio = rqd->bio;
>   	unsigned long start_time = r_ctx->start_time;
>   
> -	generic_end_io_acct(dev->q, READ, &pblk->disk->part0, start_time);
> +	generic_end_io_acct(dev->q, REQ_OP_READ, &pblk->disk->part0, start_time);
>   
>   	if (rqd->error)
>   		pblk_log_read_err(pblk, rqd);
> @@ -411,7 +411,8 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
>   		return NVM_IO_ERR;
>   	}
>   
> -	generic_start_io_acct(q, READ, bio_sectors(bio), &pblk->disk->part0);
> +	generic_start_io_acct(q, REQ_OP_READ, bio_sectors(bio),
> +			      &pblk->disk->part0);
>   
>   	bitmap_zero(&read_bitmap, nr_secs);
>   

Looks good to me. Thanks.
