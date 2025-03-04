Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422F31FCFC2
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 10:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083619; cv=none; b=fLTmlpUrMv8rTxsROWGxpHSZ3SU58mtpsew9vdZPeP6wwrNYMoobIILtRhGKVUaNgDCRgH0q5Xvr/DPm8Kjt7cAszA9uDYAh1ggkMPoSdbbFJYni7L/R2quONouk7h6REaMbBwa5pSP2U14JXzl6E5FAzlmSICR3g9Vp/76g5cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083619; c=relaxed/simple;
	bh=U2EcBkhb4T4CKHMyktSp8XaskuGZa3nqmOzgA6Yqcdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubSjSU44fNEc/5kgHjERkkIutISoVilrAWyaziuJ4E3cbGbmaXV0E5Tct+kCj1f9CKW9e9fY8gVImNRRrzdhKQcI2xwlsfM2IbI2UguC0K9jFORztTEXmVqTR+lB7j66ooDYMXdm+Z7ncjdAE1Q4jfHltxBe0e98QHx5AF8/gSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AzT635k3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AzT635k3"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390d98ae34dso4409927f8f.3
        for <linux-block@vger.kernel.org>; Tue, 04 Mar 2025 02:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741083615; x=1741688415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mM6uhVuxdq3yTuuEuc4jtPzNlL9cRg4isSUjeaJbmAs=;
        b=AzT635k3i++f1rSldjDkBLNvWjwz7rds2N33rYyDDUg+sxj8wbZcuRU1ULqckjRArp
         J/GNQU8CcPD5HNhprigdGGvQMk3hOUff5HB5GYvU95zapxFaCUqpOWZWMHh3EYsaiF4C
         yBq004L//mp/NQmLQQGC8Lkj3buDf9OTbaYxe0K55niJL9dLspNWm2LUTRmbEcWfSdmX
         y0iPDJdu24Eh3OWKNf7k1mKn0O8OdsNzVEuzJWS+M6Buv2Kh7iGNh+8GkgYe47qyIyBt
         j9cgogoSjtpAw6H8FmGJ2MEVJqFXG3yu4de04BZSLsoXwyjuaFnJbuWkKkoIllFE8KEw
         Vdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741083615; x=1741688415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mM6uhVuxdq3yTuuEuc4jtPzNlL9cRg4isSUjeaJbmAs=;
        b=NmAn1fT7T1vv9Wc26P7U5YQdcBXCjX8yAcQpD+BC4q4Gx+C+0W0fil6zEjPGCEsd1W
         LtgZvGMSj1KwA/32D73ADU7KaI0rsf8D7WT705YD5rHWv/UsaUS6+dgtf19at6g7gmSn
         GzWIC1xp0dDcgZkRXlTxEgy8bcC0PcSjV/0bEtxhTCLMssxAEF6jMHGsEcZK/OZnC5Hy
         bcfPBkbvhC9bNLBdyewF29oP4bXywUrV5d1PvFJLZQ/MHFC+vGhLGdHxbA/j1fl/+9FO
         4rzJSycnsJC2dpchmuxVLQ1MhWEOSZUKGWrSITlewL+VuFAmA+KtYYZOuYG6B6iAWyrs
         U/lA==
X-Forwarded-Encrypted: i=1; AJvYcCVY4nYj4aLVVePUnRL0+fDLKY05LUFGvpHRVWcsWtr/563r84IhnyjjdMI18pnBLOW4w+FL9H7uoAzXVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzF2yrRgflYzrn2r1iB6SRbTQU7eBvrTHkKUONiLQL7OV/T/t3+
	FU30zc5Hq3AF8/rl9lrM50/YYCt4clj0+AqaXMMIo1U6RURxNpHv98TE2t9kodE=
X-Gm-Gg: ASbGncvSUDaS9nA1qhFxc0JBcYvLiJ0AilQGo1sPJqeMABTGdb0N8QRKvDTqHhXGHMJ
	fWlsLRHJM5HAvCSCI9K0NOmg/ZfEJ5NoMAReGxw9apxGeijWWkY6SEyBmeuP+yXLsIhzN00xIz0
	ShSDXvHSiGriagcshrmBOc9NReZrjBikA38BYZSOxmR1/30qg3OOxiG8skK2YSOpX5tmmUjHWys
	r8fwQokomG+C4PjIDw7rA7C+qjF4WTUqa8maBmVqBH9BGyQJqGHxr98qIaihHVp+Omd7SVKvdXF
	93ebg6qa7nw+Xhp6xDfStdzthKOIBBznCdk1E2PP3mSzg3YkFBOzSZ/p6Y33Xv/iMalw9Q==
