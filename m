Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957F232E696
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 02:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787277987; cv=none; b=RYkbwEowWdJIEZmXVra38GP2OObs9Al+OCULcnm+gvb8aFHej0JJmf6sIVraT7aojfQt42GowtaSIeA5zoOZNxAJ8nN8OQ7nW3EGOT0ckd8r6jyL25xGsv2fq5rNu7/oqwv/dhbpfc6M3jZmJkTFN8XitjwRmHzlDytfQb0+RXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787277987; c=relaxed/simple;
	bh=tLbRp7EvT1DHtKaW1uXLPNKn/kgt2hFVWXp82nhmjQU=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VsAW1mfAzjSGlp1GwljotytFfWknzeMXZzBEHROPGWidgcoGVVvAZNWzZB1wucpD7QWx/GOgEZcuH/YiR8ohIWveEAbSRs/SabBubcCc1ZqPf/8Y3Vt3P8fSgeuTTKGo6umFFi0KBxQU0qU9A36QJGAxp2I30nDGebOVM99xFsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hR3Yz6gL1zYQtxM
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 10:05:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A28A840593
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 10:06:19 +0800 (CST)
Received: from [10.174.178.185] (unknown [10.174.178.185])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgA3J0aZsodqAEhQDA--.64359S3;
	Fri, 21 Aug 2026 10:06:19 +0800 (CST)
Subject: Re: [PATCH 1/2] block/mq-deadline: disable I/O priority when
 prio_aging_expire is zero
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
 linux-block@vger.kernel.org
References: <20260820021246.2681624-1-yebin@huaweicloud.com>
 <20260820021246.2681624-2-yebin@huaweicloud.com>
 <7b469479-e9c5-444e-919f-c18c17893bb7@acm.org>
Cc: ming.lei@redhat.com
From: yebin <yebin@huaweicloud.com>
Message-ID: <6A87B299.2040207@huaweicloud.com>
Date: Fri, 21 Aug 2026 10:06:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7b469479-e9c5-444e-919f-c18c17893bb7@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgA3J0aZsodqAEhQDA--.64359S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW3Kr43ArWktF1rKF4UJwb_yoW8CryxpF
	4rWa4agr4kGF1xt397t3Z7XryFq3srJrWUWrn8GrWUC3WYqFs2vryxArs8KFy7Cw4vk3ya
	yws5Zryrurn8XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/



On 2026/8/20 23:31, Bart Van Assche wrote:
> On 8/19/26 7:12 PM, Ye Bin wrote:
>> Since the mq-deadline scheduler introduced support for I/O priorities,
>> if a process does not have an I/O priority configured, it becomes bound
>> to the process's scheduling priority.
>
> How can this happen? The scheduling priority (sched_setparam()) and I/O
> priority (ioprio_set()) are independent as far as I know.
>
Yes, I thought so at first. However, after checking the historical records,
I found that the IO priority was set based on the task scheduling class when
the IO priority was not configured. This was introduced by the f7eda402878b
("block: Return effective IO priority from get_current_ioprio()") and
a78418e6a04c ("block: Always initialize bio IO priority on submit") commits.
>> Setting prio_aging_expire to zero does not actually turn off I/O
>> priority in mq-deadline.
>
> prio_aging_expire should not be set to zero. Feel free to submit a patch
> that disallows setting prio_aging_expire to zero.
>
Yes, setting it to 0 can cause priority inversion issues. However, I understand
that even when a relatively small value is set, priority inversion can still
occur. This is because the system first checks whether the lower-priority IO
has timed out, and if it has, it then dispatches the lower-priority IO. In
cases of high IO pressure, this can actually result in the lower-priority IO
being dispatched first. So, is it sufficient to constrain this value to zero?
Or is this value entirely up to the user to control? From the user's perspective,
a naive view would be that setting this value close to zero means not distinguishing
priorities. Indeed, our product was designed with this idea in mind, setting the
value to 0 to disable priority, but it ended up causing IO priority inversion issues.
> Thanks,
>
> Bart.
>

