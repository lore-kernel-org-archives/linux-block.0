Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33C8394EBD;
	Wed, 17 Jun 2026 06:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781677069; cv=none; b=BVzSXNAzyq6OkZNkpciyDppnwc7zKBEmSy6ya8eKwfsIkMuelKw/aQRkNQDtO6wgWiMZmdWnnliic6CNeT7UL2SQ2a6odpI6hQ11lixYutY6BKnp6KYdycw1oDT5Yirak7C7Xj832EJfJKdbYSMpb3L4xjsMhYkO2EEKbYkiRtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781677069; c=relaxed/simple;
	bh=poDADrzoQbzctHuaCBF182lqKge2c3dwNUl4QnA52sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2Cy1OgAOvyLszJMXu1LgrPW6hBouy1gPrtAHRKPVNCCUFCChfgrVWvS0ygtUbuIHdgEWbybzuwElLrY6ByFhNK/v9iY8hFiXUZmB/PnOgtrOxjcAVYQRMmGje9JD1xEAqwgsAuUyWutcoCECeAe7zYkg/npwrr7iiLccb3XOck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4450A68AFE; Wed, 17 Jun 2026 08:17:43 +0200 (CEST)
Date: Wed, 17 Jun 2026 08:17:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jianyue Wu <wujianyue000@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>,
	Kairui Song <kasong@tencent.com>,
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
Message-ID: <20260617061743.GA19844@lst.de>
References: <20260614-zram-swap-ops-block-register-v1-0-6c1a6639c222@gmail.com> <20260616123646.GB21024@lst.de> <CAJxJ_jhK+zkpjhs3YsQ9RoasKYh+E0NweQci0sPAEY1ne5LmBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJxJ_jhK+zkpjhs3YsQ9RoasKYh+E0NweQci0sPAEY1ne5LmBA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 17, 2026 at 11:38:02AM +0800, Jianyue Wu wrote:
> Before I rework or drop the RFC, could you outline how you see that
> core-side model working? In particular:
>   - How should a compressed backend like zram or future block device
>     plug into swap_iocb / swap_ops?

I don't think that is the right layer.  The virtual swap layer that is
currently in the process of being upstreamed is the right level, and
the actual swap devices or swap files are just a dumb backend for what
they higher level code does.

>   - What role do you expect zram to keep while the legacy block interface
>     remains: current block swap only, or something else?

For now we'll need to keep it working as-is.  It is heavily used in
android and potentially elsewhere.  Once we have zswap fully working
in the virtual swap layer world it might make sense to say never
compress again in zram when REQ_SWAP is set (or maybe a new
REQ_COPRESSED) so that we can use the core compression code without
breaking existing setups.

