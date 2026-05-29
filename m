Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219C2372EF3
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 06:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036080; cv=none; b=GnjiDNEJyU0wqFEiLWzqm/ChGv14hpAmSurvIWoRcL4RchDQ9ohFJCbc5DXphM/TgpzelMIkKTMb4qtj89BNwsUJpCpxn2cCdVMugvE3FKyIUnwjqIK26pMHQINkPaLAnUI61oQ3Isjc5Jbj1Bv9UiWgzM1cc3NWQFuysH7Xcpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036080; c=relaxed/simple;
	bh=aWm5pPjh9QbuwEuyTmAGg6qLEyO3df9OE1WBW5+1nKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mw866Bwa1fZU8qNusywU4xF3YjM7pBlroEfJbx9lPrm6Gq3wLtbA/Zzyhhr0BKZD0oz58fO0ex2F8415iPe7nO8L8zGEsRDgSNYEYA8cz6jvgn23lqjyHk2nLuUjtOrDf9aQbwq/+QtS1g/YpkkCBU4Mhirs1XX6Mx+78S+0HpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cWbAqy3q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3iltee5V; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cWbAqy3q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3iltee5V; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cWbAqy3q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3iltee5V";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cWbAqy3q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3iltee5V"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4CC936A92E;
	Fri, 29 May 2026 06:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780036077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2Dwy9X9J8tlZx9OVg9I8KGI9SUWg+yYkV+//jqQEOU=;
	b=cWbAqy3qRQ4PBLde0bT7dE1XyopR+unFMD+1FQ5jXV3qpaBOCKWuxJkLOMxkqlKIYTkxMG
	rypDXsE49Ko6F2rlXQ7zbBfVICJWuDVrE7m9PVhIrEbpanolti7v2Hjgwq7Ekf0ecfGNaR
	fAb/yNKiDIu6S1AmMhvGAJCfXN3qefI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780036077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2Dwy9X9J8tlZx9OVg9I8KGI9SUWg+yYkV+//jqQEOU=;
	b=3iltee5VNb7lvH9ae+bcZ2txcfCB8B5qh8VPLoorbNRFM8ycmYbUEgjvEAgetqmkFtmh4y
	a51fkAN6/3dm2dAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cWbAqy3q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3iltee5V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780036077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2Dwy9X9J8tlZx9OVg9I8KGI9SUWg+yYkV+//jqQEOU=;
	b=cWbAqy3qRQ4PBLde0bT7dE1XyopR+unFMD+1FQ5jXV3qpaBOCKWuxJkLOMxkqlKIYTkxMG
	rypDXsE49Ko6F2rlXQ7zbBfVICJWuDVrE7m9PVhIrEbpanolti7v2Hjgwq7Ekf0ecfGNaR
	fAb/yNKiDIu6S1AmMhvGAJCfXN3qefI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780036077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2Dwy9X9J8tlZx9OVg9I8KGI9SUWg+yYkV+//jqQEOU=;
	b=3iltee5VNb7lvH9ae+bcZ2txcfCB8B5qh8VPLoorbNRFM8ycmYbUEgjvEAgetqmkFtmh4y
	a51fkAN6/3dm2dAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D4585B1D0;
	Fri, 29 May 2026 06:27:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TSn2Ae0xGWrUHgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 May 2026 06:27:57 +0000
Message-ID: <3a4289d8-8e10-470d-bb2c-8266c6a1314d@suse.de>
Date: Fri, 29 May 2026 08:27:56 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] block/cgroup: Improve lock context annotations
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>
References: <cover.1779997063.git.bvanassche@acm.org>
 <a30486e2e9695614e4407d5ad8c75d637f5b31db.1779997063.git.bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <a30486e2e9695614e4407d5ad8c75d637f5b31db.1779997063.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4CC936A92E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,suse.de:mid,acm.org:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51

On 5/28/26 21:45, Bart Van Assche wrote:
> Add lock context annotations where these are missing. Move the
> blkg_conf_prep() annotation into block/blk-cgroup.h to make it visible
> to all blkg_conf_prep() callers.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-cgroup.c |  1 -
>   block/blk-cgroup.h | 15 ++++++++++-----
>   2 files changed, 10 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
