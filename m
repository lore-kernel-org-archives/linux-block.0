Return-Path: <prvs=708eb8c04=bart.vanassche@wdc.com>
Subject: Re: [PATCH 0/3] Fix blk_mq_end_request() and blk_end_request() for
 WRITE SAME
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20180626001009.16557-1-bart.vanassche@wdc.com>
 <yq1a7rh5yu6.fsf@oracle.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <48692754-bee2-6e76-0083-f708c59e017d@wdc.com>
Date: Tue, 26 Jun 2018 09:24:53 -0700
MIME-Version: 1.0
In-Reply-To: <yq1a7rh5yu6.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/26/18 08:53, Martin K. Petersen wrote:
>> This series of three patches fixes a crash in the block layer core
>> that I encountered while retesting the SRP tests in blktests. Please
>> consider these patches for kernel v4.19.
> 
> Patches 1 and 2 look fine. However, I'm not sure I'm so keen on patch
> 3. It looks like it's papering over a more fundamental issue.
> 
> Can you elaborate a bit on why the existing code fails with dm in the
> mix?

Hello Martin,

The issue I ran into is not specific to dm. The only role of dm in this 
is that I found a way to trigger the reported bug with dm.

A close look at the block layer core learned me that in several 
functions there is confusion between what is called the Data Out buffer 
size in the SCSI spec and the number of bytes that are affected on the 
medium. As you know these two numbers are identical for most commands 
but not for discard nor for write same requests. In the block layer core 
the number of bytes affected on the medium is __data_len. The size of 
the Data Out buffer is one of the following:
* rq->special_vec.bv_len if RQF_SPECIAL_PAYLOAD has been set.
* zero for discard requests for which RQF_SPECIAL_PAYLOAD has not been
   set.
* The cumulative size of all bio's associated with a request for all
   other request types, including write same.

Discard requests are generated and processed as follows:
* __blkdev_issue_discard() allocates a bio and sets .bi_size of that
   bio but does not attach any pages to the bio.
* generic_make_request() sets rq->__data_len by calling
   blk_rq_bio_prep() indirectly.
* The sd driver decides which SCSI command to translate discard requests
   into - UNMAP, WRITE SAME(10) or WRITE SAME(16).

Write same requests are generated and processed as follows:
* __blkdev_issue_write_same() allocates a bio, attaches a zero page to
   the bio and sets .bi_size.
* generic_make_request() sets rq->__data_len by calling
   blk_rq_bio_prep() indirectly.
* The sd driver translates the request into a WRITE SAME(10) or WRITE
   SAME(16) SCSI command.

Upon request completion scsi_finish_command() executes the following code:

	good_bytes = scsi_bufflen(cmd);
	scsi_io_completion(cmd, good_bytes);

In other words, the SCSI core passes the size of the Data Out buffer to 
blk_update_request(). In case of discard and write same requests, that 
number can differ from the number of bytes affected on the medium.

The loop in blk_update_request() iterates over the bio's attached to a 
request and hence finishes as soon as the value passed as the nr_bytes 
argument equals or exceeds the Data Out buffer size.

This is why I think that all blk_end_request_all() variants should pass 
the Data Out buffer size to blk_update_request() instead of the number 
of bytes affected on the medium.

Bart.
