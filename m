Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBE93D3D03;
	Tue,  2 Jun 2026 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780394310; cv=none; b=k23dwNUXhVzVS1r5r/jxup8U2wRbr+sUWMAQVRSW7QVaKt2hzlBZNdivJM09iz0XDge5kYqVDv8slj8P+EZroVfq3A8ivW9cixVIOjAAiIOy7ZqCovrpcAUU9qvh2r4ftWEMwiEMRCSZRPTHpdX8Xs9pGi1geqwKPnjp47zPRDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780394310; c=relaxed/simple;
	bh=rj8exp7Amd9Ol8HJ44cvBYkEXAiW5cNwu7/fcWUYLW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NngY2FeFq2Owx+11alUF1YwNq6gdGlc3qS/X5zo5iGpPK9KlBM9WFkDiCORXP923jhOiSaom6Ho3dQ35VVRqJUfAgJsqW1jeuxqXwySkt0H/LKDUqxJTqVtmNtAQqKIiVtuwgZyddaXzCu4yhhYtQXSPvghObCThLiQwmi76YvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2WUXT9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2WUXT9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C444E1F00898;
	Tue,  2 Jun 2026 09:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780394309;
	bh=ATzXC1zmaZ/vfuDrUdct+l2gZdFTjFwyYzm+mZ+8ldE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=G2WUXT9juyCz3FhbTrS5sMLYCg+ZzFkZiN5Xfor4oN5EyxLpFUAyGxxjyYo2BT+7y
	 6BRDFbckSxYfQr/vPI9hU0ffJtpookD4g020tFhwVt83RYEdwWoaDZ0mzLcffBO93S
	 4SnZQXIwM998Abvzd3Rdbc4+v16+5ZkHvJHddENeF3bMWfHzSIinE/HDYU0La039Gg
	 MkJj58fPoVKCBSaBzv/zxoxUBBV6TmQfAD/zAEdJB2HllsH48gNukHjnhXvPtEYAOY
	 JnqVooRum7EUcmFL2jTwDBQFMGB62cFPz1TMQ8jrQuzNDn0oJIvd/yCmWAFZfaboWh
	 oxN1yt01zYBGw==
Message-ID: <e4c653ec-dfb4-4dce-a565-2a43520fc44f@kernel.org>
Date: Tue, 2 Jun 2026 11:58:25 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: configurable block error injection
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Brendan Gregg <brendan.d.gregg@gmail.com>, GOST <gost.dev@samsung.com>
References: <20260602054615.3788425-1-hch@lst.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
In-Reply-To: <20260602054615.3788425-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/06/2026 07.45, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds a new configurable block error injection facility.
> We already have a few to inject block errors, but unfortunately most
> of them are either not very useful or hard to use, or both:
> 
>  - The fail_make_request failure injection point can't distinguish
>    different commands, different ranges in the file and can only injection
>    plain I/O errors.
>  - the should_fail_bio 'dynamic' failure injection has all the same issues
>    as fail_make_request
>  - dm-error can only fail all command in the table using BLK_STS_IOERR
>    and requires setting up a new block device
>  - dm-flakey and dm-dust allow all kinds of configurability, but still
>    don't have good error selection, no good support for non-read/write
>    commands and are limited to the dm table alignment requirements,
>    which for zoned devices enforces setting them up for an entire zone.
>    They also once again require setting up a stacked block device,
>    which is really annoying in harnesses like xfstests
> 
> This series adds a new debugfs-based block layer error injection
> that allows to configure what operations and ranges the injection
> applied to, and what status to return.  It also allows to configure a
> failure ratio similar to the xfs errortag injection.

I wonder if the block layer would be interested in moving block error
injection off the should_fail() fault injection framework and extending
the ALLOW_ERROR_INJECTION annotation instead and offloading all the
debugfs configuration logic (block/error-injection.c) into eBPF?

I talked about moderr [1] at LPC 2025. It's a simple error injection
tool in eBPF for the module subsystem. The suggested direction there was
to generalize the tool to ideally to no tool at all, and leverage
bpftrace to describe the error injection conditions a given
subsystem needs to be tested under. That would let blktests, for
example, absorb that and simplify the configuration logic this series
adds in the kernel for debugfs.

A previous attempt to add inline error injection [2] was rejected as too
intrusive / source-polluting; the eBPF approach solves that, since the
injection logic lives in a standalone tool/script rather than in the
kernel sources.

What do you guys think?

[1] https://lpc.events/event/19/contributions/2204/
[2] https://lore.kernel.org/all/20210512064629.13899-1-mcgrof@kernel.org/

