Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091B17E9
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001187; cv=none; b=Fv9E33IN1qWct2xSnnTg0bh7WDqlPzCzIDAdCMtlNJmH/xyBCz4Mg97NQOWY4EBHwGDbGxrStJKYitDVfWKZ8AfR9ZndafDewREb+NFswxRY/eWy9aXfhMJAo6/pUTqY1nXnb+tJjpOg6W2aQigfEg5msSNhDzhkO9tcj4g4F/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001187; c=relaxed/simple;
	bh=2YnYHmGlMUzbPvn/+95fUN24UNlrjhz41krMUOMxpSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUlC3IAGPl1mVgEcP0X9aX61yKmNe6VGlbEf6fZsDww1iZ5coPuhcJ3rMBzijezw+q3jc5aKQYfG4IykJiKeN4MuA+DBegTrG7Dwb9amcGm+qID+wyyjq42G7DebbyeYaIlZ5x1+jsd7vAx6wzcpI9OfI/BWAYLfdk6p2RnqgRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RQL7/jBB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NpLDH0z9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RQL7/jBB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NpLDH0z9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RQL7/jBB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NpLDH0z9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RQL7/jBB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NpLDH0z9"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4442D21F7D;
	Tue, 23 Jan 2024 09:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706001184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3pZiWCA45MPXYhuSSFzLhiEFyugVP1G7XbsKeWz0k4=;
	b=RQL7/jBBaD7LkyML9gsK8MpUPE5JL9LKCGF2A4pu3cL0ahTnqGzp+ZDsLFz9RRhskaZImM
	Xu2Qr1sdriPZMhLXjre2X5gf4I99exoy+kvMNR9JB3X3v4FyMorvCw8JBv5EeFvhcYlXvM
	Qks/WEerYW4q3tDyyBK/N19MNpZBjGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706001184;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3pZiWCA45MPXYhuSSFzLhiEFyugVP1G7XbsKeWz0k4=;
	b=NpLDH0z9nesgn/CfLEeWU5BxdH6Req8lS81rpKxxIXKbI2Oehn0p4/8oPKLHj0WUZ32nik
	p46NVwBe/+jdTvDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706001184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3pZiWCA45MPXYhuSSFzLhiEFyugVP1G7XbsKeWz0k4=;
	b=RQL7/jBBaD7LkyML9gsK8MpUPE5JL9LKCGF2A4pu3cL0ahTnqGzp+ZDsLFz9RRhskaZImM
	Xu2Qr1sdriPZMhLXjre2X5gf4I99exoy+kvMNR9JB3X3v4FyMorvCw8JBv5EeFvhcYlXvM
	Qks/WEerYW4q3tDyyBK/N19MNpZBjGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706001184;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3pZiWCA45MPXYhuSSFzLhiEFyugVP1G7XbsKeWz0k4=;
	b=NpLDH0z9nesgn/CfLEeWU5BxdH6Req8lS81rpKxxIXKbI2Oehn0p4/8oPKLHj0WUZ32nik
	p46NVwBe/+jdTvDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3618C136A4;
	Tue, 23 Jan 2024 09:13:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R9nBDCCDr2XVfgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 23 Jan 2024 09:13:04 +0000
Message-ID: <d1223964-f952-451c-9863-7788d37198ed@suse.de>
Date: Tue, 23 Jan 2024 10:13:03 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: can we drop the bio based path in null_blk
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20240123084942.GA29949@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240123084942.GA29949@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.14 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.05)[60.41%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.14

On 1/23/24 09:49, Christoph Hellwig wrote:
> As we found out recently null_blk never splits bios in bio mode, thus
> ignoring a lot of it's paramters and having buggy zoned device
> handling.
> 
> Is there any good reason to keep this mode around given that all relevant
> hardware drivers use blk-mq, and the non-so-relevant ones not using
> blk-mq probably should?
> 
All for it.
But I guess that means we should convert zram...

Cheers,

Hannes

