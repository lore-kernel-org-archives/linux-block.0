Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31632330329
	for <linux-block@vger.kernel.org>; Fri,  5 Dec 2025 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764938872; cv=none; b=gRb4KkwYraX5DmC8HEisno4V8B0pfWozqN6M+WbGBHZebv+bNMW/J5WI36yjIiRZs81VmFg+j3UfzYZJZ1g99OQebaajNhKDyXUoxUR8KwbO9qipXVNB+w6hOnw7Gq9eU4JPcYtOB8SOcytSjF5rox0vhaJRCJMwBgLKjQIHmus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764938872; c=relaxed/simple;
	bh=Ybr3pXbcRmT0m68YHGxN6LwuScUpWDuCtVULJK/mQD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFUsFE2RVnYjKej7KoDVy440rb1LbreLhSJy/okhju03Ao/Oi0YJlWwjR8oTRnaEu13rsFjAS/8Q176BmpgbddWHS1mduc2T0G1zYV3dJ27acC+gQdtN5AnoZkFKQUWX8DvbVILkOYme4OCoGqM4C7NJCSVPZbxwp44r+NUokgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=N5lmXBfr; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="N5lmXBfr"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42e2ce8681eso1495474f8f.0
        for <linux-block@vger.kernel.org>; Fri, 05 Dec 2025 04:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1764938862; x=1765543662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Xsi/u/jSTR/b5hCyqT8OwuItwdlKKYVSB2ANQp3EgQ=;
        b=N5lmXBfrkwvPVrZAt0y//WdcQx1qhf6nzMS4Tu37hY9VVWLmsXzIl7grXm1u9czbY3
         KygidyZOs0iLGQ8G54/tjd4Ri5T8eOOAzkMvqHFgyRt1IEUdN5bhkTOIcVfvPLCpSPCE
         wwZYxhTogJcq9510owpkUBbMZQojhIGZNbEZ0SQQ6dBPjk0t6+f7bL+Cm51hjwjObWAi
         RkU73b1ZGJqwKOE+3i/5jZPv7YBQvYTSS+LxNEmjlPIzFrCzPcyo8hO//4W09uyQb0m5
         +fxTlq/vP96U3PlI6hdKYs789Q7C5rEQwWqIIU/oZOxai9+qb4eJd4OhTf+5OKiKQyiY
         qnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764938862; x=1765543662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Xsi/u/jSTR/b5hCyqT8OwuItwdlKKYVSB2ANQp3EgQ=;
        b=xC5gVz+YK1nDZ5tvgIAqA/09s3gr1MqnWtRh/z5UgYrjGe8sncl3T+L3P/WerPxNef
         FXQNCjJDwF/D9dci4XzPpTF+4ETYy8aL1iEFNPKLdfuwaoYee0NIzXckg03qsNDYf+qI
         BCFR78PpzCVHKqKTEJ+mEx9haer9ASvhZYukJX+FtTtjFxd4qlsSMqs3BoT1T1bNwGXc
         QkR4lX0wyucUzNMXhbHgVFwNf2bifxTFnm6aoWIZYilebOnheLSudpgSmhg9GkcbG5oM
         g92FXVzKRVcvI+CRuZ4YW/JKyn81GzPWyNoFFcULG8BfyjYIFFBvKxf4o2Pdodr8QT+a
         fkXQ==
X-Gm-Message-State: AOJu0Yz8XhE5oquPZTBrWs+1PW4dY4/iIcrtRat8p7hHQ64NyU2k+KiJ
	xl6pmHaGzfaHWTa6KyiXAnW382hGS/JJr29ath7vZeLl4Yt4Tyjh0sIG40b+wNRelIqgRlQ6r4r
	tDj67
X-Gm-Gg: ASbGncuOJWcqWpve/2oIDwRzVfcMBwtn1KzorYtCrBsMDIpjuf418KCViMSAAg0hm6S
	dJjEegKOt0Y52l/utXK1X9T3OXEot2hF/4GBlgETtSVoqEULDKyUf2D6pLgzrHRzTcwYkBHVXvw
	yHtepx/8lwOmvuDnFbwtpmQ4XxOA8ffU3055otIP5lHllySDlKknYj+T+Kq9kck7LSt317WW4+b
	plBGTgNRCNbJVp8k1yCwCMxmAKxTwgv3V4rAehq62fhtXqMPymPPSQM9smFsdgNxNhZnoldiqqa
	hOQajOVb1KJYSSwOytJrKP+PGnO9+PZEzjFks20wrBDDsGcQXiXO1OPi9pos95KjOOhc8ExoV+q
	NyKdLSk0TWL2fq36eOeY0XjpaXhfsgYA/m1Jvv6/Y7U0rIZ47Z5kb9EhzW3xOQLkA/wfHaJDGbv
	VKc7SC7Dw3daYXksS9E54+ibJxyWjlvuDk9Uwxm4Vi5eldq9dMnz39ixl83sIyESz4cXEfA1B2a
	OrVWuMXtyrOv3CvD/6dlA7y
