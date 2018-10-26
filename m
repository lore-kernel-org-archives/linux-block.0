Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 05/28] IB/srp: remove old request_fn_active check
To: Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>, Parav Pandit <parav@mellanox.com>
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-6-axboe@kernel.dk>
 <e643e59f-9569-812f-7d24-871d2a5c3106@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a62229d7-83e9-c298-7d42-7130fb9fe11f@kernel.dk>
Date: Fri, 26 Oct 2018 08:32:19 -0600
MIME-Version: 1.0
In-Reply-To: <e643e59f-9569-812f-7d24-871d2a5c3106@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/26/18 1:08 AM, Hannes Reinecke wrote:
> On 10/25/18 11:10 PM, Jens Axboe wrote:
>> This check is only viable for non scsi-mq. Since that is going away,
>> kill this legacy check.
>>
>> Cc: Bart Van Assche <bvanassche@acm.org>
>> Cc: Parav Pandit <parav@mellanox.com>
>> Cc: linux-scsi@vger.kernel.org
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>   drivers/infiniband/ulp/srp/ib_srp.c | 7 -------
>>   1 file changed, 7 deletions(-)
>>
>> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
>> index 0b34e909505f..5a79444c2f3c 100644
>> --- a/drivers/infiniband/ulp/srp/ib_srp.c
>> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
>> @@ -1334,13 +1334,6 @@ static void srp_terminate_io(struct srp_rport *rport)
>>   	struct scsi_device *sdev;
>>   	int i, j;
>>   
>> -	/*
>> -	 * Invoking srp_terminate_io() while srp_queuecommand() is running
>> -	 * is not safe. Hence the warning statement below.
>> -	 */
>> -	shost_for_each_device(sdev, shost)
>> -		WARN_ON_ONCE(sdev->request_queue->request_fn_active);
>> -
>>   	for (i = 0; i < target->ch_count; i++) {
>>   		ch = &target->ch[i];
>>   
>>
> I _think_ I've already killed that one; please do check the latest tree 
> from Doug Ledford.

I don't know which tree is Doug's, but as long as it's queued up
for mainline, that's all I care about. I'm still rebasing this
branch, so it'll just get dropped when it shows up in mainline.

-- 
Jens Axboe
