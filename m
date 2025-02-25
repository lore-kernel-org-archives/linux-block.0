Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28625A34C
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469850; cv=none; b=jGe2ng5gFNakwtE6eYCdV/DAuEEhu61ymlDnkyR17/u6mADAkVGQc0VZhc9rCtq0F2+dPuKjdCnqskMyMP2hhCRxd4ZAdF9WBjUyM894/iy/Otjg25v5BjnVxdoKgn1iYwBJ9QXRG41+cnWgWIUKSL0KtlhGWMUexOUzz7rtuKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469850; c=relaxed/simple;
	bh=49msvEepN+ya5IMh56TbffDv+gGHp6suiu9ZO72InO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDsDE0mzKg0JKgPPvl5USUKaVT6ng2jB9c8uvDJsGaK9s5MlQf1nzkxZRZeghGVN6+XIOx/DAYrxaV1psKnodLY4zO/VXgNc39kTvyWYsyRMDHuEr02QwAPOoJxZFQWtpB/FN/OqpnrySEjzoqNM/HGBu9tOK2MPtkt6M4Mts9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xIrs8tEq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1cLsmiYm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xIrs8tEq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1cLsmiYm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xIrs8tEq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1cLsmiYm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xIrs8tEq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1cLsmiYm"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27D0621189;
	Tue, 25 Feb 2025 07:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740469847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVdhU+sovhW9lMxkmZjVxMSF0hgXBxWkrhWAPGMXt+s=;
	b=xIrs8tEqHO3Yfa4jJ+LaT8Qd/JUpzpPT8uYvrx8Qr/sNBTTS6I3MRQA0xaB8ggElJZj1yK
	To2krFDVYZgu7Yi5L7NOQIETXyt1BDmBlXMescoBIZ2gCFsBA4uBzxZ8fzV8bFwkIq+WKx
	ABBzXpARLwlQ0I2u8w8eqcZyzpU7mnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740469847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVdhU+sovhW9lMxkmZjVxMSF0hgXBxWkrhWAPGMXt+s=;
	b=1cLsmiYm40GdEud+syv0X+yVDBxDnly8fj/F3WnuZs849jBifmi4cslrFbSeon6jDhMgT9
	6JF9sKJt8aQC/GAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740469847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVdhU+sovhW9lMxkmZjVxMSF0hgXBxWkrhWAPGMXt+s=;
	b=xIrs8tEqHO3Yfa4jJ+LaT8Qd/JUpzpPT8uYvrx8Qr/sNBTTS6I3MRQA0xaB8ggElJZj1yK
	To2krFDVYZgu7Yi5L7NOQIETXyt1BDmBlXMescoBIZ2gCFsBA4uBzxZ8fzV8bFwkIq+WKx
	ABBzXpARLwlQ0I2u8w8eqcZyzpU7mnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740469847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVdhU+sovhW9lMxkmZjVxMSF0hgXBxWkrhWAPGMXt+s=;
	b=1cLsmiYm40GdEud+syv0X+yVDBxDnly8fj/F3WnuZs849jBifmi4cslrFbSeon6jDhMgT9
	6JF9sKJt8aQC/GAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D340213332;
	Tue, 25 Feb 2025 07:50:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AIPJMVZ2vWdKcgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 25 Feb 2025 07:50:46 +0000
Message-ID: <cdc16a43-4f9d-459f-bb9e-4794b8fa5738@suse.de>
Date: Tue, 25 Feb 2025 08:50:46 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 5/7] block: protect nr_requests update using
 q->elevator_lock
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
 gjoyce@ibm.com
References: <20250224133102.1240146-1-nilay@linux.ibm.com>
 <20250224133102.1240146-6-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250224133102.1240146-6-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 2/24/25 14:30, Nilay Shroff wrote:
> The sysfs attribute nr_requests could be simultaneously updated from
> elevator switch/update or nr_hw_queue update code path. The update to
> nr_requests for each of those code paths runs holding q->elevator_lock.
> So we should protect access to sysfs attribute nr_requests using q->
> elevator_lock instead of q->sysfs_lock.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-sysfs.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
