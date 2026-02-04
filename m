Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E567E28980E
	for <linux-block@vger.kernel.org>; Wed,  4 Feb 2026 01:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170315; cv=none; b=czXtoZWtAN64a4pwV33U3rS5QLrTh31zbz2HLxjELJtR8EJyQWeOJafO/qXRu5ceI/Efg1xDH1VZDAUsIq5wUKB6JmbnolE+YkIafYuGl8beD2yAVitUggmE/o4H2gMotix/6WGuUmI7NTyoqbiLLoRhSD+F9ALiFzFBYT+K1rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170315; c=relaxed/simple;
	bh=5VrRkS+zgKK9bZFLext8nWIteAYPEBCgW8mhE9whUjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjklWD2SDnfQ/4c2wj7wOrRijPcebpugGqlsGDCi8aKCZlBF/DkOs616Z1ylFqQcUJDUaAupRIQWRqCXznaUxkRj7Q/fOMP8TGwAtr3zuQ6mrbjDRmQapv+8knJ5iJmH87dQ0ykDCd/qTtqCZuR3+VPoDHL7iau4uUbDUgiS4T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yt45ZQnc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UgMz51K3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yt45ZQnc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UgMz51K3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yt45ZQnc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UgMz51K3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yt45ZQnc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UgMz51K3"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 019BB5BCC7;
	Wed,  4 Feb 2026 01:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770170312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjaUR9nsig9iP+E9O+05swY8bJuPkeSHlsRz0TGkVtk=;
	b=yt45ZQnc0W/vPeeFPACRvK5+4mRt/G4wtq8+OnhxvT31VT8ZfV2CGBBOeXjgfQkezXQQBx
	Ia1rgg5ySFXoVy+r8En8UpEECKXyaKXt0qssrmGqtq8yWwmy41G2D+UcYGwJsnAvAroKYG
	RpOka6zETWVQWUQcJNecbyId8xf+TKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770170312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjaUR9nsig9iP+E9O+05swY8bJuPkeSHlsRz0TGkVtk=;
	b=UgMz51K3zLp27faqFUdTpY4DXUosgdFl0oYc7GqluxvUDZJIy7luZ8S8rHy9t2aZhHOtpn
	2tsO60DO1n7BWSBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yt45ZQnc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UgMz51K3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770170312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjaUR9nsig9iP+E9O+05swY8bJuPkeSHlsRz0TGkVtk=;
	b=yt45ZQnc0W/vPeeFPACRvK5+4mRt/G4wtq8+OnhxvT31VT8ZfV2CGBBOeXjgfQkezXQQBx
	Ia1rgg5ySFXoVy+r8En8UpEECKXyaKXt0qssrmGqtq8yWwmy41G2D+UcYGwJsnAvAroKYG
	RpOka6zETWVQWUQcJNecbyId8xf+TKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770170312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjaUR9nsig9iP+E9O+05swY8bJuPkeSHlsRz0TGkVtk=;
	b=UgMz51K3zLp27faqFUdTpY4DXUosgdFl0oYc7GqluxvUDZJIy7luZ8S8rHy9t2aZhHOtpn
	2tsO60DO1n7BWSBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BAE63EA63;
	Wed,  4 Feb 2026 01:58:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yfhGBMWngmlregAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Feb 2026 01:58:29 +0000
Message-ID: <2e66760b-9a52-4577-93e2-f0331f03e3d8@suse.de>
Date: Wed, 4 Feb 2026 02:58:26 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/8] block, bfq: convert to use
 request_queue->async_depth
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
 tj@kernel.org, nilay@linux.ibm.com, ming.lei@redhat.com
Cc: bvanassche@acm.org
References: <20260203081952.732210-1-yukuai@fnnas.com>
 <20260203081952.732210-8-yukuai@fnnas.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260203081952.732210-8-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 019BB5BCC7
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On 2/3/26 09:19, Yu Kuai wrote:
> The default limits is unchanged, and user can configure async_depth now.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/bfq-iosched.c | 43 +++++++++++++++++--------------------------
>   1 file changed, 17 insertions(+), 26 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
