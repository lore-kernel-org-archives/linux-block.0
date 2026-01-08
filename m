Received: from mail-dl1-f100.google.com (mail-dl1-f100.google.com [74.125.82.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF7042A829
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864020; cv=none; b=kCMLfq7TrO9gmpXO10KF0iTOWEShJB5OjMmBpNzVMb8vMGRe3P8Jbc3Y5pHpaEpJ0SuDxsSX1NeQL8YoJuAMCm60DzKPMAGA/Jagw2qYOuVVKxFGyDUVTL1H4kCOL38rSNE8/QXVwgvJ2x2nUxcm1wFjhi8kK/3kzbmcPZ9H4A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864020; c=relaxed/simple;
	bh=j0qqe+b6Tp1wsdU1PGQcA4ShpgCikqFMILedh5CXjdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cisMeF/sDcf1of8dQknqdCcUHFvD1ufI/TCDzjiZTW3Rb0NkMyj1SuGBXeWbRL6ePHThstg7PoowSHs8JDFSXbg7BeraZdJ7ljpioCixJ1uaLRCMh2vv15h7gJFgRHJWQawR/LUTPDTVfghv+hrsuZhqQ9jLLm17keo7HuChmQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TPAhHMSO; arc=none smtp.client-ip=74.125.82.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TPAhHMSO"
Received: by mail-dl1-f100.google.com with SMTP id a92af1059eb24-121b937a5bcso220238c88.1
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863996; x=1768468796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BsEwlEe6b4/GC4RnV/DMnhZhqrSG2xlnXLmv4xPAM8=;
        b=TPAhHMSOZUK78HkqiocWIzv0cK3Ooxc0KIPQJUESSYuaOzXw/CPxZBVs04DZK9vP4L
         YLm8RbQeCdNlUpiPoSF81cj2jUCrd+EZRAt1ED52TljSgJsFtWdtjaQYPSC0kqwgVUMZ
         WOFPzMRVacp1S3xdpCynEyjuRMi9VzvxwppttuNpFVvQ0MUM8o9n5VCf0c/CYFEB1xUS
         mbyAojNlL7hSIE8uKRBsrqM0go6ZOUKrRMLe6dAoQl/ZYWeH874KlTvBgagdfScFLPVP
         20JP9QdjGZjKczhZ3NM7qL7t7rxMRzfIabLMk5+pLS35dzDSi/slJovSGsG9sFYgQox+
         eDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863996; x=1768468796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1BsEwlEe6b4/GC4RnV/DMnhZhqrSG2xlnXLmv4xPAM8=;
        b=pNMgj0WkE7q4HRFYF2YSYlDS5WnC8vYP0wZ2ZQbgObJ/IfJVMjYZaXvxnTW3NFYBKN
         Ukw1DlfqZTsWuW762XsxOprQtLr/yUnHFuIfDp9eDoJ99FYX93CqUpUkQst2kzIjUSD6
         /TOCQi/wRfYqEA7g9UdjHCYkx/jMFvqp0NBjl5fZPxHDnqnQwk62aPYlgm4pmOj2sqLL
         It/OLHN0K0hf8SgMii6sgo4BMJGAI2etp4dhhe1P6WXmsRZn6TEfgKt4dNcZbb8HZrEw
         ElPxKaoSLARf4YHStMOrL4VO8Qc4SI8Th9FzBvtjCTXcrWupcnBBlN90ylfsvxAbb4YY
         zOeg==
X-Gm-Message-State: AOJu0YzTQDtUg2noNjHWx6NN/XuNr24w8c9XHw9KdtjpqgWsaWntN9nR
	+dOWed6WJwgjRLpuX9GPHtHnCmUQhXe5kBzmDwInlWhDtKoI2kx+//Q7AIm4REBiEHvMXJBjhPI
	6SMeQlpauYLkun1xWVcxkKfMuNoDzYI2Ra9BQ
X-Gm-Gg: AY/fxX5oEst1sctW/S0enfOaUsz2wiLlAOppS5wVq2ijiT8RL9i9sKkL9woJXmhjo+K
	3WFNvxmJcA4gdeaRnOkLdpXQ2KkaXcqmGlgECKGfqDYAMM0y+WOd0KIQ6JbZfe85yDVldpzRN/+
	GBCqqcbfnTTUDTRRe9G4Bb7YD7epaQoFZR7IJSL7BUT/FoKMIb4Zh6Yf87j8uk6UVSRM/ZUFoox
	X3ufEqi8XCyGKKII4MkFmi0cTPNJgwEP9hMl/UPDjLOUtRAVzo9KZSqb0qo7dj/V0O4IcymcllS
	62r0NbpvdxdT/Mw/5SAtV9VN54PcvqDeF+k2qUCpnJ8qX1WmngO5LxdpXQIG7sS9xCR414HsWN4
	Vp9Rfk1jbLrwwXLYC4LZadiZpZZSywPbfngc99W7BoQ==
X-Google-Smtp-Source: AGHT+IFrkMoxXPbkCpAtEJlUUiQgbFuZWtwfN3P60Hvgrr4I9mhxnVUkWYur8ZvQ4vma87yDUMkDhoQj9aJ/
X-Received: by 2002:a05:7300:5505:b0:2ae:5d59:3ef6 with SMTP id 5a478bee46e88-2b17d350045mr1780070eec.9.1767863996418;
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2b170798edesm940360eec.11.2026.01.08.01.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9166C34223B;
	Thu,  8 Jan 2026 02:19:55 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8BEFCE42F2C; Thu,  8 Jan 2026 02:19:55 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 04/19] ublk: set UBLK_IO_F_INTEGRITY in ublksrv_io_desc
Date: Thu,  8 Jan 2026 02:19:32 -0700
Message-ID: <20260108091948.1099139-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Indicate to the ublk server when an incoming request has integrity data
by setting UBLK_IO_F_INTEGRITY in the ublksrv_io_desc's op_flags field.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 3 +++
 include/uapi/linux/ublk_cmd.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b91b2111f280..7310d8761d2b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1125,10 +1125,13 @@ static inline unsigned int ublk_req_build_flags(struct request *req)
 		flags |= UBLK_IO_F_NOUNMAP;
 
 	if (req->cmd_flags & REQ_SWAP)
 		flags |= UBLK_IO_F_SWAP;
 
+	if (blk_integrity_rq(req))
+		flags |= UBLK_IO_F_INTEGRITY;
+
 	return flags;
 }
 
 static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 {
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 4c141d7e4710..dfde4aee39eb 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -412,10 +412,12 @@ struct ublksrv_ctrl_dev_info {
  *
  * ublk server has to check this flag if UBLK_AUTO_BUF_REG_FALLBACK is
  * passed in.
  */
 #define		UBLK_IO_F_NEED_REG_BUF		(1U << 17)
+/* Request has an integrity data buffer */
+#define		UBLK_IO_F_INTEGRITY		(1UL << 18)
 
 /*
  * io cmd is described by this structure, and stored in share memory, indexed
  * by request tag.
  *
-- 
2.45.2

