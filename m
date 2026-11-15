Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794709751;
	b=z5zT8eXV+iOrjFX7DHmBwMATJbcdJTrLrBZs4U7+Kh+M5J2x3CUqTtMrjDWsi4+b9z5W
	 lOTHQGOynWzdqm2gxEheiyeOOHSigLKaaSk8xsvDrJrR8wGSSm45C+VB4X92ampsxNcn5
	 J617ZDWz1mRtnBgjEb+vbfjx6npDUXqSWsTC413Bm2Dt48zowH8UlLq3WeU2tUe8SFQzW
	 SdTf5e0JSsJ+CQDAMgOGFL9vwG6kRKL+17AfbJnkDbkBFvBnRTGtH19ynKMjMhfcqvzUG
	 4l8/iWDaFRFVKC9Y2E9UoxS4mN0jrDlx/OMzDEbA1mBs0sPmzMqze7ktHBpHF0N6oCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794709751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=7CDE5oldwyToxMIHZaDAAROi1zR3/FKKlLBPz1nWp5Y=;
	b=KkJy1LS3koxIcP02bNk9z13kP8sAT0Up8GajeV0RnZZqaBbskmkB/eQzHAO2QZuCG0VF
	 sTMiZ688tTFSiPCFOEwIv0o47k+634RimGhObVL1O2+nX1zmHo6kja1JPyAkTxY4Tjbpa
	 mz8vzxkK1rOp7HgNM/bMdyaCx/c/0Vr58l6FtHGuMj6eoJiJMiUWc/p366bNVF0ERTmhK
	 r1/NlOZrnoX37Hocb7u93YIBNGKf9yCm9nVL1YTVKegr2hSIPTi3Vv24ZqRjbY7mN1rYJ
	 4t8Xb6p5xH5+VRkwKw+28NQIoNCFQ/naNdUzift9xMwPpwnS3Cd+VY3oqFhUJLrOXRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T+tStDCN;
	arc=none smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12095606A327
	for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 02:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12095606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T+tStDCN
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4c5d8c7f326so756652b6e.1
        for <linux-block@vger.kernel.org>; Sat, 14 Nov 2026 18:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794709750; x=1795314550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7CDE5oldwyToxMIHZaDAAROi1zR3/FKKlLBPz1nWp5Y=;
        b=T+tStDCNHyTwpVrwpY/oHLqkXZxok0j3rwq91AyNE0mZPek6fIP8b13nuvhrJIUKa6
         ab1Kh/ROheDyxFbx5YhNLKdwQPpuAfv+em7i6tO8eNAGl4rztkwPSbCiHY6B1jVvXfoN
         o4lluGVK+4Gg/8XVtXotyh/feX3v1JHh0z566htkVAuSIMVyBSfBm6WImqIRC6OFv0u3
         yrccVrcpg2IHV66qfkIJs756YbNS7o9c7PTtu0upsnyijkhazliAemD6XeL00AaMJkFs
         JCgxOroc3w4Ddt4bs4GJPrf/PjeaJBWcSqLwS2ntKBZNgeCUIsnbhLPWh5bxnmBLox8V
         uRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794709750; x=1795314550;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7CDE5oldwyToxMIHZaDAAROi1zR3/FKKlLBPz1nWp5Y=;
        b=NPRSlit2ZE6mERMYdbqzV6GEjFL5SUKF/fKx4KGLSIeAzbZOvsvtowRKOSGYB+YIEJ
         ZanU87qqgb4rk7J0EXepCVjJpN12ifZrlCVybYWw272fTjRD7DX84TI006xnQ+bHbL/U
         pjfpxLVtHKcTkLAX+T09QntRD/qbLf2TLtktzS5nI9eh6hh6FfjU0otE6iiuI3g+NH3g
         EHZsE3n90P3PMGY/9yaC0loXgSOxcGQ68ayB4MmEC6K17SzUEv7AX63gfgdJ/SH49ZpU
         INC484NXcozYbKtsB/uTY8ajGKCVzKgMy56sK3yoxu6S2RmblYqHP38mSUfFVwFCr8oi
         mJOw==
X-Forwarded-Encrypted: i=1; AL+hErEmUT4xQLMkkUkyGNanOI1NsC27Ca86xhs2ylIhGJfjq5ajiNYBjWnNJh3JRYiysLCeiQkBjgJdErAloQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/LwXsv34NoIx7hH0+LUs7BG2lS3PCvsFU/6ktIANsiFdqBwyJa
	+UltKsvuPJBuXIm6G1THL3qHberjdA72T1RjzcHcMfMdhEf6Oqj7Wyd5
