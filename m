Return-Path: <mlyle@lyle.org>
Return-Path: <mlyle@lyle.org>
Subject: Re: [PATCH] bcache: check all uuid elements when start flash only
 volumes
To: Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20180226161047.14577-1-colyli@suse.de>
 <d041972d-8ba4-c4c7-2b91-b342174463ec@suse.de>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <16efbb53-4ecd-8a90-dbad-90027e155244@lyle.org>
Date: Mon, 26 Feb 2018 19:54:11 -0800
MIME-Version: 1.0
In-Reply-To: <d041972d-8ba4-c4c7-2b91-b342174463ec@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Reviewed-by: Michael Lyle <mlyle@lyle.org>

I have this and the other fix in the queue for testing tomorrow and will
pass along a changeset to Jens if all looks good.  Thanks!

Mike

On 02/26/2018 08:15 AM, Coly Li wrote:
> On 27/02/2018 12:10 AM, Coly Li wrote:
>> Commit 2831231d4c3f ("bcache: reduce cache_set devices iteration by
>> devices_max_used") adds c->devices_max_used to reduce iteration of
>> c->uuids elements, this value is updated in bcache_device_attach().
>>
>> But for flash only volume, when calling flash_devs_run(), the function
>> bcache_device_attach() is not called yet and c->devices_max_used is not
>> updated. The unexpected result is, the flash only volume won't be run
>> by flash_devs_run().
>>
>> This patch fixes the issue by iterate all c->uuids elements in
>> flash_devs_run(). c->devices_max_used will be updated properly when
>> bcache_device_attach() gets called.
>>
>> Fixes: 2831231d4c3f ("bcache: reduce cache_set devices iteration by devices_max_used")
>> Reported-by: Tang Junhui <tang.junhui@zte.com.cn>
>> Signed-off-by: Coly Li <colyli@suse.de>
>> Cc: Michael Lyle <mlyle@lyle.org>
>> ---
>>  drivers/md/bcache/super.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
>> index 312895788036..4d1d8dfb2d2a 100644
>> --- a/drivers/md/bcache/super.c
>> +++ b/drivers/md/bcache/super.c
>> @@ -1274,7 +1274,7 @@ static int flash_devs_run(struct cache_set *c)
>>  	struct uuid_entry *u;
>>  
>>  	for (u = c->uuids;
>> -	     u < c->uuids + c->devices_max_used && !ret;
>> +	     u < c->uuids + c->nr_uuids && !ret;
>>  	     u++)
>>  		if (UUID_FLASH_ONLY(u))
>>  			ret = flash_dev_run(c, u);
>>
> 
> Hi Jens and Michael,
> 
> Could you please have a look and pick this fix into 4.16 ? Commit
> 2831231d4c3f ("bcache: reduce cache_set devices iteration by
> devices_max_used") is just merged in 4.16-rc1, so I don't CC stable for
> this fix.
> 
> And I still need a peer code reviewer on this patch, any Reviewed-by is
> welcome.
> 
> Thanks to Junhui Tang for reporting this issue today.
> 
> Coly Li
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bcache" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
