Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF46227CB0A
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105958; cv=none; b=ciHsNYNtH/9h7QtJxDKDWjpcJ3feaPJdAqb7itDg70y2bCftHjeycDTnsWrQCiE/6j77zWw7g1lg3UnIyfVaK5d616QZF42nj4Bowl6bMlIZCKQW8CjHTdOApIFdn+ZeAAKMNmhw2lDtIDcR0egNFrr5Qr6qSsQVyHeSXZX7v3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105958; c=relaxed/simple;
	bh=ny+4Brc+hbmz2X5IkOBkCRuyw+9KNy/JizxcqzexIMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zxu6Q9Gl9ex0AJT8JyaR7VNlskzvD+BhO9Mb7mj42dBeAFXMQpC/qJoFVD/mUOPM+uVeyp0eSwNwWKQiSQp8zMJix+BAs9lFKVvcgsTJ60oC8dYrcQLok6bjOMTQVu+dyeu0jz39KGP1lFY/sYWAGKP9Bqg8Isug90qHXu5lq/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=baB3r3nh; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="baB3r3nh"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso4767419f8f.0
        for <linux-block@vger.kernel.org>; Tue, 04 Mar 2025 08:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741105954; x=1741710754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jc0fHINLgpRpFjBoumMxo+EFHaGqMPVtOaRHH1CUD+c=;
        b=baB3r3nh3TlgvhwuFSiRpPsN5MaM6I/3+Sra9xir2dDuFg/x9SRr8XIAnsfjfWH7HR
         C17WBoQMVwOaDMGR/8O0rsQNyqNvmp8DRUw8cL4gY6hyuHbZJI/XNoirN5gkTeI+iCIu
         C29iRoYAEUwKm182t7zamhP3q2TeVSuHggG9sR09UpzRffMSwcvZrlKk+UIpnldPVY4c
         JboMY4By8SUhgq2+oZ/3mfKSOOmESpJxR1SnXqp6EwHZU9/QrBqPOL3mX0tZb/HRZG6G
         1Phq4wIgLrKKOuXHb/SuSrLkBM+RpmLVCiqF3+LkgqQPqUHpzQ7GYwOBznguvxNgGkmN
         3juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741105954; x=1741710754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jc0fHINLgpRpFjBoumMxo+EFHaGqMPVtOaRHH1CUD+c=;
        b=LJSNgxquUyq2Z2Uj+ZOfgwD+KsbnkYwh3zXYv8f/jtExqSt3iU73NNm6DABMeeU0rN
         9g42CV7RL2+lN3SzDK0djYqWaSnNe9oHzX+iTd1zUXBOB2GYLi2SZJ3pO02jmsD5heAm
         Hyfo1Eu1ss/Nj4PQgWO2Uvzq4zdPw3ihRrMXPA4P31xv0IztutlsG2PnRBMsmKgKGk8p
         yoOPjqtsjyrm9Z4zdB69MMSD7QndfIyqcoy/P5nHlTMAfvXngLgmla3iPcmsmQz5/uh/
         yLzKMF8ffgvoutwoIYgTTislQ+a3n1R3jSCJk1jFJou0UberTYdllkK6d6c6rjz36EIT
         TXww==
X-Forwarded-Encrypted: i=1; AJvYcCVDRVjyd1ZG81fsBequ9bkYY8nBWUhkedzQ3evYzZdpCnHb9oRc+EehnasI9LEY/GEtknpGM3fl51tFIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuhwE77byMtkAc9LgpT7goOah62SupUgtaAFBwjO+2l8g5xll1
	vBjyFwzrJXCsamDVOaKq35fCvf99WV3y0GcsLcaDfaz1309FmNBOII1IEJ4qB2M=
