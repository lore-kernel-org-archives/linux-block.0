Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F771E5B85
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 06:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745301697; cv=none; b=JkovcIAORr9mJQkjRwkU6l4aamGc+7J1TzLXQNwTfVInQt3mrSiCfb7KzWFMTKj0b1SCDF9qdPIArzZ+VrwnPrtXCLR9wrq7jtTXy0jarrPQs9Bk7auN9Noei9q6GIMrkTiHdVfS4/uzwQoLIomz49VLou+5uDOXsOYkl5EC19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745301697; c=relaxed/simple;
	bh=wGwgiewhjBIX+8GjUdc/oNiJL/kmB1/DwG03EBgDE2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XsS9fD7/R3Ko4RXyT0TU3X9Afs9aTN+94fkFNK1TsNLRUKznY+uAg34B0bk0hYa0DL2L0+nIPCJYZZByC/hlcIBsiMCh6qxi+tY2scuX3PbyvWllMgdF5ZVwxSwiF4iKvag1RU12LXuT1ILJX8W5H9dwEjqTf8th+UJJ4exZ9Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V/AJtEeZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q4dkB/1G; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V/AJtEeZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q4dkB/1G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V/AJtEeZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q4dkB/1G";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V/AJtEeZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q4dkB/1G"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B2641F7C1;
	Tue, 22 Apr 2025 06:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745301694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qAEdlD+1fkBRWwWX7oIvbsU76R7RqsdxCsykUSCBNJo=;
	b=V/AJtEeZ4XjpnBecoNG+xxQnCSBNXhf3YNyc0BRKA5soSs2gfjuEjIZv55JSKWHHNldOYr
	IPTdtcVK+9n0QB0PN2IIDC2JmW/E/O+yiIj7xawf/zxFOnekV7kVKPtjVEwueGMAF40U85
	jKVdoJY+KdDmPyW2etLEUno8VCsjOvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745301694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qAEdlD+1fkBRWwWX7oIvbsU76R7RqsdxCsykUSCBNJo=;
	b=q4dkB/1GqXzN6imkMJStRz0xxvbAMZQuMsXBaekQeBhCVITT3jYFEVbyEjZt6Wb9GGxO8L
	6MQ4TMaKo4o7dwAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="V/AJtEeZ";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="q4dkB/1G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745301694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qAEdlD+1fkBRWwWX7oIvbsU76R7RqsdxCsykUSCBNJo=;
	b=V/AJtEeZ4XjpnBecoNG+xxQnCSBNXhf3YNyc0BRKA5soSs2gfjuEjIZv55JSKWHHNldOYr
	IPTdtcVK+9n0QB0PN2IIDC2JmW/E/O+yiIj7xawf/zxFOnekV7kVKPtjVEwueGMAF40U85
	jKVdoJY+KdDmPyW2etLEUno8VCsjOvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745301694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qAEdlD+1fkBRWwWX7oIvbsU76R7RqsdxCsykUSCBNJo=;
	b=q4dkB/1GqXzN6imkMJStRz0xxvbAMZQuMsXBaekQeBhCVITT3jYFEVbyEjZt6Wb9GGxO8L
	6MQ4TMaKo4o7dwAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94490139D5;
	Tue, 22 Apr 2025 06:01:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WbmeIr0wB2i7IQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Apr 2025 06:01:33 +0000
Message-ID: <28543ecf-3f2d-432d-a81a-97903082d9b5@suse.de>
Date: Tue, 22 Apr 2025 08:01:32 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 02/20] block: move ELEVATOR_FLAG_DISABLE_WBT as request
 queue flag
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-3-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250418163708.442085-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0B2641F7C1
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/18/25 18:36, Ming Lei wrote:
> ELEVATOR_FLAG_DISABLE_WBT is only used by BFQ to disallow wbt when BFQ is
> in use. The flag is set in BFQ's init(), and cleared in BFQ's exit().
> 
> Making it as request queue flag, so that we can avoid to deal with elevator
> switch race. Also it isn't graceful to checking one scheduler flag in
> wbt_enable_default().
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/bfq-iosched.c    | 4 ++--
>   block/blk-mq-debugfs.c | 1 +
>   block/blk-wbt.c        | 3 +--
>   block/elevator.h       | 1 -
>   include/linux/blkdev.h | 3 +++
>   5 files changed, 7 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
