Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26DF46EC81
	for <linux-block@vger.kernel.org>; Fri,  7 Aug 2026 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103637; cv=none; b=jaG6iB0WEiJIV0tuP/8g5GnZsCpOaeiOjUw8fR4OnZ9IIg06lC9wvfZLbDmI03HVgfc2g9CNhcQtUkPe5c8aqJvWu2SPNsu4zUzbjvvr1Oy4FsvzEgrnrZ4ekKH4VHUdMrErTR2s0gI4cLTbIa69Sepq6W/14dW3qae5yJTF9FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103637; c=relaxed/simple;
	bh=HAxTTYTclPYxPPteGMWtBYMrw9GHt78USZX5TcgaE78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0JaiamoyUogvlzbun/chZc2l1q88HC2TN9zkAY+ewVCU1izOr1nxEbd0wYfAqxl3YI8VxWgD3NDpKYdPdUOkqERh3mIjxDL0zYCTsN8RH0rsflInd20YLonsnVQ5IE+Qy/+qy2iexHAWDd12fOWdofR3hfjzAOtTjadWt2q/as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bvcFu7QL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pYtGCN52; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qaA1JgMd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NAYEk3EZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bvcFu7QL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pYtGCN52";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qaA1JgMd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NAYEk3EZ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 90A3C3E1D;
	Fri,  7 Aug 2026 11:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786103619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XF6kxDi5oZfzTeV72JIySXpva8zH2jEHi2SRlAfCKz8=;
	b=bvcFu7QL3z1tF7pN6NVyx99eGol2PRcCKsBXFVadti3Nwdou09O7WcEzkc4EP3pwC7LWiX
	iSTjW34lwG3sL6i2d/8n8sfme6HZwXI740FtgM7tsshGHRPpogIlPAkPW0emONqS+1l3MF
	+fqTbgamSigQlXDMKUUvxh+4nA3Vd7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786103619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XF6kxDi5oZfzTeV72JIySXpva8zH2jEHi2SRlAfCKz8=;
	b=pYtGCN52YXBSjjRRBXfCS9+aTaj9g8y53ODBAYn4PWhfcbiavx0SDe/isfwev8LDCBGmSc
	kPaU5hlGi6fu85Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qaA1JgMd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NAYEk3EZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786103615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XF6kxDi5oZfzTeV72JIySXpva8zH2jEHi2SRlAfCKz8=;
	b=qaA1JgMdQ6rDqoVF4JAmB7cq/qUvfD1VqKYAXX4D6pby3olmgGcvOwBAqgWDzEAjQA2IT7
	z+aKXeXVybLMCHYWkWzi2qBGrqbDuO13aR+aEPw57umfRoNRxjie90UC0IJ52spKVSG4+i
	vDQk+NU/RuLrwcdihm40hAZueqrDjVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786103615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XF6kxDi5oZfzTeV72JIySXpva8zH2jEHi2SRlAfCKz8=;
	b=NAYEk3EZnSYwwwPQHTTj+Ts3fa8KsKgrGNTAB7HdS2nEF4OiezJqg9L9hk7q2P3RcGQLkg
	0SEdZIFDL14NpmDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7ED30779B6;
	Fri,  7 Aug 2026 11:53:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cf4oHj/HdWqyGAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 07 Aug 2026 11:53:35 +0000
Message-ID: <fed17865-2601-4910-9604-046581783d50@suse.de>
Date: Fri, 7 Aug 2026 13:53:35 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/13] block: flag zoned disks with GENHD_FL_NO_PART
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260806160445.848337-1-dlemoal@kernel.org>
 <20260806160445.848337-14-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260806160445.848337-14-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 90A3C3E1D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On 8/6/26 6:04 PM, Damien Le Moal wrote:
> Zoned block devices do not support partitions. However, the partition
> table is nevertheless still inspected, and any partition found ignored
> with a warning in add_partition(). While this is generally not a problem,
> and in fact beneficial to the user as it indicates an invalid use of a
> zoned block device, scanning for a partition table on the device may
> result in issuing read operations to offline zones (e.g. after a disk head
> is depopulated for disks that support head management operations).
> 
> Since partitions are ignored anyway, completely disable partition scanning
> for zoned gendisks by setting the flag GENHD_FL_NO_PART in __add_disk().
> The existing check in add_partition() is left as-is to ensure that we
> still get a warning if for whatever reason, despite GENHD_FL_NO_PART, we
> still endup trying to add partitions.
> 
> Flagging zoned disks with GENHD_FL_NO_PART also has the benefit to expose
> through sysfs the ext_range attribute with the value of 1 instead of the
> default DISK_MAX_PARTS, thus correctly advertizing the fact that zoned
> disks do not support partitions.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/genhd.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
Long overdue, if you ask me, and arguably not directly related to this 
patchset. But anyway.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
