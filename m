Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F88C433FE
	for <linux-block@archiver.kernel.org>; Fri, 14 Oct 2022 16:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJNQY0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Oct 2022 12:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiJNQYY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Oct 2022 12:24:24 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D5241D3A4F
        for <linux-block@vger.kernel.org>; Fri, 14 Oct 2022 09:24:24 -0700 (PDT)
Received: from pwmachine.localnet (85-170-37-190.rev.numericable.fr [85.170.37.190])
        by linux.microsoft.com (Postfix) with ESMTPSA id 170F320F32DC;
        Fri, 14 Oct 2022 09:24:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 170F320F32DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1665764664;
        bh=0duHXehrvqnLR/0zgXOclz4VUHEzguBRni2O8VtDkaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FPoLZzotCbN7JawLH9RlfzEeFcCFVzqh7jG+Ya7FAtm6W8naW9P6q2K0b/ayDRin9
         10xl4Fy6TN/mFXXOgyJ324PnpoyuxOPckPplVLJ1Y2WRSpCCLAGoP52RiUPP5MPPFU
         gy/l/KfY4O8zFbWuCqxJhu+MOiBxr38rq9jZYGYY=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk, rostedt@goodmis.org,
        Hengqi Chen <hengqi.chen@gmail.com>
Cc:     hengqi.chen@gmail.com
Subject: Re: [PATCH] block: introduce block_io_start/block_io_done tracepoints
Date:   Fri, 14 Oct 2022 18:24:20 +0200
Message-ID: <4433439.LvFx2qVVIh@pwmachine>
In-Reply-To: <20221014100111.1706363-1-hengqi.chen@gmail.com>
References: <20221014100111.1706363-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi.


Le vendredi 14 octobre 2022, 12:01:11 CEST Hengqi Chen a =E9crit :
> Currently, several BCC ([0]) tools (biosnoop/biostacks/biotop) use
> kprobes to blk_account_io_start/blk_account_io_done to implement
> their functionalities. This is fragile because the target kernel
> functions may be renamed ([1]) or inlined ([2]). So introduces two
> new tracepoints for such use cases.

Thank you for working on this, I was able to build a kernel with your patch=
=20
and successfully tested it:
root@vm-amd64:~# uname -a
Linux vm-amd64 6.0.0-rc4-00001-g89f38605b66b #95 SMP PREEMPT_DYNAMIC Fri Oc=
t=20
14 18:03:58 CEST 2022 x86_64 GNU/Linux
root@vm-amd64:~# perf_5.10 record -e block:block_io_done -e=20
block:block_io_start -a dd if=3D/dev/zero of=3Dfoo count=3D100
=2E..
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.083 MB perf.data (1 samples) ]
root@vm-amd64:~# perf_5.10 script                                          =
   =20
              dd   313 [000]   273.355898: block:block_io_start: 8,0 W 5324=
8=20
()>
         swapper     0 [000]   273.357048:  block:block_io_done: 8,0 W 0 ()=
=20
484>

So, I can offer you this:
Tested-by: Francis Laniel <flaniel@linux.microsoft.com>

>   [0]: https://github.com/iovisor/bcc
>   [0]: https://github.com/iovisor/bcc/issues/3954
>   [1]: https://github.com/iovisor/bcc/issues/4261

One small nit:
[0]: https://github.com/iovisor/bcc
[1]: https://github.com/iovisor/bcc/issues/3954
[2]: https://github.com/iovisor/bcc/issues/4261

>=20
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  block/blk-mq.c               |  4 ++++
>  include/trace/events/block.h | 27 ++++++++++++++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c96c8c4f751b..3777f486a365 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -887,6 +887,8 @@ static void __blk_account_io_done(struct request *req,
> u64 now)
>=20
>  static inline void blk_account_io_done(struct request *req, u64 now)
>  {
> +	trace_block_io_done(req);
> +
>  	/*
>  	 * Account IO completion.  flush_rq isn't accounted as a
>  	 * normal IO on queueing nor completion.  Accounting the
> @@ -917,6 +919,8 @@ static void __blk_account_io_start(struct request *rq)
>=20
>  static inline void blk_account_io_start(struct request *req)
>  {
> +	trace_block_io_start(req);
> +
>  	if (blk_do_io_stat(req))
>  		__blk_account_io_start(req);
>  }
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index 7f4dfbdf12a6..65c4cb224736 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h
> @@ -245,6 +245,32 @@ DEFINE_EVENT(block_rq, block_rq_merge,
>  	TP_ARGS(rq)
>  );
>=20
> +/**
> + * block_io_start - insert a request for execution
> + * @rq: block IO operation request
> + *
> + * Called when block operation request @rq is queued for execution
> + */
> +DEFINE_EVENT(block_rq, block_io_start,
> +
> +	TP_PROTO(struct request *rq),
> +
> +	TP_ARGS(rq)
> +);
> +
> +/**
> + * block_io_done - block IO operation request completed
> + * @rq: block IO operation request
> + *
> + * Called when block operation request @rq is completed
> + */
> +DEFINE_EVENT(block_rq, block_io_done,
> +
> +	TP_PROTO(struct request *rq),
> +
> +	TP_ARGS(rq)
> +);
> +
>  /**
>   * block_bio_complete - completed all work on the block operation
>   * @q: queue holding the block operation
> @@ -556,4 +582,3 @@ TRACE_EVENT(block_rq_remap,
>=20
>  /* This part must be outside protection */
>  #include <trace/define_trace.h>
> -


Best regards.


