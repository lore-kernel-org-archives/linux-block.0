Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 05/28] IB/srp: remove old request_fn_active check
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Parav Pandit <parav@mellanox.com>
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-6-axboe@kernel.dk> <1540502607.66186.54.camel@acm.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <57072cc9-a678-5578-c773-a17ff26a5971@kernel.dk>
Date: Thu, 25 Oct 2018 15:24:06 -0600
MIME-Version: 1.0
In-Reply-To: <1540502607.66186.54.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 3:23 PM, Bart Van Assche wrote:
> On Thu, 2018-10-25 at 15:10 -0600, Jens Axboe wrote:
>> This check is only viable for non scsi-mq. Since that is going away,
>> kill this legacy check.
>>
>> Cc: Bart Van Assche <bvanassche@acm.org>
>> Cc: Parav Pandit <parav@mellanox.com>
>> Cc: linux-scsi@vger.kernel.org
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  drivers/infiniband/ulp/srp/ib_srp.c | 7 -------
>>  1 file changed, 7 deletions(-)
>>
>> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
>> index 0b34e909505f..5a79444c2f3c 100644
>> --- a/drivers/infiniband/ulp/srp/ib_srp.c
>> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
>> @@ -1334,13 +1334,6 @@ static void srp_terminate_io(struct srp_rport *rport)
>>  	struct scsi_device *sdev;
>>  	int i, j;
>>  
>> -	/*
>> -	 * Invoking srp_terminate_io() while srp_queuecommand() is running
>> -	 * is not safe. Hence the warning statement below.
>> -	 */
>> -	shost_for_each_device(sdev, shost)
>> -		WARN_ON_ONCE(sdev->request_queue->request_fn_active);
>> -
>>  	for (i = 0; i < target->ch_count; i++) {
>>  		ch = &target->ch[i];
> 
> It seems like Hannes' and my Signed-off-by/Reviewed-by tags are missing?
> See also https://marc.info/?l=linux-scsi&m=153970174514608.

Sorry, forgot to update that one. I'll do that for v2. Thanks for letting
me know.

-- 
Jens Axboe
