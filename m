Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BD95A79B
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413798; cv=none; b=rS/mK1vzqlzPks53sY6XCgr5dlaT18oTnKJXWBO/JBhZBiUPXjq5FMte05Q77IvfxbJzHFlysoMKLfe7X/axqwOMiFGYeS8plYgL7jBk8+lCqMqGv47xZLoYD0tWRoROlVZOeQYZklYnCMbrNevMNWmGup8K8HtJG+9qkgdsrco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413798; c=relaxed/simple;
	bh=AU++OVBAjcfFthdZaMJBi9qwNWaqFXsoinwFRk2pw+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFKSYV4fqckYyPMU+VyVSJjGeaPIT66aTpi1+/uaPC7P+kQVQbpgk0mqkpqG0cU6LVcViTEkJbx2suTsa3T85OlnLZOtF3iREF++8wHasi3D/2RY+qXTIhrIKrOXhO0V5W6YuSFOQnseYIlfTmTovHTImwb8RFJEFJtZvkPGMW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a5iokN0a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JUHdhqih; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a5iokN0a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JUHdhqih; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a5iokN0a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JUHdhqih";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a5iokN0a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JUHdhqih"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2DFA221E39;
	Tue, 20 Feb 2024 07:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708413795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hqYC094o1E9qeQHY3eiC+Xmx0vlYYpDJi84/HXvLzfI=;
	b=a5iokN0a2kjwnm1Du/P2jAxQGriSsnf6UXsHsm9Qbsx5gRdsqTF0XG0hy8SZz5Lxq7dl5G
	jCexDERZ9FLbZRT1OGS8b8hAgv4Ja+foVm5vi6YUzgYdb7bFR3NDEO+ze47UH9ek5eb26Q
	qhs+RQUnkcq2DWZ9ebn0TSamuz8OUsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708413795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hqYC094o1E9qeQHY3eiC+Xmx0vlYYpDJi84/HXvLzfI=;
	b=JUHdhqihaFPsbnVdPQirma2/QvGkVYpP6BQGeWWa0JCFAAq9+DKZeSbsc7KqCJ6QmQUBMK
	7PMxt5btD4hXanCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708413795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hqYC094o1E9qeQHY3eiC+Xmx0vlYYpDJi84/HXvLzfI=;
	b=a5iokN0a2kjwnm1Du/P2jAxQGriSsnf6UXsHsm9Qbsx5gRdsqTF0XG0hy8SZz5Lxq7dl5G
	jCexDERZ9FLbZRT1OGS8b8hAgv4Ja+foVm5vi6YUzgYdb7bFR3NDEO+ze47UH9ek5eb26Q
	qhs+RQUnkcq2DWZ9ebn0TSamuz8OUsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708413795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hqYC094o1E9qeQHY3eiC+Xmx0vlYYpDJi84/HXvLzfI=;
	b=JUHdhqihaFPsbnVdPQirma2/QvGkVYpP6BQGeWWa0JCFAAq9+DKZeSbsc7KqCJ6QmQUBMK
	7PMxt5btD4hXanCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7D7C134E4;
	Tue, 20 Feb 2024 07:23:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oC8uL2JT1GUpRQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 20 Feb 2024 07:23:14 +0000
Message-ID: <2558ae2a-32cf-4994-a00c-a7c01c2cc9ad@suse.de>
Date: Tue, 20 Feb 2024 08:23:13 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] null_blk: pass queue_limits to blk_mq_alloc_disk
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240220053303.3211004-1-hch@lst.de>
 <20240220053303.3211004-6-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240220053303.3211004-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.41 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.32)[96.86%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,wdc.com:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.41

On 2/20/24 06:33, Christoph Hellwig wrote:
> Pass the queue limits directly to blk_mq_alloc_disk instead of
> setting them one at a time.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Tested-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/block/null_blk/main.c     | 41 +++++++++++++++----------------
>   drivers/block/null_blk/null_blk.h |  2 +-
>   drivers/block/null_blk/zoned.c    | 15 ++++++-----
>   3 files changed, 28 insertions(+), 30 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

