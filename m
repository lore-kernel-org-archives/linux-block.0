Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v4] virtio_blk: Fix an SG_IO regression
To: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Dann Frazier <dann.frazier@canonical.com>, stable@vger.kernel.org
References: <20171026101015.29855-1-bart.vanassche@wdc.com>
 <20171027063947.GA22931@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <23618215-59e7-bf48-f2eb-3911ccfc582a@kernel.dk>
Date: Fri, 27 Oct 2017 08:24:32 -0600
MIME-Version: 1.0
In-Reply-To: <20171027063947.GA22931@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/27/2017 12:39 AM, Christoph Hellwig wrote:
> On Thu, Oct 26, 2017 at 12:10:15PM +0200, Bart Van Assche wrote:
>> Avoid that submitting an SG_IO ioctl triggers a kernel oops that
>> is preceded by:
>>
>> usercopy: kernel memory overwrite attempt detected to (null) (<null>) (6 bytes)
>> kernel BUG at mm/usercopy.c:72!
>>
>> Reported-by: Dann Frazier <dann.frazier@canonical.com>
>> Fixes: commit ca18d6f769d2 ("block: Make most scsi_req_init() calls implicit")
>> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Dann Frazier <dann.frazier@canonical.com>
>> Cc: <stable@vger.kernel.org> # v4.13
>> ---
>>  drivers/block/virtio_blk.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index 34e17ee799be..e477d4a5181e 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
>> @@ -593,10 +593,20 @@ static int virtblk_map_queues(struct blk_mq_tag_set *set)
>>  	return blk_mq_virtio_map_queues(set, vblk->vdev, 0);
>>  }
>>  
>> +static void virtblk_initialize_rq(struct request *req)
>> +{
>> +	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
>> +
>> +#ifdef CONFIG_VIRTIO_BLK_SCSI
>> +	scsi_req_init(&vbr->sreq);
>> +#endif
> 
> How about only defininig the initialize_rq method and implementation
> if CONFIG_VIRTIO_BLK_SCSI is set?
> 
> Else looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

I did that while merging it.

-- 
Jens Axboe
