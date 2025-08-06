Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EACFAD2C;
	Wed,  6 Aug 2025 00:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754441917; cv=none; b=mIS9LvX9UZ+x7yCexuXQbWwb9cqjx9/DAGSB3wFKlAsey0xp2CVxk7PvUeev1kzp9UDEOI66poxlz/TfHtP6m5ELCvYayz8Zx6xbOVYxh01pErNaQvYaDHJiLdMbNVVvvnNyp6JqKFvP3sqxUwHMNUPm7dSfdQF8dFeEwAnxfyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754441917; c=relaxed/simple;
	bh=YV3P0WrF2xxL6MMhSPAdxp5AVr3TClpAXVq0Kl3GCJo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eSJ7MYP/xwLXiJxdpMPJlOVqOOGs0awWdt38fc9XOT7yC9s1SKtJV8Fqe42nEWQw9RH9suHk5jzxRBcK76ADU1OCx2PMe8hUlpJq49rhXZ3kPIzKkW4YnFrLsusyYqzHKp2jooW0YqeUiAafkWZgKNvjWyP0wBiBddCIV4cBFu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bxX3Q4ZJpzYQv79;
	Wed,  6 Aug 2025 08:58:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 490C81A0A27;
	Wed,  6 Aug 2025 08:58:25 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgA3sxOtqJJoRnLcCg--.39504S3;
	Wed, 06 Aug 2025 08:58:23 +0800 (CST)
Subject: Re: [PATCH] block: prevent deadlock in del_gendisk()
To: Hillf Danton <hdanton@sina.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Ujwal Kundur <ujwal.kundur@gmail.com>, axboe@kernel.dk,
 ming.lei@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250803134114.2707-1-ujwal.kundur@gmail.com>
 <20250805120001.3990-1-hdanton@sina.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8f1183d0-dfee-9448-446e-2a8846987319@huaweicloud.com>
Date: Wed, 6 Aug 2025 08:58:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250805120001.3990-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3sxOtqJJoRnLcCg--.39504S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GFy8Zw18KF4kCrWfXw4xWFg_yoW3urXE9a
	4xCay8Jr15tw4SkF4YqF93Grn2kF1rAF48WF4rAFZ5uwnxZas8Jan8CrWruwsagF48J34v
	yr13C342gr4agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
	r21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/



在 2025/08/05 19:59, Hillf Danton 写道:
> On Mon, 4 Aug 2025 15:51:48 +0800 Yu Kuai wrote:
>> �� 2025/08/03 21:41, Ujwal Kundur д��:
>>> A potential unsafe locking scenario presents itself when
>>> mutex_lock(&disk->open_mutex) is called with reader's lock held on
>>> update_nr_hwq_lock:
>>>          CPU0                    CPU1
>>>          ----                    ----
>>> rlock(&set->update_nr_hwq_lock)
>>>                                  lock(&nbd->config_lock);
>>>                                  lock(&set->update_nr_hwq_lock);
>>> lock(&disk->open_mutex)
>>>
>> This problem is already fixed inside nbd by:
>> 8b428f42f3ed ("nbd: fix lockdep deadlock warning")
>>
> Deadlock still exists [1].
> 
This deadlock is a different problem, not what you claimed to fix in
this patch.

Thanks,
Kuai

> [1] https://lore.kernel.org/lkml/6891742c.050a0220.7f033.001a.GAE@google.com/
> .
> 

