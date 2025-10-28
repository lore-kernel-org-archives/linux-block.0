Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8056B2571A0
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672735; cv=none; b=Z6Okin50QWE/CdDs+BvzM20oS8hThxYEMXxSltZxP9xzlk0DS6Hx0x02BMwvQIkm2NdRXFb8MlKnwKEMUs+Zd4ahCJ2ybIc/SVT5ezpX1QP10DAKkG6ZIXJ/G2SfYY01988D27rjd9hCyKK8l8z0EXc3wn9/k7yWBopUn633T/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672735; c=relaxed/simple;
	bh=0vS3N7Soa4g7PYjFL0nKr3kXyVf5rWwjh7etBfTatEc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CAnmxiZt4uoBMM0SP3Bok3v2sMLLRD3XW77UDPC6rkNBP+v5eUyVcBHXKipxl4HKFv80XzQlJLeh8zN8qAdN24oFoWrnNmM6MRbcfBNXwefl/fiMVkiYRVKzg6r5PEylmvMxjOcfxMoLDMfkzYZTY2yx1RiA1pksAGb7tyWVzjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAQKpe0u; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAQKpe0u"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-269af38418aso69482375ad.1
        for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 10:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761672733; x=1762277533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7UrFn7k+xc8Pd2/cu+Nwj/xLezKCLVWGsy8x1XSrvek=;
        b=AAQKpe0u8G60wXSr2wWohpQEI0eAKngL9Y+sRLfYo9jwKa2uezejcJKwOUwwYiKEvt
         GljKggL948hpKDB9XQvMeIyUoPVr656PYvJNiJRyj7loYQthIl4aC90iwJIku7PoW9ct
         V6Lz/9znpz1D/HuWJjutoG1ZsJwjuQ6NdrvDVhzVGU8/7WqPnEUmlmHIsaJ32gAJO7aU
         vYz2q1ABTJcyBDeMylrQFRpDN3GZ/bxu+WnYK8vE+UO4DAhqYWLoKJHdjd9DE7p3l8Gi
         gwo2DxIeRccyn6SS8+8OugKhj3OaelOm/R2z4K/ioiZcngRmGy46OVIBqfqjq0W05rCd
         ktAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761672733; x=1762277533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7UrFn7k+xc8Pd2/cu+Nwj/xLezKCLVWGsy8x1XSrvek=;
        b=fq7Y3dGUvBzMwoLAjppij9Mq+KfcVi6EXSng6AncgewqpmjNDenM6PSRbZS2xb7n09
         67I6gokREBmbgKUkRQeSZz3fs5Gy+VSaTLzmGQZETGgW94aJXzBAzW8+PC45eG9pPceT
         w4hvE8hyx+yAiYggDjZwU2rq6rG/O51e9w442QXwKpse60i8e0pRSx4q5RfJp1Co8de8
         ty6KM8fvehieBMFZtfR4JT4f78/GgkOdG88V43qvX+taMwYytyikShyPujkbyaelaTyW
         9Yw5jMd9mGN/nfFVTFWvtkBXccv1RtmGEvSt7NAZWjuvXkG1ic5KspfVrMdJ7TUWx58A
         Zt9A==
X-Forwarded-Encrypted: i=1; AJvYcCVoapCn06XonZRzjaKxwnT5laauguRu0szyWdelXcT/Sfp+HXtrC1r3N0n1VAIFdeVVvZAF7ZqB+az0lQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYrHBRx7WIqhJ5A05m6cP9+SkHxiIolxJawzKrRN9olFiOfMW9
	upAGYDcosXFNZqCIfN1abGf82N4ioEPuru080MGEl6i5mWpNrSRWvOR4
