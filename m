Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E62364032
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 05:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776404136; cv=none; b=H7lZi2iLOXqWTzLNXISnbIpZ3/hAVhVBXLYnwe/14nyp+SF3Bc++kcgRiybz+JcAiTwkNZQhANUaXQmJTuYZxRjGqao93okSirgBVtkygowQASPaJ+WsvUc2VyLYP9ohejU1aHeNeZBqq5DmVZnsH5FUUcwyf1hc4O/8zz7NJj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776404136; c=relaxed/simple;
	bh=1ejMD1BuTTOzdHDyBrBvgduPTwPpHVCtsPFx3vBsiYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mn2vYPZnqOLc47ul9QFb621hiWurpjY62sZXNfZXNOCfIXrUlzumXhto/crmwxU9w/DNFuMVpH9RcLrDgidQbK68lLHKUVZz6rdLdf0bbfg1u5QH1PhQTIn4jhYEs4/hlfhwTLyNngY9CJHiuMS43tHWuC3XClKzmPJYoFmlyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ooe43UWt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e89yVKib; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ooe43UWt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e89yVKib; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ooe43UWt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e89yVKib";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ooe43UWt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e89yVKib"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 373265BE47;
	Fri, 17 Apr 2026 05:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776404129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSYjqscpeRLZzPyVofMpNCLGqznDKi5Wz/+sfgZ00gs=;
	b=ooe43UWtzFWvAKrwFRUSjvGBHxTLpjkMXQaovuGR6AtL1y/EZbz/f3OH5NQGTubxQrw4d6
	jjWBO8i09or9mxJi7rl7gcAj2u4KaZ5aiMlB2pGMapbU3IWp52O2Ne3C1SPsqxXp9BpVUm
	UAAj5JNqaya3+98TrJTIXm/vAup3bLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776404129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSYjqscpeRLZzPyVofMpNCLGqznDKi5Wz/+sfgZ00gs=;
	b=e89yVKibZpqJhS3s4J9d0YODfiqDHYwy8kpEsvkj2SofVIJbzYZLTo+7o3o0WGD1va60cu
	F/jWLekHfp+CKqDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ooe43UWt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=e89yVKib
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776404129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSYjqscpeRLZzPyVofMpNCLGqznDKi5Wz/+sfgZ00gs=;
	b=ooe43UWtzFWvAKrwFRUSjvGBHxTLpjkMXQaovuGR6AtL1y/EZbz/f3OH5NQGTubxQrw4d6
	jjWBO8i09or9mxJi7rl7gcAj2u4KaZ5aiMlB2pGMapbU3IWp52O2Ne3C1SPsqxXp9BpVUm
	UAAj5JNqaya3+98TrJTIXm/vAup3bLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776404129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSYjqscpeRLZzPyVofMpNCLGqznDKi5Wz/+sfgZ00gs=;
	b=e89yVKibZpqJhS3s4J9d0YODfiqDHYwy8kpEsvkj2SofVIJbzYZLTo+7o3o0WGD1va60cu
	F/jWLekHfp+CKqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7F9C593AE;
	Fri, 17 Apr 2026 05:35:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2jtnK6DG4WmZFAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 17 Apr 2026 05:35:28 +0000
Message-ID: <606445b1-bf2d-4f5a-a286-da190476b501@suse.de>
Date: Fri, 17 Apr 2026 07:35:28 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmet-tcp: Don't clear tls_key when freeing sq
To: alistair23@gmail.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 kbusch@kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, yi.zhang@redhat.com, mlombard@arkamax.eu,
 linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, Alistair Francis <alistair.francis@wdc.com>
References: <20260417004809.2894745-1-alistair.francis@wdc.com>
 <20260417004809.2894745-2-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260417004809.2894745-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,lst.de,grimberg.me,nvidia.com,kernel.org,lists.infradead.org,vger.kernel.org,redhat.com,arkamax.eu];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,wdc.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 373265BE47

On 4/17/26 02:48, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Curently after the host sends a REPLACETLSPSK we free the TLS keys as
> part of calling nvmet_auth_sq_free() on success. This means when the
> host sends a follow up REPLACETLSPSK we return CONCAT_MISMATCH as the
> check for !nvmet_queue_tls_keyid(req->sq) fails.
> 
> A previous attempt to fix this involed not calling nvmet_auth_sq_free()
> on successful connections, but that results in memory leaks. Instead we
> should not clear `tls_key` in nvmet_auth_sq_free(), as that was
> incorrectly wiping the tls keys which are used for the session.
> 
> This patch ensures we correctly free the ephemeral session key on
> connection, yet we don't free the TLS key unless closing the connection.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   drivers/nvme/target/auth.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
