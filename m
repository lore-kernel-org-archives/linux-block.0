Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288A32356DE
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749630541; cv=none; b=lgxuyB8yJ6Lci/0yUYfiEDf/t1R8dsOnCUSZaIxefEnsAaTS8jSjanv8GfEPYeNVd1zmElsxmCrcb6rATK68E0L71nq7OutsDnjkw3weE1a7WJUCqn9wha1dCNMeVbwJtY49pcVcvtgtUd8t+2zJ9fq+iZfmWFHGf2nvvXpqRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749630541; c=relaxed/simple;
	bh=QnF0Ld8acv43UQ9ffDiEIz7sBvevGBLYajEPoczMnjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YvTbSGt4Za/i/+o6tkUGAj6JsIwPaHhdcPTCAeRbhBmsW+3bmP8chwY/Yi2Zbn6eEIJaDT4L/TM0CwhpePDFgmMWMBtcnLs5hA6J64CBlE0fsgzDxIURybUKNRb5IeyqCBl8FixmNKPNrRQeTx0UqdmIC5iQJngcPKtOnqCnfks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NWHGSxU+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Kfu6V0ck; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NWHGSxU+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Kfu6V0ck; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NWHGSxU+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Kfu6V0ck";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NWHGSxU+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Kfu6V0ck"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 361781F79E;
	Wed, 11 Jun 2025 08:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749630538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iWbCIhGuQmZAI7DQK9PaeMKGwkly0Axz0Gduq89pco0=;
	b=NWHGSxU+lnnXP5YSv5kpKdVpbVbqPvJXagWa+jtpdEq8ZDN8SqOkl6dlT5je8gA/i+6iXd
	bV3laCpfseTjLvmTcny91BwRTo+xNSx3O5GAfvmAeoDV4+m/QG6GWQRwH7h0F0sct4pXLv
	pSFtiXCZ9b87km1kCs84UrnfaQWC4os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749630538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iWbCIhGuQmZAI7DQK9PaeMKGwkly0Axz0Gduq89pco0=;
	b=Kfu6V0ck1iN1wUftmGFU14UqMQd5b/c1LVdbuD+/Oq+LYQreDwvpEZ55DAgzYFzDXIs/ai
	uqBNh/9tzqmzm3Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749630538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iWbCIhGuQmZAI7DQK9PaeMKGwkly0Axz0Gduq89pco0=;
	b=NWHGSxU+lnnXP5YSv5kpKdVpbVbqPvJXagWa+jtpdEq8ZDN8SqOkl6dlT5je8gA/i+6iXd
	bV3laCpfseTjLvmTcny91BwRTo+xNSx3O5GAfvmAeoDV4+m/QG6GWQRwH7h0F0sct4pXLv
	pSFtiXCZ9b87km1kCs84UrnfaQWC4os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749630538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iWbCIhGuQmZAI7DQK9PaeMKGwkly0Axz0Gduq89pco0=;
	b=Kfu6V0ck1iN1wUftmGFU14UqMQd5b/c1LVdbuD+/Oq+LYQreDwvpEZ55DAgzYFzDXIs/ai
	uqBNh/9tzqmzm3Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A1F7137FE;
	Wed, 11 Jun 2025 08:28:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 075wBUo+SWgWawAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 11 Jun 2025 08:28:58 +0000
Message-ID: <926bd8e3-e644-43a7-943a-6c80df200bbf@suse.de>
Date: Wed, 11 Jun 2025 10:28:57 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Clear BIO_EMULATES_ZONE_APPEND flag on BIO
 completion
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20250611005915.89843-1-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250611005915.89843-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
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
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On 6/11/25 02:59, Damien Le Moal wrote:
> When blk_zone_write_plug_bio_endio() is called for a regular write BIO
> used to emulate a zone append operation, that is, a BIO flagged with
> BIO_EMULATES_ZONE_APPEND, the BIO operation code is restored to the
> original REQ_OP_ZONE_APPEND but the BIO_EMULATES_ZONE_APPEND flag is not
> cleared. Clear it to fully return the BIO to its orginal definition.
> 
> Fixes: 9b1ce7f0c6f8 ("block: Implement zone append emulation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index dfcef04ea8b4..55e64ca869d7 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -1254,6 +1254,7 @@ void blk_zone_write_plug_bio_endio(struct bio *bio)
>   	if (bio_flagged(bio, BIO_EMULATES_ZONE_APPEND)) {
>   		bio->bi_opf &= ~REQ_OP_MASK;
>   		bio->bi_opf |= REQ_OP_ZONE_APPEND;
> +		bio_clear_flag(bio, BIO_EMULATES_ZONE_APPEND);
>   	}
>   
>   	/*
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
