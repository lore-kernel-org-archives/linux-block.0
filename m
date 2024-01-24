Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB4DF514
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 06:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706077161; cv=none; b=WKcie0tcxdHOCu0S4Xuj1qL60sVDEbzTRDxF3juBUyg9tMq791xm0AoHMy93td+lSnNZYpvdy8im/gp48mPXW5PGs0V5elFVgYHksz85OTdF45nPqWVeTY/hlqSra1vSXGx8LFdbhu4Bf0mUoH/uFxZjs83uWH0erZWeSii0S8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706077161; c=relaxed/simple;
	bh=wT4MQHGEtBLyoSgWPb98J/e9WF3V2UO6VxSdMhHexIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgjQa3FrDrtspXimwPUluzrAMjL7CzvybdBYRsbxGno47i3LTmrSAUZVEApZsfzJ/IZ92WvwY/vPhiDd3KvQyr5kJCJa/zdlIOkL40bKZkl1a/2sFF2nZGwmFA7TR6fHePDhF25BAqY+39pWGi2w2CPh6c0JL490nRHPLeghljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vd/jE7pi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dvF8Y2Tl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i/0Ot2Xb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NGw/m7Ew; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vd/jE7pi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dvF8Y2Tl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i/0Ot2Xb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NGw/m7Ew"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9B5E21F28;
	Wed, 24 Jan 2024 06:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706077158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RW4O677P8gtxdk1h9zpLLUk4t3hUWTGqLL0uyRMks7E=;
	b=Vd/jE7pi8w65FMo3skquaiEQNjaZXmE7Zb/bCeze0F8I0QyBy8CiVg5N5nnJdlUzBnvEng
	6ci5RS+NJN9nvQoaQfhGj2FT5GiNHoN4itAwg3uCQWo6cE98Wei/aNZnjRyS40be44393T
	E2HAceD8mVDcGFA5NdeS/97diTURHrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706077158;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RW4O677P8gtxdk1h9zpLLUk4t3hUWTGqLL0uyRMks7E=;
	b=dvF8Y2Tl43DwuMvo1AvjgQB99izfscSJ2RLrqAoDazFr4/Jkbx1iU4JEo1vqJTdPXJdFSy
	7HEqOerceXdfcpDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706077157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RW4O677P8gtxdk1h9zpLLUk4t3hUWTGqLL0uyRMks7E=;
	b=i/0Ot2XbM+XbItbqLbL/CXx/hoZOolQJBDDLF6PuEp7Qu3p7dTclhlsHkYeqrrnKmfwVIQ
	wyDSWIifFZm138dA7vnhFZ5PN3g6lKpYyOPNINhCQGJHbMxXBP7gghMeZRjJOpBzLYKOU2
	G8j8yrwAxabanrMGDhpJGKWGxnhT7Jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706077157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RW4O677P8gtxdk1h9zpLLUk4t3hUWTGqLL0uyRMks7E=;
	b=NGw/m7EwGzYLrA/2WhR1m88FJ+GnOiU8OCql8Ql8cEoq6QkYk3sYOJGtABqiHOZ82IpoJf
	RfHz+XjbsRaLFbBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D4AA1333E;
	Wed, 24 Jan 2024 06:19:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fn5LEOWrsGU4SQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 24 Jan 2024 06:19:17 +0000
Message-ID: <bf5e66a8-d631-45eb-8d1f-b4892bc081eb@suse.de>
Date: Wed, 24 Jan 2024 07:19:16 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] virtio_blk: split virtblk_probe
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-12-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240122173645.1686078-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="i/0Ot2Xb";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="NGw/m7Ew"
X-Spamd-Result: default: False [-4.33 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.53)[97.89%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E9B5E21F28
X-Spam-Level: 
X-Spam-Score: -4.33
X-Spam-Flag: NO

On 1/22/24 18:36, Christoph Hellwig wrote:
> Split out a virtblk_read_limits helper that just reads the various
> queue limits to separate it from the higher level probing logic.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/virtio_blk.c | 193 +++++++++++++++++++------------------
>   1 file changed, 101 insertions(+), 92 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich

