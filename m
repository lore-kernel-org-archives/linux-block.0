Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9518450A66
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 20:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715372629; cv=none; b=YXOKSu+ffxusYQu4h0CpwSiiteUATJnh4Md83lqyGNkIG2mV7Ff7CLdSyou92S8AfBiNhRlJv1MNXasIXsbr2sNcB7NoDUPYc8Sav9IgAgPzK40p4RvIdApNBXYjtSIRwZUTDARZJzttLPGMNEkt9P0Tjwi1F6aGmQ1YTsMjjD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715372629; c=relaxed/simple;
	bh=GGmXYLda3aUshZYlnfpM0J4P6wlT9Bhb4G3DwmMVkKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HI9ClhoJXpH1ZTzD+27OEX6vk3FWC+sJEtwxQnYRdnwQNcPf/2PWDQ+ymDore5ibtizdHhsPFJy2c3fCfnk7Mojf71BAt5fXdpx6s4QdUNidSppwjkgOyH/+Adc9eYANcKRHWBQsCk8yDpMUpU+slcrTGfOL/jxGXSwCZq3jSVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=LOcQZjvz; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="LOcQZjvz"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VbgLl6Sgpz6Cnk98;
	Fri, 10 May 2024 20:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1715372605; x=1717964606; bh=rKr+Z
	PSBQvSYhNcTe1Dl+1VPya0C0a3BjPn8yAwdUII=; b=LOcQZjvzUFz9OdGCViS2o
	HPlx6dFR3chxYii1yrUBBOpsc9ZGgLuFrkgpjyfkMN3M/6pN9uRO6/2LEnKLS+2b
	an2igFjSjrrcoH3xPzV8RkhOLutQ4jL6z77xEPhI1lMKIcV9q7boRQhiIKoukVS3
	KOxTx8SCirKgiwrSRYboj3YLk5akn2j/F0AOjmEg23JsV+RQiy8NItChh4Ion/Ep
	P5ZqpcFDgC8ztCTNbdYD/1RpT0/XXu+gPMt6PjhfjP5+LMZl9z1BlhFPjrdgZ4BH
	K6NUusPK14tfHWG1gCVkHqmj3BlOnNBtrz3He4okAFWayqPAxhyDAPb3lFtF0A8V
	A==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EvCOWkilxcSy; Fri, 10 May 2024 20:23:25 +0000 (UTC)
Received: from asus.hsd1.ca.comcast.net (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VbgLh1G7Mz6Cnk90;
	Fri, 10 May 2024 20:23:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Josef Bacik <jbacik@fb.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 2/5] nbd: Remove superfluous casts
Date: Fri, 10 May 2024 13:23:10 -0700
Message-ID: <20240510202313.25209-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510202313.25209-1-bvanassche@acm.org>
References: <20240510202313.25209-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In Linux kernel code it is preferred not to use a cast when converting a
void pointer to another pointer type.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Josef Bacik <jbacik@fb.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: Markus Pargmann <mpa@pengutronix.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/nbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 9d4ec9273bf9..90760f27824d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -222,7 +222,7 @@ static ssize_t pid_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	struct gendisk *disk =3D dev_to_disk(dev);
-	struct nbd_device *nbd =3D (struct nbd_device *)disk->private_data;
+	struct nbd_device *nbd =3D disk->private_data;
=20
 	return sprintf(buf, "%d\n", nbd->pid);
 }
@@ -236,7 +236,7 @@ static ssize_t backend_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct gendisk *disk =3D dev_to_disk(dev);
-	struct nbd_device *nbd =3D (struct nbd_device *)disk->private_data;
+	struct nbd_device *nbd =3D disk->private_data;
=20
 	return sprintf(buf, "%s\n", nbd->backend ?: "");
 }
