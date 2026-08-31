Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D74237996B
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 02:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788143347; cv=none; b=k9oD4KIta6wbjejAi+sxgsI8SkVGSqQFafykThi2Ih4A2ElrIPlCAKtIRqujLdz48oPexWsYWmHh6m+ZMhDRGLN5h1DWU1t2A/5Fx+yDvisVch5PcLyOKgiRZj8N/NlR+UHuKrUELxGdBohTZk+cy6eH08qY8k5su66AV5X3xgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788143347; c=relaxed/simple;
	bh=kmlBwvRehw3VKz9c8309cNc1KVpQR1VloFEEvq8gjC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fa9nRqyUrkUtBFZm/KyB755F0/UJ/vtaoJVRQf46EOFrRDmIWN0wSHezevjkNx1VV2UfvAaclUcFzujbKRX0ZQXSq/SI6hnmzXog+2+5GXOC1x65F5aAZeRqOJ53Bg+Qlu7Z5KdsVruTA573umWvrU1GLAawV9HJWFh73DLAxg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVZUOLoN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVZUOLoN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3363C1F00A3E;
	Mon, 31 Aug 2026 02:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788143334;
	bh=YwqNfmhuWrZGj3kuSG9MxCjuM4AM56GhnZE26FcBYfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AVZUOLoN0gCkVdhjfloSYqHYJb2zpMUOZaa0k5a9H6baqstqM7+AgtQFs7+YXiUz0
	 7X1Wy9PJ0aqPDPxPCk9B1aSKsBlKyzu94zWsLbwTslm6P1MWLJK0+uVuTVZfvta+p7
	 Wcuen5HEeTIV7IRXa9SyRZemp9sC+xDQEg3thDHS+5PeHu3F90qCYPOkHpfccFQUbF
	 uMDAglZo2Zo1QOE/UrmGhOWHEkVDFG8sIPv51sJdv17C5EoMT/jSBiGn8OsxtYJcs8
	 /7FSGzpnBqmVao6JGbPMupd9rHO3aq27jS8NlPgmLvq81/4xXEMIedpmh+su84R1Hc
	 WaXOUIHuUEIDA==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 1507F1980050;
	Sun, 30 Aug 2026 22:28:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 30 Aug 2026 22:28:50 -0400
X-ME-Sender: <xms:2-aUam1Zghk7jsPTVkI4JM-RbrLDPOo6LaJH_47P0CgAHje4-hPbdQ>
    <xme:2-aUas1oIhQroj2LB2S-TBBc6Qs3Lp9H3K1WV3sKPcIXQrsSEuuXk3_hM_4Lsv4on
    amZeEAeyRxKj9vblePiRHYWuGsL5ajvuctLS8eTOV6klYcXY9Ws4Q>
X-ME-Received: <xmr:2-aUauq5ObrCNd3kePUb32QFERp0If9mquNAna5UBSRHkusqMRXCcpY2y5E>
X-ME-Proxy-Cause: dmFkZTGikeL7Ca+TmNEFzc0vH4jlwT722XVdXtOou1v3igBDEncFGj77NsHPEuBojySN8T
    oeVj2weYrB7KZMakVoVRJUPY80SNG0ySMJsIFhtHzgdy+bSF3uopPrr5hWqYy4PkJ6m2nf
    pwcb4EGSm5KTlkaImH9Awl16Ph6U0QciZ9hMWbDvOx2H146Eyvho7+8mPIuoEq5bRN6MKI
    E/ksYGeF6/W/xKluaF51v3+7WGq0uzd/3CmXvCDFovpLXjrV4gEXi+NAgkUpnMeEQCEbR5
    QJmxIsRD+d1gcCwwfNdaE9dK0hFulFNDH8T+zCSx13N3x2ouJ/jP8UviWjZD7C2DjDNoT4
    +ms3fM5gUKRSnswAQ/qeL0hAcDLz2QO5l0pHOFMin3wotE3xEj9F7/iAViZWIb2GTkyqar
    fzfGmIvro0IWJUMESur9u8YFA4GBxsqTesEeZyqhu2bXGSeKgT4D7JyolLaLb0fkai11af
    +KVIIGjaVpbKFdAcVQnDRnM+YVw8iKzJ8AF4qboZxMulCFJhyXtXofC2esia8N6FZmcjU+
    WWC2AHzrMP4DeAACwH6856+j/kCABE7HOW/s6TpLzSa1A+kkGxtlx22K8reu4dGQY/58MS
    tYgJU8M4/EBvfNAjl846FVOW+brqAmI1OnITyK44vYU7Q4KiPKWTRMvnuiOA
