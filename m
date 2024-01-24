Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663A63AA
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706076964; cv=none; b=cx+/O3v1rHDGGvODlZhvuywgoMnTu20nzkHcHdPtdVUK6xIZJJfXyAzPOK7rsQrAQZh0eDKmhue7kyQbN1S7gdiD9SLnH4oXpPZ1YIiQsMaHqX1helQKpRnIgmJQ4K04h2OSbdyR558memZBb3e6C3RERnWEi24Sw4BHfL31ltk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706076964; c=relaxed/simple;
	bh=mEMQ3eHE60DcL0HTXyOW/l0AYOD0n+xQ3WsY7yCcSks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuKGkdEIjTKQPtDmR5z0viq+KDPgIfP5MPIiPC7sUTyx2qkWO5vqnYXlZ7dAp3Fsdaz9IhXnlHmrKHxJ0f5E6hZKac2niBwaehrQoDsK1MDB446c+5B8RpCTyo1ZiBth0Uv9685kkhmTnazuwDz+h7QEJbFb97fb31smmrZHzdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sGR/i8hP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dENgFlI2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sGR/i8hP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dENgFlI2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sGR/i8hP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dENgFlI2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sGR/i8hP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dENgFlI2"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6479921EFF;
	Wed, 24 Jan 2024 06:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706076961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wL3FXz2bX5N1hbglbi532xljVQYaOdWVI9JGnLG0v3o=;
	b=sGR/i8hPojM9HF+o9pqL00oSkwBSQYAodpzXDlvzmq35/G6FJox8B29+g0tRRMRIKVgKOg
	I27clxaXjwRDvKR+6/cI2AyTBNIRe4wRSjg6DC0rxb3sRPc+gQcO7IBLhBdvrMyu2sAXmp
	SyP9EX2VxWvJQ4rlNDghfDJEoSCUDnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706076961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wL3FXz2bX5N1hbglbi532xljVQYaOdWVI9JGnLG0v3o=;
	b=dENgFlI2CpSdKT1DWX6EHIbYX5rBWu7ADgBqt48sN66N/UgymTHIP71bhXMRyxwbY53lNJ
	FLgSbn6MP7unAZAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706076961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wL3FXz2bX5N1hbglbi532xljVQYaOdWVI9JGnLG0v3o=;
	b=sGR/i8hPojM9HF+o9pqL00oSkwBSQYAodpzXDlvzmq35/G6FJox8B29+g0tRRMRIKVgKOg
	I27clxaXjwRDvKR+6/cI2AyTBNIRe4wRSjg6DC0rxb3sRPc+gQcO7IBLhBdvrMyu2sAXmp
	SyP9EX2VxWvJQ4rlNDghfDJEoSCUDnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706076961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wL3FXz2bX5N1hbglbi532xljVQYaOdWVI9JGnLG0v3o=;
	b=dENgFlI2CpSdKT1DWX6EHIbYX5rBWu7ADgBqt48sN66N/UgymTHIP71bhXMRyxwbY53lNJ
	FLgSbn6MP7unAZAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEBB11333E;
	Wed, 24 Jan 2024 06:16:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +KSoLSCrsGVhSAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 24 Jan 2024 06:16:00 +0000
Message-ID: <27555186-8a15-43c0-a6ad-28da519b91b7@suse.de>
Date: Wed, 24 Jan 2024 07:16:00 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] block: pass a queue_limits argument to
 blk_mq_init_queue
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
 <20240122173645.1686078-10-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240122173645.1686078-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.29
X-Spamd-Result: default: False [-1.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.00)[38.47%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 1/22/24 18:36, Christoph Hellwig wrote:
> Pass a queue_limits to blk_mq_init_queue and apply it if non-NULL.  This
> will allow allocating queues with valid queue limits instead of setting
> the values one at a time later.
> 
> Also rename the function to blk_mq_alloc_queue as that is a much better
> name for a function that allocates a queue and always pass the queuedata
> argument instead of having a separate version for the extra argument.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq.c            | 19 +++++++------------
>   block/bsg-lib.c           |  2 +-
>   drivers/nvme/host/apple.c |  2 +-
>   drivers/nvme/host/core.c  |  6 +++---
>   drivers/scsi/scsi_scan.c  |  2 +-
>   drivers/ufs/core/ufshcd.c |  2 +-
>   include/linux/blk-mq.h    |  3 ++-
>   7 files changed, 16 insertions(+), 20 deletions(-)
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

