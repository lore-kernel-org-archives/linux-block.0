Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861C51EF395
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745314246; cv=none; b=p6wVj0Vo8jPPj/8N9qE4PkJrC0ClfB1ZyDMUPnJa+2JwXaNKopi4RTu2nQb3bB+sV49sqnzsNuIG/3cwzZTE0s0nd/6q6grzI5YUqpLvRFERSfG8UbvLlZjq1u1lqDz8oJ3dUUtRZHPnKj67sXUrJjaHtPVtzr3HgckNszGNDG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745314246; c=relaxed/simple;
	bh=LCNEJoisySBIX1GTlsm/Qm8KNnoU9rD9YzBAO2Ayrxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecSNw7gJPMyqAXV9GH/JeIexv/DLh6fQdsQUy41xApI8O6EuFuDoJ5n9e3VZpl++WE/DMKvtplsBhjdzi95+ewe4iEM3X9Qq/+C322PhK+cQrgt3xhuiXen5XaWhYBdbV/z2ezqyq+TGyU2FhQEzBgsBf52qNCkWR1dG98ba+Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FaOjUw1t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9IWSSKIR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FaOjUw1t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9IWSSKIR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FaOjUw1t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9IWSSKIR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FaOjUw1t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9IWSSKIR"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B16A221179;
	Tue, 22 Apr 2025 09:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745314242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/0wNDSSPBApU9sdynDLKPLyoL2XCsKtKgTJE/XLudw=;
	b=FaOjUw1t8ywKMLcBM836zaWYwcfx3MewaJHTdxFs4OLctpNWYdYnqxYSmrMyiENrT9Sw+K
	0YooBaXAtyOwxVh7dN57W0sZnNYUqpKzGDTXiCe6DGySnzA7jomo8dU55PViRw+uhgjMLy
	PRUQqRqxV/q2EOh5AuWj8ef+a4xGLCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745314242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/0wNDSSPBApU9sdynDLKPLyoL2XCsKtKgTJE/XLudw=;
	b=9IWSSKIRyB1VsrmkaNfKP/6zWxO1F9kNnUi35RhhlugrjwdBUZxLKjjpXzH55CcOLT9+g0
	QFU6GUIi80sCYMDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FaOjUw1t;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9IWSSKIR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745314242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/0wNDSSPBApU9sdynDLKPLyoL2XCsKtKgTJE/XLudw=;
	b=FaOjUw1t8ywKMLcBM836zaWYwcfx3MewaJHTdxFs4OLctpNWYdYnqxYSmrMyiENrT9Sw+K
	0YooBaXAtyOwxVh7dN57W0sZnNYUqpKzGDTXiCe6DGySnzA7jomo8dU55PViRw+uhgjMLy
	PRUQqRqxV/q2EOh5AuWj8ef+a4xGLCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745314242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/0wNDSSPBApU9sdynDLKPLyoL2XCsKtKgTJE/XLudw=;
	b=9IWSSKIRyB1VsrmkaNfKP/6zWxO1F9kNnUi35RhhlugrjwdBUZxLKjjpXzH55CcOLT9+g0
	QFU6GUIi80sCYMDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A19F1139D5;
	Tue, 22 Apr 2025 09:30:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /FgLJ8JhB2ipZAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Apr 2025 09:30:42 +0000
Message-ID: <a7b3b9dd-f7ad-4bbb-a119-21bc5c2033be@suse.de>
Date: Tue, 22 Apr 2025 11:30:42 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] brd: use memcpy_{to,from]_page in brd_rw_bvec
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org
References: <20250421072641.1311040-1-hch@lst.de>
 <20250421072641.1311040-6-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250421072641.1311040-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B16A221179
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,lst.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/21/25 09:26, Christoph Hellwig wrote:
> Use the proper helpers to copy to/from potential highmem pages, which
> do a local instead of atomic kmap underneath, and perform
> flush_dcache_page where needed.  This also simplifies the code so much
> that the separate read write helpers are not required any more.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/brd.c | 57 ++++++++++-----------------------------------
>   1 file changed, 12 insertions(+), 45 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
