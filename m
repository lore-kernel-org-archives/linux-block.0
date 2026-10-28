Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197356;
	b=sflgI9K7NCxZildj5VELObI4pHpRZNoZwMpjM/dUWde6TDb02a/o8dZ2Y4oThKoahYmu
	 ISCsMlj18GzT9hrUQD1hzJICgL6qPgWlfAUPL2QkcS+XrrID6R1VJgw84Zed2J5bMMKsW
	 kd3nvLxLBt4a/LIRCTqoYt9ESvfgnGKOAiBHyOorX/6R1TloBZkAqB/AIIoaXlbC8VRRj
	 t2P+kEBPSfBQkSNBUzlnSmvaey48jc9sB+vyRhhn3HYjKceXGfYc5QLD37qw+XyaOElhx
	 gNZh3nqCZMgvyLX3S2SpGaoHFughAMixFQLHWlTIZOnHZyuZ5cuMJx159OCDBY3RFQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=XkCOJZX/WWMB9kGzP5MkxZIBGrbHKVoP2EMu7c4H2Kk=;
	b=YhBeMDhX2YWhShonxOx6jb8iD7aIfcqzxrEr0BNHu3lRiWwp5MPNSnI8piUJRKCDpa65
	 lhzkq5oCGth0DbMG9CvyvPFgB8UjkJcVDW9vhXtZOBSCc087w0UnK+llQrVqyWuA/Yuap
	 MvuL3rEIf5Yo2gK+BVEmvQ0Nem3E4AQkj9qZLLPfltD/MiaclGvI8qom5tTX+2IFrEwf1
	 mUJ9Kh6Rc3vnGe4cFumqJ9eaSxpprbmWuXR5djOg4tvl3BzhfNa1262sQT6ciYgiBKoGN
	 pNkA/Dvji0PJ5If5c9EhfIQ77wvBOIqlAYczhMnMlPExZ+zE5PMumOxRNqu+4aS/fNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p1iUDFqo;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A59606A31A
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 14:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6A59606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p1iUDFqo
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso595308a91.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 07:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197355; x=1793802155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XkCOJZX/WWMB9kGzP5MkxZIBGrbHKVoP2EMu7c4H2Kk=;
        b=p1iUDFqocQVreW8roT9uwBqm6fySMDwgzjOCMGfn8x5G2WANMhf8m8BF++eyz91ef5
         CFEgtqlNdqdmN2iKi3k+DBoajDIu+GKDYyVfMsetvRIHtSebreXYpWDd7ilJdfk2qfDc
         CPd04F9Zc1qkzDu+tl2TajmsKIdBnPFxWK0GiGu/wbEDLhf5IA6WOoQYj6tp3RKJ8LuA
         on/2ID1TXSKk8oWNqdM6upYk9J3DCwLJI/JYfistRGToKZiakbUql0ccLPKoLo9Shiyl
         2XderNpWJ4JK0sIxJtN0+pKrQACGD57RXW1wzl/ihBqFtb4Jkw3MkxXLcpyaGL8a5tKX
         MEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197355; x=1793802155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XkCOJZX/WWMB9kGzP5MkxZIBGrbHKVoP2EMu7c4H2Kk=;
        b=iL/Vt0CIyYRGWllxF9ndX1XIVgATN2J+ZPlPS5p6vCMbDoVMNdnMTMhy6ZPIVTCDpJ
         rbJzCs2Q6dszcrYmQdTCd0KMdYkVHU+FxVkxpRT0LhSOD5IwMx0i9ExxSC993OOUPbID
         kSCfdVHAgRcQ/be/Pl4o4uwihJ9Ghm7cG9i21DcSuSvrnQGDHp1WV2zbmDM5+Z2Hm4Rv
         Og1o61ixbH4jWINbdm9QaHnXGgPyMW1WcoPsyoRFYFldMQsyXyBUwbjaD7l94mIQBv0V
         rOkfQNxohF/C3Z3qyy90BARxoYuMlcUZA1IowUGAy+z55gbhc/whJPAVbKqCp2uR3+1a
         ySQQ==
X-Gm-Message-State: AFq9FYL9BfiOZ+/Bgi0iVWGGZy00DdfeqfAQC8c4a+jZrmOcDiYq+oOl
	oGa7yi8o7rcnf4XGwnNSVpVFmiALH8Z8DV+6Ct5yrpzZcZfX13LvmrHf
