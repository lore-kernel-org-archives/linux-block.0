Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C63347278D
	for <linux-block@vger.kernel.org>; Fri,  7 Aug 2026 11:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103349; cv=none; b=AjzqU0I7qlxuonQr4jQWjv3O5oZXdqIHFBYEQIHzkBM6WZX3FfpWYseGNkmGqECWg2YoD60m1rlyi/NAQqqvOkxBUUbLVYSWq4hR7vXeI2iP8ydvv74bG8cL/jzH2aHY+TQFNllxnr7ltR5T95sIztHrkwrqpM6l/DdlDPANxNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103349; c=relaxed/simple;
	bh=ibOXtym9f1h7jH/vfSSs67uqbJLEp4lYfXBpwRz0dXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWJL+UnR6I5Qocuqg97X5jA0qrMSIAq9+h2x9dYK+xqw/02OwNzFeoj/TCD+h+xy4JKwBcYI/iQJlgTI3VW6g5ohXNP6LOFbYQar9jCv/6GwQSAw/+ncWcQInkiQ+3C+hswud7ei7ioxDzkFnVoyFWgnNwVhZOtSdHuj7yo06gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EFDVSZ3z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7DsU+EUz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qz1NzxFU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/eD4r3wG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EFDVSZ3z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7DsU+EUz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qz1NzxFU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/eD4r3wG"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 910A53E0A;
	Fri,  7 Aug 2026 11:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786103331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeCf9wqpw9l6B1Sk7gbT1PDToQf1qO0P+fz2GETSO5Q=;
	b=EFDVSZ3zLagM2StHmftohMYQjY2AD5IdykzQPilnPXINxYQE1wSiF+feLZHjco+qiVdCkR
	Me/xIgmsZ75GVSDpjrT6SVAEwzy4LLeR87uEu3kU1eoP5UreJfflaIgaFemrNUTxG16wye
	aU+PBl6/7dakbQP7kG7ambYck0+eBQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786103331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeCf9wqpw9l6B1Sk7gbT1PDToQf1qO0P+fz2GETSO5Q=;
	b=7DsU+EUzO/W320e1PjPtCiED4Ev6cglQsQuNmz75VTGgd1SuOtayVdS7pIdYrqc9LZznaa
	DMDMecrGUmxK/0Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qz1NzxFU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/eD4r3wG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786103327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeCf9wqpw9l6B1Sk7gbT1PDToQf1qO0P+fz2GETSO5Q=;
	b=qz1NzxFUBOnD3dc5+jA6ztbSHMasT7XeVY91+8Iqy66LfIik7n5xdllktPwsSXWf08vHR9
	5LWuEeHk8+yjTVKbs42BFKBMQ9tIzMon6Msz2dCIo7fxz7D/HFNeVxJohBVX3B9mYnAaFo
	yzBNfDx/T8BtuFQlqprQ/tLnZ2rNei4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786103327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeCf9wqpw9l6B1Sk7gbT1PDToQf1qO0P+fz2GETSO5Q=;
	b=/eD4r3wGE26bLZ5op7ym41TK99NLbnwaS+4WWbexM4+75tXuFThidQMHjQTSPfkDYP7Psv
	8foS8MUUG0uP+LAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B5B8779B6;
	Fri,  7 Aug 2026 11:48:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FeRHHR/GdWqvFAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 07 Aug 2026 11:48:47 +0000
Message-ID: <34ddfe1b-7f5f-4dc8-8cc6-01e09274047a@suse.de>
Date: Fri, 7 Aug 2026 13:48:47 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/13] block: allow read-only and offline conventional
 zones
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260806160445.848337-1-dlemoal@kernel.org>
 <20260806160445.848337-12-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260806160445.848337-12-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 910A53E0A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On 8/6/26 6:04 PM, Damien Le Moal wrote:
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
> ---
>   block/blk-zoned.c | 65 +++++++++++++++++++----------------------------
>   1 file changed, 26 insertions(+), 39 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
