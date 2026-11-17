Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903022;
	b=jYMzvL4Idz8y2jC1VtBesbr+OhHNXpd8vgAB6dKvT/HaYDbslJnbVih7QOwamkEpVepQ
	 ouupODt/7NKjeWJce73PUyJulNHtZ3Yb+6RFpV5lmttrp30SzNgHPVGP9mw0KFxHbzm0s
	 Rr+bi6UALVH+GF8zU/pwmO/RZZlXQki3pYw9ZOYJo5DeEneyoeKL5w3GxfGhrrxfllMWr
	 8ftkpjFEsHdcd3DosFrO4aF+htyl1uYZRPOVYXHxV7f5TOykekBXxd9Uc7tME9hIEig/q
	 Vfwc4aWKlW16MkVY2Mw1WjHGmbjjE0PFi7CUaxjNM3UTAKwXpmmIepsE2frnCaFhBnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903022;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LmGROQ8j6ssfXVbTrRZUW1rS5G1Xj+GI9rns6J0VgQk=;
	b=pLIp6BlXMvJYFsx9A1FRGEWTxryN95zbTpa8JwrV9IRCW44OAtRPYYSgUAf5IC2n9XJj
	 w/nTewimqQapULIdX5hJbCb5qCLieQtmkpDDjO8Un3IKGRXmRk+VpuopJQ2v1zP23yxH/
	 e+t1804OLwqfdMNDdyNnLwF6nkPqjb4gCUaeWtmobF38HoXc8Ptfc4fW9BU0marfVvr4d
	 VgYp7JwQ/RCl/HHxL38sG6jJ9X4rpx0fE0JFJewMfFwWNDdYfCdxdT0XAbb/jxFUrVV0M
	 AMG/gsVffSUr+cbEw8JgERk2h6hotlHrZd+BYHexbXZm5o1AXCF/z9oENsq2YrmYlVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=T8C2zjZX;
	arc=none smtp.remote-ip=91.218.175.74
