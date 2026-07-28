Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D876347DF84
	for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274212; cv=none; b=pfPb0fVb8AYOx6R02Q2Mu0CDon7Ch5G/vof10jStl6TPfI3tsNKuNbaXje+ZDLgIyowkK/8JgCr72SwPSCS7p7xn0Moi0pb+xljwu2V3u9L0BXpN/wHAnS1uFb/NbYAf5CTjW19kDzwHMHFHS+hpfDWYN4S8WZeiWL3SrzIJWwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274212; c=relaxed/simple;
	bh=GOpsniia9YGwJC5+Tf9jZp7skqJgnlIpNpZfRP/ds68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c99zr92yIzlDzPGfaiFcB3+e5iad6onW/uqp6X30YNxyhK4g6TLjqjGjGWnyDNOB2plNlatsGH+zRC8UCLFnz1ejeVshMhJwp/+3OProv0zMfUNhFf1+HRyVOTj+i35Isv/1BokNCPEQUrFW1tN0Eju4BThijQn7I84/4rtGZd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5Ym4u/V; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5Ym4u/V"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47640541585so243470f8f.1
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 14:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785274208; x=1785879008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jomHTWh5pLJKgL2wIyki6K11K3ENYcuFeD6DEOIqSFg=;
        b=H5Ym4u/VExLT6WCLEE6Kv4YIjIw58vB034j8JEtU73/52h+pQnIHzfk9AFZZ7sYOjb
         8zlZzzwzcZzyJN9OYpWJ55tzNZb0Mo6Waf1q38cQDVRs8lfGOHXMPls5sh4/rm8Leqmy
         gXWt8McGH1ltozIKZ+VJYO62dYGsgiFSxlNJtrV9ymcJBGJA7MTfe0qICFv3efxNTiUi
         Ewfiu/Ea/sINTuGolpH0q03ARYDniehuDgUm3WrSEVB4y7Nf8kgeqlwD7CDcQQ4L8f8u
         Ao9Ov92XKpNK+yJ/fcgLbF6EbI1zlAJ6KEoSzfPPH9VNM8LzJsDWMTMZKpQ3fvXK7dMo
         lepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785274208; x=1785879008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jomHTWh5pLJKgL2wIyki6K11K3ENYcuFeD6DEOIqSFg=;
        b=mrdAGhj9DnhicDUL8Q69xCrOCWKvW5xHOKIkQUDca2pk2e99x0bsKTT5IHMC1rhT6q
         ylE3M+f9bY5CmzpCkzyNlRZUsjUA5reWpblOhtVX59OvncDj60761epsI+177Q4BATUn
         4ZRQreKJgTuwQODNQHi8p0M4WsvwNoCy/gV1w+OQ8o6uS73rEn0ygtRGL7Q3avlRe76G
         +QtpxJekrpfhb/eID4MTbplX4w50zGKY+fnmdQjUF+J+LCFooUPpehtiEV73yrOcMasA
         Kh8Ru7S5Hd6FfwgU89grl+G6PzLWBHAYR9xjvInxkJc5HdaKf4aTOonHnCL6p6tFHXUW
         dsGQ==
X-Forwarded-Encrypted: i=1; AHgh+RowLUVIVQTNqOvToDFpnz1Gml6Swdi9yBFYg4HkMFrw3ldg2NoZnFRnVJA5CK4XNQonpVtQsDWs8JOB9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkvJ1eNbSuQ16tQkwh53YO8E/jhAtPuoztVcUFKs7gWf8yzuRq
	xAk8kYwnvoODd9/NevC0zhelXYMiRXlfnNtQF6cgq+rjtpd5f0GyYGq8
X-Gm-Gg: AR+sD13snEvMtb4mTQL7g/+OEhrBfVasb9iXUZmlLrGy6fLpLIYmYPQDVkMRAZRNj8y
	7g48O0f4JW9rRo4xovngb8XphA8BZJFGKSGOY2lv/bxEwZvIYUyGBS1bSk4zp/y/yFcik/Cng4O
	zhMKxOKA7/ck0tDOndsr0S7nRobTtW4aehR/uia2OvjnBjJQUqNvWkof0ni1DUktBdlwY8KWqVJ
	9+0+2n/2ae0neuiWVkRaN38hgfhfbC9Ms0IEiCPvAhphPvmtzisgmEqDVnGFfULxkt3Tc/695Ro
	mC7dM8M+6n+CMsKLW7nwNtLSCJGwRm6zBQzRMXxmscSJXJzincUpndekIqdqzOEVIOqIT0xkUM7
	7kxV+YZWJMX5m7bLm/JZDBr3nt2OLUVkrpoFEMsqFYqmiQrrB+HEkJGSkjwvIKN17A1ddep51/D
	rcLS/EoJwJEdxZrms/awCYcmKPR/Y7Zx+J+fYwAJYloUFywUnbvrpEV6gToLlTiZ1pVRPOkm8Yj
	vp0J94imPEldnncA+E=
X-Received: by 2002:a05:6000:2f81:b0:47f:97a4:f121 with SMTP id ffacd0b85a97d-47fb1f108a5mr5045703f8f.30.1785274208062;
        Tue, 28 Jul 2026 14:30:08 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6ac44bcsm2245329f8f.11.2026.07.28.14.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:30:05 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: [PATCH v4 12/14] io_uring/rsrc: add uncloneable regbuf flag
Date: Tue, 28 Jul 2026 22:29:24 +0100
Message-ID: <a138961611aadf950ce6ab9215f00ae888b8ce72.1785274111.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785274111.git.asml.silence@gmail.com>
References: <cover.1785274111.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's hard to implement cloning if the internal structure needs to be
mutable and/or relies on other ring resources. In preparation to such
buffer types, add a flag indicating that the buffer can't be cloned. It
might be possible to add cloning in the future for them, but that would
likely need reallocating the structure and reacquiring resources in case
by case manner.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 5 +++++
 io_uring/rsrc.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 24fc3232a66a..d57e8a0380b5 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1381,6 +1381,11 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
 		if (!src_node) {
 			dst_node = NULL;
 		} else {
+			if (src_node->buf->flags & IO_REGBUF_F_UNCLONEABLE) {
+				io_rsrc_data_free(ctx, &data);
+				return -ENOMEM;
+			}
+
 			dst_node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
 			if (!dst_node) {
 				io_rsrc_data_free(ctx, &data);
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 98ae8ef51009..83aa86e6f320 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -29,7 +29,8 @@ enum {
 };
 
 enum {
-	IO_REGBUF_F_KBUF		= 1,
+	IO_REGBUF_F_KBUF		= 1 << 0,
+	IO_REGBUF_F_UNCLONEABLE		= 1 << 1,
 };
 
 struct io_mapped_ubuf {
-- 
2.54.0

