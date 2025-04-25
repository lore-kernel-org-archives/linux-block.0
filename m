Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD58197A76
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 06:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745563195; cv=none; b=mSMkHDNyIDZg//fQCQQtdgHhgKG4A70Fu4CPo3LzKIqY9V0Gh0BfTI/cltq3s+V99OQ7HA8q73eJkv50mDb92ge3Xmz1qe540EPR10p5rr2fwQzo5lHytVU8DySBmVIZlxXQoxmtYXTHfaMSaZ9kTkHoH7qPWcEe4tU0BgYIdXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745563195; c=relaxed/simple;
	bh=5nTNRIOWB7cJYrYs7dIhj5RW3WPemDBwPTOTmA92AHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hr2SlOzclhK8t2068vnw1kmhqs7ciM8rpoW3PKu17f3u94Lvulklji3knEA93sgI2NIWhIYx6sRsc/1ycqn3sfROUEhscfKDfIX4ZseWBIA0LYVeGw6JW8BAyqRCqFAv2tnfoX0cU5FJSUyByI43hGOa8zeOyRdWWzTv7ltYsNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XQ4DuASe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g1vhrzrj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XQ4DuASe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g1vhrzrj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XQ4DuASe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g1vhrzrj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XQ4DuASe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g1vhrzrj"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A6E71F38C;
	Fri, 25 Apr 2025 06:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745563192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cFH5hYzngFQj/C9Vt2FcDINQos83iPEIDy7FTYePEis=;
	b=XQ4DuASeEzBAorl3whYAq+UyGa55YqXN6SY/fltgcKISsQrZKji321l3hIQdWGrgGXD5rc
	5Ei1MrMAZR/I4O+z3vmGM2z/XvKOJ+GuZ1LYhdB0l97tuuTEAtLZy07ogveP9ETRd8INS4
	BQsip3sbGhsVPCvl5BG8HSaq6vJpfv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745563192;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cFH5hYzngFQj/C9Vt2FcDINQos83iPEIDy7FTYePEis=;
	b=g1vhrzrjELefWbnJblxFGDJT+PWaUMCNlgIZ5ArWKkG72v57UX1LBrSserwBeHIJ+qtjop
	vFJ5SsSEJ0wUT0BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XQ4DuASe;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=g1vhrzrj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745563192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cFH5hYzngFQj/C9Vt2FcDINQos83iPEIDy7FTYePEis=;
	b=XQ4DuASeEzBAorl3whYAq+UyGa55YqXN6SY/fltgcKISsQrZKji321l3hIQdWGrgGXD5rc
	5Ei1MrMAZR/I4O+z3vmGM2z/XvKOJ+GuZ1LYhdB0l97tuuTEAtLZy07ogveP9ETRd8INS4
	BQsip3sbGhsVPCvl5BG8HSaq6vJpfv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745563192;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cFH5hYzngFQj/C9Vt2FcDINQos83iPEIDy7FTYePEis=;
	b=g1vhrzrjELefWbnJblxFGDJT+PWaUMCNlgIZ5ArWKkG72v57UX1LBrSserwBeHIJ+qtjop
	vFJ5SsSEJ0wUT0BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D533A13A80;
	Fri, 25 Apr 2025 06:39:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uOaoMTcuC2i9YQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 25 Apr 2025 06:39:51 +0000
Message-ID: <f711fb22-a6c8-43fd-b581-bb9afa6f9db1@suse.de>
Date: Fri, 25 Apr 2025 08:39:51 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 13/20] block: unifying elevator change
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-14-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250424152148.1066220-14-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2A6E71F38C
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/24/25 17:21, Ming Lei wrote:
> elevator change is one well-define behavior:
> 
> - tear down current elevator if it exists
> 
> - setup new elevator
> 
> It is supposed to cover any case for changing elevator by single
> internal API, typically the following cases:
> 
> - setup default elevator in add_disk()
> 
> - switch to none in del_disk()
> 
> - reset elevator in blk_mq_update_nr_hw_queues()
> 
> - switch elevator in sysfs `store` elevator attribute
> 
> This patch uses elevator_change() to cover all above cases:
> 
> - every elevator switch is serialized with each other: add_disk/del_disk/
> store elevator is serialized already, blk_mq_update_nr_hw_queues() uses
> srcu for syncing with the other three cases
> 
> - for both add_disk()/del_disk(), queue freeze works at atomic mode
> or has been froze, so the freeze in elevator_change() won't add extra
> delay
> 
> - `struct elev_change_ctx` instance holds any info for changing elevator
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-sysfs.c |  18 +++-----
>   block/blk.h       |   5 +-
>   block/elevator.c  | 114 +++++++++++++++++++++++++---------------------
>   block/genhd.c     |  28 ++----------
>   4 files changed, 75 insertions(+), 90 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
