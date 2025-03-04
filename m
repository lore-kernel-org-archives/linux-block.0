Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA4329B21A
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102192; cv=none; b=ow9qXfW5+KdiT530Yb367clbP7ubVvMhU5ug2Be+r7CDFxmViXVDtPxRwoGRtNupsLlmYqukHizynqEyPsJEfz6366jf3ijnLT90xg2Obpo0LXWF9Vmk8/NdHuvHdOYdhtcIQWfVx90Hije79YxdRIR0wWvlnAkqwwX3iE+Zb9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102192; c=relaxed/simple;
	bh=PPE6zKH4h9sRSXTAI14TW04uU/QuuHCeJZVitYlAe+w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tm0iWvpyWxqe9dFRwyMEwtSeWfxyqA5fMiCcMc8UacQnrMoTSxlhxSkdxMSlnQn2bAAtAaE7EnATyFyreCaqfVgmS0EoG1CmjooicRFoVDsziRZlMdZRg4Kiz0IpkNBVyFd+RMJXzXOcQJ+c4CIY+mh4NQg4ZRnAnCFTAyjLNcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RE/go9Yi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OEQzgZWX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RE/go9Yi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OEQzgZWX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RE/go9Yi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OEQzgZWX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RE/go9Yi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OEQzgZWX"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 24DCB2119E;
	Tue,  4 Mar 2025 15:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741102188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wUNX38N8od0pSQB4Oki1DA+O8/wAji44uxALcbahVhE=;
	b=RE/go9YicsRzV3B2vBPWdPWdIBkawTf8QFI6qsJSCN1CIMN2uaHzYHttBw24DsrXTelOEQ
	tFqAl9b0V1nUSHBfuxu0YiY6eA9U99kd9qYXfMxdkzWFw3VG0QCzq4PjsGBvDfAZ2EPj6t
	WthWVcbabKuZggv+YV2yp8edyuLaERY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741102188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wUNX38N8od0pSQB4Oki1DA+O8/wAji44uxALcbahVhE=;
	b=OEQzgZWXVNyzwEwQk/fOgUlXq3bC/s6xosaObP9eLXgwh1Cyu1UviAVWdZuWt6O2VY4wfm
	Unr1sHRUaX0gl2Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="RE/go9Yi";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OEQzgZWX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741102188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wUNX38N8od0pSQB4Oki1DA+O8/wAji44uxALcbahVhE=;
	b=RE/go9YicsRzV3B2vBPWdPWdIBkawTf8QFI6qsJSCN1CIMN2uaHzYHttBw24DsrXTelOEQ
	tFqAl9b0V1nUSHBfuxu0YiY6eA9U99kd9qYXfMxdkzWFw3VG0QCzq4PjsGBvDfAZ2EPj6t
	WthWVcbabKuZggv+YV2yp8edyuLaERY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741102188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wUNX38N8od0pSQB4Oki1DA+O8/wAji44uxALcbahVhE=;
	b=OEQzgZWXVNyzwEwQk/fOgUlXq3bC/s6xosaObP9eLXgwh1Cyu1UviAVWdZuWt6O2VY4wfm
	Unr1sHRUaX0gl2Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08F3213967;
	Tue,  4 Mar 2025 15:29:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8BHLAWwcx2ecRQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 04 Mar 2025 15:29:48 +0000
