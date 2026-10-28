Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205934;
	b=WYr0UDyuY/e+ofU3zOSv2mBleRY9Oj6DDNUJVyJI+oeI9dNVRneGDaESwNIrGSbKV+/O
	 8CUwwLWl4rYMvPwLRTpqwF457lNi9IJwgMgP8gy3x2B5wdQ7UlznkWK7u8mzzngC91q4n
	 B3kDnBxzQt4+Fs/xU1FadvBbNQowWwdN9e+n/1E9NWgdfHtzCqild2KNia9YDeM/zrzWb
	 EuCFrRDX7uvb70135P/8fAlYcKTt5MO79nd2SnZ4EzrrmnrTdh1AyFo8/zz8m9ysUb7vP
	 mEndxZHI7C2tdKGQnJ+zI7NefSaDXkf98FOsnxsnZ2FMDoUiVHkYJPJi6sx5Oo49fRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IU9MOmP/DNYIBy+a0Esa3M3MWyw1kMu7zxXOFPkbXXM=;
	b=oFQn5aYonPcDxoZuEQ8Xl/EHMZO91QXg7fpqZwPHRQjB+EffzdRH1Sa3oN/DiyPgLaN7
	 Ax1g3aSImU9u+vkSN8v/kx7CU3JSexLluJdOgrf2u0rpjRFNiIbO5CiCwsHNITdOdUtBX
	 j1Z5xAZGuLHO/p2xzfmwMcWcB79VDcyZEoQ7GeRgnq0TgKO7ITAkHdwYhokAERShao93+
	 4E4GXBswjZhJQG9sAAdgphQROlidF6/AeAPjpjJW/iJZQWRg/s+ypUSwwBRHHnnlk17Sv
	 ax3rssT/M7P9W9zIREVnpelxHmMYxK6jVMy1J2H6xFMUtn5kWg9q8SsjEcqoaC8Zs1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MwPqTwG4;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93439606A326
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93439606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MwPqTwG4
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-846566246e8so1081040a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205934; x=1793810734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IU9MOmP/DNYIBy+a0Esa3M3MWyw1kMu7zxXOFPkbXXM=;
        b=MwPqTwG4aN0CbZ1pPEzQpGoX0SGLhkk4E0oVT6ngkpj1HvCK2xGgQY2LnWbOdjzh4G
         QFpFHd0NGJI+iXWlkApin8lXx9QhT9yMZDfnA8C7LgQ4moPshoIny/dx5ZWfuTvMu6Aw
         k9i8z5duqK7CZh8wPnT/bSgDKRfM0lJvqERd66zFQORUbx7uXq3VFA4wQ4ybie+N5uCi
         47rjDptN4/4guW8EM30PhYUqHRAUvB/YwNlvqpx4L7a86xsgb7Alp8t+QH7q+wyoOxlD
         zIyXTeRAnNmCEm+Ooy9L6PQYflxBMrZNnsh7IpVVTRwaYTIt24tKcoO4jGgv6I0Re/L1
         xXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205934; x=1793810734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IU9MOmP/DNYIBy+a0Esa3M3MWyw1kMu7zxXOFPkbXXM=;
        b=050BFYp0B1K1SGU554K/uDMM1J0urXy0tqiwdVToLRO4LHfSBbAgIanWdwSbTAuTRD
         Rnmd73/VCLamjMuM7Mb/Eu4lbj/XBz/Mr3cYGfHiwTy2wTJARSMpCVIBWX6bueLw5I+y
         D9nMNc3KEsKx+uh/q0YE701gXBOYsYc55pBeujrX0IbAQ1ZDeSjVhvj7BMANBbevv1E8
         tcp2GdMjA8Mbve6YoVQaHrRA+/VCNXjFMZI6UK69ZnWbdPZsQTeba0FCG4qA5lBr+Zh/
         EMGG9BWdHWcO6IzyOSPSEpwm10SUqXE8S/rFe0CaMyekEs3rkw2xAO8L0eGgC2AQu+9o
         XP+Q==
X-Gm-Message-State: AFq9FYK/KgSnajklssc8GmAMH0EyKirdSnHecXRjRe3Fj0rNfOOZqRvO
	rQij42hEWPecdQsd6hnHT71ykMShO94Ro96vG0gXEwzrcQMZCWEW5c7RDFR0NhI2twjX0gKNbpe
	99CFNoFw=
