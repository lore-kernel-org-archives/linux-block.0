Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205931;
	b=atpPMji2IPtJzRubJztxbWoHZbsXomDsMQjaa5SCVQdH9UQ+ptutFKfTAqgNCwUJ9Imf
	 naSLlfM6xFBcvPCk7Inks7V25yEjsEoQG1CRzGnmDt7MDHhttTnqU/KnpBLmpE+7zwepA
	 n1IurLVewE8k4CqzZUvXzj3iscqyY9z7znXWZlZ6PWHuyVDX29ukLtPGvwVwBzEEQhYql
	 ifDw0hZ1WgB8a+WqV/QFsAbjpfffGwmVv2ggKev8L2FQIihewygqmC1bffMHTc/BCyHDu
	 jGtUmNxkCESn0MY42MJrxF/ucLA7qgEXWaINZdrXKjvpLmrUukvbVIbjNuUYotxImgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g0BbxXEGqH/PMOOGK50C2TckR3vSjmU8GoAsInK43cE=;
	b=Qj0jWA5DlspVYQMBn/WHSiYUUR40bZM26Q+92M3nP9fJ3JEUOYWUgoAr8ZPIkPrnVhId
	 mEzg4ol+LA2KPz3PssoyNZN2ACnnGBgHbONL5o5yueXxiUtgEVi1MiH8aUqAUkNWs0M8w
	 oj5boQLyN+dtuUXcmoPYEx/f+CPYBx8rmHqkNrJRXYq+CwmjMg6gzL10hkqFNIqWE61Jf
	 PK0300/+E6nRVvlvWkSuHJ5JARW4ru5saMAUEzOPK6Dei2I98FQ5FCLZuAirXxbvVmZij
	 0w4rh62cG/al1BGR1p6R1moG/5Tx61Qat24ZZeR6e1xFeeSeLwTMDDQ7nPm+hd+s79g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="N5F/7YR+";
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59B8606A325
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E59B8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=N5F/7YR+
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-702dedeb70dso854629eaf.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205930; x=1793810730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g0BbxXEGqH/PMOOGK50C2TckR3vSjmU8GoAsInK43cE=;
        b=N5F/7YR+1wKeEH0eIkt4knZzy2IPR++EWDF6qu+7tAhlCYolTqZV5S+bGDXRUmqQO6
         Kwnix5Ol1YT1oq0nkjKuIURvPSApk8kcrrEelp+BUE7yEx5pTOn/JUH5SgMY4oS/Yp0d
         3UBzw8WypD+js7kd4HT9U/aIWJhD6+Xw0HaiHpyHnslklGa0J7kztbVubfBKX3P3kXMN
         7GwTizdUixsAqXu47lKdT8YiC8ROBdUXcvcnrcmuB4CPQpQk9dpJY6RhKkKGBrrLWp6m
         YVmbmFe9PpM/xXT34unUO0zL5LBLFebC8DFID1eIywpJwOt9woNAWMPBC2GlqXqCq9lb
         SH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205930; x=1793810730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g0BbxXEGqH/PMOOGK50C2TckR3vSjmU8GoAsInK43cE=;
        b=vR4pDq2zY2+JTkLE3srHnatyJeCxZv/u0gM9Kg9WZUpfMEAd5Z5gn4uT3bJDocoOa9
         ETWBMKO31ZPLKYutjFzTe8gxvhCNrxOTWgVAtZVlfh3APWJjP8Lnh1DEDh0MBAeZd5Nd
         n+sXtVxd7upwxFISeukevIr1Sani0HgA3lGLdRNn7P3FS6WLaNsOm2wByKkdA2bZ+9OL
         vKVmqjpAThAqSjqljiYvocWSjcIMWNBN+hKVqYG8bqKasTkcAIWv+3lbqITfn2yIsn/F
         z1G0vExCNh8fKUl3sd3zaZHZkBVG8iz59oKHESCccTZkz3jAOavhMD8ft9NuoeY4AVKe
         4OZQ==
X-Gm-Message-State: AFq9FYLD+jgQfXcz9Zf9JkZySGKzVzjQaGF5Pp1/chSMqJlBOWifoPzs
	Exz5T+PRqb02HnEg+ap7FHEe1i86uCNDspbjHy/I7IkCtJNZq26szkUabEBpMuCeP/3PdXV/mrT
	Y/X3RNtg=
