Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72557D096
	for <linux-block@vger.kernel.org>; Thu, 28 Mar 2024 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711625529; cv=none; b=ix1MKmapN9Mv/fmRogD7JKmB7emXNTWLqZo8DO4QubhyHmpvwWa+7vW1p6nKsVweyfyJRwXSi3ZToFnJimwS+xVVsY8L7JkQ7w6LTn1hJ39hzyj8ReUqxzcfB+26LCICYNvdDeIcf0cQzVeKqwy7jUfVAWPokEU8hH3AWn3dBpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711625529; c=relaxed/simple;
	bh=fv8yM5rN/C0Y77Kw5Klv/jH4Oz3++7wImo5EAXNiMwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yk2F81cgy+XaiuNE5IoKrtgHR+AxsVX7tuWLXC9ZsgfLhgKqk5WLoE9bzSoPZpWgMlwMOOIN1yOFSl8HOu8NTBrch4GlFAlHQU1ubLw3oT2pwP4MI8Zn53NDN6hMSs3JWem6WltjvqAEg5AoxgoP6ydemIEkIq7Jyvwl/W9ekaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DRzMMwGl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dHn4V7iR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wP7uUpiF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S6lMdoZN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DRzMMwGl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dHn4V7iR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wP7uUpiF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S6lMdoZN"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA38920807;
	Thu, 28 Mar 2024 11:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711625526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f6X0T0QvsvPcleLoF5b3AzTy2619Cz/nMq7hoZ7FRjo=;
	b=DRzMMwGly/4s/Qnqw0Rudt6U9az8fANjYFHG2KHeMaoizJ35bPA+U7zaks9ndOrfbV4dxD
	T5gdC4B7TGaiKiwusqYNYKKxYQASGeT0pdvsTgsKlzwMhJZoaDsiClaBI6aFIxUBiSUOuv
	1CKWC8m9vhhutUAJpAlejFZT5slQRw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711625526;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f6X0T0QvsvPcleLoF5b3AzTy2619Cz/nMq7hoZ7FRjo=;
	b=dHn4V7iRB1rFqvVEFx681erfCExeSMwjuACIkGMPyHAGlYP4565/Q2tiEERVbgHvyIRTov
	zZpHOeuIDMx0rYCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711625525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f6X0T0QvsvPcleLoF5b3AzTy2619Cz/nMq7hoZ7FRjo=;
	b=wP7uUpiFqKyvBDk1TZUXs9paUNMcahGyrJWrtJzfEI7zvm8oZEPmXzqpx60LpEdYhGgwjT
	bC43HerEnuOejR1LOH/O86orbzPrhwqhG07gJJmbrKCcoo7zx0LXjdVfzpQi9WLZQkCM02
	mzoP7vJNqf85+E+1g4PwvR72ICdZkZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711625525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f6X0T0QvsvPcleLoF5b3AzTy2619Cz/nMq7hoZ7FRjo=;
	b=S6lMdoZNjcYre+Kh3yhGhKUhwGE0YyneqooJHbFax6R9ExAqViso03vPc+3gaKxiMxDtd4
	/Fuj4dJYyhJAT9Cw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B0D3513AF7;
	Thu, 28 Mar 2024 11:32:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id EeGyKjVVBWbvGQAAn2gu4w
	(envelope-from <hare@suse.de>); Thu, 28 Mar 2024 11:32:05 +0000
Message-ID: <ef07c956-23cd-4de4-8a4c-c796c743d8f1@suse.de>
Date: Thu, 28 Mar 2024 12:32:05 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] block,nvme: latency-based I/O scheduler
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20240326153529.75989-1-hare@kernel.org>
 <5cade4b4-f19f-422d-ab93-bc853b1563d1@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <5cade4b4-f19f-422d-ab93-bc853b1563d1@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.50
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wP7uUpiF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=S6lMdoZN
X-Rspamd-Queue-Id: EA38920807

On 3/28/24 11:38, Sagi Grimberg wrote:
> 
> 
> On 26/03/2024 17:35, Hannes Reinecke wrote:
>> Hi all,
>>
>> there had been several attempts to implement a latency-based I/O
>> scheduler for native nvme multipath, all of which had its issues.
>>
>> So time to start afresh, this time using the QoS framework
>> already present in the block layer.
>> It consists of two parts:
>> - a new 'blk-nodelat' QoS module, which is just a simple per-node
>>    latency tracker
>> - a 'latency' nvme I/O policy
>>
>> Using the 'tiobench' fio script I'm getting:
>>    WRITE: bw=531MiB/s (556MB/s), 33.2MiB/s-52.4MiB/s
>>    (34.8MB/s-54.9MB/s), io=4096MiB (4295MB), run=4888-7718msec
>>      WRITE: bw=539MiB/s (566MB/s), 33.7MiB/s-50.9MiB/s
>>    (35.3MB/s-53.3MB/s), io=4096MiB (4295MB), run=5033-7594msec
>>       READ: bw=898MiB/s (942MB/s), 56.1MiB/s-75.4MiB/s
>>    (58.9MB/s-79.0MB/s), io=4096MiB (4295MB), run=3397-4560msec
>>       READ: bw=1023MiB/s (1072MB/s), 63.9MiB/s-75.1MiB/s
>>    (67.0MB/s-78.8MB/s), io=4096MiB (4295MB), run=3408-4005msec
>>
>> for 'round-robin' and
>>
>>    WRITE: bw=574MiB/s (601MB/s), 35.8MiB/s-45.5MiB/s
>>    (37.6MB/s-47.7MB/s), io=4096MiB (4295MB), run=5629-7142msec
>>      WRITE: bw=639MiB/s (670MB/s), 39.9MiB/s-47.5MiB/s
>>    (41.9MB/s-49.8MB/s), io=4096MiB (4295MB), run=5388-6408msec
>>       READ: bw=1024MiB/s (1074MB/s), 64.0MiB/s-73.7MiB/s
>>    (67.1MB/s-77.2MB/s), io=4096MiB (4295MB), run=3475-4000msec
>>       READ: bw=1013MiB/s (1063MB/s), 63.3MiB/s-72.6MiB/s
>>    (66.4MB/s-76.2MB/s), io=4096MiB (4295MB), run=3524-4042msec
>> for 'latency' with 'decay' set to 10.
>> That's on a 32G FC testbed running against a brd target,
>> fio running with 16 thread.
> 
> Can you quantify the improvement? Also, the name latency suggest
> that latency should be improved no?
> 
'latency' refers to 'latency-based' I/O scheduler, ie it selects
the path with the least latency. It does not necessarily _improve_
the latency. Eg for truly symmetric fabrics it doesn't.
It _does_ improve matters when running on asymmetric fabrics
(eg on a two socket system with two PCI HBAs, each connected to one
socket, or like the example above with one path via 'loop', and the
other via 'tcp' and address '127.0.0.1').
And, of course, if you have congested fabrics, where it should be
able to direct I/O to the least congested path.

But I'll see to extract the latency numbers, too.

What I really wanted to show is that we _can_ track latency without
harming performance.

Cheers,

Hannes

