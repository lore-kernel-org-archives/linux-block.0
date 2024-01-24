Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67134F9E2
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 06:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706076661; cv=none; b=PjQnSrOWQUtwEPxwaB+pvJoStMJ8cs760gBD4CX4vlP3nkA3Ak4okyCuOgQlZF3u1+0swOxC63pGWErFg+udod8RrU+vPDzuF6nueWU3AezOIRAKKLn3y0prg2j6cWEIGgkxXG817RF0n5W82Zt73aIjTjDta0otyZlcsftXhH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706076661; c=relaxed/simple;
	bh=B1ZqAurKOnAchT3DXj5yx9w0sQzU7/nL+XdV/xYbyic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3M4MaheT0EcDlv/6ecQvkARw7GDZNip6+T6Hwa0SZxtWTNbRuIo4fOZgBlquzsoV3UOM8ZGR2ZjuO0chEGUJhDiLmSADxQFhXXl0vSitsQdv6hBJHSX1pIF2/Q23P7+RHmmCIfGEEgvX2f1LLa0iyMnEmvtHxMD3zxMnhVC5Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u8utl9dc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JBMPU3Kv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u8utl9dc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JBMPU3Kv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u8utl9dc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JBMPU3Kv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u8utl9dc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JBMPU3Kv"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B2BBA1F7DA;
	Wed, 24 Jan 2024 06:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706076658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2lr2QbuZmq3xr/8lS4baALtoR+HyKurF5geBOY4D50=;
	b=u8utl9dcTSZd+HuKeZk3L64RSLPW++BPZvzlfM2NpygMgNX65So1TwJuXKu8Cc3MVOVoZ5
	pYy0/u8u2ZwUuW4Tc38DbQyLTLjhC+47BASVfqHeWhF9BPj1pMBMSqME+c2uAgvSc0OXTz
	DA0c55jk7WBlsK2IloZzfZuKpMHgKuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706076658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2lr2QbuZmq3xr/8lS4baALtoR+HyKurF5geBOY4D50=;
	b=JBMPU3KvzXAdDbvm3MwMZKwdXpWi2C3qxLzEtq9L4ELqDF+HitI+25/2yMsym4sBoYUmyE
	Scjn5d3hupJGJsAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706076658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2lr2QbuZmq3xr/8lS4baALtoR+HyKurF5geBOY4D50=;
	b=u8utl9dcTSZd+HuKeZk3L64RSLPW++BPZvzlfM2NpygMgNX65So1TwJuXKu8Cc3MVOVoZ5
	pYy0/u8u2ZwUuW4Tc38DbQyLTLjhC+47BASVfqHeWhF9BPj1pMBMSqME+c2uAgvSc0OXTz
	DA0c55jk7WBlsK2IloZzfZuKpMHgKuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706076658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2lr2QbuZmq3xr/8lS4baALtoR+HyKurF5geBOY4D50=;
	b=JBMPU3KvzXAdDbvm3MwMZKwdXpWi2C3qxLzEtq9L4ELqDF+HitI+25/2yMsym4sBoYUmyE
	Scjn5d3hupJGJsAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3A1B1333E;
	Wed, 24 Jan 2024 06:10:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IPUgOPGpsGVVRwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 24 Jan 2024 06:10:57 +0000
Message-ID: <f10a068e-d855-4c4c-91b4-3dc8137bb3db@suse.de>
Date: Wed, 24 Jan 2024 07:10:57 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/15] block: add a max_user_discard_sectors queue limit
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
 <20240122173645.1686078-6-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240122173645.1686078-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u8utl9dc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JBMPU3Kv
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.09)[88.10%];
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
X-Spam-Score: -4.09
X-Rspamd-Queue-Id: B2BBA1F7DA
X-Spam-Flag: NO

On 1/22/24 18:36, Christoph Hellwig wrote:
> Add a new max_user_discard_sectors limit that mirrors max_user_sectors
> and stores the value that the user manually set.  This now allows
> updates of the max_hw_discard_sectors to not worry about the user
> limit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-settings.c   | 13 ++++++++++---
>   block/blk-sysfs.c      | 18 +++++++++---------
>   include/linux/blkdev.h |  1 +
>   3 files changed, 20 insertions(+), 12 deletions(-)
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

