Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452B846A61A;
	Fri, 18 Sep 2026 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727956; cv=none; b=KTWh+Yon8oVuclSZRpHjB6OMewb9jPsw64ArBCFaERvRvT8/Vs0uXaB25ltkrKgeLK6ImLXC8WBQTcpEDGF2dJEQ/yJdnusUpxGqaGI5p23P0ePd7OOIBH+me3ZoXk7mgzvtnh43Pp4sZjQ2ABi4UoT4jHnfUFCWzgnvyQ+I8RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727956; c=relaxed/simple;
	bh=cgAecvkmis8JXGkziTgbcdl5g5pSful1E5yPa4VX2Bs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7lz+gK+h/SkMMJFWkLSSlL1+vhS1pMTV5iAbGlW+osEv7xTQu/3vZOiGiEyhh4BePn3m1SOJ73Y2UmFMfZ4b8ESfPR/X8TW3cdAvoZhUF9gPwl8N6kHIZI94G44QZ7e31T35q/SfnHEZNrNjmvyl+pFBvdAl5oT7c35Pm60PyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: OquXUPoHT66oNEcvihwAxw==
X-CSE-MsgGUID: /08qwzvdTbSUWRfLNb23PQ==
X-IronPort-AV: E=Sophos;i="6.27,103,1786982400"; 
   d="scan'208";a="189368164"
From: Wang Shuaiwei <wangshuaiwei1@xiaomi.com>
To: <bigeasy@linutronix.de>, <axboe@kernel.dk>, <frederic@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tglx@kernel.org>, <wanghui33@xiaomi.com>, <wangshuaiwei1@xiaomi.com>
Subject: Re: [PATCH] tick/block: Add BLOCK_SOFTIRQ to the hotplug safe mask
Date: Fri, 18 Sep 2026 18:39:04 +0800
Message-ID: <20260918103904.719661-1-wangshuaiwei1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917095110.Yxq3FCrB@linutronix.de>
References: <20260917095110.Yxq3FCrB@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX06.mioffice.cn (10.237.8.126) To bj-mbx11.mioffice.cn
 (10.237.8.131)

On Thu, 17 Sep 2026 11:51:10 +0200, Sebastian Andrzej Siewior wrote:
> Should this go via nohz, softirq or block?

I'd prefer it to go through the nohz tree since the change is in
SOFTIRQ_HOTPLUG_SAFE_MASK which lives in the NOHZ tick-stop path.

Jens, could you please have a look at this? The patch marks BLOCK_SOFTIRQ
as hotplug-safe, relying on blk_softirq_cpu_dead() to drain pending
completions during CPU offline. Just want to make sure the block layer
is comfortable with that assumption.

Thanks,
Shuaiwei
