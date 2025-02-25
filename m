Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FA9189F36
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 07:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469108; cv=none; b=HL6GjxSSU632LFwkFk1E7Rppe4inFoUHo0fakTKr7fjQLMz6FJRwuUXNtwd3PFF07AggKuPd9bMA3yFH/U23eu1IIilsDuT15z4iSm+MAZ8A0SUb/GgnYZn14dOsK7T17oZ39tmtI4C5f688smej4Dw9jErAXLcc9L8Sm3Alh38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469108; c=relaxed/simple;
	bh=+myyec9fstgP7F3nui5vZFKB+z8SJ29afXUXsd/qTmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ux6n+3W1Y0dDrb+Rx7Pw29DuF9tnEm1UgYlwKddAr81p8TXCjfcnGXLAkdD+Edx7Pw1p5M3uWFu4B7Skw7uYh0RHxRd2xTUz6HGo44eGoLrnoF7TNlhPBesWLobx1/SutJ6UPcM80P0kE+0/gMheOPczHldv03KkoH/9jRU96D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vOkXxkWc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xWHPtHQM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vOkXxkWc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xWHPtHQM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vOkXxkWc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xWHPtHQM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vOkXxkWc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xWHPtHQM"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 083521F44F;
	Tue, 25 Feb 2025 07:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740469105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8yndWxMjcl+lcKx0y9LUj9XFTr9tgBHyvX7IKz4Brg=;
	b=vOkXxkWcWviY2gYDoJ9Sv02PSsNLk0Ib63a3dxFlovhCwXBJINBx8bo/anKrMbGdlRr/VQ
	hOFrLu+uErb8SSfkTiVlvABrbPshCdkc9YuLDRkNaHuhipl13plOL+4tJ5mWYGFCFwufsy
	tIvGIdfzs/EZx6R5+jbH7PHpKG381zs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740469105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8yndWxMjcl+lcKx0y9LUj9XFTr9tgBHyvX7IKz4Brg=;
	b=xWHPtHQMHC1RDFMHbeDE83QzybuJi0RgryEtciErC8294Zn75rMEVlsemmrlWKS7YQJa5F
	UnBsVgLnoby1xLBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vOkXxkWc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xWHPtHQM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740469105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8yndWxMjcl+lcKx0y9LUj9XFTr9tgBHyvX7IKz4Brg=;
	b=vOkXxkWcWviY2gYDoJ9Sv02PSsNLk0Ib63a3dxFlovhCwXBJINBx8bo/anKrMbGdlRr/VQ
	hOFrLu+uErb8SSfkTiVlvABrbPshCdkc9YuLDRkNaHuhipl13plOL+4tJ5mWYGFCFwufsy
	tIvGIdfzs/EZx6R5+jbH7PHpKG381zs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740469105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8yndWxMjcl+lcKx0y9LUj9XFTr9tgBHyvX7IKz4Brg=;
	b=xWHPtHQMHC1RDFMHbeDE83QzybuJi0RgryEtciErC8294Zn75rMEVlsemmrlWKS7YQJa5F
	UnBsVgLnoby1xLBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B68A413332;
	Tue, 25 Feb 2025 07:38:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QpR4KnBzvWecbgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 25 Feb 2025 07:38:24 +0000
Message-ID: <ab4e899f-83d8-4f05-a592-122a445bff69@suse.de>
Date: Tue, 25 Feb 2025 08:38:24 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/7] block: acquire q->limits_lock while reading sysfs
 attributes
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
 gjoyce@ibm.com
References: <20250224133102.1240146-1-nilay@linux.ibm.com>
 <20250224133102.1240146-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250224133102.1240146-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 083521F44F
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 2/24/25 14:30, Nilay Shroff wrote:
> There're few sysfs attributes(RW) whose store method is protected
> with q->limits_lock, however the corresponding show method of these
> attributes run holding q->sysfs_lock and that doesn't make sense
> as ideally the show method of these attributes should also run
> holding q->limits_lock instead of q->sysfs_lock. Hence update the
> show method of these sysfs attributes so that reading of these
> attributes acquire q->limits_lock instead of q->sysfs_lock.
> 
> Similarly, there're few sysfs attributes(RO) whose show method is
> currently protected with q->sysfs_lock however updates to these
> attributes could occur using atomic limit update APIs such as queue_
> limits_start_update() and queue_limits_commit_update() which run
> holding q->limits_lock. So that means that reading these attributes
> holding q->sysfs_lock doesn't make sense. Hence update the show method
> of these sysfs attributes(RO) such that they run with holding q->
> limits_lock instead of q->sysfs_lock.
> 
> We have defined a new macro QUEUE_LIM_RO_ENTRY() which uses new ->show_
> limit() method and it runs holding q->limits_lock. All existing sysfs
> attributes(RO) which needs protection using q->limits_lock while
> reading have been now updated to use this new macro for initialization.
> 
> Also, the existing QUEUE_LIM_RW_ENTRY() is updated to use new ->show_
> limit() method for reading attributes instead of existing ->show()
> method. As ->show_limit() runs holding q->limits_lock, the existing
> sysfs attributes(RW) requiring protection are now inherently protected
> using q->limits_lock instead of q->sysfs_lock.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-sysfs.c | 102 +++++++++++++++++++++++++++++-----------------
>   1 file changed, 65 insertions(+), 37 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
