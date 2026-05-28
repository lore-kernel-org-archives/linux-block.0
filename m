Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ACA30C359
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 06:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779948329; cv=none; b=MsgPCWsSotzUfRD6M2OmbsXAvjkoEU32VX2I5++PVIGEWMRh6MwqICCXCVyA675zPSRTP8qwG913FwP+my0vfAV1qq3mGN4sEhb/2hdZOzM45gIMt8IQpqMXRusUs39HVBcc6rZF1BBlq8nref9XOf3ltsMtImlY47tPfya7wsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779948329; c=relaxed/simple;
	bh=XRwErSt+b32PSYKPP11QqaYL99X9G0opk99wxwC0/mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9eVDmhrj/chaNjjhlnh57zcP5eejqde3KAOo+1Y3XRqWqf6Sqwmspq6reTJ8QYmaCOiXO6FPhB7DGoLvGWSoLGOOyh2IFDL6O+Q+0HKF7HZb4POeImeApYt3E/aB46Hq3IpBWdCkLrHV0+sSDZ6hTkerVVDRhEtuZIM2FCn4vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LN8CKolZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yxy/CmDj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LN8CKolZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yxy/CmDj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LN8CKolZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yxy/CmDj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LN8CKolZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yxy/CmDj"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D04976ACFA;
	Thu, 28 May 2026 06:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779948325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhITeeO5SslKJeMFj7cqRnEI7SzOrQWeSpQaTW65MKQ=;
	b=LN8CKolZFgVDD66FCKfL1O37mcn3U1VhNhynBqDza/lNhItK7gf50nV7dgDOpder6eHibF
	B9jfnbr+h48XxRL4ewbHSbpTenI5J+/QTOF8GrQyRvbb/rB7phE16bsFRCu44zhhY/16Nf
	N0awJcSx6gyAcfg1thyyS+Q0U7RTZ/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779948325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhITeeO5SslKJeMFj7cqRnEI7SzOrQWeSpQaTW65MKQ=;
	b=yxy/CmDjQ0EXZrFTPGgyeZkkM7XPbO/lq3YPsMYgCf5/CanQgpCDuQKWRL49LNM0BEaPFh
	5Eh5SaQQibQefPBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779948325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhITeeO5SslKJeMFj7cqRnEI7SzOrQWeSpQaTW65MKQ=;
	b=LN8CKolZFgVDD66FCKfL1O37mcn3U1VhNhynBqDza/lNhItK7gf50nV7dgDOpder6eHibF
	B9jfnbr+h48XxRL4ewbHSbpTenI5J+/QTOF8GrQyRvbb/rB7phE16bsFRCu44zhhY/16Nf
	N0awJcSx6gyAcfg1thyyS+Q0U7RTZ/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779948325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhITeeO5SslKJeMFj7cqRnEI7SzOrQWeSpQaTW65MKQ=;
	b=yxy/CmDjQ0EXZrFTPGgyeZkkM7XPbO/lq3YPsMYgCf5/CanQgpCDuQKWRL49LNM0BEaPFh
	5Eh5SaQQibQefPBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B087B5AC2C;
	Thu, 28 May 2026 06:05:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id poR/KSXbF2pkeQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 28 May 2026 06:05:25 +0000
Message-ID: <7436e7a2-b626-4d7c-9acf-5431c5fbfdce@suse.de>
Date: Thu, 28 May 2026 08:05:25 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: mark biovec_init_pool static
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20260527150646.2349405-1-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260527150646.2349405-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]

On 5/27/26 17:06, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/bio.c         | 2 +-
>   include/linux/bio.h | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
