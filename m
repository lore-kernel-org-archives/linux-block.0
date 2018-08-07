Return-Path: <jgross@suse.com>
Subject: Re: [PATCH 1/4] xen/blkback: don't keep persistent grants too long
To: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-block@vger.kernel.org, konrad.wilk@oracle.com, axboe@kernel.dk,
 boris.ostrovsky@oracle.com
References: <20180806113403.24728-1-jgross@suse.com>
 <20180806113403.24728-2-jgross@suse.com>
 <20180806155852.7jvudjpzzq6fdp33@mac>
From: Juergen Gross <jgross@suse.com>
Message-ID: <efbe9e36-5d56-c3d5-5260-7ffda9d00ab2@suse.com>
Date: Tue, 7 Aug 2018 08:34:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180806155852.7jvudjpzzq6fdp33@mac>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/08/18 17:58, Roger Pau Monné wrote:
> On Mon, Aug 06, 2018 at 01:33:59PM +0200, Juergen Gross wrote:
>> Persistent grants are allocated until a threshold per ring is being
>> reached. Those grants won't be freed until the ring is being destroyed
>> meaning there will be resources kept busy which might no longer be
>> used.
>>
>> Instead of freeing only persistent grants until the threshold is
>> reached add a timestamp and remove all persistent grants not having
>> been in use for a minute.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>  drivers/block/xen-blkback/blkback.c | 77 +++++++++++++++++++++++--------------
>>  drivers/block/xen-blkback/common.h  |  1 +
>>  2 files changed, 50 insertions(+), 28 deletions(-)
> 
> You should document this new parameter in
> Documentation/ABI/testing/sysfs-driver-xen-blkback.

Yes.

> 
>>
>> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
>> index b55b245e8052..485e3ecab144 100644
>> --- a/drivers/block/xen-blkback/blkback.c
>> +++ b/drivers/block/xen-blkback/blkback.c
>> @@ -84,6 +84,18 @@ MODULE_PARM_DESC(max_persistent_grants,
>>                   "Maximum number of grants to map persistently");
>>  
>>  /*
>> + * How long a persistent grant is allowed to remain allocated without being in
>> + * use. The time is in seconds, 0 means indefinitely long.
>> + */
>> +
>> +unsigned int xen_blkif_pgrant_timeout = 60;
>> +module_param_named(persistent_grant_unused_seconds, xen_blkif_pgrant_timeout,
>> +		   uint, 0644);
>> +MODULE_PARM_DESC(persistent_grant_unused_seconds,
>> +		 "Time in seconds an unused persistent grant is allowed to "
>> +		 "remain allocated. Default is 60, 0 means unlimited.");
>> +
>> +/*
>>   * Maximum number of rings/queues blkback supports, allow as many queues as there
>>   * are CPUs if user has not specified a value.
>>   */
>> @@ -123,6 +135,13 @@ module_param(log_stats, int, 0644);
>>  /* Number of free pages to remove on each call to gnttab_free_pages */
>>  #define NUM_BATCH_FREE_PAGES 10
>>  
>> +static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
>> +{
>> +	return xen_blkif_pgrant_timeout &&
>> +	       (jiffies - persistent_gnt->last_used >=
>> +		HZ * xen_blkif_pgrant_timeout);
>> +}
>> +
>>  static inline int get_free_page(struct xen_blkif_ring *ring, struct page **page)
>>  {
>>  	unsigned long flags;
>> @@ -278,6 +297,7 @@ static void put_persistent_gnt(struct xen_blkif_ring *ring,
>>  {
>>  	if(!test_bit(PERSISTENT_GNT_ACTIVE, persistent_gnt->flags))
>>  		pr_alert_ratelimited("freeing a grant already unused\n");
>> +	persistent_gnt->last_used = jiffies;
>>  	set_bit(PERSISTENT_GNT_WAS_ACTIVE, persistent_gnt->flags);
>>  	clear_bit(PERSISTENT_GNT_ACTIVE, persistent_gnt->flags);
>>  	atomic_dec(&ring->persistent_gnt_in_use);
>> @@ -374,23 +394,23 @@ static void purge_persistent_gnt(struct xen_blkif_ring *ring)
>>  	bool scan_used = false, clean_used = false;
>>  	struct rb_root *root;
>>  
>> -	if (ring->persistent_gnt_c < xen_blkif_max_pgrants ||
>> -	    (ring->persistent_gnt_c == xen_blkif_max_pgrants &&
>> -	    !ring->blkif->vbd.overflow_max_grants)) {
>> -		goto out;
>> -	}
>> -
>>  	if (work_busy(&ring->persistent_purge_work)) {
>>  		pr_alert_ratelimited("Scheduled work from previous purge is still busy, cannot purge list\n");
>>  		goto out;
>>  	}
>>  
>> -	num_clean = (xen_blkif_max_pgrants / 100) * LRU_PERCENT_CLEAN;
>> -	num_clean = ring->persistent_gnt_c - xen_blkif_max_pgrants + num_clean;
>> -	num_clean = min(ring->persistent_gnt_c, num_clean);
>> -	if ((num_clean == 0) ||
>> -	    (num_clean > (ring->persistent_gnt_c - atomic_read(&ring->persistent_gnt_in_use))))
>> -		goto out;
>> +	if (ring->persistent_gnt_c < xen_blkif_max_pgrants ||
>> +	    (ring->persistent_gnt_c == xen_blkif_max_pgrants &&
>> +	    !ring->blkif->vbd.overflow_max_grants)) {
>> +		num_clean = 0;
>> +	} else {
>> +		num_clean = (xen_blkif_max_pgrants / 100) * LRU_PERCENT_CLEAN;
>> +		num_clean = ring->persistent_gnt_c - xen_blkif_max_pgrants +
>> +			    num_clean;
>> +		num_clean = min(ring->persistent_gnt_c, num_clean);
>> +		pr_debug("Going to purge at least %u persistent grants\n",
>> +			 num_clean);
>> +	}
>>  
>>  	/*
>>  	 * At this point, we can assure that there will be no calls
>> @@ -401,9 +421,7 @@ static void purge_persistent_gnt(struct xen_blkif_ring *ring)
>>           * number of grants.
>>  	 */
>>  
>> -	total = num_clean;
>> -
>> -	pr_debug("Going to purge %u persistent grants\n", num_clean);
>> +	total = 0;
>>  
>>  	BUG_ON(!list_empty(&ring->persistent_purge_list));
>>  	root = &ring->persistent_gnts;
>> @@ -419,39 +437,42 @@ static void purge_persistent_gnt(struct xen_blkif_ring *ring)
>>  
>>  		if (test_bit(PERSISTENT_GNT_ACTIVE, persistent_gnt->flags))
>>  			continue;
>> -		if (!scan_used &&
>> +		if (!scan_used && !persistent_gnt_timeout(persistent_gnt) &&
>>  		    (test_bit(PERSISTENT_GNT_WAS_ACTIVE, persistent_gnt->flags)))
> 
> If you store the jiffies of the time when the grant was last used it
> seems like we could get rid of the PERSISTENT_GNT_WAS_ACTIVE flag and
> instead use the per-grant jiffies and the jiffies from the last scan
> in order to decide which grants to remove?

True. This might make the control flow a little bit easier to
understand.


Juergen
