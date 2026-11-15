Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794709562;
	b=MOQYp6KBWALrlIVACCQ4USCUESBwQ427nd/t8vmz6P88KzYx6SUN8Rmgee+dNC9UZ557
	 X5/R31Q5ieB5LnWf3nOWhk5+yrEXabrMaQXwk1nX7n01XNwxKP8GHdnd5eGw7wUVtaAGk
	 /XPagQXv6igXI6LPVzCAHdhrwZYGOq8IcbAF5lBq+++j3ucFpVBFBYUnjxrdb/3A/NPoh
	 PVSiojjSjDsGNAGzx1nGMW+2T+vNYWrSiNxNqo+sf+5hpMKIhi0OsiyK0QY2e0/aNSZo2
	 Iwd1J8P2O/UdGApALkjUFyglfmTlbKi0W+LVuTSSyX5KaDAFVj3jtqi9en2u8t86+3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794709562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=XBDay+SoYcPU0sU6hc5PE3yhZdkJGrIdG29lu1ejOcI=;
	b=gPNaX79VM4/1z9EapLZj+vLbJYmaJlubtrnsjaPnZ5+CBO4jpP4jUZGeeugBdqMcIeEH
	 brvlIKQpP67Zoyga2LYxPOG39pszklY0CyOvoEUShMTRJ3VaA7qzJ4UkUObdHeGTiwEbV
	 Mm4HrBD0g5Zq8tvyQT15BNP0NqP2OP4S7REqxoNRaNHGSCh+qkjKyn2DJkEJCwtBbIaO2
	 tNgrc7uftAU9AtYidfFy+sDOnEEuextdtOGj/XYvdI4tlLxbtdJISZXA4PQGdl5AJZ456
	 /IXGLHjR3HJjYi8H6j0gkCe72qNcVAaG+gLX41Ftgw5tF3VGw+jwHG+TohHU11gsaSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YAhvBAWG;
	arc=none smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CAB606A327
	for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 02:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21CAB606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YAhvBAWG
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4adaa0f72abso3489803fac.1
        for <linux-block@vger.kernel.org>; Sat, 14 Nov 2026 18:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794709560; x=1795314360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XBDay+SoYcPU0sU6hc5PE3yhZdkJGrIdG29lu1ejOcI=;
        b=YAhvBAWG8Du5A9pBVS8Pf6w+YJzqdg9Hnb6F/P9/kFZvvnyfdLOX7dv7a6x1wOAk5b
         bzXtgzCGvQs2uOcfX4DUxwg6coPUo8bk3XrweOUVb5DPpGPIW8CHYNFU6aQGeJpFqB/M
         aTmjf3IIFXkc7QmOqBWoAY4Su00sqC8bX7KY9VUE9kfo7yx5/4GmS28P8soNhuJSs/Ge
         yi5KC5925r2tEpjZVzG6WTE5pREiBDcQ0+IlvOB4dr4jaSzj2g8U3gVzL8xgPN2hC63d
         ZzlflEQjfXEh4YXV5frS/7RIsEEznYMYdtg3JCeVQbeHlf3r4jtDKak1JIHRgFuGaUfS
         /p9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794709560; x=1795314360;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XBDay+SoYcPU0sU6hc5PE3yhZdkJGrIdG29lu1ejOcI=;
        b=ievcGdAeKpBSmidWL8DBPVhwqkgfetecvrWdlZEmhF0o/2eDDqoKoFJNZAYBw5VD87
         ohpOSg1I2r3OuMI/wDUKQfyjj3bF2N6nLhblFSMoJWunX+oZJnqbzdb6tym1JoXuWrQr
         D6p4HEMk952zPPbV4EFb04wh3XsiBbScqzc9t8EwfhCZsgRucHN9HBMhPNPHLCfXB0JA
         b7F3/qGAWd7QNyN0vmxCs8wgirFXPy/k/T3FzVdains0ZkxpzsmQJX8mZApTIUfCDgFf
         1A/PwzHsoAjTdKfy0M2KGOWb29hhH+D5CaoIrQwMtp9nStlP8EBk5t0yyeIkDJg5oGUm
         Q3mQ==
X-Forwarded-Encrypted: i=1; AL+hErGbFp7qSVO9IfWUvyheLuTfQcEcgBeWNAItgyo3gj5sm6qgkUXydLTK4IpC0kpR/wEquqlMQuvkJGkhrw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8oE+Q/cUzngZyhXpVLXpmHJDHQUP4oXgG2WDd1FHjE64dkUpfu
	R+8c88LQAPS1G/8BTRfvNR/42mI8o+YSyNWanZaiGa67FM+ZXrlnh43a
