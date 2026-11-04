Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751553;
	b=33xzpwMfuphKIwu4kM+Lk5nAxRZcL0zR3O/pDj7lzytyvJZMBPJIoHtlvOh47pSeYhWz
	 A2Lu2r/ODI92rrkYOP+5hNdXm8J+2wDXuIECvdYvfGtc59C/6aWvgcGosKjb9cWzXpLJD
	 8Y0i1nKeNyVpBC2ROquDhs9+4z+8AGqNmhikVhJgg5Pt6wYLrxUI1JicvUYKx57IFfciO
	 3N+NB4KU2nQw/uEF/NBdMSUkowxrKz37+rA/JzG3A5gApEleSx+sd8/lPQyD8eZS+G+/k
	 Mm/gtWQA2vSTJ5wCS0I/W2zqOGdQxSSteBqqTqR+jmvPTyFF7KCl1rALjjUh/BfpWOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=xkQ2a4rr4OfVHQ6kuJzVvVdC31NeQtZjjZjX0zJeTWI=;
	b=W6F/QnCBV4POKRnl6SqagqSzUzcZIs8e3c4qEWKbXzUVuPRsgzmPSCoWTfQ9C1UIl6oc
	 QLUyLXOErdmX2xgSn8F4qfotwVdUmOQkxdw3s8JjlyXdCVMisF+rGoY0gExknrS8n+rTe
	 uHJLJ2WRLIZ+qyV0h+2XkDXbrx7lPWkgkC+ek/rG7N9F/hbE5G8EO6Q2bezFZraaLsEJf
	 ZEGz2oxQ+6NbSXpqTRX3pI0HoGHCS79OE6yiJju81jUzphU7sO5jT64Zl7EaJpODBKWqH
	 vvF/dj/SFZcEq7bDuX9vhtdgH4luzA0YqkyaHWcf1q4taGupAvAUODPVCZeA2U/qgXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nua3l3Lz;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578C9606A324
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 00:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 578C9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nua3l3Lz
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e0d1da913so25002f8f.1
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 16:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793751552; x=1794356352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xkQ2a4rr4OfVHQ6kuJzVvVdC31NeQtZjjZjX0zJeTWI=;
        b=nua3l3LzXH5sC9A6SJ9iKsthhz+gzmmes08RfX+Km6fub4LXy2WKga81YLv/KZCWh8
         aXCZIIS81A56KCQkdxYaQNk5KHgirFO47zSnsfkrTpI8Z2AFJ47Q48Yw6MG+mXUKNu9J
         7EYoJk7ILdJjyCu6Aejpdt5y38qkkDrNjk4xAeA3yIuYCixIdbBtd+K62+4bta72poy4
         GWeWprgrZ9BdD55agKUAF1VFYRsPQrgK703f6xRrYn6zCVxoijW2mmd95cLOAZyFHT7F
         WT9RigCUK7rGvk9in63j78CQ5ytxfWfGFNCbaMfe6VQIjtgNRpE7kyEJsYjkXjeukJ30
         Lm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793751552; x=1794356352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xkQ2a4rr4OfVHQ6kuJzVvVdC31NeQtZjjZjX0zJeTWI=;
        b=LQRsjcHbdmyuVHEf1wOpQNX6uO3xYI/FhqxlmYn0mxbEkv6zH4S2cbQBQ+LkxVV0ae
         b39pQZd7wy7o2o6koRkCz5shcAGQqax6aTusCfxwZroRt5DSBJyO6fd/55Nl+n4iIIJs
         lP4Dso7B1fTOB3oVMYsNA+3peYeQ4P5J+pXSxr81KlAyajacbeeS9Fo5vN6lca1uqVJx
         8EGjTzEE/fkELCaXvY6KQvka1iANzI/l4lkdFJqTrODTzk/o6KaSbVAKk7I3TlmsJp4X
         khGAkwRABE3Z+06q1O6ClN+4LkFKz7GiwvY6GXm1qkYVoNfbg2ldWY9k5YWhZqvS7wF4
         H/1w==
X-Gm-Message-State: APuU4Z/GsnkNGnhIITjl/t3Mh0XUrYJJENsgoUpJ7yQjPTJ+tGqdF0RN
	1tFwk6O+swNdzeToiDNue+itFC5w4tekNCC9y7Izoz0PR8/l9XbPGYrU5A3gwQ==
X-Gm-Gg: AYBFou2rPuuLVoKmbOccvC6A1LnS6OUKHaMC5LtJh7Dq2qCJ8gy96jyjRBXSru98hVX
	/QSYKhqEitOpzkCU1onmyfF8vNzpzyvPOjIM53eEgk7zLsMRGGoox3Z2/Maat8TC4CvPvScDH9G
	0NDQVMclk1DvbDb9fi0gai+lxy6yV4jwjQpkFptuepfPQC+CWaaadG54i8yGUSPJj/q1Oy+BnII
	jR9tkttP2pkzvrANo3sQ97vukwMFK+54ft+buDEkqQa/F0DA3CT5u5kWEs4l3M9VNFA04bU1jb4
	sK3EATlfHHv0ynO9crHIqS2UifLj0UNBsBHD6buFrK6wQDEKlScQXkPALs+mQ0oIS2Xu2sf5Xdp
	uv2/HGBnNI2Hrbei2LE9i2GwlqoPWGW/fv8epL2iBJt7a3FEtZwyAYA5nVl0WXxHxxtPn5M158y
	SMqJeSNxEyAAi+NTkOHg3zX0VDt+cwOvKHzrAYulZhu8nr1BX4BltWhWPK2/VKlH5BfSiFv5oeF
	DjobsK1OkhrRGrSfjRdy4Vp4U7YuXceJtgN+gRiTKOs4tcwC9Qf0YOI5WMTydIsHUh4vPmnYoI8
	XtNtZKI5uUMzHkjjdc/t7m9MD9981BaKVjHUiQZL3oaB5uuxez/lZx6J2vQvKLSIxbAg1MSr08e
	izj0JjBZoHV2j74IJDhuC/Lh6mboKv7d6
X-Received: by 2002:a05:6000:3101:b0:48f:bbb5:61c2 with SMTP id ffacd0b85a97d-48fbbb563a3mr6701949f8f.4.1793751551597;
        Tue, 03 Nov 2026 16:19:11 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda1fb0esm676676f8f.49.2026.11.03.16.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:19:09 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH 0/5] allow dma-buf-io ctx reuse across files
Date: Wed,  4 Nov 2026 00:18:56 +0000
Message-ID: <cover.1793751001.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Currently, dma-buf maps can only be used by the file they were
registered with. This means that we can't open a new file, even if it
comes from the same subsystem and point to the same block device and
use it with an old dma-buf registration. That would be too restrictive
for upcoming filsystem support, so lift it now and allow reusing
contexts between files pointing to the same NVMe, even if they refer
to different partitions.

To do that, we add a tag representing for each file, save it from
the file passed during registration and use it to reject files
which tags don't match it. Tags are set by subsystems creating
files, should be unique and represent the instance of the
subsystem.

Pavel Begunkov (5):
  dma-buf-io: add tags for sharing ctx b/w files
  block: set dma-buf-io tag to block files
  io_uring: add data to dma-buf convertion helpers
  io_uring/dma-buf: switch to tag file filtering
  io_uring/dma-buf: get rid of struct io_buf_dma

 block/fops.c                 |  1 +
 drivers/dma-buf/dma-buf-io.c |  3 +++
 include/linux/dma-buf-io.h   | 22 ++++++++++++++++++++++
 include/linux/fs.h           |  6 ++++++
 io_uring/dma-buf.c           | 19 +++++--------------
 io_uring/dma-buf.h           | 24 ++++++++++++++----------
 6 files changed, 51 insertions(+), 24 deletions(-)

-- 
2.54.0

