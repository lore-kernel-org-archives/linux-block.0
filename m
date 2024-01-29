Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB79845976
	for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706508717; cv=none; b=P1q5DVKPAswOEqOkOsou5RvB+3Dnw3fMeIvcZ5KXhCodawwDyQfMt3NKfhC7jRFB3L6UsGDjUMfHR7/KE+j/NxVK3a2tmAFdbNrKGOnDMOLq7HfdFf3oJLLufAfYTjJLY1TwzFY4scqvu7lnvw7zgY9P6yuLlA70TwxVmjTSoJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706508717; c=relaxed/simple;
	bh=UaQkEnMYi2BN4m5wBJSKGXubqymmzIm+30VvqRYvpak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VzacejathJM60Ku9sXgNs1MSpNGWrtF+G3EUqOtBb5SJqRBFWGIHSJZxCJpB1LU8UdwokEJegkQRNVXXAXrNf3fso2PpeCYw7PPIQTotnPFGNZ7v/2268rvQ041yYz7nIZAsNyUZW3VnfuOXrt/AupFsdmapTAMEHJB2elShKhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ewk8koO/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=prVrk2pb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v50bw1YI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3KIONblc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ewk8koO/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="prVrk2pb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v50bw1YI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3KIONblc"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E83761F7D1;
	Mon, 29 Jan 2024 06:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706508714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddu+U64xtjg+pkz7EZ+7fFB4LAA/cmY94lZh0HXlHC8=;
	b=ewk8koO/0sGWLzAM9bQL8rMrAnXh/dCf6YqaWb76tQvXw761iumRQ2T/ZhkFT8aHspE89K
	+eg/yinl9qkirzwXEhNUNsE3d/sUp6zOBThju34q/0v/CaZSt3T1gA/m56u3fSFootdQ9O
	G9uRr0iWPvIc2rTPsLUdNS03jEIxMWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706508714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddu+U64xtjg+pkz7EZ+7fFB4LAA/cmY94lZh0HXlHC8=;
	b=prVrk2pb8+gAD/sGtmV0qM1MLb0eG111iocGHPng6QGyJDLmxxPOpgZhaFVwABMbWJ7/nQ
	q+vLeD9bbm5vN7Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706508713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddu+U64xtjg+pkz7EZ+7fFB4LAA/cmY94lZh0HXlHC8=;
	b=v50bw1YIXZ0qKkQDnruORo23f1hev5+UteKCs38hyyi6V5+5gYKmYoKbkXpfP0K3xG6N3/
	k0gzYsTv59mQ5eXMPRhibX6No9gWDHCw4DK7V/vIrVH30/MZVTkOxj4ZT3a7ygHGOo4hN8
	2ta6q4+Mkl04bWyiKN5TB/jZPXR2yfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706508713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddu+U64xtjg+pkz7EZ+7fFB4LAA/cmY94lZh0HXlHC8=;
	b=3KIONblcoMtJoNUZBgp2/bxEOBlHDpaj4IB0MKfQp2LfHXul++OTZV4myxzSVSdeB/dWeQ
	v/mcVuJuHJaqofDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 546B512FF7;
	Mon, 29 Jan 2024 06:11:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lDlPEqlBt2UVRQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 29 Jan 2024 06:11:53 +0000
Message-ID: <4b4c9b22-a2f0-4727-8238-90b73a70828b@suse.de>
Date: Mon, 29 Jan 2024 07:11:52 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] block: add an API to atomically update queue limits
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240128165813.3213508-1-hch@lst.de>
 <20240128165813.3213508-4-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240128165813.3213508-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.01)[49.10%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.10

On 1/28/24 17:58, Christoph Hellwig wrote:
> Add a new queue_limits_{start,commit}_update pair of functions that
> allows taking an atomic snapshot of queue limits, update it, and
> commit it if it passes validity checking.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c       |   1 +
>   block/blk-settings.c   | 182 +++++++++++++++++++++++++++++++++++++++++
>   block/blk.h            |   1 +
>   include/linux/blkdev.h |  23 ++++++
>   4 files changed, 207 insertions(+)
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

