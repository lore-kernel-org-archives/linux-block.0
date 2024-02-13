Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DFB381D5
	for <linux-block@vger.kernel.org>; Tue, 13 Feb 2024 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825668; cv=none; b=p/gAx6JUBR5MNZbIQauEfB+2FZgcVIqULTmITz8jJ8R03Vbu7Le+FymojaWUAx9n990oBF+yfreGZB8HmSUdaVk5d+n9EEGPCCt7rYMeGAv+LSDBal3tmuhBe1J0Gtp1Sd3Ng6/AdzdVqJWwQ0kgKB1gNO+M68z8AIG2OAI8Zgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825668; c=relaxed/simple;
	bh=LlqMFc0KD+ARHuUxOVdF0nMLCR2bchX0uM6oN9g/KuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2y8ui9wl1Pja1EHb1gYQCLzp7rqgAseRK90fhHIhAx1OXyB6i9uLStQ0aAecq6BhDSXw4E2yVdjuZzSrgZ256xsuC0KQEm1NrpDC3e9UsEzDFQn1L9eQrE5HQfG+N/m2+h9ma+RYqKmLbvVSbRjCT0KafyJ1KFI12VLnpGJtLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nYilzl+Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rgak5yNP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nYilzl+Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rgak5yNP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nYilzl+Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rgak5yNP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nYilzl+Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rgak5yNP"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C34C22202;
	Tue, 13 Feb 2024 12:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707825660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfGsMKhC3RUEfvaT5VCui4TBVLfYZd6NdpQbaFjP+Bo=;
	b=nYilzl+Q07/6rNMhbnC5vggZookLDqxqf29Fyfoio8cSQF2Nq+N1K0B7x9tqr5QySlgAd+
	d2HZJoJhA88KyuvspRh9hpYeLv1wOlkTZyYlOwt0X/WreomX3LmxShl3Ys5VgjVzgJSz0y
	ekecPa14JXxFd+s/JrmH1NquXKRmQvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707825660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfGsMKhC3RUEfvaT5VCui4TBVLfYZd6NdpQbaFjP+Bo=;
	b=rgak5yNP+kOMVGyU9iyzXolzTVGr5kXyksSw8p4ssrRYRdHIRXimPEr0eB7+3iLAB4VgZT
	67HqdUaivg0LRXBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707825660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfGsMKhC3RUEfvaT5VCui4TBVLfYZd6NdpQbaFjP+Bo=;
	b=nYilzl+Q07/6rNMhbnC5vggZookLDqxqf29Fyfoio8cSQF2Nq+N1K0B7x9tqr5QySlgAd+
	d2HZJoJhA88KyuvspRh9hpYeLv1wOlkTZyYlOwt0X/WreomX3LmxShl3Ys5VgjVzgJSz0y
	ekecPa14JXxFd+s/JrmH1NquXKRmQvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707825660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfGsMKhC3RUEfvaT5VCui4TBVLfYZd6NdpQbaFjP+Bo=;
	b=rgak5yNP+kOMVGyU9iyzXolzTVGr5kXyksSw8p4ssrRYRdHIRXimPEr0eB7+3iLAB4VgZT
	67HqdUaivg0LRXBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F32D1370C;
	Tue, 13 Feb 2024 12:01:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ujJdCvxZy2UaAgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 13 Feb 2024 12:01:00 +0000
Message-ID: <63665452-69a0-4589-82c9-6ee5de735c67@suse.de>
Date: Tue, 13 Feb 2024 13:00:59 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] block: add an API to atomically update queue limits
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240213073425.1621680-1-hch@lst.de>
 <20240213073425.1621680-5-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240213073425.1621680-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nYilzl+Q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rgak5yNP
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.08 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.58)[98.15%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -6.08
X-Rspamd-Queue-Id: 5C34C22202
X-Spam-Flag: NO

On 2/13/24 08:34, Christoph Hellwig wrote:
> Add a new queue_limits_{start,commit}_update pair of functions that
> allows taking an atomic snapshot of queue limits, update it, and
> commit it if it passes validity checking.  Also use the low-level
> validation helper to implement blk_set_default_limits instead of
> duplicating the initialization.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-core.c       |   1 +
>   block/blk-settings.c   | 228 ++++++++++++++++++++++++++++++++++-------
>   block/blk.h            |   2 +-
>   include/linux/blkdev.h |  23 +++++
>   4 files changed, 217 insertions(+), 37 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