X-Gm-Gg: AYBFou0/EZvMP5MgPRSNI/jIZsd90baEX1bgMvzdTcckZBh5yVc06723fU/FTB/dncR
	FPQV151LN6B7ok6gTE9lsID3AxeyUpFNjgg1LIsN3tFE6XI0a/kf85VM74zLVDeIBP7QvqenAE4
	ZBF/6Vy/8xRY04QnF/1GGgmPg2BB8HVi2Ac6sXSCDQkvMGrG7oqeWyzBQMqF581U/7pA9s7fSVf
	Dk2Nnx8BW+CPNS4tSaVpiA0x11W1kS+cCHWCOZQFDn0emYrsHA1wQnolCgxA6uhj6dFBKq24PfA
	znsRsbA4/X8nCw7+fBRfno9dy9dtZCm8sfw22TybXY0j94m4dA9+rgkMXKiyXQChVZh3VYxV3B5
	bLT0heiBWFJG8AC4REv3LCU/kGBuE3WodTEkcpPYHALvbM1Mog7Ihv8H5iwDLGrSlsS+LW/gETQ
	3Gg2ARbzZL/cIe00HiFeYbaBgHL/x4PBqTftKXJUmDva1xVOjSvf2ax2iDanACPdFdvbPd25ko0
	yp5Fiamuh+vqLAWx6m24eJ0rWK6jdMTVq/Y/cV+BLwOPFlxSAeJ9lQMNol3ewbamZ/5R1VQlVrd
	/x1zOkxMmoPzfm9xvPA3xcUBhhUNuKFGp1L8DqRNLCV7zHe+Fnb5LUdOSlGvBqSpU6nvDVy1iHR
	VLrZfevmuOF+B/71t6Nv1zOruHNwxxaH8
X-Received: by 2002:a05:6808:14d2:b0:568:39f2:1254 with SMTP id 5614622812f47-56e64dfaba9mr5765056b6e.47.1794709750000;
        Sat, 14 Nov 2026 18:29:10 -0800 (PST)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e6fc412c6sm6246722b6e.4.2026.11.14.18.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 18:29:09 -0800 (PST)
Date: Sat, 14 Nov 2026 20:29:04 -0600
From: Ming Lei <tom.leiming@gmail.com>
To: shao.mingyin@zte.com.cn
Cc: shuah@kernel.org, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/4] selftests: ublk: clear reused batch SQE command flags
Message-ID: <avkY8Hy04c3QzXSv@fedora-laptop>
References: <202611112257529855AMDZLzg8ZmFDQ3fBstbi@zte.com.cn>
 <202611112258022807A4cJ4GoTzO_Q2qeMKeG1@zte.com.cn>
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
In-Reply-To: <202611112258022807A4cJ4GoTzO_Q2qeMKeG1@zte.com.cn>

On Wed, Nov 11, 2026 at 10:58:02PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> Batch FETCH commands set IORING_URING_CMD_MULTISHOT and select a buffer.
> When a SQE slot is reused for a PREP or COMMIT command, batch command
> initialization overwrites the SQE flags but leaves uring_cmd_flags set.
> The multishot flag then disagrees with buffer selection, so
> io_uring_cmd_prep() rejects the command with -EINVAL. The completion
> assertion aborts kublk, leaving a recovery device QUIESCED or its CLI
> waiting for a daemon notification that will never arrive.
> 
> Clear rw_flags when initializing a batch command. The FETCH path sets
> its multishot flag explicitly afterwards.
> 
> Fixes: cb5a6b308700 ("selftests: ublk: handle UBLK_U_IO_FETCH_IO_CMDS")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> Tested on next-20261105 with CONFIG_BLK_DEV_UBLK=y in a local QEMU/KVM
> VM (4 vCPUs, 4 GiB), using real kublk and fio. With the same diagnostic
> kernel and batch null workload, the original binary received -EINVAL
> for a multishot COMMIT without buffer selection and its daemon exited,
> leaving the device QUIESCED. With this change the daemon remained alive
> and the device stayed LIVE before deliberate device deletion.
> 
> The four recovery scripts also passed twice with this change and a
> separate fix for commits arriving after the quiesce cancellation scan.
> 
>  tools/testing/selftests/ublk/batch.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/ublk/batch.c b/tools/testing/selftests/ublk/batch.c
> index 625a9c32a..fcab2ca9e 100644
> --- a/tools/testing/selftests/ublk/batch.c
> +++ b/tools/testing/selftests/ublk/batch.c
> @@ -241,6 +241,7 @@ static void ublk_init_batch_cmd(struct ublk_thread *t, __u16 q_id,
>  
>  	sqe->fd	= 0;	/* dev->fds[0] */
>  	sqe->opcode	= IORING_OP_URING_CMD;
> +	sqe->rw_flags	= 0;

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming
