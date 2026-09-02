Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006D44756AE;
	Wed,  2 Sep 2026 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354259; cv=none; b=cy9tjdGXbufRB13/i4HYvnGIwJeZtXvDwqbYRIzk7CrVoyh8cqA/+lYmxkaWrjMzqUHhcqiP7luKy6EV6jGSaxHXpskZ6tXxBr0aTn44QwbMuKEbEvMv0AXfF2Xkme1bayYpJjs1hPVQQ56GL/wpr0m2MfJgfd3n8AeMh3davfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354259; c=relaxed/simple;
	bh=GpXZI/OqqMDezYCipNWrDDXWztHm06XfE3y96Z95PKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZG+JdA5cD6+RPvldEFmDmyHBGuHyDD7SRmF+4NFubjFPy/3Y6LwXb4nNd3y/n8QXmhQxelXj60Zk1iAiVtpKm+dB/kSg/HDudpf0XDwHQ7gQQ1zYqvvvK/vuw+DCweLvCh5gOeFtQZ3n80UBZmxFYJCYRyf0qpM4zFawIctZnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y452SvEV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eSoUn4lY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mxL9TFtw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UGcH6j5f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y452SvEV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eSoUn4lY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mxL9TFtw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UGcH6j5f"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9BA8321D36;
	Wed,  2 Sep 2026 13:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788354251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TrHZoBJ19a7O8e8QOjl851dqqNWBajXpEJqZgdh9rSk=;
	b=y452SvEVdTKX0bsLSE+CA/QCA92czQY/1HypyIHTu3/MOtasFqgNKxyR6ICbS3xITB61ad
	9tviZEL7hauN7HPowZ3+/WgkgQZgpBWA+azv3Yz++76QXSrzOK/Ij08jPU6Iq61Bf/vKKL
	UrRtztVapmx/2Z5TbpPmc1OsLZDX8CQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788354251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TrHZoBJ19a7O8e8QOjl851dqqNWBajXpEJqZgdh9rSk=;
	b=eSoUn4lYfb3viW1x0YH/5i4g4+2UeGAbGpI8HphDUu55mfJYtvGOtJZ5x6zhdhmoCVbFzZ
	NdBw+q7WCqCOXXBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788354247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TrHZoBJ19a7O8e8QOjl851dqqNWBajXpEJqZgdh9rSk=;
	b=mxL9TFtwnRIwfDXrqsRsLHVn6UQyjKQOLbeDGPHKX0o024QeZHnD1vivXiHtZ9Bg8Tk3CZ
	zUs3NT/ofWet8WGur3TY4GxVUrm9oYFIl6+lLxLHsJxvMOEVKsJXSjMMy5ggKuJiVBTqY+
	l7d+4zMirVaWv+2LgYN5WYYe2Ksnyzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788354247;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TrHZoBJ19a7O8e8QOjl851dqqNWBajXpEJqZgdh9rSk=;
	b=UGcH6j5fYmMfWO6fb/aYaL/Or9NhdXq1+ybuliM7iDVsUh2zCcxAu9hreg+KFQG1YmAWTt
	JKzpu28JcAvPUVAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 627CB136E6;
	Wed,  2 Sep 2026 13:04:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DTSdF8cemGprPwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 02 Sep 2026 13:04:07 +0000
Message-ID: <f9308891-f421-440e-b4b0-f600362aaafc@suse.de>
Date: Wed, 2 Sep 2026 15:04:07 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] block: honor IOCB_NOWAIT in the block device
 buffered read path
To: Tal Zussman <tz2294@columbia.edu>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 John Garry <john.g.garry@oracle.com>, Christian Brauner
 <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Keith Busch <kbusch@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu>
 <20260828-blkdev-fixes-v2-4-32f3f40cebed@columbia.edu>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260828-blkdev-fixes-v2-4-32f3f40cebed@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,columbia.edu:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO

On 8/28/26 3:49 PM, Tal Zussman wrote:
> blkdev_read_iter() takes inode_lock_shared() unconditionally around
> filemap_read(). Unlike blkdev_write_iter(), it does not reject
> IOCB_NOWAIT for buffered I/O, so a non-blocking read, or the buffered
> tail of a short IOCB_NOWAIT direct read, blocks behind set_blocksize()
> holding i_rwsem across sync_blockdev().
> 
> A preadv2(RWF_NOWAIT) issued while another thread changes the block
> size with a dirty page cache blocks for as long as sync_blockdev()
> takes, 4 to 6 seconds on a scsi_debug device with delay=5.
> 
> Use inode_trylock_shared() for IOCB_NOWAIT and return the bytes the
> direct path already read, or -EAGAIN if none, when the lock is
> contended, preserving NOWAIT semantics.
> 
> Fixes: c0e473a0d226 ("block: fix race between set_blocksize and read paths")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260802-blkdev-fixes-v1-0-a82fc549fd74%40columbia.edu?part=2
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>   block/fops.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
