Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723053064B8
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763991537; cv=none; b=DAts7WNyS/LvWNSu7aqgOKDGU/tVGEj2Ej3nAM6f6NAnpExofGPGepHWjNQHpblwAE3YUIJnZityeGG69JO8lgvDxxOnGtUq6kheYy5Qb4gIHGKWy9JgyDl92P64kJytay/SUdgS7mOWFPfl7ESDNqPlF1yamX/x0gKhDKhhc2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763991537; c=relaxed/simple;
	bh=hFssPJTM7dfkeo3nvA01t4OSU6WT4LDzj+frYOuLW9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjE9sFrCmLLSWMSCZOZpsXI/NDavcNKiR6aezRuuc0dT0gIW3WuCLjDPtLyfBUjbdS00mD6LQRfJF3GrZq+0UNIprmI3Y4/Rrr6Co+YIhajN9BkzCUYzn26t1O3nT944kLNj3Kd99pzV95bEZGTxzMIAD3DsQ6x9y4NsI+Zk07o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Os99fXi/; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Os99fXi/"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso197147a12.0
        for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 05:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763991534; x=1764596334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fGnf1zvNYnk55vDoYwHQmt5WFO2pnbA0Jle9HXGkL5k=;
        b=Os99fXi/P5CtZqR0D3ax0akt+Gp2AWkUY8AfW1xNYM3Z26PGCN2nf6zaAjKy/Ikd8d
         Qntn5kv6SU1FT40UgPr8zjJzkyV8h8MLTGyNwIRLmhOq4ww4rVliyKsDTmLpP2YTgbJ9
         OgxGJptnmlRfQ7plwEN0TMg4/kDuvtseCKxW311HD+6vHq6yFn8OkOPag8Uy4U88YNXb
         TMZzomQujHkv6vZi1yL80iDMicSrsGT3c0GAlAH2iCLY0mEpkCARFupuwPF1jx2qyQj7
         SPrUm8JCnGMgkeTABaMj+nI1buehfnfBxXcCAyP6BxzmauWDRi7bB0H53rHOpLBbPEUN
         K6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763991534; x=1764596334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGnf1zvNYnk55vDoYwHQmt5WFO2pnbA0Jle9HXGkL5k=;
        b=mwpyVWUxX/hDLYtZ0wEm2MWko/7wkvXWOU+ppw6DZRwnFGVLz2agvAdgvS8bmZThl/
         2z1DT3CTfGCDAoJYeP1mKmma5Qhc8hFcIgyt5TSww/UAN8THtMmeozEJ0OzGxJXrANRC
         N+kjW0E/Rh1ZY+ApUdgA3N0OqDAcduTDvyh/l9StN6XAuAxkZTgektlpqY93/TSed2ij
         PUQXtfbU5+zGGiI3BaZFLfKQ3MJpVWaKPBWudQCN9USbr77eWfR6nFTeTHPkzAP2gQtl
         btsCbroFHuSEzO9mAW/TW9RUQ8Lf3wA1pzjhiyPCrQVTT/I34NTatFO/bzL3Z65tbXu2
         yHLA==
X-Gm-Message-State: AOJu0Ywb/s4JHmSoTBwAtoZ26ErLg3kCXakRBJT2fAuCgfTCEVeijup9
	qfNJ31VpTzTq4fHlwk0XvOU8m1Q6mWPAfiXKcZyR4tzeaLbeJrhmouKyqzUY2CyfOVYpBMk3TMx
	YUndG0Oq4EEmnz//W+xrp6ldDGLEO2A==
X-Gm-Gg: ASbGncv2UEPW5f/ANOIX3JzKnobMCWCZ1MBBgOKdf3HGQv6z+r3SEHfImGvuS+YMfvX
	BzzCFLKfH+ckLmNxwBV8vtUAW8P+VQBJ2l/nMd2yhWJH9uF14jqJHIRTgJVPXg6IDlZr95apf06
	KnDVaQT3/GwnrCAoAsx7fItrzLmzXkWBry/rqD8RwoHwuGoD4GA9qjo4gLxNQlhG9Dd6I1hUkky
	fByRjOUeBEuOM58c27gmeku3WK1bpyEWjJvHPkHcEjTdd3c9/4ksNQPkNSZMiDq1YVpUDgya/4k
	e7YEWgHb34mSZLj9w2sgWIsZemVsxtPAW/NCPVkVUWTr7faTdjIkw+xPy0IHnAMShns=
X-Google-Smtp-Source: AGHT+IEIrrPvcFC3+rTLrgAPrW5zl0/cNdfSGGH+WdJU8CBkNncTEWdpxNp4QGdNjnbB8MXP5BRq+4un+OL6bxIbhcQ=
X-Received: by 2002:aa7:d814:0:b0:640:93ea:8ff3 with SMTP id
 4fb4d7f45d1cf-6453969fc53mr9852940a12.13.1763991533736; Mon, 24 Nov 2025
 05:38:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763725387.git.asml.silence@gmail.com> <51cddd97b31d80ec8842a88b9f3c9881419e8a7b.1763725387.git.asml.silence@gmail.com>
In-Reply-To: <51cddd97b31d80ec8842a88b9f3c9881419e8a7b.1763725387.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 24 Nov 2025 19:08:16 +0530
X-Gm-Features: AWmQ_bnDcYvcgkdgCo-kXgELlQbBhcvXrCXwL82qa0EngBmCaaIoNiIBz4Az0nk
Message-ID: <CACzX3As+CR4K+Vxm2izYYTGNo1DezNcVwjehOmFjxTqaqLrDGw@mail.gmail.com>
Subject: Re: [RFC v2 05/11] block: add infra to handle dmabuf tokens
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"

> +void blk_mq_dma_map_move_notify(struct blk_mq_dma_token *token)
> +{
> +       blk_mq_dma_map_remove(token);
> +}
this needs to be exported as it is referenced from the nvme-pci driver,
otherwise we get a build error
