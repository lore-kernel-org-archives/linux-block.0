Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509BA572688;
	Tue,  8 Sep 2026 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882901; cv=none; b=OnO4c3a/cgXJC5qYsugJ35Gq4aEl8lDTQjSu8M5tFziJHN0l6bkZHAfM1H50TXzH6Mj0GVcGiXo8+CZ5E2dCAE3yj1sYVJTz7zVoAWyP09RKfATSovKN7tpyon+aS6N6p0uK8sJnIno9Hhh0UaYPEi+2aWNU+sJc78uTGDy6OW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882901; c=relaxed/simple;
	bh=pjkcNDn5KFxGr3G5TviCNOQbg/0IkK4fcvglxKhPONo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qW47AyLVjJRuQnLReFHMDMAzea4MRwzzarRZrlDzm/AWMWn1Z9lzQbm96CoU5X7BqltlViWdB6wFyxjS/VTUGhbcQPE97pqyLbLjgVAqlLh6W26bTGD8l0i3YLb/1EpiYTqKAGoxrj8K1AZfDHmCK9BRuq4xWc5NTl2kjqPvEm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jk1wi5nt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jk1wi5nt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4AB1F00A3A;
	Tue,  8 Sep 2026 15:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788882899;
	bh=+LaiAafgtAJeBS+j2Ji6I5vTEBM/3hGCFd1lVdOgJRk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jk1wi5ntnDS9w08mvGcPx0/Tng1FRs8OBaQ0uCuMArdSwmO613fP/fiVV8b2MMrGu
	 3XcaQz6LKP/milwhEwAJABqiicjt/O7NKceozS3oxKfeyPCk22Poa/puMvPVjaTHuV
	 SQMhvm1S0ZLIHiReBjew1P2vsaQwv8KBeLysV905TUV9QCVVSMZshH2vHmDzV8YyHS
	 C3FtJfUXVvMYv5hGYWoPlEshi6eELEi4XXVv9iNxR1bHmw5S52b+o3n/wVxxOp0WG6
	 V8xwdRhs/Plj7f7XEITSOP90bzJg7XNwFvRORECnTX5/HAj3DETjgtna7WwcsCJXNU
	 i4JRy7WA4Wl0A==
Message-ID: <81e0b88b-84d1-4d9b-929d-68d26a6ffdbc@kernel.org>
Date: Tue, 8 Sep 2026 17:54:50 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/25] mm/fbatch: remove !CONFIG_SMP special case of
 folio_activate()
Content-Language: en-US
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Ackerley Tng <ackerleytng@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Binbin Wu <binbin.wu@linux.intel.com>, Christian Brauner
 <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Christoph Lameter <cl@gentwo.org>, Claudio Imbrenda
 <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 JP Kobryn <jp.kobryn@linux.dev>, Jan Kara <jack@suse.cz>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Kairui Song <ryncsn@gmail.com>, Kiryl Shutsemau <kas@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Leonardo Bras <leobras.c@gmail.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Mel Gorman <mgorman@techsingularity.net>, Miaohe Lin <linmiaohe@huawei.com>,
 Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Qi Zheng <qi.zheng@linux.dev>,
 Rik van Riel <riel@surriel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan
 <surenb@google.com>, Yang Shi <yang@os.amperecomputing.com>,
 Yu Zhao <yuzhao@google.com>, Zach O'Keefe <zokeefe@google.com>,
 Zi Yan <ziy@nvidia.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
 <3f18ab7d-c12a-d2a3-4d3e-f9908f94f27d@google.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
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
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

