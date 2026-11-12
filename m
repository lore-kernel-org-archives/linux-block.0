Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491225;
	b=nwvvi4UOmDg+TN45aKdakM9tXCxpI3Lv8/NwukdL8dWpMkaLY5yUgrKkVk0QP8vpq8Oz
	 kXWDZp3WCSMfdtaB12YwIChokYosEZ70Q6tNCTOdzDzA5VrP7pGW4OTOW75iRi35dqkkd
	 xO36B8JHut8p8ubvVgWX5LQsOxxrJbr/vA3/U7c8d90Ah5yc/oF8w4Cz5ZRfg0Uka/1W8
	 LrY6eSdJwIOMzucC608uY6awNoKYNG+oCCyy/RWZcH1AU3nTtVljZf44kk4cZSMQdBQGC
	 q0FqIggmoPWYvDwWNgJEaYjdpDtAouHwOFA2ieceMSadEBZn6Q6fI/xkycuPXqA+l8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=At9dnyT/4q/wJJ9tfHQDwKMvIA9o4nNPXbuYEoFso6w=;
	b=udLHHFQgsdIR1161Vs8P2+Jh3iOIQZF2e98vcnshZT7LMKg4lBz+8UDliu6NLRt2p9nn
	 iksjZJMu2o1VQHYWI8cAQaprUOmX61Kpyxe4VXuazku+mmtXXMLRu3fa1JOAdaG/ml2Cs
	 zl+Lo3b1qdxQ7TkmCGOphUgsEV6d9xXzHbq909JG0Jq3ev9/JgK8nR712xguQ/0wkbmug
	 nMjIJGtDKyh3HfYjPpL9GVtdzSbvUCC8bmk1Azz2hZlbAh5vRGDyXNdZ+P2uniPg/o+X+
	 +lW4XjOTFkjMS5IU9ron9dW3chJy9UvmfxEiFyGAMm5RuIQSlJafCloaC5sjgrVGAjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloud.ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=Fm27Yuq9;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109BC606A880
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 13:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 109BC606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=Fm27Yuq9
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4946589267bso132008f8f.0
        for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 05:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1794491223; x=1795096023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=At9dnyT/4q/wJJ9tfHQDwKMvIA9o4nNPXbuYEoFso6w=;
        b=Fm27Yuq9g7zEqILjHO8VSWuJNFq4DrD6kqa1MUcXpyXdfjc16G9jkLcHADjhHFO+SX
         6EiMtZOmwH7i8vIYEqg14qvjz2PZFGAS+bwQf4ApqcHOCaX65vYSCtAemyHSY95qRSJP
         QLQUKnw/Ewmf30XmRjyHWK5iga3UBw+xW6IbwUh+JbJItzusbgI+crjcSRhmltNrCmiF
         VRZKk25hGlHbMbVKPZbIvL6fpoJytG9KNh2r1wVhz3vp2zuaIERwCEBVc0zPmOSVQPcF
         6yVcPlJSb5KdJiY8DtuOaVqw22+B0IjziubW5L4oOEyzB+zZQjBRE8vG24gvJaPF0zjX
         ErTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794491223; x=1795096023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=At9dnyT/4q/wJJ9tfHQDwKMvIA9o4nNPXbuYEoFso6w=;
        b=Ty9kzBCpaenNRwtkHbPVxJBgZkODbMcYFE7R1IlMc0oGzfryqlnkassDNWpSe8/tvh
         Dc7wwZK7mS/9Rs+u1sq0aHSXVemfpKbnXyj8XOBgC8AdZtqecWSG0mUVQzlqTwy+eNzg
         eOKX0iiXI+02Zso5/L3fW0GExgwh8xlQz0Bouj2AdmYE/eI6ILynNKc+uJL4FdqsvV8F
         W28z7ynYRVhQtLzDl27xCK8fZIO8GksytfHQuTbhPnvb9lV+s1f6PMswq56iMrw4Di49
         QWUMhhPHi4vanV27OTj8mDA1gEscv7/W9ejKZcwuKkAcyyO5xRa4tk9iWBZX4em3s/yg
         /FWA==
