Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AC6371CEA
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772660769; cv=none; b=doWO9G82kWbYRI43Yze6xfEzblUBpGcfBHya+ZlQQRQmQbMKh9qAj7xlVT8hrGvQvZu3NhQ/rZj83tLkBw21tkMZ2NaviqwwkF+G17kp1kpGCTc1VQI4O7LOylaxqBmhbYHuoWvDMYtMrGHtYAwhLu0s9QFCLiQLICLoGp/fSbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772660769; c=relaxed/simple;
	bh=tfRUwKnkEC/jke7NKndMs2zP2U+8kWAWM4H6pLEsPW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmlMvglAn7RRWiwlR1oewVCZcc7qoB1Y5ZmPJdkKioyV7MSLYvBa69EyA6GvRY6NWmmTH90TwUL67QW4rHMvYQQukIrzN9aiHBx8bbs/bjh1mVZgZ/cU8/XEqVh+98YKuj0sgGmwQQvainWhqslBKEcraBylG1V+SThHChOtZxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7CSMCJ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7CSMCJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D84C4CEF7;
	Wed,  4 Mar 2026 21:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772660769;
	bh=tfRUwKnkEC/jke7NKndMs2zP2U+8kWAWM4H6pLEsPW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7CSMCJ1il2Hpgku52kL4nUWGK0sLVdYK+5aPveV3AXZiv+DkU2fjKyi4+APbxsam
	 es2PNCEuz9PTq6N3c0vLNpkKFcP9Thqoer43K7d9AelqCuxgSuVswMNJ1L6nB8rV3o
	 mejKym1JFZuBVTlAg1Iov5vQPzvu48J2Uhs+M7h7bsgAAFuc7TNPjsHnXNYAAQ0wkc
	 j+74LO63sxMr9hRgj6p2AQ/n3M0HFvRxp+X8lQdJcuiLXuvvURx21pJJOWcHQldaMj
	 S/XULj/NrpUPk3FsYdAn9syIU4SmtUWtZlWDRMiZ+4oy9K8lcnPqbCc45ThieCjITj
	 0QyVNVxZTasBQ==
Date: Wed, 4 Mar 2026 11:46:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
	linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH 03/14] block: Make the lock context annotations
 compatible with Clang
Message-ID: <aaioIEIzdrJHsYbw@slm.duckdns.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
 <20260304194843.760669-4-bvanassche@acm.org>
 <aaiP-EE4M0iywHzc@slm.duckdns.org>
 <dfa02afc-b517-43cf-a136-4c5d464fc457@acm.org>
 <aaic_mAZCuC0wZdX@slm.duckdns.org>
 <159e66de-5934-4d60-862c-de4dce9afc7d@acm.org>
 <aain5U1gMQpwJXXY@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aain5U1gMQpwJXXY@slm.duckdns.org>

On Wed, Mar 04, 2026 at 11:45:09AM -1000, Tejun Heo wrote:
> On Wed, Mar 04, 2026 at 03:34:12PM -0600, Bart Van Assche wrote:
> > Here are specific examples of what is possible with the Clang
> > thread-safety analysis and what falls outside the scope of any code
> > review software:
> > * Documenting which synchronization object protects which member
> >   variable (the __guarded_by() annotation). It can be very difficult
> >   or even ambiguous to derive from code which synchronization object is
> >   intended to protect which member variable. The Clang thread-safety
> >   support allows to annotate member variables with __guarded_by().
> > * Whether or not it is intentional that some code paths unlock a
> >   synchronization object and other paths do not. The Clang
> >   thread-safety annotations include __acquires() and __cond_acquires().
> >   These annotations not only enable compile time checking of
> >   synchronization calls but are also useful as documentation to humans.
> 
> I'm skeptical that the overhead justifies the likely constantly diminishing
> benefits. I suppose it's upto each subsystem's choice.

Oops, I meant, benefits justifying overhead, not the other way around. At
least you know I actually wrote it.

Thanks.

-- 
tejun
