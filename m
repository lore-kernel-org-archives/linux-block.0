Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D8628DBD
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710398; cv=none; b=UK21AK+uQ+HfckZGqNHHOcBHUlsaR7uyXtuZSZxzWI+d50qtvMjOvKQoSQbuuuzJRIlIm+u7AIynWhEqYYOBLG3X6aUMMl23q1M6HDQGiBr3VukLz5MzZ2hh39rHLOHhChUdc5xj62l5fpJjwjHWJDmol7feGHy3QcQbnhs710o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710398; c=relaxed/simple;
	bh=KZzKiCcoDSRXwcX9MekjoKp1MqufHTwKz3XzaXPjUmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqCTyu1EBbYCr400o+0KjIBijQMd9uzgdWCNNTvyybrSSrb/QCHOhVSpXkjq79N0u3vASZIKZT0MMkwACynNeA6ze8aVq1Ps42NvvHnWWcaNDHYa6k0pe7VEZSk51Q3VQB0jZWy4nH2BtP2Y8mR8akhrzJ0qHznax9659GXvHrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DF81168D09; Fri, 23 Feb 2024 18:46:29 +0100 (CET)
Date: Fri, 23 Feb 2024 18:46:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	Alasdair G Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [git pull] device mapper fixes for 6.8-rc6
Message-ID: <20240223174629.GB5743@lst.de>
References: <ZdjTMZRwZ_9GjCmc@redhat.com> <CAHk-=whmiQC_F1s1bWmOhM8csz_zxL32B=sPGgaz1kiTK_T2iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whmiQC_F1s1bWmOhM8csz_zxL32B=sPGgaz1kiTK_T2iA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Feb 23, 2024 at 09:42:21AM -0800, Linus Torvalds wrote:
> And honestly, "__packed" really is wrong here.  Nobody ever wanted it
> to be completely unaligned.

I'll let Ming speak, but I think the idea was to remove the padding
at the end of the structure when embedded into the bio.

> 
> I think we might be better off marking it as being 4-byte aligned.
> That would mean that instead of __packed, it is done as
> 
>    __packed __aligned(4)
>
> 
> because "__aligned" on its own only increases alignment (so without
> the __packed it would stay 8-byte aligned).
> 
> Then the only part of that structure that might be unaligned is
> "sector_t", and that would only matter on 64-bit architectures.

Does __aligned also work on struct members?  If so we could add a
__aligned(8) to bi_sector an get exactly what we want..