X-Forwarded-Encrypted: i=1; AL+hErFKki+PJCYmt3AkbVR+CLK8HnurE5W8N7PZ2k5+O4YqmxYyAO7oKxUnCo72VkH2fwaY9/Sq0x3XKSIgMQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8ty/+x3v9kQL9Odjuq7emWkdrxnTR0U55PSNQgVSlKzLEbr2jX
	gXHF1leDjheRpuUFWT5A74R2WMvrBiMIm9oZLdmGMs1QYEU7yE4W2WAMORh7jiGWlUA=
X-Gm-Gg: AYBFou1uqsHCP6RHVr6A8oz/sK5yTLN68ehFipqXjrJFLt4PC8onvInzLieVIhoxzFw
	Gwc2NMsajFlEwDOP1c2/zdQiytdIxpWPVv89OMdvvLdXexmWTayVsswO8n/UbTjvpywJtU4qFCG
	1wT/7FMQo0kOTjF0BGYHdEhhCo8PdgHFza5n2BrEoKE4lrG/J6g2HuLwsz/Sz6c+c3NwyrZtZZY
	ugmN1T1C6nJZIN2RGTd+T0zzXfbLUkeIZx3gmJ1igxQcMrs/h6HI4M/wAaWIafAdhB3y9AI1BiJ
	h8iq1mWxSKNs6LF1CGBuHE9wUw2FX1iBz7QrgXgGvIUcghbf6zMI0BX4jQV0hEhDmSEwPrfo+5n
	Q3OtcDHibMner93FqAFr7PUBG3mjdnyqFBFhtSA/3xYMaasGWkifiB430qOYEXf4AgnaVA/mbrE
	QpuM0THooHnEtAx5gzUBri6qizyn0qm9a85fROc5dzO1aFM1MlYUC2CYn7Z7nBo1IObdlPTM9sO
	cxpO0nk6vjBVKmQcmlVvvIMG1bzbRnFpC3rTbtdWebwQcLnvVZSqf1V/vLF8Ft9tHTh3hKN9dKl
	1dvb8EwocX0PcvIXIehlfMvot1AVgsDRkW02mFnkQHC17hqlGfVFHw7TUsS5REEvV90Y1sAPGS9
	Jm4CoMQ==
X-Received: by 2002:adf:e196:0:b0:48c:6611:82 with SMTP id ffacd0b85a97d-499c434be3fmr10614340f8f.1.1794491223476;
        Thu, 12 Nov 2026 05:47:03 -0800 (PST)
Received: from jwang-ThinkPad-T14-Gen-6.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498367b99bcsm17665990f8f.51.2026.11.12.05.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:47:03 -0800 (PST)
From: Jack Wang <jinpu.wang@cloud.ionos.com>
To: Yu Kuai <yukuai@fygo.io>,
	Song Liu <song@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] md: suspend the array instead of freezing the queue for limits updates
Date: Thu, 12 Nov 2026 14:47:00 +0100
Message-ID: <20261112134700.372702-3-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112134700.372702-1-jinpu.wang@cloud.ionos.com>
References: <20261112134700.372702-1-jinpu.wang@cloud.ionos.com>
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

Provide ->suspend() and ->resume() for md_fops using mddev_suspend() and
mddev_resume(), so sysfs limits updates no longer freeze the queue.

mddev_suspend() only waits for active_io, but md_submit_bio() reads the
limits in bio_split_to_limits() before taking it. A bio already there may
see a mix of old and new limits, as with mddev_update_io_opt().

Fixes: c99f66e4084a ("block: fix queue freeze vs limits lock order in sysfs store methods")
Suggested-by: Yu Kuai <yukuai@fygo.io>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/md/md.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 03e35386a802..c9fa4e99569a 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8669,6 +8669,16 @@ static unsigned int md_check_events(struct gendisk *disk, unsigned int clearing)
 	return ret;
 }
 
+static int md_suspend_disk(struct gendisk *disk)
+{
+	return mddev_suspend(disk->private_data, true);
+}
+
+static void md_resume_disk(struct gendisk *disk)
+{
+	mddev_resume(disk->private_data);
+}
+
 static void md_free_disk(struct gendisk *disk)
 {
 	struct mddev *mddev = disk->private_data;
@@ -8689,6 +8699,8 @@ const struct block_device_operations md_fops =
 	.getgeo		= md_getgeo,
 	.check_events	= md_check_events,
 	.set_read_only	= md_set_read_only,
+	.suspend	= md_suspend_disk,
+	.resume		= md_resume_disk,
 	.free_disk	= md_free_disk,
 };
 
-- 
2.43.0

