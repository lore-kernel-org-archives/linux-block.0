Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815078632C;
	Thu, 26 Jun 2025 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750953782; cv=none; b=gaIL2Ckdz8CkcrAN8s+ujPmqou6YGPj3gx4DqJV9n6CxxNr5oDp+sGnqgqvGKY/QI9gjSxtw0BDjHLibonXmeqkoeuB2tV8SMXysnbrhmQqxpCxdJoXmnU5blgPL8mNJYssxeKE2ItWGV9X97NdqcecTqf7B8bBOWYRFJgRSNnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750953782; c=relaxed/simple;
	bh=fkGxV0HQgUHeJiQTfRjSQzlpYpFfxY0bwgPvRDYow7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZsPzjRyZ/fXBwA5H+n/bXwl8waSZ7x6iUp2dUVwHu6L2PS7mBAmeaAGGWQQVJHFX2HOFz2Vu8PIsvtj+iFy01pKCTlp4c/MwGa/L8MgqZvRu6MnGvT2yE65+dBicII5GxgBX6GgWtXD0d1SnoSce74+vniEK37Q8l9s+V6v+xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Ed6z/WBD; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Ed6z/WBD"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bSk433ZkRzlvbn9;
	Thu, 26 Jun 2025 16:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1750953778; x=1753545779; bh=mWotOeTIYSin/+S9kemNAwkH
	pt9kwJx54UQRiU9Daog=; b=Ed6z/WBDAqr1Lk/YhLm6xirKr7qzKYtmutsw2DXF
	b9OnweiNBLmN9jkyoH1o/JMVCpOQGcroHn6k0mWHAgXyPjI6XX3aIi4DWU809/XE
	L6MJ5/7WIBfCpM/uEbwf1nMN1oNZRJNYAiEW6pfY0pgSwwglgIUVij1NIyn5u4b6
	nRqEoZpqGgTlW4RS1GHuOeR6fCyCkFGr37g4gtSYPe1lK2rtsNeEnneDose50+ob
	b/rsA6yeMnnTCHdJbg/NPIN1ll3EW+ehlVJOw98OO79HadiRM+S1JHMSRWfq6cmO
	FJh35E1X1YTNB0SdPOhlOhwnmVkYqzA5AIRckud2qbOcVw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id xL4D-LjWMyAm; Thu, 26 Jun 2025 16:02:58 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bSk3y4j2Zzlvbn8;
	Thu, 26 Jun 2025 16:02:53 +0000 (UTC)
Message-ID: <ca4c60c9-c5df-4a82-8045-54ed9c0ba9be@acm.org>
Date: Thu, 26 Jun 2025 09:02:52 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix a deadlock related to modifying the readahead
 attribute
To: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 stable@vger.kernel.org
References: <20250625195450.1172740-1-bvanassche@acm.org>
 <1816437d-240a-4834-bef9-c9c4a66bee0a@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1816437d-240a-4834-bef9-c9c4a66bee0a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/25 10:31 PM, Nilay Shroff wrote:
> It seems that some other thread on your system acquired
> ->freeze_lock and never released it and that prevents
> the udev-worker thread to forward progress.

That's wrong. blk_mq_freeze_queue_wait() is waiting for q_usage_counter
to drop to zero as the below output shows:

(gdb) list *(blk_mq_freeze_queue_wait+0xf2)
0xffffffff823ab0b2 is in blk_mq_freeze_queue_wait (block/blk-mq.c:190).
185     }
186     EXPORT_SYMBOL_GPL(blk_freeze_queue_start);
187
188     void blk_mq_freeze_queue_wait(struct request_queue *q)
189     {
190             wait_event(q->mq_freeze_wq, 
percpu_ref_is_zero(&q->q_usage_counter));
191     }
192     EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait);
193
194     int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,

> If you haven't enabled lockdep on your system then can you
> please configure lockdep and rerun the srp/002 test?

Lockdep was enabled during the test and didn't complain.

This is my analysis of the deadlock:

* Multiple requests are pending:
# (cd /sys/kernel/debug/block && grep -aH . */*/*/*list) | head
dm-2/hctx0/cpu0/default_rq_list:0000000035c26c20 {.op=READ, 
.cmd_flags=SYNC|IDLE, .rq_flags=IO_STAT, .state=idle, .tag=137, 
.internal_tag=-1}
dm-2/hctx0/cpu0/default_rq_list:000000005060461e {.op=READ, 
.cmd_flags=SYNC|IDLE, .rq_flags=IO_STAT, .state=idle, .tag=136, 
.internal_tag=-1}
dm-2/hctx0/cpu0/default_rq_list:000000007cd295ec {.op=READ, 
.cmd_flags=SYNC|IDLE, .rq_flags=IO_STAT, .state=idle, .tag=135, 
.internal_tag=-1}
dm-2/hctx0/cpu0/default_rq_list:00000000a4a8006b {.op=READ, 
.cmd_flags=SYNC|IDLE, .rq_flags=IO_STAT, .state=idle, .tag=134, 
.internal_tag=-1}
dm-2/hctx0/cpu0/default_rq_list:000000001f93036f {.op=READ, 
.cmd_flags=SYNC|IDLE, .rq_flags=IO_STAT, .state=idle, .tag=140, 
.internal_tag=-1}
dm-2/hctx0/cpu0/default_rq_list:00000000333baffb {.op=READ, 
.cmd_flags=SYNC|IDLE, .rq_flags=IO_STAT, .state=idle, .tag=173, 
.internal_tag=-1}
dm-2/hctx0/cpu0/default_rq_list:000000002c050850 {.op=READ, 
.cmd_flags=SYNC|IDLE, .rq_flags=IO_STAT, .state=idle, .tag=141, 
.internal_tag=-1}
dm-2/hctx0/cpu0/default_rq_list:000000000668dd8b {.op=WRITE, 
.cmd_flags=SYNC|META|PRIO, .rq_flags=IO_STAT, .state=idle, .tag=133, 
.internal_tag=-1}
dm-2/hctx0/cpu0/default_rq_list:0000000079b67c9f {.op=READ, 
.cmd_flags=SYNC|IDLE, .rq_flags=IO_STAT, .state=idle, .tag=207, 
.internal_tag=-1}
dm-2/hctx0/cpu107/default_rq_list:0000000036254afb {.op=READ, 
.cmd_flags=SYNC|IDLE, .rq_flags=IO_STAT, .state=idle, .tag=1384, 
.internal_tag=-1}

* queue_if_no_path is enabled for the multipath device dm-2:
# ls -l /dev/mapper/mpatha
lrwxrwxrwx 1 root root 7 Jun 26 08:50 /dev/mapper/mpatha -> ../dm-2
# dmsetup table mpatha
0 65536 multipath 1 queue_if_no_path 1 alua 1 1 service-time 0 1 2 8:32 1 1

* The block device 8:32 is being deleted:
# grep '^8:32$' /sys/class/block/*/dev | wc -l
0

* blk_mq_freeze_queue_nomemsave() waits for the pending requests to
   finish. Because the only path in the multipath is being deleted
   and because queue_if_no_path is enabled,
   blk_mq_freeze_queue_nomemsave() hangs.

Bart.

