Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792555848;
	b=wlBWMsB8UmLrZqRofOOtslwTf606pvkWizMsg3UfsAURo3T6nvbcBHcM53cse2puAzNa
	 nrrH1wvVdxcpWYkGnMSfw5u+Pv5mIS9fL9i/Ts5/UZyoWoAcCJcX0lv629YS+M0A4wOdV
	 e4gOrmx8pnyuLfAbsYG7rPdW4GQd+VuxXKwaAvHsx/fbixpYMgZRatXc419XAp1qOAaiL
	 EVirYUJo97MELGK2VDlwoEMieBgNi3u4tsl5AuVWwro/PLpWmcJfzcKD1d3Rlc81R1aho
	 KIOx1NN6aD2Qpel3UyXRGoYyEc66JpvuPEMIxy43jz3P4hb0810ACfxObpX2O4zLv5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792555848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oGhvDxI3zW4RDmWwBNExt8CDr9PPRQWD4dlxrwabZRw=;
	b=fkxf0hpcYnW5/ArlL1xQLDSKDiYhnFxBzJQDZ3fSQshgMiEhja1dklQ/O4e8dlkvW16a
	 iYeItS3KR1m4VgObuVot+0IttGKYurL9cXJg4oMChb1KY5MVBiftMBAEgg4l0bXI15L3D
	 N3HDzhkWmuLOC7aLRL2+lndOGtMvlEKpwANouDpsMYl+pcco01ntIqyaMM0wToIOK3Ke8
	 BId85IhheC7kourjbA1/jwUfemk6MnZl3vQeikpgp8DecjD7gioue3MWkDPl5zt1plLxt
	 et2sdlCCDGM902G2HzF+Zs6qCw7UbI1GrF+ePDk/O3GCJoYijWezKdCAhO3EqTyP1NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U7r8awW4;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9A9606A31C
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 04:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A9A9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U7r8awW4
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f3c8958d5so36276085a.2
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 21:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792555847; x=1793160647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oGhvDxI3zW4RDmWwBNExt8CDr9PPRQWD4dlxrwabZRw=;
        b=U7r8awW4d7wFmrFO7u1NARM3mK4MzpEMRRLD1y1k9W7ZFhRhXLQrD0Y/cQ2FjxDRjn
         b9uLKRzic+RqXsLLGCcV+2inpy4rBoaj3/7StfariJ1ab+lVBrxFhTTokOSaGMpSkzsJ
         zvSpDO34JoUyv51TVd1wfhTTqRwO0oSsyIhSXOn409U2+5TXffmQklkJvlUEhUArIcrO
         SRP8eDQrP/QZp76MP3qW3l4yf7TDGDnVMrMAOaxxHv7/oiqqpKbqI6E9uwe0LKkDdqLY
         4j6SU8tkvW5P2Uz/GEg4UQEfBDMkPvekNM5c7DPN/WXm78//kXWTQMyi+uMP3GRNUAB3
         TKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792555847; x=1793160647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oGhvDxI3zW4RDmWwBNExt8CDr9PPRQWD4dlxrwabZRw=;
        b=yH3jk/2xIUa5KayOgIU/zD1JrDx6O3uv6q4GpHMXJ/cAwb1AviptJorbSMjbkm2410
         nkEZgkV93h7njcQG0Qtrk3EAqZdcMC/T96K4Gn+Hd+RruIU6ZKFbH8UIohwclwQTKNGP
         7LY18ZX6vI5/lvJKreeS+isoQWLh/eop/XKWsYXP4nq2BOtqwcYoFXmdCfKn5usKes4m
         t8vDliYi9VHmhpJGYJwhumLhl2WozJmwpcSN8uXWZR7uWnSWxnXxD2UJose+o5QMUcJ/
         F1XnjFvTJ+WxzfMFE8qM/VNrRY2mGw/O/+NXnVR0M/P40OSc+oinWMpxjs0keXpVk8GQ
         8j8Q==
X-Forwarded-Encrypted: i=1; AKwUvByovmddh9fVhlQ50GyvzdbUM4vll0vdTudYkWGDcZuGA18UemdCUviUGi/DV5Bfzh4YArSh34q7wWLF4w==@vger.kernel.org
X-Gm-Message-State: AFq9FYIls4J8KtKslNUeXGpuXA7Rrn8igtxYDJDW2/6i8WsKTepa2Afn
	ZqM7ZS/NzVYHijXa4ZpbZY/g93lrNE+Q5czwisnlcNNE2XD5vxRR3Hgr
