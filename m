Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9427920BB48
	for <linux-block@vger.kernel.org>; Tue, 12 Nov 2024 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400607; cv=none; b=dVQMrjzZnZMJanAsbnFrNdKegS3oucN2F6GDR8V9QJLQdduhMz6kTvtVtdx/lPa+Eqr5LkmK23sNLQu3XTtlXC2BfenCxlFPLSpgb92Zh7Wm8oaZlIAQ6SgFgoXqxepSbLJdl/ujN1luURajU8KBV/JDshXqeEthNoEdYaKni6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400607; c=relaxed/simple;
	bh=QGtwmSfVGCvS2nIVVaTBuXc+xwm9knawD+pGMaaunu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=hLAGp6I6Ycg6GvJFFYTTkn/VzYkcGZRKKnSJmLti+rcR7CrDAaU3fr1iH2KE4o8d/CU+ks2VXlTI5vqYl6wPHxH+QWdVTwqP/nx2o5YBqab/W0ENzHiESwLncMxRpJmPZiz/2GX8l9DcUfD3SEauv+7PMtQSyr/aCFXVk9g86rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=twqrQAk7; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="twqrQAk7"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241112083642euoutp0120c4a3a2840c6d2cd9be29aacf57eba0~HK6zDPWDr0643006430euoutp01P
	for <linux-block@vger.kernel.org>; Tue, 12 Nov 2024 08:36:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241112083642euoutp0120c4a3a2840c6d2cd9be29aacf57eba0~HK6zDPWDr0643006430euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731400602;
	bh=5GjUPcXd2hRirSF3wvITG6e70GJlNPgpj+JrFh31UtY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=twqrQAk7Q64E/fxMEBHP4apOAKqiXdrh9SrwpvF66m2Hm3ZzweRYog12uh76RE2Ku
	 7K1m6vGSPVGT0CDX6CnxKEXlWCXopsdoJVdY5FKt+SOqICmFMRegSEf5X2EhVSrkys
	 8/7AJA7Pq2P3uUDQXpEC5vs/Oig2RzzxIGvSJFw4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241112083642eucas1p1d513ef4a3852001223415e78ada3034d~HK6yvF9oN1300113001eucas1p1t;
	Tue, 12 Nov 2024 08:36:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id FE.C9.20821.A9313376; Tue, 12
	Nov 2024 08:36:42 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241112083641eucas1p225d5ee764acd75806f5067a2c996c915~HK6yPd9kn2753327533eucas1p28;
	Tue, 12 Nov 2024 08:36:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241112083641eusmtrp24098c41cb7d07e74d91b99d996da1063~HK6yO4QLW0348903489eusmtrp2O;
	Tue, 12 Nov 2024 08:36:41 +0000 (GMT)
X-AuditID: cbfec7f2-b11c470000005155-e3-6733139aa08b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 6B.BF.19654.99313376; Tue, 12
	Nov 2024 08:36:41 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241112083640eusmtip1a073bf2c8fec580981d2885f06b6c66d~HK6xRHRRa0037900379eusmtip1O;
	Tue, 12 Nov 2024 08:36:40 +0000 (GMT)
