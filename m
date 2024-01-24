Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A6BF9C1
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 06:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706076114; cv=none; b=TnHvYDTgz5xdUBLgI4P0jmApnyKKfYZ6paco/cJu9MEQ7kx29HHYPhtmKVl5rk0uwxuWtqbCUpC0oPsB+c3mDk8ISGR9nr4SMqc0YvXsTPuDV/xczh4FMX9mPuUrStbcHz9/cH+q2rP0DapkKzf0gJOMPnLrWx2yP6munKb9Vog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706076114; c=relaxed/simple;
	bh=bmBmr/XyAWlAMhN4RFN33Gt1wCKiIJHpjrCLbp0ynVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHj3Ppo+6F/T8gi0lw6+Ut8MjjTBe0ff87B7fYKLYOxHPm8hd/BH2jkkUb8yDH4gAFKsbDJZpZX6TJ0LX1iCzwK3rSz0/JYrXO7KHRGkH9Kw6ZbB6H40oHA1eTp9/DTpK1gHzt6BtBGoUGoCIwQs/YRvz6M0fQldPoepTfpa5FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dKampBC0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bD3rOGIY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dKampBC0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bD3rOGIY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dKampBC0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bD3rOGIY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dKampBC0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bD3rOGIY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 091D01FCFA;
	Wed, 24 Jan 2024 06:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706076111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7DpqATfF8GeEARjoMG9rG4cWtrbgy15BGCKTb02l7E=;
	b=dKampBC0DkeZFufjxPiTR5N1shGgfL2A5YJrupfRKh/dlfZUxas+MnIgHDEhyXF8M41z09
	kYmpQSJA28klWYnCX+NpNMNEU1foGEb0Zji6XF5xGutzWdk5zDMpD4xQwluaTtyAvuFqqL
	T+n2lb54OtBBKsx3Y04C5iSo2jpxqpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706076111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7DpqATfF8GeEARjoMG9rG4cWtrbgy15BGCKTb02l7E=;
	b=bD3rOGIYa+Yzq/xYXcI+y5wNI2Nar+91HPanrJ4MkVFID9pQmyj4xlHMk/ziyUdAUdZn36
	Z5a4I6KoUSjSCkAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706076111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7DpqATfF8GeEARjoMG9rG4cWtrbgy15BGCKTb02l7E=;
	b=dKampBC0DkeZFufjxPiTR5N1shGgfL2A5YJrupfRKh/dlfZUxas+MnIgHDEhyXF8M41z09
	kYmpQSJA28klWYnCX+NpNMNEU1foGEb0Zji6XF5xGutzWdk5zDMpD4xQwluaTtyAvuFqqL
	T+n2lb54OtBBKsx3Y04C5iSo2jpxqpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706076111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7DpqATfF8GeEARjoMG9rG4cWtrbgy15BGCKTb02l7E=;
	b=bD3rOGIYa+Yzq/xYXcI+y5wNI2Nar+91HPanrJ4MkVFID9pQmyj4xlHMk/ziyUdAUdZn36
	Z5a4I6KoUSjSCkAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D0841333E;
	Wed, 24 Jan 2024 06:01:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YOr5Fc6nsGXkRQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 24 Jan 2024 06:01:50 +0000
Message-ID: <fb3c48b3-9d31-475b-a05b-b8cc6f7b7207@suse.de>
Date: Wed, 24 Jan 2024 07:01:50 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] block: refactor disk_update_readahead
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
 <20240122173645.1686078-3-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240122173645.1686078-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dKampBC0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bD3rOGIY
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.54 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.54)[92.01%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.54
X-Rspamd-Queue-Id: 091D01FCFA
X-Spam-Flag: NO

On 1/22/24 18:36, Christoph Hellwig wrote:
> Factor out a blk_apply_bdi_limits limits helper that can be used with
> an explicit queue_limits argument, which will be useful later.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-settings.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
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

