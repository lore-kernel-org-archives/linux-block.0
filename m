Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C19364931
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448617; cv=none; b=ZKQ+nGeKNbuPY8u0iCdms98Hc4iDgzmHODFZtkaGUdcvjb6Sx//QKonZaOv7AirNbJ30CxIiRd6LW4jCtgFe02hsu1p9c21t0hu4qRdGsxFMqXDkfpyLRuZ5LsZIck3pezLItZN+N22RZ0ezqTo/WaatNnZXQvCaUZSu1CT7GlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448617; c=relaxed/simple;
	bh=rQygVJUtFAzYtEknhRieKDqn6w0pfOX4KVX5wSMgj9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQKL/VpiUdWASWe0yACIbwapkKmoa6B967M3Uwsqnw2U6XeFb71UroNdwfShoAvjCR5Xgjtyd7MnmZbHDf5mSkwbB6vvPTyc87egoZr5WIhDzdfkY/aqFL82+MnMXY1NtHm9LtQwdKWo/AquMUh0zqlGo41N3/U9C/Ir0OInaEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xRGdOwnn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XztMiCi+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P03WdEaM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oU3Cd0KT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xRGdOwnn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XztMiCi+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P03WdEaM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oU3Cd0KT"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F1DC3E22;
	Tue, 11 Aug 2026 11:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786448610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i6TS3IyCJpyM23K7bEeBSTQtB5rn7KfnCL4AKloVXXg=;
	b=xRGdOwnnRvY/0Acb2Hzmoz7KIHvZPNCEEVDIdqwYWl/oST10gyknBXNIim4vIxNwaeYLRH
	wlpQ5HroBSor0sgOcsMiCgQ8NQf72Uc7pjTreMY5jTo6GQxLKdj043Cu1sGUSqevQ5fsg9
	K2fmtIfhZKyQcTNDDol7WcjLtUbcGZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786448610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i6TS3IyCJpyM23K7bEeBSTQtB5rn7KfnCL4AKloVXXg=;
	b=XztMiCi+sBwbJoJPCTckd1+9fqiUeex2C/V2io2pzXO+NEppO8i0Rt+Ikj9Gv4Aqu/U92l
	3k0jbCF6gW6wQPAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=P03WdEaM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oU3Cd0KT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786448606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i6TS3IyCJpyM23K7bEeBSTQtB5rn7KfnCL4AKloVXXg=;
	b=P03WdEaMDL4v5YngCeSTEqlHEePpnrR0p+oAYtvC+oXYmOFvD/qMVX+SzcDQ2U8Uu+TGBN
	9aCxqge8evJ1EHZl/bJUQYx8Nj+eoDUR0yRDE+oEmVem0aMcDGwOevyHcd9Zq1g4S3lAjz
	3oLFX2pvB7i9IrHdowesYhFMZzLGX4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786448606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i6TS3IyCJpyM23K7bEeBSTQtB5rn7KfnCL4AKloVXXg=;
	b=oU3Cd0KTaMaridW2eu7aAvV//CnsHcNhfrSWUhSrCUbRIu+Q6EpSMq2/RPTAtLN3/VcNiw
	qAoIa/F+r4kKfyAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02854779B2;
	Tue, 11 Aug 2026 11:43:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3bk2AN4Ke2oSfwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 11 Aug 2026 11:43:26 +0000
Message-ID: <5c2906c0-170f-47c3-b8b8-c8f788072bfb@suse.de>
Date: Tue, 11 Aug 2026 13:43:25 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/13] block: allow read-only and offline conventional
 zones
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
 <20260811105852.1245357-12-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260811105852.1245357-12-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,acm.org:email,suse.de:email,suse.de:mid,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 0F1DC3E22
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On 8/11/26 12:58 PM, Damien Le Moal wrote:
> With SCSI and ATA SMR HDDs, the storage element depopulation feature can
> change the condition of conventional zones to read-only (if a write head
> is depopulated) or to offline (if a read head is depopulated).
> However, the function blk_revalidate_zone_cond() currently does not allow
> these conditions for conventional zones, causing a zone revalidation
> failure.
> 
> Remove blk_revalidate_zone_cond() and move the zone condition checks for
> conventional zones to blk_revalidate_conv_zone(), allowing the regular
> BLK_ZONE_COND_NOT_WP condition as well as the BLK_ZONE_COND_OFFLINE and
> BLK_ZONE_COND_READONLY conditions to match the conditions that can be
> seen from a zoned device with depopulated storage elements.
> 
> The zone condition checks for sequential write required zones are moved
> to blk_revalidate_seq_zone() without any change to the conditions allowed.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-zoned.c | 65 +++++++++++++++++++----------------------------
>   1 file changed, 26 insertions(+), 39 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