X-Gm-Gg: AYBFou3SEChEYVB3IEMp9+iwKFk1sNwc0mFD61kAmbkKDLEdRQn0MdBIBPZFQKzCeOx
	g1nSs6pif2k/hnhYwU3iw6Ma+wFZbIkQLOY+M+Le8MkCxxP+qLET7U9BYu00XoP42iJqEqIvJbw
	euMoFAHPrYJ07SF5gDBa0YKxcU0FbQeu1r6FDM2xu+OyPCMmMzaspeSQfrDhK+gp7wieC7EIqu6
	m8H5H/uve/P9HZKi7Dda6OCHU9zh/5ZD/fkwSsSd8SQaU3hd1Mg5DnXqzRmxyaCS4dqABSK2X1T
	Rpw4/PZj7sClUSsQl3SJaNwZdPHQJZtkpAT4ggYrkFka2hPdWYdnIxmnxsZBqkDQemkexeLOJ6S
	+nMFcltu8/i+tEdV2il9nA5U0LdpdA3SkAVPpoL+JCsXXzHu9xPHuqqUO3Lw/+TckNF7lOG1C2J
	pnCfmu5yB3oCh9vSS+KLe1wMbowVwqoKUDHrZGHvBJ9Vsd+cmzvajkx4RSdkAAEM1CsBqh4wjui
	Az+rc5P/KKr49dwCk2gKZkmeEg+aBJhRe8iDXe5iyjNBFV0MLl79qu5seTjwGFdgz64e6hFhYop
	ZhAPCLU=
X-Received: by 2002:a05:620a:44cd:b0:93f:2c95:658c with SMTP id af79cd13be357-93f57f1ed0amr231705985a.14.1792555847390;
        Tue, 20 Oct 2026 21:10:47 -0700 (PDT)
Received: from keith-pc.taila86f15.ts.net ([2600:4040:50fa:9200:fff4:6e82:93d2:837e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e247ffsm149480485a.39.2026.10.20.21.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 21:10:46 -0700 (PDT)
From: Keith Teeple <keithrteeple@gmail.com>
To: szwyb123@gmail.com
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	david@davidgow.net,
	kunit-dev@googlegroups.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Keith Teeple <keithrteeple@gmail.com>
Subject: Re: [PATCH v2] lib/sbitmap: add KUnit test suite
Date: Wed, 21 Oct 2026 00:08:49 -0400
Message-ID: <20261021040849.688374-1-keithrteeple@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016073253.520971-1-szwyb123@gmail.com>
References: <20261016073253.520971-1-szwyb123@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 16 Oct 2026 15:32:53 +0800, Wang Yibo wrote:
> v2:
>  - Test sb.alloc_hint as a plain boolean: KUNIT_EXPECT_NOT_NULL() passes
>    its argument through a const void *, which a __percpu pointer cannot do
>    on architectures that keep percpu data in a separate address space, so
>    the test did not build on x86 (David Gow).
>  - Use a BITS_PER_LONG-relative bit number in sbitmap_test_iterate_set().
>    The hardcoded 130 lies past the end of the test bitmap when
>    BITS_PER_LONG is 32, so that bit was never visited and the test failed;
>    assert the precondition while at it (David Gow).

I am new here and trying to be helpful by testing others' patches. I
reproduced both v1 failures and confirmed the v2 fixes, applied on the
stated base (4056b3c9d3c9) and built with gcc 16.2.1:

  - x86_64 under QEMU: v1 fails to build at sbitmap_kunit.c:38,
    same as you saw with gcc 15.2. v2 builds and passes 8/8.

    One detail: this needs CONFIG_SMP=y as well as
    CONFIG_USE_X86_SEG_SUPPORT=y. Without SMP, __percpu has no address space and v1
    builds and passes. The kunit.py x64_64 QEMU config leaves SMP off by default.

  - i386 under QEMU: v1 fails sbitmap_test_iterate_set with
    nr_visited == 5 (expected 6). v2 passes 8/8.

  - UML: v2 passes 8/8.

Tested-by: Keith Teeple <keithrteeple@gmail.com>
