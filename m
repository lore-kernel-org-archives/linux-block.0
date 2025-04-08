Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63D8198A08
	for <linux-block@vger.kernel.org>; Tue,  8 Apr 2025 06:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092661; cv=none; b=R+kizZyjRrNLr5d2z0axAZ272YHOWrMaolaOayiBS1bswtBKVNaovKLwEhpEQw9JWHONAq1Lk4B7WWTjpfO28exT79tzfnrKfDO1sj1vvr2F5wj6YW2oJzYaShlD7XULHCDoyMgfIqRePaUeN/s9gYm3jsCtv6MmeOiVf3gCpKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092661; c=relaxed/simple;
	bh=BbjMwSneqqrBxj40taN5HBRkjZ+V8feoLI1QBnqS37k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5YPeTFGY5Y3IA8kooZi43Mj+ct0Zg1TDS8PlX3Q5aqHiNFzDQ9S2NANTX27libvpgSlJlghoKh00p9HDgaWi+mP0QoktxQB16PwF7dUerHtBgRBDGMYQqbDiFZs0JQFuvbuTzDOG5mXds3kEBr337CmNSQ9tX1/lZVI8CZeau0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hB2R5CC1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qqk9nfeI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hB2R5CC1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qqk9nfeI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hB2R5CC1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qqk9nfeI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hB2R5CC1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qqk9nfeI"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D368121160;
	Tue,  8 Apr 2025 06:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744092654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oj3NtTMaIdmS7f74bC9S8exgrmgilgWjdRpkYIVpsYg=;
	b=hB2R5CC13J5f2F9jzZ4zBglctMigPbWXk4fTWPJXxJp8xD1YU6h85/iTX0aoV7SXnUTnNX
	/JHXqnoBgWuxigtzjDwh7m3n8X7GyadA6WB5kY5lldHP5FgpdF31ivjVoHPyjpwWnrLkpe
	tm53WCV2MBHYGJvAnlXz5h/edye0ZC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744092654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oj3NtTMaIdmS7f74bC9S8exgrmgilgWjdRpkYIVpsYg=;
	b=Qqk9nfeIY2mqJVKCS0dZ4Q9X7yq/BgpIew3KBkTRGV+8dn++IjtsZpbkpOwIiiFCPnkNOa
	I6YJMJubnYg6g6Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744092654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oj3NtTMaIdmS7f74bC9S8exgrmgilgWjdRpkYIVpsYg=;
	b=hB2R5CC13J5f2F9jzZ4zBglctMigPbWXk4fTWPJXxJp8xD1YU6h85/iTX0aoV7SXnUTnNX
	/JHXqnoBgWuxigtzjDwh7m3n8X7GyadA6WB5kY5lldHP5FgpdF31ivjVoHPyjpwWnrLkpe
	tm53WCV2MBHYGJvAnlXz5h/edye0ZC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744092654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oj3NtTMaIdmS7f74bC9S8exgrmgilgWjdRpkYIVpsYg=;
	b=Qqk9nfeIY2mqJVKCS0dZ4Q9X7yq/BgpIew3KBkTRGV+8dn++IjtsZpbkpOwIiiFCPnkNOa
	I6YJMJubnYg6g6Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8721513A1E;
	Tue,  8 Apr 2025 06:10:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FxfsHu699GeGJQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 08 Apr 2025 06:10:54 +0000
Message-ID: <7b8c4805-a91f-4455-a021-e5d8b6078d8b@suse.de>
Date: Tue, 8 Apr 2025 08:10:54 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bio segment constraints
To: Sean Anderson <seanga2@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org, Zhihao Cheng <chengzhihao1@huawei.com>
References: <8dfd97ac-59e7-ae69-238a-85b7a2dae4f1@gmail.com>
 <8a232716-74f8-4bba-a514-d0f766492344@suse.de>
 <a0ffa9b9-8649-1b63-3d56-3fc45fdfda83@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <a0ffa9b9-8649-1b63-3d56-3fc45fdfda83@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 4/7/25 16:14, Sean Anderson wrote:
> On 4/7/25 03:10, Hannes Reinecke wrote:
>> On 4/6/25 21:40, Sean Anderson wrote:
>>> Hi all,
>>>
>>> I'm not really sure what guarantees the block layer makes regarding the
>>> segments in a bio as part of a request submitted to a block driver. As
>>> far as I can tell this is not documented anywhere. In particular,
>>>
>>> - Is bv_len aligned to SECTOR_SIZE?
>>
>> The block layer always uses a 512 byte sector size, so yes.
>>
>>> - To logical_sector_size?
>>
>> Not necessarily. Bvecs are a consecutive list of byte ranges which
>> make up the data portion of a bio.
>> The logical sector size is a property of the request queue, which is
>> applied when a request is formed from one or several bios.
>> For the request the overall length need to be a multiple of the logical
>> sector size, but not necessarily the individual bios.
> 
> Oh, so this is worse than I thought. So if you care about e.g. only 
> submitting I/O in units of logical_block_size, you have to combine
 > segments across the entire request.>
Well, yes, and no.
You might be seeing a request with several bios, each having small
bvecs. But in the driver you will want to use an iov iterator or map
it into a sg list via blk_rq_map_sg(), and then iterate over that
for submission.

[ .. ]
>>> - Can I somehow request to only get segments with bv_len aligned to
>>>    logical_sector_size? Or do I need to do my own coalescing and bounce
>>>    buffering for that?
>>>
>>
>> The driver surely can. You should be able to set 'max_segment_size' to
>> the logical block size, and that should give you what you want.
> 
> But couldn't I get segments smaller than that? max_segment_size seems like
> it would only restrict the maximum size, leaving the possibility open for
> smaller segments.
> 
As mentioned: individual segments might. The overall request still will 
adhere to the logical block size setting (ie it will never be smaller 
than the logical block size).

Maybe have a look at drivers/mtd/ubi/block.c. There the driver will
map the request onto a scatterlist, and then iterate over the sg entries
to read in the data.

Note: mapping onto a scatterlist will coalesce adjacent bvecs, so on the
scatterlist you will find only contiguous segments which adhere to the
logical block size linmitations.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
