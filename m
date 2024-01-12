Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DCC6BB5B
	for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUygNlSy"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf3ea4a586so2803426276.3
        for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 05:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705066021; x=1705670821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f93Ig9LJYi6SxdMZrbYZZHjHKOcib3L6QU/xnO4vU2I=;
        b=sUygNlSyCS5vY6Fk6MTb1dALHL9wYVw3GoCyPUx/hDpPatN0773TiQ5XqszcdpNVmv
         /fs9w1ONsQDFoy+fGNLRndio09a21H3GFteGWTdkvT2COxdPO+MVUscmXim5VRkGsgbq
         hdsNs/j1EJd2TN6zeqNVrsuBJnxGFiLRljVVz9WQ35m5if1Qb4Acn+tBBvZWqoU9LEd/
         NoMtNRuuxpYiw826QdLA1v53r71GL2T/geoCcBiH3dlWMFW8cYWFkdCLuxzhWi4VRKfd
         nQVBtHncuyfGktgFuPSN0Z9CzDTcV+BlxYaMM1QuTfSX6G4FjAx9TZ3Ja8PbUqMeXhUs
         INRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705066021; x=1705670821;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f93Ig9LJYi6SxdMZrbYZZHjHKOcib3L6QU/xnO4vU2I=;
        b=hfXYTJ81Sx+guKSmQKrKXqqzjt09lgRowPjFQ4sh3N/N9Gv/zMQtl3tq2wCfMDKzsb
         E35n3sBhpmXPnhWCglw5mglRIYxVgJ67kfLS0dMQWBqbTslTB2DlEsM7HVv2FwlzW9Yf
         V6iASHRmTjh6aSKb3E0ZUtzG7GhBJCCa4S/Pl15ljn1+xrJEbu1U3yxHmfJOcEpDrq4I
         dW6rHcZkt6lH9LJGgfEDDI75kIMi7cQkT9ZV/zpWrblOHmODZ9dKdzehR0NV7STy5BGJ
         pIXWb5BdLZHhGQlHs86KHQnNGmRsvMlSyFxEDGnWNoytg3T0CORtlU3jj41ZqHu2hupC
         34zw==
X-Gm-Message-State: AOJu0Yzlryyy2bUqIvM/Lt+S+Skmuk7VN5KHW9im1bgzjfaB4RiE5AQA
	rhlrrclDwK8o7gRyaHKgV9g61mDTNsJt1a2bDbzH
X-Google-Smtp-Source: AGHT+IEdNpp9MV1efGqWVumTNO6v9b0Uyr5We6/Yz4ZyzAHpiTLmjWlQyhYuSCloT/e8oLsD+H1RgUnxsQqoUQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2483:b0:dbd:73bd:e55a with SMTP
 id ds3-20020a056902248300b00dbd73bde55amr21536ybb.4.1705066020920; Fri, 12
 Jan 2024 05:27:00 -0800 (PST)
Date: Fri, 12 Jan 2024 13:26:57 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240112132657.647112-1-edumazet@google.com>
Subject: [PATCH net] nbd: always initialize struct msghdr completely
From: Eric Dumazet <edumazet@google.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Eric Dumazet <eric.dumazet@gmail.com>, 
	syzbot <syzkaller@googlegroups.com>, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, nbd@other.debian.org
Content-Type: text/plain; charset="UTF-8"

syzbot complains that msg->msg_get_inq value can be uninitialized [1]

struct msghdr got many new fields recently, we should always make
sure their values is zero by default.

[1]
 BUG: KMSAN: uninit-value in tcp_recvmsg+0x686/0xac0 net/ipv4/tcp.c:2571
  tcp_recvmsg+0x686/0xac0 net/ipv4/tcp.c:2571
  inet_recvmsg+0x131/0x580 net/ipv4/af_inet.c:879
  sock_recvmsg_nosec net/socket.c:1044 [inline]
  sock_recvmsg+0x12b/0x1e0 net/socket.c:1066
  __sock_xmit+0x236/0x5c0 drivers/block/nbd.c:538
  nbd_read_reply drivers/block/nbd.c:732 [inline]
  recv_work+0x262/0x3100 drivers/block/nbd.c:863
  process_one_work kernel/workqueue.c:2627 [inline]
  process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2700
  worker_thread+0xf45/0x1490 kernel/workqueue.c:2781
  kthread+0x3ed/0x540 kernel/kthread.c:388
  ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Local variable msg created at:
  __sock_xmit+0x4c/0x5c0 drivers/block/nbd.c:513
  nbd_read_reply drivers/block/nbd.c:732 [inline]
  recv_work+0x262/0x3100 drivers/block/nbd.c:863

CPU: 1 PID: 7465 Comm: kworker/u5:1 Not tainted 6.7.0-rc7-syzkaller-00041-gf016f7547aee #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: nbd5-recv recv_work

Fixes: f94fd25cb0aa ("tcp: pass back data left in socket after receive")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: nbd@other.debian.org
---
 drivers/block/nbd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 4e72ec4e25ac5a0f41bca299e7efaecf6503c451..33a8f37bb6a1f504060f783c6d727e4c76026a2e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -508,7 +508,7 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 		       struct iov_iter *iter, int msg_flags, int *sent)
 {
 	int result;
-	struct msghdr msg;
+	struct msghdr msg = {} ;
 	unsigned int noreclaim_flag;
 
 	if (unlikely(!sock)) {
@@ -524,10 +524,6 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 	do {
 		sock->sk->sk_allocation = GFP_NOIO | __GFP_MEMALLOC;
 		sock->sk->sk_use_task_frag = false;
-		msg.msg_name = NULL;
-		msg.msg_namelen = 0;
-		msg.msg_control = NULL;
-		msg.msg_controllen = 0;
 		msg.msg_flags = msg_flags | MSG_NOSIGNAL;
 
 		if (send)
-- 
2.43.0.275.g3460e3d667-goog

