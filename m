Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B62F145B10
	for <linux-block@vger.kernel.org>; Mon, 13 May 2024 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607830; cv=none; b=FMwbtAa/neL8sf8TKQoV+1NAFsOLKZx0qTTKlNL9IP9h40gCXV6IyBb0AQdv69n/AT70iOxDsxNiCwca6DD+j/E58t/aIAI+prmR4zx8o35iN0Ibri7afHKhVZ8CNouF+Xj4iJ/7wZjI/tR8IJBx7j8CNdHKdKRyT4Ga1a7aDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607830; c=relaxed/simple;
	bh=l0ri98EqSaThNli0gUMegjWsssCLrpbatiKkZENY9H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkPKiOYGaKaRjZzXpj7i9BUHG62eAjPz87NXBBC4UKcFQzFhY2NJ3YWHwLKBcw/3akjHCvWEgeeW67XXFwj7V8Yhzx01JsBVi2e7Wl3VIHwa8ZcdsUJf5hVLhMZ3GSXztpXuB7v+CTyV2ArLk87aokpPpMpQDnwq3wwq79B9Yj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TYphToIw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OIM8kb9y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TYphToIw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OIM8kb9y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TYphToIw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OIM8kb9y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TYphToIw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OIM8kb9y"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4E86434A49;
	Mon, 13 May 2024 13:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715607827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmjIcVgM8ACRobh4KwNj0tmtHsSWloagIWh6SXnJlk4=;
	b=TYphToIwAaatHhDqMwqG0KNWEOT4IkVP5iNKWtbFYzcQxlnOzwOsbOkQh7QwUT7+VHE7iI
	fsVdoKQGBPl5bIo8G3kXesNJv4PBYuuYJ792F8PVGUFvYG9DX93CvnCZMTP9quMLDHEslg
	U/OaDNZ6TTBAzIzxAbyNRpLRveXr/wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715607827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmjIcVgM8ACRobh4KwNj0tmtHsSWloagIWh6SXnJlk4=;
	b=OIM8kb9yLdLSUix/3GGIQoPuXtNZbxnR7RNiIMnhcSKuzq95ER506AwY7m2apnSwVVeeCD
	GKmdsyEXSIJ9CeBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TYphToIw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OIM8kb9y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715607827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmjIcVgM8ACRobh4KwNj0tmtHsSWloagIWh6SXnJlk4=;
	b=TYphToIwAaatHhDqMwqG0KNWEOT4IkVP5iNKWtbFYzcQxlnOzwOsbOkQh7QwUT7+VHE7iI
	fsVdoKQGBPl5bIo8G3kXesNJv4PBYuuYJ792F8PVGUFvYG9DX93CvnCZMTP9quMLDHEslg
	U/OaDNZ6TTBAzIzxAbyNRpLRveXr/wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715607827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmjIcVgM8ACRobh4KwNj0tmtHsSWloagIWh6SXnJlk4=;
	b=OIM8kb9yLdLSUix/3GGIQoPuXtNZbxnR7RNiIMnhcSKuzq95ER506AwY7m2apnSwVVeeCD
	GKmdsyEXSIJ9CeBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB7B11372E;
	Mon, 13 May 2024 13:43:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id grMMKBAZQmY5EAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 May 2024 13:43:44 +0000
Message-ID: <f58dc322-b7d9-487c-854f-c7df953c6519@suse.de>
Date: Mon, 13 May 2024 15:43:38 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] nvme: enable logical block size > PAGE_SIZE
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>, Matthew Wilcox <willy@infradead.org>
Cc: hare@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Pankaj Raghav <kernel@pankajraghav.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-6-hare@kernel.org>
 <Zj_6vDMwyb2O6ztI@bombadil.infradead.org>
 <Zj__oIGiY8xzrwnb@casper.infradead.org>
 <ZkAEhFLVD9gSk0y0@bombadil.infradead.org>
 <ZkAszpvBkb5_UUiH@bombadil.infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZkAszpvBkb5_UUiH@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4E86434A49
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -6.50

On 5/12/24 04:43, Luis Chamberlain wrote:
> On Sat, May 11, 2024 at 04:51:32PM -0700, Luis Chamberlain wrote:
>> On Sun, May 12, 2024 at 12:30:40AM +0100, Matthew Wilcox wrote:
>>> On Sat, May 11, 2024 at 04:09:48PM -0700, Luis Chamberlain wrote:
>>>> We can't just do this, we need to consider the actual nvme cap (test it,
>>>> and if it crashes and below what the page cache supports, then we have
>>>> to go below) and so to make the enablment easier. So we could just move
>>>> this to helper [0]. Then when the bdev cache patch goes through the
>>>> check for CONFIG_BUFFER_HEAD can be removed, if this goes first.
>>>>
>>>> We crash if we go above 1 MiB today, we should be able to go up to 2
>>>> MiB but that requires some review to see what stupid thing is getting
>>>> in the way.
>>>>
>>>> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=20240408-lbs-scsi-kludge&id=1f7f4dce548cc11872e977939a872b107c68ad53
>>>
>>> This is overengineered garbage.  What's the crash?
>>
>> I had only tested it with iomap, I had not tested it with buffer-heads,
>> and so it would require re-testing. It's Saturday 5pm, I should be doing
>> something else other than being on my computer.
> 
> It crashes because we forgot two things in this series below, so the
> change below its us to enable to *at least* boot up to 64k LBA format on
> NVMe.
> 
> One can reproduce this with kdevops with:
> 
> make defconfig-lbs-xfs-bdev-nvme
> make bringup
> make linux
> 
> I've added another defconfig which bumps the LBA format up to 512 KiB to
> see if bootup blows up, that has another defconfig:
> 
> make lbs-xfs-bdev-large-nvme
> make bringup
> make linux
> 
> That at least booted. Note that the above defconfigs use this thread's
> message ID, so it applies this series on top of the min order branch.
> The patch below is just needed.
> 
> I'll try next going above 512 KiB.
>   
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 4f73d23c2c46..fa88e300a946 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2360,8 +2360,6 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>   	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
>   		limit = inode->i_sb->s_maxbytes;
>   
> -	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> -
>   	head = folio_create_buffers(folio, inode, 0);
>   	blocksize = head->b_size;
>   
> diff --git a/fs/mpage.c b/fs/mpage.c
> index e3732686e65f..e124c924b2e7 100644
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -178,7 +178,6 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>   	gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
>   
>   	/* MAX_BUF_PER_PAGE, for example */
> -	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
>   
>   	if (args->is_readahead) {
>   		opf |= REQ_RAHEAD;
> 
Thanks. Will be including that in the next round.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

