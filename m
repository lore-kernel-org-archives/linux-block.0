Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173825;
	b=IHvTHUVXhHRJd0v2ll7ljJ/iaeWx8zmC0HrxUn7MJ7Zh7CTD1Dhj5052EPg43GKlitEq
	 AJCvnR5WY+g6Mi4WZB5HzlypWRZ79q2HOSZ+tgW96gWU/7PngN62C5iEz7XIwgUvaoSNE
	 AAPOpwk9g86FP17i3ZsycAO4E/dHa/A2QKnPAypDayhgYJoRzkVE2f0VlLXOK7JTU0J6Q
	 eMBfsK3yzDkJu7zrEgbosBZC74o+JnaOGRpL9eJ/dYfUwAlO4h/ukK9hcfPWUSNWXb97d
	 PSMwJTMvS3R5rs6kZ3DCoijnjgcGqxIjwxiW8ENKoQqKz+BjKFlxlNOreb8Tsu96Idg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173825;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=9eGVk4i3hUfatSK78Y/+LmSIOKTw0KYxW3KsL+6MN3E=;
	b=3JQR96ad60ZfioLI3J4wyKBLiphG1t54UWX/rowmBb14nxppRdxcm0ZpQ1ArUUcPs48A
	 f7t/ZbLeb5nW+iltFPGzC0NINbF40yhlm6ZT31Hbh71xrpkRki0BQkbyC7rjqah28/EW8
	 b4ynHJA8uA9+2Fo9mMzjeQ4BNQ0aPYvaDFrvb9GVQh5tAAZ5+Wk/CVSlpro8YW47Qz5pz
	 WE25zJmDt+cfQc1hj06EVgcWo3I/S0mmTQ1YSnmhHfDd4+vIRTOPRQUPrrvlUMHKN5vV1
	 sHKPdHUYcripQaGx/Oun3SlBgc0rS+aANMyFz4+pcQxV0HrvPYdfzCv8DrNXkAnZ9sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=n+fBzjWK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=l1hMC5Fi;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Yvt3lMbr;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IGyxlZRY;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DAF606A337
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 11:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9DAF606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=n+fBzjWK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=l1hMC5Fi;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Yvt3lMbr;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IGyxlZRY
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C5CC7225DA;
	Fri, 20 Nov 2026 11:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795173822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eGVk4i3hUfatSK78Y/+LmSIOKTw0KYxW3KsL+6MN3E=;
	b=n+fBzjWK7oZFFXusnr3blFrKqvf5xVozupWbrAlKC/RXa7G5pN2uqrRLI525jitY5DCIcE
	fFQ/Nq/cWSj75htVqJVLg/0kGUM3AaE2+25EnucCGECBTGfNT6d+JFK8M3PnCBousdP3gv
	47Xtgxhz/jCwo+JtByYxz6OGrz0s/7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795173822;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eGVk4i3hUfatSK78Y/+LmSIOKTw0KYxW3KsL+6MN3E=;
	b=l1hMC5FiwKv2r01R42cBp4pq0Zh9keG9HHI+HLi8tTkRZxT52xbhRYR6NhJ2QUFI8D4yfZ
	Hd+sUvqhwUUax1BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795173820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eGVk4i3hUfatSK78Y/+LmSIOKTw0KYxW3KsL+6MN3E=;
	b=Yvt3lMbrOYFiZ1jf0TWmHg3Lr+iMVjoBXCCSSdE4MffMLDs6DP6h8pjpdn0ViEHsYlEiE0
	J9wL3Nio5V4GWxi8rNMspMR/b7BrBJALyBO32pmOirE0dWNFknVDR3VWSmtREk8/8BzoEC
	kQvSOU2EoYfRqA52r4S/8RN9l1MlAWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795173820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eGVk4i3hUfatSK78Y/+LmSIOKTw0KYxW3KsL+6MN3E=;
	b=IGyxlZRYh1jeMrUY2O0rzuhK8Ot3xl5q642qsKRk4MqLEeCi8/i625qOPxhQYvLsxacPM9
	lL1BynNUGiwfd3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 990011342D;
	Fri, 20 Nov 2026 11:23:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hTUSHLwtAGtabQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 20 Nov 2026 11:23:40 +0000
Message-ID: <07e9794a-3c97-4498-8870-81f9b75d8bdf@suse.de>
Date: Fri, 20 Nov 2026 12:23:40 +0100
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 1/9] nvme/047: look up the namespace again
 after reconnecting
To: Daniel Wagner <dwagner@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
 <20261118-nvme-target-control-v2-1-d191bbbf5dd6@suse.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261118-nvme-target-control-v2-1-d191bbbf5dd6@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.997];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-Spam-Flag: NO

On 11/18/26 10:26 AM, Daniel Wagner wrote:
> nvme/047 keeps using the namespace name from the first connect after
> reconnecting. The name can change when other controllers come and go,
> and fio then fails to open the device. Look it up again after the
> second connect.
> 
> Fixes: 7497d8b45817 ("nvme/047: Test different queue types for fabrics transports")
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/047 | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tests/nvme/047 b/tests/nvme/047
> index 433090f2d6f2..2aeee2f0f1aa 100755
> --- a/tests/nvme/047
> +++ b/tests/nvme/047
> @@ -42,6 +42,8 @@ test() {
>   
>   	_nvme_connect_subsys --nr-write-queues 1 --nr-poll-queues 1
>   
> +	ns=$(_find_nvme_ns "${def_subsys_uuid}")
> +
>   	_run_fio_rand_io --filename="/dev/${ns}" --size="${rand_io_size}"
>   
>   	_nvme_disconnect_subsys >> "$FULL" 2>&1
> 

What's a bit awkward is this 'subsys_uuid'; one is confused why we
would set the subsystem UUID as the UUID of the namespace.
Eg what would happen if we were using (or wanting to specify) more
than one namespace?
Can't we rename it to 'ns_uuid' to make the scope clear?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
