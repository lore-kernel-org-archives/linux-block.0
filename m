Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007865;
	b=kYgG6Mj3JC7HGojGwX5SJYCKtCjxRCFeaO0xcT9F57f+HyVgSsY4eU/F04UxiZnEMII+
	 45FEv+C83MJC0tmm6UhLh+lZq+XBpB3ui9MTWvoa6aD1Z4tJBT0MrTrvWxns6nj8wRtMf
	 zrj6IQqeUNs6LCqhDv/oEPgfma5+Ym8UBIacpgwuV/e5JC1zWI45nG0MNXMwF+9t/XwVp
	 qHZ5/lV6uW/6oXbkPp24ooFRaZEX2dsbSzAGu+W+KX/vYhGuTpicbb/nMuDbsIdahOe1+
	 8eEDBDM7Pbkyx4TKo+kb09g5X0Ft5udz9Cofwx5Orv/svFoo/9T/Q8RmWEaUgiHeDMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007865;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ou7VqJIvrJwbDof8WuTCn2yqRr3nuLImwl+n8z/KCYU=;
	b=GzoAgLDIMl/MUy80m3xsNcJ7IE0iP4mTVmeCYKTsmznX7wbIy9TOcm6VVYU3zMcOvg0H
	 JKmAYjnygjWDp5uU0wgbfYYeFQspujqt1bf1CcTLUER9SAQ2/T5viRX0lDmuvd98mNgXJ
	 3yx4bXuDUP11kApV7iyRBLDv8Qn5Ne0iU9/qDtnvzhNIOsaFS6uvpuba609Vw+K0VNl0h
	 9QSIZzzFEPumbDV1nBs0ERhl2cBuYGUguWSiU/mDyShgmIm6zWZ+72r0p8e+gD289tJES
	 6alp7pHswIw4aCsoHGu4YpgAgLyLg3VbGTr/GFiPeHkS7kAgiQLK/AoOS8/JP3RwDaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wRuLXZI5;
	arc=none smtp.remote-ip=91.218.175.225
Received: from mta0.migadu.com (out-225.mta0.migadu.com [91.218.175.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78183606A331
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 13:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78183606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wRuLXZI5
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/ZzSIR3rPfPXJJtOS8PvCdyzoY8bbs32yVXQ2eK08Ew=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795007862; v=1; x=1795612662;
 b=wRuLXZI55fFf4X88ZVUxePGmdNFnkBpJPhJ5pfnszsresV0CwftRxx0PxzRELfa+UBAfZcMO
 FQOInKGpTqEv5BS5eDRQ8sUT32bNtNTkQwggRCG8l0wsmd759p4mOgBuhycUrmPvr+EK5cJvEop
 luJovKH0Z0iVLm04/TBuf5y8=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 663fd380a80634db;
	Wed, 18 Nov 2026 13:17:42 +0000
X-Mizu-Trace-ID: 663fd380a80634db
X-Migadu-Flow: FLOW_OUT
Message-ID: <0da8e4bf-ad3d-4a69-a1af-b2be9c63160c@linux.dev>
Date: Wed, 18 Nov 2026 21:17:36 +0800
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
Cc: cui.tao@linux.dev, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, daniel@iogearbox.net, linux-kselftest@vger.kernel.org,
 cuitao@kylinos.cn, ameryhung@gmail.com
Subject: Re: [RFC PATCH v14 0/4] blk-iocost: BPF struct_ops cost model
To: tj@kernel.org, josef@toxicopanda.com, axboe@kernel.dk, ast@kernel.org,
 alexei.starovoitov@gmail.com
References: <20261118131029.797007-1-cui.tao@linux.dev>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20261118131029.797007-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Alexei,

在 2026/11/18 21:10, Tao Cui 写道:
> This series lets a BPF program take over the cost model of one
> device. The BPF model provides calc_cost() for charged IOs plus two
> transfer coefficients for the completion-time sizing, io.cost.model
> selects between the attached model and the builtin one, and enabling
> and disabling the controller stays with io.cost.qos.
> 
> The builtin model is a linear formula derived from a handful of device
> parameters, and the right formula is device specific. A BPF model can
> be adapted to the device and updated without rebuilding the kernel.
> 
> The series is based on next-20261117.

p1 changed quite a bit since the version you acked, mostly from
tj's review and Sashiko's testing reports, so here's a quick
summary.

The flag enum and the model accessors are renamed. The merge flag
is now enum iocost_calc_flags with IOCOST_CALC_MERGE, calc_cost()
takes a calc_flags parameter, and ioc_model()/model become
ioc_bpf_model()/bpf_model so the builtin model is no longer
represented as a NULL model. The named enum also makes the flags
discoverable through BTF.

calc_cost() now has the same pricing scope as the builtin model:
bios with no data and no flush state and ops other than reads,
writes and zone appends cost nothing, flushes are passed through
so the model can price them from the bio flags, and
completion-time sizing now follows the model's transfer
coefficients.

On attach iocost holds its own reference on the struct_ops map,
so a model cannot go away while it is pricing. A dead owning map
reports -ENODEV instead of -EBUSY now, and the autop stepping
timestamps are cleared at attach so a stale pre-attach profile
cannot fire a step at the model=linear switchback.

The attached and attached_link updates also moved out of
ioc->lock: rq_qos_mutex already orders all their accessors, and
ioc->lock is only needed for publishing bpf_model to the timer
and show paths.

I'm still carrying your Acked-by. Since p1 changed quite a bit,
I'm happy to drop it until you've had a chance to take another
look if you'd prefer.

Thanks,
Tao
