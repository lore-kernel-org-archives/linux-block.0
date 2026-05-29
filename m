Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D783AA18B
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 06:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036520; cv=none; b=ABAg/XXq5wCX2lcVLAH97OVApNP8FVPgU0+AW4Ps11Od9nQWEmtrF7OYg2LW7jnkUooz5PhMP1pthtKYVRZ0UL7nqMtK6+/W2Ia1D4tYjP5+zy+aGWo/YBxMOKiiSmJqfPeBLs7foCT+FVRpRZmVu2NjGh00aGExdLT31wVJJ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036520; c=relaxed/simple;
	bh=01Fi5TNzSvMLRU2AnDlSa6Qn1N6AyDzIFdpCSe361F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYWZMyq8Q8eZr5enrN63Ssc7F587wB67dzfcMAOwil9jOWfGg20+l6Cc6LulY5VV+e3bp9myLsCllrzkzYbF2aDxkVQgeU80wLT+LAL5Ho2N4DdZR+X7VTY7kMTJfiHa6Moth86ICoxPcyo1kgN0a6Pw9E0KxZ0QN/ft/vXPawg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aAYh9koA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IHYJmPYQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aAYh9koA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IHYJmPYQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aAYh9koA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IHYJmPYQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aAYh9koA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IHYJmPYQ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 545BC66E2C;
	Fri, 29 May 2026 06:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780036517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szWT/bhFGQJ0kXI1YZ6fPqNhNPaDn9DVm7nrr39/tUQ=;
	b=aAYh9koAaDEYQrh+kGcl9KBraw5IW7zZ45VMSrL1/+kG8FA6UVNH6LQy5QwMlBEkVOJdWc
	FLhIEzRYVZ4z/68bjnkkP2fgGCuEYTpxYD1XbY88s9QnI3ZucKJjMN3FYJxCs5ju+i2+Ez
	knPd9HeNYmOPNELMSk7w6Fmh2dXufMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780036517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szWT/bhFGQJ0kXI1YZ6fPqNhNPaDn9DVm7nrr39/tUQ=;
	b=IHYJmPYQikdbIiPGkJvwI7iK9d2hjKjOReWW7TH4M3X8YdUmd3E8QV8KuE3bs4ERk4lpck
	OV3vg9E+V73XtyCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780036517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szWT/bhFGQJ0kXI1YZ6fPqNhNPaDn9DVm7nrr39/tUQ=;
	b=aAYh9koAaDEYQrh+kGcl9KBraw5IW7zZ45VMSrL1/+kG8FA6UVNH6LQy5QwMlBEkVOJdWc
	FLhIEzRYVZ4z/68bjnkkP2fgGCuEYTpxYD1XbY88s9QnI3ZucKJjMN3FYJxCs5ju+i2+Ez
	knPd9HeNYmOPNELMSk7w6Fmh2dXufMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780036517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szWT/bhFGQJ0kXI1YZ6fPqNhNPaDn9DVm7nrr39/tUQ=;
	b=IHYJmPYQikdbIiPGkJvwI7iK9d2hjKjOReWW7TH4M3X8YdUmd3E8QV8KuE3bs4ERk4lpck
	OV3vg9E+V73XtyCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22DF05B1D7;
	Fri, 29 May 2026 06:35:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cbqSBqUzGWqRJQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 May 2026 06:35:17 +0000
Message-ID: <bfa3d9eb-c786-4575-b1f6-8c3f30068917@suse.de>
Date: Fri, 29 May 2026 08:35:16 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/12] block/kyber: Make the lock context annotations
 compatible with Clang
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Nathan Chancellor <nathan@kernel.org>
References: <cover.1779997063.git.bvanassche@acm.org>
 <5165d212359b6b2ac70f52917282b85ea6c75fdf.1779997063.git.bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <5165d212359b6b2ac70f52917282b85ea6c75fdf.1779997063.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,acm.org:email,suse.de:email,suse.de:mid]

On 5/28/26 21:45, Bart Van Assche wrote:
> While sparse ignores the __acquires() and __releases() arguments, Clang
> verifies these. Make the arguments of __acquires() and __releases()
> acceptable for Clang.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/kyber-iosched.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
