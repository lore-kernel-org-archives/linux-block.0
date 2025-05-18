Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148031D5165
	for <linux-block@vger.kernel.org>; Sun, 18 May 2025 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747567558; cv=none; b=ccy7JoCezW2WF6b6y5NywfD+HxvgvIXwe6VJ/kqYxULwTn+iVTscewPAR3GFptATu/y964a0kmpzl9qFIDAvXRY7EkYC2exQLPqrY0suFRpe1ZVBPA73qSEyevqOIHQX5K6uAMRkFkN3QFEWTV2UZufE6zmAXYr8ZWy9CZ430ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747567558; c=relaxed/simple;
	bh=K4ud0oQtFLhWshvvJQQInqLa7E1eEMKsxJaXyXAGW+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=StR9EnRhFcE5O+MoGemdkA+FgXXbWI9Dgsztaj0TfCo5Fq+5mvjC9ZnXI4wof3pcdoBiGo52Qz94vIWJJTrRnZjhcc5BX6Mcn8wkU6jOOyNoAC9Et9Xthux+q84dp5SX9erb1houZh6kvK5cDKCsOLnAz9x3IZUxu6t5G3rzXMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zGhTJZ/o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GLokBfVU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SguQP8cd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=27d7mBZQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zGhTJZ/o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GLokBfVU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SguQP8cd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="27d7mBZQ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C71002212F;
	Sun, 18 May 2025 11:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747567547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVotmFrRw7S6uv+MCVusAFu5PtN9XD5eaJlI5bCEF+Q=;
	b=zGhTJZ/oyueY4umA1d7Lg84QKJ9sq3sCXhHXl2T76I8ASqnkMWv3s/j809+5Tag422YYBJ
	lc/ScZNLjmGnryIFJW5K3lthuxgJphvK/9K53WmZcbHY7nx5eLOO7TSOvnQ5LYF9wSPpc2
	XD8nIKeinGaBm+AUJU38/Ag6/1sKUhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747567547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVotmFrRw7S6uv+MCVusAFu5PtN9XD5eaJlI5bCEF+Q=;
	b=GLokBfVU5MnR7UPHT+dY/MQ7ttSZgP0qyNmk0ovDvMHXng/m20KIrPc9KQdtW6Bwxy5uLx
	4pV5medLV4XSbaCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747567546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVotmFrRw7S6uv+MCVusAFu5PtN9XD5eaJlI5bCEF+Q=;
	b=SguQP8cdLy2Tj8E7YvUptQbCdGhMmAISIH6NXZLDmoiCtqpvyjuhWVw5YgKjUt0rGgBktt
	o8UbLcDXXmB6pSncVCLO80EbIrlMVmbFtZP+xk3eINXKIp/cbOoeE1IxpGPk3nDnuazdMT
	sPcTcWc/D6DRmFwulsWCqDHamc0mfCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747567546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVotmFrRw7S6uv+MCVusAFu5PtN9XD5eaJlI5bCEF+Q=;
	b=27d7mBZQgOlghlYnJ1BMK1RefkP5zJ4A0p7TXBXEE35kbeykJLRkGHk/JQuQZ9sO5l8J9r
	ogdyB19Fb5lCWIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 828011334C;
	Sun, 18 May 2025 11:25:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mqspHbrDKWjOFwAAD6G6ig
	(envelope-from <hare@suse.de>); Sun, 18 May 2025 11:25:46 +0000
Message-ID: <635f3315-a77b-4e8b-8454-20cb7c9ae2e8@suse.de>
Date: Sun, 18 May 2025 13:25:46 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] nvme/063 failure (tcp transport)
To: Sagi Grimberg <sagi@grimberg.me>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm>
 <72a394aa-9ed1-45ec-8aaf-5f5ccf1c18ab@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <72a394aa-9ed1-45ec-8aaf-5f5ccf1c18ab@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 5/18/25 12:01, Sagi Grimberg wrote:
> 
> 
> On 16/05/2025 15:31, Shinichiro Kawasaki wrote:
>> Hello all,
>>
>> Using the kernel v6.15-rc6 and the latest blktests (git hash 
>> 613b8377e4d3), I
>> observe the test case nvme/063 fails with tcp transport. Kernel 
>> reported WARN in
>> blk_mq_unquiesce_queue and KASAN sauf in blk_mq_queue_tag_busy_iter 
>> [1]. The
>> failure is recreated in stable manner on my test nodes.
>>
>> The test case script had a bug then this failure was not found until 
>> the bug get
>> fixed. I tried the kernel v6.15-rc1, and observed the same failure 
>> symptom. This
>> test case cannot be run with the kernel v6.14, since it does not have 
>> secure
>> concatenation feature.
>>
>> Actions for fix will be appreciated.
> 
> Hannes, did you encounter this?
> 
No; I would think it's an artifact due to multipath not being enabled.
Shin'ichiro, can you reproduce it with CONFIG_NVME_MULTIPATH on?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
