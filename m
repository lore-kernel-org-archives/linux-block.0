Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6A044F54C
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977966; cv=none; b=E3pZxZ++eBZcHUorlOh4XCRreURH41xLhrxWNZqeJBMxp3hzzRgTsAB0vqfBVSufSfcB+CMqkhdKeX9qAt0r1GYfRrCNuIqDbiQ+Wjj8qMMLtcrrgkUxyddO3ntG77uJWyP5KZMXQMoHhyjx6Y7Rpv9fWW3tQiHHs2KWSni7vjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977966; c=relaxed/simple;
	bh=weGnp7IBbryCjvpWBBTbgpO4sETZOPpzMirjmNwz5rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbSRSPOl+tbzTWalxZyYS3JZTvIe1cGDHVYaPVgSb0+eJQTJvXZK5yGg26dyOIOB+biiPAUl90LAUbEZay1D8JdKTAqOuuDhZUkAp7uuMKB0GAQUXfJ/0zz21eT+9cTodcKQiSVsIdT6uh/LPCV9IvE4z/74JTFt5feJkPJsV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=0b1t.tech; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=0b1t.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-939109fafd6so232535785a.3
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 01:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789977964; x=1790582764;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=weGnp7IBbryCjvpWBBTbgpO4sETZOPpzMirjmNwz5rA=;
        b=mr3nG6Qa2qlL9assaJcDpeu8cXducoPqifet7VPbXK6djQ+kQi6LrNYFrXqSoutTf3
         zorSArxwnnHz3W1RpY7zcAwZZbxntZYeGyywPytBejXE9rYJcjvg2UdBx0h6Lr7EDgSN
         xB2DOK/PF/z/kI9GS6EmlcJb4+ppg23FarO3oqyvqiIEzUa5B86+iZ2fJmkLarsN6d+c
         N3XyLfYg4lIeGvy0DJqVoxqEZ0L9TZlsa5qfgueA5IP4TON2rzakrB9BeVnTuWJataho
         5p2FWaHtyVwNMNjeQqgDWxB1WvMt3xI0pYiCopbq+BDJzRpD2Jh2hl1TMK4oVQfrt/WS
         /7cQ==
X-Forwarded-Encrypted: i=1; AKwUvByraYJh/+bpPIaI4MbZxW1pcHUBYzSDVmKMR6M2W6WB6PP6hz8+FvKVk9aT/trlQfjpGqL8yhDEh96O8w==@vger.kernel.org
X-Gm-Message-State: AFuF++lh2/Aw9xd0ne5adKKMDAk5Eh1iHIcTH/O5tOheli2GzSwX1cMh
	xqz38ki4GtZ+RSfyyf3KHQfsBoQktNXOPJTY0t1aO0Qg+yPOeggz8t97/2IYNvSdsyg=
X-Gm-Gg: AYBFou2XOTmp+W6jS5/bb4F1Je1OV5cNHiRUs9jpgNm7kVlBK87pzKcBY+ruKfzLEMf
	TbPmsVKZo+gp0wrQHtjN4ZenwaK8I9Syf5z9vrulOzpBiM3DLl5iYflCyyZMVbJ+Uib6CnF1fsE
	KXrbDQ/r8XaUzDW1Ca9Ci9mfldh1rySmHf/2DQhUf4Rw7wVDFcdhgX3k3wKbbVuy02EgcetiGQg
	yOd1wT9k+mKWv4Pscsu8RO7X82dt8oWj29YdmPNxvHoj5u/fk2mLKybA596Isrz3Gp2+p+MKqL4
	L1/q5q4MPxDC/8DF2QAcA3tHRWLfHfeuL76CiL9b9CXfFxTgoKBvqieTFdsdttjv3j27MGkPCGH
	b1k63y7REqGAYjKXVpvQKuffL7/ZP/3+mkr7BXSWYFuKPwVAlq6u4IWyiZ+yBb/YXi8f+Jqurq0
	/f045v8xNAddbLiXeSliWsFawT2mbqujVBffhdUR7Aydf9XZPQr6YA5inQ8ewdqWtjP7HMUfnfH
	tHCufo/epPpPtbypDUqHTaLF/RB
