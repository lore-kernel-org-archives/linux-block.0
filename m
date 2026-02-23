Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56728344D91
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848434; cv=none; b=u4xdTJ9QH+Y7Va23uXlE2VaZ4eKIGmN8njrVNSO1ftQUx5R15iuvS0bwvCrlXwGhZB5+ShwCaiMBH3uV9J/ieJLQ9PnpvBgfPWQNhvLAb6eZmgcFz7lBHULqxgzjDxHne1ZHiDo+amdqGyGEg7RrH0fJrxecPmYI6Rw53+WoH9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848434; c=relaxed/simple;
	bh=sLKcpBxNDBN7TPHwmRa79Ohe6hxN5VblMJujYK2GMLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rxh2VNXIR/JAfl02F+3YE1tIYx9DyCtqJ+2Pks15r2F9kov1stdvnqhm5r+X3cWSYgppXqP55+gceitqEjDbUSwxvZQQ2ZfwkuMobDBvXiDxrg4vvb8ceSHRddAnM7f1/C+XE8t1++03SCSAvWDMqiyCMhmePz2Di00z4QZvUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GGrR2Dj3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HnkGaX12; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GGrR2Dj3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HnkGaX12; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GGrR2Dj3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HnkGaX12";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GGrR2Dj3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HnkGaX12"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 85ED75BD12;
	Mon, 23 Feb 2026 12:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771848430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRvzF9lgLUIWU47DM5OAR0hZIzs2MAphVA/nNcrThrM=;
	b=GGrR2Dj3LhPD6hdsxuhf4CP0la4F2RrDGvxmOWQO+LF+wij/cbTHXphgrM7mWwb5hjtl3n
	XrS5b6ZJFjF5t4oHUpFH+Roob75NHuvYlc+R1y4I18N+Hk1UlsVz8D8r2I5sif01zytUxl
	TJvRs0hTl4gxy31xIZifFm3grRKMAds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771848430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRvzF9lgLUIWU47DM5OAR0hZIzs2MAphVA/nNcrThrM=;
	b=HnkGaX12CAuMnAxBw6C/RYnq5AqOuQ63k+j33qwLnLeFhbOJKTyWmHMT+CNWz2OEqhAmlo
	3tUzsVU6KK1aJIDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GGrR2Dj3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HnkGaX12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771848430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRvzF9lgLUIWU47DM5OAR0hZIzs2MAphVA/nNcrThrM=;
	b=GGrR2Dj3LhPD6hdsxuhf4CP0la4F2RrDGvxmOWQO+LF+wij/cbTHXphgrM7mWwb5hjtl3n
	XrS5b6ZJFjF5t4oHUpFH+Roob75NHuvYlc+R1y4I18N+Hk1UlsVz8D8r2I5sif01zytUxl
	TJvRs0hTl4gxy31xIZifFm3grRKMAds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771848430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRvzF9lgLUIWU47DM5OAR0hZIzs2MAphVA/nNcrThrM=;
	b=HnkGaX12CAuMnAxBw6C/RYnq5AqOuQ63k+j33qwLnLeFhbOJKTyWmHMT+CNWz2OEqhAmlo
	3tUzsVU6KK1aJIDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64E863EA68;
	Mon, 23 Feb 2026 12:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7yOdF+5CnGnwUAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Feb 2026 12:07:10 +0000
Message-ID: <f61591f3-1b0a-44c2-b53c-9b10fbf4a432@suse.de>
Date: Mon, 23 Feb 2026 13:07:10 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] block: allow submitting all zone writes from a single
 context
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260221004411.548482-1-dlemoal@kernel.org>
 <20260221004411.548482-7-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260221004411.548482-7-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 85ED75BD12

