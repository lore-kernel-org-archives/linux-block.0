Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66744202C46;
	Tue, 16 Jun 2026 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613413; cv=none; b=RJCGGmWzm9BQPiZsKdyOPkWABwpvffjdjKkrMZTqh5HsFm4XphhRfYUZ+gppSRAYGbcR1PrSyi8tDc9HM35wMUidBZtkQNT3kRZ1h8YOQ71Sn35CEDPabMs7YnX5BQGiKwmpLbtjXZ06QmyRBn775+Fxr6euWJ8lrd0jx85J7yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613413; c=relaxed/simple;
	bh=xfzKR7IgypJiS1B45c8sdwSFt3SsDVQtlJzJWnaQ1a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hfxa2DygQlOCi71lu7aBmobAX3wsX/doKfAIKL+NRRFcFBUuyJGQcpGGZo0G8lHzLo3G9GlVhPNy0Rfeh6c2jH/JUkETaK9jwQoB1o3YyGH+Vwin/oNnE7XeqvzwjlyHkpck6Wjil9zXEp2DaLU0mHKyJw3mSlst/YLIhqAVuDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E2F0E68AFE; Tue, 16 Jun 2026 14:36:46 +0200 (CEST)
Date: Tue, 16 Jun 2026 14:36:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jianyue Wu <wujianyue000@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Chris Li <chrisl@kernel.org>,
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
	Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Youngjun Park <youngjun.park@lge.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/zram: route block swap I/O through swap_ops
Message-ID: <20260616123646.GB21024@lst.de>
References: <20260614-zram-swap-ops-block-register-v1-0-6c1a6639c222@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614-zram-swap-ops-block-register-v1-0-6c1a6639c222@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

I fear this is going entirely in the wrong direction.

Yes, we have to keep zram around as a legacy interface for now,
but the right place to deal with compressed swap is in the core.

So please don't add more hacks for 'magic' block devices.

