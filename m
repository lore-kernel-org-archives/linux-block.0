Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1644C2F549C
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 02:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779418508; cv=none; b=PjaTZEOIyz3k4sbRKNFU3uMVfte3RpyguIn+HsxOrOi3RXPcbVnPx8Ifh4aVn/8nnlWoW5K5ebrK4qNodSmULk8SiUKi4Omdd0ap11LMo0CLfRq15Dfuxgq7GUtp61Co/UbJEtZpLKNbw8fijyWYwLGK1hg/MrCDMb6IXmKT5i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779418508; c=relaxed/simple;
	bh=hR57sJ91wiAmylV6xAFjqCJNhvw42r5hiaFXIyVzhww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IXLg3HQus9F4YPZ3lceoPsAa+rxgRA1CkxJdTz10E6+Ujn4UFGR8MSeATt0WFxiFODL9TLXfSVYWLlSVU13j7g/BYIN9v2amp4qVQCr0u2F91XHARnyMgpy9gI4Hf/wsGZdpPrwEUfHakVk0kZleyUpATTbhzcEw7MhlgRlE2V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLCRHBdo; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLCRHBdo"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8b6dd874471so100552906d6.0
        for <linux-block@vger.kernel.org>; Thu, 21 May 2026 19:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779418506; x=1780023306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bZNQhuooYTLy1gx9MAaoZ50t8gHq8zmKqxe7T13R9co=;
        b=WLCRHBdoYo+6HDNUPVqmdm9IzjG07dhj4y+dumsuYx4f2agEL/EzREo9BalFBL0Ro/
         0Pj8In43Yf1cu9iFU6HSWfiijMTUaCupSvsOYELwc/jJqxCP5R32zawC/gNlvoVdG9l9
         oKM1Ef3kJ7+dkZPhCtjrOTO3o4FqsWhQ3xk85Tg6DXo3zWA5vnLBYnRSUDKvxUEnMmvv
         CdARHy/yp/TvTDJjsXl+nsfPfhGuPq9ykRV7aFgiWG4dY7HpN1IPEBG8FUcuHVKgkKJv
         2+Fh3u2ANK6wE8BRzGFVTNXUrZw3EpYWSjuyAus5hAOjnwSuBPsrQjlzNc3hJ3Q7WqMv
         HTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779418506; x=1780023306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZNQhuooYTLy1gx9MAaoZ50t8gHq8zmKqxe7T13R9co=;
        b=TAvGMiEctOMc3MG98UWmi38sXrz/diSaPqG+O/qVwVfYrZyDnqcQQQisCTW9kTsqYw
         KBnzw767oyrkf4161snzTRiJJ4l7GjzZKaGRHNVfCiC9wr9iGRAqzUMP5H4+q53klgWs
         7knMNOvLuy4BwI9BFm7oZvF7/+a2VW7O1EEyuiP5iPagsxzaEHik7qsbtg1B6IjGfr/D
         24hCKEfAfJIxpfwaLC7bspyG78E67d2+f8lxn1ptTzTCQLpE9G8qrSaNJXB43Eb9eS4Q
         RBaNpuW9a4tG4dYG5VnoHU1wClRIVA3TWMMKTq8EjlApytyKFEPl3jUoU9IsZEO4+Hrd
         0Ueg==
X-Forwarded-Encrypted: i=1; AFNElJ+vD2kbewfyHSI/Ox/FYCfw1QRMcM4Uk1BLbys3ES7WTONPpkGpIrFEtrX+C+/MxV15cjqhatZ5WFJrmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yww2qe+tWWuKsON2cAKfWVLCG8uQlxbNBRHCD3JJof8oet7BO/v
	A5D2YIuF3bGANMYQ1uG/QuUSio6axGQeT6xeTI/t3XgYxGhm1IxGrxOT
X-Gm-Gg: Acq92OGIfFJFEWMAD9/bMsyZNAelvfWjK37gU0dJjT6wN6hISTW6KdlunhI2ZavfVaV
	BXl/YDzyKWqmtpwUx8ZX4iodytT4t5CgPsrLCDp9yDGwKsBr8XcDF7yAVmTzBI+qs6iPBTfqHMb
	uvNp8vumJLiUCBmOCAMGa2dXSpgM9mmwUb26Ns5CP3nitjTYcEnTITqB4HI3gYz2PXI+jVsP1oe
	TLBQSWXWa5ywXHgS1Yjco1pXNv+3U4roxGmYY7GNcqSL7dteRESELI9IIRObA+0IRf+NnlBfA7t
	B2TYFVztkrBl7jgNK5E2b3GaCLkd5m/VaHDSttLzceJeF4S+XuYfs4CrvVQWUHbFnbufRPzjcCT
	EJOG8BLFL5VzGsPUqpZEEfYU+ZlBSURmFh4BkEWpnPHVnbeCvKSrA8EEstbJGVNhLV+VYqEJeE4
	9N1v3RRcDiOOkgRooZ2rQVTC0b1bhjxo6TNCbKG8KuDWz15lfoHQhJnTISt2yn3aKUU6hV39qIq
	alKriwLA+V5C/3iWF7rbFMq1WcqMq9ay9ks69k9YxmHpA==
X-Received: by 2002:a05:6214:468f:b0:8ca:16fd:7297 with SMTP id 6a1803df08f44-8cc7b60142emr35734256d6.30.1779418506097;
        Thu, 21 May 2026 19:55:06 -0700 (PDT)
Received: from fedora.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80ded51esm6110616d6.17.2026.05.21.19.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 19:55:05 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com,
	syzbot+bc273027d5643e48e5b3@syzkaller.appspotmail.com,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Hongling Zeng <zenghongling@kylinos.cn>,
	Bart Van Assche <bvanassche@acm.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] loop: add sync_blockdev() in __loop_clr_fd() to prevent UAF
Date: Fri, 22 May 2026 10:54:51 +0800
Message-ID: <20260522025451.845068-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The syzbot report describes a NULL pointer dereference in lo_rw_aio()
caused by a race between lo_release() and loop_queue_rq().
__loop_clr_fd() clears lo->lo_backing_file while an already-scheduled
asynchronous I/O work (lo_rw_aio) is about to execute on a kworker.
Since the kworker enters lo_rw_aio() after lo->lo_backing_file has been
set to NULL, it dereferences the NULL pointer when initializing the
kiocb, leading to a general protection fault.

Fix this by adding sync_blockdev() in __loop_clr_fd() to flush all
pending writeback I/O before clearing lo->lo_backing_file. Since the
loop disk is already closed at this point, no new I/O can be submitted
— only writeback remains.

Reported-by: syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cd8a9a308e879a4e2c28
Reported-by: syzbot+bc273027d5643e48e5b3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bc273027d5643e48e5b3
Analyzed-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Hongling Zeng <zenghongling@kylinos.cn>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/linux-block/9b2032d6-3f36-4d2b-8128-985c08a4fa37@I-love.SAKURA.ne.jp/
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0000913f7efc..023e20a88a8a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1118,6 +1118,9 @@ static void __loop_clr_fd(struct loop_device *lo)
 	struct file *filp;
 	gfp_t gfp = lo->old_gfp_mask;
 
+	/* flush outstanding writeback I/O before clearing lo_backing_file */
+	sync_blockdev(lo->lo_device);
+
 	spin_lock_irq(&lo->lo_lock);
 	filp = lo->lo_backing_file;
 	lo->lo_backing_file = NULL;
-- 
2.54.0