X-ME-Proxy: <xmx:2-aUanJ7XxmVtIIXxjCOEJNH8PBsOX_M9t5zX6dDW_BK3sdUuBsyDg>
    <xmx:2-aUageco-eD9TfWakNkdmaGQ_bc9SmHk56ZNonQAPGlcfedPq0lrg>
    <xmx:2-aUavnJxex1loLDFXFzofNmYj0_jPxOz1qLo7zbIFw8cS9pIpD_-g>
    <xmx:2-aUagYBeyhZz_7hzzu4DeoNo1Me1hYxJLsHK4ERA7b6Q7gddU7khw>
    <xmx:2-aUavLkZ3xi8RZQNC9Htrl4RqMZkkqmgPzS3Sw-YO2LHYfzKensXXQi>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Aug 2026 22:28:42 -0400 (EDT)
Date: Mon, 31 Aug 2026 03:28:41 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 	Ackerley Tng <ackerleytng@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 	Baolin Wang <baolin.wang@linux.alibaba.com>,
 Barry Song <baohua@kernel.org>, 	Binbin Wu <binbin.wu@linux.intel.com>,
 Christian Brauner <brauner@kernel.org>, 	Christoph Hellwig <hch@lst.de>,
 Christoph Lameter <cl@gentwo.org>,
 	Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, 	JP Kobryn <jp.kobryn@linux.dev>,
 Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
 	Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>,
 	Lance Yang <lance.yang@linux.dev>, Leonardo Bras <leobras.c@gmail.com>,
 	Lorenzo Stoakes <ljs@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>,
 	Matthew Wilcox <willy@infradead.org>,
 Mel Gorman <mgorman@techsingularity.net>,
 	Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
 Minchan Kim <minchan@kernel.org>, 	Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 	Peter Zijlstra <peterz@infradead.org>, Qi Zheng <qi.zheng@linux.dev>,
 Rik van Riel <riel@surriel.com>,
 	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 	Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 	Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>,
 Zach O'Keefe <zokeefe@google.com>, 	Zi Yan <ziy@nvidia.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 07/25] mm/fbatch: LRU_NEXT_ACTIVATE bit to optimize
 folio_activate()
Message-ID: <apThx6sWOQ-aZcN7@thinkstation>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
 <16b39f43-d91e-7b23-900e-90cec13837ff@google.com>
 <apAllneItXmyjRPo@thinkstation>
 <7b30ca86-dca6-83b7-a632-180e35ed2a0c@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b30ca86-dca6-83b7-a632-180e35ed2a0c@google.com>

On Fri, Aug 28, 2026 at 01:40:51AM -0700, Hugh Dickins wrote:
> Do you have a head for smp_mb__ barriers? I'm more anxious that
> I might be missing one or two of those.

I think the release side of PG_lru is missing.

You effectively turn PG_lru into a lock over folio->lru.next.

The acquire side works: test_and_clear_bit() has a return value, so it
is fully ordered.

But there's a problem with release. set_bit() is unordered. You
correctly placed a fence in __folio_add_lru(), but every other
folio_set_lru() is problematic.

For instance:

	CPU0 				CPU1
folio_batch_move_lru()		folio_batch_move_lru()
  lru_add_del_folio()
    lru.next = LIST_POISON1
  lruvec lock
    list_add()
  /* no barrier */
  set_bit(PG_lru)
				  folio_try_get() == true
				  folio_test_clear_lru() == true
				  lru_next == stale BATCHED ???
  lruvec unlock

If CPU1 sees a stale BATCHED, lru_add_del_folio() returns true without
doing the list_del() or the NR_LRU_BASE accounting, and CPU1 then goes
on to lruvec_add_folio() a folio that is already on a list.

I think we need to have a helper that would set PG_lru and enforce
release semantics.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
