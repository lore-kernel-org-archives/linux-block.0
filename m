Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C14A15AF6
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 06:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706076057; cv=none; b=reLBptW02P/hDYFN6Hj3G1Dn9vBk+u36/I5Co3AunEUqf5FlR9WLuvscwgopMQX9SZpK2V5TXIUdg2dg2zQLKqN55UVP3p6YDNJr4V5x/NPMr5GaLEiN0/Jr0qItrSv3YFB/Z+vEtKAir+UXDdPA/Gx+gHPM6dpt0gLEDVveeZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706076057; c=relaxed/simple;
	bh=6ty2KcsW0oJ1YiphRixvv63VtjBliN9AH/UJbv5qWFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPVRIMsCybdBNuQgucGPGbWR9KtpZezWSTwfB6bJ2Ko981QvR7x1EfIoapD1uaApqWEDHlnL7MFb93wsOBZL9Mg6yt4fRu0AddtDSZ8ZqYmKs91WNkHwGxkR5jLyHmv5F/I2W436pE95cRS53XJ/gfj1mWsOvWVNscYj1pHcaiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YP8H8xRM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0YYk9OXw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YP8H8xRM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0YYk9OXw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YP8H8xRM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0YYk9OXw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YP8H8xRM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0YYk9OXw"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 854FF222D0;
	Wed, 24 Jan 2024 06:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706076052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHvr9EmiU91Nl1qjGrSy31HV1Xzl+Wi1nMYRXRmA/P4=;
	b=YP8H8xRMjggbMhyQv8o2VtPBj4pusl0yvTOIlL7iAp/nD3KGfwbDkaAkKZR70eQv9swR9e
	Ijvn9LXj6+UHzbERHxw3a4pZp02JHAQ0u5jA9WNeTghAhlTsux23Bma8v2BOjGylbtU8Fl
	HY94XMv7p4ph8PEKXe/TaWkPeJ8w6qI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706076052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHvr9EmiU91Nl1qjGrSy31HV1Xzl+Wi1nMYRXRmA/P4=;
	b=0YYk9OXwbakA1ekpalJAuVy3sZcHuuW0RpZvENqS+y1SWuFd7MvAYjRHPqLJRVl/supIQq
	GJSC44vOwR0S7mDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706076052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHvr9EmiU91Nl1qjGrSy31HV1Xzl+Wi1nMYRXRmA/P4=;
	b=YP8H8xRMjggbMhyQv8o2VtPBj4pusl0yvTOIlL7iAp/nD3KGfwbDkaAkKZR70eQv9swR9e
	Ijvn9LXj6+UHzbERHxw3a4pZp02JHAQ0u5jA9WNeTghAhlTsux23Bma8v2BOjGylbtU8Fl
	HY94XMv7p4ph8PEKXe/TaWkPeJ8w6qI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706076052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHvr9EmiU91Nl1qjGrSy31HV1Xzl+Wi1nMYRXRmA/P4=;
	b=0YYk9OXwbakA1ekpalJAuVy3sZcHuuW0RpZvENqS+y1SWuFd7MvAYjRHPqLJRVl/supIQq
	GJSC44vOwR0S7mDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04BF61333E;
	Wed, 24 Jan 2024 06:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZBgHO5OnsGXkRQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 24 Jan 2024 06:00:51 +0000
Message-ID: <fad45fca-1421-4f4c-b044-7d0d95d6405a@suse.de>
Date: Wed, 24 Jan 2024 07:00:52 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] block: move max_{open,active}_zones to struct
 queue_limits
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
 <20240122173645.1686078-2-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240122173645.1686078-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.44
X-Spamd-Result: default: False [-1.44 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.15)[68.69%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 1/22/24 18:36, Christoph Hellwig wrote:
> The maximum number of open and active zones is a limit on the queue
> and should be places there so that we can including it in the upcoming
> queue limits batch update API.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/blkdev.h | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
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

