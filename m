Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4CB3EBF38
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849820; cv=none; b=YFq/cackLxsCPRc8CePf7FuoA9WhGrTKMtGaZiskQTSr95XF3dUEjG2yCh87W7yr4QH/GMdAR0ADnVydPF41ezqcwK3KQZVJvZQzczu3/NR4Mg+DKGJsZeHUM5EpwbK+ZrnL1HY19JwfIBBMOS0Mm1oXXSsSoHfNL6AQAqYhBOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849820; c=relaxed/simple;
	bh=1SD3wCnCRXE/k3XfOLHLWgqASkOhX/Q2ho7jLAz/DFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WvPRkf40H+KymjWh8GASX9zVB11X1f6naMFtPdnCeHqs1VJuoPabxeaIypSFKSmBimJvK2LW1tlEiqezyLAVeRv2VKLm0yAWiSaeu+AVfFNpbs4LtRuRkOKQLY6OtmiL2m/T1g34gaqbpLRcVoyJIf7wDh9I/c/WFSBQbQMbayU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZVrO6jtG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XJDJGGQi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZVrO6jtG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XJDJGGQi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZVrO6jtG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XJDJGGQi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZVrO6jtG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XJDJGGQi"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 91AE93EC88;
	Mon, 23 Feb 2026 12:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771849817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVvSHqMQHGxKFsupPwU7PDnbf5868y0o34nCnMEdK2M=;
	b=ZVrO6jtGVjEUSkWpn4JMi6vRR3KA3ihRzeB0FyIa4LZ4tvSgZYJRb3Jps3ekRNmdtbUieO
	lkBvBHPov0GyVl+5ncS/JbWaP6lLqUQrUBD08MBZ+zAh7qt/XEPKi+IebpLtofyDmZFwOI
	Key+4CnNQ0xvuNGAV/KM3ebBH5cZW9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771849817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVvSHqMQHGxKFsupPwU7PDnbf5868y0o34nCnMEdK2M=;
	b=XJDJGGQiZWOVBL4LfhuKLwzpiplc2bOsCgY+di4DpUzNg4lSpTBcrRqXi1mULwKtTS1JeJ
	vUqxSeBjixHKwwDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771849817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVvSHqMQHGxKFsupPwU7PDnbf5868y0o34nCnMEdK2M=;
	b=ZVrO6jtGVjEUSkWpn4JMi6vRR3KA3ihRzeB0FyIa4LZ4tvSgZYJRb3Jps3ekRNmdtbUieO
	lkBvBHPov0GyVl+5ncS/JbWaP6lLqUQrUBD08MBZ+zAh7qt/XEPKi+IebpLtofyDmZFwOI
	Key+4CnNQ0xvuNGAV/KM3ebBH5cZW9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771849817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVvSHqMQHGxKFsupPwU7PDnbf5868y0o34nCnMEdK2M=;
	b=XJDJGGQiZWOVBL4LfhuKLwzpiplc2bOsCgY+di4DpUzNg4lSpTBcrRqXi1mULwKtTS1JeJ
	vUqxSeBjixHKwwDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77E1E3EA68;
	Mon, 23 Feb 2026 12:30:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id abW8HFlInGk8aQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Feb 2026 12:30:17 +0000
Message-ID: <be221e64-6186-4cd6-aa3e-a26d08766d53@suse.de>
Date: Mon, 23 Feb 2026 13:30:17 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ublk: document partition flags, kublk and update
 external links
To: Alexander Atanasov <alex@zazolabs.com>, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20260223121515.3296983-1-alex@zazolabs.com>
 <20260223121515.3296983-4-alex@zazolabs.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260223121515.3296983-4-alex@zazolabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,zazolabs.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zazolabs.com:email,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On 2/23/26 13:15, Alexander Atanasov wrote:
> Add section about partition handling on ublk devices.
> Document UBLK_F_PARTITIONS and UBLK_F_AUTO_PART_SCAN.
> 
> Add section for kublk to be used as reference.
> 
> Update extenal github links - repos have moved to ublk-org
> and README is renamed to README.rst
> 
> Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
> ---
>   Documentation/block/ublk.rst | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
