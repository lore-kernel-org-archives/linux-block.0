Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/9] QUEUE_FLAG_NOWAIT to indicate device supports nowait
From: Jens Axboe <axboe@kernel.dk>
To: Shaohua Li <shli@kernel.org>, Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-block@vger.kernel.org, hch@infradead.org, jack@suse.cz,
 linux-raid@vger.kernel.org, dm-devel@redhat.com,
 Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20170726235806.12148-1-rgoldwyn@suse.de>
 <20170726235806.12148-2-rgoldwyn@suse.de>
 <20170808203246.sdjnpzixxz5brjaf@kernel.org>
 <10dbe9f0-e2a0-456f-b271-7cf0312aa1d5@kernel.dk>
Message-ID: <284fb7b3-9265-229f-4c66-bd043b94ec9f@kernel.dk>
Date: Wed, 9 Aug 2017 20:18:21 -0600
MIME-Version: 1.0
In-Reply-To: <10dbe9f0-e2a0-456f-b271-7cf0312aa1d5@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/08/2017 02:36 PM, Jens Axboe wrote:
> On 08/08/2017 02:32 PM, Shaohua Li wrote:
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>> index 25f6a0cb27d3..fae021ebec1b 100644
>>> --- a/include/linux/blkdev.h
>>> +++ b/include/linux/blkdev.h
>>> @@ -633,6 +633,7 @@ struct request_queue {
>>>  #define QUEUE_FLAG_REGISTERED  29	/* queue has been registered to a disk */
>>>  #define QUEUE_FLAG_SCSI_PASSTHROUGH 30	/* queue supports SCSI commands */
>>>  #define QUEUE_FLAG_QUIESCED    31	/* queue has been quiesced */
>>> +#define QUEUE_FLAG_NOWAIT      32	/* stack device driver supports REQ_NOWAIT */
> 
> Does this work on 32-bit, where sizeof(unsigned long) == 32?

I didn't get an answer to this one.

-- 
Jens Axboe
