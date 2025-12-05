Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D4A27F00A
	for <linux-block@vger.kernel.org>; Fri,  5 Dec 2025 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764922520; cv=none; b=RbNHspzPLOaqWgv9U3NvzPrztHDTwhfU59V0O8EHupVnRHWpd7oSvNtxj3pq6aNcSi+ORXew2uiPHcofYP1obZkRu1okR77zIMO6FeXigFkuDhkjpyj3yNroZ2+QzltUtF2AaKW4zGFOBu0yVlG29uanmK12wXj1ND0j8sFwHnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764922520; c=relaxed/simple;
	bh=xwiVecgt1sLDYfV+QEgdpoP1LUTUXUzksYnF7YkxbTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UyncOgnGUhjPh8LUfcBRt7nB9FxDizFjTf4fwHqxKnV7DS4G0pPPEZM6a2nXZuERrUYJKvof14rOfwEP5W8/Y0/z8QXbp6/OPUTE6s8Jsfz//ikFCOcKD8fOLKD7u5eeMjgU39SXGaxSeQ1xo1H4bqvbZKeoQQkvp+++I1Ra76s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t1jce6GR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YpnOsifs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z8tGcheH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y7mnHG4x; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t1jce6GR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YpnOsifs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z8tGcheH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y7mnHG4x"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AFC3F336CD;
	Fri,  5 Dec 2025 08:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764922507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4+NBn5xZiXZq84M6fBwyTKsyKKa+lPaIlWOSdiCedw=;
	b=t1jce6GR2x/cQq+ZayWmBdHGqP7PT/KVNlpTdjUmtnQ3GCJmIkrtDsDzUd3cJTBLUk1YD/
	oqu9Pb8cjw7yr8ukr4ryHg7wvHCYblwLxZXVY7gQoSpVXQ8y+747DVWIaj6Cwx7atBYYx+
	0A1lh/9Icr67ee9u6sdIMqDj86Y95w0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764922507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4+NBn5xZiXZq84M6fBwyTKsyKKa+lPaIlWOSdiCedw=;
	b=YpnOsifsbq4ENLzlw796pJBN3QUcVySSPOvP0hNM4817FxT4tqJ3osj46ybnLjTa4+C9CI
	DVmLqBQ2BabRn5Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Z8tGcheH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=y7mnHG4x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764922505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4+NBn5xZiXZq84M6fBwyTKsyKKa+lPaIlWOSdiCedw=;
	b=Z8tGcheH5nH+26ocBXYShqOzfpacOqFJUuruq0gYSU7xQI4lARNmYdaqzduExDNxw01Yfa
	6cazyb9rCrKE7obu+elfXHucwRlT9E9iaRbtjqy/LtZyvJbpUn55XUXAh0Cp2ceYEIrm8q
	t1nhkfbh5L+BeqMviYHwXq/dwbXDa5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764922505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4+NBn5xZiXZq84M6fBwyTKsyKKa+lPaIlWOSdiCedw=;
	b=y7mnHG4xASOMc6qknoEkXNcc4WBvWdlhZtqE4AuPpzU7PNKJBCeDGe6I/UZ8XQXIqeee8F
	UNO5V2VxYFMDLaAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A6063EA63;
	Fri,  5 Dec 2025 08:15:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YzKbIImUMmn5LAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 05 Dec 2025 08:15:05 +0000
Message-ID: <4c28a2fc-20ea-47c7-b1e8-21dd1e07e875@suse.de>
Date: Fri, 5 Dec 2025 09:15:05 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] [udf?] memory leak in __blkdev_issue_zero_pages
To: shaurya <ssranevjti@gmail.com>,
 syzbot+527a7e48a3d3d315d862@syzkaller.appspotmail.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <6931abe7.a70a0220.2ea503.00e0.GAE@google.com>
 <23fde58b-ef8f-4420-b0a8-5ae87dfe0bc4@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <23fde58b-ef8f-4420-b0a8-5ae87dfe0bc4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,syzkaller.appspotmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[527a7e48a3d3d315d862];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: AFC3F336CD
X-Spam-Flag: NO
X-Spam-Score: -3.01

On 12/4/25 17:12, shaurya wrote:
> #syz test:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
 >

Please send the patch as the mail body, not as attachment.
Otherwise bots will have issues picking it up properly.
Other than that:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
