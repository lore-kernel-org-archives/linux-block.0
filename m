Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6E9383328;
	Thu, 27 Aug 2026 03:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787802591; cv=none; b=gSjLIXw4DVjsSUct4a4HJyod3FOFglTSQiiNCcc8WWvJrhGsYXBdNWBjTeaJ6w0gC/3fXxuLoYRLkaL+92sl4FFuXQsa+jfDVzASulC0ECLfZ/6KtJQQWQVdh/xbsYt50sk0EkYQksm2FfDJuQ/mwkhorkUD9szcbS3SOnVYPFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787802591; c=relaxed/simple;
	bh=igb50QrfF84eGcNXm1dpgl4szbeXCHNDQIoRj/Al6a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnh6kRRyZ3OQB5KDEY3VzwLlvoza9bIXJweGCFk+ACBWXfXxS7cJWLcuBfxi49ACEMlByXEHDxLX/WtLKlP/mB2wlLyhhepR1qwjUPrYcZ7HQE4cPe8rFb8rXvR8vuJeXfuzisF+igbw4qpQW5nz3s/is2ubrDHNCH9LZL3/vF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZGJl6Nn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZGJl6Nn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBAE1F000E9;
	Thu, 27 Aug 2026 03:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787802589;
	bh=dhufDDpPatwfSinFpRRrx2lSqixbpL4CnJZGnUElFjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dZGJl6NndyjeNODl/icVscwB4pN2OzsecgBtXgdUSnp3WXJhycaWn+eUsteJihbGH
	 6WczQIB4D+BbRNd4tRPbl02cQdyVhmgU0RoIq7Quv5dxL3Hzgm4bRRDwWBiXgZThkB
	 76v1jcscEbHlil2AoyEOanfJymCMqSKiZfJJ3nFZEEzZgb0acEY8Osg49oE33p5BLj
	 sEtwS3gHAcqvzSwDFYr34Fi+VUDekkTHKemZiPfdPofgYWpsBPRmY4sS3PSipP9MrY
	 bTwnZC1PmCkpQkLcHRQUWwa5R2ue++oltK7WnTZl1cyKEQxkef0zfHXBTMsbDSuOgY
	 IBYEOpg3TIXeQ==
Date: Wed, 26 Aug 2026 21:49:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Md Haris Iqbal <haris.iqbal@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC for-next 0/3] block: delay support for error injection
Message-ID: <ao-z23T9yE6Z2BTZ@kbusch-mbp>
References: <20260827000115.128093-1-haris.iqbal@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827000115.128093-1-haris.iqbal@linux.dev>

On Thu, Aug 27, 2026 at 02:01:12AM +0200, Md Haris Iqbal wrote:
> Two things are worth a look.  A delayed bio is resubmitted below the
> injection hook, so the rules are not applied to it again and it can never
> pick up a status from another rule.  And holding a bio back reorders it
> against bios submitted later, which breaks sequential write ordering on
> zoned devices.  Both are documented in patch 3.

Would it be possible to do the delay on the completion side instead?
That should avoid those submission order problems.
