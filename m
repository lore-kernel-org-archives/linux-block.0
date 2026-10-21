Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581142;
	b=mltNxwPT7kn6xAiAPEgBdPq+kOCYFtDwoB20q0tCl8Ux7qRDcV6XeR0gyF4a328rLT+t
	 Uj3Guyvhl38038py6gdPIFPn8obe7lJJrYsPbT01McOJMFE7Ws8W+XeQ4OSJCxGiEIJ1N
	 2klaSRrk3Stp/KdtrgqukbVNaJhtUZBIuYO14yQS8QOzLL3ug5JRm2jvBNlPyz8e+8S6g
	 /dgJrTIHi7557sQiE7oTAsRQHRnDez49ikYZnrS2ogKNUXrpt05XuCgKmE9wyJbn5dNS9
	 bb5h1lE0KeMSUx3nL8fJdOZrSSZrPMf8K/FttC+xbD565YRIowtizh8U97Yn+lVD02Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581142;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=EJBM3qHz6wO0vIjwr4ywSAoAmm7XwJUzCn8kiOebQoo=;
	b=wlFxLQpAvLOYTbxxN8ZkXQyP0DBU93y77GZ6MGoD44FY6/FVy7bkzxNEkJq+2KVCUsoV
	 xymFvrWjoKnCrDWKISTZGonwOPw1qJV0JrhyVs9dJxklMK4c4M0dWefhudFIe/KqdzQIj
	 UbU6SOqna8QbVc62gNlYV0Qn0gPjG1GLYS0rdVL5hNoDxcXCY9jZvtvlFjbUAewWWhbVe
	 MleiFZhEX4Q1bfdYlcSHsUrkTzPPDywpdlp9qdWqpQnF81LGzQFEd0Wp9XfCyI6JHUfG9
	 T+doyN8swqSV+l3K/bycL0tA18vIu9VKBVFO0iZoQw1C/4u9xBPLe+liaKjErHbdmLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EKjY5bkG;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1HtUq+x6;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EKjY5bkG;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1HtUq+x6;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC499606A319;
	Wed, 21 Oct 2026 11:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC499606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EKjY5bkG;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1HtUq+x6;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EKjY5bkG;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1HtUq+x6
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 42A8D21DF0;
	Wed, 21 Oct 2026 11:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792581140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJBM3qHz6wO0vIjwr4ywSAoAmm7XwJUzCn8kiOebQoo=;
	b=EKjY5bkGpoRBx4VVHesxzwNxbXTQh6XPdRp0olwx9cU8cEFsZ9PI2VIDMgBaKOP1XFwwI5
	IglO1jRW0akEjEob42xZ030rkBscXSCj3wBcmKqZWr3lqvwO5I1jHGPlA7GYZ0o7hDG81B
	NrC9To4Cq2DicOVvV5wanyKMKQGLFQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792581140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJBM3qHz6wO0vIjwr4ywSAoAmm7XwJUzCn8kiOebQoo=;
	b=1HtUq+x6/hZp5RVPDBFwKe9bIP41E/4etr41n7TRg7GwWEAu8pmXpvmMDuMybLZyz8fTW/
	ZhKetV9bbnVrMEDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792581140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJBM3qHz6wO0vIjwr4ywSAoAmm7XwJUzCn8kiOebQoo=;
	b=EKjY5bkGpoRBx4VVHesxzwNxbXTQh6XPdRp0olwx9cU8cEFsZ9PI2VIDMgBaKOP1XFwwI5
	IglO1jRW0akEjEob42xZ030rkBscXSCj3wBcmKqZWr3lqvwO5I1jHGPlA7GYZ0o7hDG81B
	NrC9To4Cq2DicOVvV5wanyKMKQGLFQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792581140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJBM3qHz6wO0vIjwr4ywSAoAmm7XwJUzCn8kiOebQoo=;
	b=1HtUq+x6/hZp5RVPDBFwKe9bIP41E/4etr41n7TRg7GwWEAu8pmXpvmMDuMybLZyz8fTW/
	ZhKetV9bbnVrMEDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3932134A5;
	Wed, 21 Oct 2026 11:12:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aqCuMhOe2GpuAgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 Oct 2026 11:12:19 +0000
Message-ID: <451bea60-3c75-4edd-88c1-415ff7657595@suse.de>
Date: Wed, 21 Oct 2026 13:12:19 +0200
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] nvme-fabrics: limit each queue type to the number of
 online CPUs
To: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>, Surabhi Gogte <sgogte@purestorage.com>,
 Hannes Reinecke <hare@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>,
 Frederic Weisbecker <frederic@kernel.org>, Aaron Tomlin
 <atomlin@atomlin.com>, Maurizio Lombardi <mlombard@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
References: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org>
 <20261014-nvme-fabrics-isolcpu-v1-4-355156be27b2@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261014-nvme-fabrics-isolcpu-v1-4-355156be27b2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.29

On 10/14/26 9:46 AM, Daniel Wagner wrote:
> From: Daniel Wagner <wagi@kernel.org>
> 
> nvmf_nr_io_queues limits each queue type to the number of online CPUs
> when asking for I/O queues, but nvmf_set_io_queues hands out the
> granted queues without these limits, and only nr_io_queues is clamped
> when parsing the options.
> 
> E.g. with 2 CPUs, nr_io_queues=2, nr_write_queues=10 and
> nr_poll_queues=10, 2 + 2 + 2 = 6 queues are requested, but handed out
> as 4 default, 2 read and 0 poll queues.  blk_mq_map_queues can't create
> more CPU masks than there are CPUs, so default queues 2 and 3 take over
> the CPUs of default queues 0 and 1, and connecting the I/O queue of
> default queue 1 fails with -EXDEV.
> 
> Apply the same limits in nvmf_set_io_queues.  A queue type with more
> queues than online CPUs always has a hardware context without an online
> CPU, so no working setup changes.  The options are not modified, so the
> limits follow CPU hotplug on reconnect.
> 
> Fixes: 6486199378a5 ("nvme-tcp: fix queue mapping when queue count is limited")
> Fixes: a249d3066de6 ("nvme-fabrics: add queue setup helpers")
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/fabrics.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
