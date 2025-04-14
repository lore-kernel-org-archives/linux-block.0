Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61E3155C82
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744663482; cv=none; b=G/zW3Sbr6vWbRp2Zyfj2ddGHoZjPs/bIvS419uCi1QktYbD+kdDyU4nyibEziSRCkQ0UzscuIL7h6Q9cwUNNhvTZmivsTs6Zk50zOK2eeZmLt5SP/zFWRBwBGAdLQgDjJYsBkfSig4jLlivJT9+pQOg2BkRWDisnTQ53IAORRaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744663482; c=relaxed/simple;
	bh=CJaP5Q/H3GgKGVS4Z7oz85VbKERxfsqLP2P8xXf1RHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXYulCYxexfKXH9C4UYvEbM78JdiqD9nWTeg3cyLiB5TAecNO2ESc5Gxtvetq3yxoncoB8L/6VWqg+1Op9cEDZBzrBgJHhiR5PYb0B+KUlOY3hf4ExQxmLvmSLNTvogLGwEmOnNyXwajZta1UBTJfOoTrlSgWd2MVlggwMSACVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Le077qaB; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Le077qaB"
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-86135af1045so369698139f.1
        for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 13:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744663480; x=1745268280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uVCA9Dp3PbRx3rPeqhyjLud3oi91INJ7gCWAwFCnRl8=;
        b=Le077qaBIh14kc2+dIH8rJF8tePNAq9TcY+e4j+0EA4OGIyozKerVYczCDTYFOchMl
         nN8Ofj+qdDIBBdKMy9TXRpqSpeZfoQxeT8qxUTPIIEL9qYNoEAsBKsv4dt3z8DKDlNgK
         kWmKNHwLwcuwm6jTXEmrO9/XZrGCGZIv0asQeew9ilyHSpTr33GA0KzRn+x2T43dreR9
         zDK2TCQqmzb44geHGwW5Ad2Ee7RhD6nKFK0gS1DxZGjgS8wfqt4fic+RoY4ZK+oXtpGQ
         xxvsikVNzNAxv8s6rLyA4oIuPuYaeTm2RCyM+iYaWQyLd/gXgjUwPUSd7wJ6/3KBa0iF
         Wllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744663480; x=1745268280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVCA9Dp3PbRx3rPeqhyjLud3oi91INJ7gCWAwFCnRl8=;
        b=uEgvQCl9xyui+Sejef5JVJSxDUKCRk6MY5RhnJ1s+0wBPnF8AyPa9yLkF2yA8wWU/Q
         31d9Hxg06o15MN26IHu/ZfC36kohKG8exJnYveY21QND2XmdVbeUbEsC5zmKlSfBtLmL
         rD9I2+IfwDOR4ZiWbCWoycrRhL1P0doyNl6zNkJirbqVsSLwMZg1jDWxh4PeDd+WYm7Q
         If59l6ZdeYnQO4DOzpsFFZJscQ65Dm3qXYAGwPHpg+58YkHz9jkFHb4EU9nEbT+uWdpJ
         fTCgi2PaLo1k+PrjzGsLprgw2f0r8a7pGpdYkGoGCyeSmh8AZ9Nza+p29WcugclFbysJ
         p4vA==
X-Forwarded-Encrypted: i=1; AJvYcCX014qoDxmyXmruivnJxW5rEgYwYIHA9lSvLxXqSocmkU/NwiIqQqO3/cCCQBkRH365BF7q4nooCvLelg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhpmRWuSgfI9gTVIrmH6okUrHmvO74U9izLaM9zeXtgfRdvrdQ
	H4+WTx4KWvDIBxcHgPLMrBsFULiXeZ7fmlCbycz34AlIQLf76gawHVGYvrw8iUvjAzj34Q3NUMg
	6Owjt4ueaqCypSzk/I+v0gP5HeTPvaW/pSM3Ft9Vk9ZSYXCfZ