X-Gm-Gg: AYBFou1uEx1PS7saqJ0Ob/xdoFahntFNEZ94hkwpanLdYkIDvD3dClljBjasINgvI42
	b+/BKiMRR4wdNvgOjlKalWvplHLhaUZWdghDxZg7L54p1t+Q8f8D6518G21PhssMTFSy87jmeOj
	0d9h5V2+GN4mIzIYehopO0iu5qZy1cYbKNyPtHmeX+/6WXU0hjnldhvN0BaSw1vP6RGJcSz4Y34
	xe3EMHrLQgkEOxWnZABFp6AI6AEdlwRl9KwWoYQBKE9WQOgIEEgO8ETJbRJnL9WmbGfBNkh5BO8
	0WcuudzysGHCP7vsBb9wLmL0Ytk5OIRCcc1B6X4Syd1/Pzks/4cmREEZZBVTqgkHkc/piOsIBMY
	fFe4H2tjcMrsYdglTEXqfPQ76pugU0KGUD+SNcJ87vE5OoVDdSDdYW4BVDMrZbSX71xDHe1lbd/
	w0WgnPJNRQrh1mUJFT42l8WIuuCAOtDCQ5vlSmoY5YYivPl6FH7+bEszsiqZKQrfKQO4kn1UwGq
	pmsEUgD9D5ifMUkdQPhz3ExR+c3X6kjjQzgAwoMZtCnS/E7Mvpu1NMlBsmecSzPC2u9bhbILSjh
	5py0j+s5hgVpnPHU+Mowd0tHAcE2lb6JyXyHNV5IRdgmIaAzjgwS+LLGm4h+7f681wjju/o9Cg=
	=
X-Received: by 2002:a05:6830:4492:b0:844:53b7:9890 with SMTP id 46e09a7af769-85c20a9e8a5mr62052a34.8.1793205933723;
        Wed, 28 Oct 2026 09:45:33 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 61/98] nvmet-auth: authenticate the I/O queues again
Date: Wed, 28 Oct 2026 10:42:04 -0600
Message-ID: <20261028164415.1262013-62-axboe@kernel.dk>
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

Since commit c91a20129185 the target neither asks a host to authenticate
an I/O queue nor checks that it did: nvmet_check_auth_status() is true
for everything but the admin queue. Nothing else ties an I/O queue to
the admin queue's authentication. The Connect of an I/O queue names its
controller by subsystem NQN, host NQN and cntlid, so anyone who can
reach the port and knows the NQNs can attach a queue to an authenticated
controller and do I/O. Property Set isn't subject to authentication
either, so an unauthenticated host can enable its own controller and
connect an I/O queue to that.

Ask for authentication in the Connect response of an I/O queue and
refuse its commands until it has passed, as before that commit. The
Linux host authenticates every queue that is asked to. A queue with a
TLS session is exempt, its peer held a PSK the port accepts, and since
commit ecf4d2d88351 such a controller does get a host key when the admin
queue re-authenticates.

Fixes: c91a20129185 ("nvmet-auth: authenticate on admin queue only")
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/auth.c        | 14 +++++++-------
 drivers/nvme/target/fabrics-cmd.c |  4 ----
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 0f64fd4ade59..9ae8293cc734 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -275,13 +275,13 @@ void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
 
 bool nvmet_check_auth_status(struct nvmet_req *req)
 {
-	if (req->sq->ctrl->host_key) {
-		if (req->sq->qid > 0)
-			return true;
-		if (!req->sq->authenticated)
-			return false;
-	}
-	return true;
+	struct nvmet_sq *sq = req->sq;
+
+	if (!sq->ctrl->host_key || sq->authenticated)
+		return true;
+
+	/* Whoever set up the TLS session of an I/O queue knew the PSK. */
+	return sq->qid && nvmet_queue_tls_keyid(sq);
 }
 
 int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index b451029ab8f4..38311187d27a 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -251,10 +251,6 @@ static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 	bool needs_auth = nvmet_has_auth(ctrl, sq);
 	key_serial_t keyid = nvmet_queue_tls_keyid(sq);
 
-	/* Do not authenticate I/O queues */
-	if (sq->qid)
-		needs_auth = false;
-
 	if (keyid)
 		pr_debug("%s: ctrl %d qid %d should %sauthenticate, tls psk %08x\n",
 			 __func__, ctrl->cntlid, sq->qid,
-- 
2.56.0

