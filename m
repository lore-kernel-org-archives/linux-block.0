Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795430881;
	b=pkKOygsrOz5/zDK1nxqLRiq2JXGnE2lVgYi24p1nNjM1c8TcYNc91/8/wtHJLl7txvzD
	 1OAjZxoYCzKkHx2n10BYZm9HVg3NL3HJnAyEtkZYs2lpBj7wKDikLfjz5AbG+GYr+GqS0
	 7GL3ymP7l3m1k3Hm84zFU6TClPCcCl422QUfE/UlkrnPVbX6v1hHyjVxMib/tbOG7laFK
	 bCjZr8mvvAfpyK1yJ4IVimtSLRWbYiAQsR3S+W12DUpO4GRAQd3kU2GzKDiifFUQtjVBr
	 fxAwceDEh3ZEBDEd3rAIov6QHDilO/MM9b2JZ188CJ9hC789roann7k6BlGw+1Wgpsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HvoT7Anl9hphNmVfzcXuCYVLME3jPhO7743SpeB5e/o=;
	b=Lb1f/xTWebWCdthP4+4qyOzJNoZ4beWdlmELW39VnTVEELfKKvKY1yk/C4BTDTKwe35C
	 XpHmKwqHFbUUdYsCS7BvCIqD9by/drfSn92aCuKI1UxRr5YYef6/Vmh5eRQjvBa4ySCHa
	 Um3SD+e6MvVbPqqFCdusZYyoM85mdsKf071cEGqrmuwy715+DKXT45MdFATp0sDxc28x9
	 BVeTKeq6DvkzQH8jc56gJA6HX5SFexOIxKVT92rc7F5eFBaq2LCU7mznpHqf1eIw/PWtD
	 /V55bLVeUgeYbjhVM67z1OQthvfts/nG4CtRUzRkrTr4/Cv6Z0m3f6CNO5B3/ggGJkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=EzvkQHYQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1832606A332
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 10:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1832606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=EzvkQHYQ
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c50a4a2132cso433865766b.3
        for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 02:48:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795430879; cv=none;
        d=google.com; s=arc-20260327;
        b=kOci/mHANyt2jLm2X+4qMnp1qK9y4XW29C5pMim9mAXxqgY3ID7eiimwnjySw/wRI2
         z2Z84Rsps9fmMCXW9pEKB9CfPWFzFk5oIYhjJpCIF7UuWwwfmooTJYj+ZN+FZ5D/eY+5
         /NmNqw+qvjsDfgeY3myF3sh4d9Bk/kzz50BShcwOYvI4Vt/06n9xYpehysyTd9Kf5tn+
         PpJLvCbkF5EX9ctuPDx0WX2i/dis8LWz9NdCO3HlI+ZJKoYGqCKGdSA25tlxTNznZiaj
         8t/OyKw9Zx1M/vPQAvtOtkTx8D50GKy9EF4atGZPIbGt8IxHti1CVgX5w2LbdG4t1Zae
         yFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HvoT7Anl9hphNmVfzcXuCYVLME3jPhO7743SpeB5e/o=;
        fh=9mRGX81ivVDqPhffF9ocr1b5j/E8ZOHuweh4XpccFAo=;
        b=TFDdFwFLXk1qd0c71vWYSlsK5Ezi0FNKOiTzM3AFDZ9sVZDPe3zKjIikKC6pxpfB6A
         hK7dlL/uxmcZ9B4fnYowjIUqBkeSgsxzVuC0PT21fhpufYos49+Jla6xO9tSklb6NZ5x
         S6ykLH3pxqZ/3VZszTDdkbRz+W4Vaog4BaI8TQvkMKQC7HZhAUA8rLF4fFcN2kUuG1mT
         Ln4Xe+J7uFDkvbh+oxqUG5Ru/w9nfKMH/GOOsfoFkGcQkykEAaCPrxpD9pv4Ca0sPrL5
         0JvdnZw5U9hOJ3AvavgffBctIOtWL/pngvdohpJr9pcWMc8VOWpkiOEAFeZYmCMVAyTD
         VtGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795430879; x=1796035679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HvoT7Anl9hphNmVfzcXuCYVLME3jPhO7743SpeB5e/o=;
        b=EzvkQHYQol/Cq4j4qvyk4vT5eoqfh3xOMREdIutC7U43kJ7WlRjGjF1QiKiIeZJhhT
         64/scM0R5jqI4nP3Cl7VAamQcExdSP4wQZWh+dmW2P/DvguXnTf+dVwIhv6KUwoyuYDv
         hpDsMHO1YE7d7nmO5Z/5Wy7oLFz9SAwph9v0R49R+NWbwEzOp8qWwZLPgXOxijnOg4Om
         Pzawc3hy7N+Qzj5xWP1ar97rK9hEBX8dCLPDYqP/gFaUiFVS4LqiH5c1Eair1rnX4pBs
         XJJdXJJetOW9jxQ/fGnl7WiQGdZKrvqKFqzQpnbCEHv3DLTiQrdJvARCD6DRK88dZHt3
         3Xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795430879; x=1796035679;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HvoT7Anl9hphNmVfzcXuCYVLME3jPhO7743SpeB5e/o=;
        b=c4nyvTlMYsYMaTIQFCUtFQEPaEwDsN+5fVZLkNz6C0CXtklMoODWf8/EoNHwZLRGjP
         2ubavz2DU5xSmjwWdl0m7lwzpHueE6kGGPJd2n0x+OU3Dc0QZSdQtTdD/jcX44NBciP5
         bjXQs10nTHzz8dW3F91J0j6m2Gk8fAVgxDTCrBN73/m/HWWRlXXhx3zdwkLHLYSKd0yu
         uYpxYDXpDU1SID/XX8ilWSrfeKJ8+sJxDEaFsRCHnomtUc5lIR4GeXg8dqAmUWVFgWPY
         QlxTTuVeO24z0MUjtc5eq4bXucLYk12iFuX7w6WbmF5B3tyQzY/OAcd8En2GVyr3Equ9
         CZvQ==
