Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899BD279DDF
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269999; cv=none; b=rxEIxiW0ehkhZg3djEz64pyfuF8O6WN07jW5Q//skhtcXbTJOuD9SuABz2bxowdonRo2jnzkehUgl9lz3A6U6gabZxD89HgxS+nWgzLbDoRBFTcHwqqK1yD/37oHpZXPrQQRKv7ZLY2TSAh36xh4rqONM5XO1F2lS0thRc3WQ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269999; c=relaxed/simple;
	bh=6UvgZ6FlP9BrAv2GeuGkoQUCGSFiSZSU8Yjga4iyc8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqOcKO22iJx3J0OcwvCF7V1Kq4uQKB56uabfYTxH+f9Lp10m9z65k5/yCzjaFK0HOBBuR3zD0JIRWM62d/sXjCfu5dQmaMfSaPxhUP5eMGvqiRYCGxBENqD0H1ervrIRwiIt5rqvql9+cF3KHg1xkz48d9/RhQ9RJTm7lWdRQrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LT9HQ3Jf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LT9HQ3Jf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06315C4CEF5;
	Wed, 23 Jul 2025 11:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753269999;
	bh=6UvgZ6FlP9BrAv2GeuGkoQUCGSFiSZSU8Yjga4iyc8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LT9HQ3JfoxkJUoYA8Z+o0sRLHWYSMoeIu8U42YLQN2McvJQPaKWv7PDSwIaUjJc6y
	 8wVGUiXrp4NUtjb3XWI8IklUg1ZVEh0Le9Hb8VqJW9NnwGU/UtMz0q3JbO3l8VTAcJ
	 EnHO+1ozRPCTNtQo8v5rCcRbySvLTEFcQx4/4KT2+6WcDezA9JMjpnmi7/JBDfZhPY
	 q4jjFWaz+LHHjR9fVMFVtsurwiK5VKbqpKzfVEXmjoyx2hvGV1Y35afCBCUTE25XC4
	 uni98d+vXuJfBks/wi7ITqwlCK8o07AKlgq72k2xrTGUkEVofNqGcvKXVc+dU55Mjj
	 4ARDzFMF8AiuQ==
Date: Wed, 23 Jul 2025 19:26:33 +0800
From: Coly Li <colyli@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Kent Overstreet <koverstreet@google.com>
Subject: Re: [PATCH 3/5] bcache, tracing: Do not truncate orig_sector
Message-ID: <hiry5xdjilb3qmcsqpuimjf3eo33tovoctx4gj4a5a4x2v7hwj@2vrjnidqa3g7>
References: <20250715165249.1024639-1-bvanassche@acm.org>
 <20250715165249.1024639-4-bvanassche@acm.org>
 <34508ac0-2060-4ea4-8fe7-de59ac64c677@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <34508ac0-2060-4ea4-8fe7-de59ac64c677@acm.org>

On Tue, Jul 22, 2025 at 10:54:02AM +0800, Bart Van Assche wrote:
> On 7/15/25 9:52 AM, Bart Van Assche wrote:
> > Change the type of orig_sector from dev_t (unsigned int) into sector_t (u64)
> > to prevent truncation of orig_sector by the tracing code.
> > 
> > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > Fixes: cafe56359144 ("bcache: A block layer cache")
> > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > ---
> >   include/trace/events/bcache.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/trace/events/bcache.h b/include/trace/events/bcache.h
> > index 899fdacf57b9..d0eee403dc15 100644
> > --- a/include/trace/events/bcache.h
> > +++ b/include/trace/events/bcache.h
> > @@ -16,7 +16,7 @@ DECLARE_EVENT_CLASS(bcache_request,
> >   		__field(unsigned int,	orig_major		)
> >   		__field(unsigned int,	orig_minor		)
> >   		__field(sector_t,	sector			)
> > -		__field(dev_t,		orig_sector		)
> > +		__field(sector_t,	orig_sector		)
> >   		__field(unsigned int,	nr_sector		)
> >   		__array(char,		rwbs,	6		)
> >   	),
> 
> Hi Coly,
> 
> Can you please help with reviewing the two bcache patches in this patch
> series? Apparently you didn't get Cc-ed automatically by
> scripts/get_maintainer.pl. See also
> https://lore.kernel.org/linux-block/20250715165249.1024639-1-bvanassche@acm.org/.

Done. Thanks.

Coly Li
