Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94098405C46;
	Fri,  5 Jun 2026 06:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641409; cv=none; b=ruGkd4pbLlmKAofww7Mt80HljWhZA0JzOmVfquoEuuu21zFdlNY+f5JHE2QYXd2RXOlhagdlJDpVOsuPDcZTHFdN8MCiAxXd4TMavtPlne2hGEgZqDICeq9G9mz1jLmPwKVYqSQ4RtWfdU7CMl2NJmJV796IbKl6jvJiY1qFCD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641409; c=relaxed/simple;
	bh=tLaZYVeTaOMoMRVOxRG3tDV+wwu4/EUAlzXG578KDCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=exACY3EIBPX1YFKBeJyNVfEYJ6bbJuuIw70TCAtoXDxOuo0iix/2mGAus4s+XvzprQy+ooa0O+O/8LcrWfhl9+lorQaoheYRndoGDEqbbNRINDrk36fcWBjJwG9DKN5hwzNpBSE0ipJFlt/juNA8ugbbJVVk8GCJ7EwfBgmuHSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNeXJMR5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNeXJMR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED821F00893;
	Fri,  5 Jun 2026 06:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780641408;
	bh=DbfIj55Sv7cmo68RLBus49QLwPGZwaa/3if4NpR3DzE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KNeXJMR5jBl5j7pK3nuBHnoWgZ0fVm0nm3sGcaFB+kufl9bI3HaOu4GvoSk22XBD9
	 zRev3Cw1aQOWIpgkcbZI7wqu1/OEgmnJsIHpFUfkSWYkXpbQYhQmYq+OM7JeRTZxy2
	 7RX3DUXW5eX+DERw8pt7xYhxYAL+zHN//36gmUr7JP9W0H/n/UVU4MVZWpD6T6UYPe
	 bAAO8Gc4Aj7lI4e/mKXClc1D8NQmhEw+iSj1XoGgLrIxK0UoMk2xQ6uecIsWjjrE1/
	 zy79glmkhYa7H93C9Bm47thUYw0EB/Q0BuXMIslaOz5SqoRbf3ppP2oYBn+NZa9Y9w
	 mRDn5OkLywrvA==
Message-ID: <d1393120-3381-496e-b73e-193620681916@kernel.org>
Date: Fri, 5 Jun 2026 14:36:36 +0800
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