Message-ID: <6551c33f-b9e1-45ab-b420-d022d6e4e402@samsung.com>
Date: Tue, 12 Nov 2024 09:36:40 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] block: model freeze & enter queue as lock for
 supporting lockdep
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Christoph
	Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>, Waiman Long
	<longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar
	<mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ZyEGLdg744U_xBjp@fedora>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djP87qzhI3TDV4tEbZYfbefzWLNlkYm
	i2kffjJbrFx9lMli7y1ti8u75rBZnD52gsXi0ORmJotLBxYwWRzvPcBk0XLH1IHb4/IVb4+d
	s+6ye2xeoeVx+Wypx6ZVnWweu282sHm833eVzePzJrkAjigum5TUnMyy1CJ9uwSujLdXtjEX
	bFOseNo+g6WB8b50FyMnh4SAicTVWxOYuhi5OIQEVjBK/L31Dsr5wigx92wfE0iVkMBnRonF
	9zhgOn48XskMUbScUWJl90eojo+MEpOP9bKDVPEK2Ek8nzERzGYRUJV4cOwsI0RcUOLkzCcs
	ILaogLzE/VszwGqEBeIkPra/YAWxRQSUJO7eXc0OMpRZ4AqTxKaLK8HOYBYQl7j1ZD6YzSZg
	KNH1tosNxOYUUJN4v3ANC0SNvMT2t3PAzpMQ6OaU2N/2gxnibheJH7s/sEPYwhKvjm+BsmUk
	/u+czwTR0M4oseD3fShnAqNEw/NbjBBV1hJ3zv0CWscBtEJTYv0ufYiwo0Tz7O3MIGEJAT6J
	G28FIY7gk5i0bTpUmFeio00IolpNYtbxdXBrD164xDyBUWkWUrjMQvLmLCTvzELYu4CRZRWj
	eGppcW56arFhXmq5XnFibnFpXrpecn7uJkZgCjv97/inHYxzX33UO8TIxMF4iFGCg1lJhFfD
	Xz9diDclsbIqtSg/vqg0J7X4EKM0B4uSOK9qinyqkEB6YklqdmpqQWoRTJaJg1OqgUnz4prl
	Ke/4zj55cUxz6pk+zq0eHAuncb1Yz3XK/Iyx3OHQ6hqLuvZ3l4tXTzi3KDix2DlbQ+78ku+7
	GQJeTn3UYtzzQVq4xbp91/lcQW3uTWavtkp4du0u+LHqX2itURHX87XTbsU3P2OY+yViqeJd
	/XXR254Wln/nD7s/wcubd4KAV2bamyCm8/xMjzdfnxF+5U1zR+/Ey1y2Xm8ny3xQXn/0cgHj
	Ej1Gk0s7c1nOnGJZv4bf4tvHkOY179gZvzI2L31a8/mIypPN6zoXcIblbd63TE2vY53HLe2/
	9p3bDsk46cTbaVU0RKzZM1//p+P+lQfEHq0uybFqiduZb/H37ROxS4wODz+9S91gYB2ixFKc
	kWioxVxUnAgAP9MSxdADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xu7ozhY3TDV736VmsvtvPZrFmSyOT
	xbQPP5ktVq4+ymSx95a2xeVdc9gsTh87wWJxaHIzk8WlAwuYLI73HmCyaLlj6sDtcfmKt8fO
	WXfZPTav0PK4fLbUY9OqTjaP3Tcb2Dze77vK5vF5k1wAR5SeTVF+aUmqQkZ+cYmtUrShhZGe
	oaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJextsr25gLtilWPG2fwdLAeF+6i5GTQ0LA
	ROLH45XMXYxcHEICSxkltt/YxAiRkJE4Oa2BFcIWlvhzrYsNoug9o8StRy/ZQBK8AnYSz2dM
	ZAexWQRUJR4cO8sIEReUODnzCQuILSogL3H/1gywGmGBOImP7S/AhooIKEncvbuaHWQos8AV
	Jokzt5aBFQkJ9DFJfNtbBWIzC4hL3HoynwnEZhMwlOh62wW2mFNATeL9wjUsEDVmEl1buxgh
	bHmJ7W/nME9gFJqF5I5ZSEbNQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIEx
	u+3Yzy07GFe++qh3iJGJg/EQowQHs5IIr4a/froQb0piZVVqUX58UWlOavEhRlNgYExklhJN
	zgcmjbySeEMzA1NDEzNLA1NLM2MlcV62K+fThATSE0tSs1NTC1KLYPqYODilGpjKUk0+LL2S
	dmJrRuG8wPhr5qk75+XVMcu5vW18oPHW0LpaVXeV3xyPd/kKfA+Nc6vjD7dErF6hvpH71Pb7
	CayvO7Sjvz9J3yNSVvprWlWjqOdDoR2ll88K7pIrSvfLWNB4PzYnr8+bh+WvTffX6IuPzxg9
	NnPLvHeDp0opp993h/1Dcal3spfiFIwPPbXZ/anmce6+trxetR+2jtxu9rdZ/dz0mKQflXh1
	qPs0eOhcLAy25Ko5/tfFsif0fmfPDzmWnoDETdWdS36UMnhfd+jWX33d7LCNdNsrA63ei+dU
	J0v8bW8MfTJlxwP9/6+O/tG96vpLzd7qctoGNZHTD3YKrpRlu+g45wCbL/d3JZbijERDLeai
	4kQAzEcDO2IDAAA=
X-CMS-MailID: 20241112083641eucas1p225d5ee764acd75806f5067a2c996c915
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241029111338eucas1p2bd56c697b825eef235604e892569207e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241029111338eucas1p2bd56c697b825eef235604e892569207e
References: <20241025003722.3630252-1-ming.lei@redhat.com>
	<20241025003722.3630252-4-ming.lei@redhat.com>
	<CGME20241029111338eucas1p2bd56c697b825eef235604e892569207e@eucas1p2.samsung.com>
	<ca16370e-d646-4eee-b9cc-87277c89c43c@samsung.com> <ZyEGLdg744U_xBjp@fedora>

