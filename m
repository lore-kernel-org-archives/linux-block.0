Subject: Re: [PATCH 7/7] blk-mq-sched: allow setting of default IO scheduler
To: Bart Van Assche <bart.vanassche@sandisk.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
 <1481228005-9245-8-git-send-email-axboe@fb.com>
 <3e4483e3-6018-5c6c-9fe2-128ed68c01f4@sandisk.com>
Cc: paolo.valente@linaro.org, osandov@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <f6e98baa-7b11-8c5c-74b9-5d40bccc97a2@fb.com>
Date: Tue, 13 Dec 2016 08:06:53 -0700
MIME-Version: 1.0
In-Reply-To: <3e4483e3-6018-5c6c-9fe2-128ed68c01f4@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/13/2016 03:13 AM, Bart Van Assche wrote:
> On 12/08/2016 09:13 PM, Jens Axboe wrote:
>> +config DEFAULT_MQ_IOSCHED
>> +	string
>> +	default "mq-deadline" if DEFAULT_MQ_DEADLINE
>> +	default "none" if DEFAULT_MQ_NONE
>> +
>>  endmenu
>>
>> +config MQ_IOSCHED_ONLY_SQ
>> +	bool "Enable blk-mq IO scheduler only for single queue devices"
>> +	default y
>> +	help
>> +	  Say Y here, if you only want to enable IO scheduling on block
>> +	  devices that have a single queue registered.
>> +
>>  endif
> 
> Hello Jens,
> 
> Shouln't the MQ_IOSCHED_ONLY_SQ entry be placed before "endmenu" such 
> that it is displayed in the I/O scheduler menu instead of the block menu?

Good catch, yes it should. I'll move it.

-- 
Jens Axboe
