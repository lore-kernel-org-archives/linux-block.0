Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556B9342CBA
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 06:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783925479; cv=none; b=nUFT7k3LEmKTMn1H3GcEEl/v1MwBO++zFFX4fybgHBXnw7S9KINLIH7y7kGuV95jhp5qm/wnstYwaObzYWpnIAH8cDiswWqBw8MYhH0tUZoTGX3lEjVfwZ0ZTfDS4mefcrOgTrZaHUYVmJGE5+ZM/nhw5T5qAmeIcE9Q1MP3ahY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783925479; c=relaxed/simple;
	bh=3i/EzXkWvSHr5bRVpIx9fX1f045wr/eghivsmwBX6BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIC645Epu12jP4f6i4gYqysNljbzONqNpIu5H5HzSY1cfz3CkoqoIsXLVnesH9lFLu09XmKRpMxwVUOunkqT+Gli4yb/0Q65WGzgURjYkdbDvAIKgtc1T8af5rhuc2p7P0mrDB9RazhVQ6iZu5OXJxTFoaKcCWOWrzJ17WpScPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ss3p1Bil; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fq3Zovrs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ss3p1Bil; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fq3Zovrs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ss3p1Bil";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fq3Zovrs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ss3p1Bil";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fq3Zovrs"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A6217740B;
	Mon, 13 Jul 2026 06:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783925470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYE/cr+IHUxdiM3OBW129gkzz/uLDWhYyZFceMYkVbg=;
	b=Ss3p1BilMXNdCo+rh2WY/NeGrv1xfbPAxORpilXsuh7Jv4SU0T560DqNtne0Bbzd18+tfW
	xiKoajFvDzbhg+iAesh4AJCJf8GLamANDVHBvlw0RZkIu/ZWArptHb7Lnh48iiXLHH7yE/
	iV8L52jiQLRivBX1TyoUoWOmT/qoptM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783925470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYE/cr+IHUxdiM3OBW129gkzz/uLDWhYyZFceMYkVbg=;
	b=fq3Zovrspe/CHvd4ezmjh2aA7T2CmYk2fDvM2hZ6zD+59KOnHDg3Cpa1WTV1oEscezp3V5
	n2pnC5P1TT+o1gCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783925470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYE/cr+IHUxdiM3OBW129gkzz/uLDWhYyZFceMYkVbg=;
	b=Ss3p1BilMXNdCo+rh2WY/NeGrv1xfbPAxORpilXsuh7Jv4SU0T560DqNtne0Bbzd18+tfW
	xiKoajFvDzbhg+iAesh4AJCJf8GLamANDVHBvlw0RZkIu/ZWArptHb7Lnh48iiXLHH7yE/
	iV8L52jiQLRivBX1TyoUoWOmT/qoptM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783925470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYE/cr+IHUxdiM3OBW129gkzz/uLDWhYyZFceMYkVbg=;
	b=fq3Zovrspe/CHvd4ezmjh2aA7T2CmYk2fDvM2hZ6zD+59KOnHDg3Cpa1WTV1oEscezp3V5
	n2pnC5P1TT+o1gCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECDE7779AE;
	Mon, 13 Jul 2026 06:51:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n6uYON2KVGo9QwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jul 2026 06:51:09 +0000
Message-ID: <ee86f276-d3ff-401c-927f-6103018b96b9@suse.de>
Date: Mon, 13 Jul 2026 08:51:09 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] partitions: aix: bound the lvd scan to one sector
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: Kees Cook <kees@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260606170721.1530005-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260606170721.1530005-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.dk];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -2.80

On 6/6/26 7:07 PM, Michael Bommarito wrote:
> aix_partition() reads the logical-volume descriptor array as a single
> sector and then scans it:
> 
> 	if (numlvs && (d = read_part_sector(state, vgda_sector + 1, &sect))) {
> 		struct lvd *p = (struct lvd *)d;
> 		...
> 		for (i = 0; foundlvs < numlvs && i < state->limit; i += 1) {
> 			lvip[i].pps_per_lv = be16_to_cpu(p[i].num_lps);
> 
> p points at a single 512-byte sector, which holds 512 / sizeof(struct
> lvd) = 16 entries, but the loop runs until foundlvs reaches the on-disk
> numlvs or i reaches state->limit (DISK_MAX_PARTS, 256). numlvs is an
> on-disk __be16 read straight from the volume group descriptor and is not
> validated, so a crafted AIX image with numlvs larger than 16 and lvd
> entries whose num_lps fields are zero (so foundlvs never advances) drives
> the loop to read p[i] well past the end of the read sector buffer.
> 
> The 2014 off-by-one fix d97a86c170b4 hardened the matching write of
> lvip[lv_ix] but left this read loop unbounded.
> 
> Bound the scan to the number of struct lvd entries that fit in the
> sector that was actually read.
> 
> Fixes: 6ceea22bbbc8 ("partitions: add aix lvm partition support files")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>   block/partitions/aix.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/block/partitions/aix.c b/block/partitions/aix.c
> index 29b8f4cebb63d..6679e825ba329 100644
> --- a/block/partitions/aix.c
> +++ b/block/partitions/aix.c
> @@ -208,7 +208,14 @@ int aix_partition(struct parsed_partitions *state)
>   		if (n) {
>   			int foundlvs = 0;
>   
> -			for (i = 0; foundlvs < numlvs && i < state->limit; i += 1) {
> +			/*
> +			 * The lvd array was read as a single sector; only the
> +			 * struct lvd entries that fit in it are valid.  Bound the
> +			 * scan so an on-disk numlvs larger than that cannot walk
> +			 * the read buffer out of bounds.
> +			 */
> +			for (i = 0; foundlvs < numlvs && i < state->limit &&
> +				    i < 512 / (int)sizeof(struct lvd); i += 1) {

I would use SECTOR_SIZE here. And maybe 'i++' instead of 'i += 1'.
>   				lvip[i].pps_per_lv = be16_to_cpu(p[i].num_lps);
>   				if (lvip[i].pps_per_lv)
>   					foundlvs += 1;
> 
> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
