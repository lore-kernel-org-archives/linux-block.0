Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098384965F;
	Wed,  5 Jun 2024 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717584884; cv=none; b=WK2WHdZfEH71tJQg4ClZnz1MpQqOte6V6Xbv5YEa013n1sNNQ3+hzTk9Tna8HGMpKOOPRHbySfHakVcTe49bdeYqFF+hTQpd5nJnDumhe5lKRKk02Qz98+LW7iyV8QiKuLL2Jh8dqploEp4a7uXydZtekO3Cuu3thkhWY02M/Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717584884; c=relaxed/simple;
	bh=bau7Nw4lZjOvZ5Zq7H83So2KGZJ6w7rIU5ZNiMh/AX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvAiqV1YgMY1JPODmFoakue0jdU/j6U37XSHW8dnUkrksNxQV6OSQz3pe6xXXoyhffPPd6xMpF0AT4VIbvBwHAqjv+OliNUZHay7OgyPmrjv1P/iWzfAjrXLiV6IaFnAHG3FVpKBP3opnZi/p8SSuo6rDzf9thfYU+/IGyoszso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 624F544E91;
	Wed,  5 Jun 2024 12:54:38 +0200 (CEST)
Message-ID: <ec27da86-b84a-430b-98aa-9971f90c8c87@proxmox.com>
Date: Wed, 5 Jun 2024 12:54:36 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix request.queuelist usage in flush
To: Chengming Zhou <chengming.zhou@linux.dev>, axboe@kernel.dk,
 ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20240604064745.808610-1-chengming.zhou@linux.dev>
 <c9d03ff7-27c5-4ebd-b3f6-5a90d96f35ba@proxmox.com>
 <1344640f-b22d-4791-aed4-68fc62fb6e36@linux.dev>
Content-Language: en-US
From: Friedrich Weber <f.weber@proxmox.com>
In-Reply-To: <1344640f-b22d-4791-aed4-68fc62fb6e36@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/06/2024 12:30, Chengming Zhou wrote:
> On 2024/6/5 16:45, Friedrich Weber wrote:
>> Hi,
>>
>> On 04/06/2024 08:47, Chengming Zhou wrote:
>>> Friedrich Weber reported a kernel crash problem and bisected to commit
>>> 81ada09cc25e ("blk-flush: reuse rq queuelist in flush state machine").
>>>
>>> The root cause is that we use "list_move_tail(&rq->queuelist, pending)"
>>> in the PREFLUSH/POSTFLUSH sequences. But rq->queuelist.next == xxx since
>>> it's popped out from plug->cached_rq in __blk_mq_alloc_requests_batch().
>>> We don't initialize its queuelist just for this first request, although
>>> the queuelist of all later popped requests will be initialized.
>>>
>>> Fix it by changing to use "list_add_tail(&rq->queuelist, pending)" so
>>> rq->queuelist doesn't need to be initialized. It should be ok since rq
>>> can't be on any list when PREFLUSH or POSTFLUSH, has no move actually.
>>>
>>> Please note the commit 81ada09cc25e ("blk-flush: reuse rq queuelist in
>>> flush state machine") also has another requirement that no drivers would
>>> touch rq->queuelist after blk_mq_end_request() since we will reuse it to
>>> add rq to the post-flush pending list in POSTFLUSH. If this is not true,
>>> we will have to revert that commit IMHO.
>>
>> Unfortunately, with this patch applied to kernel 6.9 I get a different
>> crash [2] on a Debian 12 (virtual) machine with root on LVM on boot (no
>> software RAID involved). See [1] for lsblk and findmnt output. addr2line
>> says:
> 
> Sorry, which commit is your kernel? Is mainline tag v6.9 or at some commit?

Yes, by "kernel 6.9" I meant mainline tag v6.9, so commit a38297e3fb01.

If I boot this mainline kernel v6.9 in a Debian (virtual) machine with
root on LVM, I do not get a crash. If I apply the patch "block: fix
request.queuelist usage in flush" on top of this mainline kernel v6.9,
and boot the Debian machine into that patched kernel, I get a crash on boot.

> And is it reproducible using the mainline kernel v6.10-rc2?

I'll test mainline kernel v6.10-rc2, and "block: fix request.queuelist
usage in flush" applied on top of v6.10-rc2, and get back to you.

>> # addr2line -f -e /usr/lib/debug/vmlinux-6.9.0-patch0604-nodebuglist+
>> blk_mq_request_bypass_insert+0x20
> 
> I think here should use blk_mq_insert_request+0x120, instead of the
> blk_mq_request_bypass_insert+0x20, which has "?" at the beginning.
> 

Right, sorry:

# addr2line -f -e /usr/lib/debug/vmlinux-6.9.0-patch0604-nodebuglist+
blk_mq_insert_request+0x120
blk_mq_insert_request
[...]/linux/block/blk-mq.c:2539

which refers to this line [1]:

		blk_mq_request_bypass_insert(rq, BLK_MQ_INSERT_AT_HEAD);

Thanks!

Friedrich

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/block/blk-mq.c?h=v6.9#n2539