On 2/21/26 01:44, Damien Le Moal wrote:
> In order to maintain sequential write patterns per zone with zoned block
> devices, zone write plugging issues only a single write BIO per zone at
> any time. This works well but has the side effect that when large
> sequential write streams are issued by the user and these streams cross
> zone boundaries, the device ends up receiving a discontiguous set of
> write commands for different zones. The same also happens when a user
> writes simultaneously at high queue depth multiple zones: the device
> does not see all sequential writes per zone and receives discontiguous
> writes to different zones. While this does not affect the performance of
> solid state zoned block devices, when using an SMR HDD, this pattern
> change from sequential writes to discontiguous writes to different zones
> significantly increases head seek which results in degraded write
> throughput.
> 
> In order to reduce this seek overhead for rotational media devices,
> introduce a per disk zone write plugs kernel thread to issue all write
> BIOs to zones. This single zone write issuing context is enabled for
> any zoned block device that has a request queue flagged with the new
> QUEUE_ZONED_QD1_WRITES flag.
> 
> The flag QUEUE_ZONED_QD1_WRITES is visible as the sysfs queue attribute
> zoned_qd1_writes. For a regular block device, this attribute cannot be
> changed and is always 0. For zoned block devices, a user can override
> the default value set to force the global write maximum queue depth of
> 1 for a zoned block device, or clear this attribute to fallback to the
> default behavior of zone write plugging which limits writes to QD=1 per
> sequential zone.
> 
> Writing to a zoned block device flagged with QUEUE_ZONED_QD1_WRITES is
> implemented using a list of zone write plugs that have a non-empty BIO
> list. Listed zone write plugs are processed by the disk zone write plugs
> worker kthread in FIFO order, and all BIOs of a zone write plug are all
> processed before switching to the next listed zone write plug. A newly
> submitted BIO for a non-FULL zone write plug that is not yet listed
> causes the addition of the zone write plug at the end of the disk list
> of zone write plugs.
> 
> Since the write BIOs queued in a zone write plug BIO list are
> necessarilly sequential, for rotational media, using the single zone
> write plugs kthread to issue all BIOs maintains a sequential write
> pattern and thus reduces seek overhead and improves write throughput.
> This processing essentially result in always writing to HDDs at QD=1,
> which is not an issue for HDDs operating with write caching enabled.
> Performance with write cache disabled is also not degraded thanks to
> the efficient write handling of modern SMR HDDs.
> 
> A disk list of zone write plugs is defined using the new struct gendisk
> zone_wplugs_list, and accesses to this list is protected using the
> zone_wplugs_list_lock spinlock.  The per disk kthread
> (zone_wplugs_worker) code is implemented by the function
> disk_zone_wplugs_worker(). A reference on listed zone write plugs is
> always held until all BIOs of the zone write plug are processed by the
> worker kthread. BIO issuing at QD=1 is driven using a completion
> structure (zone_wplugs_worker_bio_done) and calls to blk_io_wait().
> 
> With this change, performance when sequentially writing the zones of a
> 30 TB SMR SATA HDD connected to an AHCI adapter changes as follows
> (1MiB direct I/Os, results in MB/s unit):
> 
>                      +--------------------+
> 		    |   Write BW (MB/s)  |
>   +------------------+----------+---------+
>   | Sequential write | Baseline | Patched |
>   |  Queue Depth     | 6.19-rc8 |         |
>   +------------------+----------+---------+
>   | 1                | 244      | 245     |
>   | 2                | 244      | 245     |
>   | 4                | 245      | 245     |
>   | 8                | 242      | 245     |
>   | 16               | 222      | 246     |
>   | 32               | 211      | 245     |
>   | 64               | 193      | 244     |
>   | 128              | 112      | 246     |
>   +------------------+----------+---------+
> 
> With the current code (baseline), as the sequential write stream crosses
> a zone boundary, higher queue depth creates a gap between the
> last IO to the previous zone and the first IOs to the following zones,
> causing head seeks and degrading performance. Using the disk zone
> write plugs worker thread, this pattern disappears and the maximum
> throughput of the drive is maintained, leading to over 100%
> improvements in throughput for high queue depth write.
> 
> Using 16 fio jobs all writing to randomly chosen zones at QD=32 with 1
> MiB direct IOs, write throughput also increases significantly.
> 
>                      +--------------------+
> 		    |   Write BW (MB/s)  |
>   +------------------+----------+---------+
>   |   Random write   | Baseline | Patched |
>   |  Number of zones | 6.19-rc7 |         |
>   +------------------+----------+---------+
>   | 1                | 191      | 192     |
>   | 2                | 101      | 128     |
>   | 4                | 115      | 123     |
>   | 8                | 90       | 120     |
>   | 16               | 64       | 115     |
>   | 32               | 58       | 105     |
>   | 64               | 56       | 101     |
>   | 128              | 55       | 99      |
>   +------------------+----------+---------+
> 
> Tests using XFS shows that buffered write speed with 8 jobs writing
> files increases by 12% to 35% depending on the workload.
> 
>                      +--------------------+
> 		    |   Write BW (MB/s)  |
>   +------------------+----------+---------+
>   |     Workload     | Baseline | Patched |
>   |                  | 6.19-rc7 |         |
>   +------------------+----------+---------+
>   | 256MiB file size | 212      | 238     |
>   +------------------+----------+---------+
>   | 4MiB .. 128 MiB  | 213      | 243     |
>   | random file size |          |         |
>   +------------------+----------+---------+
>   | 2MiB .. 8 MiB    | 179      | 242     |
>   | random file size |          |         |
>   +------------------+----------+---------+
> 
> Performance gains are even more significant when using an HBA that
> limits the maximum size of commands to a small value, e.g. HBAs
> controlled with the mpi3mr driver limit commands to a maximum of 1 MiB.
> In such case, the write throughput gains are over 40%.
> 
>                      +--------------------+
> 		    |   Write BW (MB/s)  |
>   +------------------+----------+---------+
>   |     Workload     | Baseline | Patched |
>   |                  | 6.19-rc7 |         |
>   +------------------+----------+---------+
>   | 256MiB file size | 175      | 245     |
>   +------------------+----------+---------+
>   | 4MiB .. 128 MiB  | 174      | 244     |
>   | random file size |          |         |
>   +------------------+----------+---------+
>   | 2MiB .. 8 MiB    | 171      | 243     |
>   | random file size |          |         |
>   +------------------+----------+---------+
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-mq-debugfs.c |   1 +
>   block/blk-sysfs.c      |  35 ++++++++
>   block/blk-zoned.c      | 197 +++++++++++++++++++++++++++++++++++------
>   include/linux/blkdev.h |   8 ++
>   4 files changed, 215 insertions(+), 26 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 28167c9baa55..047ec887456b 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -97,6 +97,7 @@ static const char *const blk_queue_flag_name[] = {
>   	QUEUE_FLAG_NAME(NO_ELV_SWITCH),
>   	QUEUE_FLAG_NAME(QOS_ENABLED),
>   	QUEUE_FLAG_NAME(BIO_ISSUE_TIME),
> +	QUEUE_FLAG_NAME(ZONED_QD1_WRITES),
>   };
>   #undef QUEUE_FLAG_NAME
>   
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index f3b1968c80ce..789802286d95 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -384,6 +384,39 @@ static ssize_t queue_nr_zones_show(struct gendisk *disk, char *page)
>   	return queue_var_show(disk_nr_zones(disk), page);
>   }
>   
> +static ssize_t queue_zoned_qd1_writes_show(struct gendisk *disk, char *page)
> +{
> +	return queue_var_show(!!blk_queue_zoned_qd1_writes(disk->queue),
> +			      page);
> +}
> +
> +static ssize_t queue_zoned_qd1_writes_store(struct gendisk *disk,
> +					    const char *page, size_t count)
> +{
> +	struct request_queue *q = disk->queue;
> +	unsigned long qd1_writes;
> +	unsigned int memflags;
> +	ssize_t ret;
> +
> +	if (!blk_queue_is_zoned(q))
> +		return -EOPNOTSUPP;
> +
> +	ret = queue_var_store(&qd1_writes, page, count);
> +	if (ret < 0)
> +		return ret;
> +
> +	memflags = blk_mq_freeze_queue(q);
> +	blk_mq_quiesce_queue(q);
> +	if (qd1_writes)
> +		blk_queue_flag_set(QUEUE_FLAG_ZONED_QD1_WRITES, q);
> +	else
> +		blk_queue_flag_clear(QUEUE_FLAG_ZONED_QD1_WRITES, q);
> +	blk_mq_unquiesce_queue(q);
> +	blk_mq_unfreeze_queue(q, memflags);
> +
> +	return count;
> +}
> +
>   static ssize_t queue_iostats_passthrough_show(struct gendisk *disk, char *page)
>   {
>   	return queue_var_show(!!blk_queue_passthrough_stat(disk->queue), page);
> @@ -611,6 +644,7 @@ QUEUE_LIM_RO_ENTRY(queue_max_zone_append_sectors, "zone_append_max_bytes");
>   QUEUE_LIM_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
>   
>   QUEUE_LIM_RO_ENTRY(queue_zoned, "zoned");
> +QUEUE_RW_ENTRY(queue_zoned_qd1_writes, "zoned_qd1_writes");
>   QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
>   QUEUE_LIM_RO_ENTRY(queue_max_open_zones, "max_open_zones");
>   QUEUE_LIM_RO_ENTRY(queue_max_active_zones, "max_active_zones");
> @@ -748,6 +782,7 @@ static struct attribute *queue_attrs[] = {
>   	&queue_nomerges_entry.attr,
>   	&queue_poll_entry.attr,
>   	&queue_poll_delay_entry.attr,
> +	&queue_zoned_qd1_writes_entry.attr,
>   
>   	NULL,
>   };

Can't you plug it into the 'queue_attr_visible()' function, too,
such that it doesn't even show up for non-zoned drives?
(After all, it's not that you can change between zoned and
non-zoned drives.)
(One hopes :-)

And I really had hoped that we wouldn't need to introduce new
kthreads, rather that workqueue are the new kthreads.
Any reasoning why you couldn't use workqueues here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
