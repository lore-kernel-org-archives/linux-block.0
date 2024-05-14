Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2CA12E75;
	Tue, 14 May 2024 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715672388; cv=none; b=E+Daa7f9xV9nLoxuN+fDAH7966X1TQ1Bg9xcx5MtheemNDOctecueyOlH8ijEq9H7D96YVWXSr5BKMupAhdzqILbIhrB8l8e6qGfQoMaoDOVsvvWEFq0vU5arpcNco8wem7LBm6kY/++I01Mn3U1AJbQLxhvI+xhXH4NMboG/PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715672388; c=relaxed/simple;
	bh=O6fvMG9fls+8aSK9zXqzwgl4m3ezYko0QL6OnAcKSq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0ne7HKG6+JJtHw9UxAU+8bnZZdHr8iUm92XEyyVVnrL+CyQtWls8K4dR6DpjZsQFLQL0o/wV8fOP6GVBiqWZHOpNK4nY7PgM7HdXueLZugP3lYOjoJu8pXcscLsNMrT/8oK/MV5K8gXxzr5C9VNpIxWZs5mxnDziyK8Pz7+ZoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 44E7dWvk004086;
	Tue, 14 May 2024 16:39:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Tue, 14 May 2024 16:39:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 44E7dVMG004083
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 14 May 2024 16:39:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <21d52c65-4f18-46a2-be68-ff8487103e82@I-love.SAKURA.ne.jp>
Date: Tue, 14 May 2024 16:39:32 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux kernel bug] INFO: task hung in blk_mq_get_tag
To: Sam Sun <samsun1006219@gmail.com>, Hillf Danton <hdanton@sina.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, axboe@kernel.dk,
        syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
References: <CAEkJfYPxWBfEnuKeCGEsscVTYy8MrNxCJwdbxS=c2-B0H+HfTA@mail.gmail.com>
 <20240513225409.3025-1-hdanton@sina.com>
 <CAEkJfYMhv8AxxHSVdPT9bCX1cJZXw39+bMFh=2N9uNOB4Hcr=w@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAEkJfYMhv8AxxHSVdPT9bCX1cJZXw39+bMFh=2N9uNOB4Hcr=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/05/14 11:05, Sam Sun wrote:
> Pointed out by Tetsuo, this kernel panic might be caused by sending
> NMI between cpus. As dump log shows:

You can do

  # echo 0 > /proc/sys/kernel/hung_task_all_cpu_backtrace

before starting the reproducer in order to disable
trigger_all_cpu_backtrace() from hung task.

If trigger_all_cpu_backtrace() from hung task can reproduce
the kernel panic, I think that trigger_all_cpu_backtrace() from
SysRq-l should be as well able to reproduce the kernel panic.
That is, you can build with CONFIG_MAGIC_SYSRQ=y and try

  # echo l > /proc/sysrq-trigger

for bisecting and reporting as a separate bug.

