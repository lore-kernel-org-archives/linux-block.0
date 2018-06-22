Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: avoid to synchronize rcu inside
 blk_cleanup_queue()
To: Ming Lei <ming.lei@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>
References: <20180620025522.8002-1-ming.lei@redhat.com>
 <20180622114204.4ohrk53td3iijamc@kamzik.brq.redhat.com>
 <8024ab9d-ae82-c8f2-83e3-a9d8fa4ba303@kernel.dk>
 <20180622213115.GA2949@ming.t460p>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <39a212af-2b5b-6eb4-e63c-287051717435@kernel.dk>
Date: Fri, 22 Jun 2018 16:00:04 -0600
MIME-Version: 1.0
In-Reply-To: <20180622213115.GA2949@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/22/18 3:31 PM, Ming Lei wrote:
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 8e57b84e50e9..18ad2b95ff63 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2351,8 +2351,12 @@ static void blk_mq_update_tag_set_depth(struct blk_mq_tag_set *set,
>>  static void blk_mq_del_queue_tag_set(struct request_queue *q)
>>  {
>>  	struct blk_mq_tag_set *set = q->tag_set;
>> +	bool shared;
>>  
>>  	mutex_lock(&set->tag_list_lock);
>> +
>> +	shared = !list_is_singular(&set->tag_list);
> 
> Or:
> 	shared = set->flags & BLK_MQ_F_TAG_SHARED;

That'd work too, yeah.

-- 
Jens Axboe
