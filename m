Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865699;
	b=Tjgo5OmLew5ondOsfOpwMeXBpD4v4Fb4SxC/dj0pnYIkQXAHD0VBz9LJ9jIzqxzy33pf
	 E8VkPlKkmnZAexFJ6hetNl0D46EmQK05bJ4XepeJigWtbrWVTO+x+poXLz+gR8uxJJqj5
	 aOsRoAXxoFpmXu7EjSA5bmkEapBb/7ROnvxpIGKULwFN2+J/6psFpUNdj4SlUCmf7C+eb
	 9ziyfoMUyTwE3GOPzHfsIHHe3JOnUI0rvKQZj3rsf7rmYCLlH9s7QU+b72OWv5iXM7KCP
	 E6hAV33LwZe3muSklUBUz4VjQXn8Gfv9wfVRAqODKTkyPYhaufJDazX9FkF1uX91CzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865699;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WqHkRG09x5uGZCJcQ5xBEX+lcS7fQPhyozl8pVJvZ8Q=;
	b=JFvnfWM64GIkkQxpllms9pOj9F8Q7w95KC1eNLasNIOmrFq1jMHdarEYMwh8H8uvGODS
	 dlys9dzHM5SjqU0FM5A3lGvZCtTvFi++sqN0fTGPQ4nugyuYKnzs4WeFVaKlE5x4fMzRk
	 vT3cX9XcjmL9iSjI2yUr/qa8GRvi7CNM/LDBY3sWkwYmJcP8fITMAWv5wXUxDIcO4tHIB
	 BjSEgKA9FNM2lg6LBmRClWeyQ4k0Egy9KvWwFSH+uK7Mkld2MePwrS4UTIzXJJAEvy0jc
	 JhA/Csh/aLmp99TOWDsPAL5ys8KCJzPk1k94eBX3NN0GsbwUc/PtqeQUwHHMjqOh6tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=KwKeMDLD;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A59606A31C
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 21:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44A59606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=KwKeMDLD
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jT1h25xWwzlfftg;
	Mon, 16 Nov 2026 21:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1794865695; x=1797457696; bh=WqHkRG09x5uGZCJcQ5xBEX+lcS7fQPhyozl
	8pVJvZ8Q=; b=KwKeMDLDjZ2IS1urCm+6p5tdr2FStekdcLmjDyywZIzKT899fqN
	WT41r5JzPI4ObfY33QYBJ6yrzwxQk4zx9g6PUKx9p4t2UdKoHL5DNgr6WEcvjqgU
	hhByA0VM+7VcVS+roM45mZ43lgYmvGlio/3cIipye/+9SrvXG6OMLEgiy5G3MDV4
	8cDiRLWWNQ8ekUdJ5y7GR/WVdfutgvg0c1qQ6at9tG9sCpo21ju+r0hJoI10PZj0
	xpnS/ZKHhGEDIueBXzZZf6xkcsbcU+oVdA93r2StpyQBIh+IhJN9BXthnyM6gKL3
	6Pox+g4rlufSPUhAkI69RonXlLMnQUQC/Ig==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9nRMyIozUQda; Mon, 16 Nov 2026 21:48:15 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jT1gz3QHvzlpHx8;
	Mon, 16 Nov 2026 21:48:15 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Aibing Chen <chenaibing@cmss.chinamobile.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/8] nbd: Defer request transmission to a workqueue
Date: Mon, 16 Nov 2026 13:48:00 -0800
Message-ID: <cover.1794865298.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

The NBD driver transmits requests over sockets owned by user space direct=
ly
from nbd_queue_rq(). Hence, sk_lock is acquired while blk-mq holds
q->q_usage_counter and set->srcu. Since other kernel code acquires sk_loc=
k
before fs_reclaim, mm->mmap_lock and other subsystem locks, syzbot report=
s
multiple circular locking dependencies. Socket lockdep reclassification, =
the
existing workaround, introduces new races and module reference count leak=
s,
and does not suppress all of these reports.

This patch series fixes these lockdep complaints by deferring request
transmission to a workqueue, similar to the loop driver, and by removing
the socket lockdep reclassification code. Since requests are no longer
transmitted from a context in which signals can be pending, the
partial-send handling code is removed.

This patch series is organized as follows:
- Patch 1 fixes a missing wakeup of wait_for_reconnect() callers when
  NBD_RT_DISCONNECTED is set.
- Patches 2 and 3 prepare for deferring request transmission by
  simplifying the nbd_send_cmd() return values and by no longer taking a
  config_refs reference for each request.
- Patch 4 defers request transmission to a workqueue.
- Patch 5 fixes a nsock->tx_lock -> cpu_hotplug_lock lockdep complaint.
- Patch 6 removes the socket lockdep reclassification code.
- Patches 7 and 8 remove the partial-send handling code that has become
  unreachable.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Bart Van Assche (8):
  nbd: Wake up config->conn_wait when setting NBD_RT_DISCONNECTED
  nbd: Requeue requests directly in nbd_send_cmd()
  nbd: Stop taking a config_refs reference per request
  nbd: Defer request transmission to a workqueue
  nbd: Call sk_set_memalloc() outside nsock->tx_lock
  nbd: Remove socket lockdep reclassification
  nbd: Remove the partial-send handling
  nbd: Remove the sent argument of sock_xmit()

 drivers/block/nbd.c | 394 ++++++++++++++++----------------------------
 1 file changed, 142 insertions(+), 252 deletions(-)

