Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1757B667;
	Thu, 31 Jul 2025 05:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753939475; cv=none; b=RF+8rLQQ2TvTgRWj+qejGI2EP7TDgYyueF8Cs0tystGH62zAR8C3F2xJneenkjMA+wZBez793p9H0fuBTW/+JEPzy5iQPYWWnjx2TxQlGOVgrx/JiAoAsap2OgoOPWjbDU2U6KSE1fEjcmqgQNQu7kGOEuHJRGyrfYisqyRV2uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753939475; c=relaxed/simple;
	bh=F/ZxZJgCuAbMs9EzbKvWAgIIXYUt+6FicNW5gRq3UaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZigsVOhZHFKBkTrnHwf0TKSc96SYJuoTjFN+A2Tq6FzO8eZ8m1prhOrGtFrQ9C0ATeRX8xxbck4j2f54jfYACgVftsgFJJy381Sj2vXitFkcx3MmX1u82+KRmqdPTcQuWJGQBtmA+hm49hyJpN1k2dAMLyLV1I3Um6kXV3C17U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=He8xGEJE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="He8xGEJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E29C4CEEF;
	Thu, 31 Jul 2025 05:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753939474;
	bh=F/ZxZJgCuAbMs9EzbKvWAgIIXYUt+6FicNW5gRq3UaI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=He8xGEJECy98A7uCITKZU4FGPz6XEzrLLymA4sOB+NEtg8JGw74dEE230xgPHRmgL
	 A73WlaGi7qQoUHY3oPzYlWFEzXA5FL7ymLY/XgoKmh4/qYhHBBiot0UrXH+/tXYLiE
	 HsJ97Hb4glpsEagiH4nZJmDKDZGLkoxgLFUC2LaDHNoVxp1Ig3vdgmJfafk2cgCvse
	 QWmoMqdH67svxLnq1F63IwQsiDM57Y1+qpuv3wcCbIW7HFE+APkGDLTrA8ZxJqpkLW
	 rTGsY/KoAEHV9XYQYi3Wl6cs3z9KLxhBpd5owKdI1Jkh56d9RYMAyvB4ryfKnWjQz/
	 NZS0c/n/r1MMA==
Message-ID: <04e4aa4c-8d33-42ab-88cc-3dceadd6c9b1@kernel.org>
Date: Thu, 31 Jul 2025 14:22:00 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix default IO priority if there is no IO context
To: Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>
References: <20250731044953.1852690-1-linux@roeck-us.net>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250731044953.1852690-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/25 1:49 PM, Guenter Roeck wrote:
> Upstream commit 53889bcaf536 ("block: make __get_task_ioprio() easier to
> read") changes the IO priority returned to the caller if no IO context
> is defined for the task. Prior to this commit, the returned IO priority
> was determined by task_nice_ioclass() and task_nice_ioprio(). Now it is
> always IOPRIO_DEFAULT, which translates to IOPRIO_CLASS_NONE with priority
> 0. However, task_nice_ioclass() returns IOPRIO_CLASS_IDLE, IOPRIO_CLASS_RT,
> or IOPRIO_CLASS_BE depending on the task scheduling policy, and
> task_nice_ioprio() returns a value determined by task_nice(). This causes
> regressions in test code checking the IO priority and class of IO
> operations on tasks with no IO context.
> 
> Fix the problem by returning the IO priority calculated from
> task_nice_ioclass() and task_nice_ioprio() if no IO context is defined
> to match earlier behavior.
> 
> Fixes: 53889bcaf536 ("block: make __get_task_ioprio() easier to read")
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
