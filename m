Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C135DDD0
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 06:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706076711; cv=none; b=NQV8ai9oFtBxU+R2vfm19SbbHp3sGzawcuENqrHJw1/1Z8IAwL11Tnu3VCB1yIy6Xhtfgy34OgmXXXJClSbVLx5PH1HT+R917FSwaCmpKgqTVrQwfprKGdskwMWi5+YS0yUhXyuYC7374yWxyuxoNGzFkZ7EzieYunDrBXtBan8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706076711; c=relaxed/simple;
	bh=GM684PWoiNAo7P59kiFbNs+VXrDjNgrAhwieNijnff8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqtVCyzPSKJeH2UFmEmz4HZdaViuR2pHT2KyX5f3GoOyi0uwAQmaaz6+B4xYxmJhczcH7Wp/B957sse8y9aprgIHkoI4ZIZoQ0kqZoyY0Smq58cfL6i64idqQWO/tNArnUqbHlclIjoWdPdUCFVPbvoMqVmwXwTCyNJ79v6YeUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=135ghavu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B/5mky08; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=135ghavu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B/5mky08; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="135ghavu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B/5mky08";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="135ghavu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B/5mky08"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D3B4B21EDD;
	Wed, 24 Jan 2024 06:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706076708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ua+VdJ2UQxBgQh0LDzAaAFUIYy6hxYHokKGdi/rYbbs=;
	b=135ghavuSSLb/qgempi40IBLCibJuZ5+meq2+utUBAA7agseEalaJg2PNFjCc0KRU1qXVL
	T12qGGtPSZcQ8c6GaMEVorQppQp/FqefVlGMaNyLrKdMoPuE7Wf0nz2wpMY6OG0j5o8Azy
	YKc3z/xGuWuBDMQV8wExUHzmDJ5ACoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706076708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ua+VdJ2UQxBgQh0LDzAaAFUIYy6hxYHokKGdi/rYbbs=;
	b=B/5mky08MDidi3jQWb3LjGouBXZfE0mejA6B7dtCuPa90aiooViZl+zOkSZD0mmAviKKKp
	s56Me8HQkaNIeCCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706076708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ua+VdJ2UQxBgQh0LDzAaAFUIYy6hxYHokKGdi/rYbbs=;
	b=135ghavuSSLb/qgempi40IBLCibJuZ5+meq2+utUBAA7agseEalaJg2PNFjCc0KRU1qXVL
	T12qGGtPSZcQ8c6GaMEVorQppQp/FqefVlGMaNyLrKdMoPuE7Wf0nz2wpMY6OG0j5o8Azy
	YKc3z/xGuWuBDMQV8wExUHzmDJ5ACoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706076708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ua+VdJ2UQxBgQh0LDzAaAFUIYy6hxYHokKGdi/rYbbs=;
	b=B/5mky08MDidi3jQWb3LjGouBXZfE0mejA6B7dtCuPa90aiooViZl+zOkSZD0mmAviKKKp
	s56Me8HQkaNIeCCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 486DE1333E;
	Wed, 24 Jan 2024 06:11:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qGpyDCSqsGVVRwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 24 Jan 2024 06:11:48 +0000
Message-ID: <822f3536-26fa-4e5f-b87d-94be9209c16e@suse.de>
Date: Wed, 24 Jan 2024 07:11:48 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] nvme: remove the hack to not update the discard
 limits in nvme_config_discard
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
 <20240122173645.1686078-7-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240122173645.1686078-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.31)[75.35%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,lst.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.40

On 1/22/24 18:36, Christoph Hellwig wrote:
> Now that the block layer tracks a separate user max discard limit, there
> is no need to prevent nvme from updating it on controller capability
> changes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 10 ----------
>   1 file changed, 10 deletions(-)
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

