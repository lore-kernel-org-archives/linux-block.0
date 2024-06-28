Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FDA3398B;
	Fri, 28 Jun 2024 06:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719555903; cv=none; b=hsubCJAM52OlSVE59CrFkeYskTny854SanwcTEVyIvwT0qekT20IhMSYaKdPGeb/D6VbvcNwXb7W8pt2APhb7V4hQr8Pf8EDs/yZDhqYnec71qr46EeBR/9j0CQaa3lwuOZQWLkoczCZzMAzRzIf/iEWpaqSxzSjat8pKJP9E+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719555903; c=relaxed/simple;
	bh=YLmeUWo25fb4+4xLIV42PCMyCg/O6IcRMX8z+lPf04s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAJ0E5AgRFDsKRPu+Ry1tONZAUkeHXG4qcxYECKWMmqmPxdWM7Ca7vYejGggvQX3aV7u7inhlQPCVoszooVku4y2HoqKhroWHqVMa2eP21bnIkVli3F3jQSzgy6qgUWuM3dpTe3nR5Q1hOibxJ/6pOWQKN34Pbxi+lm58JkiZu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uDprSZaL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MQiCWv1G; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uDprSZaL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MQiCWv1G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uDprSZaL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MQiCWv1G";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uDprSZaL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MQiCWv1G"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 69E931FCEE;
	Fri, 28 Jun 2024 06:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719555899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/FQOPeOhateSzFn9j7wdhav+ZCO4bg81Aue2fbrQ9Y=;
	b=uDprSZaLmgt/Xrl6arhTyXLMasmsdSokjtWJ6WBeaOfJ2s39lVp5FvEXA/xXE6PwaZsQ7J
	wPT8lcTHul75kzsJqogPwu75jvZ+FtZoarpy58d6LTqm0CZroxFjzfv9gDPS6/kFf/BDtb
	+wwCbIzbTnNyLdVJILhRYsmCfD4vL+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719555899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/FQOPeOhateSzFn9j7wdhav+ZCO4bg81Aue2fbrQ9Y=;
	b=MQiCWv1GK1GZNz5jm49v/blIvpFldQTx+PsSQzMk2Y586OSTHIeseOV/WDjzNCiKf1Rcdv
	WGdbFI718EyI/HAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719555899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/FQOPeOhateSzFn9j7wdhav+ZCO4bg81Aue2fbrQ9Y=;
	b=uDprSZaLmgt/Xrl6arhTyXLMasmsdSokjtWJ6WBeaOfJ2s39lVp5FvEXA/xXE6PwaZsQ7J
	wPT8lcTHul75kzsJqogPwu75jvZ+FtZoarpy58d6LTqm0CZroxFjzfv9gDPS6/kFf/BDtb
	+wwCbIzbTnNyLdVJILhRYsmCfD4vL+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719555899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/FQOPeOhateSzFn9j7wdhav+ZCO4bg81Aue2fbrQ9Y=;
	b=MQiCWv1GK1GZNz5jm49v/blIvpFldQTx+PsSQzMk2Y586OSTHIeseOV/WDjzNCiKf1Rcdv
	WGdbFI718EyI/HAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 844351373E;
	Fri, 28 Jun 2024 06:24:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uIsTHDpXfmZ4ewAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 28 Jun 2024 06:24:58 +0000
Message-ID: <1fbf3f91-218a-47a6-95f3-7c08a6df2ecf@suse.de>
Date: Fri, 28 Jun 2024 08:24:58 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
Cc: Frederic Weisbecker <fweisbecker@suse.com>, Mel Gorman <mgorman@suse.de>,
 Sridhar Balaraman <sbalaraman@parallelwireless.com>,
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	URIBL_BLOCKED(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,suse.de,parallelwireless.com,gmail.com,redhat.com,vger.kernel.org,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 

On 6/27/24 16:10, Daniel Wagner wrote:
> group_cpus_evenly distributes all present CPUs into groups. This ignores
> the isolcpus configuration and assigns isolated CPUs into the groups.
> 
> Make group_cpus_evenly aware of isolcpus configuration and use the
> housekeeping CPU mask as base for distributing the available CPUs into
> groups.
> 
> Fixes: 11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed interrupts")
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   lib/group_cpus.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 73 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