Message-ID: <3a1b72be-6e2a-4b74-91f5-d51d230d22b5@suse.cz>
Date: Tue, 4 Mar 2025 16:29:47 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel oops with 6.14 when enabling TLS
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: Hannes Reinecke <hare@suse.com>, Hannes Reinecke <hare@suse.de>,
 Matthew Wilcox <willy@infradead.org>, Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <08c29e4b-2f71-4b6d-8046-27e407214d8c@suse.com>
 <509dd4d3-85e9-40b2-a967-8c937909a1bf@suse.com>
 <Z8W8OtJYFzr9OQac@casper.infradead.org>
 <Z8W_1l7lCFqMiwXV@casper.infradead.org>
 <15be2446-f096-45b9-aaf3-b371a694049d@suse.com>
 <Z8XPYNw4BSAWPAWT@casper.infradead.org>
 <edf65d4e-90f0-4b12-b04f-35e97974a36f@suse.cz>
 <95b0b93b-3b27-4482-8965-01963cc8beb8@suse.cz>
 <fcfa11c6-2738-4a2e-baa8-09fa8f79cbf3@suse.de>
 <a466b577-6156-4501-9756-1e9960aa4891@suse.cz>
 <6877dfb1-9f44-4023-bb6d-e7530d03e33c@suse.com>
 <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 24DCB2119E
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[suse.com,suse.de,infradead.org,nvidia.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 3/4/25 11:26, Vlastimil Babka wrote:
> +Cc NETWORKING [TLS] maintainers and netdev for input, thanks.
> 
> The full error is here:
> https://lore.kernel.org/all/fcfa11c6-2738-4a2e-baa8-09fa8f79cbf3@suse.de/
> 
> On 3/4/25 11:20, Hannes Reinecke wrote:
>> On 3/4/25 09:18, Vlastimil Babka wrote:
>>> On 3/4/25 08:58, Hannes Reinecke wrote:
>>>> On 3/3/25 23:02, Vlastimil Babka wrote:
>>>>> On 3/3/25 17:15, Vlastimil Babka wrote:
>>>>>> On 3/3/25 16:48, Matthew Wilcox wrote:
>>>>>>> You need to turn on the debugging options Vlastimil mentioned and try to
>>>>>>> figure out what nvme is doing wrong.
>>>>>>
>>>>>> Agree, looks like some error path going wrong?
>>>>>> Since there seems to be actual non-large kmalloc usage involved, another
>>>>>> debug parameter that could help: CONFIG_SLUB_DEBUG=y, and boot with
>>>>>> "slab_debug=FZPU,kmalloc-*"
>>>>>
>>>>> Also make sure you have CONFIG_DEBUG_VM please.
>>>>>
>>>> Here you go:
>>>>
>>>> [  134.506802] page: refcount:0 mapcount:0 mapping:0000000000000000
>>>> index:0x0 pfn:0x101ef8
>>>> [  134.509253] head: order:3 mapcount:0 entire_mapcount:0
>>>> nr_pages_mapped:0 pincount:0
>>>> [  134.511594] flags:
>>>> 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
>>>> [  134.513556] page_type: f5(slab)
>>>> [  134.513563] raw: 0017ffffc0000040 ffff888100041b00 ffffea0004a90810
>>>> ffff8881000402f0
>>>> [  134.513568] raw: 0000000000000000 00000000000a000a 00000000f5000000
>>>> 0000000000000000
>>>> [  134.513572] head: 0017ffffc0000040 ffff888100041b00 ffffea0004a90810
>>>> ffff8881000402f0
>>>> [  134.513575] head: 0000000000000000 00000000000a000a 00000000f5000000
>>>> 0000000000000000
>>>> [  134.513579] head: 0017ffffc0000003 ffffea000407be01 ffffffffffffffff
>>>> 0000000000000000
>>>> [  134.513583] head: 0000000000000008 0000000000000000 00000000ffffffff
>>>> 0000000000000000
>>>> [  134.513585] page dumped because: VM_BUG_ON_FOLIO(((unsigned int)
>>>> folio_ref_count(folio) + 127u <= 127u))
>>>> [  134.513615] ------------[ cut here ]------------
>>>> [  134.529822] kernel BUG at ./include/linux/mm.h:1455!
>>> 
>>> Yeah, just as I suspected, folio_get() says the refcount is 0.
>>> 
>>>> [  134.529835] Oops: invalid opcode: 0000 [#1] PREEMPT SMP
>>>> DEBUG_PAGEALLOC NOPTI
>>>> [  134.529843] CPU: 0 UID: 0 PID: 274 Comm: kworker/0:1H Kdump: loaded
>>>> Tainted: G            E      6.14.0-rc4-default+ #309
>>>> 03b131f1ef70944969b40df9d90a283ed638556f
>>>> [  134.536577] Tainted: [E]=UNSIGNED_MODULE
>>>> [  134.536580] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>>>> 0.0.0 02/06/2015
>>>> [  134.536583] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
>>>> [  134.536595] RIP: 0010:__iov_iter_get_pages_alloc+0x676/0x710
>>>> [  134.542810] Code: e8 4c 39 e0 49 0f 47 c4 48 01 45 08 48 29 45 18 e9
>>>> 90 fa ff ff 48 83 ef 01 e9 7f fe ff ff 48 c7 c6 40 57 4f 82 e8 6a e2 ce
>>>> ff <0f> 0b e8 43 b8 b1 ff eb c5 f7 c1 ff 0f 00 00 48 89 cf 0f 85 4f ff
>>>> [  134.542816] RSP: 0018:ffffc900004579d8 EFLAGS: 00010282
>>>> [  134.542821] RAX: 000000000000005c RBX: ffffc90000457a90 RCX:
>>>> 0000000000000027
>>>> [  134.542825] RDX: 0000000000000000 RSI: 0000000000000002 RDI:
>>>> ffff88817f423748
>>>> [  134.542828] RBP: ffffc90000457d60 R08: 0000000000000000 R09:
>>>> 0000000000000001
>>>> [  134.554485] R10: ffffc900004579c0 R11: ffffc90000457720 R12:
>>>> 0000000000000000
>>>> [  134.554488] R13: ffffea000407be40 R14: ffffc90000457a70 R15:
>>>> ffffc90000457d60
>>>> [  134.554495] FS:  0000000000000000(0000) GS:ffff88817f400000(0000)
>>>> knlGS:0000000000000000
>>>> [  134.554499] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [  134.554502] CR2: 0000556b0675b600 CR3: 0000000106bd8000 CR4:
>>>> 0000000000350ef0
>>>> [  134.554509] Call Trace:
>>>> [  134.554512]  <TASK>
>>>> [  134.554516]  ? __die_body+0x1a/0x60
>>>> [  134.554525]  ? die+0x38/0x60
>>>> [  134.554531]  ? do_trap+0x10f/0x120
>>>> [  134.554538]  ? __iov_iter_get_pages_alloc+0x676/0x710
>>>> [  134.568839]  ? do_error_trap+0x64/0xa0
>>>> [  134.568847]  ? __iov_iter_get_pages_alloc+0x676/0x710
>>>> [  134.568855]  ? exc_invalid_op+0x53/0x60
>>>> [  134.572489]  ? __iov_iter_get_pages_alloc+0x676/0x710
>>>> [  134.572496]  ? asm_exc_invalid_op+0x16/0x20
>>>> [  134.572512]  ? __iov_iter_get_pages_alloc+0x676/0x710
>>>> [  134.576726]  ? __iov_iter_get_pages_alloc+0x676/0x710
>>>> [  134.576733]  ? srso_return_thunk+0x5/0x5f
>>>> [  134.576740]  ? ___slab_alloc+0x924/0xb60
>>>> [  134.580253]  ? mempool_alloc_noprof+0x41/0x190
>>>> [  134.580262]  ? tls_get_rec+0x3d/0x1b0 [tls
>>>> 47f199c97f69357468c91efdbba24395e9dbfa77]
>>>> [  134.580282]  iov_iter_get_pages2+0x19/0x30
>>> 
>>> Presumably that's __iov_iter_get_pages_alloc() doing get_page() either in
>>> the " if (iov_iter_is_bvec(i)) " branch or via iter_folioq_get_pages()?
>>> 
>> Looks like it.
>> 
>>> Which doesn't work for a sub-size kmalloc() from a slab folio, which after
>>> the frozen refcount conversion no longer supports get_page().
>>> 
>>> The question is if this is a mistake specific for this path that's easy to
>>> fix or there are more paths that do this. At the very least the pinning of
>>> page through a kmalloc() allocation from it is useless - the object itself
>>> has to be kfree()'d and that would never happen through a put_page()
>>> reaching zero.
>>> 
>> Looks like a specific mistake.
>> tls_sw is the only user of sk_msg_zerocopy_from_iter()
>> (which is calling into __iov_iter_get_pages_alloc()).

That's from tls_sw_sendmsg_locked(), right? But that's under:

if (!is_kvec && (full_record || eor) && !async_capable) {

Shouldn't is_kvec be true if we're dealing a kernel buffer (kmalloc()) there?

>> And, more to the point, tls_sw messes up iov pacing coming in from
>> the upper layers.
>> So even if the upper layers send individual iovs (where each iov might
>> contain different allocation types), tls_sw is packing them together 
>> into full records. So it might end up with iovs having _different_ 
>> allocations.
>> Which would explain why we only see it with TLS, but not with normal
>> connections.
>> 
>> Or so my reasoning goes. Not sure if that's correct.
>> 
>> So I'd be happy with an 'easy' fix for now. Obviously :-)
>> 
>> Cheers,
>> 
>> Hannes
> 

