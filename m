Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2281E3F1ABE
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 02:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810761; cv=none; b=JqwRkeTncjCvbxywKMdYZMFOuySMj2Mn529jITxX2uCzFn5bAq0Lj+Z3qkJXiLqwKnUIBSpyYMt/qqUXyKVmqRh6w/af8X2x6SzDXe6PPFgOSYTih12zCKmmRxxU5ZehdamhXSgsO3iacyjF7wblmJBljZ1POUIqnLLV7moSQzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810761; c=relaxed/simple;
	bh=fBeh1O4v9avKYsqlzpe0SpoW9v0F8R6Nqhz52syL9gU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D48BKEQdwhi9T5Y1FtxP+sriW0dJFc2E6qQsPINt5WGRjlW/8tIPDwL8/iKbiHSuxAsPRa3OX5+4FUvPY7U3p74dvLMDAhHuTPwx93h5xLRx00S7kWMGEQcfFJyeAyCUjtIG2H5ey3tAquK8CE7wz/GgJnp6PNoWR6A2psdGnl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=QJOaIHGl; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="QJOaIHGl"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6acb51944d6so2262615eaf.0
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 19:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785810758; x=1786415558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LJctEvW30tSWQkftroA0CEnZmB/pHZEQAoCkYmBNvzw=;
        b=QJOaIHGlzHI/889d8JR9a16k4arVZUxQuBN7QdATFPopsrN76bYezrD8zJy6OpZyHC
         pgUAYExDEJqfoKfPwc2axpsh7lPHaeBHIohpBZngZqeEhBCX7eywXMrlhwhztWTtFg22
         uxMR4pNznfjcKoMCLY9srjdcrLBSOfzmZqLHaQR9FxUYfeNiw25Og9/00SoEcx195Sj5
         JchthVB9XdQ09RqviN7t8x18Y9JtcSoQr4gaRzGcqS8gaOgZbHHO43/TRElHE+sxW0cI
         jzuo/wqW9nHy5t9qRo4csKDi/lBS8mwuJm1cZ/HzI9JB0aBgUMSLXMXnPqwdgTmsNu7V
         sUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785810758; x=1786415558;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LJctEvW30tSWQkftroA0CEnZmB/pHZEQAoCkYmBNvzw=;
        b=eGaascCjt1gTmIXGz2iIH+fXwsYl6/OEm1FTHFqM1Y1NTIcsCbtnr7PC6YuEGh3LDl
         4q97MtU0+VxSBsHWq/MDRqc7kP2ib79xUOCZ5EANG0vpUFdZPqfuR8IGLmBNPcD3L7py
         yyByZQleUDaOukL8+Ge31TwM4Ag7HJCSIo3OoqPKa56L84wAzjO/lKkdpa0aJ6pg8EUt
         A3SJWz3htpygdsCwQzFIloJhH0UnDDRR/eR7wyF4EKZ0urQM3RiY08w2r6aobUsR7/GI
         OSxRD0BSfbnm79pMcz6HA5d1FAST7wBU0ZSmeauqE7UQ2dOd7hrrJtqBgx2Yzq8HDQ9B
         86jQ==
X-Gm-Message-State: AOJu0YyYY2rDnxb7frCZw8FzMda06wcqOzTB2XLA8hihTTgRwX0iq3s+
	ro/ivXmfmq32n8z9ocGmjuVuWLPRzlYy9uSJj+R1a/j8Qro5NGY+4xFyBXk8b0K9tx5/BqZ/YP3
	6ZgOO3zh26g==
X-Gm-Gg: AR+sD11mgdx4kxai1gdNKwcvfkySvaz3zw02DrSG9pwSUjD3WDCxrgQHxIizb0sulbe
	scFiX25Mn2P3jEn4ZJGMEe+0C3HKnZqErxl6AMGhgANSFIfmthFY4PWo7tynR2Wcg1NGeRuQNA+
	aa84xR41f4Pfyx8LSX/zAk9KVyQi1j9MC19fiY0FTh+cPIfuxH6wyTrESt/kA2gEgC0hVljI0Bz
	iWeRAgV/AUtlg8g2WJyljGJ8+YY1g//XQRM0gd19eBrsVmUOwbafvt7s5VxnJSAu/Gmc5GQLgZz
	zm6kBitWJtEhDBcB/BrT86Kp8fTsPf3xtioKtOd9Hh8xj/8PVJNaFq3y2ZVVLrmmOWpU/KeCl1Z
	KPRtmgU16XC7UNbCIQoYUdrSWqiuVgW6s3bx8rwW63pOMarT+gpE+WvcLWgP66+1je7QhsPzKiG
	CiChYz5q6OPnk3PMHh2s0uFWogqyn/zDfjiihyn9P0IyziJe3QvEJcva9SmUxMljLxkZjGqKcV+
	ctqDZqY4NE6pxcLth0e2dGoSaGr9HQEAf3eana+7g==
X-Received: by 2002:a05:6820:83c2:10b0:6aa:fe65:4cd1 with SMTP id 006d021491bc7-6ae434add96mr13794024eaf.36.1785810757940;
        Mon, 03 Aug 2026 19:32:37 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f66c1fe3sm10700195fac.14.2026.08.03.19.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 19:32:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>, Shuah Khan <shuah@kernel.org>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260803211441.2538144-1-csander@purestorage.com>
References: <20260803211441.2538144-1-csander@purestorage.com>
Subject: Re: [PATCH v2 0/8] ublk: io_desc optimizations
Message-Id: <178581075261.549250.11096322353386419848.b4-ty@b4>
Date: Mon, 03 Aug 2026 20:32:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 03 Aug 2026 15:14:32 -0600, Caleb Sander Mateos wrote:
> This series is based on the "ublk: harden user buffer handling" series.
> 
> ublk passes the parameters of incoming I/O in memory shared between the
> kernel ublk driver and userspace ublk server in struct ublksrv_io_desc.
> 
> The thread submitting the ublk I/O writes to the io_desc, while the ublk
> server thread handling the I/O reads the io_desc. This basically
> guarantees a cache miss on both threads for each ublk I/O. Avoid the
> cache misses by writing the io_desc on the server thread in the kernel
> before dispatching the I/O to userspace.
> 
> [...]

Applied, thanks!

[1/8] ublk: consistently use u16 for queue and tag numbers
      commit: f510198855b6ddac0ffe62684dc407c56d3e0f24
[2/8] ublk: remove struct ublk_zoned_report_desc's operation field
      commit: 3a00b782a7b63b1876261ab883e1d8e1aa0e09fb
[3/8] ublk: split request validation from io_desc init
      commit: 8c76625ff9360cbe9ce0c47a624877aea14b3499
[4/8] ublk: initialize io_desc on daemon task
      commit: 735409f58b3da45094f2dfd7c18fb9e1937431f1
[5/8] ublk: add UBLK_F_IO_DESC_SIZE
      commit: 5c0958d80190822c4614ca00478d9acd9671bba6
[6/8] selftests: ublk: add support for --io_desc_size
      commit: fc01b96d74b3a9eec2b558d49ec9f5176473766a
[7/8] selftests: ublk: add UBLK_F_IO_DESC_SIZE test
      commit: d61d0f95e686be015cfaf193c0ae15156d1a0cc4
[8/8] ublk: lift checks out of ublk_{,un}map_io()
      commit: a8a79eba22dc4c11f2877bcf9e8557f6d95541ac

Best regards,
-- 
Jens Axboe



