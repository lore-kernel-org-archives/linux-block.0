Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F1246783
	for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 04:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791605898; cv=pass; b=Vv1SyRcMKQUTBmQjz32N0IltycOJ8sf7d07yZYgosHew5j3OmcfPeRpUGaiq/XWojvvpc635r3/oEMWzei8y5fyjmJmvVYQt5Pes74YjK+NbT6EceL53WI9r4Zl1b88BN/G2cSgsqAJcRZlcknT6vbxQRZaMjYsU6yk7pCh624E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791605898; c=relaxed/simple;
	bh=KYy6VegmlTUaxOe7PFlSpF96TjgUY4FSEQt4j5zRT20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEIwIxi9iTnVilJomhPAuXuDEJ5O7TZQhqYa4AK1kCNox3vqHdJ7pDMO7Pp3HzRL+xUvNdUuhfTtf90RknqY+Jv6HdMTzVOZlY7eWJINhuYnNbxi6P1hbWxaJYCt1fakHLZ+LTja2FbcklwWJ6HwygGt5i5NTPnt59Ka9oNNNk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxwPN3z2; arc=pass smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxwPN3z2"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6df5e315bd1so304768eaf.2
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 21:18:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791605895; cv=none;
        d=google.com; s=arc-20260327;
        b=OMUMu1ak2QnqmJlauzRLm9iZtrxMWHwhsC8jJkVjRwishhLgPh3IgYF7V6b7Byinb/
         H94aNb101zWIeJKVNkzpjZOWPrxKFitLlYWSO0PU3e/HfhBMyHsbBrwKy45Svd+hZP6G
         IXwzuRzAaqXsp3G0R5KBJziwLzWBzGaROhiiPVT+/2p4zFHzfJjUb1X+J8nC/4vvDGEl
         X+9NyOP1AFiL7RR6rEieM20eDEzNX2yuBHHiD9bMx/n2LbHIPFW5264R20/hGSFh9Pwj
         Mgs1LDqmPxdD1+8t+eF6s03qqGXX2d5W4va6B09shDKGm+GW3j5yGIklVgat8zMOh0/Q
         Cz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ew33P9923AzoJpuAktLckP37GCcxC9qHFUOjrnQW1Ik=;
        fh=YXn9rJPcoMvpbJhfmXpR+rAdpeHg3EQsMont24gwkqg=;
        b=Ot1yifwoFuBtQbacJtbOuXF4r9Lbyee1tZjSjS3RuNgWRgyCRSs/vqoPeDy92qiqQj
         dAKgSIzzxnfSSHPUyP6Rs4qYTpVLMaZfAaCEFQN2Dyu5wslq4xY1llpqJYk1RE7BFrdH
         algH9pQZeD966W1FgWkwF1laSRAAaNy0KGPwEctyHXt4DATA+1m00wBGMN8hWHig8OHm
         /Z5kdHoEvy3Pr3KQGeqLSgcIN9EUZ3NdgJJc20Y+hO1Beq5KW1MBRFs9hHV47W6KWiWA
         D6C8IwAMe/CJpAu4onO4vkbj8cdUA3ghej3gd47vpQjKOAvYYdTAleJRR7eFrppUVH2Q
         MATw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791605895; x=1792210695; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ew33P9923AzoJpuAktLckP37GCcxC9qHFUOjrnQW1Ik=;
        b=OxwPN3z2Qz8oUwvwhqV8qNluN4gvU/XIaloMEhRouQnKBX5awGvC1nhoxLjPFyIQ7u
         DV3EiJm9Ieqo4hI0bJ/MF6sbCni4DbDsLnE7s8oAWWXxzD4FXfhyk3JfNMA0vvJuRUQn
         DbjnHf5C5cI67mieFz1E36SjXNwSYq5u9iby+wu9S54Op6T1sIn54U8o4l/dEiqW7UuQ
         nGgOsf1drkrgL0CRVP1/ZgUY0Gkbe6zGIyk3wWzdCVQbL4jkQn7FH3nI7Nf6NTBrQTNf
         YdmDsbc1lfhFlsFBEObW4MODgwE+CAj0WcyV2RadszbAc0Hbd7I7rAL6D2R1x6b5CFTf
         8j/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791605895; x=1792210695;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ew33P9923AzoJpuAktLckP37GCcxC9qHFUOjrnQW1Ik=;
        b=cCUqnD+ldIgI73iKRR5cqekNANIIyZWMHc7ghuZL1BA764Ud1mTwZmCBrDjtVvFT0Y
         t6sCBNbdkYv33nSPNAlmNe2K2XjfvzPNDG14u/jgchJwdJlUOS2Iqiyr2k+EY0uLnEGH
         zicnFTnjon0AXSo27r70l+HYQbZSmbYgdNpzTtkZPfkoIR2viRyb3v4/zI9U8RnNs18W
         r2zTmI1gWCpDY8WP9FFqawXfKmbayC6TwBxSHmRHqjF8GW++eRKtdpr0AveqtHGr/Qj1
         ZxHdx/bvPtIJpVGGaFDhQ+FzXNnFFiENlzw88lNJNIuoJ2WGvT58R4EC4gpUjA9D5Yic
         8czg==
