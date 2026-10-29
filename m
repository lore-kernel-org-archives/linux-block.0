Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259884;
	b=xj+IPqG79Bse7QBwT/+3Qv+P7B3lJ3YZYKXTll0rxtccxCBSR1E9WuRA0Rm/MwtZCn7a
	 9age6m2FBu/kIL5oVFxCSX2ytpVdfKoX2YJ7TKtJJ+Q6C+OXn+RKbwFxbJeyAdClDVAHK
	 YCVTqrCfOPQL9poTaOv8bbHXJ3GhGRAkqn/PVGR8QVDf6XEYVtnm7qFPAtzabE7Ggdbgk
	 CVgfpXN4610Eu/LL6U07f+jgsi3SmS/Z62GoW71SCO3R4ObJKDiKQhCtuUxkCETqjgqEe
	 mUr+h2W/dzltxODXspF8Cy1aGHs7ZDlTfc6RAIRA6fccVJwQ4DZoI7U/OJXDPwPOx3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259884;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=iYzgyRy9e7KrMk2VFwevWg5HygN+ByzYcib+AT+Cf+E=;
	b=YX3X64zWKp9Wk7seLuyg9+zUULkVwUkbb9NDgh96ypPxOwDYSgDdT46gzF0+uoN+gl/v
	 BD9/lYxIio7AJ2zhFxfQl2GpZH7tBuIM8pBBmdaZ27r17Tx8SKjcinDFydei2H9f1THZ+
	 gPOw6Ad5xGw4TmkBoonN5/MWRkcjYsH+o9UHVftebAzG14CeQCdvaRWhBtyDYFIX1mJ9w
	 iU1a5W+Kbm7pHpeIv9yKEwSsTgkZ2/0aMnae/8pYRJ5g+i0F649GurtNgi1xLX1nVYFlj
	 gfrEzY1NVF0IcODU6/DOR4AwhhAnEsu02ZVxPw8oawmv6gzU/gEK+mATj/apnmS/ANA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lQMOfMor;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=b3DW9fSm;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lQMOfMor;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=b3DW9fSm;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C23606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 07:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43C23606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lQMOfMor;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=b3DW9fSm;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lQMOfMor;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=b3DW9fSm
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 76A0A220A8;
	Thu, 29 Oct 2026 07:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793259882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYzgyRy9e7KrMk2VFwevWg5HygN+ByzYcib+AT+Cf+E=;
	b=lQMOfMorQhx3EMNG1yP0fEn46+vXDHvtlfoEyYqraT6Pc5sj+K7DmV4kL/XNtzwG3kb9Kn
	5NEbhVZtYtpmTtNYZQXTfFOkbDp4td/DDXO+xC2NqJlCBJhKvCza/yqObD+wyxxjzNEj9N
	Sc8q+ElKSlpaqq+ymERIkdwq2WA7OPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793259882;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYzgyRy9e7KrMk2VFwevWg5HygN+ByzYcib+AT+Cf+E=;
	b=b3DW9fSmdXCzKhDfTLB+aNFo01tQ2QRQo2QXjh+8209mNhlQ2OZh/PPRQEAParkdtUlyi+
	gki7gJLqQniQXmCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793259882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYzgyRy9e7KrMk2VFwevWg5HygN+ByzYcib+AT+Cf+E=;
	b=lQMOfMorQhx3EMNG1yP0fEn46+vXDHvtlfoEyYqraT6Pc5sj+K7DmV4kL/XNtzwG3kb9Kn
	5NEbhVZtYtpmTtNYZQXTfFOkbDp4td/DDXO+xC2NqJlCBJhKvCza/yqObD+wyxxjzNEj9N
	Sc8q+ElKSlpaqq+ymERIkdwq2WA7OPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793259882;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYzgyRy9e7KrMk2VFwevWg5HygN+ByzYcib+AT+Cf+E=;
	b=b3DW9fSmdXCzKhDfTLB+aNFo01tQ2QRQo2QXjh+8209mNhlQ2OZh/PPRQEAParkdtUlyi+
	gki7gJLqQniQXmCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D16F13419;
	Thu, 29 Oct 2026 07:44:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o2sSAmr54modGAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 07:44:42 +0000
Message-ID: <074f2280-973b-4ef8-af98-46d6e6f5c5bd@suse.de>
Date: Thu, 29 Oct 2026 08:44:41 +0100
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
Subject: Re: [PATCH 53/98] nvme-tcp: don't get stuck on a TLS control record
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-54-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-54-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.997];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,grimberg.me:email,suse.de:email,kernel.dk:email,toxicpanda.com:email,lst.de:email]
X-Spam-Score: -13.29

On 10/28/26 5:41 PM, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> The host receives with read_sock(), and tls_sw_read_sock() won't hand
> out a non-data record: it puts it back and returns -EINVAL.
> nvme_tcp_io_work() bails on the error and finds the same record again
> next time, so nothing behind it is ever read. One warning alert or
> NewSessionTicket after the ICResp kills the queue: commands time out and
> the controller resets. The Linux target sends none, but others may.
> 
> Fetch such a record with recvmsg() instead. A fatal alert starts error
> recovery, anything else is dropped whole, with a log line, and the queue
> carries on. io_work and a poller may both see the record, so a bit makes
> sure only one of them deals with it, and that one retries read_sock()
> afterwards.
> 
> Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/host/tcp.c | 87 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 86 insertions(+), 1 deletion(-)
> 
TLS record handling is currently being reworked, so please drop.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
