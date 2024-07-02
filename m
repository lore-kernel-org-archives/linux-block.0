Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C24B537E7;
	Tue,  2 Jul 2024 07:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719905165; cv=none; b=SU3PHm+ZTYNbN/nS5b8725lHtWKkSmdgan7Con1IPVdXEtnIcrfBhm35Zg/dsj9CZafw29mXwDD4IS/yNlNeCtkifodBC5gIxMykqmtPdAjfQdkTKOOhj8JuO4C5gYIqWIYP4cNVHFeF3QCajPQwYhSgTyW8Rxlh3P38l6tFIaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719905165; c=relaxed/simple;
	bh=WFHHEkv8N9Bai32nGXrq7y2Iy0SVdznCs033vBYYBMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQDSc4CByCrOfbR6x4wbzvmmtQeE84VEXShpVLniNLqS5bmDVJt968AeSo78eaTcqqyKP8fPjTn8LOeccTBfsE1BxZeG7B/S/Hk7cIMo7DbtAdrvdQ3Ax+WfLQrmLIipTo3sbwEhamFQ4oM/M0tD1LMqhbIXibNyAVFvDyZ2g7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D15F2128C;
	Tue,  2 Jul 2024 07:26:01 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 394121395F;
	Tue,  2 Jul 2024 07:26:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WZlBDYmrg2bJBAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 02 Jul 2024 07:26:01 +0000
Date: Tue, 2 Jul 2024 09:25:52 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>, 
	Frederic Weisbecker <fweisbecker@suse.com>, Mel Gorman <mgorman@suse.de>, 
	Sridhar Balaraman <sbalaraman@parallelwireless.com>, "brookxu.cn" <brookxu.cn@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 3/3] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
Message-ID: <irhdgxgnyz76ss7p74dnriix6llnxquowvzh3dxb7mgwd54zd7@euhdihb5spgw>
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
 <ZoIPzQNEsUWOWp3f@fedora>
 <1a1a4684-a55d-4c27-8509-9bf61408872f@suse.de>
 <ZoJWXRgycA8UeYB3@fedora>
 <c797bdc1-b949-4d88-a65f-904d909755dc@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c797bdc1-b949-4d88-a65f-904d909755dc@suse.de>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Rspamd-Queue-Id: 4D15F2128C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Mon, Jul 01, 2024 at 10:37:46AM GMT, Hannes Reinecke wrote:
> Hmm. Guess we need to modify the grouping algorithm to group across all
> cpus, but ensure that each group consists either of all housekeeping CPUs or
> all isolated cpus.

This is what this series does, though just for the housekeeping CPUs. v1
introduces the io_queue option for isolcpus which made sure the
managed_irq behavior doesn't change.
