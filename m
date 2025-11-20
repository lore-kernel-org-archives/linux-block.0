Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD80918DB01
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 02:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604504; cv=none; b=j168zAqr6kzF4RQckm8T4ynz+GyAhL0bYX68kXRST62b1+06GSB13EeqqSEkjle10UUhgBI7NBmSWgDAUnIxc3subl1uftw3jqFBDYlULYycc3FYuhInK0fq2Vrx7/CQgjhSBaS9Wz+D6R1bVeB0FTySY3TX05/L6pjhJp0QIM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604504; c=relaxed/simple;
	bh=WQ/SMyzjtzd/v0iVSKxe9BiXpoLRjR1ellufJoDNb10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ElfH+SWXyt//J/1LV+g6mq+v0UkvfJvOVYqGfJI7CtNju/LQCKjJt8nhtaknGCbC6bzxzj4yR2QaZUEtYtcro7x4k0YTS9FBuEEexnUFQqxOfOPA5W7k7WS7FIrmfeQsWZrx1MTMCdjhmBjryg2fliGxd/wfPSIMw45N8rsKu8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQzqAfzD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQzqAfzD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7179C4CEF5;
	Thu, 20 Nov 2025 02:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763604504;
	bh=WQ/SMyzjtzd/v0iVSKxe9BiXpoLRjR1ellufJoDNb10=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CQzqAfzDkUiZ9urxBtJP0B9DvYYa31Uz/gpRTb3w9eD3VrI5gHTeNCMCGNptiu4nR
	 xStmcWFwbW49AtkGkFoWzYa9XKR5UqTMs4Yurc192cjfWTJ92VlCqopi8IS4WlkzBL
	 cL6Tk0d9MxLM+hu6xD3uE254uZknYe0T6NKcElnOKQtSpzt38lau1gNZVfnuReXCOE
	 G0UuypHH1joWI8nhX00soNtgZ+NAzlDuD06GkPnpRWM3uibcA/q1Q87dSp8Ch6oJ5D
	 5JrXMuzL6nDR+ACCO7uM4XDx94yaFtvSU69FWY+10ylA7Wm8gaDiBu3zVuxU6Vpc7o
	 kekOQxVJ5WnYA==
Message-ID: <76483814-97ba-4ae9-a9dd-19ba9a4a83b4@kernel.org>
Date: Thu, 20 Nov 2025 11:04:18 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] zloop: clear nowait flag in workqueue context
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org
References: <20251119232234.9969-1-ckulkarnilinux@gmail.com>
 <20251119232234.9969-2-ckulkarnilinux@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251119232234.9969-2-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/25 8:22 AM, Chaitanya Kulkarni wrote:
> The zloop driver advertises REQ_NOWAIT support through BLK_FEAT_NOWAIT
> (enabled by default for all blk-mq devices), and honors the nowait
> behavior throughout zloop_queue_rq().
> 
> However, actual I/O to the backing file is performed in a workqueue,
> where blocking is allowed.
> 
> To avoid imposing unnecessary non-blocking constraints in this blocking
> context, clear the REQ_NOWAIT flag before processing the request in the
> workqueue context.
> 
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
