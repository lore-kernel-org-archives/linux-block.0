Received: from bsdbackstore.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DAA204C22;
	Wed, 12 Feb 2025 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739347911; cv=none; b=VzE2KjJePuA9wTQcfbhN6Uz7i5bvi94Q5YNN7fAZrr2HlHf94kTYeaM1+1+Q82hNV4eQsbFbo86zOMaWSjI4ZyqryekQ11ofKx+3VLDyJDUzHtBO31Tsgcp1+ji6USE8MyIQGTiTVrmGn9OFFK9vjwt+NHfDkGudlF7ctqMgY74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739347911; c=relaxed/simple;
	bh=BV+SbdZ1oms0bO2GHFHJ5BLn58tdsad3g4zHGqw2/i0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HPSrVgtJgpvL9urkB2EX0n4onrMP+K4beDmUEcAgnVgwuwIvLWqo5JgBXDKSXOYM0BC6MkLrJdHZz+yZJIhK5+0x+D4LwWiU+HN67vLr8gnhwHB4kiaADvlosnedKsCJu5IqC5YGoR/d6A9RNSWy5g6vZ+Mdiz+wv+gR6fNECec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu; spf=pass smtp.mailfrom=bsdbackstore.eu; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsdbackstore.eu
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 8dfb9e77 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 09:11:37 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Feb 2025 09:11:34 +0100
Message-Id: <D7QBDBZMZTCI.1W40WVL5JJ3O7@bsdbackstore.eu>
Cc: "mgurtovoy" <mgurtovoy@nvidia.com>, "sagi" <sagi@grimberg.me>, "kbusch"
 <kbusch@kernel.org>, "sashal" <sashal@kernel.org>, "linux-kernel"
 <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "chunguang.xu"
 <chunguang.xu@shopee.com>
X-Mailer: aerc
References: <2025021015413817916143@cestc.cn>
 <D7OOGIOAJRUH.9LOJ3X4IUKQV@bsdbackstore.eu>
 <3f1f7ec3-cb49-4d66-b2b0-57276a6c62f0@nvidia.com>
 <D7OWXONOUZ1Y.19KIRCQDVRTKN@bsdbackstore.eu>
 <CAAO4dAWdsMjYMp9jdWXd_48aG0mTtVpRONqjJJ1scnc773tHzg@mail.gmail.com>
 <202502111604342976121@cestc.cn>
In-Reply-To: <202502111604342976121@cestc.cn>

On Tue Feb 11, 2025 at 9:04 AM CET, zhang.guanghui@cestc.cn wrote:
> Hi=C2=A0
>
> =C2=A0 =C2=A0 This is a=C2=A0 race issue,=C2=A0=C2=A0I can't reproduce it=
 stably yet. I have not tested the latest kernel.=C2=A0 but in fact,=C2=A0=
=C2=A0I've synced some nvme-tcp patches from=C2=A0 lastest upstream,

Hello, could you try this patch?

queue_lock should protect against concurrent "error recovery",
while send_mutex should serialize try_recv() and try_send(), emulating
the way io_work works.
Concurrent calls to try_recv() should already be protected by
sock_lock.

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 841238f38fdd..f464de04ff4d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2653,16 +2653,24 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx=
, struct io_comp_batch *iob)
 {
 	struct nvme_tcp_queue *queue =3D hctx->driver_data;
 	struct sock *sk =3D queue->sock->sk;
+	int r =3D 0;
=20
+	mutex_lock(&queue->queue_lock);
 	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
-		return 0;
+		goto out;
=20
 	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
 	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queu=
e))
 		sk_busy_loop(sk, true);
+
+	mutex_lock(&queue->send_mutex);
 	nvme_tcp_try_recv(queue);
+	r =3D queue->nr_cqe;
+	mutex_unlock(&queue->send_mutex);
 	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
-	return queue->nr_cqe;
+out:
+	mutex_unlock(&queue->queue_lock);
+	return r;
 }
=20
 static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int siz=
e)


Thanks,
Maurizio
