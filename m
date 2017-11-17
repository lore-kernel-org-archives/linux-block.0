Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2 2/3] bdi: add error handle for bdi_debug_register
To: Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, linux-mm@kvack.org
References: <cover.1509415695.git.zhangweiping@didichuxing.com>
 <100ecef9a09dc2a95feb5f6fac21c8bfa26be4eb.1509415695.git.zhangweiping@didichuxing.com>
 <20171101134722.GB28572@quack2.suse.cz>
 <20171117150604.GA21325@localhost.didichuxing.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e600ac56-e07d-ce4a-6af2-e3d7e4c71abf@kernel.dk>
Date: Fri, 17 Nov 2017 09:34:43 -0700
MIME-Version: 1.0
In-Reply-To: <20171117150604.GA21325@localhost.didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/17/2017 08:06 AM, weiping zhang wrote:
> On Wed, Nov 01, 2017 at 02:47:22PM +0100, Jan Kara wrote:
>> On Tue 31-10-17 18:38:24, weiping zhang wrote:
>>> In order to make error handle more cleaner we call bdi_debug_register
>>> before set state to WB_registered, that we can avoid call bdi_unregister
>>> in release_bdi().
>>>
>>> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
>>
>> Looks good to me. You can add:
>>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>>
>> 								Honza
>>
>>> ---
>>>  mm/backing-dev.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
>>> index b5f940ce0143..84b2dc76f140 100644
>>> --- a/mm/backing-dev.c
>>> +++ b/mm/backing-dev.c
>>> @@ -882,10 +882,13 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
>>>  	if (IS_ERR(dev))
>>>  		return PTR_ERR(dev);
>>>  
>>> +	if (bdi_debug_register(bdi, dev_name(dev))) {
>>> +		device_destroy(bdi_class, dev->devt);
>>> +		return -ENOMEM;
>>> +	}
>>>  	cgwb_bdi_register(bdi);
>>>  	bdi->dev = dev;
>>>  
>>> -	bdi_debug_register(bdi, dev_name(dev));
>>>  	set_bit(WB_registered, &bdi->wb.state);
>>>  
>>>  	spin_lock_bh(&bdi_lock);
>>> -- 
> 
> Hello Jens,
> 
> Could you please give some comments for this series cleanup.

It looks good to me - for some reason I seem to be missing patch
2/3 locally, but I have this followup. I'll get it applied for
4.15, thanks.

-- 
Jens Axboe
