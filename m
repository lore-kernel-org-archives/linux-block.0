Received: from bsdbackstore.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171442222CA;
	Tue, 11 Mar 2025 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741690358; cv=none; b=CCfVqM9IxHdj9/5/3iUFu/5uc4kb2L//cjxI6VnDmY8vdeyl9k7d1AD4nSElWyd24n84EGn6B0XMu9J0k9Z6ditVQ4YheDGZWwKNc4Lk76IsSIPUluPEPslp+BqsKw2PJ/k38iCuDVLEkI5LE3FoxjRJSb2X81Cha17jZ0oAN/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741690358; c=relaxed/simple;
	bh=0VEEkjJ4MAGyY/gEohUFQhijdGjOkmkRGbJ+e1N1MUA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=VTBaRdxPQIaSwuzdiyaBBfKtkODnwysL1f+fkVL7TPqakgLw2chLOka7vMPv+hyeUhtVCnUKIWNgrLsEFtoipu8/gxJdQ/EeW0v0iEpO3iWlNkXkTZqAA/okq0z91kYKJtFOLr7tRpNjvaRVfhRzoFFgCLMxFc1la8WxuFV5YXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu; spf=pass smtp.mailfrom=bsdbackstore.eu; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsdbackstore.eu
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id ccc6a89d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Mar 2025 11:52:26 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Mar 2025 11:52:24 +0100
Message-Id: <D8DDP6LIPOKB.2ACTHLE9FPI2A@bsdbackstore.eu>
To: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "sagi"
 <sagi@grimberg.me>, "mgurtovoy" <mgurtovoy@nvidia.com>, "kbusch"
 <kbusch@kernel.org>, "sashal" <sashal@kernel.org>, "chunguang.xu"
 <chunguang.xu@shopee.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
Subject: =?utf-8?q?Re:_nvme-tcp:_fix_a_possible_UAF_when_failing_to_send_request?= =?utf-8?q?=E3=80=90=E8=AF=B7=E6=B3=A8=E6=84=8F=EF=BC=8C=E9=82=AE=E4=BB=B6?= =?utf-8?q?=E7=94=B1sagigrim@gmail.com=E4=BB=A3=E5=8F=91=E3=80=91?=
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
X-Mailer: aerc
References: <2025021015413817916143@cestc.cn>
 <aed9dde7-3271-4b97-9632-8380d37505d9@grimberg.me>
 <202503071810452687957@cestc.cn>
In-Reply-To: <202503071810452687957@cestc.cn>

On Fri Mar 7, 2025 at 11:10 AM CET, zhang.guanghui@cestc.cn wrote:
>
> Hi=20
>
>         After testing this patch,   sending request failure occurred,   u=
nfortunately, the issue still persists.=20

Maybe I am completely wrong but I am still quite convinced that the problem=
 here
is that, despite the nvme_tcp_try_send() failure, the target sends a respon=
se capsule
for the command, leading to a double-completion in the host.

Sagi, what about taking this patch: https://lore.kernel.org/linux-nvme/2025=
0306160322.1370300-2-mlombard@redhat.com/T/#u
and do a step further by not completing the request, leaving the error
recovery handler the task of cleaning everything up?


diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 327f3f2f5399..72c1d7948386 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1328,8 +1328,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *q=
ueue)
 	} else if (ret < 0) {
 		dev_err(queue->ctrl->ctrl.device,
 			"failed to send request %d\n", ret);
-		nvme_tcp_fail_request(queue->request);
 		nvme_tcp_done_send_req(queue);
+		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
 	}
 out:
 	memalloc_noreclaim_restore(noreclaim_flag);


Maurizio
