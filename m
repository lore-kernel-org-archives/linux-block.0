Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70A122A4E2
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745563003; cv=none; b=dul9EECWFdJQEAaAzS45htDeUSb2LGCvMXI2o5C++jRlDuKNfefSeKPyeSCFYnxTQNgkM8XxCnTXhkpfAEnzWsogH/TOsahXI1wCVx5kzrzcEsyEcasnUflw/deBFYq4VvTw40A9I5SF1mfAJHphCPKozpbkBBLm++pp2r1jBE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745563003; c=relaxed/simple;
	bh=5gqxQIOOJoxK6CrWiGIFE4cs70bgudJl4CQ98ivMT+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvCvwraV5RE3+PC2ZBhcjprX14vL9VCkAvp1IVmmUIm7xnvnJgaE7Zxy1OJcip0Wscuh1lEj1YfU/HoMkf/6QxxObHmfU9dWNIIelNa6r85mu8ZTmkoYNeo+7SNrPTXJZJ5KGgGzcz/Fy8UPkvvTfT/42dFRa/GcLtsmO+VTz8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mxaFimSr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zN4Pq5X2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mxaFimSr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zN4Pq5X2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mxaFimSr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zN4Pq5X2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mxaFimSr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zN4Pq5X2"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB56B210F9;
	Fri, 25 Apr 2025 06:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745562999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VnP2oQNJ4aRkUGsuyBw7pqsaWml2NKM/g69ZFpz9s+0=;
	b=mxaFimSrVXRTnRqxr6JDeb6TsCChhkISwVHqLeYZTL0h+t3uRvlX1i0vmJgTqDfBavQlnn
	V2YogAM0mKIseMQW+3O+TFfv1EUsav5QFGoBB1B9dNjg8T3IeaLjViuh0KR03ZnAyJ0KRG
	694GpvZjRDT8QF+jJpj+Ex7Tvy0xVNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745562999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VnP2oQNJ4aRkUGsuyBw7pqsaWml2NKM/g69ZFpz9s+0=;
	b=zN4Pq5X2H5z+MxJmhwbjj/cIdYwlZ8rnmqrdSBins6BkGeAcVueeIAQtK3V9f02PpabFch
	kPOeHk5bOd8UMJBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mxaFimSr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zN4Pq5X2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745562999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VnP2oQNJ4aRkUGsuyBw7pqsaWml2NKM/g69ZFpz9s+0=;
	b=mxaFimSrVXRTnRqxr6JDeb6TsCChhkISwVHqLeYZTL0h+t3uRvlX1i0vmJgTqDfBavQlnn
	V2YogAM0mKIseMQW+3O+TFfv1EUsav5QFGoBB1B9dNjg8T3IeaLjViuh0KR03ZnAyJ0KRG
	694GpvZjRDT8QF+jJpj+Ex7Tvy0xVNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745562999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VnP2oQNJ4aRkUGsuyBw7pqsaWml2NKM/g69ZFpz9s+0=;
	b=zN4Pq5X2H5z+MxJmhwbjj/cIdYwlZ8rnmqrdSBins6BkGeAcVueeIAQtK3V9f02PpabFch
	kPOeHk5bOd8UMJBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63FE713A80;
	Fri, 25 Apr 2025 06:36:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AtSDFnctC2gZYQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 25 Apr 2025 06:36:39 +0000
Message-ID: <ab199022-c0f1-4836-8b9e-3c3fec70e5aa@suse.de>
Date: Fri, 25 Apr 2025 08:36:38 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 11/20] block: move queue freezing & elevator_lock into
 elevator_change()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-12-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250424152148.1066220-12-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BB56B210F9
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/24/25 17:21, Ming Lei wrote:
> Move queue freezing & elevator_lock into elevator_change(), and prepare
> for using elevator_change() for setting up & tearing down default elevator
> too.
> 
> Also add lockdep_assert_held() in __elevator_change() because either
> read or write lock is required for changing elevator.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/elevator.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
