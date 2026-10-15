Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD7C598BE8
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096474; cv=none; b=HxyFfXTNPx9mIZFKKvWpiHt4jHDjkAtISSax7cc/sHQefvbJqSJULaQeheXBv3XSw6tCon29ohXG5b9NYysYOCjys60y3C+azDXobisEHifCvXRc0f6lT89EIj5Pym1h9pI3eUrZ2aVoQb+Qy4LhSn4oxyAv2w2wegONi5J569c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096474; c=relaxed/simple;
	bh=qWzTRRFlBrjKxhqo/bIT5/vkMosLcfmvltWqBsG2ARo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O8LAEPCfaQ/ETZpBCgoLAPVmvkOhwZgQ0PLCeNwkDmq6sJUbMNMU/t/oeyEQJuAjmrjPq9ddnvTZALci7qdj0Sbrm12LkMU+0Lv7VJkp134rt+/DOIGzP/NzhiNBxbWpittLKmY/jmlWlGo9b0+U2Rte+eFkBng5+iqlk6xOvfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=wRdyCTqn; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="wRdyCTqn"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4f59ea27bd0so2047058b6e.0
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 13:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792096472; x=1792701272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BZVnmfGOWMEQB6LCOpiT/03uLBXyo08m720hSCcSffQ=;
        b=wRdyCTqnheLsMAiS31O6SPFMMzaOLlU40iJ+4X7qvhemaBh6pnOQvZhFKksnNuvNcS
         Y1Qhenkkn3cQ//ZfQIJYlAGjnDgj+FUKXiWHNXMzrQZI5YLIX2rLNtD/KeMwLNsu/Ip2
         qNZ/dsJeRvbvq4z5hI1M+Ps04lAdN5Xbl5Gsc71XypIA1yfcJPXRBfNUMJ/GPt26daRG
         5XMayzavh3jS+72LkVG/bGFkgqeqYFO8I7lNdexmDoQSQk1sZy+gIMZvngZH6uzf4L4E
         4TudvkjHdNbtnfaH03tsnApSdds4XVIzfL70nNzeZBRHw5WMKIac+JM9xbNu5hONS4VY
         ncvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792096472; x=1792701272;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BZVnmfGOWMEQB6LCOpiT/03uLBXyo08m720hSCcSffQ=;
        b=ozli/kjvRk4ftn0KYzPMmVSKsQ1hrFpYy55c0OIPd0ldgKhxpDnClztZbrjwyNbVwE
         LSrpdUm5MTgHMAFzzckK2Wh/czPEBBQqoBY/tqoCG8aqZkB91UXd5x84q0HvuwZvVL96
         zhrmiUIBMM6koTOF6aLOEr2FIpJj7rgZLbGlnc1D77Orsv6WFwmd7Kk+pzLQ54phHj1V
         5nJ7qFPyCnPGP3NZaGf7DqgLrtAkR3e29z6u9wuqA78Yht9cWPKF9dx2IFssWn5F7cBI
         FywlJtOoSc+Zb2xmFjbC0vV8s7e9xlAVvyABE+YF+/vbI3/qWE6rgbIxkZAKJAaABoab
         SSPw==
X-Gm-Message-State: AFq9FYJcFlvvRy0oQ8DVSkDQXoOuM14L6QMRVVMjspBG81NmNLlWhA3W
	QAwpG5V4a7pQMXW0phjkH5C6KAyWRAI7koKEqbfTdVVxKkvTsjPQWXoPrmTs+SjiD4k=
X-Gm-Gg: AYBFou0LbfBvi7MInRXO/8BFjuLhhSMeK9SLgbBfCQiz92VZqhOkT6lHFR4eQIlBrZd
	PNiOSaGU7JsO+GOE2jDKvHlv8xGn8DmTR3z7/pIcIgIo2abiXjYiMMVM0BJ0vUpsnR/dVY+F8Cc
	tSFeMebpz0e75XGSzOLR4/TAbpHtwETaIssl1CiFE4zJ0W89ZV6mdEhYWA8JZbJ/7fQzSCebzp+
	vcO+GdTBPwDtfKTYitMDjKp6iiK7z9yIROMxdSkigJROb2vDag1E3cnBfO922LT1yA0Hi42Nx7O
	3Ro8rtCY53Z75bku9QrzogebHyqWc6Ii+ErmDgPNRgdw/Eh3nfC7LGFsoiq/wyUAOLD5myczLw2
	9HEps7SJcsksiFXGTyQ03Z8/3u19Izgw4HjMMsYgQWc64+MMNSn7uQF4knwgWiZawcLyTE43kln
	OFbfxSWLupEDkeD/LftNC0IJjn2lF5kFaQerPlJR9O3IhwHvS0xaC8v0pOdanzceJiHwNdtFPo2
	e2hL/UQFKh4iHAI3CAXL5cngNtBIWFeed/DT6yvvlvK7hpzs/pm048eO4x15gfBNCZi
X-Received: by 2002:a05:6808:3510:b0:4c4:9f7e:92ce with SMTP id 5614622812f47-50c5464570dmr18523514b6e.38.1792096471991;
        Thu, 15 Oct 2026 13:34:31 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-537b6f5169csm350539b6e.15.2026.10.15.13.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:34:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>, 
 Paolo Bertinetti <paolobertinetti200f4@proton.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+b48868c46e62c1c4cb2c@syzkaller.appspotmail.com, 
 syzkaller-bugs@googlegroups.com
In-Reply-To: <179010105967.8478.2344875677216734809@proton.me>
References: <179010105967.8478.2344875677216734809@proton.me>
Subject: Re: [PATCH] ublk: hold RCU read lock in ublk_try_buf_match()
Message-Id: <179209646794.1861240.13664201337469739319.b4-ty@b4>
Date: Thu, 15 Oct 2026 14:34:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 22 Sep 2026 18:17:43 +0000, Paolo Bertinetti wrote:
> syzbot reports a lockdep splat when I/O is dispatched to a ublk device
> with UBLK_F_SHMEM_ZC enabled:
> 
>   WARNING: suspicious RCU usage
>   lib/maple_tree.c:720 suspicious rcu_dereference_check() usage!
>   ...
>   Call Trace:
>    mas_root lib/maple_tree.c:720 [inline]
>    mas_start+0x3cc/0x640 lib/maple_tree.c:1250
>    mas_state_walk lib/maple_tree.c:3006 [inline]
>    mas_walk+0x1db/0x490 lib/maple_tree.c:4458
>    ublk_try_buf_match drivers/block/ublk_drv.c:5639 [inline]
>    ublk_init_iod+0x5d2/0x1120 drivers/block/ublk_drv.c:521
>    ublk_dispatch_req+0x97/0x9c0 drivers/block/ublk_drv.c:1776
>    tctx_task_work_run+0x73d/0xa80 io_uring/tw.c:96
> 
> [...]

Applied, thanks!

[1/1] ublk: hold RCU read lock in ublk_try_buf_match()
      commit: aaf49023041bc1f887a028a164d3bac714b65508

Best regards,
-- 
Jens Axboe