X-Gm-Gg: ASbGncsJlMLevb/jF6aZqluoitYtX45GbWGbxWgRm7MmuVwnJdyJsLeSEGWL0zAVRTH
	J82JA3zVSvNhlhnKx9rJVFRkKVa3tD40CDh7oP5wnMAURp4VcFlMQO6lU2PhDwlt1hdArcKb8k/
	2ilk0ypvaPwdT9BJveRop22pT2WP/8c388rVjlXjIJ6lL/qYwUBK8qMW0Wq+6szQC1aPwUwz+rg
	zJ1CRiGDRYRDxOu2GMoRhEOltalLrJ8oDxPfvlrLIcT14maaQkfsmYYq2WGz41F1k5uGsTrx4ZW
	TqV6YlqkR2udw7ROh+VE8pYz58o7KODY68k2H00LuoQ5AnuqkqEwl4OiXvlYeXSTSwM7hDRf3/v
	qyre8zpPixCZNKcw=
X-Google-Smtp-Source: AGHT+IE9XHPKCWYKHmfXqhIFhQbBA+5LnUK+LBGTEc5R7+PxSq+ocpU3+RvEvLUOWl1sPoOEowzQ0Q==
X-Received: by 2002:a05:6000:154e:b0:390:fe2d:3172 with SMTP id ffacd0b85a97d-391155fa457mr3008728f8f.3.1741105953921;
        Tue, 04 Mar 2025 08:32:33 -0800 (PST)
