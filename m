Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F8F2741C6
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 05:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745905763; cv=none; b=j9khbMJ9dnRhVS0ysN9eoJzjH/bbCIncB2wadN+UaM+PSh2hNouQrvshc3BDAIotFtDk6wTGnlmUjHmXKadiwZ07vEPrW9lDiwdSnMPmXeqz7Wpigek8xEgmqR9SdEORTZ7iwluT1dm2sQObdlAxCkJRnAaLl7senJ79yuA61DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745905763; c=relaxed/simple;
	bh=sUIKaA1DayQaMOb971xMIfhFu+hajbs/SQU7ocMW0QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ja46AOGwkR6dC8IkVgok2O8jMlM1AwMvnhFNQD9Ij2Jv+keLL0KhcDfFQyPtPB798cYjXcek3FyFP4pOLwkBFpeNfF5zDPmqNEazJN7VrvvHzKvDUNCmeEx+HxVehThfX/ZBvqk5nBx3KPTu+J0gt2UiNGPhKnRDFkpzlHEzGLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pfb6NHHD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h/Thtx2K; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pfb6NHHD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h/Thtx2K; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pfb6NHHD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h/Thtx2K";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pfb6NHHD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h/Thtx2K"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 705CA219AB;
	Tue, 29 Apr 2025 05:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745905758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MzV4gmYooaTnfYptyMOrMTVYCdZ9yWhpgxF9mnX8wDI=;
	b=pfb6NHHDwdUmq0YfJoqFb7MUFk5MKIjL0l4WA1sCP9fFx2B+Jsi1bv7w3hsO22iQ/fIXc3
	EvSVv+AG5kGwy62z9wyJJuYtmwwDPQZGF0wwkCgE93WvDNN/8K9gZov3bip51pCw4qFZYe
	V4uZAoAOI7Zf/Dan8Js09FKVwcdApTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745905758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MzV4gmYooaTnfYptyMOrMTVYCdZ9yWhpgxF9mnX8wDI=;
	b=h/Thtx2KfWKMcSygRlp4w5CbVQ7nChr1+7JTveuMQkTsYLrBBxDkq7jWq4cqAhjQHp+XVh
	RaUlPMm2rW05K8Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pfb6NHHD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="h/Thtx2K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745905758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MzV4gmYooaTnfYptyMOrMTVYCdZ9yWhpgxF9mnX8wDI=;
	b=pfb6NHHDwdUmq0YfJoqFb7MUFk5MKIjL0l4WA1sCP9fFx2B+Jsi1bv7w3hsO22iQ/fIXc3
	EvSVv+AG5kGwy62z9wyJJuYtmwwDPQZGF0wwkCgE93WvDNN/8K9gZov3bip51pCw4qFZYe
	V4uZAoAOI7Zf/Dan8Js09FKVwcdApTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745905758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MzV4gmYooaTnfYptyMOrMTVYCdZ9yWhpgxF9mnX8wDI=;
	b=h/Thtx2KfWKMcSygRlp4w5CbVQ7nChr1+7JTveuMQkTsYLrBBxDkq7jWq4cqAhjQHp+XVh
	RaUlPMm2rW05K8Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 107DF1340C;
	Tue, 29 Apr 2025 05:49:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FOqxAV5oEGjWVQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 29 Apr 2025 05:49:18 +0000
Message-ID: <89f3680d-442e-47cc-822e-f00f474dd597@suse.de>
Date: Tue, 29 Apr 2025 07:49:17 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 2/3] nvme: introduce multipath_head_always module
 param
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, jmeneghi@redhat.com,
 axboe@kernel.dk, martin.petersen@oracle.com, gjoyce@ibm.com
References: <20250425103319.1185884-1-nilay@linux.ibm.com>
 <20250425103319.1185884-3-nilay@linux.ibm.com>
 <38a93938-8a9c-4d6a-9f74-af1aa957fd74@suse.de>
 <a33c691a-d4f6-4cd8-96e0-17e2e4078d37@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <a33c691a-d4f6-4cd8-96e0-17e2e4078d37@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 705CA219AB
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/28/25 09:39, Nilay Shroff wrote:
> 
> 
> On 4/28/25 12:27 PM, Hannes Reinecke wrote:
>> On 4/25/25 12:33, Nilay Shroff wrote:
>>> Currently, a multipath head disk node is not created for single-ported
>>> NVMe adapters or private namespaces. However, creating a head node in
>>> these cases can help transparently handle transient PCIe link failures.
>>> Without a head node, features like delayed removal cannot be leveraged,
>>> making it difficult to tolerate such link failures. To address this,
>>> this commit introduces nvme_core module parameter multipath_head_always.
>>>
>>> When this param is set to true, it forces the creation of a multipath
>>> head node regardless NVMe disk or namespace type. So this option allows
>>> the use of delayed removal of head node functionality even for single-
>>> ported NVMe disks and private namespaces and thus helps transparently
>>> handling transient PCIe link failures.
>>>
>>> By default multipath_head_always is set to false, thus preserving the
>>> existing behavior. Setting it to true enables improved fault tolerance
>>> in PCIe setups. Moreover, please note that enabling this option would
>>> also implicitly enable nvme_core.multipath.
>>>
>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>> ---
>>>    drivers/nvme/host/multipath.c | 70 +++++++++++++++++++++++++++++++----
>>>    1 file changed, 63 insertions(+), 7 deletions(-)
>>>
>> I really would model this according to dm-multipath where we have the
>> 'fail_if_no_path' flag.
>> This can be set for PCIe devices to retain the current behaviour
>> (which we need for things like 'md' on top of NVMe) whenever the
>> this flag is set.
>>
> Okay so you meant that when sysfs attribute "delayed_removal_secs"
> under head disk node is _NOT_ configured (or delayed_removal_secs
> is set to zero) we have internal flag "fail_if_no_path" is set to
> true. However in other case when "delayed_removal_secs" is set to
> a non-zero value we set "fail_if_no_path" to false. Is that correct?
> 
Don't make it overly complicated.
'fail_if_no_path' (and the inverse 'queue_if_no_path') can both be
mapped onto delayed_removal_secs; if the value is '0' then the head
disk is immediately removed (the 'fail_if_no_path' case), and if it's
-1 it is never removed (the 'queue_if_no_path' case).

Question, though: How does it interact with the existing 
'ctrl_loss_tmo'? Both describe essentially the same situation...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
