Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205945;
	b=Jhz7yHk5doY9GaCeuaYs1v1Q6W8SEsSISkBmUWFWlh+3yvcbDuUlenpzRFwQ/YpzhQWv
	 nsvgbVVDeSrekh4umLwMeEkc0uprJG9/kOn4rWTH9cHgXvQB7tNARpM5oMjNWygSQigDZ
	 LyE27HahgXL05LafQrCyYIT/UgZL4mF63fjQkw69EFw/rivcZGP1+fwEdrOQfjE7YOPVs
	 b2hkJn7DMLidbeMXAaI/UiRTl2E9JyOfUNStiLvAZ6WeaQe9HbSFLWFkPewEDAIWuN2br
	 IrAIBo5zwb2VPvNYeyyoCNvOQBF0lFlnb4BKHj82nrfrr3VZjjmXt3ijU7PPK+w+AUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q74eJcf9ve2x7VNEFmVR0TGrSQWca78NbMFd58RPGYo=;
	b=v+0eF57/T9V2HlWQcyBv4/JtN5/166NnOaLwGF6SvfeUDU8gr7OypzF38C3uuhtTuc0R
	 KTHFB2dwBBrDrZlBwDm+/23yzNeOxs27FBfCCM2JX7x3Yyn92eOxqjYCfANiM3OTA834L
	 8ogyBW5ksFwXczmNvOgFIFuihe2pIt+adCRC8EDFR8lWOsUB6W1T96VUnLabiuhdgKdRf
	 WgEKvOe8qFwgK4RbHiserXDByVAFGXeRboVPeCC1zJgxmlQsJXbIezkcCFJVYF0+v4CV/
	 PQy4yg6hTJwXU8IstKMZxqtps5+OEKplaE3U6Jo/FUmSCIDPCZ+05908m7Tr+lXssfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JFwWB7lC;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C226C606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C226C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JFwWB7lC
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-8479f46ecd8so569241a34.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205944; x=1793810744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q74eJcf9ve2x7VNEFmVR0TGrSQWca78NbMFd58RPGYo=;
        b=JFwWB7lCq8Bb38/hE0C9ipwXv/1WNlguCcitamQSRGup03+xI1VM14MPd4wtZreUm+
         0ekceDFKx4G44CvlCmIpyW0gHvQoHH0GOgeloxratC1eUpkimiRR9feV5WjRoW127R4K
         SSceXq/GfYIng03Hahgo6nvk/Z1CnMHPTD14G/QD9pC7Fi0BNPZsS+xwav1kdePutpyp
         IlwbBCG/TSncl08sQlKSD7JrncE8/YC1hhTs8DtpRyRPpJz8J4IY5rmEyENz80F2Y/p1
         mQvLhhuGghx9Ic7l6Qh1dDW6jiid4MYuoW4wDUr8pcGH0rYKVq0nYUjMxSGws9xssOXT
         mW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205944; x=1793810744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q74eJcf9ve2x7VNEFmVR0TGrSQWca78NbMFd58RPGYo=;
        b=I7rIqOwaLYImgDg19VOh6YTU+v4bIK7KIZkUJ6ZNri2EV6k2bSH1ngLA9VQDDRPYRT
         tBFsCbuQQA5hOrMzN7SHm470O92wsyC6mm4iJ44i1KmFNRt9LeGVxA9wgPRijOWloUNg
         sV9RCRojrbXlpVnTgiQ8gtZTzwuUkbVGVOeje2UOlE8h5oMwnDCLPlis0HT2zQNyPJeX
         V0aq+GQ4yTMFPOEvcx4h3xBdL2IJdemrDy65drJKeoRyUopWfSpKlj4uph8X4tkzKs7K
         vfrAfYyT39YTGrsvnoV/OO7YnI+jdrHrC3L5ESxUDProB2XQ1OEvPMMEPIncPDSnqqek
         6rvQ==
X-Gm-Message-State: AFq9FYK9hSHTYFd83ZzQqyz2xds2MxDqw7Ka0TBbHm3gNsfyOqJs4Iyt
	NGp/tqFFDwVvEIMU76MG4cPAOgHsG3pzbMgj4AwZbjvlLfnhcdJEnwo6kpPrjiG0Ms8aSSQczAE
	9UYQ61Fg=
X-Gm-Gg: AYBFou1JVNLIgPSYXw68Kux7vtpsJyKNhR2LumROsTsovVb4l4IYxfjGyhdUcG9YZzt
	DJBVj3R+yInEr4lcd/CsxFqB9cXS+yK+rGlZ4md+o6z1F6gaJVlwPDnFrfg479OUnZg0ALpB4mL
	Xp33L2MIC1/ZEIAFUA+pdqyIBWjs/O0qVxO+rMblxkSkbNqRnxW93wmPLz2HneUpDRY4hyHljX/
	KBo5mRuoDzDNZLBaqvQco7bjPWCG8w8wtFJDyYo8e5F580w0Tvt8CDF2hITezGNenZ6de1oDwdK
	RYFiOlYKmcKB8BySRaiHy6T4LyQGhgufqUEg53el4FvKbOAJojw2S6npiR17YPnNiP3MhlCeBd5
	M1gegM7MctpAYyWGCZj/34m6mYLh7X4yfRaK5stmQWHNh1vjZ1uyW696u7Uf92bELumuqPgZTYh
	7sqa7nnHXDeZ/fLWQe3ocw4Y+xR8R4mL7dcpvf2zuvoy9gC4rdfPjW6wmmebGijCYAXIgXmmh/w
	DnV8vELJ2Hdl1INTSSJ2UFXDLxRg3faDTbWnjID4JrzhxNVuvQgymtEoubxFuXvSOmnlRkW+dMy
	UC1ErWx/C4a4wG0fpkbfxs+PJsgjKN8BwCpEH8syR11IuQY+dubOWpWVnrHLb66ig0gevznOrw=
	=
X-Received: by 2002:a05:6830:71a1:b0:828:ca8c:f880 with SMTP id 46e09a7af769-85abafc97camr2542683a34.27.1793205943517;
        Wed, 28 Oct 2026 09:45:43 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 68/98] nvmet: accept I/O queues on the controller's port only
Date: Wed, 28 Oct 2026 10:42:11 -0600
Message-ID: <20261028164415.1262013-69-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
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

From: Josef Bacik <josef@toxicpanda.com>

nvmet_ctrl_find_get() looks the subsystem up through the port of the
request, but then takes the controller from the subsystem list whatever
port it was created on. A controller belongs to one port and one
transport: ctrl->ops is that of the admin queue, and both
->install_queue() and ->delete_ctrl() assume the queues are their own.
So an I/O queue arriving on another port of the same subsystem, possibly
on another transport, is installed into a controller it has no part in,
nvmet_tcp_install_queue() writes to it as a TCP queue, and an error on
it deletes that controller. The Connect comes before any authentication.

Skip controllers of other ports, and compare the transport too since a
port's transport can be changed while it's disabled.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 333739f14c2b..d01f8abed66c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1507,6 +1507,11 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
 				pr_warn("hostnqn mismatch.\n");
 				continue;
 			}
+			/* All queues of a controller come in by its port. */
+			if (ctrl->port != req->port || ctrl->ops != req->ops) {
+				pr_warn("port mismatch.\n");
+				continue;
+			}
 			if (!kref_get_unless_zero(&ctrl->ref))
 				continue;
 
-- 
2.56.0

