Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65BF365D21
	for <linux-block@vger.kernel.org>; Thu, 30 Oct 2025 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845890; cv=none; b=GLym/7a9H5XWTGjYlJAUTEvnWu9iNEUbMchZgwgLw4uBvEE6IJV+wrHNdSysmvY2QrCXa3b1JQyuBPEz7huxATudnKD6AFM/2ba9C3UJKzslm6zJTsf3O8UtH8QofsxfJvUjBHQNor/J+bCLPPp5t9CJ99jy5TU0D7HhWVgZq5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845890; c=relaxed/simple;
	bh=Q9dUav+ktzqD3z+iw5mtf6ik4qYvWyeiX1JcgrpnLOE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DJ9VjRD527YEDVYjfiX3lvm+pvm1nYEddlr9SVN8PRN5V2dCv8qqMZ6QtR7ypaHdL4SYzvlmAwLNn2x5B3DtWpM5T+U+BmXPLT06VgWhCDPgwP3xulKvC6q5VN7HNyJ7V2hxVeroBGxXhFKNnScSqi0GeqSf9hQqU0irKzMK9Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=W0j9FuHi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YOGQbZ7H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W0j9FuHi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YOGQbZ7H"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB90C1FB5E;
	Thu, 30 Oct 2025 17:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761845886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9dUav+ktzqD3z+iw5mtf6ik4qYvWyeiX1JcgrpnLOE=;
	b=W0j9FuHi5ia4BtiSgtwVlKazxjkplEnVTO+322TaITPrGd6KL8Ke5ZYyz6I5ek6IaPCrGi
	PodQD5XdDjpVP0NYFTqdCGjzCe2i9rydb+OMqA20ZS3gN01fzIdY5LvwAVueIy60kjwaTv
	8tkIF7OMn8XuJTz2TM7DwDCR3elNjWg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761845884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9dUav+ktzqD3z+iw5mtf6ik4qYvWyeiX1JcgrpnLOE=;
	b=YOGQbZ7HuAZIjKHoD/vaheIP05zeYqQTh0dlsr4cGxRZzLX+xxzKVj+kgfzl4V5QF1lu2k
	R0/tICs6kvuWSIcfQK5WjPtBHLX4hQjxK/R9O1it5roNylNWLzfLumns+7msi+uUmScdnx
	Ey77P9CzFZxUybXB18vc72Zm/nLT1rY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FE971396A;
	Thu, 30 Oct 2025 17:38:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id COjxJXyiA2liXAAAD6G6ig
	(envelope-from <mwilck@suse.com>); Thu, 30 Oct 2025 17:38:04 +0000
Message-ID: <f4ef82a5ca88901653ce07fb0313c144a0fdb6ac.camel@suse.com>
Subject: Re: [PATCH v3] block: Remove queue freezing from several sysfs
 store callbacks
From: Martin Wilck <mwilck@suse.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Nilay
 Shroff	 <nilay@linux.ibm.com>, Benjamin Marzinski <bmarzins@redhat.com>, 
	stable@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Chaitanya
 Kulkarni	 <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>
Date: Thu, 30 Oct 2025 18:38:04 +0100
In-Reply-To: <20251030172417.660949-1-bvanassche@acm.org>
References: <20251030172417.660949-1-bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,lst.de:email,imap1.dmz-prg2.suse.org:helo,acm.org:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Thu, 2025-10-30 at 10:24 -0700, Bart Van Assche wrote:
> Freezing the request queue from inside sysfs store callbacks may
> cause a
> deadlock in combination with the dm-multipath driver and the
> queue_if_no_path option. Additionally, freezing the request queue
> slows
> down system boot on systems where sysfs attributes are set
> synchronously.
>=20
> Fix this by removing the blk_mq_freeze_queue() /
> blk_mq_unfreeze_queue()
> calls from the store callbacks that do not strictly need these
> callbacks.
> This patch may cause a small delay in applying the new settings.
>=20
> This patch affects the following sysfs attributes:
> * io_poll_delay
> * io_timeout
> * nomerges
> * read_ahead_kb
> * rq_affinity
>=20
> ...
>=20
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Nilay Shroff <nilay@linux.ibm.com>
> Cc: Martin Wilck <mwilck@suse.com>
> Cc: Benjamin Marzinski <bmarzins@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: af2814149883 ("block: freeze the queue in queue_attr_store")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>=20
> Changes compared to v2:
> =C2=A0- Dropped the controversial patch "block: Restrict the duration of
> sysfs
> =C2=A0=C2=A0 attribute changes".

So the "deadlock" situation for the other sysfs attributes that you
handled with the timeout in v2 will remain now? Are you planning to
send a follow-up patch for these attributes?

Martin

