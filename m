Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923851;
	b=WPkbLHXemsIEnBmjXS5wo4Qgb9OROhFuNy+DXnDNPfD3tqJ05Hkg38aH8LvtfmnLTnMR
	 8gV0ah19iVE5TUAiyacSbol0MRHKExsK0wgdqeIb4MeJjBt8lftOqB/R3XsC2/NNRosr9
	 1tExuIC/2XFfrKAfQjxQGHAvCDocm7NQfN2xBKlo3m/PEqkcSJ+ftoM+hEvYko0RcDaql
	 W0FjPYYi3PblduyPs7FUwfzcdyMktg/wGmKqJ50AcXX5HKN9Fohc4vnSo2AQB+/b5akSD
	 6gAwEmKZR3TD0X/JF3K7Ce8ITfthKAPxJ+o6JTqr1Gy+dcFZY1mVrYbHQ0NJOVxYlLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923851;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=fEuhClmaJB9i6FXWuXFxHEVU2l5a2ORvSS+UOcUmAQg=;
	b=1B/JtAOKxPe2SIf3RtRaniHX6MobdZj/181QaySzNjVWl+Y/ACnvVuXp+PQbrj4lBSNJ
	 EWdBgTtN5PbVHII9+eRTJKf8GYGtOYWu2knCgFNuRrvhdV3M6fJTIwlBDmzeC1SHG3KZo
	 ihlsCbRRpM0OPOivGLvGfeVpRsRaOfYMqQPsw7snYGtCvUAGNB87Oo+9avF2Oo/Cjz0Ey
	 Ozx/OoBt8zE91lIV9swigQvYHHUsHVtPfATPC4NGQhlwWFUE8YukfPkJuISmA6LUIgsWt
	 YlZ+GSwR4TUvdOKzkKEK8ww839SkbzCoXj3FyVlAZYMgErTw7+Wz7jYpfxp/qvNsd2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=kLRKax7Q;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291EF606A31C;
	Tue, 17 Nov 2026 13:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 291EF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=kLRKax7Q
Received: from [127.0.1.1] (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1C34A15B2;
	Tue, 17 Nov 2026 14:54:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794923700;
	bh=SGdF8nfS37ls6JI/8WVlvHSMe1DjBMEx5/IrVzLhb5w=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=kLRKax7Qdo2KFM3LRtNj1wG6mRam6bxjFgr5dCY7LNwEAE1gDePOPuSKuLCdROShE
	 mDwtbAi6e5MZMtd83tcyjjfIV9fF1MrkMF8gYJzpcRzRD2SnOGUK+FEnsvfWt8wrCF
	 xBePtEZipHyK/7oo6aczGgDw1CKchbKhlg6G3Aoo=
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 00/26] mm/fbatch: drain lru_add_drain() and _all()
From: Alen Karnil <alen.karnil@ideasonboard.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Ackerley Tng <ackerleytng@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
 Binbin Wu <binbin.wu@linux.intel.com>, 
 Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Christoph Lameter <cl@gentwo.org>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
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
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
 Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Date: Tue, 17 Nov 2026 13:57:16 +0000
Message-Id: <179492383658.1554713.9260140415931487684.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=713;
 i=alen.karnil@ideasonboard.com; h=from:subject:message-id;
 bh=SGdF8nfS37ls6JI/8WVlvHSMe1DjBMEx5/IrVzLhb5w=;
 b=owGbwMvMwCUWeK6p+sMV/3mMp9WSGLL+xDr0pdpNea1+QsDbv6z1/MembZb8+62j3efM//qG6
 59XmMr1jlIWBjEuBlkxRZYvh2SmL7VZEXZBM4QTZg4rE8gQBi5OAZhIMzfDbxbtTzlN+op2wge3
 BJtvdVutoaIlusZ26wbjRV/WT/rNHsfwP59xlbfJTeOzJaf7RQxdTF7Pmz3P4c+RKskibv3ZKyR
 aGQA=
X-Developer-Key: i=alen.karnil@ideasonboard.com; a=openpgp;
 fpr=F4C21C97A53CA856D029540951CE827BF0D44F9E

On Wed, 09 Sep 2026 02:39:08 -0700, Hugh Dickins <hughd@google.com> wrote:
> mm/fbatch: drain lru_add_drain() and _all()
> 
> [PATCH v2 00/26] mm/fbatch: drain lru_add_drain() and _all()
> 
> This series was prompted by lru_add_drain_all() appearing in watchdog
> backtraces: not to blame, but blocked on an unresponsive CPU to run
> its workqueue. lru_add_drain_all() is a heavyweight operation, which
> we often hope to avoid by a much lighter lru_add_drain(); but even
> those local drains can aggravate the lruvec lock contention which
> per-cpu fbatches are intended to ease.
> 
> [...]

Tested-by: Alen Karnil <alen.karnil@ideasonboard.com>

-- 
Alen Karnil <alen.karnil@ideasonboard.com>