X-Gm-Gg: AYBFou32NinajvbBpaf9HggszJateOf/O8Qh4AV00pvjmW2jq0XOWxb4OOnG8l11Nss
	uwWYFfAnkPeQUs2P26DtrUDLYM0VSLG94NUyqDmP+5ZqMnBU4RqG84gEmtHSX5zfJwbDL9xIjEj
	YjR81lWSvBgIana+y3NdZFJBxtKPRVlrFZptOsKdhRxot3tPV1yKySyXj2MEah1IjO07LdFnJT/
	p/YiPcgdX3ruNGiDreYjIrZkgz7byLyA8l62IkxtI/U+8f7pSusZ9NspJPmrVAQq7BcLTc0RwCN
	sZ2r1LeecYE0NLRhgSSWfjCuPTMjqefV3T9rqYvdkdfCfRfaPmJBqEEpJjBTYkpEKSDZlWs/ufC
	Ny9G08JIwlJJ2e1okLjftTqnHRikSDgH7TfiZr9456uJh6RMDGwVF+CEfLbN0j8PwkIALx7t64i
	PQHBQp04Q8OphjQQORf/nGm0eka9wbnNCV/oiVCB4cADFMI68BVoGFX0KRAEpbKKmHVDHgbiDZU
	Fy8lQbxGzPhDHVs3iLag0hHLbxCmSEj42ZVEqcsaZNOLwTgdR5DEsiwnMe2wTkPMir9tp1qP1mZ
	FfG0gUt4XwsWDyUyTteIHCR17CG+YFUKz4wQtXyCPE0IwcyaeL0sfLGap2GS3zs+aeEF9NtKUUf
	LnIsQAzHtSgMQyo56IpxbYlOMU0x+Wugj
X-Received: by 2002:a05:6820:3419:10b0:6f8:51f5:b9af with SMTP id 006d021491bc7-71ab5108708mr2371012eaf.25.1794709559883;
        Sat, 14 Nov 2026 18:25:59 -0800 (PST)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ab3f44dc4sm5379466eaf.0.2026.11.14.18.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 18:25:59 -0800 (PST)
Date: Sat, 14 Nov 2026 20:25:52 -0600
From: Ming Lei <tom.leiming@gmail.com>
To: shao.mingyin@zte.com.cn
Cc: shuah@kernel.org, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/4] ublk: cancel commits arriving after the quiesce scan
Message-ID: <avkYMF-_bBaIfBly@fedora-laptop>
References: <202611112257529855AMDZLzg8ZmFDQ3fBstbi@zte.com.cn>
 <20261111225801025TKHDW7iZbMR4sFQAc8af5@zte.com.cn>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111225801025TKHDW7iZbMR4sFQAc8af5@zte.com.cn>

On Wed, Nov 11, 2026 at 10:58:01PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> QUIESCE_DEV marks the queues canceling and cancels pending commands.
> A server can still be processing an I/O when that scan passes its slot.
> If it submits COMMIT_AND_FETCH_REQ afterwards, the newly published
> command can remain queued without a future request to complete it.
> The server waits for that completion and the device remains LIVE.

The issue is real, and it can be reproduced without any test hook:

        kublk add -t fault_inject -q 1 -r 1 --delay_us 3000000
        dd if=/dev/zero of=/dev/ublkbN oflag=direct bs=4k count=1 &
        sleep 1
        kublk quiesce -n N

Without this patch the device stays LIVE after the delayed commit
lands; with it the device reaches QUIESCED. Please add this as a new
recovery selftest in v2, so the fix is covered.

> 
> Share the cancellation claim with the command handler and use it after
> processing a commit when the queue is canceling. The cancel lock and
> CANCELED flag ensure that the control path and command handler cannot
> complete the same command twice.

The commit log needs to cover a few more things:

1) ublk_cancel_cmd() refuses to cancel while the request of this tag is
started, and the new call site skips that check. With zero copy or auto
buffer registration the committed request may still be in flight when
the command is aborted here. I think it is safe, because ->canceling is
already set, so any new request on this tag is aborted in
ublk_queue_rq() and never dispatched to this slot, but please explain
that in the commit log.

2) If ublk_wait_for_idle_io() fails with -EBUSY or -EINTR, ->canceling
is left set and ublk_cancel_dev() isn't called. With this patch the
server gets UBLK_IO_RES_ABORT on its next commit even though QUIESCE_DEV
returned an error. That may be fine, but it is a behavior change and
should be documented.

