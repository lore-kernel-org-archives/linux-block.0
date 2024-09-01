Received: from hop.stappers.nl (hop.stappers.nl [141.105.120.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3FF39879;
	Sun,  1 Sep 2024 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725173598; cv=none; b=ZvMttl9odbMKRoDmUbwxQXqD/NEwnEupOgNtnq94weBwmsOjw7UsNQ/LX9DACgqHDod5qkvz7OPD2+SUVS9XqPZ6G2Ut5CLtJD3zOygqTwOrqs3ssxj6r9KysqnlGuKQ+cC2Tf57/HadGUJbXDtCxeFy6VNutLEk+1YNZefXJQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725173598; c=relaxed/simple;
	bh=cX445qEWEaGKKoMYb07BvkSeeQIFBXfy3Bey7B/Hrz4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkxZfCe4zNAxQtl04D908L3ToEUoNt7bB8O+KRuhYxmJYJ+A6nni4qKYvddAB66Syv8R7vV+Acot/f4/qWC6amIBqR+aAnS3ZqeMXIMgSQ8mIWfrgtCMk2H4fF7rTjPDU5HR3T3dwVPtDZgzwkkEn/TnJ0XrPbmfhFG4qQzRc9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stappers.nl; spf=pass smtp.mailfrom=stappers.nl; arc=none smtp.client-ip=141.105.120.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stappers.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stappers.nl
Received: from gpm.stappers.nl (gpm.stappers.nl [82.168.249.201])
	by hop.stappers.nl (Postfix) with ESMTP id 463522000E;
	Sun,  1 Sep 2024 06:46:45 +0000 (UTC)
Received: by gpm.stappers.nl (Postfix, from userid 1000)
	id 363BC30417C; Sun,  1 Sep 2024 08:46:44 +0200 (CEST)
Date: Sun, 1 Sep 2024 08:46:43 +0200
From: Geert Stappers <stappers@stappers.nl>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Alexey Dobriyan <adobriyan@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Boqun Feng <boqun.feng@gmail.com>, linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] block, rust: simplify validate_block_size() function
Message-ID: <ZtQN04+BIm/2x1qI@gpm.stappers.nl>
References: <CACVxJT-Hj6jdE0vwNrfGpKs73+ScTyxxxL8w_VXfoLAx79mr8w@mail.gmail.com>
 <CANiq72=pX32F4pDq85H=9pB=hmUcH59Xp7JoNGpKJ+XxkzovcQ@mail.gmail.com>
 <6ca8edb0-10f9-4967-b0d6-3510836fdbcf@p183>
 <CANiq72kMRBAUMBSA8vC29U=c7JVycW8c+yfMc8ZDN9Mq0oi9tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kMRBAUMBSA8vC29U=c7JVycW8c+yfMc8ZDN9Mq0oi9tg@mail.gmail.com>

On Sat, Aug 31, 2024 at 11:42:04PM +0200, Miguel Ojeda wrote:
> On Sat, Aug 31, 2024 at 10:13 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > Ignore the patch BTW, it was mangled by opening gmail Drafts :-(
> 
> No worries, and thanks for the patch by the way!
> 
> I leave it up to Andreas whether he wants the range check style or not
> (I think we should decide on a coding guideline for those and then be
> consistent).

I think that consistence is good and imagine that clippy already
has an opinion on range check style.


Regards
Geert Stappers
-- 
Silence is hard to parse
