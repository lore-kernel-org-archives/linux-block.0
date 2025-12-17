Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDEB23D7D8
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949716; cv=none; b=NcXvhqDWfzDZrfxwTMVUoTM2J9678axaWj6Q7MwnhlKKuNJC6mPLWryv2SlR13xjtucg0gRlJeH+u+iB5qZYV3zrSuSb45T9fPwsOXiw1IXNEc1NqFgSFR2wmgt7USEs0dWZyY7E9h2zS3NYpEzo09cE7AbVW1B97Va6Em9A7g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949716; c=relaxed/simple;
	bh=Pyh2W1i8IZlUeBaqc00BgLkYCHlkSrQShsXZSzjfZ7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGmLMtnl/TrT44s4h1cyH7k8K6k4mWvkvDAnJFw47eQznjltGYBc7nI7LJuEBnYbKsmOjPeGCIgHOExTEQ5l16AiA1V9jjtshtheqDh2zJyIhYeyGKuOYjypPKiBUEfTbN5RcMAiXSCKbnG5QXm+RkNjjJpPZQ+/eE6MKvdlp4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IHdg87Ke; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IHdg87Ke"
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8b2da4fb076so84631885a.2
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 21:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949712; x=1766554512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2Q4EUjN96I8JLsrl8Thk8/d3aPnxYAXF44AaVOt3uI=;
        b=IHdg87KeUrILc8yIhZahuIqFXNHWECMj4wnXxIkZRn67g0x3QwyZyWmlnzAA71n95A
         dUTQnW9vfnJgTAJn0D36rCoU+m7WDw8MLVaf0ZPVwQR4KS6yqIujaVHadXEW8WoLqG7I
         i7tPzy820mLTMw37aeu/ETOvuN5npxNhPXD/LylpgQkGoFXpTGl7yQsCKRAi9N0XnP/9
         s98Yju4OZGFpZ2fKB2/Qsq9CLKDaqjCl0ovOz3U49zU6/XT2O9g3nnV3ROZOP1CAihqv
         jcfp8qcClLkXqewm4yVPmH9Odc4baYsQQPu2nVPV5CyYcVzDlSpNXRDRdrQkjzvQO4RS
         xgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949712; x=1766554512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R2Q4EUjN96I8JLsrl8Thk8/d3aPnxYAXF44AaVOt3uI=;
        b=oU1/MKUbeQywE+YZ3gBaWUK0x/5RZTP57epLs4Qncs0ZyxJPozKBDW6WitvDYrzSQS
         +W3tTAk1Yre59EEhgyilbZLUkCJVOmDfRHvOlQhZouqapUJ4EJ11TpR6r0Gis9PFEsiA
         V8o+gih58raPuyF1DCUE437ncMBkH+tFCFCji4V/RHG46eytFPSaqW9MTjA9bRdKcDW5
         6BqBUHiGkz1/Qso1cllv+H7QR8/OpIjIVwsPzkHm7EcumYprTdqum8ZRF+Xt07DWCrac
         r6AwMQaBGTlzCGqZlYnKpfGU2bBxXel4XDeY9Hd5od2okH2FE5rvWVS1QH9AeSNNYnR8
         U28Q==
X-Gm-Message-State: AOJu0YzI++rXvPHZKB3HeQyf2rHm+UHj3VfVY7aNjfBVQr9F/HYCHZ7q
	9R9Ekeq0SiYdC3nkfh9JQ4Qcp46cv6jcClwbp+2ULHln0qogei+X4svxvOud4KUDAWRmP+Q1NL8
	PbGY+i9vRa9U5LPcc3vim7pstsj7AxLaOgCG3
X-Gm-Gg: AY/fxX705osvipXEESoHKs1ROACTySLrf6RNUfWZZ8SvFqcQh+A/pbrUvGj45HaxJbS
	qh1d+PUX+dlT8uPU5Efc1EsQijDdh1hpSpYqm8crLdiYpBzC7e/+F+P0pLKZ+rZVsIQcyQHxK9x
	2CjYwPTL4WHtNWOGzDnwCClvDqGl2KdHL826vRcXwU3atelqMUskmwAubP49A9rERI7+C/SSz5+
	vvxkBgNDmzVQn8sv/riqlJjVBIFyXhBc9R25WDWDXqpGi/EG0mIGXojiysPPTy17Rq0QNOI0LrT
	ODyxWmGSVI+mvoCQqjDMhKfOONMvqG5AH3xo07jhxH+nB3fQFRaWvq0EhiyYY2b4JJze8/wdKxG
	Y4L8OLVK9rEhBNgfRVv+4964Kuwxqok19+pu6XGqyxA==
X-Google-Smtp-Source: AGHT+IEwQVVahKTBzODwZ9LCNp7ytSuh2rRQqS2AIb4ql60egeJB6RRbKK8HEAJwdh0Tw0BDMeZ7L4T+UOA8
X-Received: by 2002:a05:622a:610:b0:4ec:f9c2:c200 with SMTP id d75a77b69052e-4f1d0655504mr181608401cf.11.1765949712259;
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8899dc07525sm19327636d6.15.2025.12.16.21.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6A40F3404B4;
	Tue, 16 Dec 2025 22:35:11 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 67759E41A08; Tue, 16 Dec 2025 22:35:11 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 01/20] block: validate pi_offset integrity limit
Date: Tue, 16 Dec 2025 22:34:35 -0700
Message-ID: <20251217053455.281509-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251217053455.281509-1-csander@purestorage.com>
References: <20251217053455.281509-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PI tuple must be contained within the metadata value, so validate
that pi_offset + pi_tuple_size <= metadata_size. This guards against
block drivers that report invalid pi_offset values.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/blk-settings.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 51401f08ce05..d138abc973bb 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -159,14 +159,13 @@ static int blk_validate_integrity_limits(struct queue_limits *lim)
 	    (bi->flags & BLK_INTEGRITY_REF_TAG)) {
 		pr_warn("ref tag not support without checksum.\n");
 		return -EINVAL;
 	}
 
-	if (bi->pi_tuple_size > bi->metadata_size) {
-		pr_warn("pi_tuple_size (%u) exceeds metadata_size (%u)\n",
-			 bi->pi_tuple_size,
-			 bi->metadata_size);
+	if (bi->pi_offset + bi->pi_tuple_size > bi->metadata_size) {
+		pr_warn("pi_offset (%u) + pi_tuple_size (%u) exceeds metadata_size (%u)\n",
+			bi->pi_offset, bi->pi_tuple_size, bi->metadata_size);
 		return -EINVAL;
 	}
 
 	switch (bi->csum_type) {
 	case BLK_INTEGRITY_CSUM_NONE:
-- 
2.45.2

