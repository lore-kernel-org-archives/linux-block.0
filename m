Subject: Re: [PATCH 7/8] wbt: add general throttling mechanism
To: Omar Sandoval <osandov@osandov.com>
References: <1472663151-18560-1-git-send-email-axboe@fb.com>
 <1472663151-18560-8-git-send-email-axboe@fb.com>
 <20160901180523.GA3280@vader.DHCP.thefacebook.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <b983e71b-c959-ca43-ce7b-b234db6035fa@fb.com>
Date: Thu, 1 Sep 2016 12:51:49 -0600
MIME-Version: 1.0
In-Reply-To: <20160901180523.GA3280@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/01/2016 12:05 PM, Omar Sandoval wrote:
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index d79909dc01ec..5a65a1f91889 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -550,4 +550,8 @@ config STACKDEPOT
>>  	bool
>>  	select STACKTRACE
>>
>> +config WBT
>> +	bool
>> +	select SCALE_BITMAP
>
> Looks like this snuck in from your experiments to get this to work on
> top of scale_bitmap?

Oops yes, it is indeed. Killed, thanks.

>> +	if (waitqueue_active(&rwb->wait)) {
>> +		int diff = limit - inflight;
>> +
>> +		if (!inflight || diff >= rwb->wb_background / 2)
>> +			wake_up_nr(&rwb->wait, 1);
>
> wake_up(&rwb->wait)?

Yeah, that'd be cleaner. I think this is a leftover from when I 
experimented with batched wakeups, with nr != 1. I'll change it to just 
wake_up().

-- 
Jens Axboe