X-Gm-Gg: AYBFou0UgUekHIgVtF1n5N7niVemNOLz5Ym4JR2uusmMGLdVDI6hfs0zePctVKG8+cH
	+nMP8HHxNOBxm0i63L+m7WbWoCpsi8DoP7meaGP1/zkzatjarBCQUA6vnEiNMWAz/vCei6HUznx
	7XLbzVBALS2deVsqxz6HrU1Ne60mK5qbZtU3r0NrK8cKWUZIgmaR4kp5A0d0LQf6m+SN9+m3uvl
	DktlC6QsRk2g4gVmp/uXtgxZ3kGoceRfVwdwaY/pilkIn41syuoipj9Jb6AtmXImHjg/BIPdKn+
	rDvlCkPL8WyJJrP4yE6G3d76xfXxu7yM16KI/LzL8tD1zrzrhGaii0YQW9N/XDIZImTtykBtlJv
	+SKHi2gSffoMGX4gaFiwtt1kCB+57WlRaSeSAz3bNG5997GeM785oi9KxomhQi36dJKAgNeU1i2
	ybRyNV8Ki+Lp/PadgvLMsAw377pEhBCdk0Vdfz27TyoXsJ+Z8qAbgcsmGIIB5ucnevMSozGi1qH
	DXOjGP+h8wmVNvlQq+WvX4NaJe9+aFsQhps+LW7tJvzgFwUEC0um/qNhpr3aSnpNnIfSjNplOiB
	u9Ir5NTyvI+Dudl1Ecpu1NKruuYk
X-Received: by 2002:a17:90b:1644:b0:3ad:6090:a17b with SMTP id 98e67ed59e1d1-3ae580ae5f8mr1548061a91.17.1793197354899;
        Wed, 28 Oct 2026 07:22:34 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac1:7ac0:50::246:47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a900c22sm3309411a91.4.2026.10.28.07.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:22:34 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	syzbot+a246ab421a728c78b4ad@syzkaller.appspotmail.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH] nbd: don't take cpu_hotplug_lock under tx_lock on reconnect
Date: Wed, 28 Oct 2026 21:22:29 +0700
Message-ID: <20261028142229.24660-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
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

nbd_genl_reconnect_sock_cb() calls sk_set_memalloc() on the new socket
while holding nsock->tx_lock. sk_set_memalloc() bumps the
memalloc_socks_key static key, which takes cpu_hotplug_lock.

tx_lock is taken in the I/O path under cmd->lock and set->srcu, which
lockdep already orders after fs_reclaim through the queue freeze and
elevator locks. Once cpu_hotplug_lock hangs off tx_lock, any path that
allocates memory while holding a lock taken under cpu_hotplug_lock
closes a cycle:

  WARNING: possible circular locking dependency detected
  Chain exists of:
    fs_reclaim --> cpu_hotplug_lock --> uevent_sock_mutex

  -> #6 (cpu_hotplug_lock){++++}-{0:0}:
         cpus_read_lock+0x54/0x1c8 kernel/cpu.c:490
         static_key_slow_inc+0x1c/0x40 kernel/jump_label.c:190
         sk_set_memalloc+0x6c/0xa0 net/core/sock.c:307
         nbd_genl_reconnect_sock_cb+0x32c/0x72c drivers/block/nbd.c:1377
  -> #5 (&nsock->tx_lock){+.+.}-{4:4}:
         nbd_handle_cmd drivers/block/nbd.c:1143 [inline]
         nbd_queue_rq+0x1f4/0xbac drivers/block/nbd.c:1207

The new socket isn't visible to anyone until it is installed in nsock,
so it doesn't need tx_lock. Mark it memalloc before looking for a dead
connection, as nbd_start_device() does, and undo it if there is no
dead connection to replace.

Reported-by: syzbot+a246ab421a728c78b4ad@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a246ab421a728c78b4ad
Fixes: b7aa3d39385d ("nbd: add a reconfigure netlink command")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Tested in x86_64 QEMU (KASAN + PROVE_LOCKING) with the syzbot C
reproducer. Before: the circular dependency with
&nsock->tx_lock -> cpu_hotplug_lock is reported on every run. After:
that chain is gone. Also exercised the no-dead-connection path
(sk_clear_memalloc()) with a second NBD_CMD_RECONFIGURE.

With this applied, the reproducer then hits an unrelated lockdep false
positive (reconnected sockets are not reclassified); I'm sending a
separate fix for that.

 drivers/block/nbd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 218b99f9e1ef..a567c0bce90e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1364,6 +1364,9 @@ static int nbd_genl_reconnect_sock_cb(struct nbd_device *nbd, unsigned long arg)
 		return -ENOMEM;
 	}
 
+	/* Takes cpu_hotplug_lock, so it must not nest inside tx_lock. */
+	sk_set_memalloc(sock->sk);
+
 	for (i = 0; i < config->num_connections; i++) {
 		struct nbd_sock *nsock = config->socks[i];
 
@@ -1375,7 +1378,6 @@ static int nbd_genl_reconnect_sock_cb(struct nbd_device *nbd, unsigned long arg)
 			mutex_unlock(&nsock->tx_lock);
 			continue;
 		}
-		sk_set_memalloc(sock->sk);
 		if (nbd->tag_set.timeout)
 			sock->sk->sk_sndtimeo = nbd->tag_set.timeout;
 		atomic_inc(&config->recv_threads);
@@ -1404,6 +1406,7 @@ static int nbd_genl_reconnect_sock_cb(struct nbd_device *nbd, unsigned long arg)
 		dev_info(nbd_to_dev(nbd), "reconnected socket\n");
 		return 0;
 	}
+	sk_clear_memalloc(sock->sk);
 	sockfd_put(sock);
 	kfree(args);
 	return 1;
-- 
2.43.0

