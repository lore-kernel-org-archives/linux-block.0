Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B143A8F0;
	Mon,  7 Oct 2024 05:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728280490; cv=none; b=lvh2/Xp73SIVbun2p66kpA1fS396aXm6cICuivBmma2Mm9/tJsE52NN3mu9bHkT4Ssqw7jPaA8u2FQfmtQUhNjnJlmCLnRZ8asDPi5Ju5NGs1Y/IhbFZNOucyIBoryiCYDaLxwLA8muFKyrG1UQwccargmelBPgF662fqCBKzM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728280490; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzAetRxNzHjudBT9vGBFlNxAK3Ooo4ptkMajr4jRvv4yYaqfyiEG7ywXd3rmkikMwJJJdEmghJiFYf/qRNb15q2EQUp0pPz1lwbfqVfU/LB/KVUnqkYeNi1XP5TQ9ueafhdGUxJjxMPgxv80Hug5OjSugYQb8b9uIZGY9POsme4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=02Gr/1/q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="02Gr/1/q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=02Gr/1/qwpl5xb9yDRo4hRb1cC
	LL1VLo3R/tp/phbLIUfxmMfP1c4gyCDBnB6WK8lnht8XKa4P00GpBQ7SccstTr4rpOHdia53zCKhz
	/9/IBvbwTTvL2MJBcKGxkETwLsdQ5QoDlwKXLmeBsPsMxWdSJcFgbycyGuXV2nn1QF8e5dczGse2S
	ADeyVzi1owIBd3rmUHOuMdr+hlbguOi/BL30Lh7HyZHJwvyfT82aIjXk8eDAC0R3jds3kLsMJdXAX
	JckGoxbkOQV6lcOati3R2B39FN2WkRM56GtgBhCnbOIRJDUP93ElG9AX185hHHaF4JRWfZOnBOD9U
	lny6NQ9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxghe-00000001LZ9-1vhE;
	Mon, 07 Oct 2024 05:54:42 +0000
Date: Sun, 6 Oct 2024 22:54:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
	Kyle Fortin <kyle.fortin@oracle.com>,
	Douglas Anderson <dianders@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Christian Heusel <christian@heusel.eu>, Jan Kara <jack@suse.cz>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Riyan Dhiman <riyandhiman14@gmail.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: add partition uuid into uevent as "PARTUUID"
Message-ID: <ZwN3ooAd6vUd7Fu5@infradead.org>
References: <20241004171340.v2.1.I938c91d10e454e841fdf5d64499a8ae8514dc004@changeid>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004171340.v2.1.I938c91d10e454e841fdf5d64499a8ae8514dc004@changeid>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

