Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD836D9F9;
	Sun,  3 May 2026 04:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777783500; cv=none; b=jHxk7EQARKHET4yRa2CRdh2vDqGyVEub9MgIT1STgjR4ef09+Egwl9z6tQtibuoE4vVjehTNYnkRhHFHLGqf9wT/TrZqiKrBZ5E1YwRbXZWsfxPXj7F1PYnB9Jbeu+a87uVtme5ygktOU724cIvU+8u7YenZVBmRmRtksOHCTJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777783500; c=relaxed/simple;
	bh=5+lluvypd/S3rfgNrMrN5CCwy15qF6X6IBO8p6fo74A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VXW8i8kcbSJi4EWfqc7vatltu9kcyVPS4V47tlehibxu9gFghbzH8pvVGzPkkcnNgWCKgsnI+XL0waPfIQoe2hh2yY9Eu6hu6WUrw/+RQ/dVnHSVmKrJRNpNoJmHjliJ/7qd+BvOff2pq6XeM4oS4vXrDVEnWj/tsEJmQDr7V6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0VlhFCr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0VlhFCr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACCEC2BCB4;
	Sun,  3 May 2026 04:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777783500;
	bh=5+lluvypd/S3rfgNrMrN5CCwy15qF6X6IBO8p6fo74A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=R0VlhFCrFObNVBDgf26tb7h8umDmGPZ7N38QD/TIbx7RLR8DiMUpUAp3k7dTPtpob
	 wmJOwzink7y2c7Bb/IUxfZz2LDnbzwxC42oxmQ8dBT4pvSSdWf+4AOkgsLEPkLGmAm
	 csL8DabW1IN7ijaYmVN0yK/3oEmvYOIzhmVfbIhwRiW9CBgYwSqTQ8lNjATuSPWaXg
	 Qot+aBm8O4vVJHWuM1D8H56Tg0o74hfFue2NiICtu1hZIbknfLF5i6RyfxokGrOqLX
	 AwmELLgFyi3JngcHmguKcEPEDnq8mV6J0U/Dfqm1nsoYjBDIfWmMIhl2qXlxp/DJ+o
	 p0ExufMDMAgnQ==
Content-Type: multipart/mixed; boundary="===============1870624184022285496=="
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aed2543e93c484d9666ff3087417ee607fceb9cd93bd9646a6f8edda7d65df1d@mail.kernel.org>
In-Reply-To: <20260503035623.28771-4-kaitao.cheng@linux.dev>
References: <20260503035623.28771-4-kaitao.cheng@linux.dev>
Subject: Re: [RFC v2 3/3] tools/ufq_iosched: add BPF example scheduler and build scaffolding
From: bot+bpf-ci@kernel.org
To: kaitao.cheng@linux.dev,axboe@kernel.dk,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,linux-block@vger.kernel.org,linux-kernel@vger.kernel.org,chengkaitao@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  3 May 2026 04:44:57 +0000 (UTC)

--===============1870624184022285496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/ufq_iosched/ufq_simple.bpf.c b/tools/ufq_iosched/ufq_simple.bpf.c
> new file mode 100644
> index 000000000000..81954e73068a
> --- /dev/null
> +++ b/tools/ufq_iosched/ufq_simple.bpf.c

[ ... ]

> +int BPF_STRUCT_OPS(ufq_simple_insert_req, struct request_queue *q,
> +		   struct request *rq, blk_insert_t flags,
> +		   struct list_head *freeq)
                                              ^^^^^^^

Does this signature match the kernel's ufq_iosched_ops definition?

Looking at block/ufq-iosched.h, the insert_req member is defined with
three parameters:

    int (*insert_req)(struct request_queue *q, struct request *rq,
                     blk_insert_t flags);

The kernel-side callers in block/ufq-iosched.c also pass only three
arguments:

    ret = ops->insert_req(q, rq, flags);
    ops->insert_req(q, target, 0);

The BPF struct_ops verifier (check_struct_ops_btf_id) validates that each
BPF program matches the declared function-pointer signature in the kernel.
A program with four parameters registered against a three-parameter member
will be rejected at load time, so ufq_simple will fail to attach via
UFQ_OPS_LOAD / UFQ_OPS_ATTACH and the example cannot be used.

Even if the verifier accepted the mismatch, the trampoline would not
populate a fourth argument, leaving freeq uninitialized. Should the extra
'struct list_head *freeq' parameter be removed?

> +{
> +	struct ufq_simple_data *ufq_sd;
> +	struct queue_list_node *qnode;
> +	struct sort_tree_node *snode;

[ ... ]

> +UFQ_OPS_DEFINE(ufq_simple_ops,
> +	.init_sched		= (void *)ufq_simple_init_sched,
> +	.exit_sched		= (void *)ufq_simple_exit_sched,
> +	.insert_req		= (void *)ufq_simple_insert_req,
> +	.dispatch_req		= (void *)ufq_simple_dispatch_req,
> +	.has_req		= (void *)ufq_simple_has_req,
> +	.finish_req		= (void *)ufq_simple_finish_req,
> +	.merge_req		= (void *)ufq_simple_merge_req,
> +	.merge_bio		= (void *)ufq_simple_merge_bio,
> +	.name			= "ufq_simple");


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25269522212
--===============1870624184022285496==--