X-Gm-Gg: ASbGncuy2G3fjKMAVjkZ4ZyCX5lcQla6o+aVrLM8Kb5gOH/NF9+zvvFoAE7DxXgbAhY
	50WD7uRIsP9ovK01DEduR6wV9lykJlpOQp+PQAWVBZoFObW9BYEIvp/0fugH0JHhITAyLpRFrlf
	UClYukvt4xgV8Mi3x7vi6pUMe5V1D7IJArheMOIBjbHJ1wkjqpr6Fu6Xco9zDWXwpTT82WG6SDL
	bXMX3azIVx5xxUpeY+TUoI4JFaf9+9Bc5qVb1GctXMrt87Ngg20zqMmCjEFCXU6FTt9VFNhtUYT
	coJvq9O5hEYajWcamB7Ia22djySf3WP2C6fDPawzBYxhoxseNfo2g/h65Nt5QPoE1njGTmw38g0
	2oWV2A44W8yWLwYwuqbFn8ZIDWGT+9oFTUUHStAXaEzvGHw3anvzVxQmEyL8vRTltqMMugm2TZa
	o=
X-Google-Smtp-Source: AGHT+IG02RvLnefZ9o2mtq2zskpOd/g913+I6NAvbu60v9XPwQlWNOcuEyIaSYAeCem2GB0HXVJTeA==
X-Received: by 2002:a17:902:e746:b0:24c:d322:d587 with SMTP id d9443c01a7336-294cb3c8a2emr54671035ad.26.1761672732759;
        Tue, 28 Oct 2025 10:32:12 -0700 (PDT)
Received: from localhost ([2600:8802:b00:9ce0::f9da])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf33f9sm121854025ad.22.2025.10.28.10.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:32:12 -0700 (PDT)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: johannes.thumshirn@wdc.com
Cc: axboe@kernel.dk,
	dlemoal@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	martin.petersen@oracle.com,
	linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH V2] blktrace: log dropped REQ_OP_ZONE_XXX events ver1
Date: Tue, 28 Oct 2025 10:32:09 -0700
Message-Id: <20251028173209.2859-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add informational messages during blktrace setup when version 1 tools
are used on kernels with CONFIG_BLK_DEV_ZONED enabled. This alerts users
that REQ_OP_ZONE_* events will be dropped and suggests upgrading to
blktrace tools version 2 or later.

The warning is printed once during trace setup to inform users about
the limitation without spamming the logs during tracing operations.
Version 2 blktrace tools properly handle zone management operations
(zone reset, zone open, zone close, zone finish, zone append) that
were added for zoned block devices.

Example output:

blktests (master) # ./check blktrace
blktrace/001 (blktrace zone management command tracing)      [passed]
    runtime  0.110s  ...  3.917s
blktrace/002 (blktrace ftrace corruption with sysfs trace)   [passed]
    runtime  0.333s  ...  0.608s
blktests (master) # dmesg -c
[   57.610592] blktrace: nullb0: blktrace events for REQ_OP_ZONE_XXX will be dropped
[   57.610603] blktrace: use blktrace tools version >= 2 to track REQ_OP_ZONE_XXX

This helps users understand why zone operation traces may be missing
when using older blktrace tool versions with modern kernels that
support REQ_OP_ZONE_XXX in blktrace.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
v1->v2 :-

Remove the extra () around IS_ENABLED(CONFIG_BLK_DEV_ZONED). (Jens)
Add a space after device name in first pr_info(). (Jens)

---
 kernel/trace/blktrace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index e4f26ddb7ee2..4a37d9aa0481 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -739,6 +739,12 @@ static void blk_trace_setup_finalize(struct request_queue *q,
 	 */
 	strreplace(buts->name, '/', '_');
 
+	if (version == 1 && IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
+		pr_info("%s: blktrace events for REQ_OP_ZONE_XXX will be dropped\n",
+				name);
+		pr_info("use blktrace tools version >= 2 to track REQ_OP_ZONE_XXX\n");
+	}
+
 	bt->version = version;
 	bt->act_mask = buts->act_mask;
 	if (!bt->act_mask)
-- 
2.40.0

