Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3D738BF81
	for <linux-block@vger.kernel.org>; Mon,  2 Feb 2026 23:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770073814; cv=none; b=gdG6Pw/Uqidx5JSm2QbZPbufYDD3j3pie7Wla2uv0O8siqKhzlWgjyzHUo46AWKpDbbcu5jL0cYdtFSq6B/tx5lxp3+0xfPGR4PpBvx/ixEXbbnr8Mz/mg7+FjSmAmWsPxiYQkvhRXrBHNoVhk5H5vG0fE1+CZNID1hR18Z20AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770073814; c=relaxed/simple;
	bh=Gf4+yrT0scPtIob8mcQ8ruhg+64bB2an4UcMHsLhKWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RtTM/ldMnhFKOYmK5JfX+jyQUMKqHXO5uOrb/nY0gRFDtCToYWZypRdxmTug1hY1xwSisPpnmBCyjYX0C+GPo0dhieo55t6GMelmHZ71scLEoMfe5KoSS1qOvSPfbWx3XfcU04AY1CXUCpSy3QcoxYMSSpX52OPhl8fg0aYYJsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NY6cDX1f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8NFBPb4n; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NY6cDX1f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8NFBPb4n; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NY6cDX1f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8NFBPb4n";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NY6cDX1f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8NFBPb4n"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D2795BCC6;
	Mon,  2 Feb 2026 23:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770073810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkIyPfQ78a8ufAa7SVjJKLERJSLrFDF34NqEMQoHruo=;
	b=NY6cDX1fRxXC91VFhwyMcSrqNmpZyKXVEoJpDx6QoPAk18sOLOn6JL5jdXdQKwpFrNTA07
	nAEH8CLvLIHhMz+rp49khXMwH0L00mnN3DsNe4Q7mr6LoQRxuN2sPlbAjRBtlmtbu2THTz
	/zNaHuLyLkPEfCs56XtTi0gWOPIC3dQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770073810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkIyPfQ78a8ufAa7SVjJKLERJSLrFDF34NqEMQoHruo=;
	b=8NFBPb4nVpHm63yWrEnWj+nh7OhDZdeuEBHeFaUK84+np1CG2kS5CLPUS79v6AQ7Vp74kR
	5CIczzZJ9hDvK8BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770073810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkIyPfQ78a8ufAa7SVjJKLERJSLrFDF34NqEMQoHruo=;
	b=NY6cDX1fRxXC91VFhwyMcSrqNmpZyKXVEoJpDx6QoPAk18sOLOn6JL5jdXdQKwpFrNTA07
	nAEH8CLvLIHhMz+rp49khXMwH0L00mnN3DsNe4Q7mr6LoQRxuN2sPlbAjRBtlmtbu2THTz
	/zNaHuLyLkPEfCs56XtTi0gWOPIC3dQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770073810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkIyPfQ78a8ufAa7SVjJKLERJSLrFDF34NqEMQoHruo=;
	b=8NFBPb4nVpHm63yWrEnWj+nh7OhDZdeuEBHeFaUK84+np1CG2kS5CLPUS79v6AQ7Vp74kR
	5CIczzZJ9hDvK8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F91C3EA62;
	Mon,  2 Feb 2026 23:10:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Bl7sNtAugWnuNAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Feb 2026 23:10:08 +0000
Message-ID: <2257486e-a52d-4b11-bf09-e2adedf2decb@suse.de>
Date: Tue, 3 Feb 2026 00:10:05 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM?BFP TOPIC] Block-layer device resets
To: Bart Van Assche <bvanassche@acm.org>,
 lsf-pc <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
 <923b3b4d-a84e-4a19-8767-6bca59204ff1@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <923b3b4d-a84e-4a19-8767-6bca59204ff1@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 2/2/26 18:27, Bart Van Assche wrote:
> On 2/1/26 9:06 AM, Hannes Reinecke wrote:
>> While we could easily terminate the controller, the specification
>> also requires us to terminate all outstanding commands.
> What specification is the above referring to?
> 
> Regarding terminating outstanding commands, doesn't how to do this
> depend on the storage protocol? Isn't the recommended procedure for
> NVMe to delete and re-create all I/O submission and completion queues?
> This procedure doesn't require support in the block layer for aborting
> individual commands.
> 
Sure, all drivers/subsystems implement a similar mechanism. But this is
pretty much implementation specific, and typically wrapped into the
device teardown path.
But that typically also involves tearing down and re-creating the device
node which doesn't lend itself for some configurations.

This proposal is to ensure that all I/O is flushed from the device
without having to reconfigure anything; typical use-case would be
when this device is used as a backing device for a nvmet namespace.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
