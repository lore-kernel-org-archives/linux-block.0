Received: from bsdbackstore.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C882205E14;
	Wed, 12 Feb 2025 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350329; cv=none; b=MuWzQwiLyAE0IOVltZQkAlW/y+WgKZeYVaSNmetSTiMZVAH+8XrszbNRuezfMQUA/gVrcNesv3xHA65IfNU7YQ8Yhdl1kOtTxp4ETWp9i9YwVNpXKfxfUgMg7UUp81dvyojJJ1kIB6j7WU2i8HhIrow0LbrI1S9PNrojeeFQHn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350329; c=relaxed/simple;
	bh=7FBrhfHO1+R0el7WD1S2tcnq9wLJ75Ki86w1d36aXqg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=hBrBiNBI1DxWUZXsF2VOyAOJ+By4notaI89WM3ykr55AX3xtg5VPC80YLQMaHBX2w90FAgUBfwrweOnk6z7MEMd0ENvd31w0+EEEoVHhue7MEgf0/arDRUBE+Igo1L81CanMUC0PWgbSAOX00QIs1NK79543I2h+toYHgOHpQFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu; spf=pass smtp.mailfrom=bsdbackstore.eu; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsdbackstore.eu
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id ce0058fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 09:52:03 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Feb 2025 09:52:01 +0100
Message-Id: <D7QC8AQ7J89A.32TNPSFWV1VNX@bsdbackstore.eu>
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>,
 "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "chunguang.xu"
 <chunguang.xu@shopee.com>
Cc: "mgurtovoy" <mgurtovoy@nvidia.com>, "sagi" <sagi@grimberg.me>, "kbusch"
 <kbusch@kernel.org>, "sashal" <sashal@kernel.org>, "linux-kernel"
 <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
X-Mailer: aerc
References: <2025021015413817916143@cestc.cn>
 <D7OOGIOAJRUH.9LOJ3X4IUKQV@bsdbackstore.eu>
 <3f1f7ec3-cb49-4d66-b2b0-57276a6c62f0@nvidia.com>
 <D7OWXONOUZ1Y.19KIRCQDVRTKN@bsdbackstore.eu>
 <CAAO4dAWdsMjYMp9jdWXd_48aG0mTtVpRONqjJJ1scnc773tHzg@mail.gmail.com>
 <202502111604342976121@cestc.cn>
 <D7QBDBZMZTCI.1W40WVL5JJ3O7@bsdbackstore.eu>
In-Reply-To: <D7QBDBZMZTCI.1W40WVL5JJ3O7@bsdbackstore.eu>

On Wed Feb 12, 2025 at 9:11 AM CET, Maurizio Lombardi wrote:
> On Tue Feb 11, 2025 at 9:04 AM CET, zhang.guanghui@cestc.cn wrote:
>> Hi=C2=A0
>>
>> =C2=A0 =C2=A0 This is a=C2=A0 race issue,=C2=A0=C2=A0I can't reproduce i=
t stably yet. I have not tested the latest kernel.=C2=A0 but in fact,=C2=A0=
=C2=A0I've synced some nvme-tcp patches from=C2=A0 lastest upstream,
>
> Hello, could you try this patch?
>
> queue_lock should protect against concurrent "error recovery",
> +	mutex_lock(&queue->queue_lock);

Unfortunately I've just realized that queue_lock won't save us
from the race against the controller reset, it's still possible
we lock a destroyed mutex. So just try this
simplified patch, I will try to figure out something else:

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 841238f38fdd..b714e1691c30 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2660,7 +2660,10 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx,=
 struct io_comp_batch *iob)
 	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
 	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queu=
e))
 		sk_busy_loop(sk, true);
+
+	mutex_lock(&queue->send_mutex);
 	nvme_tcp_try_recv(queue);
+	mutex_unlock(&queue->send_mutex);
 	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
 	return queue->nr_cqe;
 }

Maurizio
