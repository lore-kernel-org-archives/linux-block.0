Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29A6205501
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482155; cv=none; b=pLDfJphCrVK9ue427jGMBpOxUsVfPvrJoNVuC6BLCQGu9SkX8228WyqGylXA66lSv3u8KUyonH75dc0aLBOr+RUQ5ip6+TuuIhYxWW9OhBMqdcVIsw242GM8DLqPO68rmWBpRDepSSkgCjFPhWd4jQ9stYYGoQ7/PGSb1qwLB7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482155; c=relaxed/simple;
	bh=VtOKR7jOavUe/jCC4djqumVgh37976aK9RtTKXRWO2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhKkbAzAsD2ZNWUu9PcU0/aNKBFPaUAxWC/Gv66oq4utvi26+j2M9KFvuE0PgVuJ/7RDFdMTXq2s1V0patkroMXF4oCktZX4G2128U0tbRN7PSoRmaJUmisSqlE/b8CP0VBAcSSrD+qjB6VE9bdOYSXqqBh+wSTtJZbyfXN4fFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yX/4HBm5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yX/4HBm5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5SMA0LNudvRcjgz7q/tVM5DxXjonXOCKdU+oAluI23o=; b=yX/4HBm54xW19xiQ8rFX5Y1Pow
	hoWG6C4SLWRUGYCuktytJJCWr7dQYndMgXa0zzTGR+7mygmWiSn7LDPjzvfCc9bm4OZ7ktiynvG5U
	C+Z5rFWUFCKC2FcybxGnKtxqMqlq4jcll1kzpgEpRXeEQLqfwDMq3GN6P9VWd3zUVqG+gN8El3OVu
	BkiC3Q0nW9+G/7rgmsCTZj58bLisgtC02qe7zv4GjxFUBdvMBgk4UgfScNFJta9A1oU3BvqhlSDUC
	YnuiQECdwpD7hplow9XRC+eMtHbb79Vwyw9okSKFOz8/MJA6jug/rbl8s7DGwWSZDQ369VbqyOuhV
	LxnexHMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7rdw-0000000DHmw-2V43;
	Thu, 24 Apr 2025 08:09:12 +0000
Date: Thu, 24 Apr 2025 01:09:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sean Anderson <seanga2@gmail.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] zbd/005: Limit block size to zone length
Message-ID: <aAnxqAv41Quh66Q1@infradead.org>
References: <20250423164957.2293594-1-seanga2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423164957.2293594-1-seanga2@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Apr 23, 2025 at 12:49:57PM -0400, Sean Anderson wrote:
> The block size must be smaller than the zone length, otherwise fio will
> fail immediately.

In theory yes.  In practice such a zone size makes zero sense, and will
not work with any zoned file systems or other users.

So instead we should just warn about a silly zone size here instead
of trying to handle it.