X-Received: by 2002:a05:620a:19a2:b0:93a:83d:1d26 with SMTP id af79cd13be357-93bf55aeed2mr858951385a.32.1789977963752;
        Mon, 21 Sep 2026 01:06:03 -0700 (PDT)
Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com. [74.125.230.235])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93bf0215773sm551362885a.6.2026.09.21.01.06.03
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 01:06:03 -0700 (PDT)
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-939109fafd7so223716985a.2
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 01:06:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy1Y3k2LVAC8b2BHkKhiLY+01u1slkC2CxCWEglM0C8MilT2fcrVHds0viGClbT8w4vTNZICUNXhQG/6w==@vger.kernel.org
X-Received: by 2002:a05:620a:7013:b0:939:fe9a:6437 with SMTP id
 af79cd13be357-93bf551bb21mr913701985a.6.1789977963158; Mon, 21 Sep 2026
 01:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909060924.1102037-1-hch@lst.de> <20260909060924.1102037-14-hch@lst.de>
 <arDN1UdZIydNLUjz@shinmob>
In-Reply-To: <arDN1UdZIydNLUjz@shinmob>
From: 0wnerD1ed <l7z@0b1t.tech>
Date: Mon, 21 Sep 2026 16:05:52 +0800
X-Gmail-Original-Message-ID: <CAKTh27_szTVmVmV26ASynzdJUwQEe49wCxMNq5ifRH9z7tiykA@mail.gmail.com>
X-Gm-Features: AcwNN1V0k4-278Z_kDhRyPxGbZjTPAIgWklsd_xSilZS02b4Xifc_jGYXYctnbM
Message-ID: <CAKTh27_szTVmVmV26ASynzdJUwQEe49wCxMNq5ifRH9z7tiykA@mail.gmail.com>
Subject: Re: [PATCH 13/16] xfs: add support for lazy direct read bounce buffering
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, Tal Zussman <tz2294@columbia.edu>, 
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Sept 2026 at 14:40, Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
> I found that recent blktests CI trial runs started reporting the failure of
> the test case block/046 [1]. I confirmed that it is observed with the kernel at
> the linux-block for-next branch. I bisected and found the this commit triggers
> the failure. The error message "preadv returned -1 (errno 22)" was printed at
> src/bio-bounce-read.c line 121 [2].

Thanks for the report. I've taken a look at the v3 series. block/046
deliberately uses iovec lengths of 1, one logical block, and one logical
block minus 1 to create the partial extraction state that exposed the
original double unpin.

Patch 13 stops passing IOMAP_DIO_BOUNCE to iomap_dio_rw(), so the
request now goes through the ordinary bio_iov_iter_get_pages() path
first. That path validates each iovec against bdev_dma_alignment(),
and the one-byte first iovec is rejected with EINVAL before it is
pinned and before xfs_ioend_submit_read() can select lazy or always
bounce mode.

> AFAIU, the test case does direct read to a null_blk with bounce buffer, and the
> kernel side introduced some new requirements to use bounce buffer for direct
> I/Os. Then, I guess the test case requires some refinements to meet the new
> requirements.
>
> 0wnerD1ed, may I ask your help to fix this failure? At this moment, I don't have
> much time to dig into this.

Setting csum/read_bounce to always therefore would not make this
particular request reach the new bounce implementation. Patch 16 also
removes bio_iov_iter_bounce_read(), including the special bvec layout
that block/046 was written to exercise. Changing the helper to use
aligned input and forcing always mode would test the replacement iomap
implementation, but it would not preserve coverage of the original
regression.

I have prepared a minimal local blktests change that keeps block/046
active on kernels using the legacy implementation and marks it not run
when the mounted XFS instance exposes the new csum/read_bounce
interface. That preserves the existing fixed-versus-vulnerable
coverage without treating EINVAL as a successful result. A separate
test could cover the new lazy and always implementations with aligned
input and an oracle appropriate to those paths.
