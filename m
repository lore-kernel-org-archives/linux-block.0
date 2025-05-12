Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D1524FBFF;
	Mon, 12 May 2025 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747018199; cv=none; b=hZ2ZvznwoTj1UQPC23jAeaV6cTPSqZpqYlXU94e3flkD7Hmmj5WfUfa0MnUNKVDWzdMSX2Rdz0QnCFkkJDFsfxnnuyuWMwzTIqyoYjptNoy5aBkAEKhJqNZCYSXP1tFgGcBUUl6stEhYo3Cwwq0UJpX7jzYZ60DrM4AQMzqBWR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747018199; c=relaxed/simple;
	bh=GWd0OhtOGaHtFqvA+97TszWCfujVfsGuoJ8lWKxPCfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u1R9K/Ag20qEH4a9CY5i4b33pI6TI1eZCcGuVnPGUqvZ1qb3r/npGDM4/h1Qe0CKgG6gq4YzMseRaspS2DN4icjScTIY7K+ijs6psZWNGjj3iiK5VBTZEYl/ssdUEIPemO5NM46fkEUBL1nDaRXmeq58RQxZ/21Cw7qGuTluDQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hORiPeKB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hORiPeKB"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af908bb32fdso3042033a12.1;
        Sun, 11 May 2025 19:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747018197; x=1747622997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Xn0UxaC2ldBuSBix2lJVTliOIsmpfCjFQjnK6KyfHY=;
        b=hORiPeKBvIGjtbMuei+7taNrQ6Bj2qXrlyScAFDkP1zounE2jOstWFncbE5DhQoIjB
         QsSm3dw4KwsScMCucB1aukf77lIUIpOQF2zMrJvGP7fSSOricoTRcRki2ixCkJwbJeRm
         /REwDg1tIvps0YSSEd3iS68ENiG1ZVZrfXUhe58fMtDhMon1H3Px5p/a8ICsLLRk8axX
         hu3LUsBiJliBMiXtoaHel/sS/bDauQUQx5UDlxzAdXEPdLpJD1+lNMnWT2A2viOA3cki
         qZvZg3QVwyJD4w3gyjz51quwZY1juo1J1xxvTg/08FBcJ0nFP4HFI3kysMSxUqmI7Axi
         MSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747018197; x=1747622997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Xn0UxaC2ldBuSBix2lJVTliOIsmpfCjFQjnK6KyfHY=;
        b=XZ9Ya6inb+ZYgBfsvN72LjzrD6VmeOsJI/gYFkKXcnZPGevKba3ZGgfl1wteIVm1w8
         Oz4qAsy63MqgTQJSWUXsFP98vG0eUB2daPCy0FARxVl5kFusdZ7TF0BLO5UX8+/ZvRlG
         dsR+b3QFXHwiQxeZrmBr9egbJZV3JCXyfxPXjn7R3P3EiVH4h99VDJBA7U1reA/5ykz9
         JY1rh+iYOeJeVZHsBqmnVq0ZWtQf6BRYk5CK3wwc3+h0rnJbUt/bJL1hKonRPy3zgmgT
         hnznd9OmRxRTWk7qJlAX+2Hdatmc3IhPWSxxUb5VSzLqxFQS4KHgA1KQTbqpx1Au8Vkj
         kjXA==
X-Forwarded-Encrypted: i=1; AJvYcCUIN2hwgEON5Z0e9Ocmk0KTa6RB9N3S2pAmIf84olSoKwCkBdQ7+Y2BzzV/mOppZUQyYDI9uRzB+HTDN8rtuKj+ySqO@vger.kernel.org, AJvYcCULoLZbjer7IMIKvVUE+S3+QUMKVeaqa9jYVhGqYoEZX5DFMmrpTCdj69zAxtYLqjXgVuhhRkWO0Obl6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMS0DcNK9pHN0RZxf+P5oQd/P8LXZ6SMQgWDg7hqiAvo19sdJf
	418KnxHoyx/DB1FIGscpOKgVnuMctZ0gIosV8gduAi3V0w943UO1
X-Gm-Gg: ASbGncsjajbsn3PMHspjWbiMvspiZ1tIu4TEUfMGqcJOzIDkC74AlXcYbRTZTC5b8+S
	5Wm7+lzaIyd3+p3hOYmTutENyGoVAsEkzjQu7QUFtu6dU2CKZ3FxPSUdpbPb7WnAsJMjSUZslE+
	IEpgxT3psVLu3LtiB6wk9UtZGJ8UlO+yZXB6yhH9JUGG4xxLiGLeIbqnGjHPhMXeKK/x910jYYP
	jS+sJQ803jVuin8ILLMaRXSgC8niqsS0rxAov24brc2YXUUvHuRXB2z7xiGn4yiB4vXyav+zejJ
	N4/WdZL4NajmlDeB2t+xjsuIemTXrZYNrGLMuDETJx2xAE51cyMhHpjabiNCnCIUrqIicXq7xHE
	eeig8Wyknbvt8WWFtbL6rHGs=
X-Google-Smtp-Source: AGHT+IEZLb0tNMDYG2FFIR2NAfhSeoHWZDgQb/fQeyOLRn/4m4pOM35xlZM3JgnSVKmonPOsoLs3/w==
X-Received: by 2002:a05:6a21:150a:b0:204:594e:29a5 with SMTP id adf61e73a8af0-215ab4ab9b7mr19064407637.4.1747018196810;
        Sun, 11 May 2025 19:49:56 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b234af2c287sm3938761a12.41.2025.05.11.19.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 19:49:56 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH v1 5/5] relayfs: uniformally use possible cpu iteration
Date: Mon, 12 May 2025 10:49:35 +0800
Message-Id: <20250512024935.64704-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250512024935.64704-1-kerneljasonxing@gmail.com>
References: <20250512024935.64704-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Use for_each_possible_cpu to create per-cpu relayfs file to avoid later
hotplug cpu which doesn't have its own file.

Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 kernel/relay.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index 27f7e701724f..dcb099859e83 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -519,7 +519,7 @@ struct rchan *relay_open(const char *base_filename,
 	kref_init(&chan->kref);
 
 	mutex_lock(&relay_channels_mutex);
-	for_each_online_cpu(i) {
+	for_each_possible_cpu(i) {
 		buf = relay_open_buf(chan, i);
 		if (!buf)
 			goto free_bufs;
@@ -615,7 +615,7 @@ int relay_late_setup_files(struct rchan *chan,
 	 * no files associated. So it's safe to call relay_setup_buf_file()
 	 * on all currently online CPUs.
 	 */
-	for_each_online_cpu(i) {
+	for_each_possible_cpu(i) {
 		buf = *per_cpu_ptr(chan->buf, i);
 		if (unlikely(!buf)) {
 			WARN_ONCE(1, KERN_ERR "CPU has no buffer!\n");
-- 
2.43.5

