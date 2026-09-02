Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CC748C8C4;
	Wed,  2 Sep 2026 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352992; cv=none; b=KYEJ1NuHOK9Eqrw7UH+4NVer3wkIGdEJmD9hdokuYb9LL1/RcMBjSsL1V5HcLWFz1udChnG2/7zwLjHtVblXs4ORlG8og2H059NxI98SvISgQeQxgJnd45mBtFiUPFkPK2dxfvXeGC7kk6YkXR+LTAbl7sA1iRu0kqj3P+dvxdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352992; c=relaxed/simple;
	bh=rB8FwDwWynWToCQcqpqQox8MPqYaewx+oongNmJJ6jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AaIKW0+YIMG+4MMhAx51TASRdFKHkfhYyUwodiQ6r9I8J45Gq58Ruk53ofT2srrTETrlBzHd1xACPkdJ661I50qjpiVIx5SgaubOiJQhao0QzjwULKO4AtIq3fRiCU9dk6H0CWHLi6bXI6WuFBVrgvj84YXq+lZz/zJH7dWP6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jy0QDUtS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xUDwUmmh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IcC1RVcP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NVOEmJQI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jy0QDUtS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xUDwUmmh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IcC1RVcP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NVOEmJQI"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B87DE21A41;
	Wed,  2 Sep 2026 12:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788352984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jr+bXQeQlIYgYzGL8zAXhYqYBet3nKd2SgKBOy6+WP8=;
	b=Jy0QDUtS+RRfukcHYRxKe02t90Rk9a7dO4Z0YdLaqoyny+iA0BY6129wQq0bH1jfKoyg1L
	/PJcWmj0O/ZGWLVZj58iUwimihTy8+NY2pjzifFL92S9oUPI4qTNBCQ5noOiOADb5ppOtA
	l5Sr2RY+M0gMpcu++4lLP33TYYzYPMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788352984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jr+bXQeQlIYgYzGL8zAXhYqYBet3nKd2SgKBOy6+WP8=;
	b=xUDwUmmhERdqrrYORgW7d3yic1LdsJm+qJQE5+wFIqditDaaZ/lchA7HEaYf7JOWr81Ass
	LWSK7x6LE20uOABQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IcC1RVcP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NVOEmJQI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788352980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jr+bXQeQlIYgYzGL8zAXhYqYBet3nKd2SgKBOy6+WP8=;
	b=IcC1RVcPRQixJz0XodFolIZVdTsDCEQfxa36AzLfbEY8xGwZm3Dv1d9OtOmQRAkACSdkOx
	WLcJ6zmgzQZCCtxLlRYrRnyzVg+1oa6CT/VXs6bsE0UkJ2IIBRto15m99Fxegj6Z/1EM2k
	P0gFRna7W5vjdz2gvf97QJaeWX4tWN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788352980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jr+bXQeQlIYgYzGL8zAXhYqYBet3nKd2SgKBOy6+WP8=;
	b=NVOEmJQIcpmi+K/sq7V/gYq7ISiAHCfwFLxSVr0Rdazw0dZdxIK3LmfK2xqRS5IbXH1BxM
	dQzlX75l0xa4JcAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F8DF136E6;
	Wed,  2 Sep 2026 12:43:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gc2cHtQZmGoKKgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 02 Sep 2026 12:43:00 +0000
Message-ID: <676f40aa-2804-4f5b-b0d6-a5f95984601d@suse.de>
Date: Wed, 2 Sep 2026 14:43:00 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] block: use iomap_dirty_folio for block devices
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
 <20260828-blkdev-fixes-v2-1-32f3f40cebed@columbia.edu>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260828-blkdev-fixes-v2-1-32f3f40cebed@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B87DE21A41
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,sashiko.dev:url,suse.de:dkim,suse.de:email,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51

On 8/28/26 3:49 PM, Tal Zussman wrote:
> With CONFIG_BUFFER_HEAD=n, block devices are written back through iomap,
> but def_blk_aops uses filemap_dirty_folio, which only sets PG_dirty. It
> does not set the per-block dirty bits in the folio's iomap_folio_state,
> so iomap_writeback_folio() finds no dirty range, submits no I/O and
> clears PG_dirty, resulting in data loss.
> 
> Other iomap users set .dirty_folio to iomap_dirty_folio, which marks the
> folio's blocks dirty before calling filemap_dirty_folio().
> 
> This is only observable with block size < folio size. With a single
> block there is no iomap_folio_state to get out of sync and
> iomap_writeback_folio() marks the whole folio dirty itself. For a
> page-aligned device, this may require using the BLKBSZSET ioctl to set
> the block size, which requires CAP_SYS_ADMIN. A device whose size is not
> page aligned already gets a sub-page block size from
> set_init_blocksize(), so no ioctl and no privilege is needed.
> 
> To reproduce, on a device with a sub-page block size, write a known
> pattern with O_DIRECT, mmap the same range, store to it, msync() and
> fsync(), then read it back with O_DIRECT. A reproducer is available at
> [1].
> 
> [1] https://gist.github.com/tzussman/18ab05cba4b3fdc79cce0a69d1fd05b4
> 
> Fixes: 925c86a19bac ("fs: add CONFIG_BUFFER_HEAD")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260730-blk-dontcache-v7-0-3e8e6850068d%40columbia.edu?part=5
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>   block/fops.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
