Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5689E48124F;
	Fri, 18 Sep 2026 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735360; cv=none; b=ln1xqCxm+0tdlOwZqvWuXpX1uVEvzrjdYoIjyDqO9GlgHTe02WWCpp1UajLrZn9JRzMnNpeazKpICkiFUNgx0f3tK8eoY5nbdZXZmEizejYPQjaKD8W42BLPJHSfwWE3eVUc/rVII5YijdDneFF+e3EOFTVTn2qn8sgXnje3SZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735360; c=relaxed/simple;
	bh=0uFk0CynoyO/XdCYFb3Tw+0SUFLkSrbp7zQb9omLFtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1zJTVig01NdlaCKFl1nYKlZ4zU0tsmnUSpWT/T7/ZO6CI/IpszLdRM278LxX3BDUbwlWfjWtCVMx3fe0yJlLrhmKwY+QyUAb6e9q/wG1BXp7fmbqtEKTVmfz2BMYB9QF/qLaEsxRnxY4TXoeNe6lmOa4Qy75/XAkQLV64x/K14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqOrIi3W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqOrIi3W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149281F000FF;
	Fri, 18 Sep 2026 12:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789735350;
	bh=GjjRWf7HDaYAWNrlA/Da3iWDgMAgsjm6IQnZ1nOhsZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lqOrIi3WLMh84srTu50HcJcPpXsL62x/YvaKqHfmOIYfHx+EjLVJqEj0/mlRIoNE8
	 czeQWrN4yc16TXZbyG5gHpguz3F36JhezzEPvtzXCAmN0CpLtVj8Bz7fS+EMefBLhL
	 Jj/q5Cu5vlR+4Q2s+25DdPtyzfz7ZmOU0/SplhPPY+gYgtu16/mfC9qAPEIpDTcvIy
	 tqW4PsQF3/RUS8xt0/DwKtIDNnD/27/gRnTvflzqwlZePYmcQY+COVcESqyn/pQ56c
	 bpGTA9frJs+HKAzgxjQhPBmtfYjkqZimtLrQGuPJdRLx4BySTm4lpn5OUWBbG1XMMH
	 3Y+zJLhSiaiUA==
Date: Fri, 18 Sep 2026 14:42:27 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Wang Shuaiwei <wangshuaiwei1@xiaomi.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	wanghui33@xiaomi.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] tick/block: Add BLOCK_SOFTIRQ to the hotplug safe mask
Message-ID: <aq0xs91Vs4NWBqa3@localhost.localdomain>
References: <20260904064506.671203-1-wangshuaiwei1@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904064506.671203-1-wangshuaiwei1@xiaomi.com>

Le Fri, Sep 04, 2026 at 02:45:06PM +0800, Wang Shuaiwei a écrit :
> During CPU-hotplug stress testing combined with an I/O
> workload, the following message is observed:
> 
>   "NOHZ tick-stop error: local softirq work is pending, handler #10!!!"
> 
> On CPU offline, ksoftirqd is parked at CPUHP_AP_SMPBOOT_THREADS while
> the CPU still takes interrupts. A block completion raised after that
> point stays pending, and if the dying CPU goes idle before teardown,
> report_idle_softirq() sees it, keeps the tick alive and prints the
> error above.
> 
> Such pending block completions on the outgoing CPU are drained later by
> blk_softirq_cpu_dead() (CPUHP_BLOCK_SOFTIRQ_DEAD), so a pending
> BLOCK_SOFTIRQ is harmless here. Add it to SOFTIRQ_HOTPLUG_SAFE_MASK
> like the other teardown-covered vectors.
> 
> Signed-off-by: Wang Shuaiwei <wangshuaiwei1@xiaomi.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
