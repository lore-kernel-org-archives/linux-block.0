Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9E82701D7
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 06:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745561301; cv=none; b=TDCsQ6hM0V1hwAk25xwq8Ww7eXp+txujNzPd+xAy9fWCSUXLR6mfptETHqWj0dnbTNAGlQEmYEs/CCcD928Vdisg5huzWFLeCFTaCau75HeoLRaukohdjsU4oc1jXv1RuD7g5icDhkBQTe1hYpO76sy/smiORGYgmBK4T8IeshE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745561301; c=relaxed/simple;
	bh=Si0zxM1ssUf8lB4MTmLFW6QKrOZt531QRQdtgx2s9JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2vgw9jlBQeHjF9kP88IkmYZE27jCSIu7BgQtFBqKcva3GNeHQwwwvbYFqFsOiF+r3MTvbPaELwMEQPD6ApIoCEvFPBujn1hZ4K2b6u0U/cPMmElCo88dYabBQ2TGBSMaF8pbsGx+qrp5cBM0FFhObkCMdJKz5COutunlIGeoz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fbzjAjdF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1d4E319k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fbzjAjdF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1d4E319k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fbzjAjdF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1d4E319k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fbzjAjdF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1d4E319k"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F2F822116B;
	Fri, 25 Apr 2025 06:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745561295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0asHzsYchsnU8ObT1tpU4c9+Idj2lnKi3ysOVfxJYps=;
	b=fbzjAjdF8ugBuBI9emUqY7+mLudlynYtJu4JapNY3mJUiItF+OXIlFEbVDZTGTYfOafooi
	tVuYScan7g2tcKbW3Haw0FTAkhPIHRiBrxsz7b6vGq9roerGMIIOooivlVS4hcrjUuS7mV
	HA6yn6+9uT6rBmy+WarSJL/vzKFMDfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745561295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0asHzsYchsnU8ObT1tpU4c9+Idj2lnKi3ysOVfxJYps=;
	b=1d4E319k/wyQBjIctQZrBXke2iBZwhZSjODzKnE6v1K8WuiktfcW27L2Om/61t6hl6xmi2
	iatkz2tBcgcUVhBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745561295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0asHzsYchsnU8ObT1tpU4c9+Idj2lnKi3ysOVfxJYps=;
	b=fbzjAjdF8ugBuBI9emUqY7+mLudlynYtJu4JapNY3mJUiItF+OXIlFEbVDZTGTYfOafooi
	tVuYScan7g2tcKbW3Haw0FTAkhPIHRiBrxsz7b6vGq9roerGMIIOooivlVS4hcrjUuS7mV
	HA6yn6+9uT6rBmy+WarSJL/vzKFMDfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745561295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0asHzsYchsnU8ObT1tpU4c9+Idj2lnKi3ysOVfxJYps=;
	b=1d4E319k/wyQBjIctQZrBXke2iBZwhZSjODzKnE6v1K8WuiktfcW27L2Om/61t6hl6xmi2
	iatkz2tBcgcUVhBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC23D13A80;
	Fri, 25 Apr 2025 06:08:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id szgLKM4mC2h4WgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 25 Apr 2025 06:08:14 +0000
Message-ID: <08d5760b-45b5-44fb-a49b-a8cadf4c178a@suse.de>
Date: Fri, 25 Apr 2025 08:08:14 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 04/20] block: use q->elevator with ->elevator_lock held
 in elv_iosched_show()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-5-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250424152148.1066220-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 4/24/25 17:21, Ming Lei wrote:
> Use q->elevator with ->elevator_lock held in elv_iosched_show(), since
> the local cached elevator reference may become stale after getting
> ->elevator_lock.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/elevator.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
