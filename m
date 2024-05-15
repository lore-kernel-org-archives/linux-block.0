Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E535BAFC;
	Wed, 15 May 2024 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715771217; cv=none; b=J9E1cb/aO7UR2RIuTQ3EAxRWm59oE7XMa4tUpYEvX1W9zH5NzEyNBP0A8MQioljF7+xj6hmmSTOdF9MgrWXQPnu/riogwM8VixWniqjWfc8yoi+nrgRrJN5z0pjQIMV7ADGjYSZMnzo9h+JTEtKjyUnW+QfxaDnmq2B4Ll58UtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715771217; c=relaxed/simple;
	bh=5whSzgE848s25eHm6MbF4welNqlW7UUI4lx7+7DRh2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdTxKmhNzFrvJOW34+FAJm9ARccYGpAPc04iD4uf/T+nTRjbjlQUnOukkDnfx2tzGAmiZFcWU6i8dKpLfTPoVKAqW7IGU34EqT/r3N3/FnYcY6b0icwbXw7jKUSiWvNDD8wf8HyGwL63umZPGYREeeps9apIUBC8aRltSQNv/LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 44FADZci044451;
	Wed, 15 May 2024 19:13:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Wed, 15 May 2024 19:13:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 44FADUNw044434
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 15 May 2024 19:13:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <09f1879e-3d38-4d84-b73c-fd1688d07ea4@I-love.SAKURA.ne.jp>
Date: Wed, 15 May 2024 19:13:30 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux kernel bug] INFO: task hung in blk_mq_get_tag
To: Hillf Danton <hdanton@sina.com>, Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, axboe@kernel.dk,
        syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
References: <CAEkJfYMhv8AxxHSVdPT9bCX1cJZXw39+bMFh=2N9uNOB4Hcr=w@mail.gmail.com>
 <20240514103742.3137-1-hdanton@sina.com>
 <20240514224117.3191-1-hdanton@sina.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240514224117.3191-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/05/15 7:41, Hillf Danton wrote:
> On Tue, 14 May 2024 20:07:34 +0800 Sam Sun <samsun1006219@gmail.com>
>>
>> I tried to run
>>
>> # echo 0 > /proc/sys/kernel/hung_task_all_cpu_backtrace
>>
>> before running the reproducer, the kernel stops panic. But still, even
>> if I terminate the execution of the reproducer, kernel continues
>> dumping task hung logs. After setting bung_task_all_cpu_backtrace back
>> to 1, it panic immediately during next dump. So I guess it is still a
>> task hung instead of general protection fault.
> 
> Given kworker/u10:2:53 blocked for more than 143 seconds, or the subject
> line, how could it trigger gpf?

Since CONFIG_CMDLINE in the attached config file includes sysctl.kernel.hung_task_all_cpu_backtrace=1 ,
khungtaskd calls trigger_all_cpu_backtrace() when a hung task is detected.

trigger_all_cpu_backtrace() is expected to be safe, but there seems a bug
which is triggering a general protection fault.

