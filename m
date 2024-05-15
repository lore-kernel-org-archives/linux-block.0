Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BA78625C;
	Wed, 15 May 2024 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715778738; cv=none; b=ofzmteHwoA2fEINAdKUD/AuneCw6P7WSsAExpTDhBDtQGsff7ECIf3/ZtNdG+oZBwVszjuvFh2+iTtyntnHMe2/CgEGinAtlQt+QnwG8omstr94sIeSNSqS9qMWeuH+PyUHAkvG0X4kSQLbUrHlIYnzfpgkzhHEP9qA/XDoz2qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715778738; c=relaxed/simple;
	bh=/0KXK6PmkZcde0ubOE7xzi/16BLUawUejjdCW6lX7S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIZs/joK4wZXmTCOpt6a/uYYIX4WONor5vvYpUycmJET4+xLMlpdWQZ+RtZcqpLeNh/p/VRkSvGUOTaMohy2veO3bfOe1DDr22YGTbUJyOKX6mW3MZt90ohQLScSuK8V96FvTNX2Yicqo8xOolUKEgA7wSq93RwGzzMLuQQLK+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 44FDC0M4081731;
	Wed, 15 May 2024 22:12:00 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Wed, 15 May 2024 22:12:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 44FDC0JS081728
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 15 May 2024 22:12:00 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8aa947c2-5373-4efd-83db-6a5f75069317@I-love.SAKURA.ne.jp>
Date: Wed, 15 May 2024 22:12:00 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux kernel bug] INFO: task hung in blk_mq_get_tag
To: Sam Sun <samsun1006219@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
References: <CAEkJfYMhv8AxxHSVdPT9bCX1cJZXw39+bMFh=2N9uNOB4Hcr=w@mail.gmail.com>
 <20240514103742.3137-1-hdanton@sina.com>
 <CAEkJfYPH3SJ6J3kLSjMGqkWOzgbgKZV_f2Hq05cpZZv7RmhvOg@mail.gmail.com>
 <cfe6b902-5e2d-415d-afeb-672cafd8d0b7@I-love.SAKURA.ne.jp>
 <CAEkJfYOBnhVGNENZkkdoX1g+gE=eVNFwNRG6HwFUdCw2+Kda=Q@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAEkJfYOBnhVGNENZkkdoX1g+gE=eVNFwNRG6HwFUdCw2+Kda=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/05/15 21:46, Sam Sun wrote:
>> What happens if you disable
>>
>>   sysfd = write(sysfd, input, hash - input + 1);
>>
>> line (i.e. stop updating sg_allow_dio value) in the reproducer?
>>
> 
> I tried to change the value of /sys/module/sg/parameters/allow_dio to
> 0 and remove write() call, both still triggers task hang report and
> kernel panic. I think this write is not the call crashing the kernel.
> 

Kernel panic by general protection fault upon calling trigger_all_cpu_backtrace() is
a different bug. Please be sure to keep /proc/sys/kernel/hung_task_all_cpu_backtrace 0
while investigating this hung task problem.

This hung task problem happens without touching /sys/module/sg/parameters/allow_dio ,
doesn't it?

scsi_rescan_device() is reliably printed when this hung task problem happens,
isn't it?

Then, it is strange that scsi_rescan_device() is called despite the reproducer is
almost no-op. Maybe you can trigger scsi_rescan_device() without using the reproducer.

Can you simplify steps to reproduce? For example, doing a lot of write().

