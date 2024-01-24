Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A6FF517
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 06:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706077311; cv=none; b=bskPQ6fO1StIMIVyt6QaPtnsxauVavtTEBBVrWZEtDQ7l8WoBxpHlU6WXTRsWu8H+txTG1ILpp4zZnhGyWOY5NwL96j02aCilxGp9lBCFxeD3ZxdId+ASgmHEMlgDte2Z2ULhvdtm9rdaFC4euzYqn2GJzxLwpB3Tz2OtrY3igE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706077311; c=relaxed/simple;
	bh=36HcRQZHop7jwDviesPgLrurAHjnyFq0TKQ6QzMtDm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAqvdQV2XVv6IhyfyIdPVApV4PDsATcgeTo5KoRs5q9kBhHQ0dCoI2nueRTSQFHgN0jWcA065ujZrsOkiamS9gizEhWH5fvIAlHVxV6DBsNih1b9eVTAzmBwPKGAfTvvBNFZpqY7Gvvod4iJEJkQXzphK8vg+LEDQS2bkSeZn/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OcBJYEaq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UtJ/Y4/a; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OcBJYEaq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UtJ/Y4/a; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OcBJYEaq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UtJ/Y4/a";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OcBJYEaq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UtJ/Y4/a"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BDD8C1F7DA;
	Wed, 24 Jan 2024 06:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706077308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saDeMbAzLob4LbnsJ507b3fcQrwF4Wt+ekrSNVr53GQ=;
	b=OcBJYEaqUOgv9lwN1vTc987LVEBH+2d7b/NZybpJo4QltQN5d1haGboR6wh3z9lXvMO9fZ
	aGj+clxexrULutf3Blfwc+h6hVQ6CHuCzbm03I/XhCqQRquY61+SrxblsxzESiAxwQbl9X
	8fP0lhgnYTUDKrxEmHVQK5lEEnq87+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706077308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saDeMbAzLob4LbnsJ507b3fcQrwF4Wt+ekrSNVr53GQ=;
	b=UtJ/Y4/axPa7uPix22zDHgREmYnQmh5jEiNcgIqHw72IBQnwtebokSNxZ/6pDhDbuz7W1W
	Rz4LOV7HUzBTGnCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706077308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saDeMbAzLob4LbnsJ507b3fcQrwF4Wt+ekrSNVr53GQ=;
	b=OcBJYEaqUOgv9lwN1vTc987LVEBH+2d7b/NZybpJo4QltQN5d1haGboR6wh3z9lXvMO9fZ
	aGj+clxexrULutf3Blfwc+h6hVQ6CHuCzbm03I/XhCqQRquY61+SrxblsxzESiAxwQbl9X
	8fP0lhgnYTUDKrxEmHVQK5lEEnq87+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706077308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saDeMbAzLob4LbnsJ507b3fcQrwF4Wt+ekrSNVr53GQ=;
	b=UtJ/Y4/axPa7uPix22zDHgREmYnQmh5jEiNcgIqHw72IBQnwtebokSNxZ/6pDhDbuz7W1W
	Rz4LOV7HUzBTGnCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F36BC1333E;
	Wed, 24 Jan 2024 06:21:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mM+aOXussGWZSQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 24 Jan 2024 06:21:47 +0000
Message-ID: <64efa028-87a5-4030-96b8-f436b1ee60bc@suse.de>
Date: Wed, 24 Jan 2024 07:21:47 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] loop: cleanup loop_config_discard
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
 <20240122173645.1686078-14-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240122173645.1686078-14-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OcBJYEaq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="UtJ/Y4/a"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.44 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.44)[91.25%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.44
X-Rspamd-Queue-Id: BDD8C1F7DA
X-Spam-Flag: NO

On 1/22/24 18:36, Christoph Hellwig wrote:
> Initialize the local variables for the discard max sectors and
> granularity to zero as a sensible default, and then merge the
> calls assigning them to the queue limits.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/loop.c | 27 ++++++++-------------------
>   1 file changed, 8 insertions(+), 19 deletions(-)
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

