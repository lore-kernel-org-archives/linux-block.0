Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C183976B8
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546935; cv=none; b=fX2ewmJFb4Lwh4oOkqXuOXte9b0wwZN1ZBW113leGDq+1bEFlRCCzZzcQHMig1iy9WH0uXydQgWCFZ0pkzfWwPPOIUhKXbrCt4jEjC0ne/i8bDre1GxAjg93sPZ7dZKWVLZQ3uvrYvJc/sue4iuxCqhTRknak/QYA4kBe+95gZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546935; c=relaxed/simple;
	bh=/1KpO1dKRdU/fdUTy4peKLipjQrOYCuoCJpgTJS3oF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yy/JQjE3viwoXiqHBZNZDBD+lU/1THlRLzH9NJPOlb2PZ2t6ICGDDBeI/2nONjXyjggBLUbLYaEUn0ZcvfaK0ZDGjjP8gi1i0BHsrKPGzqkAu5CTFQp6bRnMaVuIHAijQXiggovzh8hgpFeFgdA/8KUlJsr2Xwk7gf0K3iUwIi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jB0i1OFR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jB0i1OFR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6350C116C6;
	Thu, 26 Mar 2026 17:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774546935;
	bh=/1KpO1dKRdU/fdUTy4peKLipjQrOYCuoCJpgTJS3oF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jB0i1OFR2Ja0l2htLqBlcFAKA3RcWt84BnW69E+wyG4HxWXPgBWHOtgRtYKcsLOm0
	 gBa2ga2Qt5eAeA73vVp0l02M3odoCIDNBXxUNNadwtC7XR4DYp3DJZ68e7zMll7nij
	 r8GFWRxLu6w51MKsHMvhTgsQxvn83Z0p6KRKJfIYfoc0kMQbPJmScSZfGDMwYNt3hj
	 /JQ4OPmFhS4ctMh0bDVmGrgJeSQSkt4dj94qSayrdru0bk6YRyAMp8UcA0WUeSHGzo
	 MVd69aO4fPJcEBOFcDiFKmvXa7/87wUbPZRydbfNGB2IbysJ/rHp9kLKyO3/Y6lRsy
	 lxTjVCRdolbYw==
Date: Thu, 26 Mar 2026 11:42:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] src/dio-offsets.c: Fix err() usage
Message-ID: <acVv9VC-eNsUMma7@kbusch-mbp>
References: <20260326173632.3259254-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326173632.3259254-1-bvanassche@acm.org>

On Thu, Mar 26, 2026 at 10:36:32AM -0700, Bart Van Assche wrote:
> If the dio-offsets program detects data corruption, it reports the
> following message:
> 
> dio-offsets: test_unaligned_vectors: data corruption: Success
> 
> The "Success" part in this message is confusing and is reported because
> the err() macro is used incorrectly. errno must be set before err() is
> used instead of passing an error number as first argument. Fix usage of
> the err() macro as follows:
> - Change the first argument into EXIT_FAILURE (1). According to POSIX,
>   exit codes 1 - 125 mean failure and > 128 means that a program was
>   terminated by a signal. Hence, exit with code 1 instead of -1 if
>   ioctl() fails.
> - Use the err_errno() macro to set the error code instead of passing an
>   error code as first argument to err().

Looks good:

Reviewed-by: Keith Busch <kbusch@kernel.org>
