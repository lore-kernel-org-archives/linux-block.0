Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E760B1AF0AE
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745562818; cv=none; b=DVzYp+CulRYNXbSaQmyx7otC5vXsqz0ddDwbH9+fHd7Pru5zh/ONQBtlUTrO9CV/q23bH2BM/odgLcIm1VdR5w5CZjJ3z3ZdRyKEQTW1RZE1g6ymol/QuJQprCP656t3FJBLXIasAQSIO9TWSVpXTVqw9kyKC7NkdFxrUlTczxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745562818; c=relaxed/simple;
	bh=Se+XiJV4RlZH4JvtAGSXyPOmWWqXt29mdiJKvXX2HTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+mc7oXYSAWCxpg+uwrC2z31iQJrqe62kq+keFaxATdO9F/dDPHaLCw9wonmXy63Lnb+4qHhS5cy2AuWpyjwB7q7FnspYsctQjh/6ulhMEPOt5JK+AQYXqdQu6RP0oAwRMCk+edf5Lmb+ndw3HmGo+auDT3oVDJrijQ5LjmRL/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sBsWQkkS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=49UHcsU0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XFCZBmuv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/LGTL59L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sBsWQkkS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="49UHcsU0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XFCZBmuv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/LGTL59L"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA2B91F38D;
	Fri, 25 Apr 2025 06:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745562815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64P5VITu4fF6krFT/VkDdbX/8g52wrjarDP+Hb42ghw=;
	b=sBsWQkkSA8M5hzPi/LKmoHxK8dkEF+GTmTSYgEBXgQNSIXmmFsPpdPV+5OjnH4+slrqrHF
	SiDsrpcu3QX29kk6LKX9jjqLPIAZ3jjkfzx3jvWlKXotORsCMyK9TEgdTM8Jdkol/lGdWe
	WppP6ojzzXAgeDIxjEVoFrS7z0lcygc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745562815;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64P5VITu4fF6krFT/VkDdbX/8g52wrjarDP+Hb42ghw=;
	b=49UHcsU0wr0cYabEvlsSxtavl8TghPdp0u1DivGBJaz0Rc06Z7SszXue1+YVlEd5KRvks+
	Xzo9WoGjogpnk/Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XFCZBmuv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/LGTL59L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745562814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64P5VITu4fF6krFT/VkDdbX/8g52wrjarDP+Hb42ghw=;
	b=XFCZBmuv7HUu6NanRoDPqJ6iI0XKgIogd8DzFalWIa2AtVglHEqpUSnLjGNy2cUevgI9D9
	IDctnUTSIUiWFIMNH8vtbe60PRZIsQqupynEVd39gOsqJjGBgSwJ0OhYjw0BHb4bMbM3+8
	Rsr2EGMW5QYG7/W/YmYSq+OFh98OUuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745562814;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64P5VITu4fF6krFT/VkDdbX/8g52wrjarDP+Hb42ghw=;
	b=/LGTL59L7f/0+b+MiUQbZX9pJLfmxHV0V9fV9+u6yhHQWTVjq+mqWRKsF3CN31/nFxreTn
	7SRj0q5Ka91WnfCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C97313A80;
	Fri, 25 Apr 2025 06:33:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nJ1tIL4sC2heYAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 25 Apr 2025 06:33:34 +0000
Message-ID: <53b9af6c-dd1e-4749-9fd9-c00f5d579eff@suse.de>
Date: Fri, 25 Apr 2025 08:33:34 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 08/20] block: don't allow to switch elevator if
 updating nr_hw_queues is in-progress
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-9-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250424152148.1066220-9-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DA2B91F38D
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/24/25 17:21, Ming Lei wrote:
> Elevator switch code is another `nr_hw_queue` reader in non-fast-IO code
> path, so it can't be done if updating `nr_hw_queues` is in-progress.
> 
> Take same approach with not allowing add/del disk when updating
> nr_hw_queues is in-progress, by grabbing read lock of
> set->update_nr_hwq_sema.
> 
> Take the nested variant for avoiding the following false positive
> splat[1], and this way is correct because:
> 
> - the read lock in elv_iosched_store() is not overlapped with the read lock
> in adding/deleting disk:
> 
> - kobject attribute is only available after the kobject is added and
> before it is deleted
> 
>    -> #4 (&q->q_usage_counter(queue){++++}-{0:0}:
>    -> #3 (&q->limits_lock){+.+.}-{4:4}:
>    -> #2 (&disk->open_mutex){+.+.}-{4:4}:
>    -> #1 (&set->update_nr_hwq_lock){.+.+}-{4:4}:
>    -> #0 (kn->active#103){++++}-{0:0}:
> 
> Link: https://lore.kernel.org/linux-block/aAWv3NPtNIKKvJZc@fedora/ [1]
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/linux-block/mz4t4tlwiqjijw3zvqnjb7ovvvaegkqganegmmlc567tt5xj67@xal5ro544cnc/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/elevator.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