X-Gm-Gg: ASbGnctsuuoUyeE3JcvohQ70JktOfq3Imwn9RAtHS7IX4zV8iPWP59VM6G6Hyd9iDhR
	5eiOYT4KtyqWinM4kd/aBwZsnQg1/aBvO7+OW/HI/MnzVfvKLXSJKytlz7w5T1ypv2UiwjJzgoI
	2S2ST+9OV2BDIX8qcyJzVkPoX9AwXaaDiGnXiQmX5ZeAS1NqMHRnAJk5PeLZyEdP+zzROvG7Xve
	UpaXOvAUpLH8TYYjCUH/THzyb/ZlSWe9subASKtnQHb7mAzswhwOjm03WLHMlwpavRyukJUKoKt
	emCQluBei5yZnewIWaa5a0eCMe4DeMc=
X-Google-Smtp-Source: AGHT+IF+wt7omECjRNA8ZF5D3kpt5IwxBzaeA/ZA+uoR1xjf+fIPCVfhy3mqd/MDvI+zI0cVt2yuGNYzGUtg
X-Received: by 2002:a05:6602:3a05:b0:85b:3f06:1fd4 with SMTP id ca18e2360f4ac-8617cbda0b6mr1702118339f.9.1744663479777;
        Mon, 14 Apr 2025 13:44:39 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-8616522dd82sm44514839f.3.2025.04.14.13.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:44:39 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 142813401C3;
	Mon, 14 Apr 2025 14:44:38 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 06295E402BD; Mon, 14 Apr 2025 14:44:38 -0600 (MDT)
Date: Mon, 14 Apr 2025 14:44:37 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 9/9] selftests: ublk: add generic_06 for covering fault
 inject
Message-ID: <Z/1ztR/DKOGgrdfW@dev-ushankar.dev.purestorage.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-10-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414112554.3025113-10-ming.lei@redhat.com>

On Mon, Apr 14, 2025 at 07:25:50PM +0800, Ming Lei wrote:
> From: Uday Shankar <ushankar@purestorage.com>
> 
> Add one simple fault inject target, and verify if it can be exited in
> expected period.

What "it" refers to is unclear. Maybe say "verify if an application
using ublk device sees an I/O error quickly after the ublk server dies?"

> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tools/testing/selftests/ublk/Makefile         |  4 +-
>  tools/testing/selftests/ublk/fault_inject.c   | 98 +++++++++++++++++++
>  tools/testing/selftests/ublk/kublk.c          |  3 +-
>  tools/testing/selftests/ublk/kublk.h          | 12 ++-
>  .../testing/selftests/ublk/test_generic_06.sh | 41 ++++++++
>  5 files changed, 155 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/ublk/fault_inject.c
>  create mode 100755 tools/testing/selftests/ublk/test_generic_06.sh
> 
> diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
> index dddc64036aa1..ec4624a283bc 100644
> --- a/tools/testing/selftests/ublk/Makefile
> +++ b/tools/testing/selftests/ublk/Makefile
> @@ -8,6 +8,7 @@ TEST_PROGS += test_generic_02.sh
>  TEST_PROGS += test_generic_03.sh
>  TEST_PROGS += test_generic_04.sh
>  TEST_PROGS += test_generic_05.sh
> +TEST_PROGS += test_generic_06.sh
>  
>  TEST_PROGS += test_null_01.sh
>  TEST_PROGS += test_null_02.sh
> @@ -31,7 +32,8 @@ TEST_GEN_PROGS_EXTENDED = kublk
>  
>  include ../lib.mk
>  
> -$(TEST_GEN_PROGS_EXTENDED): kublk.c null.c file_backed.c common.c stripe.c
> +$(TEST_GEN_PROGS_EXTENDED): kublk.c null.c file_backed.c common.c stripe.c \
> +	fault_inject.c
>  
>  check:
>  	shellcheck -x -f gcc *.sh
> diff --git a/tools/testing/selftests/ublk/fault_inject.c b/tools/testing/selftests/ublk/fault_inject.c
> new file mode 100644
> index 000000000000..94a8e729ba4c
> --- /dev/null
> +++ b/tools/testing/selftests/ublk/fault_inject.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Fault injection ublk target. Hack this up however you like for
> + * testing specific behaviors of ublk_drv. Currently is a null target
> + * with a configurable delay before completing each I/O. This delay can
> + * be used to test ublk_drv's handling of I/O outstanding to the ublk
> + * server when it dies.
> + */
> +
> +#include "kublk.h"
> +
> +static int ublk_fault_inject_tgt_init(const struct dev_ctx *ctx,
> +				      struct ublk_dev *dev)
> +{
> +	const struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
> +	unsigned long dev_size = 250UL << 30;
> +
> +	dev->tgt.dev_size = dev_size;
> +	dev->tgt.params = (struct ublk_params) {
> +		.types = UBLK_PARAM_TYPE_BASIC,
> +		.basic = {
> +			.logical_bs_shift	= 9,
> +			.physical_bs_shift	= 12,
> +			.io_opt_shift		= 12,
> +			.io_min_shift		= 9,
> +			.max_sectors		= info->max_io_buf_bytes >> 9,
> +			.dev_sectors		= dev_size >> 9,
> +		},
> +	};
> +
> +	dev->private_data = (void *)(unsigned long)(ctx->fault_inject.delay_us * 1000);
> +	return 0;
> +}
> +
> +static int ublk_fault_inject_queue_io(struct ublk_queue *q, int tag)
> +{
> +	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
> +	struct io_uring_sqe *sqe;
> +	struct __kernel_timespec ts = {
> +		.tv_nsec = (long long)q->dev->private_data,
> +	};
> +
> +	ublk_queue_alloc_sqes(q, &sqe, 1);
> +	io_uring_prep_timeout(sqe, &ts, 1, 0);
> +	sqe->user_data = build_user_data(tag, ublksrv_get_op(iod), 0, 1);
> +
> +	ublk_queued_tgt_io(q, tag, 1);
> +
> +	return 0;
> +}
> +
> +static void ublk_fault_inject_tgt_io_done(struct ublk_queue *q, int tag,
> +					  const struct io_uring_cqe *cqe)
> +{
> +	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
> +
> +	if (cqe->res != -ETIME)
> +		ublk_err("%s: unexpected cqe res %d\n", __func__, cqe->res);
> +
> +	if (ublk_completed_tgt_io(q, tag))
> +		ublk_complete_io(q, tag, iod->nr_sectors << 9);
> +	else
> +		ublk_err("%s: io not complete after 1 cqe\n", __func__);
> +}
> +
> +static void ublk_fault_inject_cmd_line(struct dev_ctx *ctx, int argc, char *argv[])
> +{
> +	static const struct option longopts[] = {
> +		{ "delay_us", 	1,	NULL,  0  },
> +		{ 0, 0, 0, 0 }
> +	};
> +	int option_idx, opt;
> +
> +	ctx->fault_inject.delay_us = 0;
> +	while ((opt = getopt_long(argc, argv, "",
> +				  longopts, &option_idx)) != -1) {
> +		switch (opt) {
> +		case 0:
> +			if (!strcmp(longopts[option_idx].name, "delay_us"))
> +				ctx->fault_inject.delay_us = strtoll(optarg, NULL, 10);
> +		}
> +	}
> +}
> +
> +static void ublk_fault_inject_usage(const struct ublk_tgt_ops *ops)
> +{
> +	printf("\tfault_inject: [--delay_us us (default 0)]\n");
> +}
> +
> +const struct ublk_tgt_ops fault_inject_tgt_ops = {
> +	.name = "fault_inject",
> +	.init_tgt = ublk_fault_inject_tgt_init,
> +	.queue_io = ublk_fault_inject_queue_io,
> +	.tgt_io_done = ublk_fault_inject_tgt_io_done,
> +	.parse_cmd_line = ublk_fault_inject_cmd_line,
> +	.usage = ublk_fault_inject_usage,
> +};
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
> index 0cd6dce3f303..759f06637146 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -12,6 +12,7 @@ static const struct ublk_tgt_ops *tgt_ops_list[] = {
>  	&null_tgt_ops,
>  	&loop_tgt_ops,
>  	&stripe_tgt_ops,
> +	&fault_inject_tgt_ops,
>  };
>  
>  static const struct ublk_tgt_ops *ublk_find_tgt(const char *name)
> @@ -1234,7 +1235,7 @@ static void __cmd_create_help(char *exe, bool recovery)
>  {
>  	int i;
>  
> -	printf("%s %s -t [null|loop|stripe] [-q nr_queues] [-d depth] [-n dev_id]\n",
> +	printf("%s %s -t [null|loop|stripe|fault_inject] [-q nr_queues] [-d depth] [-n dev_id]\n",
>  			exe, recovery ? "recover" : "add");
>  	printf("\t[--foreground] [--quiet] [-z] [--debug_mask mask] [-r 0|1 ] [-g 0|1]\n");
>  	printf("\t[-e 0|1 ] [-i 0|1]\n");
> diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
> index 3d2b9f14491c..29571eb296f1 100644
> --- a/tools/testing/selftests/ublk/kublk.h
> +++ b/tools/testing/selftests/ublk/kublk.h
> @@ -68,6 +68,11 @@ struct stripe_ctx {
>  	unsigned int    chunk_size;
>  };
>  
> +struct fault_inject_ctx {
> +	/* fault_inject */
> +	unsigned long   delay_us;
> +};
> +
>  struct dev_ctx {
>  	char tgt_type[16];
>  	unsigned long flags;
> @@ -81,6 +86,9 @@ struct dev_ctx {
>  	unsigned int	fg:1;
>  	unsigned int	recovery:1;
>  
> +	/* fault_inject */
> +	long long	delay_us;
> +
>  	int _evtfd;
>  	int _shmid;
>  
> @@ -88,7 +96,8 @@ struct dev_ctx {
>  	struct ublk_dev *shadow_dev;
>  
>  	union {
> -		struct stripe_ctx  stripe;
> +		struct stripe_ctx 	stripe;
> +		struct fault_inject_ctx fault_inject;
>  	};
>  };
>  
> @@ -384,6 +393,7 @@ static inline int ublk_queue_use_zc(const struct ublk_queue *q)
>  extern const struct ublk_tgt_ops null_tgt_ops;
>  extern const struct ublk_tgt_ops loop_tgt_ops;
>  extern const struct ublk_tgt_ops stripe_tgt_ops;
> +extern const struct ublk_tgt_ops fault_inject_tgt_ops;
>  
>  void backing_file_tgt_deinit(struct ublk_dev *dev);
>  int backing_file_tgt_init(struct ublk_dev *dev);
> diff --git a/tools/testing/selftests/ublk/test_generic_06.sh b/tools/testing/selftests/ublk/test_generic_06.sh
> new file mode 100755
> index 000000000000..b67230c42c84
> --- /dev/null
> +++ b/tools/testing/selftests/ublk/test_generic_06.sh
> @@ -0,0 +1,41 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> +
> +TID="generic_06"
> +ERR_CODE=0
> +
> +_prep_test "fault_inject" "fast cleanup when all I/Os of one hctx are in server"
> +
> +# configure ublk server to sleep 2s before completing each I/O
> +dev_id=$(_add_ublk_dev -t fault_inject -q 2 -d 1 --delay_us 2000000)
> +_check_add_dev $TID $?
> +
> +STARTTIME=${SECONDS}
> +
> +dd if=/dev/urandom of=/dev/ublkb${dev_id} oflag=direct bs=4k count=1 status=none > /dev/null 2>&1 &
> +dd_pid=$!
> +
> +__ublk_kill_daemon ${dev_id} "DEAD"
> +
> +wait $dd_pid
> +dd_exitcode=$?
> +
> +ENDTIME=${SECONDS}
> +ELAPSED=$(($ENDTIME - $STARTTIME))
> +
> +# assert that dd sees an error and exits quickly after ublk server is
> +# killed. previously this relied on seeing an I/O timeout and so would
> +# take ~30s
> +if [ $dd_exitcode -eq 0 ]; then
> +        echo "dd unexpectedly exited successfully!"
> +        ERR_CODE=255
> +fi
> +if [ $ELAPSED -ge 5 ]; then
> +        echo "dd took $ELAPSED seconds to exit (>= 5s tolerance)!"
> +        ERR_CODE=255
> +fi
> +
> +_cleanup_test "fault_inject"
> +_show_result $TID $ERR_CODE
> -- 
> 2.47.0
> 
