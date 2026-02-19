Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE037303A3B
	for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494892; cv=none; b=f/T7H09Z5j9dSiuDliwWDp+PmhDYXniiBhHG+ciNL78JSAWSlMLIO7rSkTlTu79L5qAMsKRhrmbtvujlzOqQNoGZ4Gt3P3MNTFZM71aoWl7GvvLk0m2Da3y/kATuBtjWKXHYPww/aQ75CiZgDYMHU7IZjH/PJiTUASzH0/TeVZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494892; c=relaxed/simple;
	bh=DC2Pt8hIrWFIINaq/OAUpk4sf/yHj2GhdQi3YeDeOGQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=WfbMkH00NrbWue2RlXo5t7ThWZMsrGdy0exBH4n6xbwC9xFyL5GaHgXtXCs3sy/Zn8PiZKRdCDP6R5p4WnNEfMLRtWnjkeawH8TlTD+Y+Fnld0w6y1hI+E8jJQFiLrcxRHRSANQi8mzM0dEpLDFm+v4lMkIGdZHuyhTcZhSWA2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BNoOW7Ta; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rGfDI4Sz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BNoOW7Ta; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rGfDI4Sz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BNoOW7Ta";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rGfDI4Sz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BNoOW7Ta";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rGfDI4Sz"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 313055BCC7;
	Thu, 19 Feb 2026 09:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771494889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3e7k0CMgUbTj2xC5pAxQgef7+E5hHmV9itvXo3DbZGE=;
	b=BNoOW7Ta9bzhOeu6BmeXIU3CukJpHmWhf3JW9U55bYDe1aXhPML9SZx/SzLQpHYLhXmhJ4
	XeVGHpBZQJ5QgPfCDgDwY8fSwMdoEGtFGUPljC2m7xODa/LGoDYo8q+ddBM8B+1FuVelER
	/Ms74PK1QoBqlMqzd9RmTdfnKCvairE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771494889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3e7k0CMgUbTj2xC5pAxQgef7+E5hHmV9itvXo3DbZGE=;
	b=rGfDI4SzjwY8KzuPdzLugT9WuovU6r0d+qVBpZP4QOsfeUm8yoYUXuMpMaf13jorWQpw7T
	DKkwtNsJvzv8ZWDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BNoOW7Ta;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rGfDI4Sz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771494889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3e7k0CMgUbTj2xC5pAxQgef7+E5hHmV9itvXo3DbZGE=;
	b=BNoOW7Ta9bzhOeu6BmeXIU3CukJpHmWhf3JW9U55bYDe1aXhPML9SZx/SzLQpHYLhXmhJ4
	XeVGHpBZQJ5QgPfCDgDwY8fSwMdoEGtFGUPljC2m7xODa/LGoDYo8q+ddBM8B+1FuVelER
	/Ms74PK1QoBqlMqzd9RmTdfnKCvairE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771494889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3e7k0CMgUbTj2xC5pAxQgef7+E5hHmV9itvXo3DbZGE=;
	b=rGfDI4SzjwY8KzuPdzLugT9WuovU6r0d+qVBpZP4QOsfeUm8yoYUXuMpMaf13jorWQpw7T
	DKkwtNsJvzv8ZWDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7D9B3EA68;
	Thu, 19 Feb 2026 09:54:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c/GwNujdlmkBSgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 19 Feb 2026 09:54:48 +0000
Message-ID: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
Date: Thu, 19 Feb 2026 10:54:48 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lsf-pc <lsf-pc@lists.linux-foundation.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org
From: Hannes Reinecke <hare@suse.de>
Subject: [LSF/MM/BPF TOPIC] Memory fragmentation with large block sizes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 313055BCC7
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

Hi all,

I (together with the Czech Technical University) did some experiments 
trying to measure memory fragmentation with large block sizes.
Testbed used was an nvme setup talking to a nvmet storage over
the network.

Doing so raised some challenges:

- How do you _generate_ memory fragmentation? The MM subsystem is
   precisely geared up to avoid it, so you would need to come up
   with some idea how to defeat it. With the help from Willy I managed
   to come up with something, but I really would like to discuss
   what would be the best option here.
- What is acceptable memory fragmentation? Are we good enough if the
   measured fragmentation does not grow during the test runs?
- Do we have better visibility into memory fragmentation other than
   just reading /proc/buddyinfo?

And, of course, I would like to present (and discuss) the results
of the testruns done on 4k, 8k, and 16k blocksizes.

Not sure if this should be a storage or MM topic; I'll let the
lsf-pc decide.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

