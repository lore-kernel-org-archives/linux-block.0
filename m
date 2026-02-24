Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FCE1C5D44
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 02:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771898761; cv=none; b=uUo9eSCttxb+GhgxAzFP3gNRmIR9r1KW0ylfA6NSS3qVl3HRBMPPAP/Bf6ERCRaljqhDs4RvS5oeSYqEYw9XjG3drxfYy7KdvuUYRtmx1MwVx7iXx0Gf9UOctRZ9LbauLItvV9NfHjrPsNM+8Nx200Bpbyx8WSL5zxVi1S4VdqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771898761; c=relaxed/simple;
	bh=OV3fk9iyLzBM4vnIfFXQQW0bhrwA1chN9mngShFWJ5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EQ4aG8Gbd2FBby2wpFP9b2DRiQgk1KWkH9VadSZGFiLuQUekPGR50XSpOsytfIlcLq9Nq0uYWZ3nX2VCKJZEm1DGOwskMMskowdX0hBryH3wSo2REtAwX5Z1OJqSIAx6SFlqY0ZXg1d09kV2BWAvr8XmASVLL7j5nOLbk/08lQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZqwxNzq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZqwxNzq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9ECC116C6;
	Tue, 24 Feb 2026 02:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771898761;
	bh=OV3fk9iyLzBM4vnIfFXQQW0bhrwA1chN9mngShFWJ5A=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=YZqwxNzq7C4BpHROE98LkMMVM5EFHtvp3gDT9qYBT5oDYkIQBJb/SjV5IIZx0o0Nh
	 JR7BCR3Hw8DkAaWejuskjk2ZDl48RXjVoGq5YIa/DhNiPOkqIcAkTpHAgGj1zNi9/7
	 4RO3q1E3ZeqVKIGh10AsHSknZWzmq9PsZoDFYUa0Iepn8tej/7yKaJfx57153k/Bax
	 7GEc9kCD0PUdjjdq9pcSY787b1fIx9YHWtDAI+DLaDSECH7t1MPqODqHqo5VXH+kRK
	 aALOUftgM/y/9qmYHUZ6uIkq/vFwvoIlrS+x/SdsAextgyoL3b4RBcxSg04wD8p1YC
	 OfMZVlRoAPXCw==
Message-ID: <5ced7cb1-49a2-4ed3-aa93-3784f853cc38@kernel.org>
Date: Tue, 24 Feb 2026 11:00:44 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] block: allow submitting all zone writes from a single
 context
To: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260221004411.548482-1-dlemoal@kernel.org>
 <20260221004411.548482-7-dlemoal@kernel.org>
 <f61591f3-1b0a-44c2-b53c-9b10fbf4a432@suse.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <f61591f3-1b0a-44c2-b53c-9b10fbf4a432@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/23/26 9:07 PM, Hannes Reinecke wrote:
