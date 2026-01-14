Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD5D258CCC
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394644; cv=none; b=S9wUzpdAPn4PRlbbRCnJi6tOs/+WY+/sqpWqoVvWANUr9DeYV4vXqB7jz8m1ZxmAHAyIqU4q9O+H9eUGdb6aBpV4eGwMpu2qxzmxGtjoPcFy8UweDGz4BNBYXhOaamCi5g3jORSQ3wq76zwTksJz63W2f8Pn9p556nukJjUR0OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394644; c=relaxed/simple;
	bh=rTXiqjGwQe9StbY8q2PGEsSVnb5XD/eiq91f8fTTRKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yk/0bAqtrPN2HWMkZzYR8VeOSLpg9APcPopWIRUWZniTwjZuIuz62ZEs/uF1VAlBUyumJ5EpTl0MWIKx7ReN3HfTKNZ3KQfBw8s8egepYFvv83Ii3P0ky0MThOzuM3oxKgCxXRRBMo4jpYCCd+9QVuqmWkrEpioBokGkX2zLO7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=desi+bbh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="desi+bbh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KOu8e0fvmwRWQ233dbgArPcX6Udc57jyEPBr1+MBcUQ=; b=desi+bbhygwxq8XMZtuOwgx6vv
	nYcTfKhc5GY8sWVCT7bL9gn9BmKv6gFjyvaBW0dSZXEzQr5SqPeeD7WIhuhg/wG5wlvWTbBcEdosg
	O2wALqxIeGRsoLO4b+L7Sy5xozWvsd3D4my5YD211ZUT6gZ0UJnUtBCoP/IN0gcdei7zu6YMw2z4F
	rGYJkccSMkepN8IgjOZ4JRQIgKnt3+WHdDZynYmEVvY0cwVCkjWDKSri7kZ1bw9IYshMaM4SzxLvT
	qDFuzTFqiJlzkqQ2Zxw77eZHapbOdRCa4gkPvj3EYXKVHQZDYx0CQVMABFwlq3skMQQ4wQayhanlf
	mmSG6ayw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg0E9-00000009DkZ-327u;
	Wed, 14 Jan 2026 12:43:57 +0000
Date: Wed, 14 Jan 2026 04:43:57 -0800
From: Christoph Hellwig <hch@infradead.org>
To: alex+zkern@zazolabs.com
Cc: Yi Zhang <yi.zhang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	fengnanchang@gmail.com, linux-block <linux-block@vger.kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [bug report][bisected] kernel BUG at lib/list_debug.c:32!
 triggered by blktests nvme/049
Message-ID: <aWePjbx5p269pXzn@infradead.org>
References: <CAHj4cs_SLPj9v9w5MgfzHKy+983enPx3ZQY2kMuMJ1202DBefw@mail.gmail.com>
 <0e1446e1-f2a7-41f4-8b3c-bce225f49aa6@kernel.dk>
 <CAHj4cs-uHD_cm_5MHAS2Nyd1Dt6=sqNPrD4yWZrbykM+WvyxbQ@mail.gmail.com>
 <CAHj4cs_d81+Tbe+kh=9sz-ort4MZnC1F5gzPLGt2jrDJxA2P_g@mail.gmail.com>
 <4817253e-2cec-4cf8-95c4-6292e758fb8f@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4817253e-2cec-4cf8-95c4-6292e758fb8f@zazolabs.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 14, 2026 at 11:40:41AM +0200, Alexander Atanasov wrote:
> Double linked lists require init, single lists do not (including
> io_wq_work_list). iopoll_node is never list_init-ed. So init before adding.
> 
> Can you check if this fixes it for you? If yes, i will submit it as a proper
> patch - no way to test it at the moment.

The heads (anchors) of lists need initializations.  The entries added
to the list do not.  I know this is a bit confusing because they use
the same time, but besides not compiling due to the double-&, the patch
would not do anything even the version that would compile.