Received: from mta0.migadu.com (out-74.mta0.migadu.com [91.218.175.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673CE606A31C
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 08:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 673CE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=T8C2zjZX
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cn6tymwrhooG82BjdGKkfjlm33e7584SzGicUSgvQKM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794903019; v=1; x=1795507819;
 b=T8C2zjZX6lY7Kta2Llo6OcdUZ4LqOjd09HISFHVvV454h87DzX8MbPJaEkClE9lEopW31d2u
 y3HbbIsjespdAcQNJ0GFTjrPboRP1myBSU73x46TtmY67hUbAZbQjGCvrkEkIm6w1Oowf8GjQOQ
 8bQ+phUxk90CiXSqGCwcbEGI=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d49511be82a76482;
	Tue, 17 Nov 2026 08:10:18 +0000
X-Mizu-Trace-ID: d49511be82a76482
X-Migadu-Flow: FLOW_OUT
Message-ID: <64588236-7ab4-4d63-8ab5-8a1658eb15b0@linux.dev>
Date: Tue, 17 Nov 2026 16:10:06 +0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, josef@toxicopanda.com, axboe@kernel.dk,
 alexei.starovoitov@gmail.com, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, linux-kselftest@vger.kernel.org, cuitao@kylinos.cn,
 ameryhung@gmail.com
Subject: Re: [RFC PATCH v13 1/4] blk-iocost: add BPF struct_ops cost model
 support
To: Tejun Heo <tj@kernel.org>
References: <20261106122356.3224638-1-cui.tao@linux.dev>
 <20261106122356.3224638-2-cui.tao@linux.dev>
 <e6062944917f1c9a87ab084bae9352a9@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <e6062944917f1c9a87ab084bae9352a9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Tejun.

在 2026/11/17 01:27, Tejun Heo 写道:
> Hello, Tao.
> 
> On Fri, Nov 06, 2026 at 08:23:53PM +0800, Tao Cui wrote:
>> Attaching an iocost_model_ops struct_ops binds the model to one
>> device: the target is set in the dev member from userspace and
>> .reg creates the ioc if needed like an io.cost.model write and
>> ...
> 
> From here on, the description mostly walks through what the code does.
> Can it instead explain why it works this way and what it guarantees, and
> leave the mechanics to the code?
> 
Rewritten. The commit message now describes what the attachment
guarantees: one attached model per device, pricing follows the
model across io.cost.model writes, attaching doesn't enable the
controller, and the model can't go away while it's pricing. The
freeze ordering and the detach mechanics are left to the code.

>> +enum {
>> +	IOCOST_COST_F_MERGE	= 1 << 0,	/* called from the merge path */
>> +};
> 
> Maybe name the flags after the callback they're passed to, e.g. enum
> iocost_calc_flags, IOCOST_CALC_MERGE and a calc_flags parameter, the way
> sched_ext pairs ops.enqueue()'s enq_flags with enum scx_enq_flags and
> SCX_ENQ_*? An unnamed enum type can't be looked up by name through BTF,
> so BPF programs can't test whether a flag exists.
> 
Renamed. The enum is now iocost_calc_flags with
IOCOST_CALC_MERGE and the calc_cost parameter is calc_flags.
The named enum is used for the kernel-side definition; the BPF
callback argument remains u64, matching the existing struct_ops
interface style.

> Also, can the comment say what the flag means to the model rather than
> where the call comes from? The bio is being merged into an IO which was
> already charged its base cost.
> 
Updated accordingly.
>> +	/* holds a reference on the struct_ops map, NULL if none is attached */
>> +	const struct iocost_model_ops	*attached;
>> +	struct bpf_link			*attached_link;
>> +	/* either NULL (linear) or ->attached */
>> +	const struct iocost_model_ops __rcu *model;
> 
> Can the comment say why iocost holds its own reference on the map? If the
> link is destroyed after del_gendisk() has unhashed the bdev but before
> rq_qos_exit(), .unreg can't look up the disk and returns without
> detaching, and the link drops its reference. iocost's reference keeps the
> map alive until ioc_rqos_exit() detaches the model.
> 
The field comment now says exactly this.

> Also, why are attached and attached_link updated under ioc->lock in
> ioc_bpf_reg() and ioc_detach_model()? Everything which reads the two
> holds rq_qos_mutex: .reg, .unreg, ioc_detach_model() and
> ioc_cost_model_write(), which gets it from blkg_conf_open_bdev(). Only
> model is read under ioc->lock alone, by ioc_autop_idx() from the timer
> and the io.cost.model show path, besides the RCU readers. What is
> ioc->lock protecting for the two? Can you document the locking on the
> fields?
> 
attached and attached_link themselves are protected by
rq_qos_mutex. The ioc->lock coverage is only needed for bpf_model,
which is read under ioc->lock by the timer and io.cost.model show
paths. The field comments now document the locking rules.

>> +static const struct iocost_model_ops *ioc_model(struct ioc *ioc)
>> +{
>> +	if (!IS_ENABLED(CONFIG_BLK_CGROUP_IOCOST_BPF))
>> +		return NULL;
>> +	return rcu_dereference_check(ioc->model, lockdep_is_held(&ioc->lock));
>> +}
> 
> ioc_model() returns NULL while the builtin linear model is in use, which
> is a model too. Maybe rename the accessor and the field together, e.g.
> ioc_bpf_model() and bpf_model, or ioc_model_bpf() and model_bpf?
> 
Renamed to ioc_bpf_model() and bpf_model.

>> +	spin_lock_irq(&ioc->lock);
>> +	rcu_assign_pointer(ioc->model, NULL);
>> ...
>> +	ioc->autop_too_fast_at = 0;
>> +	ioc->autop_too_slow_at = 0;
> 
> Resetting to 0 is right, but maybe ioc_bpf_reg() is a better place for
> it? .reg is the only path which switches pricing to the BPF model without
> a forced ioc_refresh_params(), which is what zeroes the timestamps for
> io.cost.qos and io.cost.model writes. If ioc_bpf_reg() zeroes them, they
> stay zero while the BPF model is in use, which covers both detach and the
> "model=linear" switch sashiko reported on this posting.
> 
Moved. ioc_bpf_reg() zeroes the timestamps inside the ioc->lock
section together with the settle, and the zero in ioc_detach_model()
is dropped; as you say, they stay zero for the whole BPF period,
which covers both the detach and the model=linear switch.

Besides your comments, p1 also picked up two fixes from testing:
calc_cost() now matches the builtin pricing scope, and a dead owning
map now reports -ENODEV instead of -EBUSY.

Thanks,
Tao

> Thanks.
> 
> --
> tejun

