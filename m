Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66464E5356
	for <linux-block@vger.kernel.org>; Fri, 18 Sep 2026 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731842; cv=none; b=dmHiu5Z3pB2JfX/BQJU1VTxbtvDr2UhXezZ8Xozr1K2mitf0I4TAjp52PNZVx8BLJy1ZzNmuscCO/II69yWhEOO+DL1m7Zb7sweqVnQhQsUfO/0Owth8Ol/u1/Yf3CpVfuOZI0pYZS16mjfUR8VDSMprdV3uZIouacfr+s23wAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731842; c=relaxed/simple;
	bh=6bh17PdmX5TKrdwWeikxgoSU8keCsgvFkmcGubKaqR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mSUibQP6m6uBk/Z11d9On8AUDFcIg5NH0vMws51neZMD3oZBuVdyRHYVzAk2uyYxPGK3bbogFZgd9yTlGl4MciEZMFFq/eh+tsrd6LNaiOTYnPXn5CFTHxQ0S/bqXtY3Z1CeOaBFbPETkJQmgm+PxSBj4sdIIVMQ39OEKVAo6KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsBY1g6l; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsBY1g6l"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2dd68a16955so16606175ad.0
        for <linux-block@vger.kernel.org>; Fri, 18 Sep 2026 04:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789731840; x=1790336640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z+gIlvnIDxGsE2zs/bxvoadgXEzUPdH93sukY7i/YsA=;
        b=EsBY1g6l3Xjf8FFo/WTWMLSwVH4b5NQyfqbqz+VncMXUUe7Q0HAN0hWU1FT35WXR3I
         acbZZ2rmUmxlJZMwTya6DkMxD6KFLPSOMol5feNwIlE2n+SBAu9GMmL9TFj21n/vA3Sy
         DfWLUi8nhCPxdtu3ftVQuslqupJ8HapqL7ttpAA0i5wg4yum63o/12gAgLUdhZJuQ6XK
         Ye7IbrGVC4m61HSok0YdsOogT5jkm+nxW9/4DeKn0ubrD8dCxjkJrKDQPWchyVszKYc4
         MwjBQD3hLkmduPs46B6WZaczfH3/FPEupf2Yi6mwNqJvEzrEl6meQMY/HfiQ6zzX5Axx
         TLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789731840; x=1790336640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z+gIlvnIDxGsE2zs/bxvoadgXEzUPdH93sukY7i/YsA=;
        b=SO6Bso1KxiqnTJJHegQEsBIsvi1v1YaBrxIDdwbGudMjzjvCdEHQA4MH/b9vZekSzO
         LBLZA2ox2R089T35CtgH9bA7RTbRUhnLcV8yZd3f+HDEaP9pVVTxDYLD8z0kmZUhxqcW
         pJ7jTo5cYhq4+el4yrqgS7w7j28V+ohX07b9XuqY88ltgVgTgx5F5fA9iyzboh2LMnGk
         npp1+czm/uaj1rx95/kVxBYe9EdOftPJytxUbf9t75WpdsRFNyuRcCLN/fdO+RQLVpfL
         hNKc126FwFGKoEdbJ/rFO1F9Erp1vvsLkRDWFhNm1Fo1Clql0+l0mrbEwwR3BagpQFcv
         32Rw==
X-Forwarded-Encrypted: i=1; AKwUvByWVRJ55Tyz1OiHQyxgy4vKapYnDYtvhbglZEaPL6Y9BH50vWs+E4uLCZy33bOihJ7Pge7jjfVY/h08Zw==@vger.kernel.org
X-Gm-Message-State: AFuF++nYyioXYoTYhJ0VMYtJJzUgegZfgwdesPYvE1oA5E5yU9GVqq6Q
	oW/Vecl9kUeu9c2l2q5xOf4ee+BOjDj1rt7To5M9URUbt75z0fqPHy+G
X-Gm-Gg: AYBFou3lROUIxZ/Lzs9gJSSSAk/xFvbPvx3GI+O3PXI7huyQEzaoNTpD9Bt+cS0lMl2
	XJU2EMjN4/qsRyOMCR9NqghmVVL+JIx5resOuXw6BeXkaiGJ/gCofCtUh+UdNLtzDkm7u2f3fX/
	wXyGHjiFSALJLue2vn8JoPmNqqWt9WEnpcTIx5wGv+ZK2Djltl5KMcfXyqcssK0wARzKyPgZolv
	F3XVXFo585zY7ZO1vAkEmcpuQdHVQP+UyjAfhHZAbny5FohUuHMPHkhOTjjjvUQ6yiudCP94ttZ
	MpRhGZ6kziMF4BB5mw9MAdy22KFrrsIROFJSgFd0VYcIzBYQjUC4ZFK4CHQ9+dW0xzBWwGW5ump
	80BnzwNYOoJOMv54Q3OxsavyLmAloVGDXWdJDlaO0tXBp6c6bmRjygcxaYtox1bWYt/Y0VJbB90
	7ChCFbws/opBf5Kf9/DpvIn3XtTi3f56FUY1pxgfBUfqebxCc/5u6pCWpTc6n+zE7FaHgnYrTDT
	KviyKex4p0=
X-Received: by 2002:a17:90b:3b52:b0:39e:fe9:c5b8 with SMTP id 98e67ed59e1d1-39e35df66f8mr9845308a91.10.1789731839978;
        Fri, 18 Sep 2026 04:43:59 -0700 (PDT)
Received: from 73ebd4c7787b ([183.194.144.114])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144ce02b063sm3404520c88.9.2026.09.18.04.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 04:43:59 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH 0/1] xen-blkfront: unbind irq before tearing down ring and shadow requests
Date: Fri, 18 Sep 2026 19:43:53 +0800
Message-ID: <20260918114354.3660102-1-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Roger, Juergen, Stefano, and Jens,

This patch addresses a race condition during device disconnect and
ring teardown in drivers/block/xen-blkfront.c.

Problem:

In blkif_free_ring(), the driver currently cleans up all persistent
grants, frees indirect pages, frees the shadow request structures
(rinfo->shadow[i].grants_used and rinfo->shadow[i].sg), and tears
down the shared ring via xenbus_teardown_ring().  Only after all these
deallocations does it invoke unbind_from_irqhandler().

Because the event channel interrupt (blkif_interrupt) remains active
throughout this teardown procedure, a completion interrupt received
from the backend runs blkif_interrupt() concurrently on another CPU.
Since blkif_free_ring() tears the ring and shadow structures down
without holding rinfo->ring_lock, this races against the cleanup loop,
leading to use-after-free and NULL pointer dereferences when accessing
rinfo->ring.sring, rinfo->shadow[id].grants_used, or
rinfo->shadow[id].sg.

Fix:

Move unbind_from_irqhandler() to the beginning of blkif_free_ring().
This immediately unbinds the event channel and synchronizes with any
in-flight interrupt handlers via free_irq(), guaranteeing that no
interrupts execute concurrently while ring memory, grants, and shadow
structures are being freed.

This matches the teardown ordering already used in
drivers/net/xen-netfront.c (xennet_disconnect_backend()).

Best regards,
Yuchao Zhang

Yuchao Zhang (1):
  xen-blkfront: unbind irq before tearing down ring and shadow requests

 drivers/block/xen-blkfront.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.53.0

