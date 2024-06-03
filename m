Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503323BBF3;
	Mon,  3 Jun 2024 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405526; cv=none; b=UEzt4EhpFr1uLWLzdCLOL+0EfNei+LEJGKD8awbBD4+bF3msuMSznOGa6z5W3PuSRf4WZQluS78GxXsbVZIYFjfJTo7JJQZE2EMOCwZcqzI/8pdBPaeQHBHGLcaxGgCspR7s+mLlRNQxkFhJtPKLCO93X9JTjK/5b1OEXLC7NII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405526; c=relaxed/simple;
	bh=z3NTm7cVxmNTzl47hibxjvllGfDTN9yK1sU3vj/kIsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onaaPzZe6fZC21TLEuWBcbIJUs6HoxTAfYVuWlpendYRsWU0oRIH50F52aJnaRnf0hVY9R7fWVsfR7nBxecvQkLyODf3ko0CDKXW4KlPT8Tld3UYZhA1jU1ILGHYSga2kcVqeFE7sLJ9JvuXp6u1cdEsgh5G5H8ZLBUG8CK3HEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ee3GXsiY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ju5ZNMMN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ee3GXsiY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ju5ZNMMN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ee3GXsiY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ju5ZNMMN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ee3GXsiY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ju5ZNMMN"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5FE4420011;
	Mon,  3 Jun 2024 09:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717405521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8dVW93I3hjqS2K8Xe8A47EbrmxilI3hZM/aZ3B81X0=;
	b=ee3GXsiYW5a8UMiXPjPb/MtfihL5qsO+VszqwaRXVbVFnxhMz/ppUSKax3KFPyfX7BkLnV
	OzWUJgnffGIV5u5sVBXMx7Ojzdn3527AYedNgKwN8Y1IGtJwl+ijHFaEebCdSnu7tC0WtI
	u3hYozbT8DQFgwOXjsVH/VYEpV4+H/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717405521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8dVW93I3hjqS2K8Xe8A47EbrmxilI3hZM/aZ3B81X0=;
	b=Ju5ZNMMNvG8YRAb2KwGeHlV2hdGu0b2wVXM2LrEiZIr2qvEO8cEvG+ve+B8JhuuqM/yIRl
	4Y1g3lqmSWkFryCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717405521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8dVW93I3hjqS2K8Xe8A47EbrmxilI3hZM/aZ3B81X0=;
	b=ee3GXsiYW5a8UMiXPjPb/MtfihL5qsO+VszqwaRXVbVFnxhMz/ppUSKax3KFPyfX7BkLnV
	OzWUJgnffGIV5u5sVBXMx7Ojzdn3527AYedNgKwN8Y1IGtJwl+ijHFaEebCdSnu7tC0WtI
	u3hYozbT8DQFgwOXjsVH/VYEpV4+H/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717405521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8dVW93I3hjqS2K8Xe8A47EbrmxilI3hZM/aZ3B81X0=;
	b=Ju5ZNMMNvG8YRAb2KwGeHlV2hdGu0b2wVXM2LrEiZIr2qvEO8cEvG+ve+B8JhuuqM/yIRl
	4Y1g3lqmSWkFryCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDFD613A93;
	Mon,  3 Jun 2024 09:05:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PQ9sOVCHXWY5eQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Jun 2024 09:05:20 +0000
Message-ID: <0a47eebd-2aca-494d-814b-bc949b08630b@suse.de>
Date: Mon, 3 Jun 2024 11:05:19 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] rust: block: add rnull, Rust null_blk
 implementation
To: Keith Busch <kbusch@kernel.org>, Andreas Hindborg <nmi@metaspace.dk>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
 Ming Lei <ming.lei@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>,
 =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
 Joel Granados <j.granados@samsung.com>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Daniel Gomez <da.gomez@samsung.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Philipp Stanner <pstanner@redhat.com>, Conor Dooley <conor@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>,
 open list <linux-kernel@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>
References: <20240601134005.621714-1-nmi@metaspace.dk>
 <20240601134005.621714-3-nmi@metaspace.dk>
 <ZlsvHV6y4DEdC8ja@kbusch-mbp.dhcp.thefacebook.com>
 <875xusoetn.fsf@metaspace.dk>
 <ZltF5NvDnKFphcOo@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZltF5NvDnKFphcOo@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,protonmail.com];
	FREEMAIL_CC(0.00)[kernel.dk,lst.de,kernel.org,acm.org,redhat.com,vger.kernel.org,samsung.com,linuxfoundation.org,infradead.org,gmail.com,garyguo.net,protonmail.com,proton.me,google.com,nvidia.com,bupt.edu.cn,pankajraghav.com,wdc.com,bjorling.me,lists.linux-foundation.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLhytspa9b8ghbrab87o1fjg5u)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On 6/1/24 18:01, Keith Busch wrote:
> On Sat, Jun 01, 2024 at 05:36:20PM +0200, Andreas Hindborg wrote:
>> Keith Busch <kbusch@kernel.org> writes:
>>
>>> On Sat, Jun 01, 2024 at 03:40:04PM +0200, Andreas Hindborg wrote:
>>>> +impl kernel::Module for NullBlkModule {
>>>> +    fn init(_module: &'static ThisModule) -> Result<Self> {
>>>> +        pr_info!("Rust null_blk loaded\n");
>>>> +        let tagset = Arc::pin_init(TagSet::try_new(1, 256, 1), flags::GFP_KERNEL)?;
>>>> +
>>>> +        let disk = {
>>>> +            let block_size: u16 = 4096;
>>>> +            if block_size % 512 != 0 || !(512..=4096).contains(&block_size) {
>>>> +                return Err(kernel::error::code::EINVAL);
>>>> +            }
>>>
>>> You've set block_size to the literal 4096, then validate its value
>>> immediately after? Am I missing some way this could ever be invalid?
>>
>> Good catch. It is because I have a patch in the outbound queue that allows setting
>> the block size via a module parameter. The module parameter patch is not
>> upstream yet. Once I have that up, I will send the patch with the block
>> size config.
>>
>> Do you think it is OK to have this redundancy? It would only be for a
>> few cycles.
> 
> It's fine, just wondering why it's there. But it also allows values like
> 1536 and 3584, which are not valid block sizes, so I think you want the
> check to be:
> 
> 	if !(512..=4096).contains(&block_size) || ((block_size & (block_size - 1)) != 0)
> 
Can't we overload .contains() to check only power-of-2 values?

Cheers,

Hannes

