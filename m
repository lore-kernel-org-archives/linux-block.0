Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D072641F5D5;
	Thu, 27 Aug 2026 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851444; cv=none; b=GLNmndFHvT7hMA4LFoLAPYq1yOKQRaQGFBcpIqk3m/+B4Tko8yLd+57QUleBCSdykKu8R0BVZOBNEWaPqcFNXRc3Nz35jLNlqDZvE9TyujW1031OH11smtS/ITumAgIaAmgf19wN0rh0orhvB5wuGMkoBdrM7v19QhryHA+TG6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851444; c=relaxed/simple;
	bh=H5ZRMIE38fbrqt3mKWehWW9NwT08Qp2Sc2+mr9vS/as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMdx21Ywj2lkbjkW4VZxumdUJZ9xex+j5iyMQGHwf92a0M1VGCxYoNOxrxeT3etBUNP64zp8Xh1ws9L1vOsYQUxGgP4rfb7uiMCMtamBNixRnCPKeGj2To/dTAa6t2bc2Mk/skiJ+iGQTHYTejRPKHwmXCoJTk6fMufpIPuJoHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzLpiBjN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzLpiBjN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14011F000E9;
	Thu, 27 Aug 2026 17:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787851443;
	bh=BjfGfa7gS4D2wDK9mCCSlkjUdk96fAt8iFKlJ66xdXk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EzLpiBjNYRL+cecuiQoLhAzu7P8qyHCBg5rZkgBcp23SnYHYI83dN1J3k3hnXWUun
	 sf5NLBe4/3OssrfnO52PXIBY48h6Xl9YhU1d7FCXkCP2aLD0U1fdzcIBv3WdqSgFIz
	 hjadHXoPzSbMVpUQiJ+eVBHaNsUAcC6l+ka6F9DHPXTRCtvOgwIhoh0mup9ELuSwDL
	 MfL8FqK5PMcINwus6FEHP6gldl8wXFCgjAYaKrMo2JcyUVvoFRvoOWZfcgT/LyrVJu
	 9tcvciVYTK+I3cB2kbcTTqpwx3p1mK4QvoFlxEMKppupZfkHiMpFIOMhFXMGViy5Lu
	 9L8/+h48xIwDA==
Message-ID: <7fb30b85-ea60-45bd-aef2-494943b524a0@kernel.org>
Date: Thu, 27 Aug 2026 19:23:51 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/25] mm/fbatch: remove !CONFIG_SMP special case of
 folio_activate()
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Ackerley Tng <ackerleytng@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Binbin Wu <binbin.wu@linux.intel.com>, Christian Brauner
 <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Christoph Lameter <cl@gentwo.org>, Claudio Imbrenda
 <imbrenda@linux.ibm.com>, JP Kobryn <jp.kobryn@linux.dev>,
 Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
 Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>,
 Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Leonardo Bras <leobras.c@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Mel Gorman <mgorman@techsingularity.net>, Miaohe Lin <linmiaohe@huawei.com>,
 Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Qi Zheng <qi.zheng@linux.dev>,
 Rik van Riel <riel@surriel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>,
 Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
 <3f18ab7d-c12a-d2a3-4d3e-f9908f94f27d@google.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <3f18ab7d-c12a-d2a3-4d3e-f9908f94f27d@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 15:52, Hugh Dickins wrote:
> 3.0 commit eb709b0d062e ("mm: batch activate_page() to reduce lock
> contention") brought in an ifdef CONFIG_SMP around activate batching:
> https://lore.kernel.org/linux-mm/20100805140755.501af8a7.akpm@linux-foundation.org/
> shows a sensitivity to bloat that day, not any incompatibility with UP.
> 
> No other batching here has a UP alternative, and it's a bit confusing:
> simplify mm/folio.c a little by removing it now.
> 
> Certainly we can reduce UP bloat (and/or 32-bit bloat) by, say, lowering
> FOLIO_BATCH_SIZE from 31: traditionally 16, 14, 15, then raised to 31 by
> 6.9 commit 9cecde80aae0 ("mm: increase folio batch size"); or by giving
> just the static per-cpu folio batches a type of their own with a smaller
> array size on UP (1? or a little batching worthwhile even on UP?). But
> not right now, it's orthogonal to this series.
> 
> And I suspect that the old ifdef led to lru_activate being placed last,
> whereas it's usually the second most popular fbatch: move it there, to
> match cpu_needs_drain() comment "Check these in order of likelihood that
> they're not zero".
> 

This fits the theme of removing CONFIG_SMP conditionals where they are not
really warranted and cause maintenance overhead.

Let's see if this actually creates real problems we have to worry about.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
