Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CC12BB13
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470018; cv=none; b=D7yEfLdQP364+74eU9uw06oxgdLSNac09Foo08arKWNd1FK5lfVDuVPwEPHqFdb/uWCHlXzscx0+P2mqROapZuMb+yLf1Sxt7Qpzq4rT1oDEo6hyvsIRY/7aYcGaucsdtbLUO7jyaUBUcraT95kiQWRVWPZxsThreDccCbVJ46k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470018; c=relaxed/simple;
	bh=t35wQZSxIISjBl4sOR78+opJcmn6kekxvTSKsehHo/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J3NlSfldmZyTSqcaliMhxGz0x4OSz2nAvPDhHY8uOFCfV7ZucpftsvmToZx9HJjrCVE+oIjPuJVGZJmqwc6jfCBgXaOzkLZ91pGcldqfO2QfGUL6a2bDVpo/3TpD893OQ0YR3ncA5lXWJvaHSiUisYLCIewsVhv9BMowSzcwgrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mj44/j/S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f1vAN1Km; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VvbQRQW1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FLiI0LwQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mj44/j/S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f1vAN1Km";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VvbQRQW1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FLiI0LwQ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D3BB91F44F;
	Tue, 25 Feb 2025 07:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740470015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CaQDQHKucYyx6duPgqRf7+EjMBtYFl+033EZ1moC81Q=;
	b=mj44/j/SCdCrbhoLq8lfMSMp7cT4TAHpo0P19/0tSfIBiPp+syN5WCsQpwITMqELGcLtCs
	KIA8IkUqH2drm/5ldLXI8q57DpYejCSw3fZAlw+KNZwhvmOwUHZcM/qf018nqjNTY3/bnd
	nVCIfCMu2obfMTJJxl2Mti7Z0gwcK0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740470015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CaQDQHKucYyx6duPgqRf7+EjMBtYFl+033EZ1moC81Q=;
	b=f1vAN1KmtxWQeU/g+ihVyKFJ4D6bLXpkz/J/bWQ2eyNhd+Aq10DegLbv7giPxYqPTtTSBa
	L2D4cKEIbLVmsXCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VvbQRQW1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FLiI0LwQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740470014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CaQDQHKucYyx6duPgqRf7+EjMBtYFl+033EZ1moC81Q=;
	b=VvbQRQW1x9lYTefkBd67MXHIMTdFNpuQ6flsBzr3ZF8gv7RMY5crISH1kLJ2rRtqIEUCUz
	7Ej8TeGhlMCc0SDJKl8gibLvSii/At7CDXnjBKN0c07MfYoc5lSGIFLTGBffDw6ImZED2n
	6XNW8g69nrBz0G+OVOs2kM5dFNRKv6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740470014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CaQDQHKucYyx6duPgqRf7+EjMBtYFl+033EZ1moC81Q=;
	b=FLiI0LwQxWfwgCGEG4yzkbnbsXfa0tF0KFCkfu80wOxMmiQX9thvPhyYgxm2O6EVefiPmG
	tj1gXGso+Y5vdBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96D8513332;
	Tue, 25 Feb 2025 07:53:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mz8SI/52vWcIcwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 25 Feb 2025 07:53:34 +0000
Message-ID: <b70d5872-99e1-458f-aea9-282d2d9dda78@suse.de>
Date: Tue, 25 Feb 2025 08:53:34 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 6/7] block: protect wbt_lat_usec using q->elevator_lock
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
 gjoyce@ibm.com
References: <20250224133102.1240146-1-nilay@linux.ibm.com>
 <20250224133102.1240146-7-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250224133102.1240146-7-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D3BB91F44F
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/24/25 14:30, Nilay Shroff wrote:
> The wbt latency and state could be updated while initializing the
> elevator or exiting the elevator. It could be also updates while
> configuring IO latency QoS parameters using cgroup. The elevator
> code path is now protected with q->elevator_lock. So we should
> protect the access to sysfs attribute wbt_lat_usec using q->elevator
> _lock instead of q->sysfs_lock. White we're at it, also protect
> ioc_qos_write(), which configures wbt parameters via cgroup, using
> q->elevator_lock.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-iocost.c |  2 ++
>   block/blk-sysfs.c  | 20 ++++++++------------
>   2 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 65a1d4427ccf..c68373361301 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -3249,6 +3249,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
>   	}
>   
>   	memflags = blk_mq_freeze_queue(disk->queue);
> +	mutex_lock(&disk->queue->elevator_lock);
>   	blk_mq_quiesce_queue(disk->queue);
>   
Ordering?

Do we have a defined order between 'freeze', 'quiesce' and taking the 
respective lock?

Or, to put it the other way round: why do we tak the lock after the 
'freeze', but before the 'quiesce'?

Isn't that worth a comment somewhere?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
