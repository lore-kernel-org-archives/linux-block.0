Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EFE1E9919
	for <linux-block@vger.kernel.org>; Sat,  4 Apr 2026 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775309620; cv=none; b=DxshYgKba+WAAg343UfkE3e1p2m7omnXuNmuPdcAb0swh2AnsVEA1I7fVXdIKceLMDrpGVXuvTLYcuzF20e6YlEC/6elM13aDq/8nYM8VCQlaiHmtrJ5l+Uuz14PtWIOb7jO+LV71QNFQsy5YzDiw2mDPUZOZhEiMiI/9CZIdv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775309620; c=relaxed/simple;
	bh=Q2GKMP17Ghi4pjyzhv0HZ/Qzea6RamNGkszjHCu/Ebs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urpNU8KDp1KZT4IVTT0r16UacVA0qhrGCbwVMOcKShTJ8bcgZ6rsfsXt7R35Q90ywi9W/JtDMU+clRtA4I3svfxh/BWg7g5U20Eo6O0wJbNPljjX8digbiOc46nHg/r4mn1WB5VKtoL/fCY4+7BjdzfXxkT8T9TWpssyvaXtr2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bRcBo18K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRcBo18K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775309618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ajHuRr34n80QEfx3RDEkxdSOcPNSl9QuGL/XB6X9dwY=;
	b=bRcBo18KZSQNI0pdbKpftyECsPnnU+8efzwtvU942zSFsK4sRU9p9JXYCjjDWihiIZbDiG
	5yHGD/3lY+XlLOIiy9KWutt+YPlobUutmyMeUT0XIbGjoJ14EmVKeozNEG6n9R0l4CisuU
	ijDpdOzYV7j42vC5XRV+xG4Hqnx3y2I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-_CAqt0iFPkmU03TxZrpU2g-1; Sat,
 04 Apr 2026 09:33:35 -0400
X-MC-Unique: _CAqt0iFPkmU03TxZrpU2g-1
X-Mimecast-MFC-AGG-ID: _CAqt0iFPkmU03TxZrpU2g_1775309614
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD05E195608A;
	Sat,  4 Apr 2026 13:33:33 +0000 (UTC)
Received: from fedora (unknown [10.72.116.33])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF5741800576;
	Sat,  4 Apr 2026 13:33:27 +0000 (UTC)
Date: Sat, 4 Apr 2026 21:33:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: ublk: test that teardown after incomplete
 recovery completes
Message-ID: <adETItDHUovgjvk_@fedora>
References: <20260403-cancel-v1-0-86e5a6b3d3af@purestorage.com>
 <20260403-cancel-v1-2-86e5a6b3d3af@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-cancel-v1-2-86e5a6b3d3af@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Apr 03, 2026 at 09:23:56PM -0600, Uday Shankar wrote:
