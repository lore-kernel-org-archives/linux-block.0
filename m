Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779D53101C9
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504573; cv=none; b=TAtmXadEZL9YxP7j9CObGH1GB8W1Orp30DcRGqNGvNCl5RVP6tMH2hSQTwnXds6aorD7E24K5DrwB+nJiqzwwjdJXFcZ7TFr5b71Pd6o0JTzotwfNPfbRlUl65zoubB5ukCHh1CtkWvpVGXFQSM45EipZHuzh4BSRhlDBphIA+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504573; c=relaxed/simple;
	bh=rP+E2CD31qgbHE1m6FB4RF/TswJbPQwZhKtjSLy3eO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9y3grx2tFC6gvhF08gP4Wk9GaVuBr/V1BryPHswQMZXqrovzfknxTmjXXJ/S9Y3tHPTqK+u2V4I40KKPC33XTrXycajA73eIvORDBXhh6mK/VXspGQOjtSZpTlGl43Jxt8k77QOxLlR1eX/fBGbBV4OZ3pvEKm3xsk5xm3ltCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yxbtMWvf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HovKeV5j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yxbtMWvf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HovKeV5j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yxbtMWvf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HovKeV5j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yxbtMWvf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HovKeV5j"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 83F2A21186;
	Fri,  7 Nov 2025 08:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762504569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pG0btqHJb5tpb7zIum7+1MYiOjpAPBFRSsfPmdRBAO0=;
	b=yxbtMWvf75vdc4xP15EVu1GyFrjwCW58HznIQylkZOC6nAVswUioF+otlUnkjAjgpr/nmw
	GMb8JOdSZ5e7IvbKjhElhFl8nYYxzDe0tcfrdBclsCsMXIqoD6mzrzsyuOQRBhq/YZWiLD
	Np2Epk+EWpDiafF//g4EZ7qun0E0rng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762504569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pG0btqHJb5tpb7zIum7+1MYiOjpAPBFRSsfPmdRBAO0=;
	b=HovKeV5j+vZPq+/V1/sHVaOKX2hXSwAhSsKj/F340DuBN4ckmJHoXC3bDI+sV4ka76JSWl
	feXV8GSNMuoIBXDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762504569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pG0btqHJb5tpb7zIum7+1MYiOjpAPBFRSsfPmdRBAO0=;
	b=yxbtMWvf75vdc4xP15EVu1GyFrjwCW58HznIQylkZOC6nAVswUioF+otlUnkjAjgpr/nmw
	GMb8JOdSZ5e7IvbKjhElhFl8nYYxzDe0tcfrdBclsCsMXIqoD6mzrzsyuOQRBhq/YZWiLD
	Np2Epk+EWpDiafF//g4EZ7qun0E0rng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762504569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pG0btqHJb5tpb7zIum7+1MYiOjpAPBFRSsfPmdRBAO0=;
	b=HovKeV5j+vZPq+/V1/sHVaOKX2hXSwAhSsKj/F340DuBN4ckmJHoXC3bDI+sV4ka76JSWl
	feXV8GSNMuoIBXDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 364B5132DD;
	Fri,  7 Nov 2025 08:36:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id inhXC3mvDWnrTwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 07 Nov 2025 08:36:09 +0000
Message-ID: <e0493441-40b8-4e8a-9d58-b2a29d342e02@suse.de>
Date: Fri, 7 Nov 2025 09:36:08 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] block: introduce bdev_zone_start()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20251107063844.151103-1-dlemoal@kernel.org>
 <20251107063844.151103-4-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251107063844.151103-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 11/7/25 07:38, Damien Le Moal wrote:
> Introduce the function bdev_zone_start() as a more explicit (and clear)
> replacement for ALIGN_DOWN() to get the start sector of a zone
> containing a particular sector of a zoned block device.
> 
> Use this new helper in blkdev_get_zone_info() and
> blkdev_report_zones_cached().
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-zoned.c      | 4 ++--
>   include/linux/blkdev.h | 6 ++++++
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
