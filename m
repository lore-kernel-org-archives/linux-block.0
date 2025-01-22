Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C478E1F76B5
	for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737539546; cv=none; b=ZETWgtb/hRNu5lQ1o87P9gvzgBhBdqVA19wyiciCpHFtZmY67RDkIALgXKqpMS6CN68Yatc81pnsN61bdVN4nUMNgUGqmvz9Px0boZH4rdVV2bQYDlXh7D5y9TodKdalj2VXxHYbcUbsq/QVIMiObeWLp1GD7ck+Nj3wbmxspf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737539546; c=relaxed/simple;
	bh=NsyewGEbYzexxEIT1SKbiccp+d/Xzuqhr59lZjLaGw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pM9IqgZhnAr6axW4sFMw/iffGWE/xB7ZN3rxlPkqXD3TxOsQ78dzJXgD1HfMyPYqzxvRaPvgCcJOo+mwyue5NAW6OvC5eDmRoGEMTnQ4/uZX6cjWURTakKxeZ0cJiRzIjHc7wRiBF77RjkqDdRiAHpxCQJ4O7+lRkGcmwSeAMCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kM4bOIQH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kM4bOIQH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81066C4CEE2;
	Wed, 22 Jan 2025 09:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737539546;
	bh=NsyewGEbYzexxEIT1SKbiccp+d/Xzuqhr59lZjLaGw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kM4bOIQHBsRtFDk8pz9EYWp0wFLaRoiYaUMNAIaQclvVZGbPwW4+x36y4jviewc6Q
	 rook+aTn3A43Wr/Kv54QWdSRAj+lRns43g/NPe9umcAw/pd+b+9BaBOgkZN41/fPa8
	 tSeV7RxVnj8SKAt19ROEksvQpEkyli3+nV/SOPttVBhBXx+8yUKjCHpAF0AmXLYTwm
	 bbw69GSSArkQaKQQ+pYilApRaucOU2/x1qyP7j2aGayp2t09aPlYJ2lc6beKSt7h2R
	 cJ2CZqiBG7PfzYA8yFmUR0t7MUHoMCLJTY7UgyDWXiWn/RkATXgYHv15CDSMWZ/Bck
	 5TmXtG1atsLbA==
Date: Wed, 22 Jan 2025 10:52:21 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jan Kara <jack@suse.cz>, lsf-pc@lists.linux-foundation.org,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Rust block layer abstractions and
 benchmark strategies
Message-ID: <Z5C_1UmKQ1gSqlXQ@ryzen>
References: <871pwwctcj.fsf@kernel.org>
 <pAX6FrMK2jF3_7cYCG-6vidZEz1v2Gey8Qwq1QJ18zbttR5hgHP7ziCajIo3_Gok8strlNhWaOLX0o5jIKDFCw==@protonmail.internalid>
 <w4gsgpfgz335cvyjjk5oaykl3wav7d2q4robxuw73pqkkxznlx@hgap3lzl3vbs>
 <87sepcba9s.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sepcba9s.fsf@kernel.org>

Hello Andreas,

On Tue, Jan 21, 2025 at 01:51:11PM +0100, Andreas Hindborg wrote:
> Hi Jan,
> 
> "Jan Kara" <jack@suse.cz> writes:
> 
> > Hi!
> >
> > On Tue 21-01-25 12:13:48, Andreas Hindborg via Lsf-pc wrote:
> >> I would like to propose that we have a session on Rust in the block
> >> layer again this year. Specifically I would like to discuss some rather
> >> puzzling results I observe when I benchmark the C and Rust null block
> >> drivers. I did a write up of the challenges I face at [1]. The
> >> observations are not tied to rust, they also manifest in the C driver.
> >
> > The results are indeed somewhat curious. One factor I didn't see addressed
> > in your blog is CPU scheduling. I've seen in the past cases where IO tasks
> > were getting migrated across cores leading to jumps in perfomance. Did you
> > try binding fio jobs to one CPU each?
> 
> Yes, I am pinning the io jobs to cores with fio options `cpus_allowed=0-<jobs>`
> and `--cpus_allowed_policy=split` so I get 1 job per core.
> 
> The kernel is configured with PREEMPT_NONE=y.

"I also cover a problem with the benchmark results that manifested during
testing for v6.12-rc2."

I assume that all the results on:
https://metaspace.github.io/2024/12/02/problems-in-benchmark-land.html

are with kernel v6.12-rc2 ?

It would be interesting to test an older kernel version, and see if it
is e.g. a scheduler bug.


You might also want to test with this series applied (which landed last
minute before v6.13 was tagged):
https://lore.kernel.org/lkml/20250119110410.GAZ4zcKkx5sCjD5XvH@fat_crate.local/T/#u


It fixes bugs that were introduced in v6.12-rc1 and v6.7-rc2 respectively.


Kind regards,
Niklas
