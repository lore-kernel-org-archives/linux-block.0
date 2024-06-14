Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF95B1922DB;
	Fri, 14 Jun 2024 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718364097; cv=none; b=LQVPEgPe6SnCi32ZR9Tjx/NZHJmAjQQ4NDU5BBucKO4G3RkcYIgktjYc1k9HEpMMqwHMkIznYZYOsdBG+Gnbx7kMGkAcgLm0Vyclo0BRsNHB9lko87MrYgaO+03t4U90CnhIAGzRe4YUROd3CLQV1q5gyh5F1J2JCcYazNhs7yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718364097; c=relaxed/simple;
	bh=Fk2bp+GIffzDwEC7aQtOfpug0emOQaAVjf3NSFbxpeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcxkOlQTAnZe0c75SBLaNZOhxlF14UhGqRvN6jkhmFy1SnJGvB39Qf0q4xn3kEUOabfxrK+T0I00LiL+8EChtpmJrrMlgRyLvrfbdu6W/9mBeWjT0vDGSGKZdAhXz9URAn1gNZANMc3ayoW9Yfwav2ha7gJ2Xntm8nOgyjma+EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 017D43372A;
	Fri, 14 Jun 2024 11:21:34 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9D9D13AAF;
	Fri, 14 Jun 2024 11:21:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /SALOb0nbGa/FgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 14 Jun 2024 11:21:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8C4EAA0873; Fri, 14 Jun 2024 13:21:29 +0200 (CEST)
Date: Fri, 14 Jun 2024 13:21:29 +0200
From: Jan Kara <jack@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] loop: Disable fallocate() zero and discard if not
 supported
Message-ID: <20240614112129.s7hvcyqmnwmngiko@quack3>
References: <20240613163817.22640-1-chrubis@suse.cz>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613163817.22640-1-chrubis@suse.cz>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 017D43372A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Thu 13-06-24 18:38:17, Cyril Hrubis wrote:
> If fallcate is implemented but zero and discard operations are not
     ^^^ fallocate

> supported by the filesystem the backing file is on we continue to fill
> dmesg with errors from the blk_mq_end_request() since each time we call
> fallocate() on the loop device the EOPNOTSUPP error from lo_fallocate()
> ends up propagated into the block layer. In the end syscall succeeds
> since the blkdev_issue_zeroout() falls back to writing zeroes which
> makes the errors even more misleading and confusing.
> 
> How to reproduce:
> 
> 1. make sure /tmp is mounted as tmpfs
> 2. dd if=/dev/zero of=/tmp/disk.img bs=1M count=100
> 3. losetup /dev/loop0 /tmp/disk.img
> 4. mkfs.ext2 /dev/loop0
> 5. dmesg |tail
> 
> [710690.898214] operation not supported error, dev loop0, sector 204672 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
> [710690.898279] operation not supported error, dev loop0, sector 522 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
> [710690.898603] operation not supported error, dev loop0, sector 16906 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
> [710690.898917] operation not supported error, dev loop0, sector 32774 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
> [710690.899218] operation not supported error, dev loop0, sector 49674 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
> [710690.899484] operation not supported error, dev loop0, sector 65542 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
> [710690.899743] operation not supported error, dev loop0, sector 82442 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
> [710690.900015] operation not supported error, dev loop0, sector 98310 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
> [710690.900276] operation not supported error, dev loop0, sector 115210 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
> [710690.900546] operation not supported error, dev loop0, sector 131078 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
> 
> This patch changes the lo_fallocate() to clear the flags for zero and
> discard operations if we get EOPNOTSUPP from the backing file fallocate
> callback, that way we at least stop spewing errors after the first
> unsuccessful try.
> 
> CC: Jan Kara <jack@suse.cz>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Thanks. Besides the spelling fix the patch looks good to me. Feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

>  drivers/block/loop.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 93780f41646b..1153721bc7c2 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -302,6 +302,21 @@ static int lo_read_simple(struct loop_device *lo, struct request *rq,
>  	return 0;
>  }
>  
> +static void loop_clear_limits(struct loop_device *lo, int mode)
> +{
> +	struct queue_limits lim = queue_limits_start_update(lo->lo_queue);
> +
> +	if (mode & FALLOC_FL_ZERO_RANGE)
> +		lim.max_write_zeroes_sectors = 0;
> +
> +	if (mode & FALLOC_FL_PUNCH_HOLE) {
> +		lim.max_hw_discard_sectors = 0;
> +		lim.discard_granularity = 0;
> +	}
> +
> +	queue_limits_commit_update(lo->lo_queue, &lim);
> +}
> +
>  static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
>  			int mode)
>  {
> @@ -320,6 +335,14 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
>  	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
>  	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
>  		return -EIO;
> +
> +	/*
> +	 * We initially configure the limits in a hope that fallocate is
> +	 * supported and clear them here if that turns out not to be true.
> +	 */
> +	if (unlikely(ret == -EOPNOTSUPP))
> +		loop_clear_limits(lo, mode);
> +
>  	return ret;
>  }
>  
> -- 
> 2.44.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
