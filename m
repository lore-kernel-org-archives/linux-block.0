Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E3D4052D1;
	Thu, 17 Sep 2026 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789637470; cv=none; b=Cmi61NeW3RIA5zbg/+BosIPnZtPisOcpJjyGuU+fu2c60QoJc4yW1d5qbplfPqCMuudz2dIKBB6sfEWCILrbUcHfPwyEJgQgroiim2dBcOIHdEeKUzb5/t/Ge75+A08bv/phShIUPhzmCoHpZsTDxPZ6mWMFHl9LZxF80fYrmSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789637470; c=relaxed/simple;
	bh=nwZTcZKVLRm50CIVekV0K0bp7pKksHayuQkt2Apq7QM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7zbyNk5eHNefhpvGZi0XZmD2nFd5dhPYT9VdcxVMQa+KbTYmYP/OTja0xRwhXZiI2EZPjL9HcNV67e7YEkGaACMiWx0uu4WNtlc0K5pkHcJn0WCS/R1SqwpfHbMTJCE3KyZG2SDoZvlD1DuZkZLMnjsOJAHlqVVuwZtW4SQe04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: kf/kbZv9SOiUzOP2V8rocQ==
X-CSE-MsgGUID: ZV6LaNEXQAecKrsITrMkBg==
X-IronPort-AV: E=Sophos;i="6.27,103,1786982400"; 
   d="scan'208";a="162925306"
From: Wang Shuaiwei <wangshuaiwei1@xiaomi.com>
To: <axboe@kernel.dk>, <bigeasy@linutronix.de>, <frederic@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tglx@kernel.org>, <wanghui33@xiaomi.com>, <wangshuaiwei1@xiaomi.com>
Subject: Re: [PATCH] tick/block: Add BLOCK_SOFTIRQ to the hotplug safe mask
Date: Thu, 17 Sep 2026 17:30:53 +0800
Message-ID: <20260917093053.176889-1-wangshuaiwei1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904064506.671203-1-wangshuaiwei1@xiaomi.com>
References: <20260904064506.671203-1-wangshuaiwei1@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX08.mioffice.cn (10.237.8.128) To bj-mbx11.mioffice.cn
 (10.237.8.131)

On Fri, 4 Sep 2026 14:45:06 +0800, Wang Shuaiwei wrote:
> During CPU-hotplug stress testing combined with an I/O
> workload, the following message is observed:
> 
>   "NOHZ tick-stop error: local softirq work is pending, handler #10!!!"
> 
> On CPU offline, ksoftirqd is parked at CPUHP_AP_SMPBOOT_THREADS while
> the CPU still takes interrupts. A block completion raised after that
> ...

Hi,

Just wanted to follow up on this patch.
I'd appreciate any feedback or suggestions when you get a chance.

Thanks,
Shuaiwei