X-Forwarded-Encrypted: i=1; AKwUvBwr53k1I62f1pdZkvCkBsBv3qiglssJsRbJoLA5zSTVYIh/CJiws8f82gUIUj0Lea5Kgk9775m9Vidykw==@vger.kernel.org
X-Gm-Message-State: AFq9FYITJeZkz/lc22Br7TXRfVDWAIFIlBiLcD3HC6zew5famH/hbOji
	Bgb5NFIMGJGZmRC88tw9aGUjEJll/TWrqcLu6/Uypl/TskiOvyGN61PGw2NJ8RsUWeyR2Xv7Can
	HV4bewGCABXYSaB5fd4LFxB3+OdB7erU=
X-Gm-Gg: AYBFou10tQ0JYEMyoj6S4ib5FLcQ2R4Wjx7Tpx9aPQZIFG2DdwgOoQHB89jOcpyoRDN
	gZjlJS+ymGxCs//C/4mEG0x9rLgO5nCe4BjgJtgRxINFkb1gvHkrfjpiYl2mHffFeh4r5fpZZYv
	ZpgEqqWZpqiYEmypFyaz03HeZxj94MNW1goJnd4MqgdszUCjgte2rvJeGs4CYX/hq1pLVI+f6iZ
	r1WdwW546SLzfSE+C7KPVm123gLS+nlZn5cjFIIIvvk5IqGS9lqWyEebLflkjrP119W5bxY5TEF
	qIHipbtoVzRCmReVwEB9FlLGOuRIHI6GntgEPRG9xNRNQfSvVyQJ9G2KIdv41jG11fu8RFZZI+f
	ehXKC3Qh44vER5jLPSKR6BaX7YGQyimjolQ1/VHDfwUN9o1MsI6He0XM=
X-Received: by 2002:a05:6820:984:b0:6e2:3d8b:a01c with SMTP id
 006d021491bc7-6ef0e9dc2d0mr2797147eaf.19.1791605895411; Fri, 09 Oct 2026
 21:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001-bug-block-elevator-init-quiesce-v1-1-5c85fa0ec59b@gmail.com>
In-Reply-To: <20261001-bug-block-elevator-init-quiesce-v1-1-5c85fa0ec59b@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 9 Oct 2026 23:18:04 -0500
X-Gm-Features: AclHuK_aaavcIOhZXQjbCJpj_zTwHfB7pXCx3pPddER2n9m6mNEdfh2htsXEqCI
Message-ID: <CACVXFVNVC4cBuL6gFMMo+FktZnXdy18YJ-Wu81NqNfW7E4_6WA@mail.gmail.com>
Subject: Re: [PATCH] block: don't quiesce the queue when setting the default elevator
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>, 
	Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 10:12=E2=80=AFPM Qiliang Yuan <odys.yuan@gmail.com>=
 wrote:
>
> elevator_set_default() runs from blk_register_queue() while the disk is
> still being added: the block device is not visible yet and uevents are
> suppressed, so no file system I/O can be issued. elevator_change()
> freezes the queue and cancels the dispatch work before switching, which
> is enough to drain dispatch activity from passthrough requests, as the
> comment in elevator_change() already states.
>
> elevator_switch() still quiesces the queue unconditionally, though, so
> every disk added with a default elevator waits for an RCU grace period.
> Commit 245a489e81e1 ("block: avoid to quiesce queue in
> elevator_init_mq") had removed this wait from the default elevator
> setup, and it came back when that setup was folded into
> elevator_change().
>
> The wait is paid in full by callers that add disks one at a time. ublk
> adds the disk of a single-queue device from START_DEV, which takes 7.7ms
> at p50 in a 16 vCPU KVM guest, most of it in blk_mq_quiesce_queue()
> called from elevator_set_default().
>
> Skip quiescing in elevator_switch() when setting the default elevator.
>
> ublk null target, 1000 single-queue devices created one by one:
>
>                      before      after
>   START_DEV p50      7.74ms     0.68ms
>   START_DEV p99     14.61ms     1.32ms
>   devices/s             114        971
>
> Fixes: 1e44bedbc921 ("block: unifying elevator change")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
>  block/elevator.c | 7 +++++--
>  block/elevator.h | 2 ++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/block/elevator.c b/block/elevator.c
> index 2161b6eea680c..da9ba70ac9321 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -573,7 +573,8 @@ static int elevator_switch(struct request_queue *q, s=
truct elv_change_ctx *ctx)
>                         return -EINVAL;
>         }
>
> -       blk_mq_quiesce_queue(q);
> +       if (!ctx->no_quiesce)
> +               blk_mq_quiesce_queue(q);
>
>         if (q->elevator) {
>                 ctx->old =3D q->elevator;
> @@ -594,7 +595,8 @@ static int elevator_switch(struct request_queue *q, s=
truct elv_change_ctx *ctx)
>         blk_add_trace_msg(q, "elv switch: %s", ctx->name);
>
>  out_unfreeze:
> -       blk_mq_unquiesce_queue(q);
> +       if (!ctx->no_quiesce)
> +               blk_mq_unquiesce_queue(q);
>
>         if (ret) {
>                 pr_warn("elv: switch to \"%s\" failed, falling back to \"=
none\"\n",
> @@ -731,6 +733,7 @@ void elevator_set_default(struct request_queue *q)
>         struct elv_change_ctx ctx =3D {
>                 .name =3D "mq-deadline",
>                 .no_uevent =3D true,
> +               .no_quiesce =3D true,
>         };
>         int err;

Looks good given elevator_set_default() is only called on new added disk,

Reviewed-by: Ming Lei <tom.leiming@gmail.com>



Thanks,
Ming Lei
