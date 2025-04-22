Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F8D63D
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745301755; cv=none; b=LRJMJkix5adgsIGHwTg3b+FVzFx6aOgOv39hfgWveqGB4sPFR6QcfVwC5BIkpeD+YiQpzEJRfDJ9iZZvdAgkRylmyRM9xCXsBJG6naBr9tELPs42fyGJljB0maZXBt2ce9iypagAPEC5KqWSkY7BeS0t/zmu8OsHFXbx0nATwmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745301755; c=relaxed/simple;
	bh=GT8o6pdO+ZLa6wnNaz5X5segKNPjjsaLAMJpM5necVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8Qz4Mte9m2xgh6sB+8YQs+fHpSaHbDF7/kv44uCFXY9uYrpC0DCO674eLExVCPhNC+nmycAovPJLgxBJFjQujKm8PCS07M35x4RtAt2XoC2mX+7FH+Kl8r1B7siLA4Vlz5LR+9AbM3pRZrAwe0P1ONS5IFEccsoR6m7dSvtjKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z/O0tCZq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Um8rHPR+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Se6u6ITF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wpWcGD0Q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z/O0tCZq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Um8rHPR+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Se6u6ITF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wpWcGD0Q"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E06BD21256;
	Tue, 22 Apr 2025 06:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745301752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mr0DlxgFeOpu1A+yZ5L7HTqrKQLRWl2A8HPP2Ky4ct8=;
	b=z/O0tCZqIUFQk2o1IuD2gaLd5Gfer/A0nCY7MaQ4EG+GAZNqHqv9PgTDhIn6USb/Vnf9II
	BWJnuJEVQBR148DwxXm1AOTq1zIZz2cj0sR/Eg/MOxH3ZeUH/sF1V93gzUgULCZgHnctmL
	kue/lrWymzK2FTFDRa0IZuG+ehVKUyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745301752;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mr0DlxgFeOpu1A+yZ5L7HTqrKQLRWl2A8HPP2Ky4ct8=;
	b=Um8rHPR+BszmmcpMyoLeHDNXvwf4eKdBLcs10TTtNLQdfJemUd21wfC5sPa6o44rje/ECg
	3+WxBLL0UlmJ+KBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745301751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mr0DlxgFeOpu1A+yZ5L7HTqrKQLRWl2A8HPP2Ky4ct8=;
	b=Se6u6ITFF+cEfz1wDKdNC3RIfevZCHj4f/SCKzqGq5Q49IfvhrVUwkusicSw9WgAud1ViP
	WJznMvCQ5hNVIZN68hlQ0JmwOK6li+1PXvga23V1LIxfpQKfZ3lbFz2dyOKKvi+jSdwPX/
	ZhtjW5sk6SMCzn28Agm48ouq0Pnmi+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745301751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mr0DlxgFeOpu1A+yZ5L7HTqrKQLRWl2A8HPP2Ky4ct8=;
	b=wpWcGD0QsbyXQAhBMzaJzlkXH11loCIf2rsctYoIICZhOlVgzbbxTWia2TCVWQraLyp8al
	pqKc0I9rM/B/IcBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 989CA139D5;
	Tue, 22 Apr 2025 06:02:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id czNYI/cwB2j6IQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Apr 2025 06:02:31 +0000
Message-ID: <0f5c9c9a-428c-43a9-a942-b8701a561cde@suse.de>
Date: Tue, 22 Apr 2025 08:02:31 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 03/20] block: don't call freeze queue in
 elevator_switch() and elevator_disable()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-4-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250418163708.442085-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 4/18/25 18:36, Ming Lei wrote:
> Both elevator_switch() and elevator_disable() are called from sysfs
> store and updating nr_hw_queue code paths only.
> 
> And in the two code paths, queue has been frozen already, so don't call
> freeze queue in the two functions.
> 
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/elevator.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
