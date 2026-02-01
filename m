Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036BE126C02
	for <linux-block@vger.kernel.org>; Sun,  1 Feb 2026 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769965627; cv=none; b=YpImMO6njLF+eb3hcnrnC/EYXgRxuew7w4Va4u/PlEi8bmTX5g027RREw3RV1OS8P7yXob6NFLEwztR6fXuof/annQpnHENj8qmAX8pwwLFAZMVIGwiA6e4kHhgNR9hlKHqoFRUwvZnsWD7fLapx/ScqVrivzm5IUsayHAwR5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769965627; c=relaxed/simple;
	bh=NG66e7ZbHRx7QhfXGiYe0MLhUIDgBKe5tPbBLDQDLDA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Kar5ZxHERG08PfOVAJ9PoGavSGwwYnv1+T/Ydg30BUWeTdv+hB8+Y30N1cs7JHRaIQK3Zci2odk5jbM8pA3kWQW1WvOwmH3rQxtQop2OAZaDohw39gJt9MERenNUGrz+vT3Begi/y5EymwUDZWVvvpAq7ksHzP1scZxpgz4UkFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q3W+XikX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WXnGySUQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q3W+XikX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WXnGySUQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q3W+XikX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WXnGySUQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q3W+XikX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WXnGySUQ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9EBD935333;
	Sun,  1 Feb 2026 17:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769965617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZhWs3crfA2G6ueORTmclwUlmcN2OtgYnNiy2QgcLdF8=;
	b=Q3W+XikXte+zwB8vDEZ2JOJfS9pB5S/C7XdlArNEidopw+i7GLwtDx0Brde3uXk73i5A21
	3egDpDGg5uxXips9LHgUQgV1IaDEi4T709EjAOeaQheNC5jsc+b6zr84vX8CdlQ7uXgUkn
	FpNb4DEae/c18kFQUCpQyImRxGDb/50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769965617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZhWs3crfA2G6ueORTmclwUlmcN2OtgYnNiy2QgcLdF8=;
	b=WXnGySUQFhe2jRqe8d4DtfUNbJ6/xi0xlcwtuBGzbzBhH2lg7htIFVD8daI94u35g+ZJqD
	qdEmlHp/ut+O2uCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Q3W+XikX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WXnGySUQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769965617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZhWs3crfA2G6ueORTmclwUlmcN2OtgYnNiy2QgcLdF8=;
	b=Q3W+XikXte+zwB8vDEZ2JOJfS9pB5S/C7XdlArNEidopw+i7GLwtDx0Brde3uXk73i5A21
	3egDpDGg5uxXips9LHgUQgV1IaDEi4T709EjAOeaQheNC5jsc+b6zr84vX8CdlQ7uXgUkn
	FpNb4DEae/c18kFQUCpQyImRxGDb/50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769965617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZhWs3crfA2G6ueORTmclwUlmcN2OtgYnNiy2QgcLdF8=;
	b=WXnGySUQFhe2jRqe8d4DtfUNbJ6/xi0xlcwtuBGzbzBhH2lg7htIFVD8daI94u35g+ZJqD
	qdEmlHp/ut+O2uCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F8CF3EA62;
	Sun,  1 Feb 2026 17:06:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J4tDFDGIf2nrWQAAD6G6ig
	(envelope-from <hare@suse.de>); Sun, 01 Feb 2026 17:06:57 +0000
Message-ID: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
Date: Sun, 1 Feb 2026 18:06:52 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lsf-pc <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Hannes Reinecke <hare@suse.de>
Subject: [LSF/MM?BFP TOPIC] Block-layer device resets
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9EBD935333
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Hi all,

We are currently working on implementing cross-controller resets for
NVMe, which requires to send a command to the target which then should
terminate all commands on a given controller.
While we could easily terminate the controller, the specification
also requires us to terminate all outstanding commands.
Which then recurses into my all-time favourite topic on how to
abort outstanding commands from the fs/bio layer.

However, here we don't have to dissect/match to individual commands,
but rather have to abort everything, which seems rather easier.s

So I would like to fathom whether such a thing is feasible/reasonable
(I think so, obviously, and can think of several other use-cases, too,
qemu springs to mind here ...) and discuss possible implementations
(set 'req->deadline' to zero for all pending commands?).
Or maybe we can do such a thing already and I'm just not aware of it...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