X-Forwarded-Encrypted: i=1; AL+hErG06vqcPD+f4yLDTvSEzNW/zDOCHAVIgJrrKdQmeOWJrSVeYVEtxz1JmeQOk18UR1kYA6LF+7QKwHzzdg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8oeu6jcrESWfobCVmfmWYS9PHFXDv9fxg69KbrGs3TlxJBi3yr
	YURAalfuNcrmkdWK1wE/weyip4VkAeNgkbYFxBsnmi/wiAeuGEw24hfUSyl9StkOf6vpzEdTHRU
	h0rF4XLWpVIqq5Uz63PYLycQv4SKR2BCymqBF0MyPDA==
X-Gm-Gg: AZFdTZdzZfJW28iQJ25HSwHl7bfQO35UH3E20apUKUp0Pjt9TqxbqtWR9i8Z5hzLHJG
	EOyWsyaPracg/CFqv6c1YOxH/SrOPipYavZwRHoBiLNiOyGfAEB/A282KvdyBZiE3UY2aqu80wb
	hcgGGOwBAvZOOAad17jCe3Ey+j1XiliTk0vxIJu/Ke0plxQSAA/Tj6LknTrsBN9BPOjo3qPDKZr
	VdGg0pn5Sdu9fty8piTMKQKRbV4GBbOwKZILiRKmYQLjq/Ff0FQvAzIruOF9z09kdjZQx7k6I7q
	J0TC1lmfelAdnbstGZeJzc3wHz5g0BRYQrSNt/UXxm3B8OAJODLfxuN7KW5C8hkuC+8Lq9d0hRr
	UvYymTdoXersx3aHNsOFFpQLDw2KReQijCTosMu+p4MjLOzy6Vkg+5NqRkXVMbBmIyqw7rw==
X-Received: by 2002:a17:906:1304:b0:c4d:212a:192a with SMTP id
 a640c23a62f3a-c513acaff9fmr662453266b.48.1795430879222; Mon, 23 Nov 2026
 02:47:59 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121235203.811792-1-atomlin@atomlin.com>
In-Reply-To: <20261121235203.811792-1-atomlin@atomlin.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 23 Nov 2026 11:47:47 +0100
X-Gm-Features: Aa3M54oo137bS41nML-swPW4_-JFZpCl2eqix2NZRtkklgargqyy1BBEeTkW998
Message-ID: <CAAofZF5D+ycbtMxsnUgZjhUbfD+_ZD6kYyci95OTdXug_aw-dQ@mail.gmail.com>
Subject: Re: [PATCH v5] blk-mq: dispatch kworker to housekeeping CPU when hctx
 cpumask is empty
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, tom.leiming@gmail.com, hare@suse.de, dwagner@suse.de, 
	emilne@redhat.com, frederic@kernel.org, tj@kernel.org, sean@ashe.io, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aaron,

On Sun, Nov 22, 2026 at 12:52=E2=80=AFAM Aaron Tomlin <atomlin@atomlin.com>=
 wrote:
>
> [...] In real-time environments, an active SCHED_FIFO workload will
> starve this SCHED_NORMAL worker and stall hardware dispatch, whilst also
> introducing unwanted latency jitter on nohz_full cores, defeating that
> commit's original objective.

I would phrase this differently. cpu_is_isolated() checks HK_TYPE_DOMAIN,
so the jitter argument holds only when the nohz_full CPU is also
domain isolated (isolcpus=3Ddomain or an isolated cpuset partition). With
nohz_full alone, or isolcpus=3Dnohz without domain, this patch does not
apply and the behavior is unchanged.

> +static inline int blk_mq_hctx_unbound_cpu(void)
> +{
> +#ifdef CONFIG_CPU_ISOLATION
> +       if (static_branch_unlikely(&housekeeping_overridden)) {
> +               int cpu;
> +
> +               guard(preempt)();
> +               if (!cpu_is_isolated(raw_smp_processor_id()))
> +                       return WORK_CPU_UNBOUND;

Since preemption is disabled by guard(preempt)(), you can use
smp_processor_id() here instead of raw_smp_processor_id().

Thanks!

--=20

Marco Crivellari

SUSE Labs