X-Google-Smtp-Source: AGHT+IEJYUHkHpDXnLexQIZ1xTZQsresalMyN3ct2lfKJwO55dx4NW2ku8asHz4sUsXDXgCX8DGrmg==
X-Received: by 2002:a5d:584d:0:b0:391:12a5:3cb3 with SMTP id ffacd0b85a97d-39112a53f00mr4610609f8f.3.1741083615391;
        Tue, 04 Mar 2025 02:20:15 -0800 (PST)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? (megane.afterburst.com. [2a01:4a0:11::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73703caesm189761065e9.12.2025.03.04.02.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 02:20:15 -0800 (PST)
Message-ID: <6877dfb1-9f44-4023-bb6d-e7530d03e33c@suse.com>
Date: Tue, 4 Mar 2025 11:20:14 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel oops with 6.14 when enabling TLS
To: Vlastimil Babka <vbabka@suse.cz>, Hannes Reinecke <hare@suse.de>,
 Matthew Wilcox <willy@infradead.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>
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
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <a466b577-6156-4501-9756-1e9960aa4891@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/4/25 09:18, Vlastimil Babka wrote:
> On 3/4/25 08:58, Hannes Reinecke wrote:
>> On 3/3/25 23:02, Vlastimil Babka wrote:
>>> On 3/3/25 17:15, Vlastimil Babka wrote:
>>>> On 3/3/25 16:48, Matthew Wilcox wrote:
>>>>> You need to turn on the debugging options Vlastimil mentioned and try to
>>>>> figure out what nvme is doing wrong.
>>>>
>>>> Agree, looks like some error path going wrong?
>>>> Since there seems to be actual non-large kmalloc usage involved, another
>>>> debug parameter that could help: CONFIG_SLUB_DEBUG=y, and boot with
>>>> "slab_debug=FZPU,kmalloc-*"
>>>
>>> Also make sure you have CONFIG_DEBUG_VM please.
>>>
>> Here you go:
>>
>> [  134.506802] page: refcount:0 mapcount:0 mapping:0000000000000000
>> index:0x0 pfn:0x101ef8
>> [  134.509253] head: order:3 mapcount:0 entire_mapcount:0
>> nr_pages_mapped:0 pincount:0
>> [  134.511594] flags:
>> 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
>> [  134.513556] page_type: f5(slab)
>> [  134.513563] raw: 0017ffffc0000040 ffff888100041b00 ffffea0004a90810
>> ffff8881000402f0
>> [  134.513568] raw: 0000000000000000 00000000000a000a 00000000f5000000
>> 0000000000000000
>> [  134.513572] head: 0017ffffc0000040 ffff888100041b00 ffffea0004a90810
>> ffff8881000402f0
>> [  134.513575] head: 0000000000000000 00000000000a000a 00000000f5000000
>> 0000000000000000
>> [  134.513579] head: 0017ffffc0000003 ffffea000407be01 ffffffffffffffff
>> 0000000000000000
>> [  134.513583] head: 0000000000000008 0000000000000000 00000000ffffffff
>> 0000000000000000
>> [  134.513585] page dumped because: VM_BUG_ON_FOLIO(((unsigned int)
>> folio_ref_count(folio) + 127u <= 127u))
>> [  134.513615] ------------[ cut here ]------------
>> [  134.529822] kernel BUG at ./include/linux/mm.h:1455!
> 
> Yeah, just as I suspected, folio_get() says the refcount is 0.
> 
>> [  134.529835] Oops: invalid opcode: 0000 [#1] PREEMPT SMP
>> DEBUG_PAGEALLOC NOPTI
>> [  134.529843] CPU: 0 UID: 0 PID: 274 Comm: kworker/0:1H Kdump: loaded
>> Tainted: G            E      6.14.0-rc4-default+ #309
>> 03b131f1ef70944969b40df9d90a283ed638556f
>> [  134.536577] Tainted: [E]=UNSIGNED_MODULE
>> [  134.536580] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>> 0.0.0 02/06/2015
>> [  134.536583] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
>> [  134.536595] RIP: 0010:__iov_iter_get_pages_alloc+0x676/0x710
>> [  134.542810] Code: e8 4c 39 e0 49 0f 47 c4 48 01 45 08 48 29 45 18 e9
>> 90 fa ff ff 48 83 ef 01 e9 7f fe ff ff 48 c7 c6 40 57 4f 82 e8 6a e2 ce
>> ff <0f> 0b e8 43 b8 b1 ff eb c5 f7 c1 ff 0f 00 00 48 89 cf 0f 85 4f ff
>> [  134.542816] RSP: 0018:ffffc900004579d8 EFLAGS: 00010282
>> [  134.542821] RAX: 000000000000005c RBX: ffffc90000457a90 RCX:
>> 0000000000000027
>> [  134.542825] RDX: 0000000000000000 RSI: 0000000000000002 RDI:
>> ffff88817f423748
>> [  134.542828] RBP: ffffc90000457d60 R08: 0000000000000000 R09:
>> 0000000000000001
>> [  134.554485] R10: ffffc900004579c0 R11: ffffc90000457720 R12:
>> 0000000000000000
>> [  134.554488] R13: ffffea000407be40 R14: ffffc90000457a70 R15:
>> ffffc90000457d60
>> [  134.554495] FS:  0000000000000000(0000) GS:ffff88817f400000(0000)
>> knlGS:0000000000000000
>> [  134.554499] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  134.554502] CR2: 0000556b0675b600 CR3: 0000000106bd8000 CR4:
>> 0000000000350ef0
>> [  134.554509] Call Trace:
>> [  134.554512]  <TASK>
>> [  134.554516]  ? __die_body+0x1a/0x60
>> [  134.554525]  ? die+0x38/0x60
>> [  134.554531]  ? do_trap+0x10f/0x120
>> [  134.554538]  ? __iov_iter_get_pages_alloc+0x676/0x710
>> [  134.568839]  ? do_error_trap+0x64/0xa0
>> [  134.568847]  ? __iov_iter_get_pages_alloc+0x676/0x710
>> [  134.568855]  ? exc_invalid_op+0x53/0x60
>> [  134.572489]  ? __iov_iter_get_pages_alloc+0x676/0x710
>> [  134.572496]  ? asm_exc_invalid_op+0x16/0x20
>> [  134.572512]  ? __iov_iter_get_pages_alloc+0x676/0x710
>> [  134.576726]  ? __iov_iter_get_pages_alloc+0x676/0x710
>> [  134.576733]  ? srso_return_thunk+0x5/0x5f
>> [  134.576740]  ? ___slab_alloc+0x924/0xb60
>> [  134.580253]  ? mempool_alloc_noprof+0x41/0x190
>> [  134.580262]  ? tls_get_rec+0x3d/0x1b0 [tls
>> 47f199c97f69357468c91efdbba24395e9dbfa77]
>> [  134.580282]  iov_iter_get_pages2+0x19/0x30
> 
> Presumably that's __iov_iter_get_pages_alloc() doing get_page() either in
> the " if (iov_iter_is_bvec(i)) " branch or via iter_folioq_get_pages()?
> 
Looks like it.

> Which doesn't work for a sub-size kmalloc() from a slab folio, which after
> the frozen refcount conversion no longer supports get_page().
> 
> The question is if this is a mistake specific for this path that's easy to
> fix or there are more paths that do this. At the very least the pinning of
> page through a kmalloc() allocation from it is useless - the object itself
> has to be kfree()'d and that would never happen through a put_page()
> reaching zero.
> 
Looks like a specific mistake.
tls_sw is the only user of sk_msg_zerocopy_from_iter()
(which is calling into __iov_iter_get_pages_alloc()).

And, more to the point, tls_sw messes up iov pacing coming in from
the upper layers.
So even if the upper layers send individual iovs (where each iov might
contain different allocation types), tls_sw is packing them together 
into full records. So it might end up with iovs having _different_ 
allocations.
Which would explain why we only see it with TLS, but not with normal
connections.

Or so my reasoning goes. Not sure if that's correct.

So I'd be happy with an 'easy' fix for now. Obviously :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
