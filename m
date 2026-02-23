Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A0F34F270;
	Mon, 23 Feb 2026 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771839413; cv=none; b=LFWvCrCiqFbXTOEbPQM4sgFyPmIrsmpGdRgW5SPEk5DEYPMwzZ50sZYhbfXZqF42HhqSXQdkrNaSZwktZDbZcXnnmqS8qf295+2WU9n45BBOkOfnrhto6ni3GHLhaOnJ/KrZRIKFNBYmvVNtazZsYWfjqOjAkaHmGXJP38v/C4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771839413; c=relaxed/simple;
	bh=0jMHGP/ybufSz9lSb0ZxZMotoqEwnfv1L084yPjko08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1spnO5Dl6dmPV6Ieu5QyS6BgNwHmDeRTZqvK7uz8E4dUutl32v5qOurtq4tP0g7LWqThdAUBlSuRzO/43BJbbL/fdBZurFGRFY3VX97We3Vp83UU1xiS7nw+IBG2scFlkMkbK/2nl3tsRgMfFo1oHZnErXHLm+ItyvFYHi8M5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCS/Oxe+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCS/Oxe+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB8EC19424;
	Mon, 23 Feb 2026 09:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771839413;
	bh=0jMHGP/ybufSz9lSb0ZxZMotoqEwnfv1L084yPjko08=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OCS/Oxe+Dxgz+x+xdUK/MYBO0KYN9A8SZFhWmTCCYz09A6lLOmm0uN5o6h7jMzG2Q
	 jRFenKp9st0gV3TjgABTQgDrtgQ4hthtQYeoS8BvjHkxFb9TZa+DzTqltblbK0bnZj
	 PTURObvt0rZihgvX4BA4ptBpDGCg21GZiA8k6fRayqylGJCXCLs+FligqQjx4JlxJ8
	 wtf6nUlUn96LYP8M84pt9Zs2vz1o92hBGuSRYaOBpe7yA9Nxf547jnW90lIsB1uO9R
	 TW30TzjPUMgqMt/5wwjjya/3hUZIk5rkroJnbqCWY1RiILUhVwYeJVt9SE06Rrnl22
	 BMoG/sCdcY2zA==
Message-ID: <492f2fdd-3f1f-4303-b512-ef90b649910a@kernel.org>
Date: Mon, 23 Feb 2026 10:36:36 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/11] Zero page->private when freeing pages
To: Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-erofs@lists.ozlabs.org, linux-block@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Eric Sandeen <sandeen@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Carlos Llamas <cmllamas@google.com>,
 Alice Ryhl <aliceryhl@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Gao Xiang <xiang@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>
References: <20260223032641.1859381-1-ziy@nvidia.com>
 <aZvXevheBMQ6LuUu@casper.infradead.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <aZvXevheBMQ6LuUu@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/26 05:28, Matthew Wilcox wrote:
> On Sun, Feb 22, 2026 at 10:26:30PM -0500, Zi Yan wrote:
>> Based on a recent discussion with David Hildenbrand on page->private
>> is not zero when a page is freed[1], this patchset is trying to fix all
>> users do not zero ->private when freeing a page and add checks to make
>> sure all freed pages have ->private set to zero. For compound pages,
>> both head page and tail pages need to have ->private set to zero.
> 
> Sorry, I didn't notice this conversation.  It seems entirely unnecessary
> to me to zero out page->private before freeing.
> 
> I'm a bit confused that ac1ea219590c was needed too; I thought we
> cleared page->private in the allocation path, and I don't see why
> it needs to be cleared in the freeing path.  split_page() should be
> clearing page->private.

See discussion at 
https://lore.kernel.org/linux-mm/cbc3b5b3-09b5-4e3c-99f0-a1f67582afff@kernel.org/

> 
> Can we discuss this at the THP Cabal meeting on Wednesday?  I don't
> think that introducing this new rule that page->private must be cleared
> by the users is a good idea.

The benefit is that only the users that really use page->private will 
also zero it out.

This implies that all pages that enter+leave the page allocator will 
have page->private initialized and we can also likely do:

diff --git a/mm/internal.h b/mm/internal.h
index 9e0577413087..4ecdae78e0d2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -724,7 +724,6 @@ static inline void prep_compound_tail(struct page 
*head, int tail_idx)

         p->mapping = TAIL_MAPPING;
         set_compound_head(p, head);
-       set_page_private(p, 0);
  }

  extern void prep_compound_page(struct page *page, unsigned int order);


Which is rather nice.

-- 
Cheers,

David
