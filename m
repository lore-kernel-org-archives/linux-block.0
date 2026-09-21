Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3989444A730;
	Mon, 21 Sep 2026 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981191; cv=none; b=Eu0CxVmU4kB2v1DoFDqzZj43LqwlubV449KvTVJmqvrYjPnIyQlzY9Etec3fnUFnzbV6DBudmbvCI9Mn/gLcyXyRkHU2/pxg9C5L8ALFatIx/eVIKZ5tj3gz3HdROdLNGk+keSd2RPOTOCfmzCOjqDegsYzDcX0gWsg5/8thskM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981191; c=relaxed/simple;
	bh=9NTPFYO9+TwpiFyel6iI5IaZzEyVbH2xHZ8DKrUFgcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOhWwyD6X/tOGuYT7/DT41VfqqYi/TnRfpvF7d7TRW2fvyTAIlhchwA9l2WaOTtgUrNQi01awf1886Jog1/iRSFIEhVmoQRwPd7KayyP7dZEq3dFNmxJvhSdeMAZN7/tzK56NkCsCRGMyWCFpVlWTo3Dnvq7ejtywq7eEeGwICc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MUsNe7Kk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z9XLB6OO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YEh/A/mp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fdKth+eR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MUsNe7Kk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z9XLB6OO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YEh/A/mp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fdKth+eR"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB423219F1;
	Mon, 21 Sep 2026 08:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789981184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+WgP2p/OiA1lkjOPB9vNnBxmDRzRFy6x4ytQkZ9Ado=;
	b=MUsNe7KkebeCHmLt5iJ25kUikW9GHNuuFF+PlA9eaF+imC7mHXq7h4BQwJoAxrN7xABQM1
	8YiXcJn7QjNGOnt1JCgf6fxl7JIKqD0oH1Rne2slQOoHpNu2XW7vUMsEK8zM9Wv3FVk818
	O1KCjFo4xwg4nn8xZIuBGyy3vxdxA8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789981184;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+WgP2p/OiA1lkjOPB9vNnBxmDRzRFy6x4ytQkZ9Ado=;
	b=z9XLB6OO24pARwQcwM/FHPvuzVVlQU00HIinXhxVNSHj6xm4ieVN+/LR/k3ckxjjUleCR7
	Bmio0r8NaNPpilBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="YEh/A/mp";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fdKth+eR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789981179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+WgP2p/OiA1lkjOPB9vNnBxmDRzRFy6x4ytQkZ9Ado=;
	b=YEh/A/mp9UzZq0Zd+ZI+ANdSNYrgyoSzEDoLLmgKwWiFaabq0gKI1EDq/cNTKNmeNAcVSj
	Y9zbMdwbtO2RtbaIBG7RT299Cde93fms7ABcoWbHEQlp8qJ+q2zkxbZqpb28xeBegKNgzM
	gj3Rq24A4G9FQVfnFauJ/PyJWXCoBiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789981179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+WgP2p/OiA1lkjOPB9vNnBxmDRzRFy6x4ytQkZ9Ado=;
	b=fdKth+eRdjmNvPVjr79A27/fTRk+FYnr0hgjMDyFxQC9lEUOwYF/I0nRr+6Yc4Ybx7mhGr
	wFZbc3Wf1xBMcqBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 944FD13793;
	Mon, 21 Sep 2026 08:59:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BRbxFfvxsGouWQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Sep 2026 08:59:39 +0000
Message-ID: <ad45110f-2497-43e7-9846-3e2dc56c6079@suse.de>
Date: Mon, 21 Sep 2026 10:59:38 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ublk: consequences of a dead server are only failing on the last
 /dev/ublkcN release
To: Ming Lei <tom.leiming@gmail.com>, Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, Chris Mason <mason@kernel.org>
References: <20260918-eisbrecher-toilette-worum-eb11f777c563@brauner>
 <aq_iJpAgRi9ZfnOg@fedora-laptop>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aq_iJpAgRi9ZfnOg@fedora-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -5.51
X-Rspamd-Queue-Id: EB423219F1
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

On 9/20/26 3:39 PM, Ming Lei wrote:
> Hello,
> 
> On Fri, Sep 18, 2026 at 12:29:22PM +0200, Christian Brauner wrote:
>> Hi,
>>
[ .. ]
>> The commit 7fc4da6a304b ("ublk: scan partition in async way") made
>> partition scans run from a workqueue that holds disk->open_mutex while
>> the server serves its reads and START_DEV returns before it's finished.
>>
>> Any server that treats START_DEV's return as a signal that the disk is
>> ready and doesn't serve requests hangs every open() of /dev/ublkbN on
>> uninterruptible on open_mutex. You can combine that with (1) and (2).
> 
> START_DEV doesn't promise partitions scanning done when it is returned.
> 
> nvme multipath has similar usage too.
> 
Indeed, we hit the same issue with nvme. We got it fixed by commit
1f021341eef41e77a633186e9be5223de2ce5d48 ('nvme-multipath: defer 
partition scanning'), essentially suppress partition scan during
probing, and move the partition scan to a work thread. That way
probing can continue (even if partition scan is blocked), and
a failed probe can correctly abort partition scanning.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
