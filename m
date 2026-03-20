Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64223301704
	for <linux-block@vger.kernel.org>; Fri, 20 Mar 2026 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019340; cv=none; b=UTANEWIgDnvcWXai1dIIJpfZ+LpA0wSX3f9C7MdfN6KrcVZveDmQ70IKqkwx7slDCFgVT7dQCt/OBADJZB0dLcMqUrlphe2MXsvSderrIr7xatnK8e2gIr0+j9+cbEB6fMIW3vKXCt6Eg1h07IiCDqD5Ab8mvI+HG0aatfcAp6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019340; c=relaxed/simple;
	bh=Gf2xo6EztxR/JeCfjqfjM56Ztig+zO/66D1b/h1hO2w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TPZBXJnwstWveFA4dbtJq2bQZinzKFpPpV4dcJDHwyLB3JdQ7EdGKX0lQ6nYsR5R7DVmyirvHlz+se40R6BkMNT6qMBaJ+JuaVMw+puQ0oRY6OsF5ZO/Z0P99kZhhW6aOnUXEjCgCi74239kXs3g47oR4d7L587HKwRlv3v1jWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hy5wefvb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jcGylTlu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hy5wefvb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jcGylTlu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774019338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dd0KHrH7sbzENLhTFKGbOZqkvnECORpg3J+lU5pEMk0=;
	b=hy5wefvbJaqf/foFORTm8UKOheczjaBYYAPIFm1obYirKlnms8/esmrosHQGFxEtEIMD9i
	MoWt6Tun9wjT3n2y5UIE5KRIgV2OnmrFHdxRTBxqIaiRU2F80es3LDpNZm9URbs4PxcwtN
	OGiNRCyyhX3chFKYtOTfOTHMY7DTfXo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-e7V4c0pUPVyDz5NNPiERqw-1; Fri, 20 Mar 2026 11:08:57 -0400
X-MC-Unique: e7V4c0pUPVyDz5NNPiERqw-1
X-Mimecast-MFC-AGG-ID: e7V4c0pUPVyDz5NNPiERqw_1774019337
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b4031b86dso30245951cf.0
        for <linux-block@vger.kernel.org>; Fri, 20 Mar 2026 08:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774019337; x=1774624137; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dd0KHrH7sbzENLhTFKGbOZqkvnECORpg3J+lU5pEMk0=;
        b=jcGylTluTAB/qF8epxZw/orZxe++5kULpPxReJu1Qh2n7pue6u3aq/mMTDjYw6bB7T
         Vw57hmoZI9ORYgTL/qpqZq9rCkn8w/kTZjibDXjSmd/3g301vwhHImMUPwGF31A+SG7j
         WjrBNbGBkRCzufLziVOd9s5soRCF4+W5ZPsjUAWfh6piRqZKzWD7sVdh+X23HCWasUhz
         s7DQoSB+a91yW0TAxguq3VzpZ2wkaLMfhdlmx/iL+XfeFP6jwVk35pPn4Jx9YmrRjUds
         Ai08H/RVT5LAIEsjfoiawan3WyajuNvtIAi3N+zdwGTvj57Mowir3F4weaBWgmoeTFE5
         OTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774019337; x=1774624137;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dd0KHrH7sbzENLhTFKGbOZqkvnECORpg3J+lU5pEMk0=;
        b=V1IdKq9jd+XTpqAvh/5X4I2eZfEo1mg2/y4DKir7NgsFfHLC+KaAvSGEwCOCdyFCzz
         ErrcliNBSYFFiU9kP62xjQZ8uVSkfH+lmL8O10BzpBYmm1vAzNbupmi/0BGQwTJxx8p7
         788nhT948GWBNjEKWs9JzlC8a48plOtK8XfH7UTFRRNkNIiwo7CW7PJ6mzDFJlS/99fZ
         WI7haccsxMHy92gLFs3NzMxxu8QZ66KVAvvFYlAqRNjGthksbu6yLcmFRoA57jBr5UP0
         95im+sOzII17Tlay44zgmZX6mg8wqwK27tsLxOkxJtVXEGsXzqECELn9PNYdooJhWobv
         Ly8w==
