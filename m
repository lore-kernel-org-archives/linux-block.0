Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2CF168A8
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 06:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706076749; cv=none; b=St2VSu27FKSJubKG4jhfpxnF3BaNtLFqeczbftrNJ0xek0dy4PM9VHn6VnSaZ6kDrVztKU/nqKCp0n/zAAZvfw+TDluJdFP2rZrK02Ih6Yqocrf53IEEuaZAulOd9hCbnR98NyBuwUv8i5IEglYPcwYN1AvsCNH6Q762c1e1XOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706076749; c=relaxed/simple;
	bh=Ri83kwU+HgIDbJNjyWxEtSebRweAnOxd9yf3KwTUm0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kh7uAF8h3I5GEgcSTmspeFTBdsjcR+dMqTlyCgD5P4zaJIpwhSyg6tZwbtpYimF6PiXQBYLF65y1Bs29XdNr4NQq0OfQm+eLiIZkr0VNTC1OFKZzL0Fxrgcvj7M0mSH3c8bOIptw/TeptNhW/YwJ8Q5v396O4xuS12WPgLlzMpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z8KMZ1c3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FyFtRMW7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z8KMZ1c3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FyFtRMW7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z8KMZ1c3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FyFtRMW7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z8KMZ1c3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FyFtRMW7"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 381F11F7DA;
	Wed, 24 Jan 2024 06:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706076746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udd3HW/OJ3qxeYOiR3o1RLD5AKysJyGUjUBIu/iAPa4=;
	b=z8KMZ1c3vhEylryzpkiEtI77edu6jzcWHkQuZQHsZzLTu063QlXGaawLmP6LQ+JgZqGive
	NTicebaWWHx+tWxtQQ8uwDSVqb8A+UaSxKrQ0PCX5QFe8IXb6CbHw8Aj6ydgiC1zngAFgt
	vee9blyEOrFGYJ0hrhSl+Kj2VKqATJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706076746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udd3HW/OJ3qxeYOiR3o1RLD5AKysJyGUjUBIu/iAPa4=;
	b=FyFtRMW7GVAYVVe+BAWBDkagC/ZF1oe7ImYbEwwnQOqCAeg7/yb1QFhyqBUmO7maWRKl9B
	eE6askof2T5RwCDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706076746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udd3HW/OJ3qxeYOiR3o1RLD5AKysJyGUjUBIu/iAPa4=;
	b=z8KMZ1c3vhEylryzpkiEtI77edu6jzcWHkQuZQHsZzLTu063QlXGaawLmP6LQ+JgZqGive
	NTicebaWWHx+tWxtQQ8uwDSVqb8A+UaSxKrQ0PCX5QFe8IXb6CbHw8Aj6ydgiC1zngAFgt
	vee9blyEOrFGYJ0hrhSl+Kj2VKqATJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706076746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udd3HW/OJ3qxeYOiR3o1RLD5AKysJyGUjUBIu/iAPa4=;
	b=FyFtRMW7GVAYVVe+BAWBDkagC/ZF1oe7ImYbEwwnQOqCAeg7/yb1QFhyqBUmO7maWRKl9B
	eE6askof2T5RwCDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 905ED1333E;
	Wed, 24 Jan 2024 06:12:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cOfQHUmqsGVVRwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 24 Jan 2024 06:12:25 +0000
Message-ID: <a9b57560-5ebc-44b4-83cb-11a3205fec8c@suse.de>
Date: Wed, 24 Jan 2024 07:12:25 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] block: use queue_limits_commit_update in
 queue_discard_max_store
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
 <20240122173645.1686078-8-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240122173645.1686078-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.38
X-Spamd-Result: default: False [-1.38 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.09)[64.72%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 1/22/24 18:36, Christoph Hellwig wrote:
> Convert queue_discard_max_store to use queue_limits_commit_update to
> check and updated the max_sectors limit and freeze the queue before
> doing so to ensure we don't have request in flight while changing
> the limits.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-sysfs.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
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

