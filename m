Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205894;
	b=1SOyO6BvfH5U5KU7GnHqV5u0Dr9Dxjp5CDLfR723ESATrQ2n/vTwzkM0+KdXUNAG5cSH
	 mlOj4jS6i/PUTY10ASi1z4T1uMV3c1+De6+UZmgiAXPzEUyHfjyCfQcOwfiTWuRwQH1Ql
	 0vqV9IvetkKiUQVjeFfeWbWK0hjeIDvt4vcp78CdWMJKcQdCWMfny0woPCgkqVbV08YJW
	 PXBYZNNw/1Vma/ss81WySDSkEanJ1kHP9RtFarVj9n4mh5KSf5GF5D98DxbbckTdRPvDi
	 9FOJD53MYvPeV4VTtrw0FIWl5zPqkwO2GD7SyOmkFiwtPEtf+6b9AVMh0RfQI7XAgwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7DcT95DMliIQqoDKKifvP+oEA9nhkiqbXl+EjjWGsR8=;
	b=ycDJcJlssXP+Ucw5VXZ0vufPHK/ToqzbOAjHc0xQDZVRA2YHSSNXKBa8wDk3BeQEgtYL
	 CBoa/ZdywUPMSmm68zzYCc0N3r2I7cu+f/ig2QXylg2CSHGWyNFIVs7IPG6xQ53VcEF02
	 1cz+h6TqLklcyt8rkyqY+Cn+p5KYkp+H7e24oViT9Urr1C4f0qQ5AZ9gdVBTpugDfFHgd
	 hzttfGc73xmHQjXSFcIurNeMa9S+UZDVkMqDD74mp69GFGGd9xPj9mUr0NHfcnhJ0Nh/j
	 vLI82d662LhGE9OU0AfXWD1ZjQwJ5ZlbmIENrcgun9+H33QCm6Wv2PbDfQH2Jz3dDHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jvCm0NRm;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C76606A324
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27C76606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jvCm0NRm
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6b8e2d8df4fso963435eaf.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205893; x=1793810693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7DcT95DMliIQqoDKKifvP+oEA9nhkiqbXl+EjjWGsR8=;
        b=jvCm0NRmHA4OMJOFehmagpCaGrOsPkwlNM6iBIQV8SjBxQhMDojsuaqsxX++b4l0jG
         pzxMBqWvj6W/SmAo5EazBdnkEeZnmhpaJHnaNhCSutCbKfLpmGFv9WRvdUu09EAWCpdH
         BU4vIB2xK2C048pQBd/UGTiK40buv93uqwAPkogMbwGxUJP4PKdIxCbf9xNWoHR2K05V
         cBR54HcWIP7uLNsbR+0zWY7Frqilt94x6GQu6aQsrCDlwohKW+yj7VaOf4Uq1+nCuEUa
         6S/zy8ABocITAQfksFJNrFM458vWMmDtctFJftXxsz10IfLz0oDGYQJ7GhZpLKJdNnlB
         6O1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205893; x=1793810693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7DcT95DMliIQqoDKKifvP+oEA9nhkiqbXl+EjjWGsR8=;
        b=xk9Gvyz2nQZQhuiCrfk/URYZP/XJr+CqrPOKUAVrDH5mKG9M7zyPB3OBDyuBwNS6An
         7uspVu68lxhe9ywHyLvQdqrt8RfAX2ZF8fxmrniBEWf2xYyMbpAn5CqSX+TWK7rh5ANd
         N0On3E3m85gCG44PjaFeyZIGy5lSNZa7VnOL+e+vfoAyhLKI6/btCs659NpVw4rbtBgF
         G0kK0G7EewrSV6fQWSQICY/ElQiSycVuqUP+0H2puAkTWxV03rLuPtQ1m2KlTYlg6tPp
         5XAAUQtrcGlbeFhXUJEqT/OsxJE9JtIODJvafOqCBata55nlsY8RPqWZVk9M7q2jscr+
         Uy3A==
X-Gm-Message-State: AFq9FYL34ila/hzH4zhYRwB0nKw1nw/R4Bjs4Zgrg3sDKOPhtAUszKX1
	g0yCqSUPdIL5nzqX9OlKTU/KKBvjFprbvXu24BIQZwFCxjlWH3mr6J8np+K0YlC0SgQ/6WQKuGk
	1bSwFYHA=
X-Gm-Gg: AYBFou2Hg48m5Ap0JKsKPz2VRTmAvDgQjNsj+e2S7ZWTRoEwO+6aHOj+QDt9d6RJg9A
	r/RJHNwk7QjERTV6qq/FfuiahBLBroZQuTEEI/5SLBiOUC+MV0Nx3st8QG51V48IG5Aua1Cd8ZJ
	dN48yBoxCA9hXCqMwa6ZW3Is2Sn6MSDRxoLZpp4riEsPpSdR582UqsRgXztRGqpd8F9Jj/L884W
	dSsth8S7sWEvekbNGbUHPZikath6R7c6vFBBtcxXsx7goYD3GA8rCAzMkzJATAMQT0IIBWkQSPo
	hQ83XibPi4MfgDDJI32hKhrsGp1/41jOvSxWWRWz9cxEDmtZvnnW09XLzUybMxal5bNnt2xUKzb
	Kc14F/4E4Kv8RGJLwgiywC/nUoBKYekAd3GRo8KxmpHFA8ZQBtRtcQMWcT8lXRNNjJqFRE+K6pU
	QFGnXs/AxKJgE1uyP3HtVIfGv+3UAJlYjRZicsaOy2uQ9APNRX/R43yNLXTBMXiUbw9x3WpDGQl
	8p3/b4/vMeJ4MhvJoPKj/kiP9KjRj+4gDe+vhGJHMI7/Nk9n2gPvci17doMXk3GB6kwg9Y4Md0k
	qn2WW4iqe0OR0EBgq4RPC7/9OsA5kGl7CZEsGmC5tvzKGZfi7V9w/yHndhOilWZxcukMDRaUlA=
	=
X-Received: by 2002:a05:6820:350e:20b0:6da:3a3b:527e with SMTP id 006d021491bc7-713ef438b7cmr1219843eaf.81.1793205893139;
        Wed, 28 Oct 2026 09:44:53 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 28/98] blk-iocost: check again that the disk is alive
Date: Wed, 28 Oct 2026 10:41:31 -0600
Message-ID: <20261028164415.1262013-29-axboe@kernel.dk>
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

blkg_conf_open_bdev() checks that the disk is alive under rq_qos_mutex,
but ioc_qos_write() drops the mutex to freeze the queue first. If
del_gendisk() runs in between, the tag set may be gone by the time
blk_mq_quiesce_queue() looks at it. Check disk_live() again after
retaking the mutex.

Fixes: 9730763f4756 ("block: correct locking order for protecting blk-wbt parameters")
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-iocost.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 7b5d865d8c14..bfb0dd320c4a 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3322,6 +3322,11 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 
 	body = ctx.body;
 	disk = ctx.bdev->bd_disk;
+	/* It may have gone while the mutex was not held */
+	if (!disk_live(disk)) {
+		ret = -ENODEV;
+		goto close_bdev;
+	}
 	if (!queue_is_mq(disk->queue)) {
 		ret = -EOPNOTSUPP;
 		goto close_bdev;
-- 
2.56.0

