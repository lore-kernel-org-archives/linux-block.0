Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722371E260A
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 06:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745993645; cv=none; b=gYd6IKsJG/U0tlqPoqwzM0QFqmkteorFImeBRVQZaOOdHVLE71n4dTEIKTrpu9ehP6WgtCnAmyfIjII8QT5bnmjl59IJ1EKds2+Ieiy1NSUeVZvfZkrf6vMeRVnJDGsHbqv1ZE1RFHNTBbb1dU742U7+Ynl4e4dPr4I6Xrhdc5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745993645; c=relaxed/simple;
	bh=gvdroldGMDkRZwkvHLhoSUJTnrkFA+y5X4jnwMCxv0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLP/RJ2wXpGabW3Cw+iSgjR3wVGJttnu3ABZ2jPZ4VDt473lokA+f1jpTpUczq0ywQxBsBEDMLVW6NWJRrHYTnkhUinD91TPfrM5noA/MpCCThFfTgBGIwyIw8NC2UfTNAKiW+n1CfrtIul6TyGC0vIHB41wespSxtYOGbJQFnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EL79PoNH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EKmovIhH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EL79PoNH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EKmovIhH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EL79PoNH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EKmovIhH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EL79PoNH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EKmovIhH"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 745071F7BF;
	Wed, 30 Apr 2025 06:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745993641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zq0mU0C7MsY7J8kGCHXmMgI6DSmr+HdnuACEgPFi/sM=;
	b=EL79PoNHFuMc3X1LV1af/ayqcc6KhB5yr1Lkosx735xYlOP74zJC8wKNucffv84RnHZMWG
	Bk/icbZ/ReyU/f4w8ocC/ZPokcI2y3Zlov/pvLVZBXMJ8EItb4qxUhJX68/UsrqrjrEP8Y
	GXILA125XHs1Bir7sRpLhblSiIVzNUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745993641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zq0mU0C7MsY7J8kGCHXmMgI6DSmr+HdnuACEgPFi/sM=;
	b=EKmovIhHzfNPUkY6fLNEQf/dQK+OHoK7nn5Djm6QJDPBN8+pgTrxAckEAqQu9qZqUq9lYo
	jheT4HwM6mDcU2BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EL79PoNH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EKmovIhH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745993641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zq0mU0C7MsY7J8kGCHXmMgI6DSmr+HdnuACEgPFi/sM=;
	b=EL79PoNHFuMc3X1LV1af/ayqcc6KhB5yr1Lkosx735xYlOP74zJC8wKNucffv84RnHZMWG
	Bk/icbZ/ReyU/f4w8ocC/ZPokcI2y3Zlov/pvLVZBXMJ8EItb4qxUhJX68/UsrqrjrEP8Y
	GXILA125XHs1Bir7sRpLhblSiIVzNUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745993641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zq0mU0C7MsY7J8kGCHXmMgI6DSmr+HdnuACEgPFi/sM=;
	b=EKmovIhHzfNPUkY6fLNEQf/dQK+OHoK7nn5Djm6QJDPBN8+pgTrxAckEAqQu9qZqUq9lYo
	jheT4HwM6mDcU2BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F71A139E7;
	Wed, 30 Apr 2025 06:14:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tF/JCam/EWioZQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 30 Apr 2025 06:14:01 +0000
Message-ID: <a7bc3a79-220e-465c-b442-66f19472de73@suse.de>
Date: Wed, 30 Apr 2025 08:14:00 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 09/24] block: look up the elevator type in
 elevator_switch
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
 <20250430043529.1950194-10-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250430043529.1950194-10-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 745071F7BF
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/30/25 06:35, Ming Lei wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> That makes the function nicely self-contained and can be used
> to avoid code duplication.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c   |  2 +-
>   block/blk.h      |  2 +-
>   block/elevator.c | 18 ++++++++----------
>   3 files changed, 10 insertions(+), 12 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
