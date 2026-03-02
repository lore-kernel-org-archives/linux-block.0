Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1832D5436
	for <linux-block@vger.kernel.org>; Mon,  2 Mar 2026 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772436240; cv=none; b=qMc/Zf3KHx25CtNapQdpmdsotoTK+mfnPNd8CdZIjxqrjsxtEJ8XhNY0+N22EqT/SSXOQ9TN+tD0CfBYB9hNcbTr9T64wgTOCanQqHjd4mHKkIIeqvF0xmmVCaxz2dXv07CSSLiMnoMUCbBOhHT7ybqBTNbiosML3tCQ40lc2Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772436240; c=relaxed/simple;
	bh=T/rwE2qTzy3pnf7Qs8Tz2mS0LtS8WhWbFYfG4Lg3dvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mVF90TGffBBvp9XE+xrkyqXWbs1fJrxKMS23NsUmfgrxqs2459ZP1dd8aI8Ak/6D5dIE+bEJglMa7cRzP7AA+LvkN3sPLGU7eqqk3IBC3x/U6hjyVvLQEbiCH6WwXQt5zNrzQFAtVByP6joLfmkfyRiZXYhDMa050rxrEZwbwC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EULW/eYE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nijisR+T; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xA3FYdRg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gs+ZwFGC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EULW/eYE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nijisR+T";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xA3FYdRg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gs+ZwFGC"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5F6495BD15;
	Mon,  2 Mar 2026 07:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772436237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6mgwBnWFQswLnsKD43R8TtLe6U95/IzWhXEt4lEW4Lo=;
	b=EULW/eYEoBQWGKSDPU564omC35VxVINyjoUx9G/c+OJaq5d7j/tO5qrNdGGd/DWr09WkHk
	8a4eliloThjaujdmxeNiG56kNWxDO0zw4TbDaIETTdODff7g5aII5WdujRnpNOvkua+zKp
	JYd1WnHBUTF+HIAHzGDnow+PFd08ZYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772436237;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6mgwBnWFQswLnsKD43R8TtLe6U95/IzWhXEt4lEW4Lo=;
	b=nijisR+TgKyPGlFJxdGl2QZLbxPgOl/R3F27897qZIixW1UIL3M/lIB+pWkqRCDqJ2kbBV
	x63HcrIolnuVNtAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772436236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6mgwBnWFQswLnsKD43R8TtLe6U95/IzWhXEt4lEW4Lo=;
	b=xA3FYdRggPs9+HJJ8bbxxnsGU2qU+aN/2RDDKhtVPYbdy1Mkzrl49Od9FOMBwXdVFWZLHq
	lPvUUyMoPF5SGXTvDBr5e72XSTJFJ2ucXdM8x+03XjfPaqXYcg4A0QCNqGOtTQbUgZ/qQk
	/OJZwJFwCLyyv9m01ALlEGVv7kxMa1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772436236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6mgwBnWFQswLnsKD43R8TtLe6U95/IzWhXEt4lEW4Lo=;
	b=gs+ZwFGC0Uo6I4i5kgbOBRaMeDxYHBqOdSJQyVs8dGK4D0oK+JTmcge0Q9n5sNzJ27G76A
	zqeILIX5y/Ryc+Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DCAB3EA69;
	Mon,  2 Mar 2026 07:23:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9mzDCAw7pWmHbgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Mar 2026 07:23:56 +0000
Message-ID: <aa6ae051-1ead-4d31-bec9-c990f278e5df@suse.de>
Date: Mon, 2 Mar 2026 08:23:55 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] block: allow submitting all zone writes from a
 single context
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260227014951.2327711-1-dlemoal@kernel.org>
 <20260227014951.2327711-7-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260227014951.2327711-7-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,acm.org:email,lst.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 2/27/26 02:49, Damien Le Moal wrote:
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
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-mq-debugfs.c |   1 +
>   block/blk-sysfs.c      |  38 ++++++++-
>   block/blk-zoned.c      | 190 ++++++++++++++++++++++++++++++++++++-----
>   include/linux/blkdev.h |   8 ++
>   4 files changed, 215 insertions(+), 22 deletions(-)
> 
Signed-off-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
