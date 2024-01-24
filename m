Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C632F9C1
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 06:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706076891; cv=none; b=rlJX0BCvnjEjuMuQZbEfINEeEB9TvWED3CnLSfXWrDCPCRfC/fGaCMujWwb5Ouar/jCMWyhHPoRu12SLWO/OmWdlVgtBTGMvmNxmn6m8ouEbb1uf7rQWRWcza0PBEGl+jG8KsyST1SojMg416uzLrl5dO9zPjvN4gxhKXleeKlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706076891; c=relaxed/simple;
	bh=9mzFB/jQ1eO9kJpxrZ2x/3dFsUsNCLtF3xXgx7XrXTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTsvT2++UyvBOqvlR31WVG8jxhVzf6zb6O8c9rXd7sl9ujoTN+t+kYhCOaA9DTn+3VCQnnUFsgBPVGTc+gmJlGJcH1B+X6tBBAPTRueChimMARecRPot8+LLkUvwpMNwoxqgfl3lkOAOSpqhK5rlw+tOTuvgx2iOPNmwQJ0XN+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=068VQS8s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sUSnvxIn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=068VQS8s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sUSnvxIn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="068VQS8s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sUSnvxIn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="068VQS8s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sUSnvxIn"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5656121EDD;
	Wed, 24 Jan 2024 06:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706076888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uuCM8K4ayptl4YR2TxhMa98gjpiBHQkIkeB3JvgvkN0=;
	b=068VQS8s2slHw0SX8w1QfaoIVtEEpZxAE2ljrDmnrAPjcY5tTu645iiWF86Yfg036Xf81p
	d6iX0jKM3OCq4UQ+E+yxFZe9H3YnPTxTNsW0botJV5dgL8xEXk0MT9ywK/Y1YWkriiFXwH
	T8dQ4622CA+h6oljI77VXDcX/1/cFYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706076888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uuCM8K4ayptl4YR2TxhMa98gjpiBHQkIkeB3JvgvkN0=;
	b=sUSnvxIngHK8+1W0Jp/RDF6WSgNd+xIx4pjIg1tcqpvXCluIFgUVjM2gcp+8UMQgU+Z85e
	87bk5Zy2NjvoUYBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706076888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uuCM8K4ayptl4YR2TxhMa98gjpiBHQkIkeB3JvgvkN0=;
	b=068VQS8s2slHw0SX8w1QfaoIVtEEpZxAE2ljrDmnrAPjcY5tTu645iiWF86Yfg036Xf81p
	d6iX0jKM3OCq4UQ+E+yxFZe9H3YnPTxTNsW0botJV5dgL8xEXk0MT9ywK/Y1YWkriiFXwH
	T8dQ4622CA+h6oljI77VXDcX/1/cFYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706076888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uuCM8K4ayptl4YR2TxhMa98gjpiBHQkIkeB3JvgvkN0=;
	b=sUSnvxIngHK8+1W0Jp/RDF6WSgNd+xIx4pjIg1tcqpvXCluIFgUVjM2gcp+8UMQgU+Z85e
	87bk5Zy2NjvoUYBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF4061333E;
	Wed, 24 Jan 2024 06:14:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1CO4L9eqsGVhSAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 24 Jan 2024 06:14:47 +0000
Message-ID: <db68cfd1-924d-4943-9c96-1da32411840f@suse.de>
Date: Wed, 24 Jan 2024 07:14:47 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] block: pass a queue_limits argument to
 blk_alloc_queue
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
 <20240122173645.1686078-9-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240122173645.1686078-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=068VQS8s;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sUSnvxIn
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.06 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-1.06)[87.83%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -4.06
X-Rspamd-Queue-Id: 5656121EDD
X-Spam-Flag: NO

On 1/22/24 18:36, Christoph Hellwig wrote:
> Pass a queue_limits to blk_alloc_queue and apply it if non-NULL.  This
> will allow allocating queues with valid queue limits instead of setting
> the values one at a time later.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c | 28 +++++++++++++++++++++-------
>   block/blk-mq.c   |  6 +++---
>   block/blk.h      |  2 +-
>   block/genhd.c    |  4 ++--
>   4 files changed, 27 insertions(+), 13 deletions(-)
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