Received: from [192.168.178.47] (aftr-62-216-202-126.dynamic.mnet-online.de. [62.216.202.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7a2asm18282891f8f.37.2025.03.04.08.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 08:32:33 -0800 (PST)
Message-ID: <a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com>
Date: Tue, 4 Mar 2025 17:32:32 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel oops with 6.14 when enabling TLS
To: Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <Z8W8OtJYFzr9OQac@casper.infradead.org>
 <Z8W_1l7lCFqMiwXV@casper.infradead.org>
 <15be2446-f096-45b9-aaf3-b371a694049d@suse.com>
 <Z8XPYNw4BSAWPAWT@casper.infradead.org>
 <edf65d4e-90f0-4b12-b04f-35e97974a36f@suse.cz>
 <95b0b93b-3b27-4482-8965-01963cc8beb8@suse.cz>
 <fcfa11c6-2738-4a2e-baa8-09fa8f79cbf3@suse.de>
 <a466b577-6156-4501-9756-1e9960aa4891@suse.cz>
 <6877dfb1-9f44-4023-bb6d-e7530d03e33c@suse.com>
 <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>
 <Z8cm5bVJsbskj4kC@casper.infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <Z8cm5bVJsbskj4kC@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/4/25 17:14, Matthew Wilcox wrote:
> On Tue, Mar 04, 2025 at 11:26:07AM +0100, Vlastimil Babka wrote:
>> +Cc NETWORKING [TLS] maintainers and netdev for input, thanks.
>>
>> The full error is here:
>> https://lore.kernel.org/all/fcfa11c6-2738-4a2e-baa8-09fa8f79cbf3@suse.de/
>>
>> On 3/4/25 11:20, Hannes Reinecke wrote:
>>> On 3/4/25 09:18, Vlastimil Babka wrote:
>>>> On 3/4/25 08:58, Hannes Reinecke wrote:
>>>>> On 3/3/25 23:02, Vlastimil Babka wrote:
>>>>>> Also make sure you have CONFIG_DEBUG_VM please.
>>>>>>
>>>>> Here you go:
>>>>>
>>>>> [  134.506802] page: refcount:0 mapcount:0 mapping:0000000000000000
>>>>> index:0x0 pfn:0x101ef8
>>>>> [  134.509253] head: order:3 mapcount:0 entire_mapcount:0
>>>>> nr_pages_mapped:0 pincount:0
>>>>> [  134.511594] flags:
>>>>> 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
>>>>> [  134.513556] page_type: f5(slab)
>>>>> [  134.513563] raw: 0017ffffc0000040 ffff888100041b00 ffffea0004a90810
>>>>> ffff8881000402f0
>>>>> [  134.513568] raw: 0000000000000000 00000000000a000a 00000000f5000000
>>>>> 0000000000000000
>>>>> [  134.513572] head: 0017ffffc0000040 ffff888100041b00 ffffea0004a90810
>>>>> ffff8881000402f0
>>>>> [  134.513575] head: 0000000000000000 00000000000a000a 00000000f5000000
>>>>> 0000000000000000
>>>>> [  134.513579] head: 0017ffffc0000003 ffffea000407be01 ffffffffffffffff
>>>>> 0000000000000000
>>>>> [  134.513583] head: 0000000000000008 0000000000000000 00000000ffffffff
>>>>> 0000000000000000
>>>>> [  134.513585] page dumped because: VM_BUG_ON_FOLIO(((unsigned int)
>>>>> folio_ref_count(folio) + 127u <= 127u))
>>>>> [  134.513615] ------------[ cut here ]------------
>>>>> [  134.529822] kernel BUG at ./include/linux/mm.h:1455!
>>>>
>>>> Yeah, just as I suspected, folio_get() says the refcount is 0.
> 
> ... and it has a page_type of f5 (slab)
> 
>>>>> [  134.554509] Call Trace:
>>>>> [  134.580282]  iov_iter_get_pages2+0x19/0x30
>>>>
>>>> Presumably that's __iov_iter_get_pages_alloc() doing get_page() either in
>>>> the " if (iov_iter_is_bvec(i)) " branch or via iter_folioq_get_pages()?
> 
> It's the bvec path:
> 
>                  iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
> 
>>>> Which doesn't work for a sub-size kmalloc() from a slab folio, which after
>>>> the frozen refcount conversion no longer supports get_page().
>>>>
>>>> The question is if this is a mistake specific for this path that's easy to
>>>> fix or there are more paths that do this. At the very least the pinning of
>>>> page through a kmalloc() allocation from it is useless - the object itself
>>>> has to be kfree()'d and that would never happen through a put_page()
>>>> reaching zero.
>>>>
>>> Looks like a specific mistake.
>>> tls_sw is the only user of sk_msg_zerocopy_from_iter()
>>> (which is calling into __iov_iter_get_pages_alloc()).
>>>
>>> And, more to the point, tls_sw messes up iov pacing coming in from
>>> the upper layers.
>>> So even if the upper layers send individual iovs (where each iov might
>>> contain different allocation types), tls_sw is packing them together
>>> into full records. So it might end up with iovs having _different_
>>> allocations.
>>> Which would explain why we only see it with TLS, but not with normal
>>> connections.
> 
> I thought we'd done all the work needed to get rid of these pointless
> refcount bumps.  Turns out that's only on the block side (eg commit
> e4cc64657bec).  So what does networking need in order to understand
> that some iovecs do not need to mess with the refcount?

The network stack needs to get hold of the page while transmission is 
ongoing, as there is potentially rather deep queueing involved,
requiring several calls to sendmsg() and friends before the page is 
finally transmitted. And maybe some post-processing (checksums,
digests, you name it), too, all of which require the page to be there.

It's all so jumbled up ... personally, I would _love_ to do away with
__iov_iter_get_pages_alloc(). Allocating a page array? Seriously?

And the problem with that is that it's always takes a page(!) reference,
completely oblivious to the fact whether you even _can_ take a page 
reference (eg for tail pages); we've hit this problem several times now
(check for sendpage_ok() ...).

But that's not the real issue; real issue is that the page reference is
taken down in the very bowels of __iov_iter_get_pages_alloc(), but needs
to be undone by the _caller_. Who might (or might not) have an idea
that he needs to drop the reference here.
That's why there is no straightforward conversion; you need to audit
each and every caller and try to find out where the page reference (if 
any) is dropped.
Bah.

Can't we (at the very least) leave it to the caller of 
__iov_iter_get_pages() to get a page reference (he has access to the 
page array, after all ...)? That would make the interface slightly
better, and it'll be far more obvious to the caller what needs
to be done.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
