Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B012D2EA172
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318770; cv=none; b=eJfl3/nValB9+T6Cyyqi3V+R4LscTw7yZVSUFoBTwvnEXaMWpx4V5gxTr3YHJu+YmXkH6BGBH6hlhP1cGQM9dutAL344mmxGokLQH8A+YiUQ+2pDBXSd1wg8UbVf1LUZNUsz0Zx7zLjJss3BtfIQuWlacCwEmzI+aJ9mWX6/tuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318770; c=relaxed/simple;
	bh=vDTdwwqFiUx+YnWL6sZwmz4ttt9jO7ABRme3mV3jkpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qk/ch2UdJ5bVRo1MSydmmC2nxf3hBwkHeio5cS2iLrWuQmf9h4HlBbp4VU87Ac3ORF3HfXpNyfcpsTLPbPto5LOVF//BzF+Bck+BpAS5jakzcjF8vYRsRGyQA6jBwCI10wyGrImypLi4roArj0cPHEWAyYHECYxJu0Iq1WSIgeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kzg9a42n; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kzg9a42n"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso2398727b3a.2
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 00:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318768; x=1764923568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYdGxu8+S3la90e5ilLAk2WHMl9XT2MOPAJKSPmhLP4=;
        b=Kzg9a42nKrcwuYJQY+ScZnAHIrHBJFMdQX0bDvUZSFigzvsmYxoJlJxMQzE+0EDozZ
         c5GzOKzqIpHvZWVmkyMaI/UIkTqtD+w74trvULVNNRtHYvDxzy3aOGgUm4MAWg4QsJJO
         TLf3Pg/lRzat9g/FDJqx2Ndkc4AkEhXnlOnJBv4rLYrNNn3z0Tw8gZC3x8R1sM1pAjW+
         8S29cMxQFrsZBTYkeUzoUU5aRZGaujLAkU1uoT0Ppdt/TOUDuyqO+q5fX5PBQaDfU2Tp
         vlq+R8uu4j+Aogm8F2dpG41wTSSXL6T7K0JuCRjvfZ2XhZEyIlMuzC3q6NRK02smo13l
         EcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318768; x=1764923568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dYdGxu8+S3la90e5ilLAk2WHMl9XT2MOPAJKSPmhLP4=;
        b=xKoTfHvJKY7g+yOCwzdEcIMCM+kYLRoXOUu22IRvor+JzK6JYuiUNn1ZAd0v9PURpQ
         rLECEX6nwqDXU1Du+vojTXtpLhiuufWCA+/Pc/C52tFd7JJsE+Vg8teXaJ/mdyghjSor
         6lSvfAaHfUY3bxhMdsRMTLoELV71kaSm+HeY+P/h8m/lTVaT9XMr7ysgwKel4hms24BD
         LTl+pPIBrStHx/vWSGcd/cg03B1cYnTVjFpDCEGHqcm5qPF0o7DmRblo4z4UD0EuE2R9
         2eOTYOeQ4icaGnNe8CvTL2uOUrNUj9BAZp3hhGMvNgD7dg1ujcwAEmGXj0Kz+tCVWVDH
         mXTQ==
X-Gm-Message-State: AOJu0YzvAAiEY9yUn/gfz5tzp936LJuylswIUE5eEYJ8ryWcvChJlgos
	/vCbLVSRgAG1FMOh/Mse6p1MLmELrMEvcFXeWvRroJvynbWM5oe6qm0w
X-Gm-Gg: ASbGnctkeRKkR9Msmi3oiYCpbvOK6oM8fwdWmFpe7yy9JXjHunanKuBjCPUJfCIgNPV
	7TsA2BYMUzfR+O0DfubCXcHoA5COThTjq2ObRMRGGMFntV7QtWhqKec3WYjYIU5diV2yr3yJLX1
	VOiuQa4unjc9PcGQ1CXcrLATNR0HhdHfFjazxwE5B5TdNtjlkFXq0n1WcOWJVxCyZZYKE82GihF
	1OqEb0FBRzU7f1fibchGpvvLHvNBokfH1/30ECoB65YeM1dBNsAPpCmB0nDcHb1BT6ao8Q1jCZB
	pmiaRSJGE93QO9++NavhSEjm0uMPTVoKMMoDEg1GR995TkE8MstZ8ixgCWo/ALacx+GQYUkCzJR
	UgFRRcqmqEEZ1bWc3Rkm5TphFbYwQ/kyw6adErsXXcjREn1SqJTl6KkEMrfzgcsb0CTl+g11dB+
	t54f6IruvWQl4FVkedqDXxjlMjSw==
X-Google-Smtp-Source: AGHT+IExXZt7YE3nF+952Md7MiVvxMbDW7G+yswwYtoDXLwvootnd7yuttY35MGv7RVbIjqP5duRMQ==
X-Received: by 2002:a05:7022:670e:b0:11b:a73b:233b with SMTP id a92af1059eb24-11cb68354b6mr8088695c88.28.1764318767897;
        Fri, 28 Nov 2025 00:32:47 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:32:47 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 02/12] block: prevent race condition on bi_status in __bio_chain_endio
Date: Fri, 28 Nov 2025 16:32:09 +0800
Message-Id: <20251128083219.2332407-3-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Andreas point out that multiple completions can race setting
bi_status.

The check (parent->bi_status) and the subsequent write are not an
atomic operation. The value of parent->bi_status could have changed
between the time you read it for the if check and the time you write
to it. So we use cmpxchg to fix the race, as suggested by Christoph.

Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 55c2c1a0020..aa43435c15f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -313,9 +313,12 @@ EXPORT_SYMBOL(bio_reset);
 static struct bio *__bio_chain_endio(struct bio *bio)
 {
 	struct bio *parent = bio->bi_private;
+	blk_status_t *status = &parent->bi_status;
+	blk_status_t new_status = bio->bi_status;
+
+	if (new_status != BLK_STS_OK)
+		cmpxchg(status, BLK_STS_OK, new_status);
 
-	if (bio->bi_status && !parent->bi_status)
-		parent->bi_status = bio->bi_status;
 	bio_put(bio);
 	return parent;
 }
-- 
2.34.1

