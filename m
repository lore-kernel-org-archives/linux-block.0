Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD7D1E2602
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729856330; cv=none; b=ijCtZ+foPovYOa2V90K4fREawZ/hhDS+9JGPShw6FU+O4ptpLJXL2/xbxOcWEgL1aEALCegf0nVRlLnbfhgDSUWx21yDfddBEKjmRZkjUQXfrTvcni7i8es0GXbbzjj7fu0fYrY4uGMzaWqVSCfGogXeUjiZ9+DIlBHztv9akcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729856330; c=relaxed/simple;
	bh=Z4Q8slMIMtMJmSKYguIVv1KdHC0gmNmdzYGlW0Noq8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=augyM3CKNkNUQCvAiDdJ4LopNJr98ly8qeBhkTp+2KyPXJ/8cYrnr/Kt8gwj5HcochWn3ra64MX03r2sf7wZg1iBsMbcXNlS2/ypB3gTmiZMkV5T0gJ3+vmZfAkkuI5NtN7VDhxmdYnEqXtadWpa7olF0pm4kqlg8skC3HHMVWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 49PAeBoR044851;
	Fri, 25 Oct 2024 19:40:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 49PAeAMD044840
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 25 Oct 2024 19:40:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a55c8d7e-cfd7-4ab9-ab45-bd7fdecaaf3c@I-love.SAKURA.ne.jp>
Date: Fri, 25 Oct 2024 19:40:11 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brd: fix null pointer when modprobe brd
To: Yang Erkun <yangerkun@huaweicloud.com>
Cc: linux-block@vger.kernel.org, yangerkun@huawei.com, axboe@kernel.dk,
        ulf.hansson@linaro.org, hch@lst.de, yukuai3@huawei.com,
        houtao1@huawei.com
References: <20241025070511.932879-1-yangerkun@huaweicloud.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20241025070511.932879-1-yangerkun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp
X-Virus-Status: clean

On 2024/10/25 16:05, Yang Erkun wrote:
> From: Yang Erkun <yangerkun@huawei.com>
> 
> My colleague Wupeng found the following problems during fault injection:
> 
> BUG: unable to handle page fault for address: fffffbfff809d073

Excuse me, but subject says "null pointer" whereas dmesg says
"not a null pointer dereference". Is this a use-after-free bug?
Also, what verb comes after "when modprobe brd" ?

Is this problem happening with parallel execution? If yes, parallelly
running what and what?

Is this problem happening with what fault injection?
What function (exact location in source code with call trace) has
failed due to fault injection?

> Call Trace:
>  <TASK>
>  blkdev_put_whole+0x41/0x70
>  bdev_release+0x1a3/0x250
>  blkdev_release+0x11/0x20
>  __fput+0x1d7/0x4a0
>  task_work_run+0xfc/0x180
>  syscall_exit_to_user_mode+0x1de/0x1f0
>  do_syscall_64+0x6b/0x170
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e

This suggests that a userspace process has open()ed the device
before brd_init() from modprobe completed?

Please show more context including execution flow until crash.

  CPU0: (or Process1)    CPU1: (or Process2)
    does what?
                           does what?
    does what?
                           does what and is wrong?

Also, you don't need to embed brd_cleanup() into the caller
just because the caller becomes 1 by this change.

