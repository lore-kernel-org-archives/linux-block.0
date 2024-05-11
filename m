Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D0B14005
	for <linux-block@vger.kernel.org>; Sat, 11 May 2024 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715418771; cv=none; b=ms9OF4Enb5/wIO//DnJaKX7xy6wZgzcVwr6PpiJSe/jH9qyWGf3ouvyJ0a+UW/y6u+byc4AfTS+wAR8jd39Yhl0OVvhKhg0I7b5JhWEAFTXf79KPZyCeMKjItspHoV5k0o2TPUShG4NJ1TBlnsmmLaMFqd8nwvGJh3K8ykAsXPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715418771; c=relaxed/simple;
	bh=N1uoxHakYrVriCYBtbiWqsnhXKFDiUtG8KYnH/+53BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IowHON5aNQZWLtaOQSgRdvG/1Xj1kGPD/Er41wTTnw+ntrasvvLP7FELsPycAzowOT6ddj6YhDJ6dxGGUkpFJeMegZOo4dotOkhSmdY4XFsB5zvSUbSunfZqe4cuXVXlp52/nyOxM8K9KEbztge6+wE6wjG45umBHm8f/QEr42E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E6TTRKjm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cV03JxGN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E6TTRKjm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cV03JxGN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E6TTRKjm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cV03JxGN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E6TTRKjm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cV03JxGN"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 622BD20B6A;
	Sat, 11 May 2024 09:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715418768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBv4mHLZJqDUPEnY1FKk08hMrS1asm0aCdIft0VM19E=;
	b=E6TTRKjmkq2v5R6exgQL+Jj4ZrlIYfP9cIiV19hYEsT6hE2AHi5w1uLk69St9IYyRWkaSn
	1CsZSfN8Aa9ZjmOLfg5ocfUzBza5S6IiauLdvApWvIsPWQSl454uMhzXthpb1f72BQbmAc
	f9ZjyQQ4UKpaF8SfVS4EWo3Z01l/x4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715418768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBv4mHLZJqDUPEnY1FKk08hMrS1asm0aCdIft0VM19E=;
	b=cV03JxGNEB2YesFiMp6dXqnqiRM5k6APWFSOccb+Ez2eU8q/9IE+II3bZchOPvHrDlyeJF
	6e8URuov8dF0LACQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E6TTRKjm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cV03JxGN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715418768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBv4mHLZJqDUPEnY1FKk08hMrS1asm0aCdIft0VM19E=;
	b=E6TTRKjmkq2v5R6exgQL+Jj4ZrlIYfP9cIiV19hYEsT6hE2AHi5w1uLk69St9IYyRWkaSn
	1CsZSfN8Aa9ZjmOLfg5ocfUzBza5S6IiauLdvApWvIsPWQSl454uMhzXthpb1f72BQbmAc
	f9ZjyQQ4UKpaF8SfVS4EWo3Z01l/x4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715418768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBv4mHLZJqDUPEnY1FKk08hMrS1asm0aCdIft0VM19E=;
	b=cV03JxGNEB2YesFiMp6dXqnqiRM5k6APWFSOccb+Ez2eU8q/9IE+II3bZchOPvHrDlyeJF
	6e8URuov8dF0LACQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D70813A3E;
	Sat, 11 May 2024 09:12:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5P8ZAZA2P2Y9JwAAD6G6ig
	(envelope-from <hare@suse.de>); Sat, 11 May 2024 09:12:48 +0000
Message-ID: <9918c372-9ecb-4e3c-9d36-058737491d93@suse.de>
Date: Sat, 11 May 2024 11:12:47 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] fs/mpage: use blocks_per_folio instead of
 blocks_per_page
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Pankaj Raghav <kernel@pankajraghav.com>, Luis Chamberlain
 <mcgrof@kernel.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-2-hare@kernel.org>
 <Zj6ddYvmb2uIq5Ec@casper.infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Zj6ddYvmb2uIq5Ec@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 622BD20B6A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.50

On 5/11/24 00:19, Matthew Wilcox wrote:
> On Fri, May 10, 2024 at 12:29:02PM +0200, hare@kernel.org wrote:
>> +++ b/fs/mpage.c
>> @@ -114,7 +114,7 @@ static void map_buffer_to_folio(struct folio *folio, struct buffer_head *bh,
>>   		 * don't make any buffers if there is only one buffer on
>>   		 * the folio and the folio just needs to be set up to date
>>   		 */
>> -		if (inode->i_blkbits == PAGE_SHIFT &&
>> +		if (inode->i_blkbits == folio_shift(folio) &&
> 
> yes
> 
>> @@ -160,7 +160,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>>   	struct folio *folio = args->folio;
>>   	struct inode *inode = folio->mapping->host;
>>   	const unsigned blkbits = inode->i_blkbits;
>> -	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
>> +	const unsigned blocks_per_folio = folio_size(folio) >> blkbits;
>>   	const unsigned blocksize = 1 << blkbits;
>>   	struct buffer_head *map_bh = &args->map_bh;
>>   	sector_t block_in_file;
>> @@ -168,7 +168,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>>   	sector_t last_block_in_file;
>>   	sector_t first_block;
>>   	unsigned page_block;
>> -	unsigned first_hole = blocks_per_page;
>> +	unsigned first_hole = blocks_per_folio;
> 
> yes
> 
>> @@ -189,7 +189,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>>   		goto confused;
>>   
>>   	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
>> -	last_block = block_in_file + args->nr_pages * blocks_per_page;
>> +	last_block = block_in_file + args->nr_pages * blocks_per_folio;
> 
> no.  args->nr_pages really is the number of pages, so last_block is
> block_in_file + nr_pages * blocks_per_page.  except that blocks_per_page
> might now be 0.
> 
> so i think this needs to be rewritten as:
> 
> 	last_block = block_in_file + (args->nr_pages * PAGE_SIZE) >> blkbits;
> 
> or have i confused myself?
> 
Aw. No. MIssed that line.

Will be fixing it up.


>> @@ -275,7 +275,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>>   		bdev = map_bh->b_bdev;
>>   	}
>>   
>> -	if (first_hole != blocks_per_page) {
>> +	if (first_hole != blocks_per_folio) {
>>   		folio_zero_segment(folio, first_hole << blkbits, PAGE_SIZE);
> 
> ... doesn't that need to be folio_size(folio)?
> 
> there may be other problems, but let's settle these questions first.
> 

Thanks for the review.
I'll be sure to pester you next week :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

