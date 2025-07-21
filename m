Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E863A921
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753082097; cv=none; b=LjAhQQssodSlmVH+isvJZgRLtM9ex/vu0tghDM91l1XYdw8tFpAmWGSCfXochSpiDJGnFtLPuWGVUlvbbra8v85KLs8zdAJjm6OBw08H7q7164AN9NUo0igzzH29nJVSibTCTKnDUTHddBsVa44iYz3ZU/kac3KUdvGNds532/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753082097; c=relaxed/simple;
	bh=laHnPdvQO5x19nokzRULx5+CiwTf6sTMk6gXF5XAuU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=guIdN+CH76fJKyrHE0eW8ZdXEioaIp9xOFr2ub5AUb/jadqtGIYdZ01AI2BevTxOWNXAz8FOu2Qp5SQRrpjwvNzK+XpgLoAtNIERSlbU1gS5fZgY/FK6MfF4cgNUbemHRX+XjVX3g7EfTmC3xyVXWbFJKOa3eiLE/Rcu2VsROgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YFWVa32A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ytmx46To; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YFWVa32A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ytmx46To; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YFWVa32A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ytmx46To";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YFWVa32A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ytmx46To"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3231521A30;
	Mon, 21 Jul 2025 07:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753082093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HAnCZ7rNYSmKhL1wnnLjpVMKn8mj3drdj7bfFh/pUBo=;
	b=YFWVa32A/6s2DZfMn+hgchgPBTjKUt1YPPoPkbwzH6K6uy0z9b2Ltii8d2gsgxI521lxGX
	h8C7HKaQePXvJH+eXEhAYkjibDw7n3BGo1oVttHQxX+JvstmqdCfJMSgLxb1rQcos2rAMQ
	Nv32VvR5s79So2uaVWjFMvHf5JvXrxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753082093;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HAnCZ7rNYSmKhL1wnnLjpVMKn8mj3drdj7bfFh/pUBo=;
	b=ytmx46ToSRKZa4+ogf7A+1v5c8q+dS0vrjU1JyNGMJPd1jJCU3vBNbZLKye7gM8wcyjoS4
	QwpHXcMikNJYCEDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753082093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HAnCZ7rNYSmKhL1wnnLjpVMKn8mj3drdj7bfFh/pUBo=;
	b=YFWVa32A/6s2DZfMn+hgchgPBTjKUt1YPPoPkbwzH6K6uy0z9b2Ltii8d2gsgxI521lxGX
	h8C7HKaQePXvJH+eXEhAYkjibDw7n3BGo1oVttHQxX+JvstmqdCfJMSgLxb1rQcos2rAMQ
	Nv32VvR5s79So2uaVWjFMvHf5JvXrxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753082093;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HAnCZ7rNYSmKhL1wnnLjpVMKn8mj3drdj7bfFh/pUBo=;
	b=ytmx46ToSRKZa4+ogf7A+1v5c8q+dS0vrjU1JyNGMJPd1jJCU3vBNbZLKye7gM8wcyjoS4
	QwpHXcMikNJYCEDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E34A5136A8;
	Mon, 21 Jul 2025 07:14:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bIRKNezofWiNWgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Jul 2025 07:14:52 +0000
Message-ID: <856ccfc6-f576-4789-8f4d-92b9498527d8@suse.de>
Date: Mon, 21 Jul 2025 09:14:52 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix module reference leak in mq-deadline I/O
 scheduler
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk, gjoyce@ibm.com
References: <20250719132722.769536-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250719132722.769536-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 7/19/25 15:26, Nilay Shroff wrote:
> During probe, when the block layer registers a request queue, it
> defaults to the mq-deadline I/O scheduler if the device is single-queue
> and the mq-deadline module is available. To determine availability, the
> elevator_set_default() invokes elevator_find_get(), which increments the
> module's reference count. However, this reference is never released,
> resulting in a module reference leak that prevents the mq-deadline module
> from being unloaded.
> 
> This patch fixes the issue by ensuring the acquired module reference is
> properly released.
> 
> Fixes: 1e44bedbc921 ("block: unifying elevator change")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
> Note: This patch is based on https://lore.kernel.org/all/20250718133232.626418-1-nilay@linux.ibm.com/
> So please apply this patch after the above is merged.
> ---
>   block/elevator.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
