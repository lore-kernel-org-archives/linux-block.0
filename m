Received: from mail-lj1-f225.google.com (mail-lj1-f225.google.com [209.85.208.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75C1325714
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761942883; cv=none; b=epp67Hbq/1LDN0aQgg5AfxRX4AFS2fDmk0m3qsezf6G/a65WSAJBnLD5eeSESpfPbu2ZuoJCJYOqmf8yaPf05LR4KJtgOh05lBL4wBnKpMwCB1lX6FKxHgiMuEbmXjtnsCGzVc7R6OI88uYIk9TQcSJD5x5RveHQyobBehHYOtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761942883; c=relaxed/simple;
	bh=C6whxhY2k5fPAXSikyioIezH+fO5txoMclXOMXtXotc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEWyF9MKNAFPkCkOGJaHi/BoYxNSng0eBmWAzMAX3KZ0+/cQHnioA49ksNWF3trkyQil1MsoltRmrUUex3X4NIGd0pz1XT3OzvIiLGiAMzjFNkM7j4AV1o76TQCGx/ByFB+Y22dPyeOgEM+CXSE2eYOOHD6a9NVsfrT6uz+Wwkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BHzRCFab; arc=none smtp.client-ip=209.85.208.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BHzRCFab"
Received: by mail-lj1-f225.google.com with SMTP id 38308e7fff4ca-378debb4644so3860011fa.0
        for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 13:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761942878; x=1762547678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RI0qy1HNIsZ7APXGZu2HBwOodYb4++mraqK0FOunMAU=;
        b=BHzRCFabhiAWethpTxaoampQf4oPL+XouXKbBZxEG8mFL1FqS0EF9jpZN9UQ9wgzoK
         OZNRYic/S9lVXkZF+GytR7vTTrI/3+WOcb/nhJ1KpaRHfMaDUXuvOe0ncwLthQxgJWHK
         802pT0+3ovV/QNVTFvhTCms70QWPuaIXoyqkOTKNz4gSCc7BDLIReCo5noxgqf6fFK8f
         heqDvTywyL84V7XzxDYd9n/Jr+jrKlZ2YFR7+8ssV13ZkpSYevogr+pV+0FNNDU1zb86
         PkTWXQisezVYIfpyBCDOeYp2of0/y/mE2LfKODuUTdZQVDVjER8KDWxli54z8W9rrP7C
         hQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761942878; x=1762547678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RI0qy1HNIsZ7APXGZu2HBwOodYb4++mraqK0FOunMAU=;
        b=s1zVjcfGK3mpa7dyyln8ucv22vbhhQWVPnQ2jJHDuUOxy3mB9Di66MgbERQHOi+ldu
         YWwTuC4uExJEIzWDDDq0c9bF4l0NpnhdzDDU2+p6OuNEGmsSz9/74tcDTzrwXRCdQN5V
         I1KG/FvbitKX3lu6mif+cUxs8sNdhVcUIwKar85DG5DeEL5tq1IHftlw48IpVyIjQOqQ
         u1zwAhs4mT35d6I4tScgFzvnvvcKhCJKDU7vIJvOFYf8AqJOfyhvvv75KhekdqYBiw1L
         n1Wb0DrVXjlOYg3vnUZbBbmISSrsx/UvlrzTUAebwo0dNWr9wRVbAVMh/PoKmBsDACzz
         SL6w==
X-Forwarded-Encrypted: i=1; AJvYcCXE89TcXVlYPCtw/38aLwj/VqTW9nv2mE57tK2j0W3eij5l5O1gyAeDCD3XL8WyGYNEqLuTGlqUsx3ysw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8rKwIue1nT7h3O33sHEqYCTarBH5JbnjNknWV0aY6GO55bFMC
	OYc5EO8BBeXBS2hM4nm9yuh6pnvxk/D+MfWrvK3X/y+l1h0i2p7cFOovSsHUQ8nuu8uvnLru+/z
	HAnTpVPwdrY+9yNe8M2ihWgHL+zfx3QBcM+0FUx8BbmBQVEVvnPzb
X-Gm-Gg: ASbGncvb6GLSvg5Cac/TloBwa9Fo1O01jArCPb91bcHvIQ+Ty1rnGSHsj9lnW1iEjC/
	hRX4iXSqsIixkZkK+nWDkg4zJX+NKuga11x6+16zlqFfQIfLqnHIQNdnMETC3OKo2pUFklMjGDy
	wkmcV+ODfWzPj9uIuOidQHtXWlQlxK+iVjXusebxDM1et9kRpnIqkIrcPjPI1tE6bopCKLU7LKp
	qN/2gnL2mzonzquMVDPVUvQcu4hlBewx3OJGsIHHJzwKFp/M6qq67F3kFn3Y76JbyYca5JZY3/7
	qRosC7G5YPxzrp4WXkIh5rpApwMCVStwkhNCImTsXT2OWOfPTap7pw7zEi7z9eajNkVqXCDllKJ
	9xuXhav5Usdnn+9Cc
X-Google-Smtp-Source: AGHT+IFkklfQMtwtYHctUmXUj84xAbmvWB5viNqygwZDDgD7B4MpJ/ProRXWufuferuOhixNh09lD4F7KOks
X-Received: by 2002:a05:6512:4025:b0:55f:6637:78f with SMTP id 2adb3069b0e04-5941d5539bdmr914999e87.9.1761942877597;
        Fri, 31 Oct 2025 13:34:37 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-5941f5b5c33sm282549e87.37.2025.10.31.13.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 13:34:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DFCEB341B91;
	Fri, 31 Oct 2025 14:34:35 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DA9BEE41255; Fri, 31 Oct 2025 14:34:35 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 1/3] io_uring: only call io_should_terminate_tw() once for ctx
Date: Fri, 31 Oct 2025 14:34:28 -0600
Message-ID: <20251031203430.3886957-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251031203430.3886957-1-csander@purestorage.com>
References: <20251031203430.3886957-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_fallback_req_func() calls io_should_terminate_tw() on each req's ctx.
But since the reqs all come from the ctx's fallback_llist, req->ctx will
be ctx for all of the reqs. Therefore, compute ts.cancel as
io_should_terminate_tw(ctx) just once, outside the loop.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/io_uring.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 93a1cc2bf383..4e6676ac4662 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -287,14 +287,13 @@ static __cold void io_fallback_req_func(struct work_struct *work)
 	struct io_kiocb *req, *tmp;
 	struct io_tw_state ts = {};
 
 	percpu_ref_get(&ctx->refs);
 	mutex_lock(&ctx->uring_lock);
-	llist_for_each_entry_safe(req, tmp, node, io_task_work.node) {
-		ts.cancel = io_should_terminate_tw(req->ctx);
+	ts.cancel = io_should_terminate_tw(ctx);
+	llist_for_each_entry_safe(req, tmp, node, io_task_work.node)
 		req->io_task_work.func(req, ts);
-	}
 	io_submit_flush_completions(ctx);
 	mutex_unlock(&ctx->uring_lock);
 	percpu_ref_put(&ctx->refs);
 }
 
-- 
2.45.2

