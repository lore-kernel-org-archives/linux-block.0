Return-Path: <rdunlap@infradead.org>
Subject: Re: [PATCH v3] block: add verifier for cmdline partition
To: Wang YanQing <udknight@gmail.com>, axboe@kernel.dk,
 gregkh@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de,
 caizhiyong@hisilicon.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180506052356.GA11163@udknight>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cdc6b40d-4bc7-797b-facb-dd2b1552ff49@infradead.org>
Date: Sun, 6 May 2018 10:20:03 -0700
MIME-Version: 1.0
In-Reply-To: <20180506052356.GA11163@udknight>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi,

On 05/05/2018 10:23 PM, Wang YanQing wrote:
> I meet strange filesystem corruption issue recently, the reason
> is there are overlaps partitions in cmdline partition argument.
> 
> This patch add verifier for cmdline partition, then if there are
> overlaps partitions, cmdline_partition will log a warning.
> 
> Signed-off-by: Wang YanQing <udknight@gmail.com>
> ---
>  Changes
>  v2-v3:
>  1:Fix log one pair of overlaps partitions twice in cmdline_parts_verifier.
>  2:Fix out of bound access in cmdline_parts_verifier.
> 
>  v1-v2:
>  1:Don't treat overlaps partition as a error, but log a warning.
> 
>  block/partitions/cmdline.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
> index e333583..fefcc72 100644
> --- a/block/partitions/cmdline.c
> +++ b/block/partitions/cmdline.c
> @@ -58,6 +58,71 @@ static int __init cmdline_parts_setup(char *s)
>  }
>  __setup("blkdevparts=", cmdline_parts_setup);
>  
> +static bool has_overlaps(sector_t from, sector_t size,
> +			 sector_t from2, sector_t size2)
> +{
> +	sector_t end = from + size;
> +	sector_t end2 = from2 + size2;
> +
> +	if (from >= from2 && from < end2)
> +		return true;
> +
> +	if (end > from2 && end <= end2)
> +		return true;
> +
> +	if (from2 >= from && from2 < end)
> +		return true;
> +
> +	if (end2 > from && end2 <= end)
> +		return true;
> +
> +	return false;
> +}
> +
> +static inline void overlaps_warns_header(void)
> +{
> +	pr_warn("\n");
> +	pr_warn("Overlaps partitions being used in command line partition.\n");

	        "Overlapping partitions are used in the command line partitions.\n"

> +	pr_warn("Don't use filesystems on overlaps partitions:\n");

	        "Don't use filesystems on overlapping partitions:\n"

> +}
> +
> +static inline void overlaps_warns_tailer(void)
> +{
> +	pr_warn("\n");
> +}
> +
> +static void cmdline_parts_verifier(int slot, struct parsed_partitions *state)
> +{
> +	int i;
> +	bool header = true;
> +
> +	for (; slot < state->limit && state->parts[slot].has_info; slot++) {
> +		for (i = slot+1; i < state->limit && state->parts[i].has_info;
> +		     i++) {
> +			if (has_overlaps(state->parts[slot].from,
> +					 state->parts[slot].size,
> +					 state->parts[i].from,
> +					 state->parts[i].size)) {
> +				if (header) {
> +					header = false;
> +					overlaps_warns_header();
> +				}
> +				pr_warn("%s[%llu,%llu] overlaps with "
> +					"%s[%llu,%llu].\n",
> +					state->parts[slot].info.volname,
> +					(u64)state->parts[slot].from << 9,
> +					(u64)state->parts[slot].size << 9,
> +					state->parts[i].info.volname,
> +					(u64)state->parts[i].from << 9,
> +					(u64)state->parts[i].size << 9);
> +			}
> +		}
> +	}
> +
> +	if (!header)
> +		overlaps_warns_tailer();
> +}
> +
>  /*
>   * Purpose: allocate cmdline partitions.
>   * Returns:
> @@ -93,6 +158,7 @@ int cmdline_partition(struct parsed_partitions *state)
>  	disk_size = get_capacity(state->bdev->bd_disk) << 9;
>  
>  	cmdline_parts_set(parts, disk_size, 1, add_part, (void *)state);
> +	cmdline_parts_verifier(1, (void *)state);
>  
>  	strlcat(state->pp_buf, "\n", PAGE_SIZE);
>  
> 


-- 
~Randy
