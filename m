Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E82C3EAC6D;
	Mon, 27 Jul 2026 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145419; cv=none; b=D/dRUIlvux2JfxFlPkx9BouBLlwL8o2ae38ZrO9/NxhTQD6w2gy4Vd4hJ9YHnlsGr44N8JnXZMr+LSe8sTo4082biQwZmhRe5Zz0kvkWnEBTWEB86S54zZgmgePpJHBnH64b53wDww0DkTtP5iC6eR1HK0kLkfWRQeMVzChC4sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145419; c=relaxed/simple;
	bh=2sw37Q+X0GL9JMimv8d33/SmYfG+9GDwZfrHM3D2rxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DnK6KLFGjtb8bF7zIoMRhsxPVFL6mk0TEwODpoC84Sq7WFuZPpSkQi3y4XP5HvVN6D+246gfB6zzjD3tDM0W27wxU9Jf8GJr/7e8VVCBIApdDQRX4MPY2CvhCcAICkespWPFj6VTH5Zi+c8CLoSHSEG5OEPEF8E/FJhWOWjPd/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a0427e28899f11f1aa26b74ffac11d73-20260727
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:e23e2abc-c4f4-4c11-9daa-cd5c55984fd8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:e5c1714c7d1e9842402734d9955606ef,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a0427e28899f11f1aa26b74ffac11d73-20260727
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1174637161; Mon, 27 Jul 2026 17:43:30 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: bvanassche@acm.org
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: Re: [PATCH v1] block/mq-deadline: hold elevator_lock in debugfs next_rq show
Date: Mon, 27 Jul 2026 17:45:00 +0800
Message-ID: <reply-mq-deadline-next-rq-af98cabf.20260727.174500.liuxixin@kylinos.cn>
In-Reply-To: <af98cabf-89a6-41b0-9929-ec3e24783503@acm.org>
References: <2e689b2c4021.1784615432.git.liuxixin@kylinos.cn> <af98cabf-89a6-41b0-9929-ec3e24783503@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py

On Fri, 24 Jul 2026, Bart Van Assche wrote:
> The following is missing from your patch:
> - An explanation why q->elevator_lock is locked instead of dd->lock. I
>    think that you are misunderstanding the purpose of these locks.

Agreed on the distinction.  dd->lock protects mq-deadline's internal
lists/trees; elevator_lock serializes q->elevator against switch/teardown.

The crash we hit is the latter: concurrent elevator switch clears
q->elevator under elevator_lock, so next_rq_show can deref a NULL
elevator before any dd->lock is reachable.  For this LIFE bug,
elevator_lock is what can close the race; dd->lock cannot.

Fifo and the other remaining debugfs attrs have the same LIFE gap on
elevator switch: stock may take dd->lock for list walks, but still
loads q->elevator unlocked first.  I will cover those in a separate
follow-up.

> - An explanation why locking q->elevator_lock from inside a debugfs
>    attribute neither triggers lock inversion nor a deadlock.

This next_rq show path takes only elevator_lock, briefly, and does not
nest it with dd->lock.  Elevator switch takes the same mutex, so the
reader serializes with teardown rather than deadlocking; there is no
new elevator_lock <-> dd->lock nesting or inversion on this path.

> - An explanation why the dd and per_prio assignments happen with the
>    lock held. This seems unnecessary to me because neither
>     e->elevator_data nor the address of dd->per_prio[] are modified while
>    the mq-deadline debugfs attributes exist. Did I perhaps overlook
>    something?

On the width of the critical section we agree in part: holding the lock
through the tree walk and seq show is wider than needed.  Loading only
e and dd under elevator_lock, then unlocking, is enough; per_prio,
deadline_from_pos, and the seq show can run after unlock.  v2 does:

	ret = mutex_lock_interruptible(&q->elevator_lock);
	...
	e = q->elevator;
	if (!e) {
		mutex_unlock(&q->elevator_lock);
		return 0;
	}
	dd = e->elevator_data;
	mutex_unlock(&q->elevator_lock);
	per_prio = &dd->per_prio[prio];
	rq = deadline_from_pos(...);

Thanks,
Xixin

