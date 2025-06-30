Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E668917BD3
	for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264266; cv=none; b=V5clgekZzYPVZoSLa0XJC/idWFg/duemquv0tchzoN75XxEiUvBYcPu1ChSMiRhohkX0guVbqj8CbzrlnFJ8ilr45M09o/fM6ay5MGEn9MVKqrl86u1iscuf0UI7K7sSWsrf7Yu0qCKbtSe+H0jWXI47SuiINZhRTLGLEBtnKRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264266; c=relaxed/simple;
	bh=53ZRlI3TeXAkr/jdrNXDqLBjXykZPhMJOy3HhCADVfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kh4ClyHCcVuO2jh5A4Z1g6nAbYTse8aIFs2EbQFbqjkj8KIYzMkPnYXZNziPrUuQYUkaMIIwzXXO3qusKuxJYjyKwwmOV8NDP9myXWEraqCfvGnoT7VoTRsJhdaUSY8qnv8C8bU566YmIAd1rlNisBR9m4AJtMqMGlcOP/s1pSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uTNikOX4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J+EXkzjG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uTNikOX4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J+EXkzjG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uTNikOX4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J+EXkzjG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uTNikOX4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J+EXkzjG"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F20642115F;
	Mon, 30 Jun 2025 06:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751264262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AbVPXebk8X1iHMCOJaynubTr36GLfby9Wwr/ELbrVuo=;
	b=uTNikOX4ucJkECAzRdVn5W7UNAIb73xdWrzePPzymlHfuK+dFH82HQ5TKsmbRSrb2QfIlc
	3aXAkXb11wqiSt9EYFQq2WCLgZmygw1ky9DHyYxgbZhk8nfEtaqedhBOvEc53GCDJp99r1
	T5U80aDTeYZ6S1VpVewbgZ84VHHMrAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751264262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AbVPXebk8X1iHMCOJaynubTr36GLfby9Wwr/ELbrVuo=;
	b=J+EXkzjGXDPuy5VapNopBzJ0SzQPG4GckteEIYq0PH2paNpI0B/0sph5H71WhhnA8C1PJu
	9d+k/1+ZEWqkMjCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uTNikOX4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=J+EXkzjG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751264262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AbVPXebk8X1iHMCOJaynubTr36GLfby9Wwr/ELbrVuo=;
	b=uTNikOX4ucJkECAzRdVn5W7UNAIb73xdWrzePPzymlHfuK+dFH82HQ5TKsmbRSrb2QfIlc
	3aXAkXb11wqiSt9EYFQq2WCLgZmygw1ky9DHyYxgbZhk8nfEtaqedhBOvEc53GCDJp99r1
	T5U80aDTeYZ6S1VpVewbgZ84VHHMrAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751264262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AbVPXebk8X1iHMCOJaynubTr36GLfby9Wwr/ELbrVuo=;
	b=J+EXkzjGXDPuy5VapNopBzJ0SzQPG4GckteEIYq0PH2paNpI0B/0sph5H71WhhnA8C1PJu
	9d+k/1+ZEWqkMjCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EB4013983;
	Mon, 30 Jun 2025 06:17:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wBOkJAUsYmi4VAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 30 Jun 2025 06:17:41 +0000
Message-ID: <398da491-79a4-4a22-b2d8-6092aaa6da79@suse.de>
Date: Mon, 30 Jun 2025 08:17:41 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 1/3] block: move elevator queue allocation logic into
 blk_mq_init_sched
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk, sth@linux.ibm.com,
 lkp@intel.com, gjoyce@ibm.com
References: <20250630054756.54532-1-nilay@linux.ibm.com>
 <20250630054756.54532-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250630054756.54532-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F20642115F
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51
X-Spam-Level: 

On 6/30/25 07:21, Nilay Shroff wrote:
> In preparation for allocating sched_tags before freezing the request
> queue and acquiring ->elevator_lock, move the elevator queue allocation
> logic from the elevator ops ->init_sched callback into blk_mq_init_sched.
> As elevator_alloc is now only invoked from block layer core, we don't
> need to export it, so unexport elevator_alloc function.
> 
> This refactoring provides a centralized location for elevator queue
> initialization, which makes it easier to store pre-allocated sched_tags
> in the struct elevator_queue during later changes.
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/bfq-iosched.c   | 13 +++----------
>   block/blk-mq-sched.c  | 11 ++++++++---
>   block/elevator.c      |  1 -
>   block/elevator.h      |  2 +-
>   block/kyber-iosched.c | 11 ++---------
>   block/mq-deadline.c   | 14 ++------------
>   6 files changed, 16 insertions(+), 36 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
