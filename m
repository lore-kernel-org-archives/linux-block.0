Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99856466B5E;
	Wed,  2 Sep 2026 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358159; cv=none; b=riw+5/yadSIyTiLxd7mdd8129aukcaiSV03QkzqTiXwN0XOPfueldIi9/zHXUsTiQv4Rh+8tZPMmibqA3PiwEuumPGMbAuVq6KF11k73LKWwyNTCa8/WhK1Vq9ybj7TSUg6BUlyCh4jNSBG2SaVkFOMCMLxcXDeM1TvY7ijFrec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358159; c=relaxed/simple;
	bh=7tzFnLeuCNh6d1Tt5dOYgeiFrwOMyGhNN2JcJtUcOiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8RW5KtAbAhtIjUW3pa7RaD/P8YPLtIYl1S/BaZ4AmSMr2rNEGSC8yexEv3zQkyc4HbYgxkz0uK29XJBXM0rnXwK6T0BVoe4ubtS1DelcLG79xEWoPuu2RaTC0HGXm3Qd7ZVXaXWkTAGzQkynVUwZZIUcnMC8ECbV8dg/0zYbGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x/emDrI4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qx8VgQgS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Cgs0VaoI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t1MCUFJf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x/emDrI4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qx8VgQgS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Cgs0VaoI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t1MCUFJf"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 727FA1F7B8;
	Wed,  2 Sep 2026 14:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788358151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYGWPd2K+k2Qr533mg2/G9mae98f60x3t/mYInIYMb0=;
	b=x/emDrI4OAiuAeKf9rvzNuMzIs7eDMweNhgR7fqKWP30R8PWXlWVX48nXaq+EiCcRCAdOk
	jRjGO183APAhHUiDg814SM+E0S9Rxlrvdoo/SlEnpVpPlYtppRtp406XCc/vWlGR5Xw+dt
	dKQ5NgWcpvmGVWh2OCwNkJp6ROxCFHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788358151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYGWPd2K+k2Qr533mg2/G9mae98f60x3t/mYInIYMb0=;
	b=Qx8VgQgSLCrMUjJjMO1MSq86qzNxpCnhB0z3vlDbd2xvlToO85xQG6PQKuRGQLKMoORx6+
	2WktN5ImvPvGr9Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788358147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYGWPd2K+k2Qr533mg2/G9mae98f60x3t/mYInIYMb0=;
	b=Cgs0VaoICclzTWhnWgRUmLtrv/QIKn/UKJlz7Sp97qicImDkXPHpVvKjGB7Nf9Da8hkPqi
	4tDvstoGbnCBSmhmXWVj0Rg64UoQ2Vo0dzaXgW9TWfXEDO7WmGI1KLMo+jqFEmSMjGCZRs
	gE4grOG46UUaG5iZqmjvKNQDdhLXy5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788358147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYGWPd2K+k2Qr533mg2/G9mae98f60x3t/mYInIYMb0=;
	b=t1MCUFJfJOE4ET0tExaDnSlukzPKkWGcG9bptkTFp4g/VrbEd4obMcgyj6LkxYk0rzFfXU
	frVM7COPbeGzMpBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1752E136E6;
	Wed,  2 Sep 2026 14:09:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F2vnBAMumGq6AQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 02 Sep 2026 14:09:07 +0000
Message-ID: <c7fc92de-7196-4af2-acb8-fe849af70754@suse.de>
Date: Wed, 2 Sep 2026 16:09:06 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] block: fail atomic writes instead of falling back
 to buffered I/O
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
 <20260828-blkdev-fixes-v2-5-32f3f40cebed@columbia.edu>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260828-blkdev-fixes-v2-5-32f3f40cebed@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[columbia.edu:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]

On 8/28/26 3:49 PM, Tal Zussman wrote:
> An IOCB_ATOMIC direct write to a block device can silently lose its
> torn-write guarantee in two ways:
> 
>    1. blkdev_direct_write() turns an -EBUSY from page cache invalidation
>       into a 0 return, so the whole write is retried through
>       blkdev_buffered_write(), with no atomicity guarantee.
> 
>    2. On a partial page pin, __blkdev_direct_IO_simple() and
>       __blkdev_direct_IO_async() submit what was pinned with REQ_ATOMIC
>       set and leave the rest to the buffered fallback.
> 
> The second case can be triggered deterministically. A 16K
> pwritev2(RWF_ATOMIC) whose last page is PROT_NONE, on a scsi_debug
> device with atomic_wr=1, completes short with only three of the four
> pages written, violating RWF_ATOMIC semantics.
> 
> Fail the I/O instead. Return -EAGAIN when page cache invalidation fails
> for IOCB_ATOMIC rather than retrying through the page cache, matching
> __iomap_dio_rw(), which treats the failure as transient and lets the
> caller retry. Release a short atomic pin and return -EFAULT before
> submission, which is what a direct write already returns when none of
> the buffer can be pinned. A sync atomic write can then never return
> short with a remainder, so the buffered fallback is never reached.
> 
> ext4 has the same fallback and only warns in it. For block devices both
> ways in can be detected before any I/O is submitted, so fail early instead.
> 
> Fixes: caf336f81b3a ("block: Add fops atomic write support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260802-blkdev-fixes-v1-0-a82fc549fd74%40columbia.edu?part=2
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>   block/fops.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
