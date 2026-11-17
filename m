Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906276;
	b=Q3chIX0+WOgtztQOFKNbhNlgFfMN5dYSqxsTTtPHv44B2qURXl6svAcFDIGyx6GGqx4z
	 gx/q6QiYFxvnwEEJIRszV+Aez9cXx6UtQrGdfF3QnS0wBcD4o89m8RvgA2NP7m5mRk+WY
	 byGj7rYHIAP6y0bTVE0vDlsMM6mEij1WkdRgveija/RPUntQ9EgnYOQtfBi0nLdAv9MtA
	 mZKNu8CLYvz5fztMtePE+Q+hG8RVjKwzAUF8UUPCxMB2gouNtO6ghFqCfXHYE00d+v9Dp
	 j4gcCZ9Qf8kbnZo1dpmf8mlGhz25ZHPeB0nFdlimHTZCMqzIxYmXxZt9oS2usITGbrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=Yafz3sEgHSbB0dihgrPP4811kZo9wiNYZxbrPM44ojs=;
	b=M+RtMa3ROrXbh4r8cQ1hULamZqrPQygPbIXySHk1/cIxw0qau4Ubhf9EU4MeGdwerYUy
	 QxrTkZih7BTzjByfDxfwpSOs6TKaOJG/d3w1jw+yguNKClGqX3rD2u+x1buXoIdcdV/ZM
	 vVyENu1LyKzIy7QfRbYx8zosZAU1IDpIBAsVVgQk8R2mgYS9nHmDf7WVsFqozUWrXObj0
	 qzkgQM0c5t+RMTtFSkRARgOj36hv3uqpA3Vn7KUNd856SyKW76pJp02V53nUldSsmaap+
	 CxZ3n00w+Rum8U40Fgmf1hGbEo2IPML8AgmRg0qulLJznulRtMshHHJcD+FaodKG+3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=Df6fFrOr;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC7B606A32A
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 09:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EC7B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=Df6fFrOr
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b3af93b85cso367320a91.1
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 01:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794906276; x=1795511076; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yafz3sEgHSbB0dihgrPP4811kZo9wiNYZxbrPM44ojs=;
        b=Df6fFrOrS33woqipjuxMbtgP7Mb38cga8ynzt4dnwXgr3NWyVSrac4XRUinfbr3fLw
         ZVQFQHOVaZhwzqO9wK3QHesW8cBGX1Yir2qudEdLZW+BOY852fUftVTZY4lKH1Gctl09
         OJTywxiLvJaQfloOQmtSK384TfG4wao7WnxHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794906276; x=1795511076;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yafz3sEgHSbB0dihgrPP4811kZo9wiNYZxbrPM44ojs=;
        b=Iho1NNad38jLNLZXUd+7k0FxOD+XBE6aCwh3thBK68urGdUNxjC/2LL75t/uQIiZ4q
         9LkvErrRapj7v5chqCO/Jlw1cqYIKmKNyO34S5tTAI8R11vpuTm6YPNysFvm/Hj2fjnj
         +aHpiGbXUKWXfXcCasX8Rg76WgkUd6/gxwbAVJFY462osvGSBqlzRrnMTWaGZIT8tDS2
         JQeORQiQiizOKrXY6KoMdYBPFoX7yTFp+Pr7dpxPLhPSJokMQzgwgXGCPutEEQ4elu9r
         A33pYk8F2y08hy5pnWJ10dWQxOEpUFRADLbkzbMQAtp/qTA47ERVwQ/5y4BjXDnLNMTx
         J4Xg==
X-Forwarded-Encrypted: i=1; AL+hErHDAyFRvVk6PewsJiz2n07OeEQLMww1ZqH1sMt1al+kbbbiSztDvNRy/QpjkabNx4o12yiprq0psjB1VA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8V5KrwqogwFNLYFg+cGWfDbAvGSMd0uLf6K4PYSR/XhcvUJk2B
	hVu7tMxPv/y4J/iiL2TVqOwDvvX7M8lcg9emBuKCfNu9YtqvlIqL/soxosNXbSlMyqM=