X-Google-Smtp-Source: AGHT+IGjVDdpUtcqk3c0bM45g/z8wI8P964wcd8vLPho8yw37ASHgUyvfu5X/EGk3IIcPdKTi2Y4FQ==
X-Received: by 2002:a05:6000:2502:b0:427:914:7468 with SMTP id ffacd0b85a97d-42f7317d51dmr9969050f8f.15.1764938862308;
        Fri, 05 Dec 2025 04:47:42 -0800 (PST)
Received: from lb03189.speedport.ip (p200300f00f28af70a31ee45bb042915f.dip0.t-ipconnect.de. [2003:f0:f28:af70:a31e:e45b:b042:915f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfee66sm8540037f8f.11.2025.12.05.04.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 04:47:42 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	bvanassche@acm.org,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com,
	Florian-Ewald Mueller <florian-ewald.mueller@ionos.com>
Subject: [PATCH 5/6] rnbd-srv: Fix server side setting of bi_size for special IOs
Date: Fri,  5 Dec 2025 13:47:32 +0100
Message-ID: <20251205124733.26358-6-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205124733.26358-1-haris.iqbal@ionos.com>
References: <20251205124733.26358-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian-Ewald Mueller <florian-ewald.mueller@ionos.com>

On rnbd-srv, the bi_size of the bio is set during the bio_add_page
function, to which datalen is passed. But for special IOs like DISCARD
and WRITE_ZEROES, datalen is 0, since there is no data to write. For
these special IOs, use the bi_size of the rnbd_msg_io.

Fixes: f6f84be089c9 ("block/rnbd-srv: Add sanity check and remove redundant assignment")
Signed-off-by: Florian-Ewald Mueller <florian-ewald.mueller@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/block/rnbd/rnbd-srv.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 2df8941a6b14..9b3fdc202e15 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -145,18 +145,30 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
 	priv->sess_dev = sess_dev;
 	priv->id = id;
 
-	bio = bio_alloc(file_bdev(sess_dev->bdev_file), 1,
+	bio = bio_alloc(file_bdev(sess_dev->bdev_file), !!datalen,
 			rnbd_to_bio_flags(le32_to_cpu(msg->rw)), GFP_KERNEL);
-	bio_add_virt_nofail(bio, data, datalen);
-
-	bio->bi_opf = rnbd_to_bio_flags(le32_to_cpu(msg->rw));
-	if (bio_has_data(bio) &&
-	    bio->bi_iter.bi_size != le32_to_cpu(msg->bi_size)) {
-		rnbd_srv_err_rl(sess_dev, "Datalen mismatch:  bio bi_size (%u), bi_size (%u)\n",
-				bio->bi_iter.bi_size, msg->bi_size);
-		err = -EINVAL;
-		goto bio_put;
+	if (unlikely(!bio)) {
+		err = -ENOMEM;
+		goto put_sess_dev;
 	}
+
+	if (!datalen) {
+		/*
+		 * For special requests like DISCARD and WRITE_ZEROES, the datalen is zero.
+		 */
+		bio->bi_iter.bi_size = le32_to_cpu(msg->bi_size);
+	} else {
+		bio_add_virt_nofail(bio, data, datalen);
+		bio->bi_opf = rnbd_to_bio_flags(le32_to_cpu(msg->rw));
+		if (bio->bi_iter.bi_size != le32_to_cpu(msg->bi_size)) {
+			rnbd_srv_err_rl(sess_dev,
+					"Datalen mismatch:  bio bi_size (%u), bi_size (%u)\n",
+					bio->bi_iter.bi_size, msg->bi_size);
+			err = -EINVAL;
+			goto bio_put;
+		}
+	}
+
 	bio->bi_end_io = rnbd_dev_bi_end_io;
 	bio->bi_private = priv;
 	bio->bi_iter.bi_sector = le64_to_cpu(msg->sector);
@@ -170,6 +182,7 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
 
 bio_put:
 	bio_put(bio);
+put_sess_dev:
 	rnbd_put_sess_dev(sess_dev);
 err:
 	kfree(priv);
-- 
2.43.0

