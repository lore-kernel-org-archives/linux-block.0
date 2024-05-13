Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E65150279;
	Mon, 13 May 2024 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609831; cv=none; b=XjsoKOW2MCdFcnZ9kbbV7QvCwttbtjJfJvG3IAzfSj5SegyW2T7pp8MXUMaavXjWud3ftdzjuI3Kf8UDQqxd71NeE7TWAsEyH5qBz4BwcGlmvKOPc3aNJWv+9eLzPkzbJTNon0fFPPxcMQp8sOYik2jLb7+iPgDzqhEX3kS1Gtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609831; c=relaxed/simple;
	bh=+xZ1jpd8Vt6gv+X41/U6O1svfO87wx3Vsxdbq/W3bAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuPYXwzpLyqRQazWaXbwP1QGpIWD8cdL8hEvqosir2tHIzmlVa2P2IR53rLPusrKsjwRS2hETrZTiHRZBdDjgjJXi8VhuImcNkMDmTL9v8s9r5cvupyy/Tbk086RbQWrRZAgfRqBwktCXYjMOspMAwN2oaiTETOlJ6MaBz8PFzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 44DEGnrX070226;
	Mon, 13 May 2024 23:16:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Mon, 13 May 2024 23:16:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 44DEGnv1070221
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 13 May 2024 23:16:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a15774ef-1c18-4604-af10-44d458e3207a@I-love.SAKURA.ne.jp>
Date: Mon, 13 May 2024 23:16:46 +0900
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
References: <CAEkJfYPO8OK=JCFphuZvqzqCWpUjPiTVoHma3CY0gLo+rdLKNw@mail.gmail.com>
 <20240513105413.2951-1-hdanton@sina.com>
 <CAEkJfYPxWBfEnuKeCGEsscVTYy8MrNxCJwdbxS=c2-B0H+HfTA@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAEkJfYPxWBfEnuKeCGEsscVTYy8MrNxCJwdbxS=c2-B0H+HfTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/05/13 21:57, Sam Sun wrote:
> On Mon, May 13, 2024 at 6:54 PM Hillf Danton <hdanton@sina.com> wrote:
>>
>> On Mon, 13 May 2024 10:38:34 +0800 Sam Sun <samsun1006219@gmail.com>
>>> Dear developers and maintainers,
>>>
>>> We encountered a task hung in function blk_mq_get_tag. It was tested
>>> against the latest upstream kernel which was compiled by clang 14.

Did you confirm that the task hung messages continue forever
even after you terminated the reproducer when the task hung
message started?

If the task hung messages stop after you terminated the reproducer,
it is possible that this is just a problem of over-stressing.

If the task hung messages continue forever even after you terminated
the reproducer, collecting stacktraces of all lock holders using
https://lkml.kernel.org/r/77e32fdc-3f63-e124-588e-7d60dd66fc9a@I-love.SAKURA.ne.jp
might be helpful.

Please be sure to run

  # echo 0 > /proc/sys/kernel/hung_task_panic
  # echo -1 > /proc/sys/kernel/hung_task_warnings

before starting the reproducer, for by default hung_task_warnings
prints only up to 10 times (i.e. has a risk of misjudging that the
problem disappeared).