X-Forwarded-Encrypted: i=1; AJvYcCWR30/MLGAYTJ2egWsSG/Fk9Mh5ZMXYdWkV9q9l7uu9bIqR52jE3Llr+X4dWgoa2exorB2MoLKpel4gow==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDzBLh40PadaKo2Qr0pbWm9TVipcEi5GEhuV3vCXQhhBAvupCr
	USNn2WDniFk66i4wybKRdZfswkWB01aiDe+2mnUhOH08ox04HFccKHkuwhoFV3hCWaAa0mWit2r
	LCkMTt0w7R0ddPJ7BT3RRnrlnVF65B0KycuQXOvMF862Ir8XwviNf54f/SmcgT0TF
X-Gm-Gg: ATEYQzziU1UCCIx75lyJQfIeSpQQIcxMDeTPUC1wlqVdWINw5sYm4ZEwRrTdrPqowjS
	9J5CttPQMYYXPlS86vOabXIqBMQL2QpOij6E1ybV9g6ynS11yoXoT/0P+BmcFi3CcPE5ti6FQJ4
	Hi3ZQvbOBh8iAjGCFnZAat+ftAhdocpaGB0mhcg8taeArwEVPIVdll0s2/r0QQ+MYUwLZX6Yzrx
	ZuScBg/dDjJRvyLanZb+quVaeRk8agdSO6bSpu3pCMwBxYP+TBCaPFnzAZLoWS8/znSfQw8xnqp
	r/LBphFPQK3UFENfWYn7/tzRDB8ioYl9nKGZ6+tIC6W78mgjBom8M+wTzsD+mkdVTceBVXXOIkm
	55z5esj/lIiID1WofkZugMgO9LHfO8GY5jUSn0kabh2jcqRZuLtjVjWT/Ou0=
X-Received: by 2002:a05:622a:438e:b0:509:350e:744d with SMTP id d75a77b69052e-50b373ea3dbmr39119491cf.8.1774019336708;
        Fri, 20 Mar 2026 08:08:56 -0700 (PDT)
X-Received: by 2002:a05:622a:438e:b0:509:350e:744d with SMTP id d75a77b69052e-50b373ea3dbmr39118731cf.8.1774019335960;
        Fri, 20 Mar 2026 08:08:55 -0700 (PDT)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c64:4e7f:603b:aa2b:ddff:fe88:da74])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36ebae51sm23744961cf.31.2026.03.20.08.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 08:08:55 -0700 (PDT)
Message-ID: <ed7473fc9a9115f2c23cfa4ef7514589dfbdc70b.camel@redhat.com>
Subject: Re: [PATCH v3 2/2] blk-mq: expose tag starvation counts via debugfs
From: Laurence Oberman <loberman@redhat.com>
To: Aaron Tomlin <atomlin@atomlin.com>, axboe@kernel.dk,
 rostedt@goodmis.org, 	mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Cc: johannes.thumshirn@wdc.com, kch@nvidia.com, bvanassche@acm.org, 
	dlemoal@kernel.org, ritesh.list@gmail.com, neelx@suse.com, sean@ashe.io, 
	mproche@gmail.com, chjohnst@gmail.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Date: Fri, 20 Mar 2026 11:08:53 -0400
In-Reply-To: <20260319221956.332770-3-atomlin@atomlin.com>
References: <20260319221956.332770-1-atomlin@atomlin.com>
	 <20260319221956.332770-3-atomlin@atomlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-03-19 at 18:19 -0400, Aaron Tomlin wrote:
