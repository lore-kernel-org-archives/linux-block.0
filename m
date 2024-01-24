Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A65F513
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706076607; cv=none; b=VqH7vK+yEcnvMpUn7VVXp9nNhWu6c/0a58ROjrNTbMzchGWIZ+IxSU1aFWH1YGAxygVRTkx4UIP+Epw5lUU8hI/6itMgxIl1+caZUKtDTLKBJIisOTKGVVKm7ko9XT9gfz+BzOwocub35sdTYmk7VrkW4BravgsOiRl4kzcCDyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706076607; c=relaxed/simple;
	bh=1xKG5AloCVQeiM7VRZOJXq/03okUnmU7+H0LrOeD4c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZwnuQsx7+2FfJqgqjiURLPtPw5EOGi+DpLhvDAvEGsQL5Zq+zQx8O8sOfbDdvwljM/8TEEmr/Ukqb9JKyityoBdZu6scySETKV7ARfqvQT8jUFUAv94YM0UT15pWdrDJ0dTUrFg3XlkgHAFBoJzvdc2W8BeNFyMNQNbzWtelPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eqopH3YU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Cn7b3Slv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ldy7HYhn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KkWHmxI2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eqopH3YU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Cn7b3Slv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ldy7HYhn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KkWHmxI2"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 99F7621EDD;
	Wed, 24 Jan 2024 06:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706076598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvlpKBCqiZzPi9RWsvlPVUN5lL6TVn3wAfFpWndZF20=;
	b=eqopH3YUXMwKQ5LjDigLPwe56lXpe1rsZIT+8uipdmkmBbaAk3vvcIg2mKaq+LL0Ju10Lg
	2LxgeW0nVYX/jE0vkna6de1Zx5bHBYHsSoZcb2IbOxHq1H+sa1TsC1AwXtz0xj49863EIC
	WplUFDZxYMPF5UqZBcDl6SnIeZIQFyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706076598;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvlpKBCqiZzPi9RWsvlPVUN5lL6TVn3wAfFpWndZF20=;
	b=Cn7b3SlvE62eykKFWlz/3uOHThgSN8g8HMLIBSrwUuffXNwad+nBqbSen6DHZLvYgU8z6Z
	+SvOc3lUGFYuWBAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706076597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvlpKBCqiZzPi9RWsvlPVUN5lL6TVn3wAfFpWndZF20=;
	b=ldy7HYhnxe+GHCPUioiAkb5KYHwBG9kDTUKGm1O3gRh+JCgzWfscmSa01qrg5vV0tDPuKG
	Ci7d9/HMx9fWI751UQ3qJqapUj+WqoHu2Yi1+vqfYFnVpFSVGAsQ++hzNwnX7Ib6c7m6Y+
	J4L0vxJarP19Rbsb0CI8JP8hooKboUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706076597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvlpKBCqiZzPi9RWsvlPVUN5lL6TVn3wAfFpWndZF20=;
	b=KkWHmxI2aLGfu7Lh3WZ+Mkj4btIZlePnM7ZzmblXEmwyNp/U7iQ3pTvZ7yBxPspMQBdvbU
	d7iocOD2b27am4DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 029ED1333E;
	Wed, 24 Jan 2024 06:09:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wNsYN7SpsGVVRwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 24 Jan 2024 06:09:56 +0000
Message-ID: <895d824e-ab32-4abd-8b91-2d1af536b5f9@suse.de>
Date: Wed, 24 Jan 2024 07:09:56 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] block: use queue_limits_commit_update in
 queue_max_sectors_store
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
 <20240122173645.1686078-5-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240122173645.1686078-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ldy7HYhn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KkWHmxI2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.23 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.23)[72.54%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,lst.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -3.23
X-Rspamd-Queue-Id: 99F7621EDD
X-Spam-Flag: NO

On 1/22/24 18:36, Christoph Hellwig wrote:
> Convert queue_max_sectors_store to use queue_limits_commit_update to
> check and updated the max_sectors limit and freeze the queue before
> doing so to ensure we don't have request in flight while changing
> the limits.
> 
> Note that this removes the previously held queue_lock that doesn't
> protect against any other read or writer.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-sysfs.c | 37 ++++++++++++-------------------------
>   1 file changed, 12 insertions(+), 25 deletions(-)
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

