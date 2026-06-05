Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E63407592;
	Fri,  5 Jun 2026 06:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641254; cv=none; b=lCnUw6nRYh+hB5GtuT8/8sZPnL+E1V0qLn5gyIPSzdd0Bx+2j7TwWYrKbj5do6UhaXFHSOJA31h66tTtuYfs+Qx7TkuAT5tTjB8ZQye9U9NpO0Ly6hwqHLorbSKaYavjFxSZRghzquYMNV5alKFzHXdCtMGClXKHFhXvEf5wqEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641254; c=relaxed/simple;
	bh=tLaZYVeTaOMoMRVOxRG3tDV+wwu4/EUAlzXG578KDCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMF4srd3LPs2sFkfPsCLKLm3HZlwUb5vW9481oHOTouR3g3tonMQY+UTeKJ9/aDNCPb14XqLbyD28MeDrc4CirvqMwjHWnb2hacslPx8QJZARSfPfDJ81M7SgGhcSBggusLFKm9XuDTXejFuEE5x+kJf7YYQR/uxh9F+V/TO67c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ez53p94D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ez53p94D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FA81F00893;
	Fri,  5 Jun 2026 06:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780641253;
	bh=DbfIj55Sv7cmo68RLBus49QLwPGZwaa/3if4NpR3DzE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ez53p94DSgTTYurFo96qsZkWeYrWBroP5fEk8fTi/eGxAZzxzQD7o1jjNs/B2D1/u
	 w1I0seOgN18tyP+Ycg1QESHwpMRhEdlUOmVgv2gCm67NzvYnRPz+dZxRiqMabIUkTH
	 z/xu9XQc+pGWGg7HRwvXRUYfDgfHbnCuepjAuOrNsaIcbPhPE9ivEzvRQeAfh/ZtTv
	 NBJngUmgPypmZtl4JLdC8jz6sqIMRlQbZAwJzkipaDa1xYinbN6YfkL6GFvdMXasZy
	 H8h6Y69w9k799hW2QYOFSw/k4b0hSstGTRPj2DXv2hD7pUF4EnPJZwuSYtAfGQ/q6y
	 sGLizbpu0k3HQ==
Message-ID: <7bf0c159-b93b-4892-97fb-16b55f236e53@kernel.org>
Date: Fri, 5 Jun 2026 14:33:50 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Add WQ_PERCPU to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Jens Axboe <axboe@kernel.dk>
References: <20260604105347.168322-1-marco.crivellari@suse.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260604105347.168322-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/06/04 18:53, Marco Crivellari wrote:
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
> 
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> The refactoring is going to alter the default behavior of
> alloc_workqueue() to be unbound by default.
> 
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
> must now use WQ_PERCPU. For more details see the Link tag below.
> 
> In order to keep alloc_workqueue() behavior identical, explicitly request
> WQ_PERCPU.
> 
> Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> Suggested-by: Tejun Heo <tj@kernel.org>
> 
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
