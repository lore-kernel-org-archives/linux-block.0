Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504023D669A
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946011; cv=none; b=nK8iELklkJWtS8yPKNFMkThZI6EdCeRcJ9CZYekgyBAau5gHQlRmlOWSWOQgTtM/M640R7IvqMmdsKU3hAb1gbikuVWEvGmC2o9O5+Oe4v+XOrjPBsqDcY6oi5sK3N8oFMCM7HdbXQhzvU3FtTKgCyZG7bu4un7M+H9mWPmlIzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946011; c=relaxed/simple;
	bh=Kd2afCl3XVsaUjY6UneFN4n3bSFiU1kmnsDBkhmx91c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPxGSNOgFcXGFLAoqw8Om9ITTCMLN3xwMrWJ/XV6BboC4mmOJgaOD0TdC/qiX4tyoXoC0DxTc0kLnqaVrVFeYka/k0riYU1ae45UoTgNzPeQ4TQ1POcMZ0KTqof49tiYVPqOdhPfd1OJ5IZRw/QGWg0BuYe+vjSA/wu9EMlKfik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NwMKKdaP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DJaYX3sB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GHlNxsid; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VjivwMWl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NwMKKdaP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DJaYX3sB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GHlNxsid";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VjivwMWl"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B7E6621A90;
	Wed,  9 Sep 2026 09:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788946000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JHoAwmgPRHb0M1Ezqa9t9jepmj8lZpwBJ+ghiUsnmNk=;
	b=NwMKKdaPPagD1OrJ6GprcrrtuMhSMjraTElGM3t8vYnLl+S3DhQQ/Qqrcc7sjOYBwQ8WoL
	7duHVS9pwTAJKhUKNRDpV3etFqBAgnR6l+Bdx0K+bC19CHQP+3IQCp4wmsykBz6PKK7q0C
	MRnToV5xcVo5x/uXz2u5KTwnMM1z8Ps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788946000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JHoAwmgPRHb0M1Ezqa9t9jepmj8lZpwBJ+ghiUsnmNk=;
	b=DJaYX3sBpVuXgyDij0oyhKaBZRojcT8kd+BmOVcPkvzWVGjQVrFchRO7cNLNlvmIJ6VyTZ
	z3NlmxROREIaysBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GHlNxsid;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VjivwMWl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788945996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JHoAwmgPRHb0M1Ezqa9t9jepmj8lZpwBJ+ghiUsnmNk=;
	b=GHlNxsidvQDWA4/OEpNv5j8AaxUH6VehMGoM2EPaqfawoE5qQ3VSf2hSYTMyroG268Ah76
	OpPH71ZN/om47FpOvsb72pF435qllnGdr/MVb0yxDTov9v2pncL8QDrfqanqHjLm5ckxNb
	tRq6s/AIF4TOj25I814wdeOI+7bbL48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788945996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JHoAwmgPRHb0M1Ezqa9t9jepmj8lZpwBJ+ghiUsnmNk=;
	b=VjivwMWlmEA0yyaShQ3YgM/W2gSO3gnoAHy+khhjLmnewm1xWv0REfh/0IEo9QG+Rs3HC0
	R2ZJjxEIHQUJvRAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C50C1347F;
	Wed,  9 Sep 2026 09:26:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ArOGGUwmoWo4bAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 09 Sep 2026 09:26:36 +0000
Message-ID: <587c9f63-c077-4b82-a1ff-f5433f802222@suse.de>
Date: Wed, 9 Sep 2026 11:26:35 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/16] block: retry zone revalidation on capacity
 change
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260908085745.1082697-1-dlemoal@kernel.org>
 <20260908085745.1082697-12-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260908085745.1082697-12-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: B7E6621A90
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

On 9/8/26 10:57 AM, Damien Le Moal wrote:
> When disk_revalidate_zone_resources() detects a capacity change, -ENODEV
> is returned, failing the disk revalidation. However, since a capacity
> change may happen due to a storage element removal being executed
> concurrently to blk_revalidate_disk_zones(), we can simply retry the
> revalidation to capture the new zone state with the new capacity without
> failing the revalidation.
> 
> Retrying the revalidation is driven by disk_revalidate_zone_resources()
> returning -EAGAIN when a new valid capacity is detected. And to avoid
> getting stuck in an infinite loop revalidating zones, retries are limited
> to 2.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
> 
... and, or course, messing up anything accessing the disk.
But that's probably intended at this point.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