> On 2/21/26 01:44, Damien Le Moal wrote:
>> In order to maintain sequential write patterns per zone with zoned block
>> devices, zone write plugging issues only a single write BIO per zone at
>> any time. This works well but has the side effect that when large
>> sequential write streams are issued by the user and these streams cross
>> zone boundaries, the device ends up receiving a discontiguous set of
>> write commands for different zones. The same also happens when a user
>> writes simultaneously at high queue depth multiple zones: the device
>> does not see all sequential writes per zone and receives discontiguous
>> writes to different zones. While this does not affect the performance of
>> solid state zoned block devices, when using an SMR HDD, this pattern
>> change from sequential writes to discontiguous writes to different zones
>> significantly increases head seek which results in degraded write
>> throughput.
>>
>> In order to reduce this seek overhead for rotational media devices,
>> introduce a per disk zone write plugs kernel thread to issue all write
>> BIOs to zones. This single zone write issuing context is enabled for
>> any zoned block device that has a request queue flagged with the new
>> QUEUE_ZONED_QD1_WRITES flag.
>>
>> The flag QUEUE_ZONED_QD1_WRITES is visible as the sysfs queue attribute
>> zoned_qd1_writes. For a regular block device, this attribute cannot be
>> changed and is always 0. For zoned block devices, a user can override
>> the default value set to force the global write maximum queue depth of
>> 1 for a zoned block device, or clear this attribute to fallback to the
>> default behavior of zone write plugging which limits writes to QD=1 per
>> sequential zone.
>>
>> Writing to a zoned block device flagged with QUEUE_ZONED_QD1_WRITES is
>> implemented using a list of zone write plugs that have a non-empty BIO
>> list. Listed zone write plugs are processed by the disk zone write plugs
>> worker kthread in FIFO order, and all BIOs of a zone write plug are all
>> processed before switching to the next listed zone write plug. A newly
>> submitted BIO for a non-FULL zone write plug that is not yet listed
>> causes the addition of the zone write plug at the end of the disk list
>> of zone write plugs.
>>
>> Since the write BIOs queued in a zone write plug BIO list are
>> necessarilly sequential, for rotational media, using the single zone
>> write plugs kthread to issue all BIOs maintains a sequential write
>> pattern and thus reduces seek overhead and improves write throughput.
>> This processing essentially result in always writing to HDDs at QD=1,
>> which is not an issue for HDDs operating with write caching enabled.
>> Performance with write cache disabled is also not degraded thanks to
>> the efficient write handling of modern SMR HDDs.
>>
>> A disk list of zone write plugs is defined using the new struct gendisk
>> zone_wplugs_list, and accesses to this list is protected using the
>> zone_wplugs_list_lock spinlock.  The per disk kthread
>> (zone_wplugs_worker) code is implemented by the function
>> disk_zone_wplugs_worker(). A reference on listed zone write plugs is
>> always held until all BIOs of the zone write plug are processed by the
>> worker kthread. BIO issuing at QD=1 is driven using a completion
>> structure (zone_wplugs_worker_bio_done) and calls to blk_io_wait().
>>
>> With this change, performance when sequentially writing the zones of a
>> 30 TB SMR SATA HDD connected to an AHCI adapter changes as follows
>> (1MiB direct I/Os, results in MB/s unit):
>>
>>                      +--------------------+
>>             |   Write BW (MB/s)  |
>>   +------------------+----------+---------+
>>   | Sequential write | Baseline | Patched |
>>   |  Queue Depth     | 6.19-rc8 |         |
>>   +------------------+----------+---------+
>>   | 1                | 244      | 245     |
>>   | 2                | 244      | 245     |
>>   | 4                | 245      | 245     |
>>   | 8                | 242      | 245     |
>>   | 16               | 222      | 246     |
>>   | 32               | 211      | 245     |
>>   | 64               | 193      | 244     |
>>   | 128              | 112      | 246     |
>>   +------------------+----------+---------+
>>
>> With the current code (baseline), as the sequential write stream crosses
>> a zone boundary, higher queue depth creates a gap between the
>> last IO to the previous zone and the first IOs to the following zones,
>> causing head seeks and degrading performance. Using the disk zone
>> write plugs worker thread, this pattern disappears and the maximum
>> throughput of the drive is maintained, leading to over 100%
>> improvements in throughput for high queue depth write.
>>
>> Using 16 fio jobs all writing to randomly chosen zones at QD=32 with 1
>> MiB direct IOs, write throughput also increases significantly.
>>
>>                      +--------------------+
>>             |   Write BW (MB/s)  |
>>   +------------------+----------+---------+
>>   |   Random write   | Baseline | Patched |
>>   |  Number of zones | 6.19-rc7 |         |
>>   +------------------+----------+---------+
>>   | 1                | 191      | 192     |
>>   | 2                | 101      | 128     |
>>   | 4                | 115      | 123     |
>>   | 8                | 90       | 120     |
>>   | 16               | 64       | 115     |
>>   | 32               | 58       | 105     |
>>   | 64               | 56       | 101     |
>>   | 128              | 55       | 99      |
>>   +------------------+----------+---------+
>>
>> Tests using XFS shows that buffered write speed with 8 jobs writing
>> files increases by 12% to 35% depending on the workload.
>>
>>                      +--------------------+
>>             |   Write BW (MB/s)  |
>>   +------------------+----------+---------+
>>   |     Workload     | Baseline | Patched |
>>   |                  | 6.19-rc7 |         |
>>   +------------------+----------+---------+
>>   | 256MiB file size | 212      | 238     |
>>   +------------------+----------+---------+
>>   | 4MiB .. 128 MiB  | 213      | 243     |
>>   | random file size |          |         |
>>   +------------------+----------+---------+
>>   | 2MiB .. 8 MiB    | 179      | 242     |
>>   | random file size |          |         |
>>   +------------------+----------+---------+
>>
>> Performance gains are even more significant when using an HBA that
>> limits the maximum size of commands to a small value, e.g. HBAs
>> controlled with the mpi3mr driver limit commands to a maximum of 1 MiB.
>> In such case, the write throughput gains are over 40%.
>>
>>                      +--------------------+
>>             |   Write BW (MB/s)  |
>>   +------------------+----------+---------+
>>   |     Workload     | Baseline | Patched |
>>   |                  | 6.19-rc7 |         |
>>   +------------------+----------+---------+
>>   | 256MiB file size | 175      | 245     |
>>   +------------------+----------+---------+
>>   | 4MiB .. 128 MiB  | 174      | 244     |
>>   | random file size |          |         |
>>   +------------------+----------+---------+
>>   | 2MiB .. 8 MiB    | 171      | 243     |
>>   | random file size |          |         |
>>   +------------------+----------+---------+
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>   block/blk-mq-debugfs.c |   1 +
>>   block/blk-sysfs.c      |  35 ++++++++
>>   block/blk-zoned.c      | 197 +++++++++++++++++++++++++++++++++++------
>>   include/linux/blkdev.h |   8 ++
>>   4 files changed, 215 insertions(+), 26 deletions(-)
>>
>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>> index 28167c9baa55..047ec887456b 100644
>> --- a/block/blk-mq-debugfs.c
>> +++ b/block/blk-mq-debugfs.c
>> @@ -97,6 +97,7 @@ static const char *const blk_queue_flag_name[] = {
>>       QUEUE_FLAG_NAME(NO_ELV_SWITCH),
>>       QUEUE_FLAG_NAME(QOS_ENABLED),
>>       QUEUE_FLAG_NAME(BIO_ISSUE_TIME),
>> +    QUEUE_FLAG_NAME(ZONED_QD1_WRITES),
>>   };
>>   #undef QUEUE_FLAG_NAME
>>   diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index f3b1968c80ce..789802286d95 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -384,6 +384,39 @@ static ssize_t queue_nr_zones_show(struct gendisk *disk,
>> char *page)
>>       return queue_var_show(disk_nr_zones(disk), page);
>>   }
>>   +static ssize_t queue_zoned_qd1_writes_show(struct gendisk *disk, char *page)
>> +{
>> +    return queue_var_show(!!blk_queue_zoned_qd1_writes(disk->queue),
>> +                  page);
>> +}
>> +
>> +static ssize_t queue_zoned_qd1_writes_store(struct gendisk *disk,
>> +                        const char *page, size_t count)
>> +{
>> +    struct request_queue *q = disk->queue;
>> +    unsigned long qd1_writes;
>> +    unsigned int memflags;
>> +    ssize_t ret;
>> +
>> +    if (!blk_queue_is_zoned(q))
>> +        return -EOPNOTSUPP;
>> +
>> +    ret = queue_var_store(&qd1_writes, page, count);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    memflags = blk_mq_freeze_queue(q);
>> +    blk_mq_quiesce_queue(q);
>> +    if (qd1_writes)
>> +        blk_queue_flag_set(QUEUE_FLAG_ZONED_QD1_WRITES, q);
>> +    else
>> +        blk_queue_flag_clear(QUEUE_FLAG_ZONED_QD1_WRITES, q);
>> +    blk_mq_unquiesce_queue(q);
>> +    blk_mq_unfreeze_queue(q, memflags);
>> +
>> +    return count;
>> +}
>> +
>>   static ssize_t queue_iostats_passthrough_show(struct gendisk *disk, char
>> *page)
>>   {
>>       return queue_var_show(!!blk_queue_passthrough_stat(disk->queue), page);
>> @@ -611,6 +644,7 @@ QUEUE_LIM_RO_ENTRY(queue_max_zone_append_sectors,
>> "zone_append_max_bytes");
>>   QUEUE_LIM_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
>>     QUEUE_LIM_RO_ENTRY(queue_zoned, "zoned");
>> +QUEUE_RW_ENTRY(queue_zoned_qd1_writes, "zoned_qd1_writes");
>>   QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
>>   QUEUE_LIM_RO_ENTRY(queue_max_open_zones, "max_open_zones");
>>   QUEUE_LIM_RO_ENTRY(queue_max_active_zones, "max_active_zones");
>> @@ -748,6 +782,7 @@ static struct attribute *queue_attrs[] = {
>>       &queue_nomerges_entry.attr,
>>       &queue_poll_entry.attr,
>>       &queue_poll_delay_entry.attr,
>> +    &queue_zoned_qd1_writes_entry.attr,
>>         NULL,
>>   };
> 
> Can't you plug it into the 'queue_attr_visible()' function, too,
> such that it doesn't even show up for non-zoned drives?
> (After all, it's not that you can change between zoned and
> non-zoned drives.)
> (One hopes :-)

Good point. Will look into that.

> And I really had hoped that we wouldn't need to introduce new
> kthreads, rather that workqueue are the new kthreads.
> Any reasoning why you couldn't use workqueues here?

I can use a single work item instead of a kthread. I had that initially, but
the code ended up cleaner with the kthread. I can try again with the work item
if you insist...

-- 
Damien Le Moal
Western Digital Research
