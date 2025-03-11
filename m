Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFA91E832A
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 06:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741675900; cv=none; b=N/P7phuxo3xrg4hblt2/m2ojh6PUJlh2AyB00n7UUmRzJmfuyFlHaLOWdsxhKw0mP/Z4hmZ1z9IhnAg5bZz1k4w3J5wKHRewqilsyLSgygFKVcjA/kAXNnC0/m1gPMVcQzPQFSIvhv+HUwwnBRGgWKO7BriG12LpgrOGmgQ7Cpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741675900; c=relaxed/simple;
	bh=QzerK6GeikVLIrCjSGCY9tqsm4/o0u/k5N5fXh2m77k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFtrpLVyJ4HuIw4tgayGEgiDp5/De2GgprFb9kj+Uxzq6kW3XCqkkEDQC0sX08pGjhPwyGOkTA33zi0tyaFr3z80KJ1X8wWyu22rm4nEtEgtJ/Kd4xfNoNae+u11swOrc2JSnYLdFv8EGggWSgUIKBtCe18QfSJyUGM8S18Wgrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1zwEPOj2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rA4GAXXY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DVNXpfym; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wFcxj13E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1zwEPOj2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rA4GAXXY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DVNXpfym";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wFcxj13E"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DEBE221160;
	Tue, 11 Mar 2025 06:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741675891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XuWsXNiH7JOurfSIKnuP0VhNPAo74ZyN71/Csl8aHDo=;
	b=1zwEPOj21ZO8j2BGYHGmXWt9kmNeqais+S+IP7VjVapc73Dc7rQszBvv6jZk63z/u86CSR
	MYcRam8tOM8e46Hj62mDUZSFokytyNtJrq8EBjJSdwg3191GJrNzm+sxf3wr/EqWmUdiaN
	tnIgt19MGPNlACRXZvXkroeLuy6cEFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741675891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XuWsXNiH7JOurfSIKnuP0VhNPAo74ZyN71/Csl8aHDo=;
	b=rA4GAXXYBbYimGKPZHax2rLTo+yCK5b6VOugEcob8LiXLKdet6B6YGiKnHeSHq3GEdz4oh
	hdYfoniFnzov9aCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741675890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XuWsXNiH7JOurfSIKnuP0VhNPAo74ZyN71/Csl8aHDo=;
	b=DVNXpfym6ieWN9Z8ZU4yqXpg0UcvxJ8R79UdnHOkJYfwAsaRv6sWMMgib0FCQu0xT7W+st
	mFBt5n9yJo2aUtjzBPFO4EYCcpqDmaw5hbZ2lkNYITzG2LrZSfOFELiFbP7H8GOq1f7WJd
	BQQFAH9s1IA6JgZy39C/T9B91Jsx4xY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741675890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XuWsXNiH7JOurfSIKnuP0VhNPAo74ZyN71/Csl8aHDo=;
	b=wFcxj13Emyv4q2gCEcgtFDqwnE5vZ4EPScxCS8wAZ6gEiaJAJI+Q8cn2RL+K7QaVj9ggXj
	ZAKjSJDpJkut4yAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16D9D132CB;
	Tue, 11 Mar 2025 06:51:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zQq+A3Ldz2c7QQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 11 Mar 2025 06:51:30 +0000
Message-ID: <78673d08-cd0d-4daf-b471-98fabe824f3a@suse.de>
Date: Tue, 11 Mar 2025 07:51:29 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: move error logging from nvme_end_req() to
 __nvme_end_req()
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alan Adamson <alan.adamson@oracle.com>
Cc: virtualization@lists.linux.dev, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Sven Peter <sven@svenpeter.dev>,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20250311024144.1762333-1-shinichiro.kawasaki@wdc.com>
 <20250311024144.1762333-2-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250311024144.1762333-2-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 3/11/25 03:41, Shin'ichiro Kawasaki wrote:
> Before the Commit 1f47ed294a2b ("block: cleanup and fix batch completion
> adding conditions"), blk_mq_add_to_batch() did not add failed
> passthrough requests to batch, and returned false. After the commit,
> blk_mq_add_to_batch() always adds passthrough requests to batch
> regardless of whether the request failed or not, and returns true. This
> affected error logging feature in the NVME driver.
> 
> Before the commit, the call chain of failed passthrough request was as
> follows:
> 
> nvme_handle_cqe()
>   blk_mq_add_to_batch() .. false is returned, then call nvme_pci_complete_rq()
>   nvme_pci_complete_rq()
>    nvme_complete_rq()
>     nvme_end_req()
>      nvme_log_err_passthru() .. error logging
>      __nvme_end_req()        .. end of the rqeuest
> 
> After the commit, the call chain is as follows:
> 
> nvme_handle_cqe()
>   blk_mq_add_to_batch() .. true is returned, then set nvme_pci_complete_batch()
>   ..
>   nvme_pci_complete_batch()
>    nvme_complete_batch()
>     nvme_complete_batch_req()
>      __nvme_end_req() .. end of the request, without error logging
> 
> To make the error logging feature work again for passthrough requests, move the
> nvme_log_err_passthru() call from nvme_end_req() to __nvme_end_req().
> 
> While at it, move nvme_log_error() call for non-passthrough requests together
> with nvme_log_err_passthru(). Even though the trigger commit does not affect
> non-passthrough requests, move it together for code simplicity.
> 
> Fixes: 1f47ed294a2b ("block: cleanup and fix batch completion adding conditions")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   drivers/nvme/host/core.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
