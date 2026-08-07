Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA168472520
	for <linux-block@vger.kernel.org>; Fri,  7 Aug 2026 11:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102966; cv=none; b=IJ7i0VY5+buKUw+nf7GzlF4Fdqi8s9tTHagSw0yoUY/+av14AZQhOOS+0wURrbepmxLB3wi/JIlLm2b8ABe36NtuhVMKLyM0iC+fQN86wQ9IjdXGAjpNcIFmiauEas5/Yy+MxlpGFn1xiedp6ksiGWfyPTIYl1wJtM4jWG8v/D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102966; c=relaxed/simple;
	bh=POTvBRT8lOjQ75J5beoqHgV/2/HrVsLpcjOBr2jUDJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o74OquBPZLmJzmj4gEyjqFY0co5wLDBzpLz9+dRVtZt3nha3mPZMk8YZAOzeP3egp2oKxAJfV3QPSg6TVJ9qsI3693D/obZ2DywAv2FQ8yClZLooxqygzOiS6o8zMBNAQcjktcUuFZuKUu/oESKpbfZ+RB1F9/NJ+cZiHLcWXlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ii6L9fqO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hMklJ3DI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gzhGBYZZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4bRfK0Wz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ii6L9fqO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hMklJ3DI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gzhGBYZZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4bRfK0Wz"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 39BC83E2C;
	Fri,  7 Aug 2026 11:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786102953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvgmJYyv9281KbPZX9SPP7pYIQ4Yj1ujk8lFfzFtM3g=;
	b=Ii6L9fqO2JtS444BEYFopO8gbDWfzTyRVIXg4CmOSrEO3g75hkjLpEWwikz/ZDamv7hJ9M
	II5jqRN/prQ/68/a1V978FAcXVBwDMOFITf0VZHsOFhU3Ky3VkaQY6e33sNQPq5vu6e2RQ
	2nk7f7uShjdwbeLxiRwWYXlvy0Jrjxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786102953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvgmJYyv9281KbPZX9SPP7pYIQ4Yj1ujk8lFfzFtM3g=;
	b=hMklJ3DIF/lKRqdaaZIR8ysZi9vVD2MZQlGIl7B2UZYUhf7zfGDXP40mUAooRFkAztiTab
	zarCcb6yaMVLhMDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gzhGBYZZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4bRfK0Wz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786102949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvgmJYyv9281KbPZX9SPP7pYIQ4Yj1ujk8lFfzFtM3g=;
	b=gzhGBYZZvrKpSHE0psae5K9Iu2KqKLJYiFpndm1899l3BLwcnnXPymIeOmQ/V7RITG46hE
	7JQ6MWD6TnMZfvucSaXD8AfokMZcR5NOZMcpbSxApZgDoqr0nsG8YzHL/RmN1ZR5Zspc9A
	EUjNIUTVC+OCew9ngC92vBOKYk2n+Ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786102949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvgmJYyv9281KbPZX9SPP7pYIQ4Yj1ujk8lFfzFtM3g=;
	b=4bRfK0Wz3qgInhUdNuHmhTUaio0PjY6IDQc+zbwJjWw3tnuGBnyvUy3uhYyVYV1jj2nVwn
	xAHQ3b8sE+M493Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22450779B6;
	Fri,  7 Aug 2026 11:42:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zALGB6XEdWqyDQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 07 Aug 2026 11:42:29 +0000
Message-ID: <51cc65ed-18ee-482d-90bc-6291c4edbb6a@suse.de>
Date: Fri, 7 Aug 2026 13:42:28 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/13] block: fail zone management operations to
 read-only and offline zones
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260806160445.848337-1-dlemoal@kernel.org>
 <20260806160445.848337-11-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260806160445.848337-11-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 39BC83E2C
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 8/6/26 6:04 PM, Damien Le Moal wrote:
> Any zone management operation targeting a zone that is in the read-only
> or offline condition will fail. So there is no point in issuing such
> BIO. Modify the check in submit_bio_noacct() to use the new helper
> function bdev_check_zone_mgmt() to check that a zone is sequential (as was
> checked before) and also that the zone is not offline nor read-only.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-core.c  |  7 +++++--
>   block/blk-zoned.c | 24 ++++++++++++++++++++++++
>   block/blk.h       |  6 ++++++
>   3 files changed, 35 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
