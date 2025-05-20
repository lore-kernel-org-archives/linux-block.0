Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056402673B5
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 11:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741532; cv=none; b=LzVSPSpU99+3bhI5H98y0aDFtBh4O1eL8X+8tWbEH59uw/nlO0dswBmKmy45Nijlp1a0pxkl+aD7/xqMm/6xDkTfuJ7/jUbPCokvbMDmF7vd7fwR33uo7vslwYlW0iZZChssFeGWQKrFpVx/FJNNqrXRG0zDLJRHoRUnoNj49N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741532; c=relaxed/simple;
	bh=c1d1rr2QNL+WaSUE94VKWBfzEoqCg0L9aStGaaKaI1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QD5JpNlSg9+dgO1dcKmai6B/vcKBSZvgMd2MmuPXyuXL1AP6F8ZYLlw9wWLPopPhN9ElUZyD+3s6KHOx3Xeh4jAO6RfVa+9t0lHda8vpVhe9hHrd84I8MZMy3q9Fkd0S+07xCoZ4zG2pIGbXLsRG5zm4PtrRgeSik7CR9nYL300=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UcbvN0HY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=McTTgkmt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=15z+ALjw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Wb/IY+39; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UcbvN0HY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="McTTgkmt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="15z+ALjw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wb/IY+39"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E89F220687;
	Tue, 20 May 2025 11:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747741529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v79mAH0fQ8XwCkMiZBcFEcVG38jLqH2Y96+WO4NsMSM=;
	b=UcbvN0HYMTaNwJQLgft169UA8c5YIMggryjSKiXkhUUyCaOr+TGHUuBsrjLQJt6MgRe4Tz
	XJCI5cj1SJ/J2NCuEAqP0DcMk24wsLFA6QWKR/0zARrHLso8OpnQ5kknRWeqi8L37RuLw5
	KOn0Mq+UqNJ9Ok8p/iyQBl6XbDBKK64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747741529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v79mAH0fQ8XwCkMiZBcFEcVG38jLqH2Y96+WO4NsMSM=;
	b=McTTgkmtJULFIoX9+1hJFHCKBbaGt8o5saXrGhiVcGHoWihkU3JNTw089Iq2a7Eiu41gvb
	yMgVo55GlXeYANCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=15z+ALjw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Wb/IY+39"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747741527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v79mAH0fQ8XwCkMiZBcFEcVG38jLqH2Y96+WO4NsMSM=;
	b=15z+ALjwicFXJewlGbgKpOpJFXua56Vh09ncLwYmfS1ARdr98xSr6CcCAo32zp/sVPsDRz
	3WcNM7d64QdiYHFQVhc3snnkhoGCRD7siH3EXsYfoppCaJxi4UCUH4BPb0fYUYc+k0VC/w
	AXmMg8qbD4s2FuM5ubFRJvxdhpy2d5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747741527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v79mAH0fQ8XwCkMiZBcFEcVG38jLqH2Y96+WO4NsMSM=;
	b=Wb/IY+39Jt6qWXK2ow7s12LEbztRskosWmARsMMrWGu5ISnpoKrU5mELqeTSdfHfxr2VYJ
	HNC+h5FItLg72OAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE55213A3E;
	Tue, 20 May 2025 11:45:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W3iFMVdrLGiPfAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 20 May 2025 11:45:27 +0000
Message-ID: <f540dd31-75f6-4e1c-9bee-304530984610@suse.de>
Date: Tue, 20 May 2025 13:45:12 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] nvme/063 failure (tcp transport)
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm>
 <72a394aa-9ed1-45ec-8aaf-5f5ccf1c18ab@grimberg.me>
 <635f3315-a77b-4e8b-8454-20cb7c9ae2e8@suse.de>
 <3ef6roj5exuktcobnailtjstndhnyyw264y7uwzhtuaaptst5n@gl6id4fhjhcu>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <3ef6roj5exuktcobnailtjstndhnyyw264y7uwzhtuaaptst5n@gl6id4fhjhcu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spam-Level: 
X-Rspamd-Queue-Id: E89F220687
X-Spam-Score: -1.51
X-Spam-Flag: NO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On 5/19/25 04:53, Shinichiro Kawasaki wrote:
> On May 18, 2025 / 13:25, Hannes Reinecke wrote:
>> On 5/18/25 12:01, Sagi Grimberg wrote:
>>>
>>>
>>> On 16/05/2025 15:31, Shinichiro Kawasaki wrote:
>>>> Hello all,
>>>>
>>>> Using the kernel v6.15-rc6 and the latest blktests (git hash
>>>> 613b8377e4d3), I
>>>> observe the test case nvme/063 fails with tcp transport. Kernel
>>>> reported WARN in
>>>> blk_mq_unquiesce_queue and KASAN sauf in blk_mq_queue_tag_busy_iter
>>>> [1]. The
>>>> failure is recreated in stable manner on my test nodes.
>>>>
>>>> The test case script had a bug then this failure was not found until
>>>> the bug get
>>>> fixed. I tried the kernel v6.15-rc1, and observed the same failure
>>>> symptom. This
>>>> test case cannot be run with the kernel v6.14, since it does not
>>>> have secure
>>>> concatenation feature.
>>>>
>>>> Actions for fix will be appreciated.
>>>
>>> Hannes, did you encounter this?
>>>
>> No; I would think it's an artifact due to multipath not being enabled.
>> Shin'ichiro, can you reproduce it with CONFIG_NVME_MULTIPATH on?
> 
> I tried both CONFIG_NVME_MULTIPATH on and off, and the failure was recreated
> regardless of the config value. Of note is that sometimes it is recreated at
> the first test case run, and sometimes it is required to repeat the test case a
> few times.
> 
> FYI, I attached the kernel config which I used to recreate the failure.

Hmm.
Can you check with this patch (on top of the previous one):


diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 55569eb7770b..43d86e8c6df3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2197,6 +2197,7 @@ static int nvme_tcp_configure_io_queues(struct 
nvme_ctrl *ctrl, bool new)
                 blk_mq_update_nr_hw_queues(ctrl->tagset,
                         ctrl->queue_count - 1);
                 nvme_unfreeze(ctrl);
+               nvme_quiesce_io_queues(ctrl);
         }

         /*

Thanks.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