X-Gm-Gg: AZFdTZdBtAbGTzkLldsaDatAC8NIQDKdTAum7mb/zqnF4f06bCDBe1UgLehUz7BVSp8
	r4/o03XFLaC96/dWfH83ay6VEuGRKTtE+GKv3ekTKwvN/89xfAiuZz+P8ghZJfVqDD2pwuytdCy
	o4p1hlnIzteTAcDN3YbIZqfebDF9ddejeExbS/KlGhTku3RRsNGSsJlqoHneQyrhsls1kKFpnL9
	nO/Zld7G1yD/81CmtV1F3jzbd3K/1wWEiR+ehL/WeXwQsojhpVK2VpZkTi3v46fTmSsEjK/XSaU
	axoBFsV47LJ8Pu3Qqwdb2caZnA1zxkthbZGm3PxukkHZEDxDjgrtSrGCWYaZdSYO1aniDHzMn0T
	lAxjKV5R1p3XIvVS+80Fyr7glSV89QRHF5PXuGg70HVOLDMJgcbsxnpEM2kYkBgjAhC+7niELjX
	m3zOJIV/NZA4bH0EOFx/96IODr876O9rQHL3rAGRekHLcMrxP2Lxi5v+uJvM9i27/Wjql3pawhK
	TAkwM6vEFeBIp9U5DvCN2mA3yKUXnOJcOksb9ueY8fMGFkBh/B5x4AXVNsz3S7XR0hkzKFtNSOp
	8rLUB4JpBJUrnJYynUJmZprr4VRJTnAtKx3kQli8q0mwuDdPXf4L00m2hvmfNrLeO/1oiK4HktF
	kID/VVFi+tZCdN4YM6pH0H+ycNoNflv8t9h9nmwHmNtdUZo6autN/eVRmH6jA9v6iigcW/NgODb
	6GxDPPxbzKE4HoelyEUTPi7UOA79CgozsXyrpfs1RvErNFyXby4JHzrDMkxE/+3dV+DScpIBQnn
	JiaIM/fsTFPm+E=
X-Received: by 2002:a17:90b:17c7:b0:3ab:884b:65ab with SMTP id 98e67ed59e1d1-3b1b0ba4fd8mr13948715a91.55.1794906275627;
        Tue, 17 Nov 2026 01:04:35 -0800 (PST)
Received: from [172.20.0.3] ([172.56.235.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3abd068e2sm3204091a91.6.2026.11.17.01.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 01:04:34 -0800 (PST)
Date: Tue, 17 Nov 2026 01:04:31 -0800
From: Chris Down <chris@chrisdown.name>
To: Breno Leitao <leitao@debian.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	kernel-team@meta.com, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH RFC 3/3] fs/pipe: copy a run of anonymous buffers in one
	user access section
In-Reply-To: <20261113-pipe-pool-regression-smap-v1-3-b0dc69558ab3@debian.org>
References: <20261113-pipe-pool-regression-smap-v1-0-b0dc69558ab3@debian.org>
	<20261113-pipe-pool-regression-smap-v1-3-b0dc69558ab3@debian.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <avwYn2KugKhjYxNh@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Breno,

Breno Leitao writes:
>The numbers below come from an earlier version of this patch, which did
>the copies in fs/pipe.c and left runs of a single buffer to the old
>loop. Throughput change, median of 2 boots x 5 runs, SMAP on:

I timed a single read() from a pipe that was already full of anonymous
buffers, on an i9-14900HX in a 2 CPU KVM guest:

     read size  base     this     base, nosmap  this, nosmap
     4 KiB      175ns    181ns    152ns         155ns
     64 KiB     2123ns   2061ns   1971ns        2070ns
     1 MiB      49.6us   49.0us   46.4us        48.3us

(nosmap here being clearcpuid=smap.)

So on this CPU the 16 STAC/CLAC pairs in a 64 KiB read cost about 150ns,
and this patch gets back about 60ns of that. But with SMAP off this patch
is about 100ns slower for the same read. So the batched path seems to
cost more than the old loop, and only comes out ahead where STAC/CLAC
are expensive. I haven't looked into where that comes from.
On CPUs where they're cheap, like the later Zen parts Linus mentioned in
[1], this may well be a loss.

It would be good for the changelog to have numbers with some
clearcpuid=smap runs to compare with, and preferably on a few machine
types.

[1] https://lore.kernel.org/all/CAHk-=wiTN=1Sm5DVnXDtQ-tSiPuz-7QVpgP2vt6LgaEnhbubfw@mail.gmail.com/

Thanks!

Chris
