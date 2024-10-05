Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCAC5647F;
	Sat,  5 Oct 2024 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728123050; cv=none; b=OJOQxVhAsbRoanNq4WodVi9HojeTXdAhJ7ez0Co5EnnPr6NfD2LcWoObEviB93sk4kv7aWbDMuuxWbgNe1tHgJsBdAG0G0vlt3sXJP6T17U9eysB6ViCP13wAA/MJNRVt2WZNtzdEnSnAzBAubPdzNV1awPfmhQV2CjPjY0N6kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728123050; c=relaxed/simple;
	bh=H9/FZQWydP25FSSA4Zc45Hkgk8l0yrzfGLewxYoQH68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaLfEH2avl0t4CdzKa88dO5VkuDAKHqdRGiFArdwh+nhTPnkjjJI5onS430JWzh24Famei2YfInTot8n9EgIPULt1YsdoGVLGdGyNrXdtdgzFq4REU99ljCeu7G10qEAGRFZ3cUQRgumZae1k9tmOL4EAAHST0TuTIeyvXBWF98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fAie9xal; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fAie9xal"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SnQCrDz4IjxNNAqu58If3CdJvwvx6KeUnz5tFFXgFvA=; b=fAie9xalUstMuTAwrSckuwC2JV
	UOJLhvNzgvditagkpQ+8494Mhw4fxHbpoKGBtyGYy5zvxU/k+1rFMYW5IXOl98qSg/BO+OGtVaw0O
	leeBp8dLYW/wuUvyQLfquSRsE2Dqds6PSSqieZre1YUgvmmxsXt+hQqOUdkX7NIIJFYNcirUkNJRh
	pOzcjyifT6B+T0xfw2yziFDubpNqitjylXyVMCM1OLsdaYQ21Jehlh9BvqxfFGsOYoNhNw7UBqsTE
	PhFYdQw/ce2NN7qYfScPDoxv4MrZXzuuFRw4jyIG9bvRson1hofqZUzjZPkjcp+UrVX5NO81Hq2yb
	Hhkk4ppA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sx1kG-0000000428K-21V9;
	Sat, 05 Oct 2024 10:10:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B6366300777; Sat,  5 Oct 2024 12:10:39 +0200 (CEST)
Date: Sat, 5 Oct 2024 12:10:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Gary Guo <gary@garyguo.net>,
	Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Jens Axboe <axboe@kernel.dk>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: block: convert `block::mq` to use `Refcount`
Message-ID: <20241005101039.GZ18071@noisy.programming.kicks-ass.net>
References: <20241004155247.2210469-1-gary@garyguo.net>
 <20241004155247.2210469-4-gary@garyguo.net>
 <OKHi9uP1uJD59N2oYRk1OfsxsrGlqiupMsgcvrva9_IPnEI9wpoxmabHQo1EYen96ClDBRQyrJWxb7WJxiMiAA==@protonmail.internalid>
 <2024100507-percolate-kinship-fc9a@gregkh>
 <87zfniop6i.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfniop6i.fsf@kernel.org>

On Sat, Oct 05, 2024 at 11:48:53AM +0200, Andreas Hindborg wrote:

> It is in the documentation, rendered version available here [1]. Let me
> know if it is still unclear, then I guess we need to update the docs.

> 
> [1] https://rust.docs.kernel.org/kernel/block/mq/struct.Request.html#implementation-details

So I clicked on the link for shits and giggles, and OMG that's
unreadable garbage :/ Is there a plain text form that a normal person
can read?

There's just too much 'layout' and fonts and colours and URGH.