X-Gm-Gg: AYBFou0k6ONT0dHeexuJEmE2wZcFvwrYuF2WIOXzk7W7wStR65ZsYjUMTLNMrGctNRh
	3boteQ8eH9szOdJW5T9L/rhryqYXCRUeUAQWsgSzfBjUG8tP2Du5SPH2DMRnjzfeFLaIRQPtmU+
	HjLpnKsTsHNQVgHapEovlAeRh8plG/PclyAk/1Jx7s3NZ3qbpiyUYuh9Cwh4ctyb77A5wbvb8LW
	FE3TzXYetYcGEXXJkoN2aXLadIKg+J2WbFAZPByZmky8mNrjq374OKE+QxoU+MqzZQYTahzAe9y
	mC0doq9qg3oQv3T59dZwcwbtnGktV1cPbfWaQX5FsW7aorVxEwrhaUyNHZTyceiLx2iZnVo+gs7
	ryRQgv7vX34d2dlzqf3KB+das/jTWdAktC9Yz6FDJ3W9tlIDq8GjzmCzTT/RwL1fliNk8Bv/iLY
	6QHy/WFaYSTW6v2cVWS1nfgLhnSQk06tGsEg8nqFU9WVPqBJ8dGgQxwQH6DG3EkKHM44QphA4L6
	eTpvtlDI33/jZ3f8+JPzwH3ZvZtDYdkh2tYLognsw49kzby9xdvcV25NrM4RnZC8HANxmXOr6kk
	Nid/N3pChpgVuujrJ7e1cXraoUBnFmkbwpShjrp0L0FhDfQ6v8afBoAdwXovwrEEhkA1DSLRf7Q
	=
X-Received: by 2002:a05:6820:3416:10b0:6e5:5dc5:14e8 with SMTP id 006d021491bc7-713f05d02c5mr1164589eaf.86.1793205929931;
        Wed, 28 Oct 2026 09:45:29 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 58/98] nvme-fabrics: reconnect if the association is gone
Date: Wed, 28 Oct 2026 10:42:01 -0600
Message-ID: <20261028164415.1262013-59-axboe@kernel.dk>
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

A reconnect connects the admin queue, gets a controller ID, and connects
the I/O queues with it. If the controller goes away in between, the
Connect of an I/O queue fails with Connect Invalid Parameters pointing
at the cntlid, with DNR set:

  nvme nvme0: Connect Invalid Data Parameter, cntlid: 1
  nvme nvme0: Failed reconnect attempt 1/600
  nvme nvme0: Removing controller (16770)...

nvmf_should_reconnect() honours DNR and the host deletes the controller
with 599 attempts to go. DNR is right in that resending that command is
pointless, but the next attempt would create a new association with a
new cntlid. This is not a verdict on the host like a failed admin
Connect is.

Treat it as a lost association and return -ENOTCONN, so the retries are
bounded by ctrl_loss_tmo like after any other loss.

Fixes: adfde7ed0b30 ("nvme-fabrics: short-circuit reconnect retries")
Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/fabrics.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 59f823dfbbcc..96d5ae6e1c39 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -542,8 +542,19 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 			NVME_SUBMIT_RESERVED |
 			NVME_SUBMIT_NOWAIT);
 	if (ret) {
-		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
-				       &cmd, data);
+		result = le32_to_cpu(res.u32);
+		nvmf_log_connect_error(ctrl, ret, result, &cmd, data);
+		/*
+		 * The controller ID we got from the admin queue's Connect is
+		 * not known any more: the association has gone since. DNR is
+		 * right about this command and says nothing about the next
+		 * association. Don't let nvmf_should_reconnect() see it.
+		 */
+		if (ret > 0 &&
+		    (ret & NVME_SCT_SC_MASK) == NVME_SC_CONNECT_INVALID_PARAM &&
+		    result >> 16 && (result & 0xffff) ==
+				offsetof(struct nvmf_connect_data, cntlid))
+			ret = -ENOTCONN;
 		goto out_free_data;
 	}
 	result = le32_to_cpu(res.u32);
-- 
2.56.0