3) The new check fires whenever ->canceling is set, not only for
QUIESCE_DEV, so the subject and commit log are narrower than the change.

> 
> Fixes: b465ae7b2524 ("ublk: add feature UBLK_F_QUIESCE")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> Tested on next-20261105 with CONFIG_BLK_DEV_UBLK=y in a local QEMU/KVM
> VM (4 vCPUs, 4 GiB), using real ublk devices and fio. A test-only server
> hook held one COMMIT across a successful quiesce, then released it.
> In two runs per version, the original kernel left the device LIVE until
> a second quiesce; the fixed kernel reached QUIESCED without that retry.
> The paired runs used the same userspace probe and no kernel diagnostics.
> 
> The four original recovery scripts also passed twice with this change
> and a separate batch SQE initialization fix, without C or driver
> diagnostic instrumentation or reduced fio load.
> 
>  drivers/block/ublk_drv.c |   40 ++++++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 3d322fa1b..082f105f1 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2792,14 +2792,33 @@ static void ublk_start_cancel(struct ublk_device *ub)
>  	ublk_put_disk(disk);
>  }
>  
> +static void ublk_complete_cancelled_cmd(struct ublk_queue *ubq,
> +					struct ublk_io *io,
> +					unsigned int issue_flags)


ublk_drv.c uses "canceled"/"canceling" everywhere, so please name it
ublk_complete_canceled_cmd().


> +{
> +	struct io_uring_cmd *cmd = NULL;
> +	bool done;
> +
> +	spin_lock(&ubq->cancel_lock);
> +	done = !!(io->flags & UBLK_IO_FLAG_CANCELED);
> +	if (!done) {
> +		io->flags |= UBLK_IO_FLAG_CANCELED;
> +		/* dependency ordered against smp_wmb() in ublk_prep_cancel() */
> +		cmd = READ_ONCE(io->cmd);
> +		io->cmd = NULL;
> +	}
> +	spin_unlock(&ubq->cancel_lock);
> +
> +	if (!done && cmd)
> +		io_uring_cmd_done(cmd, UBLK_IO_RES_ABORT, issue_flags);
> +}
> +
>  static void ublk_cancel_cmd(struct ublk_queue *ubq, u16 tag,
>  		unsigned int issue_flags)
>  {
>  	struct ublk_io *io = &ubq->ios[tag];
>  	struct ublk_device *ub = ubq->dev;
> -	struct io_uring_cmd *cmd = NULL;
>  	struct request *req;
> -	bool done;
>  
>  	if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
>  		return;
> @@ -2818,18 +2837,7 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, u16 tag,
>  	if (req && blk_mq_request_started(req) && req->tag == tag)
>  		return;
>  
> -	spin_lock(&ubq->cancel_lock);
> -	done = !!(io->flags & UBLK_IO_FLAG_CANCELED);
> -	if (!done) {
> -		io->flags |= UBLK_IO_FLAG_CANCELED;
> -		/* dependency ordered against smp_wmb() in ublk_prep_cancel() */
> -		cmd = READ_ONCE(io->cmd);
> -		io->cmd = NULL;
> -	}
> -	spin_unlock(&ubq->cancel_lock);
> -
> -	if (!done && cmd)
> -		io_uring_cmd_done(cmd, UBLK_IO_RES_ABORT, issue_flags);
> +	ublk_complete_cancelled_cmd(ubq, io, issue_flags);
>  }
>  
>  /*
> @@ -3560,6 +3568,10 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
>  			req->__sector = addr;
>  		if (compl)
>  			__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub), NULL);
> +
> +		/* Quiesce may have scanned this slot before this command arrived. */
> +		if (unlikely(READ_ONCE(ubq->canceling)))
> +			ublk_complete_cancelled_cmd(ubq, io, issue_flags);
>  		break;

io->cmd and UBLK_IO_FLAG_ACTIVE are stored here before ->canceling is
read, with no barrier in between, while the cancel scan tests
UBLK_IO_FLAG_ACTIVE locklessly after setting ->canceling. Either side
must see the other's store. That holds in practice because ->canceling
is set under blk_mq_quiesce_queue(), but please say so in the comment
instead of leaving it implicit.

>  	}
>  	case UBLK_IO_NEED_GET_DATA:

UBLK_IO_NEED_GET_DATA publishes io->cmd in the same way. If                                                                                                                                     
ublk_get_data() fails and falls back to requeue, the command is kept
active, and with ->canceling set the requeued request is aborted in
ublk_queue_rq(), so this command looks stranded just like the commit
case. I haven't reproduced that one; can you check, and cover it in v2
if so?

Thanks,
Ming
