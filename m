Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 07/17] uml: convert ubd to blk-mq
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Jeff Dike <jdike@addtoit.com>
References: <20181011165909.32615-1-axboe@kernel.dk>
 <20181011165909.32615-8-axboe@kernel.dk> <20181015102717.GB31722@ming.t460p>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d0f8c437-27bc-c92b-9fa0-8379968bbb12@kernel.dk>
Date: Mon, 15 Oct 2018 08:16:32 -0600
MIME-Version: 1.0
In-Reply-To: <20181015102717.GB31722@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/15/18 4:27 AM, Ming Lei wrote:
> On Thu, Oct 11, 2018 at 10:58:59AM -0600, Jens Axboe wrote:
>> @@ -947,9 +970,12 @@ static int ubd_add(int n, char **error_out)
>>  
>>  	err = 0;
>>  out:
>> +	blk_mq_free_tag_set(&ubd_dev->tag_set);
>> +out1:
>>  	return err;
>>  
>>  out_cleanup:
>> +	blk_mq_free_tag_set(&ubd_dev->tag_set);
>>  	blk_cleanup_queue(ubd_dev->queue);
> 
> blk_mq_free_tag_set() should have been put after blk_cleanup_queue().

Doesn't matter for this error path, but I do agree in general that
should be the case. I'll fix those up.

-- 
Jens Axboe
