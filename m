Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FA435DA4C
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 04:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790655195; cv=none; b=SnCgr3swKUKBOLyg8eyvyo/sn/cZPBW9syiZUyBAAx6/Qc0KcLoZygqyD94gzQbAYOvVC+4IilMr4fXb3FadE1M+CyhmonX65HNPD6saTjx7EBd4LhyJlREfdwm4iAcpLcDF9rKkyb8WZ5rTI3k8WgJvvcYjPSRgqWEW63PRLPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790655195; c=relaxed/simple;
	bh=fBrobsZijgJQ4xKYnillWer0eyqBzsgm3Y6j4hnyzNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUYbO33iOj7X6yKmbqLuSxG8Db1Y8Usf7b99/bsqfz/XYP/kIh1wGxcLMAaSV0vPNDm7i3IXHGQ5obCFY6Oshrdgov9EQEE/CWOWzIXQVA/dg198K/ioYX2SHcff6nUoHvo6u6gPGAlNFQiY/hwLCqA0kIRrmPqPZesKXLc3rik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oAJLGmtk; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oAJLGmtk"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e5eso1707423a12.3
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 21:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790655193; x=1791259993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LYvHSlL6Doz9Yye4z6vhG/W2e5/5w65LNIuakmz8M/4=;
        b=oAJLGmtkOKcmq0tk1XuMpD/3LLAmDFvpT+s4I19I7ffql43u6tqMJU7Kj/eFCrbGqg
         TNW3Whs4LDaaQW/phrGs0coBAbmkIqBF8kOaahAlvlCrci/zhzElFmcEWtQ2zNQdmsqV
         n8+jf6hbwlw/FqKTpfXZcfntLQws/KTCKJn5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790655193; x=1791259993;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LYvHSlL6Doz9Yye4z6vhG/W2e5/5w65LNIuakmz8M/4=;
        b=GfgaGNzmFwfqT4jYmctf8exaQmHgkZ5oqZbNoaL12XgcOBEl1ZFyP8v9oiUBd3Qtkl
         YoP2hu6jjz7S0Cm5M0ezUOOyNAq1zntVfdRd52nRY/SvvbXrzEWJEdeZESCWCLA86IWM
         A6Eg2MtlbPALamLcSEls+xBCCse6BU1yiQRtPPlbuG/ZltQWEzj7fqWrkFPpMla/Kair
         Swd70InhDJtubRLH/hfEtutZ25RMsh7W6l1/0nsZ8nZJF8hD5WvHeJbiInrB8OpUn1Bo
         EM1DnbQjGfwO2FELqQzoRQE0qWMimkzLGQiOZKEuceGpJwvPEjj8S6Q87y0WqMLGv4RV
         eu4Q==
X-Forwarded-Encrypted: i=1; AKwUvBwwGZPx5MibSFX8QgJhMNlm/xFb4kT9S1PCLz6k+8A+psTuKzKqUxNphhcxIh4o/rlqoQhOMp0oVFsgYg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLxiJTSWFQczLm9OCzsF+3EjOh3qWXsU06I3yETY5eg9rGlouVJ
	C9BP/v093qBXisubUnwcQVPBT3lmFVzc9itDaqa6szusKEy6ziUB1pyefh3A2XdeJQ==
X-Gm-Gg: AYBFou2zWbQcRYKVsRgZoMASD1psnJCEN2u5R7dye5863x1f1xyeE3Wp6u5zeuKyrrP
	S8syT2rewpe6sH2EYXVyP0MF3ZvmSVEXk2HR1ADB11u5e98tlkTRg5yiQT3xuJCV/otZFSJsBmt
	scIRSqR6RSba5CP3xzjhxQSdO/jKuH66Pv1MpWsLSxEtIN8kiI7rRVwr2zxAfclldwAYrRcF010
	rxm5JK87K1c5LwfGfhMZ2ukkjVIqqsk1Oa/jrcWYfRRu/gbZWSMB5CIxWARwF40ww+r4KkoVw93
	j/g8DM64rs8Vfwf0V+OTJUp1iaynvG8BCNYTDeHzQAqUyCLV3k4nlx5q/fGngypvbXVofO3LHwf
	uoI1FwGS/NqsaDNtCbN+1FMErcoVhkWoXbz9cdyT58GgzNvAEmjGAxxXe4sznyzXuG+YB+XQaRD
	9w5jduUClSzEQqpKUbPSlhBcTAuN9NLwx6UBysi4ZJ/KZpiadmI6vNWRfoTuG99HTprVzMD7UY9
	O5eDPjHFbMBCKAKaWLTNUZjl9CB7g2nm1YEtV7aO1h3m16uOQ==
X-Received: by 2002:a17:90b:4c42:b0:39e:6c68:c787 with SMTP id 98e67ed59e1d1-3a098e5897amr14099148a91.61.1790655193279;
        Mon, 28 Sep 2026 21:13:13 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:5d05:485f:348c:a48b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a498179081sm2814953a91.14.2026.09.28.21.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:13:12 -0700 (PDT)
Date: Tue, 29 Sep 2026 13:13:08 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Pooyan Azadparvar <pooyan.azadparvar@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Subject: Re: zram: block_state returns premature EOF with short read buffers
Message-ID: <ars5x7UjjU10KOjE@google.com>
References: <CANC3H+LdtoydSp+o2ecErAw7k6R2+gRf9LyxcaoHv_mGhJmyQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANC3H+LdtoydSp+o2ecErAw7k6R2+gRf9LyxcaoHv_mGhJmyQQ@mail.gmail.com>


Sorry for the delay in response, your email somehow fell through
the cracks.

On (26/09/20 18:27), Pooyan Azadparvar wrote:
[..]
> However, reading the same file with a one-byte buffer returns zero
> bytes:
> 
>         # python3 - <<'PY'
>         import os
> 
>         path = "/sys/kernel/debug/zram/zram0/block_state"
>         fd = os.open(path, os.O_RDONLY)
> 
>         try:
>             for attempt in range(3):
>                 data = os.read(fd, 1)
>                 offset = os.lseek(fd, 0, os.SEEK_CUR)
>                 print(
>                     f"read {attempt}: bytes={len(data)}, "
>                     f"data={data!r}, offset={offset}"
>                 )
>         finally:
>             os.close(fd)
>         PY
> 
>         read 0: bytes=0, data=b'', offset=0
>         read 1: bytes=0, data=b'', offset=0
>         read 2: bytes=0, data=b'', offset=0
> 
> The file contains a valid record, but the short-buffer reads return zero
> bytes repeatedly and the file position remains unchanged.
> 
> This does not appear to be a memory-safety or security issue. The
> observed impact is that userspace readers using a short buffer receive
> zero bytes and cannot make progress through this debugfs file.
> 
> Could you please confirm whether this short-read behavior is expected
> for block_state?

I don't think I tend to see this as a problem.  Why would anyone do
a 1-byte (or any other tiny buffer) read in a loop?  block_state holds
a lot of data, just pass a huge buffer maybe?