> In high-performance storage environments, particularly when utilising
> RAID controllers with shared tag sets (BLK_MQ_F_TAG_HCTX_SHARED),
> severe
> latency spikes can occur when fast devices are starved of available
> tags.
>=20
> This patch introduces two new debugfs attributes for each block
> hardware queue:
> =C2=A0 - /sys/kernel/debug/block/[device]/hctxN/wait_on_hw_tag
> =C2=A0 - /sys/kernel/debug/block/[device]/hctxN/wait_on_sched_tag
>=20
> These files expose atomic counters that increment each time a
> submitting
> context is forced into an uninterruptible sleep via io_schedule() due
> to
> the complete exhaustion of physical driver tags or software scheduler
> tags, respectively.
>=20
> To guarantee zero performance overhead for production kernels
> compiled
> without debugfs, the underlying atomic_t variables and their
> associated
> increment routines are strictly guarded behind CONFIG_BLK_DEBUG_FS.
> When this configuration is disabled, the tracking logic compiles down
> to a safe no-op.
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
> =C2=A0block/blk-mq-debugfs.c | 56
> ++++++++++++++++++++++++++++++++++++++++++
> =C2=A0block/blk-mq-debugfs.h |=C2=A0 7 ++++++
> =C2=A0block/blk-mq-tag.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++
> =C2=A0include/linux/blk-mq.h | 10 ++++++++
> =C2=A04 files changed, 77 insertions(+)
>=20
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 28167c9baa55..078561d7da38 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -483,6 +483,42 @@ static int hctx_dispatch_busy_show(void *data,
> struct seq_file *m)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/**
> + * hctx_wait_on_hw_tag_show - display hardware tag starvation count
> + * @data: generic pointer to the associated hardware context (hctx)
> + * @m: seq_file pointer for debugfs output formatting
> + *
> + * Prints the cumulative number of times a submitting context was
> forced
> + * to block due to the exhaustion of physical hardware driver tags.
> + *
> + * Return: 0 on success.
> + */
> +static int hctx_wait_on_hw_tag_show(void *data, struct seq_file *m)
> +{
> +	struct blk_mq_hw_ctx *hctx =3D data;
> +
> +	seq_printf(m, "%d\n", atomic_read(&hctx->wait_on_hw_tag));
> +	return 0;
> +}
> +
> +/**
> + * hctx_wait_on_sched_tag_show - display scheduler tag starvation
> count
> + * @data: generic pointer to the associated hardware context (hctx)
> + * @m: seq_file pointer for debugfs output formatting
> + *
> + * Prints the cumulative number of times a submitting context was
> forced
> + * to block due to the exhaustion of software scheduler tags.
> + *
> + * Return: 0 on success.
> + */
> +static int hctx_wait_on_sched_tag_show(void *data, struct seq_file
> *m)
> +{
> +	struct blk_mq_hw_ctx *hctx =3D data;
> +
> +	seq_printf(m, "%d\n", atomic_read(&hctx-
> >wait_on_sched_tag));
> +	return 0;
> +}
> +
> =C2=A0#define CTX_RQ_SEQ_OPS(name,
> type)					\
> =C2=A0static void *ctx_##name##_rq_list_start(struct seq_file *m, loff_t
> *pos) \
> =C2=A0	__acquires(&ctx-
> >lock)						\
> @@ -598,6 +634,8 @@ static const struct blk_mq_debugfs_attr
> blk_mq_debugfs_hctx_attrs[] =3D {
> =C2=A0	{"active", 0400, hctx_active_show},
> =C2=A0	{"dispatch_busy", 0400, hctx_dispatch_busy_show},
> =C2=A0	{"type", 0400, hctx_type_show},
> +	{"wait_on_hw_tag", 0400, hctx_wait_on_hw_tag_show},
> +	{"wait_on_sched_tag", 0400, hctx_wait_on_sched_tag_show},
> =C2=A0	{},
> =C2=A0};
> =C2=A0
> @@ -814,3 +852,21 @@ void blk_mq_debugfs_unregister_sched_hctx(struct
> blk_mq_hw_ctx *hctx)
> =C2=A0	debugfs_remove_recursive(hctx->sched_debugfs_dir);
> =C2=A0	hctx->sched_debugfs_dir =3D NULL;
> =C2=A0}
> +
> +/**
> + * blk_mq_debugfs_inc_wait_tags - increment the tag starvation
> counters
> + * @hctx: hardware context associated with the tag allocation
> + * @is_sched: boolean indicating whether the starved pool is the
> software scheduler
> + *
> + * Evaluates the exhausted tag pool and increments the appropriate
> debugfs
> + * starvation counter. This is invoked immediately before the
> submitting
> + * context is forced into an uninterruptible sleep via
> io_schedule().
> + */
> +void blk_mq_debugfs_inc_wait_tags(struct blk_mq_hw_ctx *hctx,
> +				=C2=A0 bool is_sched)
> +{
> +	if (is_sched)
> +		atomic_inc(&hctx->wait_on_sched_tag);
> +	else
> +		atomic_inc(&hctx->wait_on_hw_tag);
> +}
> diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
> index 49bb1aaa83dc..2cda555d5730 100644
> --- a/block/blk-mq-debugfs.h
> +++ b/block/blk-mq-debugfs.h
> @@ -34,6 +34,8 @@ void blk_mq_debugfs_register_sched_hctx(struct
> request_queue *q,
> =C2=A0void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx
> *hctx);
> =C2=A0
> =C2=A0void blk_mq_debugfs_register_rq_qos(struct request_queue *q);
> +void blk_mq_debugfs_inc_wait_tags(struct blk_mq_hw_ctx *hctx,
> +				=C2=A0 bool is_sched);
> =C2=A0#else
> =C2=A0static inline void blk_mq_debugfs_register(struct request_queue *q)
> =C2=A0{
> @@ -77,6 +79,11 @@ static inline void
> blk_mq_debugfs_register_rq_qos(struct request_queue *q)
> =C2=A0{
> =C2=A0}
> =C2=A0
> +static inline void blk_mq_debugfs_inc_wait_tags(struct blk_mq_hw_ctx
> *hctx,
> +						bool is_sched)
> +{
> +}
> +
> =C2=A0#endif
> =C2=A0
> =C2=A0#if defined(CONFIG_BLK_DEV_ZONED) && defined(CONFIG_BLK_DEBUG_FS)
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 66138dd043d4..3cc6a97a87a0 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -17,6 +17,7 @@
> =C2=A0#include "blk.h"
> =C2=A0#include "blk-mq.h"
> =C2=A0#include "blk-mq-sched.h"
> +#include "blk-mq-debugfs.h"
> =C2=A0
> =C2=A0/*
> =C2=A0 * Recalculate wakeup batch when tag is shared by hctx.
> @@ -191,6 +192,9 @@ unsigned int blk_mq_get_tag(struct
> blk_mq_alloc_data *data)
> =C2=A0		trace_block_rq_tag_wait(data->q, data->hctx,
> =C2=A0					data->rq_flags &
> RQF_SCHED_TAGS);
> =C2=A0
> +		blk_mq_debugfs_inc_wait_tags(data->hctx,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 data->rq_flags &
> RQF_SCHED_TAGS);
> +
> =C2=A0		bt_prev =3D bt;
> =C2=A0		io_schedule();
> =C2=A0
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 18a2388ba581..f3d8ea93b23f 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -453,6 +453,16 @@ struct blk_mq_hw_ctx {
> =C2=A0	struct dentry		*debugfs_dir;
> =C2=A0	/** @sched_debugfs_dir:	debugfs directory for the
> scheduler. */
> =C2=A0	struct dentry		*sched_debugfs_dir;
> +	/**
> +	 * @wait_on_hw_tag: Cumulative counter incremented each time
> a submitting
> +	 * context is forced to block due to physical hardware
> driver tag exhaustion.
> +	 */
> +	atomic_t		wait_on_hw_tag;
> +	/**
> +	 * @wait_on_sched_tag: Cumulative counter incremented each
> time a submitting
> +	 * context is forced to block due to software scheduler tag
> exhaustion.
> +	 */
> +	atomic_t		wait_on_sched_tag;
> =C2=A0#endif
> =C2=A0
> =C2=A0	/**

For [PATCH v3 2/2] blk-mq: expose tag starvation counts via debugfs

Tested-by: Laurence Oberman <loberman@redhat.com>

Every 10.0s: grep . /sys/kernel/debug/block/nvme0n1/hctx0/wait_on_*  =20
rhel95: Fri Mar 20 11:04:15 2026

/sys/kernel/debug/block/nvme0n1/hctx0/wait_on_hw_tag:103260 <---
cumulative=20
/sys/kernel/debug/block/nvme0n1/hctx0/wait_on_sched_tag:0

The patch to me looks good, but will need others to confirm
Reviewed-by: Laurence Oberman <loberman@redhat.com>

