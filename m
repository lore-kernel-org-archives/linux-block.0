Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F58156C6F
	for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 06:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750227432; cv=none; b=NKT58eb4Mf+ebi/T1mUrI0i0pcfu4NWF2+g9Oalafc5dX1yw7jFZ3DOuevXJHbDdnbP2vuu5CAg46rjPN81fb6S2mOfMZxyIBfhA6tSmf3CXb4IHqi88bQCgPYq36CBcA+gdjlFLRqBSMsXxkwSxn8gZEYitCvTqq0MFceNQEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750227432; c=relaxed/simple;
	bh=bqlywIVZSJ2LOim2NGRmakW8XCyOpJIREPGxZIDtyJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLhSIaWY0IYWusnMFswa7O9Waylk3P5qCj3vhclJmMs6AZIyuhE9Na2kskl0Y2FMvUwLnhkn4QJyEs3aAXdrRRx6dhEyHz5BDUTQ4wrYQhCKXecedsGeZqyrx0fOPXt0gAc7+32rjWPx92hMta14MoX435ZMG+qMIflunHlg4R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K3c2rlmf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l6cTBmU7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K3c2rlmf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l6cTBmU7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K3c2rlmf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l6cTBmU7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K3c2rlmf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l6cTBmU7"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C8A35211A7;
	Wed, 18 Jun 2025 06:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750227428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xn77OAOZlVwUpfQYKw/7qjF2lfXIheMBmHwDQq4Iv6U=;
	b=K3c2rlmfBOY8yztCY3x801/x0D/eELxluHo/YmPzx7eG279slQoBpMBQLERC3gJ2205E6g
	C5Q1z5qb6pEbVnqPxcdD8TVQeXc8TO6D5apRTFAQREGxCPLnH5ADBQsnBrIrAxtMPTc7I3
	T7qCxvH6dhmfrwn3q2W325pcmL8U/gM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750227428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xn77OAOZlVwUpfQYKw/7qjF2lfXIheMBmHwDQq4Iv6U=;
	b=l6cTBmU7TgkB2naESuC90JSLH+yvyZBwwq4PuUCYMT4b+OM0SXJ1htLS3dYmxjMcNwKqa5
	vo2058eskgRMrjCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750227428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xn77OAOZlVwUpfQYKw/7qjF2lfXIheMBmHwDQq4Iv6U=;
	b=K3c2rlmfBOY8yztCY3x801/x0D/eELxluHo/YmPzx7eG279slQoBpMBQLERC3gJ2205E6g
	C5Q1z5qb6pEbVnqPxcdD8TVQeXc8TO6D5apRTFAQREGxCPLnH5ADBQsnBrIrAxtMPTc7I3
	T7qCxvH6dhmfrwn3q2W325pcmL8U/gM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750227428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xn77OAOZlVwUpfQYKw/7qjF2lfXIheMBmHwDQq4Iv6U=;
	b=l6cTBmU7TgkB2naESuC90JSLH+yvyZBwwq4PuUCYMT4b+OM0SXJ1htLS3dYmxjMcNwKqa5
	vo2058eskgRMrjCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87EDA13721;
	Wed, 18 Jun 2025 06:17:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GfBwH+RZUmh8YQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 18 Jun 2025 06:17:08 +0000
Message-ID: <0512cd79-8c61-4e62-bc22-988c478a1064@suse.de>
Date: Wed, 18 Jun 2025 08:17:08 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20250618060045.37593-1-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250618060045.37593-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 6/18/25 08:00, Damien Le Moal wrote:
> Back in 2015, commit d2be537c3ba3 ("block: bump BLK_DEF_MAX_SECTORS to
> 2560") increased the default maximum size of a block device I/O to 2560
> sectors (1280 KiB) to "accommodate a 10-data-disk stripe write with
> chunk size 128k". This choice is rather arbitrary and since then,
> improvements to the block layer have software RAID drivers correctly
> advertize their stripe width through chunk_sectors and abuses of
> BLK_DEF_MAX_SECTORS_CAP by drivers (to set the HW limit rather than the
> default user controlled maximum I/O size) have been fixed.
> 
> Since many block devices can benefit from a larger value of
> BLK_DEF_MAX_SECTORS_CAP, and in particular HDDs, increase this value to
> be 4MiB, or 8192 sectors.
> 
> And given that BLK_DEF_MAX_SECTORS_CAP is only used in the block layer
> and should not be used by drivers directly, move this macro definition
> to the block layer internal header file block/blk.h.
> 
> Suggested-by: Martin K . Petersen <martin.petersen@oracle.com>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
> Changes from v1:
>   - Move BLK_DEF_MAX_SECTORS_CAP definition to block/blk.h
>   - Define the macro value using SZ_4M to make it more readable
>   - Added review tag
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