> Before the fix, teardown of a ublk server that was attempting to recover
> a device, but died when it had submitted a nonempty proper subset of the
> fetch commands to any queue would loop forever. Add a test to verify
> that, after the fix, teardown completes. This is done by:
> 
> - Adding a new argument to the fault_inject target that causes it die
>   after fetching a nonempty proper subset of the IOs to a queue
> - Using that argument in a new test while trying to recover an
>   already-created device
> - Attempting to delete the ublk device at the end of the test; this
>   hangs forever if teardown from the fault-injected ublk server never
>   completed.
> 
> It was manually verified that the test passes with the fix and hangs
> without it.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  tools/testing/selftests/ublk/Makefile           |  1 +
>  tools/testing/selftests/ublk/fault_inject.c     | 51 +++++++++++++++++++++++--
>  tools/testing/selftests/ublk/kublk.c            |  4 ++
>  tools/testing/selftests/ublk/kublk.h            |  3 ++
>  tools/testing/selftests/ublk/test_generic_17.sh | 35 +++++++++++++++++
>  5 files changed, 91 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
> index 8ac2d4a682a1768fb1eb9d2dd2a5d01294a67a03..d338668c5a5fbd73f6d70165455a3551ab13e894 100644
> --- a/tools/testing/selftests/ublk/Makefile
> +++ b/tools/testing/selftests/ublk/Makefile
> @@ -18,6 +18,7 @@ TEST_PROGS += test_generic_10.sh
>  TEST_PROGS += test_generic_12.sh
>  TEST_PROGS += test_generic_13.sh
>  TEST_PROGS += test_generic_16.sh
> +TEST_PROGS += test_generic_17.sh
>  
>  TEST_PROGS += test_batch_01.sh
>  TEST_PROGS += test_batch_02.sh
> diff --git a/tools/testing/selftests/ublk/fault_inject.c b/tools/testing/selftests/ublk/fault_inject.c
> index 3b897f69c014cc73b4b469d816e80284dd21b577..228a9605053409c84baaf255f97c4abc271a8bfd 100644
> --- a/tools/testing/selftests/ublk/fault_inject.c
> +++ b/tools/testing/selftests/ublk/fault_inject.c
> @@ -10,11 +10,17 @@
>  
>  #include "kublk.h"
>  
> +struct fi_opts {
> +	long long delay_ns;
> +	bool die_during_fetch;
> +};
> +
>  static int ublk_fault_inject_tgt_init(const struct dev_ctx *ctx,
>  				      struct ublk_dev *dev)
>  {
>  	const struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
>  	unsigned long dev_size = 250UL << 30;
> +	struct fi_opts *opts = NULL;
>  
>  	if (ctx->auto_zc_fallback) {
>  		ublk_err("%s: not support auto_zc_fallback\n", __func__);
> @@ -35,17 +41,51 @@ static int ublk_fault_inject_tgt_init(const struct dev_ctx *ctx,
>  	};
>  	ublk_set_integrity_params(ctx, &dev->tgt.params);
>  
> -	dev->private_data = (void *)(unsigned long)(ctx->fault_inject.delay_us * 1000);
> +	opts = calloc(1, sizeof(*opts));
> +	if (!opts) {
> +		ublk_err("%s: couldn't allocate memory for opts\n", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	opts->delay_ns = ctx->fault_inject.delay_us * 1000;
> +	opts->die_during_fetch = ctx->fault_inject.die_during_fetch;
> +	dev->private_data = opts;
> +
>  	return 0;
>  }
>  
> +static void ublk_fault_inject_pre_fetch_io(struct ublk_thread *t,
> +					   struct ublk_queue *q, int tag)
> +{
> +	struct fi_opts *opts = q->dev->private_data;
> +
> +	if (!opts->die_during_fetch)
> +		return;
> +
> +	/*
> +	 * Each queue fetches its IOs in increasing order of tags, so
> +	 * dying just before we're about to fetch tag 1 (regardless of
> +	 * what queue we're on) guarantees that we've fetched a nonempty
> +	 * proper subset of the tags on that queue.
> +	 */
> +	if (tag == 1) {
> +		/*
> +		 * Ensure our commands are actually live in the kernel
> +		 * before we die.
> +		 */
> +		io_uring_submit(&t->ring);
> +		raise(SIGKILL);
> +	}
> +}
> +
>  static int ublk_fault_inject_queue_io(struct ublk_thread *t,
>  				      struct ublk_queue *q, int tag)
>  {
>  	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
>  	struct io_uring_sqe *sqe;
> +	struct fi_opts *opts = q->dev->private_data;
>  	struct __kernel_timespec ts = {
> -		.tv_nsec = (long long)q->dev->private_data,
> +		.tv_nsec = opts->delay_ns,
>  	};
>  
>  	ublk_io_alloc_sqes(t, &sqe, 1);
> @@ -77,29 +117,34 @@ static void ublk_fault_inject_cmd_line(struct dev_ctx *ctx, int argc, char *argv
>  {
>  	static const struct option longopts[] = {
>  		{ "delay_us", 	1,	NULL,  0  },
> +		{ "die_during_fetch", 1, NULL, 0  },
>  		{ 0, 0, 0, 0 }
>  	};
>  	int option_idx, opt;
>  
>  	ctx->fault_inject.delay_us = 0;
> +	ctx->fault_inject.die_during_fetch = false;
>  	while ((opt = getopt_long(argc, argv, "",
>  				  longopts, &option_idx)) != -1) {
>  		switch (opt) {
>  		case 0:
>  			if (!strcmp(longopts[option_idx].name, "delay_us"))
>  				ctx->fault_inject.delay_us = strtoll(optarg, NULL, 10);
> +			if (!strcmp(longopts[option_idx].name, "die_during_fetch"))
> +				ctx->fault_inject.die_during_fetch = strtoll(optarg, NULL, 10);
>  		}
>  	}
>  }
>  
>  static void ublk_fault_inject_usage(const struct ublk_tgt_ops *ops)
>  {
> -	printf("\tfault_inject: [--delay_us us (default 0)]\n");
> +	printf("\tfault_inject: [--delay_us us (default 0)] [--die_during_fetch 1]\n");
>  }
>  
>  const struct ublk_tgt_ops fault_inject_tgt_ops = {
>  	.name = "fault_inject",
>  	.init_tgt = ublk_fault_inject_tgt_init,
> +	.pre_fetch_io = ublk_fault_inject_pre_fetch_io,
>  	.queue_io = ublk_fault_inject_queue_io,
>  	.tgt_io_done = ublk_fault_inject_tgt_io_done,
>  	.parse_cmd_line = ublk_fault_inject_cmd_line,
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
> index e1c3b3c55e565c8cad6b6fe9b9b764cd244818c0..8260c96a39c05584065f41a52f3d9050614454c6 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -796,6 +796,8 @@ static void ublk_submit_fetch_commands(struct ublk_thread *t)
>  			q = &t->dev->q[q_id];
>  			io = &q->ios[tag];
>  			io->buf_index = j++;
> +			if (q->tgt_ops->pre_fetch_io)
> +				q->tgt_ops->pre_fetch_io(t, q, tag);
>  			ublk_queue_io_cmd(t, io);
>  		}
>  	} else {
> @@ -807,6 +809,8 @@ static void ublk_submit_fetch_commands(struct ublk_thread *t)
>  		for (i = 0; i < q->q_depth; i++) {
>  			io = &q->ios[i];
>  			io->buf_index = i;
> +			if (q->tgt_ops->pre_fetch_io)
> +				q->tgt_ops->pre_fetch_io(t, q, i);
>  			ublk_queue_io_cmd(t, io);
>  		}
>  	}

The callback needs to be called in ublk_batch_setup_queues() for F_BATCH
too.

Otherwise, this patch looks good.


Thanks,
Ming

