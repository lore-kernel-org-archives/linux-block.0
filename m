Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD9A211290
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745606182; cv=none; b=PbeJnuIyVNcYCS9+K45B17tzYcTLfW9rKJrLWQaSA0VmtvwnXp7Yxgn0J+YxAGONqVs38b9JJ7VrX6Ee+20zyjbKm3r1KwMlVGF8XgYMNlbuarEGyWFBhidn5bw7cV9nypsMeX5o4uJKeeJy070nN//lNrtKkhCBlYLs+p7scR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745606182; c=relaxed/simple;
	bh=I7V3+wanguo/sivHGOMYGWOlFhyfE8zm9/v01yLZajU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4+7LDtiAFR0hCTh92ZygcVGkHJhvOONcHaO+ZwQvCk5cCY7m6PHJd8iHy5jE4/aeiNmCyjgBrAq02q91GzzbaAJoyiOmFuY1ENhG56ZHNSnHSZH9MzFatiFNcCdX+t1+rbF8zWafXhpSzvS/5jDqhvLyE+43ufziZlfKELTjUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 758CE68BEB; Fri, 25 Apr 2025 20:36:14 +0200 (CEST)
Date: Fri, 25 Apr 2025 20:36:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 15/20] block: fail to show/store elevator sysfs
 attribute if elevator is dying
Message-ID: <20250425183614.GA26393@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com> <20250424152148.1066220-16-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424152148.1066220-16-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 24, 2025 at 11:21:38PM +0800, Ming Lei wrote:
> +	if (test_bit(ELEVATOR_FLAG_DYING, &e->flags))
> +		error = -ENODEV;
> +	else
> +		error = e->type ? entry->show(e, page) : -ENOENT;

Weird style mix, I'd expand the check for ->type to a proper else
if here as well.  But how can e->type actually be NULL here to start
with?

