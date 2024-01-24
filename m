Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4DFF9C6
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 06:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706077037; cv=none; b=XRfjDOF/W+DKHFKiRYQHG2HikyDT8tbNsWVGBFvWFrBS4Mp9fumCIXQynaMaSem8OU7SJ2Q60Z/leNpZLSa7cnHDMaOydrFzyjPg7+XWEZVgTzgqHtM24uBFYI19HLTWT22v9HqhpOygR7m5GQLGiXqFV/zvX+Q2fEbERzBW9dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706077037; c=relaxed/simple;
	bh=0WUdAW7bYtunl3/OSinQsdRQJCArt+a4Ecr9zrg7p7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nw2Fd6tH3YTAYGVTnmD4NmtV/+0AaL68Sws8ViMBLr++ZEwLgiuArRFSgqlwZiuS4dCmk0CKxsQVHDaCtoGPXkxal5qCEdN4XYg7BtCQVcx0Jhz7J0rj7/NeRzjc+ppnDOP+tG9QvmZQk/lgXNyBFRbIytXPKgP+dKQ8KrnZSBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RMlYniD3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wcIcOrSs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dRjnXYDN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qo+pVv2U; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RMlYniD3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wcIcOrSs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dRjnXYDN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qo+pVv2U"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E8D6D1F7DA;
	Wed, 24 Jan 2024 06:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706077034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihzDv7m3WPNQZZDKM3A8l2TUYeN58OfvBL82z74lJ5U=;
	b=RMlYniD3QMO2OX2sXpGzugDtyC0UdOUir5SmQINM7+RyylRiC3YQ/EbS5MVxxl64NrxwOL
	dp1ChXVAnt29S6BAuoEjlgpobEvgPsGArN9rCNXHKA4ZSu/rjvxFvpPpPRJnVMLveoJkV8
	A7qxug1qJPgMPH5ZKBj3wzR0gV274Rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706077034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihzDv7m3WPNQZZDKM3A8l2TUYeN58OfvBL82z74lJ5U=;
	b=wcIcOrSsSxz3cMwgeku72YQAGFc2FKEHqdWo30las5JZPdkJobbkqiCSv7/G6urlh2xyX1
	Xq3GJEe/hQknmZAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706077033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihzDv7m3WPNQZZDKM3A8l2TUYeN58OfvBL82z74lJ5U=;
	b=dRjnXYDNiHpA02UWCKqgh3ygGvPn1DIp9OVdyQ2ONLm9xlJlLuzaPduqBCW+DRPz0Z7pwU
	Py6yt1cMoWgINvAsjoN5p/5Y6mcqWEuSXI8VNdeufCTWapsiQaxIvllbmXUDd49NjGZoDZ
	KEbJ8ZNkQVSd0YE46pwdiIVVLUdVdTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706077033;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihzDv7m3WPNQZZDKM3A8l2TUYeN58OfvBL82z74lJ5U=;
	b=Qo+pVv2UkbNd9v+ORP7kbRpmQbe354XWAX5WZa3aJ0gq4yOkcUgbS57r/7w1Rhb/3uR3nq
	IpdSVpz6phwL6yCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E0991333E;
	Wed, 24 Jan 2024 06:17:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iJTVDWmrsGVhSAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 24 Jan 2024 06:17:13 +0000
Message-ID: <d15069ca-0d53-4447-9a04-2efeaf156750@suse.de>
Date: Wed, 24 Jan 2024 07:17:13 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] block: pass a queue_limits argument to
 blk_mq_alloc_disk
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-11-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240122173645.1686078-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dRjnXYDN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Qo+pVv2U
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,lst.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.00
X-Rspamd-Queue-Id: E8D6D1F7DA
X-Spam-Flag: NO

On 1/22/24 18:36, Christoph Hellwig wrote:
> Pass a queue_limits to blk_mq_alloc_disk and apply it if non-NULL.  This
> will allow allocating queues with valid queue limits instead of setting
> the values one at a time later.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/um/drivers/ubd_kern.c          | 2 +-
>   block/blk-mq.c                      | 5 +++--
>   drivers/block/amiflop.c             | 2 +-
>   drivers/block/aoe/aoeblk.c          | 2 +-
>   drivers/block/ataflop.c             | 2 +-
>   drivers/block/floppy.c              | 2 +-
>   drivers/block/loop.c                | 2 +-
>   drivers/block/mtip32xx/mtip32xx.c   | 2 +-
>   drivers/block/nbd.c                 | 2 +-
>   drivers/block/null_blk/main.c       | 2 +-
>   drivers/block/ps3disk.c             | 2 +-
>   drivers/block/rbd.c                 | 2 +-
>   drivers/block/rnbd/rnbd-clt.c       | 2 +-
>   drivers/block/sunvdc.c              | 2 +-
>   drivers/block/swim.c                | 2 +-
>   drivers/block/swim3.c               | 2 +-
>   drivers/block/ublk_drv.c            | 2 +-
>   drivers/block/virtio_blk.c          | 2 +-
>   drivers/block/xen-blkfront.c        | 2 +-
>   drivers/block/z2ram.c               | 2 +-
>   drivers/cdrom/gdrom.c               | 2 +-
>   drivers/memstick/core/ms_block.c    | 2 +-
>   drivers/memstick/core/mspro_block.c | 2 +-
>   drivers/mmc/core/queue.c            | 2 +-
>   drivers/mtd/mtd_blkdevs.c           | 2 +-
>   drivers/mtd/ubi/block.c             | 2 +-
>   drivers/nvme/host/core.c            | 2 +-
>   drivers/s390/block/dasd_genhd.c     | 2 +-
>   drivers/s390/block/scm_blk.c        | 2 +-
>   include/linux/blk-mq.h              | 7 ++++---
>   30 files changed, 35 insertions(+), 33 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich

