Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 11/11] nvme: add support for streams and directives
To: Andreas Dilger <adilger@dilger.ca>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <1497374123-15286-12-git-send-email-axboe@kernel.dk>
 <92146B74-09FB-44B4-9E95-C511B81038E4@dilger.ca>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <93088bfd-2a06-74a1-71f8-9812a7bda63d@kernel.dk>
Date: Tue, 13 Jun 2017 14:25:21 -0600
MIME-Version: 1.0
In-Reply-To: <92146B74-09FB-44B4-9E95-C511B81038E4@dilger.ca>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 06/13/2017 01:47 PM, Andreas Dilger wrote:
> On Jun 13, 2017, at 11:15 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> This adds support for Directives in NVMe, particular for the Streams
>> directive. We default to allocating 4 streams per name space, but
>> it is configurable with the 'streams_per_ns' module option.
>>
>> If a write stream is set in a write, flag is as such before
>> sending it to the device.
>>
>> Some debug stuff in this patch, dumping streams ID params when
>> we load nvme.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>> drivers/nvme/host/core.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++
>> drivers/nvme/host/nvme.h |   1 +
>> include/linux/nvme.h     |  48 ++++++++++++++++++
>> 3 files changed, 173 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 903d5813023a..81225e7d4176 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -65,6 +65,10 @@ static bool force_apst;
>> module_param(force_apst, bool, 0644);
>> MODULE_PARM_DESC(force_apst, "allow APST for newly enumerated devices even if quirked off");
>>
>> +static char streams_per_ns = 4;
>> +module_param(streams_per_ns, byte, 0644);
>> +MODULE_PARM_DESC(streams_per_ns, "if available, allocate this many streams per NS");
> 
> Are there any limits here?  For example, has to be a power-of-two value, or maximum
> number per namespace, per device, etc?

It doesn't have to be a power-of-two. Basically the device has X number of
streams available, and you can assign 1..X to a name space. Since we used
four for the API, I just open four here. It's mostly for testing, in reality
we should probably just split the available streams between namespaces and
be done with it. Either we want to use streams, and then all of them, or none
at all.

>> @@ -351,6 +355,15 @@ static inline void nvme_setup_rw(struct nvme_ns *ns, struct request *req,
>> 	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
>> 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
>>
>> +	if (req_op(req) == REQ_OP_WRITE) {
>> +		if (bio_stream_valid(req->bio) && ns->streams) {
>> +			unsigned stream = bio_stream(req->bio) & 0xffff;
>> +
>> +			control |= NVME_RW_DTYPE_STREAMS;
>> +			dsmgmt |= (stream << 16);
> 
> It isn't really clear how this is converted from the 2^16 stream IDs masked
> out of 2^32 possible streams in the bio into streams_per_ns = 4 streams per
> NVMe device namespace.  This appears to be implicitly dependent on upper
> layers submitting only 4 distinct WRITE_FILE_* stream IDs, but IMHO that
> should be handled transparently at this level.  There isn't really any value
> to mask the returned bio_stream with 0xffff, since either it will internally
> be truncated by streams_per_ns (in which case we don't need to do anything),
> or it should be explicitly folded into the accepted range, like:
> 
> 			dsmgmt |= (bio_stream(req->bio) % streams_per_ns) << 16;
> 
> or if we want to avoid a 32-bit modulus here, we could pre-compute a mask from
> streams_per_ns and enforce that this be a power-of-two value?

Right, and I think we should handle this in the block layer. Have the device
flag how many streams it supports, and just multiplex if we have to. Then the
device can rely on the fact that it never receives a stream ID that's larger
than it supports. Or just MOD it with streams_per_ns like you suggest. I'll
do the latter for now.

The 0xffff mask is typically done in drivers to inform the reader that the
spec has 16-bits set aside for this.

-- 
Jens Axboe
