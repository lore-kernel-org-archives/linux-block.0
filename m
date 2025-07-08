Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787A5189905
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 02:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751941173; cv=none; b=Id06mYZ/F+ECbgL0A201dYlH32E5ACfiaIV/wXL4irELhTkrip/g+oYVtarxBT8R9z6NFQRg8PywMShznc8Fag0vcYrmetqA7nw+9tu17yQBXpurmwHxgGwX85/BU6928vRgIhbS+FiTmiVJrtdbA5zdvrP1WaPigFzH87D3zfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751941173; c=relaxed/simple;
	bh=ekax5Fkx9rdon1V8yh03rP61qKT/NyxAxE1FJbTtIbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0HytG0yyh0SD12GIkyMQ6rVJt7rdaKFUuTiRhVofXw3laLfcZmlL/XlvKriXchblZc8+B6LD1lb8rTdYDsouEW8EE6zTVfziEK4ZXU8hoUW8OkIlFi0Z3Zf11p2WSnLAwHCDRhDiUvryai98mXuZRdoXotrY57QPkvo7OJYA7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5682JS3a080667;
	Tue, 8 Jul 2025 11:19:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5682JSpQ080661
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 8 Jul 2025 11:19:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <aebcb155-d161-46a1-b120-f247a3eaf5a2@I-love.SAKURA.ne.jp>
Date: Tue, 8 Jul 2025 11:19:28 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [nbd?] possible deadlock in nbd_queue_rq
To: Hillf Danton <hdanton@sina.com>
Cc: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        josef@toxicpanda.com, linux-block@vger.kernel.org,
        syzbot <syzbot+3dbc6142c85cc77eaf04@syzkaller.appspotmail.com>,
        Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        nbd@other.debian.org, syzkaller-bugs@googlegroups.com
References: <20250707005946.2669-1-hdanton@sina.com>
 <20250708001848.2775-1-hdanton@sina.com>
 <20250708012450.2858-1-hdanton@sina.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250708012450.2858-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav105.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/07/08 10:24, Hillf Danton wrote:
> On Tue, 8 Jul 2025 09:52:18 +0900 Tetsuo Handa wrote:
>> On 2025/07/08 9:18, Hillf Danton wrote:
>>> On Mon, 7 Jul 2025 10:39:44 -0700 Bart Van Assche wrote:
>>>> On 7/6/25 5:59 PM, Hillf Danton wrote:
>>>>> and given the second one, the report is false positive.
>>>>
>>>> Whether or not this report is a false positive, the root cause should be
>>>> fixed because lockdep disables itself after the first circular locking
>>>> complaint. From print_usage_bug() in kernel/locking/lockdep.c:
>>>>
>>>> 	if (!debug_locks_off() || debug_locks_silent)
>>>> 		return;
>>>>
>>> The root cause could be walked around for example by trying not to init
>>> nbd more than once.
>>
>> How did you come to think so?
>>
> Based on that nbd_init appears twice in the lock chain syzbot reported.
> 

You might be misunderstanding what the lock chain is reporting.

The stack backtrace of a lock is taken only when that lock is taken
for the first time. That is, two stack backtraces from two locks might
share one or more functions. Also, the stack backtrace of a lock which
is printed when lockdep fired might not be a backtrace of that lock
when actual deadlock happens.

You need to understand all possible locking patterns (because lockdep
can associate only one backtrace with one lock) before you conclude
that the report is a false positive.

>> nbd_init() is already called only once because of module_init(nbd_init).
>>
> Ok Bart is misguiding.

