Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 12/28] bsg: provide bsg_remove_queue() helper
To: Johannes Thumshirn <jthumshirn@suse.de>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Benjamin Block <bblock@linux.vnet.ibm.com>
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-13-axboe@kernel.dk>
 <cae4210e-ac0c-0963-0822-c403919bddf9@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5d905728-21f0-dec2-0284-2e16d41dca9d@kernel.dk>
Date: Mon, 29 Oct 2018 08:15:41 -0600
MIME-Version: 1.0
In-Reply-To: <cae4210e-ac0c-0963-0822-c403919bddf9@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/29/18 4:16 AM, Johannes Thumshirn wrote:
> On 25/10/18 23:10, Jens Axboe wrote:
>> All drivers do unregister + cleanup, provide a helper for that.
>>
>> Cc: Johannes Thumshirn <jthumshirn@suse.de>
>> Cc: Benjamin Block <bblock@linux.vnet.ibm.com>
>> Cc: linux-scsi@vger.kernel.org
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/bsg-lib.c                     | 7 +++++++
>>  drivers/scsi/scsi_transport_fc.c    | 6 ++----
>>  drivers/scsi/scsi_transport_iscsi.c | 7 +++----
>>  drivers/scsi/scsi_transport_sas.c   | 6 ++----
>>  include/linux/bsg-lib.h             | 1 +
>>  5 files changed, 15 insertions(+), 12 deletions(-)
>>
>> diff --git a/block/bsg-lib.c b/block/bsg-lib.c
>> index 1da011ec04e6..267f965af77a 100644
>> --- a/block/bsg-lib.c
>> +++ b/block/bsg-lib.c
>> @@ -296,6 +296,13 @@ static void bsg_exit_rq(struct request_queue *q, struct request *req)
>>  	kfree(job->reply);
>>  }
>>  
>> +void bsg_remove_queue(struct request_queue *q)
>> +{
>> +	bsg_unregister_queue(q);
>> +	blk_cleanup_queue(q);
>> +}
>> +EXPORT_SYMBOL_GPL(bsg_remove_queue);
>> +
>>  /**
>>   * bsg_setup_queue - Create and add the bsg hooks so we can receive requests
>>   * @dev: device to attach bsg device to
>> diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
>> index 98aaffb4c715..4d64956bb5d3 100644
>> --- a/drivers/scsi/scsi_transport_fc.c
>> +++ b/drivers/scsi/scsi_transport_fc.c
>> @@ -3851,10 +3851,8 @@ fc_bsg_rportadd(struct Scsi_Host *shost, struct fc_rport *rport)
>>  static void
>>  fc_bsg_remove(struct request_queue *q)
>>  {
>> -	if (q) {
>> -		bsg_unregister_queue(q);
>> -		blk_cleanup_queue(q);
>> -	}
>> +	if (q)
>> +		bsg_remove_queue(q);
>>  }
> 
> Not sure if I'm too late to the game, but as all callers do a
> "if  (q)" check, can't we just move it into bsg_remove_queue()?

Not too late, I'll make that change.

-- 
Jens Axboe
