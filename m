Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ACD47277C;
	Wed,  2 Sep 2026 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353274; cv=none; b=a2dIb+xDJNlM8is92T0gDEGuOTFcYa/nnquaQCXt7Lwq4r1I2yZ4kiCrePrnQ33Ze+IvcAxwOg2x6xBxWKI2DHwM98jWLBY4kPr1QVkXe+TO+DJp6pVoXBo/26IQ5/UAvoEv74eSfOmHcOG8jZ9H665MM5yzxoyDY2X4FP4Kmwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353274; c=relaxed/simple;
	bh=Q9kQyjWhYvloLni5+p3BRaSgAjFXjc56F+3W6pUTDcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENCsYAF7l+LIVLHPlT1y28qk/Ps3rSAxtP0gipN2qRbvnjdUtsWCTfANjzH1g3fF5cdGqAZFaV8uguu2tIY8ERbpVHROHVInjjRAWMx5c0fDqUmd9B47upBiO3z8jxOA/9jcgb5xDH5JDXEdvFlIEWQaA9AlJbpCutitTXursTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d2tF162i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bZPWKIt4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k9mjd/EM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5mKd0Ntv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d2tF162i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bZPWKIt4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k9mjd/EM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5mKd0Ntv"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 85B5A219DD;
	Wed,  2 Sep 2026 12:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788353266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6k3Rujfql8uAz7KWLPcq0eb4NgchKW9qLl1syyQI50=;
	b=d2tF162iPVgRbEzW+ZbkAJREoN0cAFK2vlm1HVCCmElSVpflX1e4IGS92CbRAZ4Wv2ZFSU
	RcX+74DakY8aoCG1YGk6b7JbW1FLlaSWgS23fXimXYvlTy8jvsLUTAD/1XwYzHK2kQauil
	uRm7dP0pwKewV4kYburImzbTo0sLsE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788353266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6k3Rujfql8uAz7KWLPcq0eb4NgchKW9qLl1syyQI50=;
	b=bZPWKIt42nVCZ4ZNJ8PWLFqoe3MbJaiChIgHdcX0oN5jP3t5hkQ5T8B4oYg6Nws3GRaHs6
	OENNCWGuUVROlwAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788353262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6k3Rujfql8uAz7KWLPcq0eb4NgchKW9qLl1syyQI50=;
	b=k9mjd/EM2hwkxuUtjq+dZI0UFdQNJDUMn/1Sluw0ni1GYjB8R+v4s8VQaxZNJ+ftDNITX4
	/GzYgFizWm6NT003SpnLDL0SWF5Woi3pSWJtv6nOXiSpl4YsqHb6be/8U0sk4lpls0Z4ju
	jBlGonJj907QoLW3cTZgn9y3sWQr7dA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788353262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6k3Rujfql8uAz7KWLPcq0eb4NgchKW9qLl1syyQI50=;
	b=5mKd0NtvRUg2Cms4TmZd8pRgh/ZiLYibS52MLQq5lpUV9qyhSdU33X97EugZ3x69CTqIyQ
	vcRmUqHOMpHTCMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C614136E6;
	Wed,  2 Sep 2026 12:47:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5SZOB+4amGooLgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 02 Sep 2026 12:47:42 +0000
Message-ID: <e2082e5a-32d9-4a96-abd3-fd6ba7aa97d2@suse.de>
Date: Wed, 2 Sep 2026 14:47:41 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] block: take i_rwsem for the direct I/O write
 fallback
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
 <20260828-blkdev-fixes-v2-2-32f3f40cebed@columbia.edu>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260828-blkdev-fixes-v2-2-32f3f40cebed@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[sashiko.dev:url,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[columbia.edu:email,sashiko.dev:url,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

On 8/28/26 3:49 PM, Tal Zussman wrote:
> Commit c0e473a0d226 ("block: fix race between set_blocksize and read
> paths") closed a race between set_blocksize() and block device I/O: with
> large sector size support, set_blocksize() can change i_blkbits and the
> mapping's minimum folio order while a concurrent reader still holds a
> folio of the old, smaller order, leading to crashes. In particular, it
> made blkdev_write_iter() wrap buffered writes in inode_lock_shared().
> 
> However, the direct I/O fallback path was missed in that conversion.
> blkdev_write_iter() passes blkdev_buffered_write() as an argument to
> direct_write_fallback() with no lock held. A direct write that completes
> only partially then finishes as a buffered write with no protection.
> 
> This can cause a BUG by racing partial direct writes against
> ioctl(BLKBSZSET). Writer threads issue O_DIRECT pwritev() with a
> two-segment iovec whose second segment is an unreadable PROT_NONE
> mapping. The direct path then writes the first segment, fails to pin the
> second, and returns short, entering the fallback. A second thread keeps
> toggling the second segment's protection so that some fallbacks get past
> fault_in_iov_iter_readable() and reach the page cache, a third thread
> populates the page cache with folios of the current block size via
> pread() and readahead(), and a fourth thread toggles the block size
> between 512 bytes and 64K with BLKBSZSET. The minimum folio order only
> moves with block sizes above PAGE_SIZE, i.e. with
> CONFIG_TRANSPARENT_HUGEPAGE raising BLK_MAX_BLOCK_SIZE to 64K.
> 
> On a CONFIG_DEBUG_VM kernel this yields the following BUG:
> 
>    page dumped because: VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping))
>    kernel BUG at mm/filemap.c:858!
>    Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>    RIP: 0010:__filemap_add_folio+0x860/0x8d0
>    Call Trace:
>     filemap_add_folio+0xc9/0x1f0
>     __filemap_get_folio_mpol+0x240/0x660
>     iomap_write_begin+0xa87/0xd70
>     iomap_file_buffered_write+0x304/0x6a0
>     blkdev_write_iter+0x255/0x510
>     do_iter_readv_writev+0x23d/0x3c0
>     vfs_writev+0x211/0x7d0
>     do_pwritev+0x121/0x190
>     do_syscall_64+0x121/0x630
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The same workload also trips WARN_ON_ONCE(pos >= folio_pos(folio) +
> fsize) in iomap_trim_folio_range().
> 
> Fix this by calling blkdev_buffered_write() in the fallback path under
> inode_lock_shared(), matching the plain buffered-write branch. With the
> fix the same workload runs clean.
> 
> A short IOCB_NOWAIT direct write reaches the same fallback. Taking
> i_rwsem there can now block behind set_blocksize(), and the fallback
> already blocks on writeback of the data it copied in
> direct_write_fallback(). blkdev_write_iter() already rejects a purely
> buffered IOCB_NOWAIT write with -EOPNOTSUPP, so do not enter the
> fallback for IOCB_NOWAIT at all: return the bytes the direct path
> already wrote, or -EAGAIN if none, and let the caller retry.
> 
> The reproducer used was written by an LLM, and is available at [1].
> 
> [1] https://gist.github.com/tzussman/69d06bc57d42a42989eb038b1b5aeb74
> 
> Fixes: 3c20917120ce ("block/bdev: enable large folio support for large logical block sizes")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260730-blk-dontcache-v7-0-3e8e6850068d%40columbia.edu?part=5
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>   block/fops.c | 23 ++++++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
> 
You gotta love LLMs; no-one would have written up a testcase with
four different threads...
Anyway. There is a reproducer, so we should be fixing it.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