On 29.10.2024 16:58, Ming Lei wrote:
> On Tue, Oct 29, 2024 at 12:13:35PM +0100, Marek Szyprowski wrote:
>> On 25.10.2024 02:37, Ming Lei wrote:
>>> Recently we got several deadlock report[1][2][3] caused by
>>> blk_mq_freeze_queue and blk_enter_queue().
>>>
>>> Turns out the two are just like acquiring read/write lock, so model them
>>> as read/write lock for supporting lockdep:
>>>
>>> 1) model q->q_usage_counter as two locks(io and queue lock)
>>>
>>> - queue lock covers sync with blk_enter_queue()
>>>
>>> - io lock covers sync with bio_enter_queue()
>>>
>>> 2) make the lockdep class/key as per-queue:
>>>
>>> - different subsystem has very different lock use pattern, shared lock
>>>    class causes false positive easily
>>>
>>> - freeze_queue degrades to no lock in case that disk state becomes DEAD
>>>     because bio_enter_queue() won't be blocked any more
>>>
>>> - freeze_queue degrades to no lock in case that request queue becomes dying
>>>     because blk_enter_queue() won't be blocked any more
>>>
>>> 3) model blk_mq_freeze_queue() as acquire_exclusive & try_lock
>>> - it is exclusive lock, so dependency with blk_enter_queue() is covered
>>>
>>> - it is trylock because blk_mq_freeze_queue() are allowed to run
>>>     concurrently
>>>
>>> 4) model blk_enter_queue() & bio_enter_queue() as acquire_read()
>>> - nested blk_enter_queue() are allowed
>>>
>>> - dependency with blk_mq_freeze_queue() is covered
>>>
>>> - blk_queue_exit() is often called from other contexts(such as irq), and
>>> it can't be annotated as lock_release(), so simply do it in
>>> blk_enter_queue(), this way still covered cases as many as possible
>>>
>>> With lockdep support, such kind of reports may be reported asap and
>>> needn't wait until the real deadlock is triggered.
>>>
>>> For example, lockdep report can be triggered in the report[3] with this
>>> patch applied.
>>>
>>> [1] occasional block layer hang when setting 'echo noop > /sys/block/sda/queue/scheduler'
>>> https://bugzilla.kernel.org/show_bug.cgi?id=219166
>>>
>>> [2] del_gendisk() vs blk_queue_enter() race condition
>>> https://lore.kernel.org/linux-block/20241003085610.GK11458@google.com/
>>>
>>> [3] queue_freeze & queue_enter deadlock in scsi
>>> https://lore.kernel.org/linux-block/ZxG38G9BuFdBpBHZ@fedora/T/#u
>>>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> This patch landed yesterday in linux-next as commit f1be1788a32e
>> ("block: model freeze & enter queue as lock for supporting lockdep").
>> In my tests I found that it introduces the following 2 lockdep warnings:
>>
>> > ...
>>
>>
>> 2. On QEMU's ARM64 virt machine, observed during system suspend/resume
>> cycle:
>>
>> # time rtcwake -s10 -mmem
>> rtcwake: wakeup from "mem" using /dev/rtc0 at Tue Oct 29 11:54:30 2024
>> PM: suspend entry (s2idle)
>> Filesystems sync: 0.004 seconds
>> Freezing user space processes
>> Freezing user space processes completed (elapsed 0.007 seconds)
>> OOM killer disabled.
>> Freezing remaining freezable tasks
>> Freezing remaining freezable tasks completed (elapsed 0.004 seconds)
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 6.12.0-rc4+ #9291 Not tainted
>> ------------------------------------------------------
>> rtcwake/1299 is trying to acquire lock:
>> ffff80008358a7f8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock+0x1c/0x28
>>
>> but task is already holding lock:
>> ffff000006136d68 (&q->q_usage_counter(io)#5){++++}-{0:0}, at:
>> virtblk_freeze+0x24/0x60
>>
>> which lock already depends on the new lock.
>>
>>
>> the existing dependency chain (in reverse order) is:
> This one looks a real thing, at least the added lockdep code works as
> expected, also the blk_mq_freeze_queue() use in virtio-blk's ->suspend()
> is questionable. I will take a further look.

Did you find a way to fix this one? I still observe such warnings in my 
tests, even though your lockdep fixes are already merged to -next: 
https://lore.kernel.org/all/20241031133723.303835-1-ming.lei@redhat.com/


Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

