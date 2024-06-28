Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684E43398B;
	Fri, 28 Jun 2024 06:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719555842; cv=none; b=XzaTzXnWBoVpr9UprK9eAxznV/jcLbDWNfRlNlMCJqv3rnjQqUrnoihYYExSoMd0qarhJ8B+Xa78pobprc4h/VjIY2D9bx7zdBdzk2PSuTjy2O5MJzbfxKFwMoTqqGULPXarojyu7JL2fkjSOsAfXmc27PSykUTIbGq3CHtNU50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719555842; c=relaxed/simple;
	bh=B7xR2DpQaDDiqf1vLloyVprc+qQgznT9DfoPUl/Vllg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuZK6z/J8TOhCO454Yy50tPeaATJpFiyrbnAl6GX90KjnO3DFyB5rjeMT9hiy3IdaVzS4iG1ZGj2EGgCmw6s3ZI02mlCI+NmIydx07VL/lvPcYeKGqOA7dX24biT17rsykKBGAvhz3KPLDDwwZA0jD0DwrE+WtKqM7j4gJC6Nds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eP7Ur/tz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=13Z7Q+zq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eP7Ur/tz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=13Z7Q+zq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eP7Ur/tz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="13Z7Q+zq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eP7Ur/tz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="13Z7Q+zq"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6BF99219B6;
	Fri, 28 Jun 2024 06:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719555838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nwidLcLTExnOFfQnmGAyzq9ZdPX1wP8vAw0uYxLpxnQ=;
	b=eP7Ur/tzJGYpMtNU3jRrLCqrpPVB5WCDOcJ3VW2VwSUdkrc8/FxV+9sSKuyBuu0hHYZy/k
	WrMzMIZfYxRGDQvTYcSKZO9l7M6TiBLOcX3xDgUhgBOmBTrBRy3PM5b3Vu2RtmlQ4PbgZn
	CMb4QHpoRJETzCbgeFnntplaT8U4svU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719555838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nwidLcLTExnOFfQnmGAyzq9ZdPX1wP8vAw0uYxLpxnQ=;
	b=13Z7Q+zqEJ/VQR9P7OvKkTE+Oa7J7N+Tj0iaK/2CZnt/vmiTJq6Z2d5QJHA6xP4f4fV5Lv
	t56x4znd/6a6nsBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719555838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nwidLcLTExnOFfQnmGAyzq9ZdPX1wP8vAw0uYxLpxnQ=;
	b=eP7Ur/tzJGYpMtNU3jRrLCqrpPVB5WCDOcJ3VW2VwSUdkrc8/FxV+9sSKuyBuu0hHYZy/k
	WrMzMIZfYxRGDQvTYcSKZO9l7M6TiBLOcX3xDgUhgBOmBTrBRy3PM5b3Vu2RtmlQ4PbgZn
	CMb4QHpoRJETzCbgeFnntplaT8U4svU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719555838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nwidLcLTExnOFfQnmGAyzq9ZdPX1wP8vAw0uYxLpxnQ=;
	b=13Z7Q+zqEJ/VQR9P7OvKkTE+Oa7J7N+Tj0iaK/2CZnt/vmiTJq6Z2d5QJHA6xP4f4fV5Lv
	t56x4znd/6a6nsBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C15E51373E;
	Fri, 28 Jun 2024 06:23:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EP1NK/1WfmZ4ewAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 28 Jun 2024 06:23:57 +0000
Message-ID: <9f86cc6b-c18f-4696-a134-767beea24d23@suse.de>
Date: Fri, 28 Jun 2024 08:23:57 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] blk-mq: add blk_mq_num_possible_queues helper
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
 <20240627-isolcpus-io-queues-v2-1-26a32e3c4f75@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240627-isolcpus-io-queues-v2-1-26a32e3c4f75@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 

On 6/27/24 16:10, Daniel Wagner wrote:
> Multi queue devices which use managed IRQs should only allocate queues
> for the housekeeping CPUs when isolcpus is set. This avoids that the
> isolated CPUs get disturbed with OS workload.
> 
> Add a helper which calculates the correct number of queues which should
> be used.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   block/blk-mq-cpumap.c  | 20 ++++++++++++++++++++
>   include/linux/blk-mq.h |  1 +
>   2 files changed, 21 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

