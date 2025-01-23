Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB3215AF6
	for <linux-block@vger.kernel.org>; Thu, 23 Jan 2025 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737622593; cv=none; b=X+paJYbDsHUuJ69lO5811TvtXVUEjQWALxNBVhblrKRA0zklgo2xmLa+Okj2VgMJcN+Izb2JepKnEbbO0zGtvITARvY5XhGj6krQDW9cvI9gyBa3/ugT0hhvx+kACtrZzQYhk7EvOjXVqRBLtzXHUSKidzncBjclvL6gh9ck/Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737622593; c=relaxed/simple;
	bh=dgR8kpL+F/8N7nnaWC2oXsO4TBOYFpSAVLK4nCNWiAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ATbOA9dmjRzFcr9l+qDeZhm9wZmvsA1H/f5tWhDMCcBhkyRLpjiD6XVHSjjWgkdl3gT+rYSuUNLwsk2hO8WGRPBHLcfWp6y3HFmPkLZmfasNq7rXMfHHbSO1O0q3KcywJYR6jkqCZFWb1egj5t5vfWyiWPy1kVSXQJhZvFnzxpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQHUcpAc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQHUcpAc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E411CC4CEE0;
	Thu, 23 Jan 2025 08:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737622592;
	bh=dgR8kpL+F/8N7nnaWC2oXsO4TBOYFpSAVLK4nCNWiAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cQHUcpAcWzMyK27wZNfgoGvdCR5/83WBP0UPhE6tLuoqlTRaJm+ihwgQjMi+882Aw
	 aH9H8sKZRKm+FrM1bKEI16VCfv3IUwxTK2hqie++9hwXPKcy/8kl2w5TVKqnjuyT9T
	 gT9pKMxUQHLTlMK0gRT49oo4Ce0WQalhnxwx+J7GhPAnKO3u4vNcDd3Slcqx5r98z9
	 IPgX87y82qxUa2ndSQ3gqvUbQqc3P0OO63xXusFd3mnxXpVUNqE9nyrVuk4YL5l9fF
	 o8px9dTukuCvwdSit/Aarzg4sUF9I26Sv6BYAUzojT6pu9KT1fTu2WB4IJ0QcvdfRo
	 rEMpiy7FdrtUA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Niklas Cassel" <cassel@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,  <lsf-pc@lists.linux-foundation.org>,
  <linux-block@vger.kernel.org>,  "Jens Axboe" <axboe@kernel.dk>,  "Matthew
 Wilcox" <willy@infradead.org>,  "Luis Chamberlain" <mcgrof@kernel.org>,
  "Miguel Ojeda" <ojeda@kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Rust block layer abstractions and
 benchmark strategies
In-Reply-To: <Z5C_1UmKQ1gSqlXQ@ryzen> (Niklas Cassel's message of "Wed, 22 Jan
	2025 10:52:21 +0100")
References: <871pwwctcj.fsf@kernel.org>
	<pAX6FrMK2jF3_7cYCG-6vidZEz1v2Gey8Qwq1QJ18zbttR5hgHP7ziCajIo3_Gok8strlNhWaOLX0o5jIKDFCw==@protonmail.internalid>
	<w4gsgpfgz335cvyjjk5oaykl3wav7d2q4robxuw73pqkkxznlx@hgap3lzl3vbs>
	<87sepcba9s.fsf@kernel.org>
	<TDEMoZmJjGhVnY-3otXnTC5jrmSm4BXY_cRbeQUN0LjBnBt0wsW2QS_CeOoxUlgxIYzhpRv4QQAm_rAjz_4-9A==@protonmail.internalid>
	<Z5C_1UmKQ1gSqlXQ@ryzen>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 23 Jan 2025 09:56:20 +0100
Message-ID: <87y0z1zz63.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Niklas Cassel" <cassel@kernel.org> writes:

> Hello Andreas,
>
> On Tue, Jan 21, 2025 at 01:51:11PM +0100, Andreas Hindborg wrote:
>> Hi Jan,
>>
>> "Jan Kara" <jack@suse.cz> writes:
>>
>> > Hi!
>> >
>> > On Tue 21-01-25 12:13:48, Andreas Hindborg via Lsf-pc wrote:
>> >> I would like to propose that we have a session on Rust in the block
>> >> layer again this year. Specifically I would like to discuss some rather
>> >> puzzling results I observe when I benchmark the C and Rust null block
>> >> drivers. I did a write up of the challenges I face at [1]. The
>> >> observations are not tied to rust, they also manifest in the C driver.
>> >
>> > The results are indeed somewhat curious. One factor I didn't see addressed
>> > in your blog is CPU scheduling. I've seen in the past cases where IO tasks
>> > were getting migrated across cores leading to jumps in perfomance. Did you
>> > try binding fio jobs to one CPU each?
>>
>> Yes, I am pinning the io jobs to cores with fio options `cpus_allowed=0-<jobs>`
>> and `--cpus_allowed_policy=split` so I get 1 job per core.
>>
>> The kernel is configured with PREEMPT_NONE=y.
>
> "I also cover a problem with the benchmark results that manifested during
> testing for v6.12-rc2."
>
> I assume that all the results on:
> https://metaspace.github.io/2024/12/02/problems-in-benchmark-land.html
>
> are with kernel v6.12-rc2 ?

Yes.

>
> It would be interesting to test an older kernel version, and see if it
> is e.g. a scheduler bug.

Yes, I did not do that. I should collect some more detailed data for
past kernels.

> You might also want to test with this series applied (which landed last
> minute before v6.13 was tagged):
> https://lore.kernel.org/lkml/20250119110410.GAZ4zcKkx5sCjD5XvH@fat_crate.local/T/#u
>
>
> It fixes bugs that were introduced in v6.12-rc1 and v6.7-rc2 respectively.
>

I'll try that, thanks.


Best regards,
Andreas Hindborg



