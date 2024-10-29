Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1097D78C6D
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187074; cv=none; b=B3T5zMT/sjXAy5VrtHr3YYBNIC+4U633AnJyeB88dD4OK2hiAMr2VB3EVHwNAkCHPzlES4HUD2fKctQoHmheD4KiitAignD7/tE6qfFxk6WMWovV4nJ0jzEv8/gjVfYyLTgTtK4iuZSSr168IBEpncbJ+0k4YK5jGdn9s0d4RU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187074; c=relaxed/simple;
	bh=vrUioXu6GKJXXvZyODon7Prrqzj1oLZCWfqiSBg2u7k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=u5YvoXqEIGAfCDllEkzdY9BGeDg2vhyA5cXNM9T/5JOLaodDx75kjNvL+ST84+t4h82iYX1tN+lC+RNy64w4RKidrBuxpnV39yWTyvpQPJeb6935yu0/if8XKix1hDaXjLasquB30gD/K53BYb8qvB5DmRG5bXlt/ceDP70NQvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nGcL9KWP; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nGcL9KWP"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730187068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1r5Cwk0j+kBuuN9igwPiLvCutACXGjhv0SlYy1tuoCs=;
	b=nGcL9KWPx0AiYX0qjR3K4bhzii9rh5IKn2QfEB1VKs9C0PadJzS1VYDlrow1KUpnQM5Q3+
	xFUO6ZyViipUUp1aYVdcl7ITL4fUyj0vtPV4wl8nKNKbFaxMNsExiz6fLaGDMio/gR/Yfn
	dqz1Ej+CLFXTnumCKTtznjMTCt0OWhw=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] block: refactor rq_qos_wait()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <9c6099ba-8d95-f2f6-fe36-7333f706c0fc@huaweicloud.com>
Date: Tue, 29 Oct 2024 15:30:08 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 mingo@redhat.com,
 peterz@infradead.org,
 chengming.zhou@linux.dev,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 tj@kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>,
 axboe@kernel.dk
Content-Transfer-Encoding: quoted-printable
Message-Id: <C50E9EB1-809B-4F69-86E1-96D307BF077C@linux.dev>
References: <20241024043525.98663-1-songmuchun@bytedance.com>
 <9c6099ba-8d95-f2f6-fe36-7333f706c0fc@huaweicloud.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT



> On Oct 25, 2024, at 15:50, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>=20
> Hi,
>=20
> +CC Tejun
>=20
> =E5=9C=A8 2024/10/24 12:35, Muchun Song =E5=86=99=E9=81=93:
>> When rq_qos_wait() is first introduced, it is easy to understand. But
>> with some bug fixes applied, it is not easy for newcomers to =
understand
>> the whole logic under those fixes. In this patch, rq_qos_wait() is
>> refactored and more comments are added for better understanding. =
There
>> are 4 points for the improvement:
>>     1) Use waitqueue_active() instead of wq_has_sleeper() to =
eliminate
>>        unnecessary memory barrier in wq_has_sleeper() which is =
supposed
>>        to be used in waker side. In this case, we do need the =
barrier.
>>        So use the cheaper one to locklessly test for waiters on the =
queue.
>>     2) There is already a macro DEFINE_WAIT_FUNC() to declare a
>>        wait_queue_entry with a specified waking function. But there =
is not
>>        a counterpart for initializing one wait_queue_entry with a
>>        specified waking function. So introducing init_wait_func() for
>>        this, which also could be used elsewhere (like filemap.c). It =
can
>>        be used in rq_qos_wait() to use default_wake_function() to =
wake up
>>        waiters, which could remove ->task field from =
rq_qos_wait_data.
>=20
> I think it's better to cook point 2 as a seperate patch.
>=20
> Whether or not, this patch LGTM.

Either is OK for me. I can update this in v2.

> Reviewed-by: Yu Kuai <yukuai3@huawei.com>

Thanks for your review.

Thanks,
Muchun=
