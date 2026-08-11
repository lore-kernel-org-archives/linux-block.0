Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990E039E177
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448004; cv=none; b=D1LG8djzP3YQz0QIo3+CHPXenGTuvLSmiFgBguvQHVLDt0OeH05CPniWs0B5G4hUGxqY+SgU6+3tplLKGDcdLZB08BRDMTObs468na9wXQypmv/U4YVxkvE6aF5vms8UxNDiO8/nhwXDdNsH2K+cNZIfOxsPIWvAMhsdBn22+xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448004; c=relaxed/simple;
	bh=aJacRGTxoeryO8fptc5jl0sVnFRwtUph3CmbQuHocw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fIIjrvoKJZnZ5AekU+yWOcOwjqlAgdluOsfjapuWpXfO4pHZrmx0KvtzFQMg2RA3rIC8Tk3E3aOXkr2j+7m4rafTTt2hKpJh7myj7sXZBW50FCld8q6t0eG754qxpb50ho32ZJS9VL7r3jTKHmgDNpuk7IDgC6cwo/Y/5jIIx/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=boy1wSB1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rSynokJM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lOPif5Wu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KGrd70Iv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="boy1wSB1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rSynokJM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lOPif5Wu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KGrd70Iv"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8303F81B83;
	Tue, 11 Aug 2026 11:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786447996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NRlQfnShdp4kVXYWhe21f7FXxSQ7JZkzDEaSlmZbV4M=;
	b=boy1wSB1IPofsvtqb31oEmR1DiLBBvS0i9vIqVEXjo2E+trlrVN0iVSvevT38wGMjQ0/VF
	j39wtK2QHTAlvTppE6eVhPC17ZrBTlIgofQBhALLJdBqwnK+rIqquVRrN3/BOCXzdDbaLA
	7hq+Ib8mTOOdxkWWqsD2jcAHp506HBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786447996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NRlQfnShdp4kVXYWhe21f7FXxSQ7JZkzDEaSlmZbV4M=;
	b=rSynokJM3tBYR6RvXCfjEwniNvHaCbDyzq+8mCh/h7GF6VmiIX3qsHKRQWHaYbkCZIW8Fy
	qZmheZ+/FLyNM9Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lOPif5Wu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KGrd70Iv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786447992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NRlQfnShdp4kVXYWhe21f7FXxSQ7JZkzDEaSlmZbV4M=;
	b=lOPif5WuglEYcmZ28pDmjVV/Nlw5RSS/GupYlR+ZOfCIuD0m51g9EdrkctwqcwbtOf+4yy
	wShpf2y+042Wjuf2/1xMjd/+qpCJYJg1aFa913rs32b3qIL5DPM+6lTjezJ8FM4H41yX38
	9RSm9HkVYLo+2Du6pAoHe9tVGrgzEF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786447992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NRlQfnShdp4kVXYWhe21f7FXxSQ7JZkzDEaSlmZbV4M=;
	b=KGrd70IvMhaAEn7BqIqSgzKDo8np5eHaCP+UYGkT0KFaA0Ow8ZR+xTkHfjxYKYJ7E97bV+
	0YsXCyrG0T5qbjDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73E2D779B2;
	Tue, 11 Aug 2026 11:33:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T0rjG3gIe2oGdQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 11 Aug 2026 11:33:12 +0000
Message-ID: <3d52760c-298d-4929-b310-5c64870614a2@suse.de>
Date: Tue, 11 Aug 2026 13:33:12 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/13] block: drop all zone write plugs on capacity
 changes
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
 <20260811105852.1245357-8-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260811105852.1245357-8-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8303F81B83
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,acm.org:email,suse.de:mid,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 8/11/26 12:58 PM, Damien Le Moal wrote:
> If during revalidation, we detect a capacity change for a zoned block
> device, e.g. due to a storage element removal on an HDD, we can assume
> that the device was reformatted, which implies that all sequential zones
> are empty. For such case, we can remove and free all zone write plugs in
> the gendisk hash table by marking them as dead, thus avoiding also to
> leave zone write plugs for zones that are beyond the new device capacity
> in the disk hash table.
> 
> Introduce the function disk_revalidate_capacity() to do this and call this
> new function at the beginning of blk_revalidate_disk_zones(), so that the
> zone revalidation process can re-create, if needed, any zone write plug
> for sequential zones that are not empty.
> 
> The checks on the capacity and zone size that were in
> blk_revalidate_disk_zones() are moved to disk_revalidate_capacity() and
> if true, also trigger dropping all zone write plugs.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-zoned.c | 81 ++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 63 insertions(+), 18 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
